using System;
using System.Collections.Generic;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public class InputSettings : ScriptableObject
{
	public enum UpdateMode
	{
		ProcessEventsInDynamicUpdate = 1,
		ProcessEventsInFixedUpdate,
		ProcessEventsManually
	}

	public enum ScrollDeltaBehavior
	{
		UniformAcrossAllPlatforms,
		KeepPlatformSpecificInputRange
	}

	public enum BackgroundBehavior
	{
		ResetAndDisableNonBackgroundDevices,
		ResetAndDisableAllDevices,
		IgnoreFocus
	}

	public enum EditorInputBehaviorInPlayMode
	{
		PointersAndKeyboardsRespectGameViewFocus,
		AllDevicesRespectGameViewFocus,
		AllDeviceInputAlwaysGoesToGameView
	}

	public enum InputActionPropertyDrawerMode
	{
		Compact,
		MultilineEffective,
		MultilineBoth
	}

	[Tooltip("Determine which type of devices are used by the application. By default, this is empty meaning that all devices recognized by Unity will be used. Restricting the set of supported devices will make only those devices appear in the input system.")]
	[SerializeField]
	private string[] m_SupportedDevices;

	[SerializeField]
	[Tooltip("Determine when Unity processes events. By default, accumulated input events are flushed out before each fixed update and before each dynamic update. This setting can be used to restrict event processing to only where the application needs it.")]
	private UpdateMode m_UpdateMode = UpdateMode.ProcessEventsInDynamicUpdate;

	[SerializeField]
	private ScrollDeltaBehavior m_ScrollDeltaBehavior;

	[SerializeField]
	private int m_MaxEventBytesPerUpdate = 5242880;

	[SerializeField]
	private int m_MaxQueuedEventsPerUpdate = 1000;

	[SerializeField]
	private bool m_CompensateForScreenOrientation = true;

	[SerializeField]
	private BackgroundBehavior m_BackgroundBehavior;

	[SerializeField]
	private EditorInputBehaviorInPlayMode m_EditorInputBehaviorInPlayMode;

	[SerializeField]
	private InputActionPropertyDrawerMode m_InputActionPropertyDrawerMode;

	[SerializeField]
	private float m_DefaultDeadzoneMin = 0.125f;

	[SerializeField]
	private float m_DefaultDeadzoneMax = 0.925f;

	[SerializeField]
	[Min(0.0001f)]
	private float m_DefaultButtonPressPoint = 0.5f;

	[SerializeField]
	private float m_ButtonReleaseThreshold = 0.75f;

	[SerializeField]
	private float m_DefaultTapTime = 0.2f;

	[SerializeField]
	private float m_DefaultSlowTapTime = 0.5f;

	[SerializeField]
	private float m_DefaultHoldTime = 0.4f;

	[SerializeField]
	private float m_TapRadius = 5f;

	[SerializeField]
	private float m_MultiTapDelayTime = 0.75f;

	[SerializeField]
	private bool m_DisableRedundantEventsMerging;

	[SerializeField]
	private bool m_ShortcutKeysConsumeInputs;

	[NonSerialized]
	internal HashSet<string> m_FeatureFlags;

	internal const int s_OldUnsupportedFixedAndDynamicUpdateSetting = 0;

	public UpdateMode updateMode
	{
		get
		{
			return m_UpdateMode;
		}
		set
		{
			if (m_UpdateMode != value)
			{
				m_UpdateMode = value;
				OnChange();
			}
		}
	}

	public ScrollDeltaBehavior scrollDeltaBehavior
	{
		get
		{
			return m_ScrollDeltaBehavior;
		}
		set
		{
			if (m_ScrollDeltaBehavior != value)
			{
				m_ScrollDeltaBehavior = value;
				OnChange();
			}
		}
	}

	public bool compensateForScreenOrientation
	{
		get
		{
			return m_CompensateForScreenOrientation;
		}
		set
		{
			if (m_CompensateForScreenOrientation != value)
			{
				m_CompensateForScreenOrientation = value;
				OnChange();
			}
		}
	}

	[Obsolete("filterNoiseOnCurrent is deprecated, filtering of noise is always enabled now.", false)]
	public bool filterNoiseOnCurrent
	{
		get
		{
			return false;
		}
		set
		{
		}
	}

	public float defaultDeadzoneMin
	{
		get
		{
			return m_DefaultDeadzoneMin;
		}
		set
		{
			if (m_DefaultDeadzoneMin != value)
			{
				m_DefaultDeadzoneMin = value;
				OnChange();
			}
		}
	}

	public float defaultDeadzoneMax
	{
		get
		{
			return m_DefaultDeadzoneMax;
		}
		set
		{
			if (m_DefaultDeadzoneMax != value)
			{
				m_DefaultDeadzoneMax = value;
				OnChange();
			}
		}
	}

	public float defaultButtonPressPoint
	{
		get
		{
			return m_DefaultButtonPressPoint;
		}
		set
		{
			if (m_DefaultButtonPressPoint != value)
			{
				m_DefaultButtonPressPoint = Mathf.Clamp(value, 0.0001f, float.MaxValue);
				OnChange();
			}
		}
	}

	public float buttonReleaseThreshold
	{
		get
		{
			return m_ButtonReleaseThreshold;
		}
		set
		{
			if (m_ButtonReleaseThreshold != value)
			{
				m_ButtonReleaseThreshold = value;
				OnChange();
			}
		}
	}

	public float defaultTapTime
	{
		get
		{
			return m_DefaultTapTime;
		}
		set
		{
			if (m_DefaultTapTime != value)
			{
				m_DefaultTapTime = value;
				OnChange();
			}
		}
	}

	public float defaultSlowTapTime
	{
		get
		{
			return m_DefaultSlowTapTime;
		}
		set
		{
			if (m_DefaultSlowTapTime != value)
			{
				m_DefaultSlowTapTime = value;
				OnChange();
			}
		}
	}

	public float defaultHoldTime
	{
		get
		{
			return m_DefaultHoldTime;
		}
		set
		{
			if (m_DefaultHoldTime != value)
			{
				m_DefaultHoldTime = value;
				OnChange();
			}
		}
	}

	public float tapRadius
	{
		get
		{
			return m_TapRadius;
		}
		set
		{
			if (m_TapRadius != value)
			{
				m_TapRadius = value;
				OnChange();
			}
		}
	}

	public float multiTapDelayTime
	{
		get
		{
			return m_MultiTapDelayTime;
		}
		set
		{
			if (m_MultiTapDelayTime != value)
			{
				m_MultiTapDelayTime = value;
				OnChange();
			}
		}
	}

	public BackgroundBehavior backgroundBehavior
	{
		get
		{
			return m_BackgroundBehavior;
		}
		set
		{
			if (m_BackgroundBehavior != value)
			{
				m_BackgroundBehavior = value;
				OnChange();
			}
		}
	}

	public EditorInputBehaviorInPlayMode editorInputBehaviorInPlayMode
	{
		get
		{
			return m_EditorInputBehaviorInPlayMode;
		}
		set
		{
			if (m_EditorInputBehaviorInPlayMode != value)
			{
				m_EditorInputBehaviorInPlayMode = value;
				OnChange();
			}
		}
	}

	public InputActionPropertyDrawerMode inputActionPropertyDrawerMode
	{
		get
		{
			return m_InputActionPropertyDrawerMode;
		}
		set
		{
			if (m_InputActionPropertyDrawerMode != value)
			{
				m_InputActionPropertyDrawerMode = value;
				OnChange();
			}
		}
	}

	public int maxEventBytesPerUpdate
	{
		get
		{
			return m_MaxEventBytesPerUpdate;
		}
		set
		{
			if (m_MaxEventBytesPerUpdate != value)
			{
				m_MaxEventBytesPerUpdate = value;
				OnChange();
			}
		}
	}

	public int maxQueuedEventsPerUpdate
	{
		get
		{
			return m_MaxQueuedEventsPerUpdate;
		}
		set
		{
			if (m_MaxQueuedEventsPerUpdate != value)
			{
				m_MaxQueuedEventsPerUpdate = value;
				OnChange();
			}
		}
	}

	public ReadOnlyArray<string> supportedDevices
	{
		get
		{
			return new ReadOnlyArray<string>(m_SupportedDevices);
		}
		set
		{
			if (supportedDevices.Count == value.Count)
			{
				bool flag = false;
				for (int i = 0; i < supportedDevices.Count; i++)
				{
					if (m_SupportedDevices[i] != value[i])
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					return;
				}
			}
			m_SupportedDevices = value.ToArray();
			OnChange();
		}
	}

	public bool disableRedundantEventsMerging
	{
		get
		{
			return m_DisableRedundantEventsMerging;
		}
		set
		{
			if (m_DisableRedundantEventsMerging != value)
			{
				m_DisableRedundantEventsMerging = value;
				OnChange();
			}
		}
	}

	public bool shortcutKeysConsumeInput
	{
		get
		{
			return m_ShortcutKeysConsumeInputs;
		}
		set
		{
			if (m_ShortcutKeysConsumeInputs != value)
			{
				m_ShortcutKeysConsumeInputs = value;
				OnChange();
			}
		}
	}

	public void SetInternalFeatureFlag(string featureName, bool enabled)
	{
		if (string.IsNullOrEmpty(featureName))
		{
			throw new ArgumentNullException("featureName");
		}
		if (m_FeatureFlags == null)
		{
			m_FeatureFlags = new HashSet<string>();
		}
		if (enabled)
		{
			m_FeatureFlags.Add(featureName.ToUpperInvariant());
		}
		else
		{
			m_FeatureFlags.Remove(featureName.ToUpperInvariant());
		}
		OnChange();
	}

	internal bool IsFeatureEnabled(string featureName)
	{
		if (m_FeatureFlags != null)
		{
			return m_FeatureFlags.Contains(featureName.ToUpperInvariant());
		}
		return false;
	}

	internal void OnChange()
	{
		if (InputSystem.settings == this)
		{
			InputSystem.s_Manager.ApplySettings();
		}
	}

	private static bool CompareFloats(float a, float b)
	{
		return a - b <= float.Epsilon;
	}

	private static bool CompareSets<T>(ReadOnlyArray<T> a, ReadOnlyArray<T> b)
	{
		if ((object)a == null)
		{
			return (object)b == null;
		}
		if ((object)b == null)
		{
			return false;
		}
		for (int i = 0; i < a.Count; i++)
		{
			bool flag = false;
			for (int j = 0; j < b.Count; j++)
			{
				if (a[i].Equals(b[j]))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	private static bool CompareFeatureFlag(InputSettings a, InputSettings b, string featureName)
	{
		return a.IsFeatureEnabled(featureName) == b.IsFeatureEnabled(featureName);
	}

	internal static bool AreEqual(InputSettings a, InputSettings b)
	{
		if ((object)a == null)
		{
			return (object)b == null;
		}
		if ((object)b == null)
		{
			return false;
		}
		if ((object)a == b)
		{
			return true;
		}
		if (a.updateMode == b.updateMode && a.compensateForScreenOrientation == b.compensateForScreenOrientation && CompareFloats(a.defaultDeadzoneMin, b.defaultDeadzoneMin) && CompareFloats(a.defaultDeadzoneMax, b.defaultDeadzoneMax) && CompareFloats(a.defaultButtonPressPoint, b.defaultButtonPressPoint) && CompareFloats(a.buttonReleaseThreshold, b.buttonReleaseThreshold) && CompareFloats(a.defaultTapTime, b.defaultTapTime) && CompareFloats(a.defaultSlowTapTime, b.defaultSlowTapTime) && CompareFloats(a.defaultHoldTime, b.defaultHoldTime) && CompareFloats(a.tapRadius, b.tapRadius) && CompareFloats(a.multiTapDelayTime, b.multiTapDelayTime) && a.backgroundBehavior == b.backgroundBehavior && a.editorInputBehaviorInPlayMode == b.editorInputBehaviorInPlayMode && a.inputActionPropertyDrawerMode == b.inputActionPropertyDrawerMode && a.maxEventBytesPerUpdate == b.maxEventBytesPerUpdate && a.maxQueuedEventsPerUpdate == b.maxQueuedEventsPerUpdate && CompareSets(a.supportedDevices, b.supportedDevices) && a.disableRedundantEventsMerging == b.disableRedundantEventsMerging && a.shortcutKeysConsumeInput == b.shortcutKeysConsumeInput && CompareFeatureFlag(a, b, "USE_OPTIMIZED_CONTROLS") && CompareFeatureFlag(a, b, "USE_READ_VALUE_CACHING") && CompareFeatureFlag(a, b, "PARANOID_READ_VALUE_CACHING_CHECKS") && CompareFeatureFlag(a, b, "DISABLE_UNITY_REMOTE_SUPPORT") && CompareFeatureFlag(a, b, "RUN_PLAYER_UPDATES_IN_EDIT_MODE"))
		{
			return CompareFeatureFlag(a, b, "USE_IMGUI_EDITOR_FOR_ASSETS");
		}
		return false;
	}
}
