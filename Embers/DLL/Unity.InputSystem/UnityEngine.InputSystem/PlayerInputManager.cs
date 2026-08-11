using System;
using UnityEngine.Events;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Users;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/PlayerInputManager.html")]
[AddComponentMenu("Input/Player Input Manager")]
public class PlayerInputManager : MonoBehaviour
{
	[Serializable]
	public class PlayerJoinedEvent : UnityEvent<PlayerInput>
	{
	}

	[Serializable]
	public class PlayerLeftEvent : UnityEvent<PlayerInput>
	{
	}

	public const string PlayerJoinedMessage = "OnPlayerJoined";

	public const string PlayerLeftMessage = "OnPlayerLeft";

	[SerializeField]
	internal PlayerNotifications m_NotificationBehavior;

	[Tooltip("Set a limit for the maximum number of players who are able to join.")]
	[SerializeField]
	internal int m_MaxPlayerCount = -1;

	[SerializeField]
	internal bool m_AllowJoining = true;

	[SerializeField]
	internal PlayerJoinBehavior m_JoinBehavior;

	[SerializeField]
	internal PlayerJoinedEvent m_PlayerJoinedEvent;

	[SerializeField]
	internal PlayerLeftEvent m_PlayerLeftEvent;

	[SerializeField]
	internal InputActionProperty m_JoinAction;

	[SerializeField]
	internal GameObject m_PlayerPrefab;

	[SerializeField]
	internal bool m_SplitScreen;

	[SerializeField]
	internal bool m_MaintainAspectRatioInSplitScreen;

	[Tooltip("Explicitly set a fixed number of screens or otherwise allow the screen to be divided automatically to best fit the number of players.")]
	[SerializeField]
	internal int m_FixedNumberOfSplitScreens = -1;

	[SerializeField]
	internal Rect m_SplitScreenRect = new Rect(0f, 0f, 1f, 1f);

	[NonSerialized]
	private bool m_JoinActionDelegateHooked;

	[NonSerialized]
	private bool m_UnpairedDeviceUsedDelegateHooked;

	[NonSerialized]
	private Action<InputAction.CallbackContext> m_JoinActionDelegate;

	[NonSerialized]
	private Action<InputControl, InputEventPtr> m_UnpairedDeviceUsedDelegate;

	[NonSerialized]
	private CallbackArray<Action<PlayerInput>> m_PlayerJoinedCallbacks;

	[NonSerialized]
	private CallbackArray<Action<PlayerInput>> m_PlayerLeftCallbacks;

	public bool splitScreen
	{
		get
		{
			return m_SplitScreen;
		}
		set
		{
			if (m_SplitScreen == value)
			{
				return;
			}
			m_SplitScreen = value;
			if (!m_SplitScreen)
			{
				foreach (PlayerInput item in PlayerInput.all)
				{
					Camera camera = item.camera;
					if (camera != null)
					{
						camera.rect = new Rect(0f, 0f, 1f, 1f);
					}
				}
				return;
			}
			UpdateSplitScreen();
		}
	}

	public bool maintainAspectRatioInSplitScreen => m_MaintainAspectRatioInSplitScreen;

	public int fixedNumberOfSplitScreens => m_FixedNumberOfSplitScreens;

	public Rect splitScreenArea => m_SplitScreenRect;

	public int playerCount => PlayerInput.s_AllActivePlayersCount;

	public int maxPlayerCount => m_MaxPlayerCount;

	public bool joiningEnabled => m_AllowJoining;

	public PlayerJoinBehavior joinBehavior
	{
		get
		{
			return m_JoinBehavior;
		}
		set
		{
			if (m_JoinBehavior != value)
			{
				bool allowJoining = m_AllowJoining;
				if (allowJoining)
				{
					DisableJoining();
				}
				m_JoinBehavior = value;
				if (allowJoining)
				{
					EnableJoining();
				}
			}
		}
	}

	public InputActionProperty joinAction
	{
		get
		{
			return m_JoinAction;
		}
		set
		{
			if (m_JoinAction == value)
			{
				return;
			}
			int num;
			if (m_AllowJoining)
			{
				num = ((m_JoinBehavior == PlayerJoinBehavior.JoinPlayersWhenJoinActionIsTriggered) ? 1 : 0);
				if (num != 0)
				{
					DisableJoining();
				}
			}
			else
			{
				num = 0;
			}
			m_JoinAction = value;
			if (num != 0)
			{
				EnableJoining();
			}
		}
	}

	public PlayerNotifications notificationBehavior
	{
		get
		{
			return m_NotificationBehavior;
		}
		set
		{
			m_NotificationBehavior = value;
		}
	}

	public PlayerJoinedEvent playerJoinedEvent
	{
		get
		{
			if (m_PlayerJoinedEvent == null)
			{
				m_PlayerJoinedEvent = new PlayerJoinedEvent();
			}
			return m_PlayerJoinedEvent;
		}
	}

	public PlayerLeftEvent playerLeftEvent
	{
		get
		{
			if (m_PlayerLeftEvent == null)
			{
				m_PlayerLeftEvent = new PlayerLeftEvent();
			}
			return m_PlayerLeftEvent;
		}
	}

	public GameObject playerPrefab
	{
		get
		{
			return m_PlayerPrefab;
		}
		set
		{
			m_PlayerPrefab = value;
		}
	}

	public static PlayerInputManager instance { get; private set; }

	internal static string[] messages => new string[2] { "OnPlayerJoined", "OnPlayerLeft" };

	public event Action<PlayerInput> onPlayerJoined
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_PlayerJoinedCallbacks.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_PlayerJoinedCallbacks.RemoveCallback(value);
		}
	}

	public event Action<PlayerInput> onPlayerLeft
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_PlayerLeftCallbacks.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_PlayerLeftCallbacks.RemoveCallback(value);
		}
	}

	public void EnableJoining()
	{
		switch (m_JoinBehavior)
		{
		case PlayerJoinBehavior.JoinPlayersWhenButtonIsPressed:
			ValidateInputActionAsset();
			if (!m_UnpairedDeviceUsedDelegateHooked)
			{
				if (m_UnpairedDeviceUsedDelegate == null)
				{
					m_UnpairedDeviceUsedDelegate = OnUnpairedDeviceUsed;
				}
				InputUser.onUnpairedDeviceUsed += m_UnpairedDeviceUsedDelegate;
				m_UnpairedDeviceUsedDelegateHooked = true;
				InputUser.listenForUnpairedDeviceActivity++;
			}
			break;
		case PlayerJoinBehavior.JoinPlayersWhenJoinActionIsTriggered:
			if (m_JoinAction.action != null)
			{
				if (!m_JoinActionDelegateHooked)
				{
					if (m_JoinActionDelegate == null)
					{
						m_JoinActionDelegate = JoinPlayerFromActionIfNotAlreadyJoined;
					}
					m_JoinAction.action.performed += m_JoinActionDelegate;
					m_JoinActionDelegateHooked = true;
				}
				m_JoinAction.action.Enable();
			}
			else
			{
				Debug.LogError("No join action configured on PlayerInputManager but join behavior is set to JoinPlayersWhenJoinActionIsTriggered", this);
			}
			break;
		}
		m_AllowJoining = true;
	}

	public void DisableJoining()
	{
		switch (m_JoinBehavior)
		{
		case PlayerJoinBehavior.JoinPlayersWhenButtonIsPressed:
			if (m_UnpairedDeviceUsedDelegateHooked)
			{
				InputUser.onUnpairedDeviceUsed -= m_UnpairedDeviceUsedDelegate;
				m_UnpairedDeviceUsedDelegateHooked = false;
				InputUser.listenForUnpairedDeviceActivity--;
			}
			break;
		case PlayerJoinBehavior.JoinPlayersWhenJoinActionIsTriggered:
			if (m_JoinActionDelegateHooked)
			{
				if (m_JoinAction.action != null)
				{
					m_JoinAction.action.performed -= m_JoinActionDelegate;
				}
				m_JoinActionDelegateHooked = false;
			}
			m_JoinAction.action?.Disable();
			break;
		}
		m_AllowJoining = false;
	}

	internal void JoinPlayerFromUI()
	{
		if (!CheckIfPlayerCanJoin())
		{
			return;
		}
		throw new NotImplementedException();
	}

	public void JoinPlayerFromAction(InputAction.CallbackContext context)
	{
		if (CheckIfPlayerCanJoin())
		{
			InputDevice device = context.control.device;
			JoinPlayer(-1, -1, null, device);
		}
	}

	public void JoinPlayerFromActionIfNotAlreadyJoined(InputAction.CallbackContext context)
	{
		if (CheckIfPlayerCanJoin())
		{
			InputDevice device = context.control.device;
			if (!(PlayerInput.FindFirstPairedToDevice(device) != null))
			{
				JoinPlayer(-1, -1, null, device);
			}
		}
	}

	public PlayerInput JoinPlayer(int playerIndex = -1, int splitScreenIndex = -1, string controlScheme = null, InputDevice pairWithDevice = null)
	{
		if (!CheckIfPlayerCanJoin(playerIndex))
		{
			return null;
		}
		PlayerInput.s_DestroyIfDeviceSetupUnsuccessful = true;
		return PlayerInput.Instantiate(m_PlayerPrefab, playerIndex, controlScheme, splitScreenIndex, pairWithDevice);
	}

	public PlayerInput JoinPlayer(int playerIndex = -1, int splitScreenIndex = -1, string controlScheme = null, params InputDevice[] pairWithDevices)
	{
		if (!CheckIfPlayerCanJoin(playerIndex))
		{
			return null;
		}
		PlayerInput.s_DestroyIfDeviceSetupUnsuccessful = true;
		return PlayerInput.Instantiate(m_PlayerPrefab, playerIndex, controlScheme, splitScreenIndex, pairWithDevices);
	}

	private bool CheckIfPlayerCanJoin(int playerIndex = -1)
	{
		if (m_PlayerPrefab == null)
		{
			Debug.LogError("playerPrefab must be set in order to be able to join new players", this);
			return false;
		}
		if (m_MaxPlayerCount >= 0 && playerCount >= m_MaxPlayerCount)
		{
			Debug.LogError("Have reached maximum player count of " + maxPlayerCount, this);
			return false;
		}
		if (playerIndex != -1)
		{
			for (int i = 0; i < PlayerInput.s_AllActivePlayersCount; i++)
			{
				if (PlayerInput.s_AllActivePlayers[i].playerIndex == playerIndex)
				{
					Debug.LogError($"Player index #{playerIndex} is already taken by player {PlayerInput.s_AllActivePlayers[i]}", PlayerInput.s_AllActivePlayers[i]);
					return false;
				}
			}
		}
		return true;
	}

	private void OnUnpairedDeviceUsed(InputControl control, InputEventPtr eventPtr)
	{
		if (m_AllowJoining && m_JoinBehavior == PlayerJoinBehavior.JoinPlayersWhenButtonIsPressed && control is ButtonControl && IsDeviceUsableWithPlayerActions(control.device))
		{
			JoinPlayer(-1, -1, null, control.device);
		}
	}

	private void OnEnable()
	{
		if (instance == null)
		{
			instance = this;
			if (joinAction.reference != null && joinAction.action?.actionMap?.asset != null)
			{
				InputActionReference reference = InputActionReference.Create(Object.Instantiate(joinAction.action.actionMap.asset).FindAction(joinAction.action.name));
				joinAction = new InputActionProperty(reference);
			}
			for (int i = 0; i < PlayerInput.s_AllActivePlayersCount; i++)
			{
				NotifyPlayerJoined(PlayerInput.s_AllActivePlayers[i]);
			}
			if (m_AllowJoining)
			{
				EnableJoining();
			}
		}
		else
		{
			Debug.LogWarning("Multiple PlayerInputManagers in the game. There should only be one PlayerInputManager", this);
		}
	}

	private void OnDisable()
	{
		if (instance == this)
		{
			instance = null;
		}
		if (m_AllowJoining)
		{
			DisableJoining();
		}
	}

	private void UpdateSplitScreen()
	{
		if (!m_SplitScreen)
		{
			return;
		}
		int num = 0;
		foreach (PlayerInput item in PlayerInput.all)
		{
			if (item.playerIndex >= num)
			{
				num = item.playerIndex + 1;
			}
		}
		if (m_FixedNumberOfSplitScreens > 0)
		{
			if (m_FixedNumberOfSplitScreens < num)
			{
				Debug.LogWarning($"Highest playerIndex of {num} exceeds fixed number of split-screens of {m_FixedNumberOfSplitScreens}", this);
			}
			num = m_FixedNumberOfSplitScreens;
		}
		int num2 = Mathf.CeilToInt(Mathf.Sqrt(num));
		int num3 = num2;
		if (!m_MaintainAspectRatioInSplitScreen && num2 * (num2 - 1) >= num)
		{
			num3--;
		}
		foreach (PlayerInput item2 in PlayerInput.all)
		{
			int splitScreenIndex = item2.splitScreenIndex;
			if (splitScreenIndex >= num2 * num3)
			{
				Debug.LogError($"Split-screen index of {splitScreenIndex} on player is out of range (have {num2 * num3} screens); resetting to playerIndex", item2);
				item2.m_SplitScreenIndex = item2.playerIndex;
			}
			Camera camera = item2.camera;
			if (camera == null)
			{
				Debug.LogError("Player has no camera associated with it. Cannot set up split-screen. Point PlayerInput.camera to camera for player.", item2);
				continue;
			}
			int num4 = splitScreenIndex % num2;
			int num5 = splitScreenIndex / num2;
			Rect rect = new Rect
			{
				width = m_SplitScreenRect.width / (float)num2,
				height = m_SplitScreenRect.height / (float)num3
			};
			rect.x = m_SplitScreenRect.x + (float)num4 * rect.width;
			rect.y = m_SplitScreenRect.y + m_SplitScreenRect.height - (float)(num5 + 1) * rect.height;
			camera.rect = rect;
		}
	}

	private bool IsDeviceUsableWithPlayerActions(InputDevice device)
	{
		if (m_PlayerPrefab == null)
		{
			return true;
		}
		PlayerInput componentInChildren = m_PlayerPrefab.GetComponentInChildren<PlayerInput>();
		if (componentInChildren == null)
		{
			return true;
		}
		InputActionAsset actions = componentInChildren.actions;
		if (actions == null)
		{
			return true;
		}
		if (actions.controlSchemes.Count > 0)
		{
			using (InputControlList<InputDevice> devices = InputUser.GetUnpairedInputDevices())
			{
				if (!InputControlScheme.FindControlSchemeForDevices(devices, actions.controlSchemes, device).HasValue)
				{
					return false;
				}
			}
			return true;
		}
		foreach (InputActionMap actionMap in actions.actionMaps)
		{
			if (actionMap.IsUsableWithDevice(device))
			{
				return true;
			}
		}
		return false;
	}

	private void ValidateInputActionAsset()
	{
	}

	internal void NotifyPlayerJoined(PlayerInput player)
	{
		UpdateSplitScreen();
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.SendMessages:
			SendMessage("OnPlayerJoined", player, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.BroadcastMessages:
			BroadcastMessage("OnPlayerJoined", player, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.InvokeUnityEvents:
			m_PlayerJoinedEvent?.Invoke(player);
			break;
		case PlayerNotifications.InvokeCSharpEvents:
			DelegateHelpers.InvokeCallbacksSafe(ref m_PlayerJoinedCallbacks, player, "onPlayerJoined");
			break;
		}
	}

	internal void NotifyPlayerLeft(PlayerInput player)
	{
		UpdateSplitScreen();
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.SendMessages:
			SendMessage("OnPlayerLeft", player, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.BroadcastMessages:
			BroadcastMessage("OnPlayerLeft", player, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.InvokeUnityEvents:
			m_PlayerLeftEvent?.Invoke(player);
			break;
		case PlayerNotifications.InvokeCSharpEvents:
			DelegateHelpers.InvokeCallbacksSafe(ref m_PlayerLeftCallbacks, player, "onPlayerLeft");
			break;
		}
	}
}
