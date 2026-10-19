using ACT.LocalLoader;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Video;

namespace ACT.Initialize.Flow;

public class InitGameUtility : RuntimeLoadFlow
{
	public InitGameUtility()
		: base("InitGameUtility")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		GameUtility.mainLight = GameObject.FindGameObjectWithTag("MainLight").GetComponent<Light>();
		GameUtility.mainCamera = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
		GameUtility.uiCamera = GameObject.FindGameObjectWithTag("UICamera")?.GetComponent<Camera>();
		GameUtility.uiCanvas = GameObject.FindGameObjectWithTag("UICanvas").GetComponent<Canvas>();
		GameUtility.mainVideoPlayer = GameObject.FindGameObjectWithTag("MainVideoPlayer").GetComponent<VideoPlayer>();
		GameUtility.npcInfoRoot = GameObject.FindGameObjectWithTag("NpcInfos").transform;
		GameUtility.gameLoader = LuminRuntimeInitializer.GameLoader;
		Camera camera = new GameObject("ZNormalVCamera").AddComponent<Camera>();
		camera.enabled = false;
		GameUtility.zNormalVCamera = camera;
		GameStart gameStart = Object.FindObjectOfType<GameStart>();
		if (gameStart != null && gameStart.selfCanvas != null)
		{
			gameStart.selfCanvas.renderMode = RenderMode.ScreenSpaceCamera;
			gameStart.selfCanvas.worldCamera = GameUtility.uiCamera;
			if (GameStart.EnterGameSpinInstance != null)
			{
				Canvas component = GameStart.EnterGameSpinInstance.GetComponent<Canvas>();
				if (component != null)
				{
					component.renderMode = RenderMode.ScreenSpaceCamera;
					component.worldCamera = GameUtility.uiCamera;
				}
			}
			if (gameStart.mainCamera != null)
			{
				gameStart.mainCamera.gameObject.SetActive(value: false);
			}
		}
		WaitInitializer.CompleteOne();
	}
}
