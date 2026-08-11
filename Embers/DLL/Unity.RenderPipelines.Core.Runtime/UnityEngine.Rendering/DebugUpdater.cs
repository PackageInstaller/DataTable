using System;
using System.Collections;
using System.Reflection;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.EnhancedTouch;
using UnityEngine.InputSystem.UI;

namespace UnityEngine.Rendering;

internal class DebugUpdater : MonoBehaviour
{
	private static DebugUpdater s_Instance;

	private ScreenOrientation m_Orientation;

	private bool m_RuntimeUiWasVisibleLastFrame;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
	private static void RuntimeInit()
	{
	}

	internal static void SetEnabled(bool enabled)
	{
		if (enabled)
		{
			EnableRuntime();
		}
		else
		{
			DisableRuntime();
		}
	}

	private static void EnableRuntime()
	{
		if (!(s_Instance != null))
		{
			GameObject obj = new GameObject
			{
				name = "[Debug Updater]"
			};
			s_Instance = obj.AddComponent<DebugUpdater>();
			s_Instance.m_Orientation = Screen.orientation;
			Object.DontDestroyOnLoad(obj);
			DebugManager.instance.EnableInputActions();
			EnhancedTouchSupport.Enable();
		}
	}

	private static void DisableRuntime()
	{
		DebugManager instance = DebugManager.instance;
		instance.displayRuntimeUI = false;
		instance.displayPersistentRuntimeUI = false;
		if (s_Instance != null)
		{
			CoreUtils.Destroy(s_Instance.gameObject);
			s_Instance = null;
		}
	}

	internal static void HandleInternalEventSystemComponents(bool uiEnabled)
	{
		if (!(s_Instance == null))
		{
			if (uiEnabled)
			{
				s_Instance.EnsureExactlyOneEventSystem();
			}
			else
			{
				s_Instance.DestroyDebugEventSystem();
			}
		}
	}

	private void EnsureExactlyOneEventSystem()
	{
		EventSystem[] array = Object.FindObjectsOfType<EventSystem>();
		EventSystem component = GetComponent<EventSystem>();
		if (array.Length > 1 && component != null)
		{
			Debug.Log("More than one EventSystem detected in scene. Destroying EventSystem owned by DebugUpdater.");
			DestroyDebugEventSystem();
		}
		else if (array.Length == 0)
		{
			Debug.Log("No EventSystem available. Creating a new EventSystem to enable Rendering Debugger runtime UI.");
			CreateDebugEventSystem();
		}
		else
		{
			StartCoroutine(DoAfterInputModuleUpdated(CheckInputModuleExists));
		}
	}

	private IEnumerator DoAfterInputModuleUpdated(Action action)
	{
		yield return new WaitForEndOfFrame();
		yield return new WaitForEndOfFrame();
		action();
	}

	private void CheckInputModuleExists()
	{
		if (EventSystem.current != null && EventSystem.current.currentInputModule == null)
		{
			Debug.LogWarning("Found a game object with EventSystem component but no corresponding BaseInputModule component - Debug UI input might not work correctly.");
		}
	}

	private void AssignDefaultActions()
	{
		if (EventSystem.current != null && EventSystem.current.currentInputModule is InputSystemUIInputModule inputSystemUIInputModule)
		{
			MethodInfo method = inputSystemUIInputModule.GetType().GetMethod("AssignDefaultActions");
			if (method != null)
			{
				method.Invoke(inputSystemUIInputModule, null);
			}
		}
		CheckInputModuleExists();
	}

	private void CreateDebugEventSystem()
	{
		base.gameObject.AddComponent<EventSystem>();
		base.gameObject.AddComponent<InputSystemUIInputModule>();
		StartCoroutine(DoAfterInputModuleUpdated(AssignDefaultActions));
	}

	private void DestroyDebugEventSystem()
	{
		EventSystem component = GetComponent<EventSystem>();
		InputSystemUIInputModule component2 = GetComponent<InputSystemUIInputModule>();
		if ((bool)component2)
		{
			CoreUtils.Destroy(component2);
			StartCoroutine(DoAfterInputModuleUpdated(AssignDefaultActions));
		}
		CoreUtils.Destroy(component);
	}

	private void Update()
	{
		DebugManager instance = DebugManager.instance;
		if (m_RuntimeUiWasVisibleLastFrame != instance.displayRuntimeUI)
		{
			HandleInternalEventSystemComponents(instance.displayRuntimeUI);
		}
		instance.UpdateActions();
		if (instance.GetAction(DebugAction.EnableDebugMenu) != 0f || instance.GetActionToggleDebugMenuWithTouch())
		{
			instance.displayRuntimeUI = !instance.displayRuntimeUI;
		}
		if (instance.displayRuntimeUI)
		{
			if (instance.GetAction(DebugAction.ResetAll) != 0f)
			{
				instance.Reset();
			}
			if (instance.GetActionReleaseScrollTarget())
			{
				instance.SetScrollTarget(null);
			}
		}
		if (m_Orientation != Screen.orientation)
		{
			StartCoroutine(RefreshRuntimeUINextFrame());
			m_Orientation = Screen.orientation;
		}
		m_RuntimeUiWasVisibleLastFrame = instance.displayRuntimeUI;
	}

	private static IEnumerator RefreshRuntimeUINextFrame()
	{
		yield return null;
		DebugManager.instance.ReDrawOnScreenDebug();
	}
}
