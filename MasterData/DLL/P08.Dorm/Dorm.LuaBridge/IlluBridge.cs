using System;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using Dorm.Character;
using Dorm.Illu;
using Dorm.MiniGame;
using LuaInterface;
using UnityEngine;

namespace Dorm.LuaBridge;

public static class IlluBridge
{
	[NoToLua]
	public static EffectController lineActive;

	private static EffectController fullScreenEffect;

	private static CinemachineVirtualCamera minigameMainCamVC;

	public static void MuteAudioTriggerOnEntityAnimator(int entityID)
	{
		AnimatiorAudioTrigger[] behaviours = (DormEntityManager.Instance.TryGet(entityID)?.animator).GetBehaviours<AnimatiorAudioTrigger>();
		for (int i = 0; i < behaviours.Length; i++)
		{
			behaviours[i].mute = true;
		}
	}

	public static void SetupItemSprite(int entityID, string spritepath)
	{
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(entityID);
		SpriteRenderer renderer = dormEntity.ModelTrs.GetComponentInChildren<SpriteRenderer>();
		if (!renderer)
		{
			return;
		}
		if (string.IsNullOrEmpty(spritepath))
		{
			renderer.sprite = null;
			return;
		}
		AtlasManager.GetSpriteWithoutAtlasAsync(spritepath, delegate(Sprite sprite)
		{
			renderer.sprite = sprite;
		});
	}

	public static void SetupClickTriggerForEntity(int entityID)
	{
		EntityClickTrigger entityClickTrigger = U3DUtil.Get<EntityClickTrigger>(DormEntityManager.Instance.TryGet(entityID).model);
		entityClickTrigger.eid = entityID;
		entityClickTrigger.enabled = true;
	}

	public static void SetupClickTriggerForEntity(int entityID, float size = 1f)
	{
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(entityID);
		EntityClickTrigger entityClickTrigger = U3DUtil.Get<EntityClickTrigger>(dormEntity.model);
		entityClickTrigger.eid = entityID;
		entityClickTrigger.enabled = true;
		BoxCollider boxCollider = U3DUtil.Get<BoxCollider>(dormEntity.model);
		boxCollider.size = new Vector3(0.5f * size, 0f, 0.5f * size);
		boxCollider.center = new Vector3(0f, 0.23f, 0f);
		boxCollider.enabled = true;
	}

	public static void MuteClickTriggerForEntity(int entityID)
	{
		U3DUtil.Get<EntityClickTrigger>(DormEntityManager.Instance.TryGet(entityID).model).enabled = false;
	}

	public static void Launch(string illuScene)
	{
		NScene.Load<DormIlluScene>().sceneName = illuScene;
	}

	public static void ShowConnectLine(Vector3[] points, float displayTime = 1f)
	{
		if ((bool)lineActive && lineActive.mIsRunning)
		{
			lineActive.Stop();
		}
		GameObject go = Asset.Instantiate("Dorm/Effect/lianliankan/line");
		lineActive = U3DUtil.Get<EffectController>(go);
		lineActive.Initialize(isLoop: false, displayTime, 1f, EEffectQuality.Low, null);
		LineRenderer lineRenderer = U3DUtil.Get<LineRenderer>(go);
		lineRenderer.useWorldSpace = true;
		lineRenderer.positionCount = points.Length;
		lineRenderer.SetPositions(points);
		lineActive.Simulator(0f);
	}

	public static bool CheckPosBlocked(Vector3 pos)
	{
		return CheckPosBlocked(pos, 0.25f, 1f);
	}

	public static bool CheckPosBlocked(Vector3 pos, float radius, float height)
	{
		Vector3 point = pos + radius * Vector3.up;
		Vector3 point2 = pos + (height - radius) * Vector3.up;
		int cHARA_LAYER_MASK = DormConst.CHARA_LAYER_MASK;
		Collider[] array = Physics.OverlapCapsule(point, point2, radius, cHARA_LAYER_MASK, QueryTriggerInteraction.Ignore);
		if (array != null)
		{
			return array.Length != 0;
		}
		return false;
	}

	public static int BeamcastEntity(Vector2 screenPos, float radius, out Vector3 hitPos, out string hitColliderName)
	{
		if (Physics.SphereCast(Camera.main.ScreenPointToRay(screenPos), radius, out var hitInfo, float.MaxValue, DormConst.CHARA_LAYER_MASK | DormConst.GROUND_LAYER_MASK))
		{
			hitPos = hitInfo.point;
			hitColliderName = hitInfo.collider.name;
			return hitInfo.transform.GetComponentInParent<IEidProvider>()?.EntityID ?? 0;
		}
		hitPos = Vector3.positiveInfinity;
		hitColliderName = null;
		return 0;
	}

	public static int[] BeamcastEntities(Vector2 screenPos, float radius)
	{
		IOrderedEnumerable<RaycastHit> orderedEnumerable = from hit in Physics.SphereCastAll(Camera.main.ScreenPointToRay(screenPos), radius, float.MaxValue, DormConst.CHARA_LAYER_MASK | DormConst.GROUND_LAYER_MASK)
			orderby hit.distance
			select hit;
		SortedSet<int> sortedSet = new SortedSet<int>();
		foreach (RaycastHit item in orderedEnumerable)
		{
			IEidProvider componentInParent = item.transform.GetComponentInParent<IEidProvider>();
			if (componentInParent != null)
			{
				sortedSet.Add(componentInParent.EntityID);
			}
		}
		return sortedSet.ToArray();
	}

	public static void SetEntityIgnoreBeamcast(int entityID, bool value)
	{
		DormEntity dormEntity = DormEntityManager.Instance?.TryGet(entityID);
		if (dormEntity == null)
		{
			return;
		}
		Collider[] componentsInChildren = dormEntity.model.GetComponentsInChildren<Collider>(includeInactive: true);
		foreach (Collider collider in componentsInChildren)
		{
			if (collider as CharacterController == null)
			{
				collider.gameObject.layer = ((!value) ? DormConst.CHARA_LAYER_ID : LayerMask.NameToLayer("Ignore Raycast"));
			}
		}
	}

	public static void InitDefaultEntityCollider(int entityID)
	{
		DormEntity dormEntity = DormEntityManager.Instance?.TryGet(entityID);
		if (dormEntity != null)
		{
			InitDefaultEntityCollider(dormEntity);
		}
	}

	internal static void InitDefaultEntityCollider(DormEntity entity)
	{
		InitDefaultEntityCollider(entity, "gua_Hit");
	}

	internal static void InitDefaultEntityCollider(DormEntity entity, string attach)
	{
		CapsuleCollider capsuleCollider = U3DUtil.Get<CapsuleCollider>(entity.FindAttachPoint(attach).gameObject);
		capsuleCollider.center = new Vector3(0f, 0f, 0f);
		capsuleCollider.radius = entity.radius;
		capsuleCollider.height = entity.height;
		capsuleCollider.direction = 1;
		capsuleCollider.enabled = true;
	}

	public static void InitMoveController(int entityID)
	{
		DormEntity dormEntity = DormEntityManager.Instance?.TryGet(entityID);
		CharacterController characterController = dormEntity?.InitComponent<CharacterController>();
		if ((bool)characterController)
		{
			characterController.skinWidth = 0.002f;
			characterController.radius = dormEntity.radius;
			characterController.height = dormEntity.height;
			characterController.center = new Vector3(0f, 0.5f + characterController.skinWidth, 0f);
			characterController.enabled = false;
			characterController.stepOffset = 0.1f;
		}
		dormEntity?.InitComponent<DormEntityMoveController>();
	}

	public static void SetMoveControllerInput(int entityID, Vector2 input)
	{
		DormEntityMoveController dormEntityMoveController = (DormEntityManager.Instance?.TryGet(entityID))?.ModelTrs.GetComponent<DormEntityMoveController>();
		if (dormEntityMoveController != null)
		{
			dormEntityMoveController.InputVec = input;
		}
	}

	public static void SetMoveLookAtEntity(int entityID, int lookAt)
	{
		DormEntity obj = DormEntityManager.Instance?.TryGet(entityID);
		Transform lookingTarget = DormEntityManager.Instance?.TryGet(lookAt)?.ModelTrs;
		DormEntityMoveController dormEntityMoveController = obj?.ModelTrs.GetComponent<DormEntityMoveController>();
		if ((bool)dormEntityMoveController)
		{
			dormEntityMoveController.SetLookingTarget(lookingTarget);
		}
	}

	public static void SetMoveLookAtDir(int entityID, Vector3 dir)
	{
		DormEntityMoveController dormEntityMoveController = (DormEntityManager.Instance?.TryGet(entityID))?.ModelTrs.GetComponent<DormEntityMoveController>();
		if ((bool)dormEntityMoveController)
		{
			dormEntityMoveController.SetLookingDir(dir);
		}
	}

	[NoToLua]
	public static void PlayEffect(Vector3 pos, Quaternion rotation, Vector3 scale, string path, float duration, EEffectQuality quality, Action<EffectController> action)
	{
		GameObject gameObject = Asset.Instantiate(path);
		if ((bool)gameObject)
		{
			gameObject.transform.position = pos;
			gameObject.transform.rotation = rotation;
			gameObject.transform.localScale = scale;
			EffectController component = gameObject.GetComponent<EffectController>();
			component.Initialize(isLoop: false, duration, 1f, quality, action);
			component.Simulator(0f);
		}
	}

	public static void PlayEffect(Vector3 pos, Quaternion rot, Vector3 scale, string path, float duration)
	{
		PlayEffect(pos, rot, scale, path, duration, EEffectQuality.Low, null);
	}

	public static void PlayEffect(Vector3 pos, string path, float duration)
	{
		PlayEffect(pos, Quaternion.identity, Vector3.one, path, duration);
	}

	public static void PlayFullScreenEffect(string path, float duration)
	{
		PlayFullScreenEffect(path, duration, EEffectQuality.Low, null);
	}

	public static void PlayFullScreenEffect(GameObject efxGo, float duration)
	{
		PlayFullScreenEffect(efxGo, duration, EEffectQuality.Low, null);
	}

	[NoToLua]
	public static void PlayFullScreenEffect(string path, float duration, EEffectQuality quality, Action<EffectController> action)
	{
		if ((bool)fullScreenEffect)
		{
			fullScreenEffect.Stop();
		}
		PlayFullScreenEffect(Asset.Instantiate(path), duration, quality, action);
	}

	[NoToLua]
	public static void PlayFullScreenEffect(GameObject efxGo, float duration, EEffectQuality quality, Action<EffectController> action)
	{
		efxGo.transform.SetParent(Camera.main.transform, worldPositionStays: false);
		efxGo.transform.localPosition = Vector3.zero;
		efxGo.transform.localRotation = Quaternion.identity;
		fullScreenEffect = efxGo.GetComponent<EffectController>();
		fullScreenEffect.Initialize(isLoop: false, (duration == -1f) ? float.MaxValue : duration, 1f, quality, action);
		fullScreenEffect.Simulator(0f);
		U3DUtil.Get<CameraEffectController>(efxGo).Initalization(Vector3.one, 55f, new Vector2(1920f, 1080f));
	}

	public static void ClearAllFullScreenEffect()
	{
		EffectController[] componentsInChildren = Camera.main.GetComponentsInChildren<EffectController>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].Stop();
		}
	}

	public static void PlayStory(string timelineAssetPath, int[] actors, bool recordOriginalCamParam = true)
	{
		DormStoryManager.instance.Play(timelineAssetPath, actors);
		if (recordOriginalCamParam)
		{
			EnableMinigameStoryCameraControl();
		}
	}

	public static void PlayStory(string timelineAssetPath, int[] actors, string[] actorPaths, bool recordOriginalCamParam = true)
	{
		DormStoryManager.instance.Play(timelineAssetPath, actors, actorPaths);
		if (recordOriginalCamParam)
		{
			EnableMinigameStoryCameraControl();
		}
	}

	public static void StopStory(bool skipRestoreOriginalCamParam = false)
	{
		DormStoryManager.instance.Dispose();
		if (!skipRestoreOriginalCamParam)
		{
			RestoreCameraAfterMinigameStory();
		}
	}

	internal static void EnableMinigameStoryCameraControl()
	{
		if (NScene.GetCurrentScene() is MiniGameScene miniGameScene)
		{
			if (minigameMainCamVC == null)
			{
				minigameMainCamVC = U3DUtil.Get<CinemachineVirtualCamera>(new GameObject("Minigame MainCam Original Pos Mark"));
			}
			Camera main = Camera.main;
			minigameMainCamVC.transform.position = main.transform.position;
			minigameMainCamVC.transform.rotation = main.transform.rotation;
			minigameMainCamVC.m_Lens.FieldOfView = main.fieldOfView;
			minigameMainCamVC.m_Lens.FarClipPlane = main.farClipPlane;
			minigameMainCamVC.m_Lens.NearClipPlane = main.nearClipPlane;
			miniGameScene.cinemachineBrain.enabled = true;
			minigameMainCamVC.Priority = 0;
		}
	}

	internal static void RestoreCameraAfterMinigameStory()
	{
		if (NScene.GetCurrentScene() is MiniGameScene miniGameScene)
		{
			miniGameScene.cinemachineBrain.enabled = false;
		}
		if ((bool)minigameMainCamVC)
		{
			Camera main = Camera.main;
			main.transform.position = minigameMainCamVC.transform.position;
			main.transform.rotation = minigameMainCamVC.transform.rotation;
			main.farClipPlane = minigameMainCamVC.m_Lens.FarClipPlane;
			main.nearClipPlane = minigameMainCamVC.m_Lens.NearClipPlane;
			main.fieldOfView = minigameMainCamVC.m_Lens.FieldOfView;
		}
	}

	public static void SetupCameraEventTriggerAtMainCamFarClip()
	{
		SetupCameraEventTriggerAtMainCamFarClip<CameraEventTrigger>(null);
	}

	internal static void SetupCameraEventTriggerAtMainCamFarClip<T>(GameObject farClipTriggerPrefab) where T : CameraEventTrigger
	{
		if (Camera.main.transform.GetComponentInChildren<T>() == null)
		{
			float farClipPlane = Camera.main.farClipPlane;
			GameObject gameObject = ((!farClipTriggerPrefab) ? new GameObject("CamTrigger") : UnityEngine.Object.Instantiate(farClipTriggerPrefab));
			gameObject.transform.SetParent(Camera.main.transform, worldPositionStays: false);
			gameObject.transform.localPosition = new Vector3(0f, 0f, farClipPlane);
			gameObject.AddComponent<BoxCollider>().size = new Vector3(60f, 60f, 0.001f);
			gameObject.AddComponent<T>().fixedAtCamFarClip = true;
		}
	}
}
