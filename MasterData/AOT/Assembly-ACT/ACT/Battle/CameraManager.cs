using System;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace ACT.Battle;

public class CameraManager : Singleton<CameraManager>
{
	private IDisposable _loop;

	private bool _setSkipBase;

	private bool _skipBaseState;

	private bool _delayOneFrame;

	private CinemachineVirtualCamera _npcVCamera;

	private CinemachineVirtualCamera _npcUiVCamera;

	public CinemachineVirtualCamera NPCVCamera
	{
		get
		{
			if (_npcVCamera == null)
			{
				GameObject gameObject = new GameObject("NPC_Generic_VirtualCamera");
				_npcVCamera = gameObject.AddComponent<CinemachineVirtualCamera>();
			}
			return _npcVCamera;
		}
	}

	public CinemachineVirtualCamera NpcUiVCamera
	{
		get
		{
			if (_npcUiVCamera == null)
			{
				GameObject gameObject = new GameObject("Npc_UI_VirtualCamera");
				_npcUiVCamera = gameObject.AddComponent<CinemachineVirtualCamera>();
				_npcUiVCamera.UseCustomFovScaler(value: false);
			}
			return _npcUiVCamera;
		}
	}

	public override void Init()
	{
		base.Init();
		_loop = UniTaskAsyncEnumerable.EveryUpdate().Subscribe((AsyncUnit _) =>
		{
			if (_setSkipBase)
			{
				if (_delayOneFrame)
				{
					UniversalRenderPipeline.SetBaseCameraSkip(skip: true);
					_setSkipBase = false;
					_delayOneFrame = false;
				}
				else
				{
					_delayOneFrame = true;
				}
			}
		});
	}

	public override void UnInit()
	{
		_loop.Dispose();
		if ((bool)NPCVCamera)
		{
			UnityEngine.Object.Destroy(NPCVCamera.gameObject);
		}
		if ((bool)NpcUiVCamera)
		{
			UnityEngine.Object.Destroy(NpcUiVCamera.gameObject);
		}
		base.UnInit();
	}

	public void SetMainCameraSkipBaseEnable(bool isEnabled, int catchPriority = 0)
	{
		_skipBaseState = isEnabled;
		_setSkipBase = isEnabled;
		if (_skipBaseState)
		{
			UniversalRenderPipeline.SetBaseCameraSkip(skip: false);
			DrawUIPass.DoCatch(catchPriority);
		}
		else
		{
			DrawUIPass.ReleaseCatch();
			UniversalRenderPipeline.SetBaseCameraSkip(skip: false);
		}
	}

	public bool GetSetMainCameraSkipBaseEnableState()
	{
		return _skipBaseState;
	}
}
