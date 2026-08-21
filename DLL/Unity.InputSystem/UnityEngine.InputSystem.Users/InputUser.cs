using System;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Users;

public struct InputUser : IEquatable<InputUser>
{
	public struct ControlSchemeChangeSyntax
	{
		internal int m_UserIndex;

		public ControlSchemeChangeSyntax AndPairRemainingDevices()
		{
			UpdateControlSchemeMatch(m_UserIndex, autoPairMissing: true);
			return this;
		}
	}

	[Flags]
	internal enum UserFlags
	{
		BindToAllDevices = 1,
		UserAccountSelectionInProgress = 2
	}

	private struct UserData
	{
		public InputUserAccountHandle? platformUserAccountHandle;

		public string platformUserAccountName;

		public string platformUserAccountId;

		public int deviceCount;

		public int deviceStartIndex;

		public IInputActionCollection actions;

		public InputControlScheme? controlScheme;

		public InputControlScheme.MatchResult controlSchemeMatch;

		public int lostDeviceCount;

		public int lostDeviceStartIndex;

		public UserFlags flags;
	}

	private struct CompareDevicesByUserAccount : IComparer<InputDevice>
	{
		public InputUserAccountHandle platformUserAccountHandle;

		public int Compare(InputDevice x, InputDevice y)
		{
			InputUserAccountHandle? userAccountHandleForDevice = GetUserAccountHandleForDevice(x);
			InputUserAccountHandle? userAccountHandleForDevice2 = GetUserAccountHandleForDevice(x);
			InputUserAccountHandle? inputUserAccountHandle = userAccountHandleForDevice;
			InputUserAccountHandle inputUserAccountHandle2 = platformUserAccountHandle;
			if (inputUserAccountHandle.HasValue && (!inputUserAccountHandle.HasValue || inputUserAccountHandle.GetValueOrDefault() == inputUserAccountHandle2) && userAccountHandleForDevice2 == platformUserAccountHandle)
			{
				return 0;
			}
			if (userAccountHandleForDevice == platformUserAccountHandle)
			{
				return -1;
			}
			if (userAccountHandleForDevice2 == platformUserAccountHandle)
			{
				return 1;
			}
			return 0;
		}

		private static InputUserAccountHandle? GetUserAccountHandleForDevice(InputDevice device)
		{
			return null;
		}
	}

	private struct OngoingAccountSelection
	{
		public InputDevice device;

		public uint userId;
	}

	private struct GlobalState
	{
		internal int pairingStateVersion;

		internal uint lastUserId;

		internal int allUserCount;

		internal int allPairedDeviceCount;

		internal int allLostDeviceCount;

		internal InputUser[] allUsers;

		internal UserData[] allUserData;

		internal InputDevice[] allPairedDevices;

		internal InputDevice[] allLostDevices;

		internal InlinedArray<OngoingAccountSelection> ongoingAccountSelections;

		internal CallbackArray<Action<InputUser, InputUserChange, InputDevice>> onChange;

		internal CallbackArray<Action<InputControl, InputEventPtr>> onUnpairedDeviceUsed;

		internal CallbackArray<Func<InputDevice, InputEventPtr, bool>> onPreFilterUnpairedDeviceUsed;

		internal Action<object, InputActionChange> actionChangeDelegate;

		internal Action<InputDevice, InputDeviceChange> onDeviceChangeDelegate;

		internal Action<InputEventPtr, InputDevice> onEventDelegate;

		internal bool onActionChangeHooked;

		internal bool onDeviceChangeHooked;

		internal bool onEventHooked;

		internal int listenForUnpairedDeviceActivity;
	}

	public const uint InvalidId = 0u;

	private uint m_Id;

	private static GlobalState s_GlobalState;

	public bool valid
	{
		get
		{
			if (m_Id == 0)
			{
				return false;
			}
			for (int i = 0; i < s_GlobalState.allUserCount; i++)
			{
				if (s_GlobalState.allUsers[i].m_Id == m_Id)
				{
					return true;
				}
			}
			return false;
		}
	}

	public int index
	{
		get
		{
			if (m_Id == 0)
			{
				throw new InvalidOperationException("Invalid user");
			}
			int num = TryFindUserIndex(m_Id);
			if (num == -1)
			{
				throw new InvalidOperationException($"User with ID {m_Id} is no longer valid");
			}
			return num;
		}
	}

	public uint id => m_Id;

	public InputUserAccountHandle? platformUserAccountHandle => s_GlobalState.allUserData[index].platformUserAccountHandle;

	public string platformUserAccountName => s_GlobalState.allUserData[index].platformUserAccountName;

	public string platformUserAccountId => s_GlobalState.allUserData[index].platformUserAccountId;

	public ReadOnlyArray<InputDevice> pairedDevices
	{
		get
		{
			int num = index;
			return new ReadOnlyArray<InputDevice>(s_GlobalState.allPairedDevices, s_GlobalState.allUserData[num].deviceStartIndex, s_GlobalState.allUserData[num].deviceCount);
		}
	}

	public ReadOnlyArray<InputDevice> lostDevices
	{
		get
		{
			int num = index;
			return new ReadOnlyArray<InputDevice>(s_GlobalState.allLostDevices, s_GlobalState.allUserData[num].lostDeviceStartIndex, s_GlobalState.allUserData[num].lostDeviceCount);
		}
	}

	public IInputActionCollection actions => s_GlobalState.allUserData[index].actions;

	public InputControlScheme? controlScheme => s_GlobalState.allUserData[index].controlScheme;

	public InputControlScheme.MatchResult controlSchemeMatch => s_GlobalState.allUserData[index].controlSchemeMatch;

	public bool hasMissingRequiredDevices => s_GlobalState.allUserData[index].controlSchemeMatch.hasMissingRequiredDevices;

	public static ReadOnlyArray<InputUser> all => new ReadOnlyArray<InputUser>(s_GlobalState.allUsers, 0, s_GlobalState.allUserCount);

	public static int listenForUnpairedDeviceActivity
	{
		get
		{
			return s_GlobalState.listenForUnpairedDeviceActivity;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", "Cannot be negative");
			}
			if (value > 0 && s_GlobalState.onUnpairedDeviceUsed.length > 0)
			{
				HookIntoEvents();
			}
			else if (value == 0)
			{
				UnhookFromDeviceStateChange();
			}
			s_GlobalState.listenForUnpairedDeviceActivity = value;
		}
	}

	public static event Action<InputUser, InputUserChange, InputDevice> onChange
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onChange.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onChange.RemoveCallback(value);
		}
	}

	public static event Action<InputControl, InputEventPtr> onUnpairedDeviceUsed
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onUnpairedDeviceUsed.AddCallback(value);
			if (s_GlobalState.listenForUnpairedDeviceActivity > 0)
			{
				HookIntoEvents();
			}
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onUnpairedDeviceUsed.RemoveCallback(value);
			if (s_GlobalState.onUnpairedDeviceUsed.length == 0)
			{
				UnhookFromDeviceStateChange();
			}
		}
	}

	public static event Func<InputDevice, InputEventPtr, bool> onPrefilterUnpairedDeviceActivity
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onPreFilterUnpairedDeviceUsed.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onPreFilterUnpairedDeviceUsed.RemoveCallback(value);
		}
	}

	public override string ToString()
	{
		if (!valid)
		{
			return $"<Invalid> (id: {m_Id})";
		}
		string text = string.Join(",", pairedDevices);
		return $"User #{index} (id: {m_Id}, devices: {text}, actions: {actions})";
	}

	public void AssociateActionsWithUser(IInputActionCollection actions)
	{
		int num = index;
		if (s_GlobalState.allUserData[num].actions == actions)
		{
			return;
		}
		IInputActionCollection inputActionCollection = s_GlobalState.allUserData[num].actions;
		if (inputActionCollection != null)
		{
			inputActionCollection.devices = null;
			inputActionCollection.bindingMask = null;
		}
		s_GlobalState.allUserData[num].actions = actions;
		if (actions != null)
		{
			HookIntoActionChange();
			actions.devices = pairedDevices;
			if (s_GlobalState.allUserData[num].controlScheme.HasValue)
			{
				ActivateControlSchemeInternal(num, s_GlobalState.allUserData[num].controlScheme.Value);
			}
		}
	}

	public ControlSchemeChangeSyntax ActivateControlScheme(string schemeName)
	{
		if (!string.IsNullOrEmpty(schemeName))
		{
			FindControlScheme(schemeName, out var scheme);
			return ActivateControlScheme(scheme);
		}
		return ActivateControlScheme(default(InputControlScheme));
	}

	private bool TryFindControlScheme(string schemeName, out InputControlScheme scheme)
	{
		if (string.IsNullOrEmpty(schemeName))
		{
			scheme = default(InputControlScheme);
			return false;
		}
		if (s_GlobalState.allUserData[index].actions == null)
		{
			throw new InvalidOperationException($"Cannot set control scheme '{schemeName}' by name on user #{index} as not actions have been associated with the user yet (AssociateActionsWithUser)");
		}
		ReadOnlyArray<InputControlScheme> controlSchemes = s_GlobalState.allUserData[index].actions.controlSchemes;
		for (int i = 0; i < controlSchemes.Count; i++)
		{
			if (string.Compare(controlSchemes[i].name, schemeName, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				scheme = controlSchemes[i];
				return true;
			}
		}
		scheme = default(InputControlScheme);
		return false;
	}

	internal void FindControlScheme(string schemeName, out InputControlScheme scheme)
	{
		if (TryFindControlScheme(schemeName, out scheme))
		{
			return;
		}
		throw new ArgumentException($"Cannot find control scheme '{schemeName}' in actions '{s_GlobalState.allUserData[index].actions}'");
	}

	public ControlSchemeChangeSyntax ActivateControlScheme(InputControlScheme scheme)
	{
		int num = index;
		InputControlScheme? inputControlScheme = s_GlobalState.allUserData[num].controlScheme;
		InputControlScheme inputControlScheme2 = scheme;
		if (!inputControlScheme.HasValue || (inputControlScheme.HasValue && inputControlScheme.GetValueOrDefault() != inputControlScheme2) || (scheme == default(InputControlScheme) && s_GlobalState.allUserData[num].controlScheme.HasValue))
		{
			ActivateControlSchemeInternal(num, scheme);
			Notify(num, InputUserChange.ControlSchemeChanged, null);
		}
		return new ControlSchemeChangeSyntax
		{
			m_UserIndex = num
		};
	}

	private void ActivateControlSchemeInternal(int userIndex, InputControlScheme scheme)
	{
		bool flag = scheme == default(InputControlScheme);
		if (flag)
		{
			s_GlobalState.allUserData[userIndex].controlScheme = null;
		}
		else
		{
			s_GlobalState.allUserData[userIndex].controlScheme = scheme;
		}
		if (s_GlobalState.allUserData[userIndex].actions == null)
		{
			return;
		}
		if (flag)
		{
			s_GlobalState.allUserData[userIndex].actions.bindingMask = null;
			s_GlobalState.allUserData[userIndex].controlSchemeMatch.Dispose();
			s_GlobalState.allUserData[userIndex].controlSchemeMatch = default(InputControlScheme.MatchResult);
			return;
		}
		s_GlobalState.allUserData[userIndex].actions.bindingMask = new InputBinding
		{
			groups = scheme.bindingGroup
		};
		UpdateControlSchemeMatch(userIndex);
		if (s_GlobalState.allUserData[userIndex].controlSchemeMatch.isSuccessfulMatch)
		{
			RemoveLostDevicesForUser(userIndex);
		}
	}

	public void UnpairDevice(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		int userIndex = index;
		if (pairedDevices.ContainsReference(device))
		{
			RemoveDeviceFromUser(userIndex, device);
		}
	}

	public void UnpairDevices()
	{
		int num = index;
		RemoveLostDevicesForUser(num);
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			while (s_GlobalState.allUserData[num].deviceCount > 0)
			{
				UnpairDevice(s_GlobalState.allPairedDevices[s_GlobalState.allUserData[num].deviceStartIndex + s_GlobalState.allUserData[num].deviceCount - 1]);
			}
		}
		if (s_GlobalState.allUserData[num].controlScheme.HasValue)
		{
			UpdateControlSchemeMatch(num);
		}
	}

	private static void RemoveLostDevicesForUser(int userIndex)
	{
		int lostDeviceCount = s_GlobalState.allUserData[userIndex].lostDeviceCount;
		if (lostDeviceCount <= 0)
		{
			return;
		}
		int lostDeviceStartIndex = s_GlobalState.allUserData[userIndex].lostDeviceStartIndex;
		ArrayHelpers.EraseSliceWithCapacity(ref s_GlobalState.allLostDevices, ref s_GlobalState.allLostDeviceCount, lostDeviceStartIndex, lostDeviceCount);
		s_GlobalState.allUserData[userIndex].lostDeviceCount = 0;
		s_GlobalState.allUserData[userIndex].lostDeviceStartIndex = 0;
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			if (s_GlobalState.allUserData[i].lostDeviceStartIndex > lostDeviceStartIndex)
			{
				s_GlobalState.allUserData[i].lostDeviceStartIndex -= lostDeviceCount;
			}
		}
	}

	public void UnpairDevicesAndRemoveUser()
	{
		UnpairDevices();
		RemoveUser(index);
		m_Id = 0u;
	}

	public static InputControlList<InputDevice> GetUnpairedInputDevices()
	{
		InputControlList<InputDevice> list = new InputControlList<InputDevice>(Allocator.Temp);
		GetUnpairedInputDevices(ref list);
		return list;
	}

	public static int GetUnpairedInputDevices(ref InputControlList<InputDevice> list)
	{
		int count = list.Count;
		foreach (InputDevice device in InputSystem.devices)
		{
			if (!s_GlobalState.allPairedDevices.ContainsReference(s_GlobalState.allPairedDeviceCount, device))
			{
				list.Add(device);
			}
		}
		return list.Count - count;
	}

	public static InputUser? FindUserPairedToDevice(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		int num = TryFindUserIndex(device);
		if (num == -1)
		{
			return null;
		}
		return s_GlobalState.allUsers[num];
	}

	public static InputUser? FindUserByAccount(InputUserAccountHandle platformUserAccountHandle)
	{
		if (platformUserAccountHandle == default(InputUserAccountHandle))
		{
			throw new ArgumentException("Empty platform user account handle", "platformUserAccountHandle");
		}
		int num = TryFindUserIndex(platformUserAccountHandle);
		if (num == -1)
		{
			return null;
		}
		return s_GlobalState.allUsers[num];
	}

	public static InputUser CreateUserWithoutPairedDevices()
	{
		int num = AddUser();
		return s_GlobalState.allUsers[num];
	}

	public static InputUser PerformPairingWithDevice(InputDevice device, InputUser user = default(InputUser), InputUserPairingOptions options = InputUserPairingOptions.None)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (user != default(InputUser) && !user.valid)
		{
			throw new ArgumentException("Invalid user", "user");
		}
		int num;
		if (user == default(InputUser))
		{
			num = AddUser();
		}
		else
		{
			num = user.index;
			if ((options & InputUserPairingOptions.UnpairCurrentDevicesFromUser) != InputUserPairingOptions.None)
			{
				user.UnpairDevices();
			}
			if (user.pairedDevices.ContainsReference(device))
			{
				if ((options & InputUserPairingOptions.ForcePlatformUserAccountSelection) != InputUserPairingOptions.None)
				{
					InitiateUserAccountSelection(num, device, options);
				}
				return user;
			}
		}
		if (!InitiateUserAccountSelection(num, device, options))
		{
			AddDeviceToUser(num, device);
		}
		return s_GlobalState.allUsers[num];
	}

	private static bool InitiateUserAccountSelection(int userIndex, InputDevice device, InputUserPairingOptions options)
	{
		long num = (((options & InputUserPairingOptions.ForcePlatformUserAccountSelection) == 0) ? UpdatePlatformUserAccount(userIndex, device) : 0);
		if (((options & InputUserPairingOptions.ForcePlatformUserAccountSelection) != InputUserPairingOptions.None || (num != -1 && (num & 2) == 0L && (options & InputUserPairingOptions.ForceNoPlatformUserAccountSelection) == 0)) && InitiateUserAccountSelectionAtPlatformLevel(device))
		{
			s_GlobalState.allUserData[userIndex].flags |= UserFlags.UserAccountSelectionInProgress;
			s_GlobalState.ongoingAccountSelections.Append(new OngoingAccountSelection
			{
				device = device,
				userId = s_GlobalState.allUsers[userIndex].id
			});
			HookIntoDeviceChange();
			Notify(userIndex, InputUserChange.AccountSelectionInProgress, device);
			return true;
		}
		return false;
	}

	public bool Equals(InputUser other)
	{
		return m_Id == other.m_Id;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is InputUser)
		{
			return Equals((InputUser)obj);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (int)m_Id;
	}

	public static bool operator ==(InputUser left, InputUser right)
	{
		return left.m_Id == right.m_Id;
	}

	public static bool operator !=(InputUser left, InputUser right)
	{
		return left.m_Id != right.m_Id;
	}

	private static int AddUser()
	{
		uint num = ++s_GlobalState.lastUserId;
		int count = s_GlobalState.allUserCount;
		ArrayHelpers.AppendWithCapacity(ref s_GlobalState.allUsers, ref count, new InputUser
		{
			m_Id = num
		});
		int num2 = ArrayHelpers.AppendWithCapacity(ref s_GlobalState.allUserData, ref s_GlobalState.allUserCount, default(UserData));
		Notify(num2, InputUserChange.Added, null);
		return num2;
	}

	private static void RemoveUser(int userIndex)
	{
		if (s_GlobalState.allUserData[userIndex].controlScheme.HasValue && s_GlobalState.allUserData[userIndex].actions != null)
		{
			s_GlobalState.allUserData[userIndex].actions.bindingMask = null;
		}
		s_GlobalState.allUserData[userIndex].controlSchemeMatch.Dispose();
		RemoveLostDevicesForUser(userIndex);
		for (int i = 0; i < s_GlobalState.ongoingAccountSelections.length; i++)
		{
			if (s_GlobalState.ongoingAccountSelections[i].userId == s_GlobalState.allUsers[userIndex].id)
			{
				s_GlobalState.ongoingAccountSelections.RemoveAtByMovingTailWithCapacity(i);
				i--;
			}
		}
		Notify(userIndex, InputUserChange.Removed, null);
		int count = s_GlobalState.allUserCount;
		s_GlobalState.allUsers.EraseAtWithCapacity(ref count, userIndex);
		s_GlobalState.allUserData.EraseAtWithCapacity(ref s_GlobalState.allUserCount, userIndex);
		if (s_GlobalState.allUserCount == 0)
		{
			UnhookFromDeviceChange();
			UnhookFromActionChange();
		}
	}

	private static void Notify(int userIndex, InputUserChange change, InputDevice device)
	{
		if (s_GlobalState.onChange.length == 0)
		{
			return;
		}
		s_GlobalState.onChange.LockForChanges();
		for (int i = 0; i < s_GlobalState.onChange.length; i++)
		{
			try
			{
				s_GlobalState.onChange[i](s_GlobalState.allUsers[userIndex], change, device);
			}
			catch (Exception ex)
			{
				Debug.LogError(ex.GetType().Name + " while executing 'InputUser.onChange' callbacks");
				Debug.LogException(ex);
			}
		}
		s_GlobalState.onChange.UnlockForChanges();
	}

	private static int TryFindUserIndex(uint userId)
	{
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			if (s_GlobalState.allUsers[i].m_Id == userId)
			{
				return i;
			}
		}
		return -1;
	}

	private static int TryFindUserIndex(InputUserAccountHandle platformHandle)
	{
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			if (s_GlobalState.allUserData[i].platformUserAccountHandle == platformHandle)
			{
				return i;
			}
		}
		return -1;
	}

	private static int TryFindUserIndex(InputDevice device)
	{
		int num = s_GlobalState.allPairedDevices.IndexOfReference(device, s_GlobalState.allPairedDeviceCount);
		if (num == -1)
		{
			return -1;
		}
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			int deviceStartIndex = s_GlobalState.allUserData[i].deviceStartIndex;
			if (deviceStartIndex <= num && num < deviceStartIndex + s_GlobalState.allUserData[i].deviceCount)
			{
				return i;
			}
		}
		return -1;
	}

	private static void AddDeviceToUser(int userIndex, InputDevice device, bool asLostDevice = false, bool dontUpdateControlScheme = false)
	{
		int num = (asLostDevice ? s_GlobalState.allUserData[userIndex].lostDeviceCount : s_GlobalState.allUserData[userIndex].deviceCount);
		int num2 = (asLostDevice ? s_GlobalState.allUserData[userIndex].lostDeviceStartIndex : s_GlobalState.allUserData[userIndex].deviceStartIndex);
		s_GlobalState.pairingStateVersion++;
		if (num > 0)
		{
			ArrayHelpers.MoveSlice(asLostDevice ? s_GlobalState.allLostDevices : s_GlobalState.allPairedDevices, num2, asLostDevice ? (s_GlobalState.allLostDeviceCount - num) : (s_GlobalState.allPairedDeviceCount - num), num);
			for (int i = 0; i < s_GlobalState.allUserCount; i++)
			{
				if (i != userIndex && (asLostDevice ? s_GlobalState.allUserData[i].lostDeviceStartIndex : s_GlobalState.allUserData[i].deviceStartIndex) > num2)
				{
					if (asLostDevice)
					{
						s_GlobalState.allUserData[i].lostDeviceStartIndex -= num;
					}
					else
					{
						s_GlobalState.allUserData[i].deviceStartIndex -= num;
					}
				}
			}
		}
		if (asLostDevice)
		{
			s_GlobalState.allUserData[userIndex].lostDeviceStartIndex = s_GlobalState.allLostDeviceCount - num;
			ArrayHelpers.AppendWithCapacity(ref s_GlobalState.allLostDevices, ref s_GlobalState.allLostDeviceCount, device);
			s_GlobalState.allUserData[userIndex].lostDeviceCount++;
		}
		else
		{
			s_GlobalState.allUserData[userIndex].deviceStartIndex = s_GlobalState.allPairedDeviceCount - num;
			ArrayHelpers.AppendWithCapacity(ref s_GlobalState.allPairedDevices, ref s_GlobalState.allPairedDeviceCount, device);
			s_GlobalState.allUserData[userIndex].deviceCount++;
			IInputActionCollection inputActionCollection = s_GlobalState.allUserData[userIndex].actions;
			if (inputActionCollection != null)
			{
				inputActionCollection.devices = s_GlobalState.allUsers[userIndex].pairedDevices;
				if (!dontUpdateControlScheme && s_GlobalState.allUserData[userIndex].controlScheme.HasValue)
				{
					UpdateControlSchemeMatch(userIndex);
				}
			}
		}
		HookIntoDeviceChange();
		Notify(userIndex, asLostDevice ? InputUserChange.DeviceLost : InputUserChange.DevicePaired, device);
	}

	private static void RemoveDeviceFromUser(int userIndex, InputDevice device, bool asLostDevice = false)
	{
		int num = (asLostDevice ? s_GlobalState.allLostDevices.IndexOfReference(device, s_GlobalState.allLostDeviceCount) : s_GlobalState.allPairedDevices.IndexOfReference(device, s_GlobalState.allUserData[userIndex].deviceStartIndex, s_GlobalState.allUserData[userIndex].deviceCount));
		if (num == -1)
		{
			return;
		}
		if (asLostDevice)
		{
			s_GlobalState.allLostDevices.EraseAtWithCapacity(ref s_GlobalState.allLostDeviceCount, num);
			s_GlobalState.allUserData[userIndex].lostDeviceCount--;
		}
		else
		{
			s_GlobalState.pairingStateVersion++;
			s_GlobalState.allPairedDevices.EraseAtWithCapacity(ref s_GlobalState.allPairedDeviceCount, num);
			s_GlobalState.allUserData[userIndex].deviceCount--;
		}
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			if ((asLostDevice ? s_GlobalState.allUserData[i].lostDeviceStartIndex : s_GlobalState.allUserData[i].deviceStartIndex) > num)
			{
				if (asLostDevice)
				{
					s_GlobalState.allUserData[i].lostDeviceStartIndex--;
				}
				else
				{
					s_GlobalState.allUserData[i].deviceStartIndex--;
				}
			}
		}
		if (asLostDevice)
		{
			return;
		}
		for (int j = 0; j < s_GlobalState.ongoingAccountSelections.length; j++)
		{
			if (s_GlobalState.ongoingAccountSelections[j].userId == s_GlobalState.allUsers[userIndex].id && s_GlobalState.ongoingAccountSelections[j].device == device)
			{
				s_GlobalState.ongoingAccountSelections.RemoveAtByMovingTailWithCapacity(j);
				j--;
			}
		}
		IInputActionCollection inputActionCollection = s_GlobalState.allUserData[userIndex].actions;
		if (inputActionCollection != null)
		{
			inputActionCollection.devices = s_GlobalState.allUsers[userIndex].pairedDevices;
			if (s_GlobalState.allUsers[userIndex].controlScheme.HasValue)
			{
				UpdateControlSchemeMatch(userIndex);
			}
		}
		Notify(userIndex, InputUserChange.DeviceUnpaired, device);
	}

	private static void UpdateControlSchemeMatch(int userIndex, bool autoPairMissing = false)
	{
		if (!s_GlobalState.allUserData[userIndex].controlScheme.HasValue)
		{
			return;
		}
		s_GlobalState.allUserData[userIndex].controlSchemeMatch.Dispose();
		InputControlScheme.MatchResult matchResult = default(InputControlScheme.MatchResult);
		try
		{
			InputControlScheme value = s_GlobalState.allUserData[userIndex].controlScheme.Value;
			if (value.deviceRequirements.Count > 0)
			{
				InputControlList<InputDevice> list = new InputControlList<InputDevice>(Allocator.Temp);
				try
				{
					list.AddSlice(s_GlobalState.allUsers[userIndex].pairedDevices);
					if (autoPairMissing)
					{
						int count = list.Count;
						int unpairedInputDevices = GetUnpairedInputDevices(ref list);
						if (s_GlobalState.allUserData[userIndex].platformUserAccountHandle.HasValue)
						{
							list.Sort(count, unpairedInputDevices, new CompareDevicesByUserAccount
							{
								platformUserAccountHandle = s_GlobalState.allUserData[userIndex].platformUserAccountHandle.Value
							});
						}
					}
					matchResult = value.PickDevicesFrom(list);
					if (matchResult.isSuccessfulMatch && autoPairMissing)
					{
						s_GlobalState.allUserData[userIndex].controlSchemeMatch = matchResult;
						foreach (InputDevice device in matchResult.devices)
						{
							if (!s_GlobalState.allUsers[userIndex].pairedDevices.ContainsReference(device))
							{
								AddDeviceToUser(userIndex, device, asLostDevice: false, dontUpdateControlScheme: true);
							}
						}
					}
				}
				finally
				{
					list.Dispose();
				}
			}
			s_GlobalState.allUserData[userIndex].controlSchemeMatch = matchResult;
		}
		catch (Exception)
		{
			matchResult.Dispose();
			throw;
		}
	}

	private static long UpdatePlatformUserAccount(int userIndex, InputDevice device)
	{
		long num = QueryPairedPlatformUserAccount(device, out var platformAccountHandle, out var platformAccountName, out var platformAccountId);
		if (num == -1)
		{
			if ((s_GlobalState.allUserData[userIndex].flags & UserFlags.UserAccountSelectionInProgress) != 0)
			{
				Notify(userIndex, InputUserChange.AccountSelectionCanceled, null);
			}
			s_GlobalState.allUserData[userIndex].platformUserAccountHandle = null;
			s_GlobalState.allUserData[userIndex].platformUserAccountName = null;
			s_GlobalState.allUserData[userIndex].platformUserAccountId = null;
			return num;
		}
		if ((s_GlobalState.allUserData[userIndex].flags & UserFlags.UserAccountSelectionInProgress) != 0)
		{
			if ((num & 4) == 0L)
			{
				if ((num & 0x10) != 0L)
				{
					Notify(userIndex, InputUserChange.AccountSelectionCanceled, device);
				}
				else
				{
					s_GlobalState.allUserData[userIndex].flags &= ~UserFlags.UserAccountSelectionInProgress;
					s_GlobalState.allUserData[userIndex].platformUserAccountHandle = platformAccountHandle;
					s_GlobalState.allUserData[userIndex].platformUserAccountName = platformAccountName;
					s_GlobalState.allUserData[userIndex].platformUserAccountId = platformAccountId;
					Notify(userIndex, InputUserChange.AccountSelectionComplete, device);
				}
			}
		}
		else
		{
			InputUserAccountHandle? inputUserAccountHandle = s_GlobalState.allUserData[userIndex].platformUserAccountHandle;
			InputUserAccountHandle? inputUserAccountHandle2 = platformAccountHandle;
			if (inputUserAccountHandle.HasValue != inputUserAccountHandle2.HasValue || (inputUserAccountHandle.HasValue && inputUserAccountHandle.GetValueOrDefault() != inputUserAccountHandle2.GetValueOrDefault()) || s_GlobalState.allUserData[userIndex].platformUserAccountId != platformAccountId)
			{
				s_GlobalState.allUserData[userIndex].platformUserAccountHandle = platformAccountHandle;
				s_GlobalState.allUserData[userIndex].platformUserAccountName = platformAccountName;
				s_GlobalState.allUserData[userIndex].platformUserAccountId = platformAccountId;
				Notify(userIndex, InputUserChange.AccountChanged, device);
			}
			else if (s_GlobalState.allUserData[userIndex].platformUserAccountName != platformAccountName)
			{
				Notify(userIndex, InputUserChange.AccountNameChanged, device);
			}
		}
		return num;
	}

	private static long QueryPairedPlatformUserAccount(InputDevice device, out InputUserAccountHandle? platformAccountHandle, out string platformAccountName, out string platformAccountId)
	{
		QueryPairedUserAccountCommand command = QueryPairedUserAccountCommand.Create();
		long num = device.ExecuteCommand(ref command);
		if (num == -1)
		{
			platformAccountHandle = null;
			platformAccountName = null;
			platformAccountId = null;
			return -1L;
		}
		if ((num & 2) != 0L)
		{
			platformAccountHandle = new InputUserAccountHandle(device.description.interfaceName ?? "<Unknown>", command.handle);
			platformAccountName = command.name;
			platformAccountId = command.id;
		}
		else
		{
			platformAccountHandle = null;
			platformAccountName = null;
			platformAccountId = null;
		}
		return num;
	}

	private static bool InitiateUserAccountSelectionAtPlatformLevel(InputDevice device)
	{
		InitiateUserAccountPairingCommand command = InitiateUserAccountPairingCommand.Create();
		long num = device.ExecuteCommand(ref command);
		if (num == -2)
		{
			throw new InvalidOperationException("User pairing already in progress");
		}
		return num == 1;
	}

	private static void OnActionChange(object obj, InputActionChange change)
	{
		if (change != InputActionChange.BoundControlsChanged)
		{
			return;
		}
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			if (s_GlobalState.allUsers[i].actions == obj)
			{
				Notify(i, InputUserChange.ControlsChanged, null);
			}
		}
	}

	private static void OnDeviceChange(InputDevice device, InputDeviceChange change)
	{
		switch (change)
		{
		case InputDeviceChange.Removed:
		{
			for (int num6 = s_GlobalState.allPairedDevices.IndexOfReference(device, s_GlobalState.allPairedDeviceCount); num6 != -1; num6 = s_GlobalState.allPairedDevices.IndexOfReference(device, s_GlobalState.allPairedDeviceCount))
			{
				int userIndex2 = -1;
				for (int l = 0; l < s_GlobalState.allUserCount; l++)
				{
					int deviceStartIndex2 = s_GlobalState.allUserData[l].deviceStartIndex;
					if (deviceStartIndex2 <= num6 && num6 < deviceStartIndex2 + s_GlobalState.allUserData[l].deviceCount)
					{
						userIndex2 = l;
						break;
					}
				}
				AddDeviceToUser(userIndex2, device, asLostDevice: true);
				RemoveDeviceFromUser(userIndex2, device);
			}
			break;
		}
		case InputDeviceChange.Added:
		{
			for (int num5 = FindLostDevice(device); num5 != -1; num5 = FindLostDevice(device, num5))
			{
				int userIndex = -1;
				for (int k = 0; k < s_GlobalState.allUserCount; k++)
				{
					int lostDeviceStartIndex = s_GlobalState.allUserData[k].lostDeviceStartIndex;
					if (lostDeviceStartIndex <= num5 && num5 < lostDeviceStartIndex + s_GlobalState.allUserData[k].lostDeviceCount)
					{
						userIndex = k;
						break;
					}
				}
				RemoveDeviceFromUser(userIndex, s_GlobalState.allLostDevices[num5], asLostDevice: true);
				Notify(userIndex, InputUserChange.DeviceRegained, device);
				AddDeviceToUser(userIndex, device);
			}
			break;
		}
		case InputDeviceChange.ConfigurationChanged:
		{
			bool flag = false;
			for (int i = 0; i < s_GlobalState.ongoingAccountSelections.length; i++)
			{
				if (s_GlobalState.ongoingAccountSelections[i].device != device)
				{
					continue;
				}
				InputUser inputUser = new InputUser
				{
					m_Id = s_GlobalState.ongoingAccountSelections[i].userId
				};
				int num = inputUser.index;
				if ((UpdatePlatformUserAccount(num, device) & 4) == 0L)
				{
					flag = true;
					s_GlobalState.ongoingAccountSelections.RemoveAtByMovingTailWithCapacity(i);
					i--;
					if (!s_GlobalState.allUsers[num].pairedDevices.ContainsReference(device))
					{
						AddDeviceToUser(num, device);
					}
				}
			}
			if (flag)
			{
				break;
			}
			int num2 = s_GlobalState.allPairedDevices.IndexOfReference(device, s_GlobalState.allPairedDeviceCount);
			while (num2 != -1)
			{
				int num3 = -1;
				for (int j = 0; j < s_GlobalState.allUserCount; j++)
				{
					int deviceStartIndex = s_GlobalState.allUserData[j].deviceStartIndex;
					if (deviceStartIndex <= num2 && num2 < deviceStartIndex + s_GlobalState.allUserData[j].deviceCount)
					{
						num3 = j;
						break;
					}
				}
				UpdatePlatformUserAccount(num3, device);
				int num4 = num2 + Math.Max(1, s_GlobalState.allUserData[num3].deviceCount);
				num2 = s_GlobalState.allPairedDevices.IndexOfReference(device, num4, s_GlobalState.allPairedDeviceCount - num4);
			}
			break;
		}
		}
	}

	private static int FindLostDevice(InputDevice device, int startIndex = 0)
	{
		int deviceId = device.deviceId;
		for (int i = startIndex; i < s_GlobalState.allLostDeviceCount; i++)
		{
			InputDevice inputDevice = s_GlobalState.allLostDevices[i];
			if (device == inputDevice || inputDevice.deviceId == deviceId)
			{
				return i;
			}
		}
		return -1;
	}

	private static void OnEvent(InputEventPtr eventPtr, InputDevice device)
	{
		if (s_GlobalState.listenForUnpairedDeviceActivity == 0)
		{
			return;
		}
		FourCC type = eventPtr.type;
		if ((type != 1398030676 && type != 1145852993) || !device.enabled || s_GlobalState.allPairedDevices.ContainsReference(s_GlobalState.allPairedDeviceCount, device) || !DelegateHelpers.InvokeCallbacksSafe_AnyCallbackReturnsTrue(ref s_GlobalState.onPreFilterUnpairedDeviceUsed, device, eventPtr, "InputUser.onPreFilterUnpairedDeviceActivity"))
		{
			return;
		}
		foreach (InputControl item in eventPtr.EnumerateChangedControls(device, 0.0001f))
		{
			bool flag = false;
			s_GlobalState.onUnpairedDeviceUsed.LockForChanges();
			for (int i = 0; i < s_GlobalState.onUnpairedDeviceUsed.length; i++)
			{
				int pairingStateVersion = s_GlobalState.pairingStateVersion;
				try
				{
					s_GlobalState.onUnpairedDeviceUsed[i](item, eventPtr);
				}
				catch (Exception ex)
				{
					Debug.LogError(ex.GetType().Name + " while executing 'InputUser.onUnpairedDeviceUsed' callbacks");
					Debug.LogException(ex);
				}
				if (pairingStateVersion != s_GlobalState.pairingStateVersion && FindUserPairedToDevice(device).HasValue)
				{
					flag = true;
					break;
				}
			}
			s_GlobalState.onUnpairedDeviceUsed.UnlockForChanges();
			if (flag)
			{
				break;
			}
		}
	}

	internal static ISavedState SaveAndResetState()
	{
		SavedStructState<GlobalState> result = new SavedStructState<GlobalState>(ref s_GlobalState, delegate(ref GlobalState state)
		{
			s_GlobalState = state;
		}, delegate
		{
			DisposeAndResetGlobalState();
		});
		s_GlobalState = default(GlobalState);
		return result;
	}

	private static void HookIntoActionChange()
	{
		if (!s_GlobalState.onActionChangeHooked)
		{
			if (s_GlobalState.actionChangeDelegate == null)
			{
				s_GlobalState.actionChangeDelegate = OnActionChange;
			}
			InputSystem.onActionChange += OnActionChange;
			s_GlobalState.onActionChangeHooked = true;
		}
	}

	private static void UnhookFromActionChange()
	{
		if (s_GlobalState.onActionChangeHooked)
		{
			InputSystem.onActionChange -= OnActionChange;
			s_GlobalState.onActionChangeHooked = false;
		}
	}

	private static void HookIntoDeviceChange()
	{
		if (!s_GlobalState.onDeviceChangeHooked)
		{
			if (s_GlobalState.onDeviceChangeDelegate == null)
			{
				s_GlobalState.onDeviceChangeDelegate = OnDeviceChange;
			}
			InputSystem.onDeviceChange += s_GlobalState.onDeviceChangeDelegate;
			s_GlobalState.onDeviceChangeHooked = true;
		}
	}

	private static void UnhookFromDeviceChange()
	{
		if (s_GlobalState.onDeviceChangeHooked)
		{
			InputSystem.onDeviceChange -= s_GlobalState.onDeviceChangeDelegate;
			s_GlobalState.onDeviceChangeHooked = false;
		}
	}

	private static void HookIntoEvents()
	{
		if (!s_GlobalState.onEventHooked)
		{
			if (s_GlobalState.onEventDelegate == null)
			{
				s_GlobalState.onEventDelegate = OnEvent;
			}
			InputSystem.onEvent += s_GlobalState.onEventDelegate;
			s_GlobalState.onEventHooked = true;
		}
	}

	private static void UnhookFromDeviceStateChange()
	{
		if (s_GlobalState.onEventHooked)
		{
			InputSystem.onEvent -= s_GlobalState.onEventDelegate;
			s_GlobalState.onEventHooked = false;
		}
	}

	private static void DisposeAndResetGlobalState()
	{
		for (int i = 0; i < s_GlobalState.allUserCount; i++)
		{
			s_GlobalState.allUserData[i].controlSchemeMatch.Dispose();
		}
		uint lastUserId = s_GlobalState.lastUserId;
		s_GlobalState = default(GlobalState);
		s_GlobalState.lastUserId = lastUserId;
	}

	internal static void ResetGlobals()
	{
		UnhookFromActionChange();
		UnhookFromDeviceChange();
		UnhookFromDeviceStateChange();
		DisposeAndResetGlobalState();
	}
}
