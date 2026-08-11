#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cinemachine;
using DG.Tweening;
using GameFramework;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase;

public class MapSceneController : MonoBehaviour
{
	public Camera sceneCamera;

	public Transform mapRotateRoot;

	public Transform blockRoot;

	public List<GameObject> dragAreaList;

	public StateItem stateItem;

	public MeshRenderer mask;

	public MeshRenderer starBg;

	private Material starBgMat;

	public RadialBlurValue radialBlur;

	public CinemachineVirtualCamera virtualCamera;

	private float rawCameraFov;

	public float mapRotateRadio = 0.5f;

	public float fingleMoveValid = 0.01f;

	public float starBgRotateRadio = 0.001f;

	private DRWorldMap _drWorldMap;

	private Dictionary<int, WorldMapItemBlock> sectionBlocks = new Dictionary<int, WorldMapItemBlock>();

	private Action _maskOutCallback;

	private GameObject curTouch;

	private AnimationClip[] maskAnimationClips;

	private Animator maskAnimator;

	private Material maskMaterial;

	private bool validDrag;

	private bool update;

	private bool canDrag = true;

	private bool draging;

	private Texture texOld;

	private Texture texNew;

	private List<string> texAssetPaths = new List<string>();

	private string assetTag = "WorldMapScene";

	private Vector2 lastDir;

	private Vector2 lastTouchPos;

	public bool Draging => draging;

	private void Awake()
	{
		maskAnimator = mask.GetComponent<Animator>();
		maskAnimationClips = maskAnimator.runtimeAnimatorController.animationClips;
		List<Material> list = new List<Material>();
		mask.GetMaterials(list);
		if (list.Count > 0)
		{
			maskMaterial = list[0];
		}
		List<Material> list2 = new List<Material>();
		starBg.GetMaterials(list2);
		if (list2.Count > 0)
		{
			starBgMat = list2[0];
		}
		if (virtualCamera != null)
		{
			rawCameraFov = virtualCamera.m_Lens.FieldOfView;
		}
	}

	private void Update()
	{
		if (!update)
		{
			return;
		}
		if (!canDrag)
		{
			draging = false;
		}
		else if (TouchEnd())
		{
			canDrag = true;
			draging = false;
		}
		else if (TouchBegin())
		{
			lastTouchPos = GetTouchPosition();
		}
		else
		{
			if (!TouchIng())
			{
				return;
			}
			Vector2 touchPosition = GetTouchPosition();
			if (Vector2.Distance(lastTouchPos, touchPosition) <= fingleMoveValid)
			{
				lastTouchPos = touchPosition;
				return;
			}
			lastTouchPos = touchPosition;
			RaycastHit val = default(RaycastHit);
			if (!validDrag || !Physics.Raycast(sceneCamera.ScreenPointToRay(GetTouchPosition()), ref val) || !dragAreaList.Contains(((RaycastHit)(ref val)).transform.gameObject))
			{
				return;
			}
			Vector2 vector = new Vector2(((RaycastHit)(ref val)).point.x, ((RaycastHit)(ref val)).point.z - 14.7f);
			if (!draging)
			{
				lastDir = vector;
				draging = true;
				return;
			}
			Vector2 to = vector;
			float num = 0f - Vector2.SignedAngle(lastDir, to);
			mapRotateRoot.Rotate(0f, num * mapRotateRadio, 0f);
			if (maskMaterial != null)
			{
				maskMaterial.SetFloat("_Rotation", 0f - mapRotateRoot.localEulerAngles.y);
			}
			if (starBgMat != null)
			{
				float num2 = starBgMat.GetFloat("_Angle");
				starBgMat.SetFloat("_Angle", num2 - num * starBgRotateRadio);
			}
			Physics.Simulate(Time.fixedDeltaTime);
			lastDir = vector;
		}
	}

	private void UpdateSceneState(bool active)
	{
		stateItem.gameObject.SetActive(active);
		stateItem.CurState = ((!active) ? (-1) : 0);
		if (active)
		{
			GameEntry.Camera.InsertCamera(sceneCamera);
		}
		else
		{
			GameEntry.Camera.RemoveCamera(sceneCamera);
		}
		sceneCamera.gameObject.SetActive(active);
	}

	public void Init(DRWorldMap drWorldMap)
	{
		ResetRadialBlur();
		UpdateSceneState(active: true);
		Refresh(drWorldMap);
		update = true;
	}

	public void Refresh()
	{
		ResetRadialBlur();
		Refresh(_drWorldMap);
	}

	private void ResetRotation()
	{
		if (mapRotateRoot != null)
		{
			mapRotateRoot.rotation = Quaternion.Euler(Vector3.zero);
			Physics.Simulate(Time.fixedDeltaTime);
		}
		if (maskMaterial != null)
		{
			maskMaterial.SetFloat("_Rotation", 0f);
		}
		if (starBgMat != null)
		{
			starBgMat.SetFloat("uv", 0f);
		}
	}

	private async void Refresh(DRWorldMap drWorldMap)
	{
		_drWorldMap = drWorldMap;
		IMapService mapService = Singleton<ServiceSystem>.Instance.GetService<IMapService>();
		List<DRSectionMap> sections = GameEntry.DataTable.GetDataRows((DRSectionMap p) => p.WorldId.Equals(drWorldMap.Id)).ToList();
		if (sections.Count <= 0)
		{
			foreach (WorldMapItemBlock value in sectionBlocks.Values)
			{
				value.Hide();
			}
			string text = $"Map/WorldMap/world_{_drWorldMap.Id}_mask_1";
			if (!texAssetPaths.Contains(text))
			{
				texAssetPaths.Add(text);
			}
			texOld = await GameEntry.Resource.LoadAssetAsync<Texture>(AssetUtility.GetTextureAsset(text, "tga"));
			texNew = texOld;
			maskMaterial.SetTexture("_ClipTex1", texOld);
			maskMaterial.SetTexture("_ClipTex2", texNew);
			mask.gameObject.SetActive(value: true);
			return;
		}
		int maxDisplayPriority = -1;
		int maxPrioritySecionId = -1;
		sections.ForEach(delegate(DRSectionMap p)
		{
			if (mapService.GetSectionOpenState(p.Id) && p.DisplayPriority > maxDisplayPriority)
			{
				maxDisplayPriority = p.DisplayPriority;
				maxPrioritySecionId = p.Id;
			}
		});
		bool needMaskOut = false;
		try
		{
			needMaskOut = await RefreshMask(maxPrioritySecionId, maxDisplayPriority);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetPlayerMark());
		List<TaskDataViewModel> allUnFinishedDisplayTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllUnFinishedDisplayTask();
		foreach (DRSectionMap item in sections)
		{
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			foreach (TaskDataViewModel item2 in allUnFinishedDisplayTask)
			{
				if (item2.SectionId == item.Id)
				{
					if (!flag)
					{
						flag = item2.TaskType == 1;
					}
					if (!flag2)
					{
						flag2 = item2.TaskType == 3;
					}
					if (!flag3)
					{
						flag3 = item2.TaskType == 2;
					}
					if (!flag4)
					{
						flag4 = item2.TaskType == 4;
					}
				}
			}
			bool sectionOpenState = mapService.GetSectionOpenState(item.Id);
			bool playerMarkShow = dataRow?.MapId.Equals(item.Id) ?? false;
			RefreshSectionBlock(item, sectionOpenState, needMaskOut && item.DisplayPriority == maxDisplayPriority, playerMarkShow, flag, flag2, flag3, flag4);
		}
		foreach (int sectionId in sectionBlocks.Keys)
		{
			if (!sections.Exists((DRSectionMap p) => p.Id.Equals(sectionId)))
			{
				sectionBlocks[sectionId]?.Hide();
			}
		}
		mask.gameObject.SetActive(value: true);
	}

	private async Task<bool> RefreshMask(int sectionId, int maxDisplayPriority)
	{
		bool needMaskOut = await Singleton<ServiceSystem>.Instance.GetService<IMapService>().RequestMapState(sectionId);
		try
		{
			int num;
			int newId;
			if (needMaskOut)
			{
				num = ((maxDisplayPriority - 1 <= 0) ? 1 : (maxDisplayPriority - 1));
				newId = maxDisplayPriority;
			}
			else
			{
				num = maxDisplayPriority;
				newId = maxDisplayPriority;
			}
			string text = $"Map/WorldMap/world_{_drWorldMap.Id}_mask_{num}";
			if (!texAssetPaths.Contains(text))
			{
				texAssetPaths.Add(text);
			}
			texOld = await GameEntry.Resource.LoadAssetAsync<Texture>(AssetUtility.GetTextureAsset(text, "tga"));
			string text2 = $"Map/WorldMap/world_{_drWorldMap.Id}_mask_{newId}";
			if (!texAssetPaths.Contains(text2))
			{
				texAssetPaths.Add(text2);
			}
			texNew = await GameEntry.Resource.LoadAssetAsync<Texture>(AssetUtility.GetTextureAsset(text2, "tga"));
			if (!needMaskOut)
			{
				maskMaterial.SetTexture("_ClipTex1", texOld);
				maskMaterial.SetTexture("_ClipTex2", texNew);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		return needMaskOut;
	}

	public GameObject GetTouchGoByRay(Vector2 pos)
	{
		RaycastHit val = default(RaycastHit);
		if (Physics.Raycast(sceneCamera.ScreenPointToRay(pos), ref val))
		{
			return ((RaycastHit)(ref val)).transform.gameObject;
		}
		return null;
	}

	private async void RefreshSectionBlock(DRSectionMap section, bool unlock = false, bool animationShow = false, bool playerMarkShow = false, bool isMainTask = false, bool isDailyTask = false, bool isSideTask = false, bool isMonsterTask = false)
	{
		if (section == null)
		{
			return;
		}
		if (sectionBlocks == null)
		{
			sectionBlocks = new Dictionary<int, WorldMapItemBlock>();
		}
		if (!sectionBlocks.ContainsKey(section.Id) && !(await GenerateItemBlock(section)))
		{
			return;
		}
		WorldMapItemBlock sectionBlock = sectionBlocks[section.Id];
		if (sectionBlock.SafeIsUnityNull())
		{
			return;
		}
		sectionBlock.RefreshTag(isMainTask, isDailyTask, isSideTask, isMonsterTask);
		sectionBlock.SetPlayerMarkVisible(playerMarkShow);
		if (!animationShow)
		{
			sectionBlock.RefreshState(unlock);
			sectionBlock.Show();
			return;
		}
		sectionBlock.RefreshState(unlock: false);
		sectionBlock.Show();
		PlayMaskOutAnimation(section.Id, delegate
		{
			sectionBlock.RefreshState(unlock: true);
		});
	}

	private async Task<bool> GenerateItemBlock(DRSectionMap drData)
	{
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(AssetUtility.GetUIItemAsset(drData.SectionModelPath), blockRoot);
		if (gameObject == null)
		{
			Log.Error("没有找到章节模型资源. Path = " + drData.SectionModelPath);
			return false;
		}
		GameObject gameObject2 = gameObject;
		WorldMapItemBlock worldMapItemBlock = gameObject2.GetComponent<WorldMapItemBlock>();
		if (worldMapItemBlock == null)
		{
			worldMapItemBlock = gameObject2.GetComponentInChildren<WorldMapItemBlock>();
		}
		if (worldMapItemBlock == null)
		{
			return false;
		}
		worldMapItemBlock.Init(drData);
		if (sectionBlocks.ContainsKey(drData.Id))
		{
			sectionBlocks[drData.Id] = worldMapItemBlock;
		}
		else
		{
			sectionBlocks.Add(drData.Id, worldMapItemBlock);
		}
		return true;
	}

	private async void PlayMaskOutAnimation(int sectionId, Action callback = null)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IMapService>().RequestOpenMap(sectionId))
		{
			_maskOutCallback = callback;
			float length = maskAnimationClips[0].length;
			((Behaviour)(object)maskAnimator).enabled = true;
			maskAnimator.SetTrigger(Animator.StringToHash("out"));
			Invoke("MaskOutCallback", length);
		}
		else
		{
			Toast.ShowError($"播放章节{sectionId} 解锁动画 状态记录失败");
		}
		maskMaterial.SetTexture("_ClipTex1", texOld);
		maskMaterial.SetTexture("_ClipTex2", texNew);
	}

	private void MaskOutCallback()
	{
		_maskOutCallback?.Invoke();
	}

	private static bool TouchBegin()
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		if (Input.GetKeyDown(KeyCode.Mouse0))
		{
			return true;
		}
		if (Input.touchCount == 1)
		{
			Touch touch = Input.GetTouch(0);
			if ((int)((Touch)(ref touch)).phase == 0)
			{
				return true;
			}
		}
		return false;
	}

	private static bool TouchEnd()
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Invalid comparison between Unknown and I4
		if (Input.GetKeyUp(KeyCode.Mouse0))
		{
			return true;
		}
		if (Input.touchCount == 1)
		{
			Touch touch = Input.GetTouch(0);
			if ((int)((Touch)(ref touch)).phase == 3)
			{
				return true;
			}
		}
		return false;
	}

	private static bool TouchIng()
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Invalid comparison between Unknown and I4
		if (Input.GetKey(KeyCode.Mouse0))
		{
			return true;
		}
		if (Input.touchCount == 1)
		{
			Touch touch = Input.GetTouch(0);
			if ((int)((Touch)(ref touch)).phase == 1)
			{
				return true;
			}
		}
		return false;
	}

	public void SetValidDrag(bool valid)
	{
		validDrag = valid;
	}

	public void StartRadialBlur(float radialBlurDuration, float fovDiff, Action callback)
	{
		radialBlur.RadialBlurRange = 0f;
		DOTween.To(() => radialBlur.RadialBlurRange, delegate(float v)
		{
			radialBlur.RadialBlurRange = v;
		}, 10f, radialBlurDuration).OnComplete(delegate
		{
			callback?.Invoke();
		});
		virtualCamera.m_Lens.FieldOfView = rawCameraFov;
		DOTween.To(() => virtualCamera.m_Lens.FieldOfView, delegate(float v)
		{
			virtualCamera.m_Lens.FieldOfView = v;
		}, rawCameraFov - fovDiff, radialBlurDuration);
	}

	public void ResetRadialBlur()
	{
		radialBlur.RadialBlurRange = 0f;
		virtualCamera.m_Lens.FieldOfView = rawCameraFov;
	}

	private static Vector2 GetTouchPosition()
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		if (Input.GetKey(KeyCode.Mouse0))
		{
			return Input.mousePosition;
		}
		if (Input.touchCount > 0)
		{
			Touch touch = Input.GetTouch(0);
			return ((Touch)(ref touch)).position;
		}
		return Vector2.zero;
	}

	public void Dispose()
	{
		ResetRotation();
		update = false;
		draging = false;
		UpdateSceneState(active: false);
	}

	private void OnDestroy()
	{
		List<WorldMapItemBlock> list = sectionBlocks.Values.ToList();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num] != null)
			{
				UnityEngine.Object.DestroyImmediate(list[num].WholeTransform.gameObject);
				list[num] = null;
			}
		}
		list = null;
		sectionBlocks = null;
		if (texAssetPaths == null)
		{
			return;
		}
		foreach (string texAssetPath in texAssetPaths)
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(texAssetPath, "tga"));
		}
	}
}
