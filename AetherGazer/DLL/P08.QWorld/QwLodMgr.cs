using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Unity.Jobs;
using UnityEngine;
using UnityEngine.Jobs;
using UnityEngine.Pool;

public class QwLodMgr
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct UpdateLodDataJob : IJobParallelForTransform
	{
		public void Execute(int idx, TransformAccess transform)
		{
			IQwLodObject qwLodObject = lodObjects[idx];
			ref QwLodData lodData = ref qwLodObject.GetLodData();
			lodData.lodObjectIndex = idx;
			QWorldMapEntity qWorldMapEntity = qwLodObject as QWorldMapEntity;
			bool flag = qwLodObject is QWorldMapEntity;
			if (flag && qWorldMapEntity.cullMode == CullMode.Disable)
			{
				UpdateEntityLodData(qWorldMapEntity, ref lodData, transform.position);
				lodData.visibilityDirty = !lodData.visible;
				lodData.visible = true;
				return;
			}
			if (!_storyCullAll)
			{
				if (flag)
				{
					UpdateEntityLodData(qWorldMapEntity, ref lodData, transform.position);
				}
				BoundingSphere boundingSphere = _boundingSpheres[lodData.lodObjectIndex];
				bool flag2 = !FrustumCulling(cameraPlanes, boundingSphere.position, boundingSphere.radius);
				if (lodData.visible != flag2)
				{
					lodData.visible = flag2;
					lodData.visibilityDirty = true;
				}
				return;
			}
			bool flag3 = false;
			if (flag)
			{
				if (qWorldMapEntity.Is(cullingLayer))
				{
					flag3 = true;
					lodData.visibilityDirty = _storyCullAllDirty || lodData.visible;
					lodData.visible = false;
				}
			}
			else
			{
				flag3 = true;
				lodData.visibilityDirty = _storyCullAllDirty || lodData.visible;
				lodData.visible = false;
			}
			if (flag3)
			{
				return;
			}
			if (flag)
			{
				UpdateEntityLodData(qWorldMapEntity, ref lodData, transform.position);
			}
			if (cullingEntityIds != null && qWorldMapEntity != null && cullingEntityIds.Contains(qWorldMapEntity.entityId))
			{
				lodData.visibilityDirty = _storyCullAllDirty || lodData.visible;
				lodData.visible = false;
				return;
			}
			BoundingSphere boundingSphere2 = _boundingSpheres[lodData.lodObjectIndex];
			bool flag4 = !FrustumCulling(cameraPlanes, boundingSphere2.position, boundingSphere2.radius);
			if (lodData.visible != flag4)
			{
				lodData.visible = _storyCullAllDirty | flag4;
				lodData.visibilityDirty = true;
			}
		}

		private static bool FrustumCulling(Plane[] planes, Vector3 center, float radius)
		{
			for (int i = 0; i < 6; i++)
			{
				if (0f - planes[i].GetDistanceToPoint(center) > radius)
				{
					return true;
				}
			}
			return false;
		}
	}

	public static bool inited = false;

	public static Camera camera;

	public static Plane[] cameraPlanes;

	public static Vector3 lodCenterPosition;

	public static bool cameraMoved;

	public static List<IQwLodObject> lodObjects;

	private static HashSet<IQwLodObject> _lodDataModelDirtyObjects;

	public static TransformAccessArray transformAccessArray;

	private static BoundingSphere[] _boundingSpheres;

	private static List<QwLodBase> _lods;

	private static List<Transform> _transforms;

	private static GameObject _placeholder;

	public static bool jobCompleAccess;

	private static bool _objectsChanged;

	private static List<Renderer> _emptyListRenderer;

	private static List<DynamicBone> _emptyListDynamicBone;

	private static List<Animator> _emptyListAnimator;

	private static List<ParticleSystem> _emptyListParticleSystem;

	private static bool _storyCullAll;

	private static bool _storyCullAllDirty;

	private static QWAgentLayer cullingLayer;

	private static HashSet<int> cullingEntityIds = new HashSet<int>();

	public static void AddLodObject(IQwLodObject lodObject)
	{
		lodObjects.Add(lodObject);
		if (lodObject is QWorldMapEntity qWorldMapEntity)
		{
			_transforms.Add(qWorldMapEntity.transform);
		}
		else
		{
			_transforms.Add(_placeholder.transform);
		}
		foreach (QwLodBase lod in _lods)
		{
			lod.OnAddLodObject(lodObject);
		}
		_objectsChanged = true;
	}

	public static void RemoveLodObject(IQwLodObject lodObject)
	{
		foreach (QwLodBase lod in _lods)
		{
			lod.OnRemoveLodObject(lodObject);
		}
		int num = lodObjects.IndexOf(lodObject);
		if (lodObjects.Count > 1)
		{
			int num2 = lodObjects.Count - 1;
			lodObjects[num] = lodObjects[num2];
			_transforms[num] = _transforms[num2];
			if (_boundingSpheres.Length < lodObjects.Count)
			{
				int num3;
				for (num3 = Mathf.Max(_boundingSpheres.Length, 32); num3 < lodObjects.Count; num3 = Mathf.Min(num3 + 512, num3 * 2))
				{
				}
				Array.Resize(ref _boundingSpheres, num3);
			}
			_boundingSpheres[num] = _boundingSpheres[num2];
			lodObjects[num].GetLodData().lodObjectIndex = num;
			lodObjects.RemoveAt(num2);
			_transforms.RemoveAt(num2);
		}
		else
		{
			lodObjects.RemoveAt(num);
			_transforms.RemoveAt(num);
		}
		_objectsChanged = true;
	}

	public static void SetModelLoaded(IQwLodObject lodObject, bool loaded)
	{
		ref QwLodData lodData = ref lodObject.GetLodData();
		lodData.loaded = loaded;
		lodData.modelDirty = true;
		if (!_lodDataModelDirtyObjects.Contains(lodObject))
		{
			_lodDataModelDirtyObjects.Add(lodObject);
		}
	}

	public static void Init()
	{
		lodObjects = new List<IQwLodObject>();
		_transforms = new List<Transform>();
		transformAccessArray = new TransformAccessArray(_transforms.ToArray());
		_lodDataModelDirtyObjects = new HashSet<IQwLodObject>();
		_placeholder = new GameObject("LodMgrPlaceholder");
		cameraPlanes = new Plane[6];
		_boundingSpheres = new BoundingSphere[64];
		_objectsChanged = false;
		_emptyListRenderer = new List<Renderer>();
		_emptyListDynamicBone = new List<DynamicBone>();
		_emptyListAnimator = new List<Animator>();
		_emptyListParticleSystem = new List<ParticleSystem>();
		_storyCullAll = false;
		_storyCullAllDirty = false;
		_lods = new List<QwLodBase>
		{
			new QwModelLod(),
			new QwLightLod(),
			new QwComponentLod(),
			new QwEntityLod(),
			new QwZoneLod()
		};
		foreach (QwLodBase lod in _lods)
		{
			lod.Init();
		}
		inited = true;
	}

	public static void Shutdown()
	{
		foreach (QwLodBase lod in _lods)
		{
			lod.Shutdown();
		}
		_lods = null;
		lodObjects.Clear();
		lodObjects = null;
		_transforms.Clear();
		_transforms = null;
		if (transformAccessArray.isCreated)
		{
			transformAccessArray.Dispose();
		}
		_lodDataModelDirtyObjects.Clear();
		_lodDataModelDirtyObjects = null;
		UnityEngine.Object.Destroy(_placeholder);
		_placeholder = null;
		cameraPlanes = null;
		_boundingSpheres = null;
		_emptyListRenderer = null;
		_emptyListDynamicBone = null;
		_emptyListAnimator = null;
		_emptyListParticleSystem = null;
		inited = false;
	}

	public static void SetStoryCulling(bool cullAll)
	{
		_storyCullAll = cullAll;
		_storyCullAllDirty = true;
	}

	public static void SetCullingAgentLayer(QWAgentLayer layer)
	{
		cullingLayer = layer;
	}

	public static void SetHiddenIds(int[] ids)
	{
		cullingEntityIds.Clear();
		if (ids != null)
		{
			foreach (int item in ids)
			{
				cullingEntityIds.Add(item);
			}
		}
	}

	public static void UpdateAllLodData()
	{
		if (!inited)
		{
			return;
		}
		camera = QWorldCameraManager.Instance.MainCamera;
		GeometryUtility.CalculateFrustumPlanes(camera, cameraPlanes);
		if (lodCenterPosition != camera.transform.position)
		{
			lodCenterPosition = camera.transform.position;
			cameraMoved = true;
		}
		else
		{
			cameraMoved = false;
		}
		_lodDataModelDirtyObjects.Clear();
		int count = lodObjects.Count;
		if (_objectsChanged)
		{
			_objectsChanged = false;
			if (_boundingSpheres.Length < count)
			{
				int num;
				for (num = Mathf.Max(_boundingSpheres.Length, 32); num < count; num = Mathf.Min(num + 512, num * 2))
				{
				}
				Array.Resize(ref _boundingSpheres, num);
			}
			if (transformAccessArray.isCreated)
			{
				transformAccessArray.Dispose();
			}
			transformAccessArray = new TransformAccessArray(_transforms.ToArray());
		}
		JobHandle jobHandle = default(UpdateLodDataJob).ScheduleReadOnly(transformAccessArray, 8);
		jobCompleAccess = jobHandle.IsCompleted;
		for (int i = 0; i < count; i++)
		{
			IQwLodObject qwLodObject = lodObjects[i];
			ref QwLodData lodData = ref qwLodObject.GetLodData();
			lodData.lodObjectIndex = i;
			UpdateLodDataModel(qwLodObject, ref lodData);
		}
		jobHandle.Complete();
	}

	public static void PostUpdateAllLodData()
	{
		if (inited)
		{
			_storyCullAllDirty = false;
			int count = lodObjects.Count;
			for (int i = 0; i < count; i++)
			{
				ref QwLodData lodData = ref lodObjects[i].GetLodData();
				lodData.positionDirty = false;
				lodData.distanceDirty = false;
				lodData.visibilityDirty = false;
				lodData.modelDirty = false;
			}
		}
	}

	public static void UpdateLodDataModel(IQwLodObject lodObject, ref QwLodData lodData)
	{
		if (lodData.modelDirty)
		{
			OnModelDirty(lodObject, ref lodData);
			_lodDataModelDirtyObjects.Remove(lodObject);
		}
		UpdateAllLodDataModel();
	}

	private static void UpdateAllLodDataModel()
	{
		if (_lodDataModelDirtyObjects.Count <= 0)
		{
			return;
		}
		foreach (IQwLodObject lodDataModelDirtyObject in _lodDataModelDirtyObjects)
		{
			ref QwLodData lodData = ref lodDataModelDirtyObject.GetLodData();
			if (lodData.modelDirty)
			{
				OnModelDirty(lodDataModelDirtyObject, ref lodData);
			}
		}
		_lodDataModelDirtyObjects.Clear();
	}

	private static void UpdateEntityLodData(QWorldMapEntity entity, ref QwLodData lodData, Vector3 position)
	{
		BoundingSphere boundingSphere = _boundingSpheres[lodData.lodObjectIndex];
		Vector3 vector = position + lodData.bounds.center;
		if (boundingSphere.position != vector || boundingSphere.radius != lodData.boundSphereRadius)
		{
			float magnitude = (lodCenterPosition - position).magnitude;
			lodData.lastDistance = lodData.distance;
			lodData.distance = magnitude;
			lodData.positionDirty = true;
			lodData.distanceDirty = true;
			_boundingSpheres[lodData.lodObjectIndex] = new BoundingSphere(vector, lodData.boundSphereRadius);
		}
		if (cameraMoved)
		{
			float magnitude2 = (lodCenterPosition - position).magnitude;
			if (lodData.distance != magnitude2)
			{
				lodData.lastDistance = lodData.distance;
				lodData.distance = magnitude2;
				lodData.distanceDirty = true;
			}
		}
	}

	private static void OnModelDirty(IQwLodObject lodObject, ref QwLodData lodData)
	{
		if (lodData.loaded)
		{
			if (!(lodObject is QWorldMapEntity { loadedModel: var loadedModel } qWorldMapEntity))
			{
				return;
			}
			if (loadedModel != null)
			{
				List<Renderer> list = CollectionPool<List<Renderer>, Renderer>.Get();
				loadedModel.GetComponentsInChildren(list);
				for (int num = list.Count - 1; num >= 0; num--)
				{
					Renderer renderer = list[num];
					if (!(renderer is MeshRenderer) && !(renderer is SkinnedMeshRenderer) && !(renderer is ParticleSystemRenderer))
					{
						list.RemoveAt(num);
					}
				}
				if (list.Count > 0)
				{
					lodData.renderers = list;
				}
				else
				{
					CollectionPool<List<Renderer>, Renderer>.Release(list);
					lodData.renderers = _emptyListRenderer;
				}
				List<DynamicBone> list2 = CollectionPool<List<DynamicBone>, DynamicBone>.Get();
				loadedModel.GetComponentsInChildren(list2);
				if (list2.Count > 0)
				{
					lodData.dynamicBones = list2;
				}
				else
				{
					CollectionPool<List<DynamicBone>, DynamicBone>.Release(list2);
					lodData.dynamicBones = _emptyListDynamicBone;
				}
				List<Animator> list3 = CollectionPool<List<Animator>, Animator>.Get();
				loadedModel.GetComponentsInChildren(list3);
				if (list3.Count > 0)
				{
					lodData.animators = list3;
				}
				else
				{
					CollectionPool<List<Animator>, Animator>.Release(list3);
					lodData.animators = _emptyListAnimator;
				}
				List<ParticleSystem> list4 = CollectionPool<List<ParticleSystem>, ParticleSystem>.Get();
				loadedModel.GetComponentsInChildren(list4);
				if (list4.Count > 0)
				{
					lodData.particleSystems = list4;
				}
				else
				{
					CollectionPool<List<ParticleSystem>, ParticleSystem>.Release(list4);
					lodData.particleSystems = _emptyListParticleSystem;
				}
				lodData.bounds = default(Bounds);
				Matrix4x4 matrix = qWorldMapEntity.transform.worldToLocalMatrix;
				foreach (Renderer renderer2 in lodData.renderers)
				{
					if (!(renderer2 is ParticleSystemRenderer))
					{
						Bounds bounds = BoundsHelper.TransformBounds(renderer2.bounds, in matrix);
						lodData.bounds.Encapsulate(bounds);
					}
				}
				lodData.boundSphereRadius = lodData.bounds.extents.magnitude;
				foreach (Renderer renderer3 in lodData.renderers)
				{
					renderer3.enabled = true;
				}
				foreach (DynamicBone dynamicBone in lodData.dynamicBones)
				{
					dynamicBone.enabled = true;
				}
				foreach (Animator animator in lodData.animators)
				{
					animator.cullingMode = AnimatorCullingMode.CullUpdateTransforms;
				}
				lodData.passController = U3DUtil.Get<QWCharacterPassController>(qWorldMapEntity.gameObject);
				lodData.passController.InitMats(list);
			}
			else
			{
				lodData.renderers = _emptyListRenderer;
				lodData.dynamicBones = _emptyListDynamicBone;
				lodData.animators = _emptyListAnimator;
				lodData.particleSystems = _emptyListParticleSystem;
			}
		}
		else
		{
			if (lodData.renderers != null && lodData.renderers != _emptyListRenderer)
			{
				CollectionPool<List<Renderer>, Renderer>.Release(lodData.renderers);
			}
			lodData.renderers = null;
			if (lodData.dynamicBones != null && lodData.dynamicBones != _emptyListDynamicBone)
			{
				CollectionPool<List<DynamicBone>, DynamicBone>.Release(lodData.dynamicBones);
			}
			lodData.dynamicBones = null;
			if (lodData.animators != null && lodData.animators != _emptyListAnimator)
			{
				CollectionPool<List<Animator>, Animator>.Release(lodData.animators);
			}
			lodData.animators = null;
			if (lodData.particleSystems != null && lodData.particleSystems != _emptyListParticleSystem)
			{
				CollectionPool<List<ParticleSystem>, ParticleSystem>.Release(lodData.particleSystems);
			}
			lodData.particleSystems = null;
			lodData.passController = null;
		}
	}
}
