using System;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using Sirenix.Serialization;
using UnityEngine;

public class QWorldWalkingPeopleGroup : QWorldEntityDataMono<QWorldWalkingPeopleGroupData>, ILODControlledLogic, ISerializationCallbackReceiver, ISupportsPrefabSerialization
{
	public struct WalkingPeopleData
	{
		public int skin;

		public int pathIdx;

		public float speed;

		public float posOnPath;

		public static WalkingPeopleData Invalid => new WalkingPeopleData
		{
			pathIdx = -1
		};

		public bool IsValid => pathIdx != -1;

		public override string ToString()
		{
			return $"skin: {skin}";
		}
	}

	private struct WalkingPeople(QWorldWalkingPeopleGroup group, int id) : IQWorldCullable
	{
		private QWorldWalkingPeopleGroup group = group;

		private int id = id;

		public bool IsValid => Data.IsValid;

		public ref WalkingPeopleData Data => ref group.people[id];

		public PassiveCharaActor Actor => group.actors[id];

		public float GetBoundSphereRadius()
		{
			return 0.6f;
		}

		public Vector3 GetPosition()
		{
			WalkingPeopleData data = Data;
			if (!data.IsValid)
			{
				return Vector3.negativeInfinity;
			}
			return group.GetPath(data.pathIdx).EvaluatePositionAtUnit(data.posOnPath, CinemachinePathBase.PositionUnits.Distance);
		}
	}

	private enum RearrangeState
	{
		Keep,
		FromStart,
		Halfway
	}

	public CinemachineSmoothPath[] paths;

	private WalkingPeopleData[] people;

	private PassiveCharaActor[] actors;

	private Bounds? cacheBounds;

	public static bool globalCulledOverride;

	private bool running;

	private bool culled;

	private int lodControlValue;

	private const float WALK_SPEED = 1.5f;

	private float estimateWalkPeopleLifeTime;

	private float pathMaxDistance;

	private UpdateVisibleInternalLogic vsm;

	private float[] eachPathGenPeopleCooldown;

	private List<int> available = new List<int>();

	[SerializeField]
	[HideInInspector]
	private SerializationData serializationData;

	private static Vector3 QWorldMainCamPos => QWorldCameraManager.Instance.MainCamera.transform.position;

	public Bounds Bounds
	{
		get
		{
			if (cacheBounds.HasValue)
			{
				return cacheBounds.Value;
			}
			Bounds bounds = default(Bounds);
			if (paths != null)
			{
				IEnumerable<CinemachineSmoothPath> source = paths.Where((CinemachineSmoothPath path) => (bool)path && path.m_Waypoints.Length != 0);
				if (source.Any())
				{
					bounds = source.Select(CalcPathBoundingBox).Aggregate(delegate(Bounds a, Bounds b)
					{
						a.Encapsulate(b);
						return a;
					});
				}
			}
			if (Application.IsPlaying(this))
			{
				cacheBounds = bounds;
			}
			return bounds;
		}
	}

	public override Vector3? Size => Bounds.size;

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
			culled = value;
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

	private CinemachineSmoothPath AddPath()
	{
		GameObject obj = new GameObject($"path {base.transform.childCount}");
		obj.transform.SetParent(base.transform, worldPositionStays: false);
		return obj.AddComponent<CinemachineSmoothPath>();
	}

	protected override void OnAfterLoadState(QWorldWalkingPeopleGroupData loadData)
	{
		base.OnAfterLoadState(loadData);
		paths = new CinemachineSmoothPath[loadData.waypoints.Count];
		for (int i = 0; i < paths.Length; i++)
		{
			GameObject obj = new GameObject($"{base.gameObject.name} path {i}");
			obj.transform.SetParent(base.transform, worldPositionStays: false);
			CinemachineSmoothPath cinemachineSmoothPath = obj.AddComponent<CinemachineSmoothPath>();
			CinemachineSmoothPath.Waypoint[] array = loadData.waypoints[i];
			cinemachineSmoothPath.m_Waypoints = new CinemachineSmoothPath.Waypoint[array.Length];
			for (int j = 0; j < array.Length; j++)
			{
				cinemachineSmoothPath.m_Waypoints[j] = new CinemachineSmoothPath.Waypoint
				{
					position = base.transform.InverseTransformPoint(array[j].position),
					roll = array[j].roll
				};
			}
			cinemachineSmoothPath.InvalidateDistanceCache();
			paths[i] = cinemachineSmoothPath;
		}
	}

	protected override void OnAfterSaveState(ref QWorldWalkingPeopleGroupData saveData)
	{
		base.OnAfterSaveState(ref saveData);
		saveData.waypoints = paths.Select((CinemachineSmoothPath path) => path.m_Waypoints.Select((CinemachineSmoothPath.Waypoint waypoint) => new CinemachineSmoothPath.Waypoint
		{
			position = path.transform.TransformPoint(waypoint.position),
			roll = waypoint.roll
		}).ToArray()).ToList();
	}

	private CinemachinePathBase GetPath(int index)
	{
		if (index >= 0 && index < paths.Length)
		{
			return paths[index];
		}
		return null;
	}

	private Bounds CalcPathBoundingBox(CinemachinePathBase path)
	{
		Bounds result = new Bounds(path.EvaluatePosition(0f), Vector3.zero);
		float num = 1f / (float)path.m_Resolution;
		for (float num2 = num; num2 <= path.MaxPos; num2 += num)
		{
			result.Encapsulate(path.EvaluatePosition(num2));
		}
		return result;
	}

	public void InvalidBoundCache()
	{
		cacheBounds = null;
	}

	private bool Visible(float dither)
	{
		return dither >= 0.2f;
	}

	public void Init()
	{
		if (paths != null)
		{
			estimateWalkPeopleLifeTime = paths.Average((CinemachineSmoothPath path) => path.PathLength) / 1.5f;
			pathMaxDistance = paths.Max((CinemachineSmoothPath path) => path.PathLength);
			eachPathGenPeopleCooldown = new float[paths.Length];
		}
		vsm = new UpdateVisibleInternalLogic
		{
			OnEnterVisible = OnEnterVisible,
			OnVisibleUpdate = OnVisible,
			OnExitVisible = OnExitVisible
		};
		people = new WalkingPeopleData[data.walkingPeopleLimit];
		for (int num = 0; num < people.Length; num++)
		{
			people[num] = WalkingPeopleData.Invalid;
		}
		running = true;
	}

	public void Shutdown()
	{
		running = false;
		Culled = true;
		people = null;
	}

	public void Resize(int walkingPeopleLimit)
	{
		int walkingPeopleLimit2 = data.walkingPeopleLimit;
		data.walkingPeopleLimit = walkingPeopleLimit;
		Array.Resize(ref people, walkingPeopleLimit);
		for (int i = walkingPeopleLimit2; i < walkingPeopleLimit; i++)
		{
			people[i] = WalkingPeopleData.Invalid;
		}
	}

	private void OnEnterVisible()
	{
		actors = new PassiveCharaActor[people.Length];
		for (int i = 0; i < people.Length; i++)
		{
			actors[i] = new PassiveCharaActor();
		}
	}

	private void OnExitVisible()
	{
		if (actors != null)
		{
			for (int i = 0; i < actors.Length; i++)
			{
				actors[i].Recycle();
			}
			actors = null;
		}
	}

	private void OnVisible(float dt)
	{
		bool justEnterVisible = vsm.justEnterVisible;
		for (int i = 0; i < people.Length; i++)
		{
			WalkingPeople cullable = new WalkingPeople(this, i);
			ref WalkingPeopleData reference = ref cullable.Data;
			PassiveCharaActor actor = cullable.Actor;
			float num = 0f;
			RearrangeState rearrangeState;
			if (!reference.IsValid)
			{
				rearrangeState = ((!justEnterVisible) ? RearrangeState.FromStart : RearrangeState.Halfway);
				num = 1f;
			}
			else
			{
				CinemachinePathBase path = GetPath(reference.pathIdx);
				float num2 = reference.posOnPath - path.PathLength;
				if (justEnterVisible && num2 > data.fadeRange)
				{
					rearrangeState = RearrangeState.Halfway;
					num = 1f;
				}
				else
				{
					num = CalcPeopleDither(path, reference, data.fadeRange, Culled);
					rearrangeState = ((num2 > 0f - data.fadeRange && !Visible(num)) ? RearrangeState.FromStart : RearrangeState.Keep);
				}
			}
			if (rearrangeState != RearrangeState.Keep)
			{
				RearrangeWalkingPeople(i, rearrangeState == RearrangeState.FromStart, justEnterVisible, !justEnterVisible);
			}
			if (reference.IsValid)
			{
				CinemachinePathBase path2 = GetPath(reference.pathIdx);
				actor.SetAssetWithoutClaim(data.peoplePrefabs[reference.skin]);
				QWorldMapCull.QWorldCullResult cullResult = QWorldMapCull.GetCullResult(QWorldMainCamPos, in cullable);
				data.customActorQualityByDistance.UpdatePassiveCharaActor(actor, in cullResult);
				actor.UpdateFade(num);
				float num3 = path2.ToNativePathUnits(reference.posOnPath, CinemachinePathBase.PositionUnits.Distance);
				actor.UpdatePosAndRot(path2.EvaluatePosition(num3), CalcWalkingPeopleRot(path2, num3, data.walkingPeopleGetUpDirFunc));
			}
			else
			{
				actor.Recycle();
			}
		}
	}

	private static Quaternion CalcWalkingPeopleRot(CinemachinePathBase path, float pathUnitPos, UpDir walkingPeopleGetUpDirFunc)
	{
		if (walkingPeopleGetUpDirFunc == UpDir.LocalSpace)
		{
			return path.EvaluateOrientation(pathUnitPos);
		}
		Vector3 forward = path.EvaluateTangent(pathUnitPos);
		forward.y = 0f;
		return Quaternion.LookRotation(forward, Vector3.up);
	}

	private static float CalcPeopleDither(CinemachinePathBase path, WalkingPeopleData people, float fadeRange, bool culled)
	{
		if ((bool)path && !culled)
		{
			float num = Mathf.Min(path.PathLength, people.posOnPath);
			float b = path.PathLength - num;
			return Mathf.Min(num, b) / fadeRange;
		}
		return 0f;
	}

	private float CalcRndGenCooldown()
	{
		return UnityEngine.Random.Range(data.genPeopleCooldownRndRange.x, data.genPeopleCooldownRndRange.y) * data.genPeopleCooldownSec;
	}

	private bool CheckAnyOtherPeople(int id, Func<WalkingPeopleData, bool> check)
	{
		for (int i = 0; i < people.Length; i++)
		{
			if (i != id && check(people[i]))
			{
				return true;
			}
		}
		return false;
	}

	private void CalcAvailablePathList(List<int> available, bool ignorePathGenCooldown)
	{
		available.Clear();
		for (int i = 0; i < paths.Length; i++)
		{
			if (ignorePathGenCooldown || eachPathGenPeopleCooldown[i] <= 0f)
			{
				available.Add(i);
			}
		}
	}

	private void RearrangeWalkingPeople(int i, bool goToPathStart, bool ignorePathGenCooldown, bool ignoreNearbyCheck = false)
	{
		CinemachineSmoothPath[] array = paths;
		if (array == null || array.Length == 0)
		{
			return;
		}
		CalcAvailablePathList(available, ignorePathGenCooldown);
		if (available.Count != 0)
		{
			int num = available[UnityEngine.Random.Range(0, available.Count)];
			float pos = (goToPathStart ? 0f : ((GetPath(num)?.PathLength ?? 0f) * UnityEngine.Random.value));
			if (!ignoreNearbyCheck && CheckAnyOtherPeople(i, (WalkingPeopleData data) => data.IsValid && Mathf.Abs(data.posOnPath - pos) < 1.5f * base.data.genPeopleCooldownSec))
			{
				people[i].pathIdx = -1;
				return;
			}
			people[i] = new WalkingPeopleData
			{
				skin = UnityEngine.Random.Range(0, data.peoplePrefabs.Length),
				pathIdx = num,
				speed = data.walkSpeed,
				posOnPath = pos
			};
			eachPathGenPeopleCooldown[num] = Mathf.Max(eachPathGenPeopleCooldown[num], CalcRndGenCooldown() - pos / people[i].speed);
		}
	}

	public void UpdateWalkingPeople(int i, float dt)
	{
		ref WalkingPeopleData reference = ref people[i];
		if (reference.IsValid)
		{
			reference.posOnPath += reference.speed * dt;
		}
	}

	public void UpdateLogic(float dt, QWorldMapCull.QWorldCullResult _)
	{
		int num = 0;
		while (true)
		{
			int num2 = num;
			WalkingPeopleData[] array = people;
			if (num2 >= ((array != null) ? array.Length : 0))
			{
				break;
			}
			UpdateWalkingPeople(num, dt);
			num++;
		}
		vsm.UpdateVisible(!Culled, dt);
		for (int i = 0; i < eachPathGenPeopleCooldown.Length; i++)
		{
			eachPathGenPeopleCooldown[i] -= dt;
		}
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
}
