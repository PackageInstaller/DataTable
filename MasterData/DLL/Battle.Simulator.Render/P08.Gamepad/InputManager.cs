using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

public class InputManager : MonoBehaviour
{
	private class InputManagerSingleton
	{
		public static InputManager manager = Create();

		public static InputManager Create()
		{
			GameObject gameObject = new GameObject("InputManager");
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
			InputSettings settings = new InputSettings();
			InputManager inputManager = (manager = gameObject.AddComponent<InputManager>());
			inputManager._settings = settings;
			try
			{
				inputManager._system = CreateInputSystem(settings);
				inputManager._bottomBar = CreateBottomBar(settings);
				inputManager._iconBindings = LoadBindingIconAsset(settings);
				inputManager._groupList = LoadControlGroup(settings);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
			return inputManager;
		}

		private static InputActionSystem CreateInputSystem(InputSettings settings)
		{
			InputActionSystem inputActionSystem = new InputActionSystem();
			PageInputActionRes pageInputActionRes = Asset.Load<PageInputActionRes>(settings.pathGlobalPage, isDontDestroy: true);
			if (pageInputActionRes != null)
			{
				foreach (InputActionRes inputAction in pageInputActionRes.inputActions)
				{
					if (inputAction.ShowInBottomBar)
					{
						Debug.LogError("InputManager: global page could not show action in bottom bar!");
						inputAction.ShowInBottomBar = false;
					}
				}
				PageInputActionMap page = inputActionSystem.CreatePageInputActionMap(pageInputActionRes);
				inputActionSystem.EnablePage(page);
			}
			else
			{
				Debug.LogWarning("InputManager: could not load global page!");
			}
			return inputActionSystem;
		}

		private static HIDBottomNoticeBar CreateBottomBar(InputSettings settings)
		{
			GameObject gameObject = GameObject.Find("UICamera_DontDestroy/Canvas");
			if (gameObject == null)
			{
				Debug.LogWarning("InputManager: could not find UICamera_DontDestroy/Canvas for BottomBar!");
				return null;
			}
			Transform transform = gameObject.transform;
			GameObject gameObject2 = Asset.InstantiateWithoutCache(settings.pathBottomBar, transform, worldPositionStays: false, dontDestroy: true);
			if (gameObject2 == null)
			{
				Debug.LogWarning("InputManager: could not load BottomBar!");
				return null;
			}
			return gameObject2.GetComponent<HIDBottomNoticeBar>();
		}

		private static InputBindingIconAsset LoadBindingIconAsset(InputSettings settings)
		{
			InputBindingIconAsset inputBindingIconAsset = Asset.Load<InputBindingIconAsset>(settings.pathBindingIconAsset, isDontDestroy: true);
			if (inputBindingIconAsset == null)
			{
				Debug.LogError("InputManager: could not load InputBindingIconAsset! create empty asset.");
				inputBindingIconAsset = new InputBindingIconAsset();
				inputBindingIconAsset.bindings = new List<InputBindingIconAsset.BindingIcon>();
			}
			inputBindingIconAsset?.Init();
			return inputBindingIconAsset;
		}

		private static ControlGroupList LoadControlGroup(InputSettings settings)
		{
			ControlGroupRes controlGroupRes = Asset.Load<ControlGroupRes>(settings.pathControlGroupAsset, isDontDestroy: true);
			if (controlGroupRes == null)
			{
				Debug.LogWarning("InputManager: could not load control group!");
				return null;
			}
			return new ControlGroupList(controlGroupRes);
		}
	}

	private InputActionSystem _system;

	private HIDBottomNoticeBar _bottomBar;

	private InputSettings _settings;

	private InputBindingIconAsset _iconBindings;

	private ControlGroupList _groupList;

	public static InputManager instance => InputManagerSingleton.manager;

	public static InputActionSystem system => instance._system;

	public static HIDBottomNoticeBar bottomBar => instance._bottomBar;

	public static InputSettings settings => instance._settings;

	public static InputBindingIconAsset iconBindings => instance._iconBindings;

	public static List<ControlGroup> controlGroups => instance._groupList.groups;

	private void Awake()
	{
	}

	private void Update()
	{
		system.Tick();
	}
}
