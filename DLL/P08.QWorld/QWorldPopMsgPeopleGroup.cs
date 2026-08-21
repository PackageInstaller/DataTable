using System.Collections.Generic;
using System.Linq;
using P08.QWorld.Misc;
using Sirenix.Serialization;
using UnityEngine;

public class QWorldPopMsgPeopleGroup : QWorldEntityDataMono<QWorldPopMsgPeopleGroupData>, ILODControlledLogic, IBubbleHost, ISerializationCallbackReceiver, ISupportsPrefabSerialization
{
	private struct EntityData : IQWorldCullable
	{
		public Vector3 position;

		public Vector3 forward;

		public EntityData(Vector3 pos)
		{
			this = default(EntityData);
			position = pos;
			Vector2 insideUnitCircle = Random.insideUnitCircle;
			forward = new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y);
		}

		public EntityData(IAreaDistribution.PosRecord pos)
		{
			this = default(EntityData);
			position = pos.position;
			forward = AvoidZeroForward(pos.rotation);
		}

		private static Vector3 AvoidZeroForward(Vector3 forward)
		{
			if (forward == Vector3.zero)
			{
				Vector2 insideUnitCircle = Random.insideUnitCircle;
				return new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y);
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

		public float GetBoundSphereRadius()
		{
			return 0.6f;
		}

		public Vector3 GetPosition()
		{
			return position;
		}
	}

	private int npcCnt;

	private Bounds? cacheBounds;

	private bool culled = true;

	private FadeGroup fade = new FadeGroup();

	private int lodControlValue;

	private EntityData[] entities;

	private const int CACHE_CNT = 1;

	private bool running;

	private PassiveCharaActor[] actors;

	private UpdateVisibleInternalLogic vsm;

	[SerializeField]
	[HideInInspector]
	private SerializationData serializationData;

	private QWorldTalkBubbleMgr bubbleMgr;

	private static Vector3 QWorldMainCamPos => QWorldCameraManager.Instance.MainCamera.transform.position;

	private IAreaDistribution areaDistribution => data?.areaDistribution;

	public int NpcCnt => (areaDistribution as FixedPosDistribution)?.Count ?? npcCnt;

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
	}

	public bool Culled
	{
		get
		{
			if (running)
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

	public int BubbleRootCnt => NpcCnt;

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

	public void UpdateLogic(float dt, QWorldMapCull.QWorldCullResult cullResult)
	{
		vsm.UpdateVisible(!Culled, dt);
	}

	private void OnVisible(float dt)
	{
		if (entities != null)
		{
			for (int i = 0; i < entities.Length; i++)
			{
				ref PassiveCharaActor reference = ref actors[i];
				ref EntityData reference2 = ref entities[i];
				QWorldMapCull.QWorldCullResult cullResult = QWorldMapCull.GetCullResult(QWorldMainCamPos, in reference2);
				data.customActorQualityByDistance.UpdatePassiveCharaActor(reference, in cullResult);
				reference.UpdateFade(1f);
				reference.UpdatePosAndRot(reference2.position, Quaternion.LookRotation(reference2.forward));
			}
		}
	}

	private void OnEnterVisible()
	{
		int cnt = NpcCnt;
		if (areaDistribution == null)
		{
			return;
		}
		entities = (from pos in areaDistribution.DistributeWorldPos(base.transform, cnt)
			select new EntityData(pos)).ToArray();
		actors = entities.Select(delegate(EntityData entityData, int i)
		{
			PassiveCharaActor passiveCharaActor = new PassiveCharaActor();
			if (data.mode == QWorldPopMsgPeopleGroupData.Mode.Random)
			{
				i = Random.Range(0, data.peoplePrefabs.Length);
			}
			ActorPrefab asset = data.peoplePrefabs[i % data.peoplePrefabs.Length];
			passiveCharaActor.Claim(asset);
			passiveCharaActor.UpdatePosAndRot(entityData.position, Quaternion.LookRotation(entityData.forward));
			return passiveCharaActor;
		}).ToArray();
	}

	private void OnExitVisible()
	{
		for (int i = 0; i < actors.Length; i++)
		{
			actors[i].Recycle();
		}
		actors = null;
	}

	public bool QueryBubbleRoot(int bubbleHandle, out Transform root, out Vector3 offset)
	{
		if (bubbleHandle < 0 || bubbleHandle >= NpcCnt)
		{
			root = null;
			offset = Vector3.zero;
			return false;
		}
		PassiveCharaActor[] array = actors;
		Transform transform = ((array == null) ? null : array[bubbleHandle]?.QueryMainActorPoint("gua_Hp"));
		if ((bool)transform)
		{
			root = transform;
			offset = Vector3.zero;
			return true;
		}
		root = null;
		if (entities != null)
		{
			offset = entities[bubbleHandle].GetPosition() + 1.2f * Vector3.up;
			return true;
		}
		offset = Vector3.zero;
		return false;
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if ((bool)this && !base.isEditorData)
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

	protected override void OnAfterLoadState(QWorldPopMsgPeopleGroupData loadData)
	{
		base.OnAfterLoadState(loadData);
		if (!base.isEditorData && data.bubbleMgrData != null)
		{
			bubbleMgr = U3DUtil.Get<QWorldTalkBubbleMgr>(base.gameObject);
			bubbleMgr.data = data.bubbleMgrData;
			bubbleMgr.entity_child_list = new List<int> { data.id };
			bubbleMgr.host = this;
			QWorldScene.Scene.lodComScheduler.RegisterLogic(bubbleMgr);
		}
	}

	protected override void OnAfterSaveState(ref QWorldPopMsgPeopleGroupData saveData)
	{
		base.OnAfterSaveState(ref saveData);
	}
}
