using UnityEngine;

public class DormModuleHelper_HotFix
{
	private static bool TryGetLevelController(out DormLevelController ctrl)
	{
		ctrl = null;
		if (null == ModuleController<DormModuleController>.Instance)
		{
			return false;
		}
		ctrl = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
		return null != ctrl;
	}

	public static int GetCurRoomUsedCellNum()
	{
		if (!TryGetLevelController(out var ctrl))
		{
			return 0;
		}
		return ctrl.GetCurRoomUsedCellNum();
	}

	public static long[] GetFur_EntityId_RootBubbleTrans(int nFurId, out Transform[] arrBB)
	{
		arrBB = null;
		if (!TryGetLevelController(out var ctrl))
		{
			return null;
		}
		long[] furEntityId = ctrl.GetFurEntityId(nFurId);
		arrBB = ctrl.GetFurRootBubbleTrans(nFurId);
		return furEntityId;
	}

	public static bool TryPickActorAtLastPressDown(out Transform rt, out int RoleId, out long entityId)
	{
		DormActor actor = null;
		rt = null;
		RoleId = 0;
		entityId = 0L;
		if (!TryGetLevelController(out var ctrl))
		{
			return false;
		}
		if (!ctrl.TryPickActorAtLastPressDown(out actor))
		{
			return false;
		}
		if (!ctrl.TrySwitchSelectedActorInViewMode(actor))
		{
			return false;
		}
		rt = actor.transform;
		RoleId = actor.RoleId;
		entityId = actor.id;
		return true;
	}

	public static bool CaptureSceneImage(string scope, string imageFileName, bool useOutdoorSceneCamera)
	{
		if (DormSceneCapture.Instance != null)
		{
			return DormSceneCapture.Instance.CaptureImage(scope, imageFileName, useOutdoorSceneCamera);
		}
		return false;
	}

	public static Sprite LoadSceneCaptureImageSprite(string scope, string imageFileName)
	{
		if (DormSceneCapture.Instance != null)
		{
			return DormSceneCapture.Instance.LoadCaptureImageSprite(scope, imageFileName);
		}
		return null;
	}

	public static void ReleaseSceneCaptureImageSprite(Sprite sprite)
	{
		if (DormSceneCapture.Instance != null)
		{
			DormSceneCapture.Instance.ReleaseCaptureImageSprite(sprite);
		}
	}

	public static void CleanSceneCaptureImages(string scope, string[] keepFileNames)
	{
		if (DormSceneCapture.Instance != null)
		{
			DormSceneCapture.Instance.CleanCaptureImages(scope, keepFileNames);
		}
	}
}
