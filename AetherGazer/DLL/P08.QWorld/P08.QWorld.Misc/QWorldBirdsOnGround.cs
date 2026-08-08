using System;
using System.Linq;
using Sirenix.Serialization;
using UnityEngine;

namespace P08.QWorld.Misc;

public class QWorldBirdsOnGround : QWorldEntityDataMono<QWorldBirdGroupData>, ILODControlledLogic, ISerializationCallbackReceiver, ISupportsPrefabSerialization
{
	private struct EntityData
	{
		public Vector3 pos;

		public Vector3 forward;

		public Vector3 movingTarget;

		private float active;

		public bool IsActive => active > 0f;

		public EntityData(Vector3 pos)
		{
			this = default(EntityData);
			this.pos = pos;
			movingTarget = pos;
			forward = AvoidZeroForward(Vector3.zero);
		}

		public EntityData(IAreaDistribution.PosRecord pos)
		{
			this = default(EntityData);
			this.pos = pos.position;
			movingTarget = pos.position;
			forward = AvoidZeroForward(pos.rotation);
		}

		private static Vector3 AvoidZeroForward(Vector3 forward)
		{
			if (forward == Vector3.zero)
			{
				Vector2 insideUnitCircle = UnityEngine.Random.insideUnitCircle;
				return new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y);
			}
			return forward;
		}

		private static Vector3 AvoidZeroForward(Vector3 forward, Vector3 defaultForward)
		{
			if (forward == Vector3.zero)
			{
				return defaultForward;
			}
			return forward;
		}

		private static Vector3 AvoidZeroForward(Quaternion? rot)
		{
			Vector3 vector = Vector3.zero;
			if (rot.HasValue)
			{
				vector = rot.Value * Vector3.forward;
			}
			return AvoidZeroForward(vector);
		}

		public void CalcMove(float deltaMove)
		{
			if (pos != movingTarget && !IsActive)
			{
				pos = Vector3.MoveTowards(pos, movingTarget, deltaMove);
				forward = AvoidZeroForward(movingTarget - pos, forward);
			}
		}

		internal void Update(float dt)
		{
			active -= dt;
		}

		internal bool TryActive(Vector3 pos, float strength, float range)
		{
			bool flag = false;
			if (Vector3.Distance(pos, this.pos) > range)
			{
				strength = 0f;
			}
			if (strength > 0f && strength > active)
			{
				if (active <= 0f)
				{
					forward = AvoidZeroForward(this.pos - pos);
				}
				active = strength;
				flag = true;
			}
			if (flag)
			{
				return !IsActive;
			}
			return false;
		}
	}

	private struct EntityActor : IQWorldCullable
	{
		public GameObject actorObj;

		public Animator animator;

		private Renderer[] renderers;

		private bool active;

		private bool justClaimed;

		public bool Active => active;

		public bool IsValid => actorObj;

		private void SetRenderersEnable(bool value)
		{
			Renderer[] array = renderers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].enabled = value;
			}
		}

		private void UpdateActive(ref EntityData entityData)
		{
			bool isActive = entityData.IsActive;
			if (active == isActive || !IsValid)
			{
				return;
			}
			if (isActive)
			{
				if (!justClaimed)
				{
					SetRenderersEnable(value: true);
					animator.Play("flyAway", 0, 0f);
				}
				else
				{
					SetRenderersEnable(value: false);
				}
				active = true;
				return;
			}
			SetRenderersEnable(value: true);
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if (!currentAnimatorStateInfo.IsName("flyAway") || currentAnimatorStateInfo.normalizedTime >= 0.98f)
			{
				if (!justClaimed)
				{
					animator.Play("flyBack", 0, 0f);
				}
				else
				{
					animator.Play("flyBack", 0, 1f);
				}
				actorObj.transform.position = (entityData.pos = entityData.movingTarget);
				active = false;
			}
		}

		public EntityActor(GameObject newObj)
		{
			this = default(EntityActor);
			justClaimed = true;
			actorObj = newObj;
			animator = newObj.GetComponent<Animator>();
			renderers = newObj.GetComponentsInChildren<Renderer>(includeInactive: true);
		}

		public Vector3 GetPosition()
		{
			if (!IsValid)
			{
				return Vector3.negativeInfinity;
			}
			return actorObj.transform.position;
		}

		public float GetBoundSphereRadius()
		{
			return 0.1f;
		}

		public void Update(ref EntityData data)
		{
			if (IsValid)
			{
				Vector3 vector = data.pos - actorObj.transform.position;
				actorObj.transform.position = data.pos;
				if (data.forward != Vector3.zero)
				{
					actorObj.transform.forward = data.forward;
				}
				if ((bool)animator)
				{
					animator.SetFloat("move", (vector.sqrMagnitude > 0f) ? 1 : 0);
				}
			}
			UpdateActive(ref data);
			justClaimed = false;
		}

		internal void Recycle()
		{
			if (IsValid)
			{
				if (actorObj.TryGetComponent<PooledAsset>(out var component))
				{
					component.Return();
				}
				else
				{
					UnityEngine.Object.Destroy(actorObj);
				}
			}
		}
	}

	private struct ActiveRecord : IEquatable<ActiveRecord>
	{
		public Vector3 pos;

		public float range;

		public float value;

		public bool IsValid => value > 0f;

		public override bool Equals(object obj)
		{
			if (obj is ActiveRecord other)
			{
				return Equals(other);
			}
			return false;
		}

		public bool Equals(ActiveRecord other)
		{
			if (pos == other.pos)
			{
				return range == other.range;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return pos.GetHashCode() ^ range.GetHashCode();
		}

		public bool IsInRange(Vector3 pos)
		{
			if (IsValid)
			{
				return Vector3.Distance(pos, this.pos) <= range;
			}
			return false;
		}
	}

	private Bounds? cacheBounds;

	private bool culled = true;

	private FadeGroup fade = new FadeGroup();

	private int lodControlValue;

	private EntityData[] entities;

	private EntityActor[] actors;

	private bool running;

	private UpdateVisibleInternalLogic vsm;

	internal const float ACTIVE_RANGE = 2.5f;

	private ActiveRecord[] actives = new ActiveRecord[8];

	[SerializeField]
	[HideInInspector]
	private SerializationData serializationData;

	internal static bool globalCulledOverride;

	private IAreaDistribution areaDistribution => data?.areaDistribution;

	public int UpdateRate
	{
		get
		{
			if (LOD < 3)
			{
				return 1;
			}
			return 4;
		}
	}

	public Bounds Bounds
	{
		get
		{
			if (cacheBounds.HasValue)
			{
				return cacheBounds.Value;
			}
			cacheBounds = ((areaDistribution != null) ? areaDistribution.WorldBounds(base.transform) : QWorldLODControlledLogicScheduler.INVALID_BOUNDS);
			return cacheBounds.Value;
		}
	}

	public override Vector3? Size
	{
		get
		{
			if (areaDistribution == null)
			{
				return null;
			}
			return Bounds.size;
		}
		set
		{
			if (areaDistribution != null && value.HasValue)
			{
				areaDistribution.SetSize(value.Value);
				InvalidBoundCache();
			}
		}
	}

	public bool Culled
	{
		get
		{
			if (!globalCulledOverride && running)
			{
				return culled;
			}
			return true;
		}
		set
		{
			if (!running)
			{
				value = true;
			}
			if (culled != value)
			{
				if (value)
				{
					fade.StartFadeOut(base.gameObject);
				}
				else
				{
					fade.StartFadeIn(base.gameObject);
				}
				culled = value;
			}
		}
	}

	public int LOD
	{
		get
		{
			return lodControlValue;
		}
		set
		{
			lodControlValue = value;
		}
	}

	public SerializationData SerializationData
	{
		get
		{
			return serializationData;
		}
		set
		{
			serializationData = value;
		}
	}

	public void InvalidBoundCache()
	{
		cacheBounds = null;
	}

	private bool Visible(float dither)
	{
		return dither >= 0.2f;
	}

	private bool Visible(EntityActor actor, EntityData data)
	{
		Camera mainCamera = QWorldCameraManager.Instance.MainCamera;
		QWorldMapCull.QWorldCullResult cullResult = QWorldMapCull.GetCullResult(pos: data.pos, radius: actor.GetBoundSphereRadius(), cameraPos: mainCamera.transform.position);
		PassiveCharaActor.Quality quality = base.data.customActorQualityByDistance.CalcQuality(in cullResult);
		if (cullResult.visible)
		{
			return quality != PassiveCharaActor.Quality.Cull;
		}
		return false;
	}

	public void Init()
	{
		vsm = new UpdateVisibleInternalLogic
		{
			OnEnterVisible = OnEnterVisible,
			OnVisibleUpdate = OnVisible,
			OnExitVisible = OnExitVisible
		};
		running = true;
	}

	public void Shutdown()
	{
		running = false;
		Culled = true;
	}

	private void OnExitVisible()
	{
		entities = null;
		for (int i = 0; i < actors.Length; i++)
		{
			Recycle(i);
		}
		actors = null;
	}

	private void OnVisible(float dt)
	{
		for (int i = 0; i < actors.Length; i++)
		{
			bool flag = Visible(actors[i], entities[i]);
			if (flag && !actors[i].IsValid)
			{
				ClaimActor(i);
			}
			else if (!flag && actors[i].IsValid)
			{
				Recycle(i);
			}
			UpdateEntityActor(i);
		}
	}

	private void OnEnterVisible()
	{
		if (areaDistribution != null)
		{
			entities = (from pos in areaDistribution.DistributeWorldPos(base.transform, data.count)
				select new EntityData(pos)).ToArray();
			actors = new EntityActor[entities.Length];
		}
	}

	public void UpdateLogic(float dt, QWorldMapCull.QWorldCullResult cullResult)
	{
		int num = 0;
		while (true)
		{
			int num2 = num;
			EntityData[] array = entities;
			if (num2 >= ((array != null) ? array.Length : 0))
			{
				break;
			}
			ref EntityData reference = ref entities[num];
			reference.CalcMove(dt * data.speed);
			reference.Update(dt);
			if (!reference.IsActive && UnityEngine.Random.value < dt / data.rndMoveFactor)
			{
				reference.movingTarget = GetWanderMoveTarget(reference.pos);
			}
			else if (reference.IsActive)
			{
				reference.movingTarget = reference.pos;
			}
			num++;
		}
		for (int i = 0; i < actives.Length; i++)
		{
			actives[i].value -= dt;
		}
		bool visible = Visible(fade.groupFade) && LOD < 3 && !Culled;
		vsm.UpdateVisible(visible, dt);
	}

	private Vector3 GetWanderMoveTarget(Vector3 pos)
	{
		if (areaDistribution != null)
		{
			Vector2 vector = UnityEngine.Random.insideUnitCircle * data.step;
			Vector3 vector2 = pos + new Vector3(vector.x, 0f, vector.y);
			Vector3 localPos = base.transform.InverseTransformPoint(vector2);
			if (!IsInArea(areaDistribution, localPos))
			{
				return pos;
			}
			if (IsInActiveArea(pos))
			{
				return pos;
			}
			return vector2;
		}
		return pos;
	}

	private bool IsInArea(IAreaDistribution areaDistribution, Vector3 localPos)
	{
		return (areaDistribution as IArea)?.IsInArea(localPos) ?? false;
	}

	private bool IsInActiveArea(Vector3 pos)
	{
		return actives.Any((ActiveRecord active) => active.IsInRange(pos));
	}

	private void ClaimActor(int i)
	{
		GameObject gameObject = Asset.Instantiate(data.prefabPath);
		actors[i] = new EntityActor(gameObject);
		gameObject.transform.position = entities[i].pos;
		gameObject.transform.forward = entities[i].forward;
	}

	private void Recycle(int i)
	{
		actors[i].Recycle();
	}

	private void UpdateEntityActor(int i)
	{
		ref EntityData reference = ref entities[i];
		actors[i].Update(ref reference);
	}

	private void RecordActive(Vector3 pos, float range, float strength)
	{
		ActiveRecord activeRecord = new ActiveRecord
		{
			pos = pos,
			range = range,
			value = strength
		};
		int num = -1;
		float num2 = float.MaxValue;
		for (int i = 0; i < actives.Length; i++)
		{
			ref ActiveRecord reference = ref actives[i];
			if (reference.Equals(activeRecord))
			{
				reference.value = strength;
				return;
			}
			if (reference.value < num2)
			{
				num = i;
				num2 = reference.value;
			}
		}
		actives[num] = activeRecord;
	}

	public void BroadcastActiveToBirdsEntity(Vector3 pos, float strength)
	{
		strength = UnityEngine.Random.Range(0.9f, 1.1f) * strength * data.activeFactor;
		float activeRange = data.activeRange;
		RecordActive(pos, activeRange, strength);
		if (entities != null)
		{
			for (int i = 0; i < entities.Length; i++)
			{
				entities[i].TryActive(pos, strength, activeRange);
			}
		}
	}

	public void BroadcastActiveToBirdsEntity(Transform src, float strength)
	{
		BroadcastActiveToBirdsEntity(src.position, strength);
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (!base.isEditorData)
		{
			UnitySerializationUtility.DeserializeUnityObject(this, ref serializationData);
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if ((bool)this)
		{
			UnitySerializationUtility.SerializeUnityObject(this, ref serializationData);
		}
	}
}
