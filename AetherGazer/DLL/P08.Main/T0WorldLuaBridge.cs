using System;
using T0World;

public static class T0WorldLuaBridge
{
	[Serializable]
	public class T0SubtitleData
	{
		private bool m_show;

		public int formID;

		public string file;

		public bool wait { get; set; }

		public bool show
		{
			get
			{
				if (!wait)
				{
					return m_show;
				}
				return false;
			}
			set
			{
				m_show = value;
			}
		}

		public virtual bool IsWaiting()
		{
			return wait;
		}

		public virtual bool IsShow()
		{
			return show;
		}

		public virtual void OnEndDisplay()
		{
		}

		public virtual void OnDispose()
		{
		}

		public virtual string GetKey()
		{
			if (!LuaHelper.IsLuaClientInited())
			{
				return "";
			}
			return LuaHelper.GetFunc("T0SubtitleData.GetKey").Invoke<T0SubtitleData, string>(this);
		}

		public virtual string GetContent()
		{
			if (!LuaHelper.IsLuaClientInited())
			{
				return "";
			}
			return LuaHelper.GetFunc("T0SubtitleData.GetContent").Invoke<T0SubtitleData, string>(this);
		}
	}

	public static int loadingCharacterID;

	public static void Launcher(string sceneName, int characterID, int sceneID, bool todayFirstEnter)
	{
		loadingCharacterID = characterID;
		T0WorldScene t0WorldScene = NScene.Load<T0WorldScene>();
		t0WorldScene.t0SceneName = sceneName;
		t0WorldScene.characterID = characterID;
		t0WorldScene.t0SceneID = sceneID;
		t0WorldScene.todayFirstEnter = todayFirstEnter;
	}

	public static void EnterChapterMode(bool isEnter = true)
	{
		if (isEnter)
		{
			T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.ENTER_CAPTURE);
			T0WorldScene.Scene.captureManager.EnterCaptureMode();
		}
		else
		{
			LuaHelper.CallFunction("RecordT0WorldCaptureSDK", 2);
			T0WorldScene.Scene.captureManager.ExitCaptureMode();
		}
	}

	public static void ChangeCapturePose(int filterType, string poseName)
	{
		if (T0WorldScene.Scene.captureManager != null)
		{
			T0WorldScene.Scene.captureManager.ChangeCapturePose(filterType, poseName);
		}
	}

	public static void ChangeCaptureScene(int locationID)
	{
		if (T0WorldScene.Scene.captureManager != null)
		{
			T0WorldScene.Scene.captureManager.ChangeCaptureScene(locationID);
		}
	}

	public static bool CheckIsHaveExitEventAndDo()
	{
		if (T0WorldScene.Scene.dataContext.ExitRegisteEvent != null)
		{
			T0InterationBaseData exitRegisteEvent = T0WorldScene.Scene.dataContext.ExitRegisteEvent;
			T0WorldScene.Scene.interactionManager.TriggerTargetInteraction(exitRegisteEvent.treeID, exitRegisteEvent.nodeID);
			exitRegisteEvent.IsFinish = true;
			return true;
		}
		return false;
	}
}
