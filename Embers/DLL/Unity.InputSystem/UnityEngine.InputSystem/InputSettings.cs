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

	[SerializeField]
	[Tooltip("Determine which type of devices are used by the application. By default, this is empty meaning that all devices recognized by Unity will be used. Restricting the set of supported devices will make only those devices appear in the input system.")]
	private string[] m_SupportedDevices;

	[SerializeField]
	[Tooltip("Determine when Unity processes events. By default, accumulated input events are flushed out before each fixed update and before each dynamic update. This setting can be used to restrict event processing to only where the application needs it.")]
	private UpdateMode m_UpdateMode = UpdateMode.ProcessEventsInDynamicUpdate;

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

	internal static bool optimizedControlsFeatureEnabled;

	internal static bool readValueCachingFeatureEnabled;

	internal static bool paranoidReadValueCachingChecksEnabled;

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
		switch (featureName)
		{
		case "USE_OPTIMIZED_CONTROLS":
			optimizedControlsFeatureEnabled = enabled;
			break;
		case "USE_READ_VALUE_CACHING":
			readValueCachingFeatureEnabled = enabled;
			break;
		case "PARANOID_READ_VALUE_CACHING_CHECKS":
			paranoidReadValueCachingChecksEnabled = enabled;
			break;
		default:
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
			break;
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
}
