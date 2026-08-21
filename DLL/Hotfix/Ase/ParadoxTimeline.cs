#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;

namespace Ase;

public class ParadoxTimeline
{
	private BattleTimelineCastingViewModel castingViewModel;

	private BattleTimelineCastingWindow castingWindow;

	private DRParadoxTimeline dRParadoxTimeline;

	private GameObject timelineAsset;

	private Camera timelineCamera;

	private float paradoxTime;

	private float duration;

	private string fullPath;

	protected bool isStart;

	private float cameraFov;

	protected ParadoxTimelineSystem system;

	public virtual int Group
	{
		get
		{
			if (dRParadoxTimeline == null)
			{
				return -1;
			}
			return dRParadoxTimeline.Group;
		}
	}

	public virtual int Priority
	{
		get
		{
			if (dRParadoxTimeline == null)
			{
				return 0;
			}
			return dRParadoxTimeline.Priority;
		}
	}

	public ParadoxTimeline(ParadoxTimelineSystem system)
	{
		this.system = system;
	}

	public async UniTask StartParadoxTimeline(DRParadoxTimeline dRParadoxTimeline, BaseEntity ownerEntity, List<int> multiList)
	{
		this.dRParadoxTimeline = dRParadoxTimeline;
		fullPath = AssetUtility.GetTimeLineAsset(dRParadoxTimeline.Path);
		if (GameEntry.Resource.CheckLocationValid(fullPath))
		{
			int actorId = ownerEntity.GetWorld().ActorId;
			for (int i = 0; i < multiList.Count; i++)
			{
				if (multiList[i] == actorId)
				{
					await StartTimeline();
					break;
				}
			}
		}
		else
		{
			Log.Error("资源路径 " + dRParadoxTimeline.Path + " 没有");
		}
	}

	private async UniTask StartTimeline()
	{
		if (dRParadoxTimeline == null)
		{
			return;
		}
		if (dRParadoxTimeline.ShowForms == 0)
		{
			timelineAsset = await system.LoadTimeline(fullPath);
			if (timelineAsset == null)
			{
				Log.Error(fullPath + "加载失败");
				return;
			}
			timelineAsset.SetActive(value: true);
			Camera[] componentsInChildren = timelineAsset.GetComponentsInChildren<Camera>();
			if (componentsInChildren.Length < 1)
			{
				Log.Error($"timeline 没有配置相机  {dRParadoxTimeline.Id}  {dRParadoxTimeline.Path}");
				return;
			}
			if (componentsInChildren.Length > 1)
			{
				Log.Error($"timeline 相机超过一个  {dRParadoxTimeline.Id}  {dRParadoxTimeline.Path}");
			}
			timelineCamera = componentsInChildren[0];
			CameraFov();
			SetShow();
			PlayableDirector[] componentsInChildren2 = timelineAsset.GetComponentsInChildren<PlayableDirector>();
			for (int i = 0; i < componentsInChildren2.Length; i++)
			{
				duration = (float)componentsInChildren2[i].duration;
			}
		}
		else
		{
			castingViewModel = new BattleTimelineCastingViewModel();
			castingWindow = await GameEntry.UI.LoadWindow<BattleTimelineCastingWindow>(fullPath, "DEFAULTTEMP", castingViewModel);
			await castingWindow.Show();
			castingWindow.transform.SetAsFirstSibling();
			duration = dRParadoxTimeline.Duration;
		}
	}

	private void CameraFov()
	{
		if (timelineCamera != null)
		{
			if (cameraFov == 0f)
			{
				cameraFov = timelineCamera.fieldOfView;
			}
			float num = 2.22f * (float)Screen.height / (float)Screen.width;
			float num2 = cameraFov * num;
			if (num2 > cameraFov)
			{
				timelineCamera.fieldOfView = num2;
			}
		}
	}

	public virtual void SetShow()
	{
		if (dRParadoxTimeline == null)
		{
			return;
		}
		paradoxTime = 0f;
		if (dRParadoxTimeline.ShowForms == 0)
		{
			if (timelineAsset != null)
			{
				Camera mainCamera = GameEntry.Camera.MainCamera;
				if (mainCamera != null && timelineCamera != null)
				{
					UniversalAdditionalCameraData universalAdditionalCameraData = CameraExtensions.GetUniversalAdditionalCameraData(mainCamera);
					if (!universalAdditionalCameraData.cameraStack.Contains(timelineCamera))
					{
						universalAdditionalCameraData.cameraStack.Add(timelineCamera);
					}
				}
			}
		}
		else if (castingWindow != null)
		{
			castingWindow.SetShow();
		}
		isStart = true;
	}

	public virtual void SetHide()
	{
		if (dRParadoxTimeline == null)
		{
			return;
		}
		if (dRParadoxTimeline.ShowForms == 0)
		{
			if (!(timelineAsset != null))
			{
				return;
			}
			Camera mainCamera = GameEntry.Camera.MainCamera;
			if (mainCamera != null && timelineCamera != null)
			{
				UniversalAdditionalCameraData universalAdditionalCameraData = CameraExtensions.GetUniversalAdditionalCameraData(mainCamera);
				if (universalAdditionalCameraData.cameraStack.Contains(timelineCamera))
				{
					universalAdditionalCameraData.cameraStack.Remove(timelineCamera);
				}
				if (cameraFov != 0f)
				{
					timelineCamera.fieldOfView = cameraFov;
				}
			}
		}
		else if (castingWindow != null)
		{
			castingWindow.SetHide();
		}
	}

	public virtual void OnLateUpdate(float deltaTime)
	{
		if (isStart && dRParadoxTimeline != null)
		{
			if (paradoxTime >= duration)
			{
				Finish();
			}
			else
			{
				paradoxTime += deltaTime;
			}
		}
	}

	public virtual void Finish(bool isDispose = false)
	{
		isStart = false;
		if (dRParadoxTimeline == null)
		{
			return;
		}
		if (dRParadoxTimeline.ShowForms == 0)
		{
			Camera mainCamera = GameEntry.Camera.MainCamera;
			if (mainCamera != null && timelineCamera != null)
			{
				CameraExtensions.GetUniversalAdditionalCameraData(mainCamera).cameraStack.Remove(timelineCamera);
				if (cameraFov != 0f)
				{
					timelineCamera.fieldOfView = cameraFov;
				}
			}
			timelineCamera = null;
			if (timelineAsset != null)
			{
				system.FreeTimeline(fullPath, timelineAsset);
			}
			timelineAsset = null;
		}
		else
		{
			castingWindow?.CloseUI();
			castingViewModel?.Close();
		}
		if (!isDispose)
		{
			system?.FinishTimeline(dRParadoxTimeline.Group);
		}
		paradoxTime = 0f;
		dRParadoxTimeline = null;
	}

	public virtual void Dispose()
	{
		Finish(isDispose: true);
	}
}
