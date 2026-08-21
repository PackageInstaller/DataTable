using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public class InputActionAsset : ScriptableObject, IInputActionCollection2, IInputActionCollection, IEnumerable<InputAction>, IEnumerable
{
	[Serializable]
	internal struct WriteFileJson
	{
		public string name;

		public InputActionMap.WriteMapJson[] maps;

		public InputControlScheme.SchemeJson[] controlSchemes;
	}

	[Serializable]
	internal struct ReadFileJson
	{
		public string name;

		public InputActionMap.ReadMapJson[] maps;

		public InputControlScheme.SchemeJson[] controlSchemes;

		public void ToAsset(InputActionAsset asset)
		{
			asset.name = name;
			InputActionMap.ReadFileJson readFileJson = new InputActionMap.ReadFileJson
			{
				maps = maps
			};
			asset.m_ActionMaps = readFileJson.ToMaps();
			asset.m_ControlSchemes = InputControlScheme.SchemeJson.ToSchemes(controlSchemes);
			if (asset.m_ActionMaps != null)
			{
				InputActionMap[] actionMaps = asset.m_ActionMaps;
				for (int i = 0; i < actionMaps.Length; i++)
				{
					actionMaps[i].m_Asset = asset;
				}
			}
		}
	}

	public const string Extension = "inputactions";

	[SerializeField]
	internal InputActionMap[] m_ActionMaps;

	[SerializeField]
	internal InputControlScheme[] m_ControlSchemes;

	[NonSerialized]
	internal InputActionState m_SharedStateForAllMaps;

	[NonSerialized]
	internal InputBinding? m_BindingMask;

	[NonSerialized]
	internal int m_ParameterOverridesCount;

	[NonSerialized]
	internal InputActionRebindingExtensions.ParameterOverride[] m_ParameterOverrides;

	[NonSerialized]
	internal InputActionMap.DeviceArray m_Devices;

	public bool enabled
	{
		get
		{
			foreach (InputActionMap actionMap in actionMaps)
			{
				if (actionMap.enabled)
				{
					return true;
				}
			}
			return false;
		}
	}

	public ReadOnlyArray<InputActionMap> actionMaps => new ReadOnlyArray<InputActionMap>(m_ActionMaps);

	public ReadOnlyArray<InputControlScheme> controlSchemes => new ReadOnlyArray<InputControlScheme>(m_ControlSchemes);

	public IEnumerable<InputBinding> bindings
	{
		get
		{
			int numActionMaps = m_ActionMaps.LengthSafe();
			if (numActionMaps == 0)
			{
				yield break;
			}
			int i = 0;
			while (i < numActionMaps)
			{
				InputActionMap inputActionMap = m_ActionMaps[i];
				InputBinding[] bindings = inputActionMap.m_Bindings;
				int numBindings = bindings.LengthSafe();
				int num;
				for (int n = 0; n < numBindings; n = num)
				{
					yield return bindings[n];
					num = n + 1;
				}
				num = i + 1;
				i = num;
			}
		}
	}

	public InputBinding? bindingMask
	{
		get
		{
			return m_BindingMask;
		}
		set
		{
			if (!(m_BindingMask == value))
			{
				m_BindingMask = value;
				ReResolveIfNecessary(fullResolve: true);
			}
		}
	}

	public ReadOnlyArray<InputDevice>? devices
	{
		get
		{
			return m_Devices.Get();
		}
		set
		{
			if (m_Devices.Set(value))
			{
				ReResolveIfNecessary(fullResolve: false);
			}
		}
	}

	public InputAction this[string actionNameOrId] => FindAction(actionNameOrId) ?? throw new KeyNotFoundException($"Cannot find action '{actionNameOrId}' in '{this}'");

	public string ToJson()
	{
		return JsonUtility.ToJson((object)new WriteFileJson
		{
			name = base.name,
			maps = InputActionMap.WriteFileJson.FromMaps(m_ActionMaps).maps,
			controlSchemes = InputControlScheme.SchemeJson.ToJson(m_ControlSchemes)
		}, true);
	}

	public void LoadFromJson(string json)
	{
		if (string.IsNullOrEmpty(json))
		{
			throw new ArgumentNullException("json");
		}
		JsonUtility.FromJson<ReadFileJson>(json).ToAsset(this);
	}

	public static InputActionAsset FromJson(string json)
	{
		if (string.IsNullOrEmpty(json))
		{
			throw new ArgumentNullException("json");
		}
		InputActionAsset inputActionAsset = ScriptableObject.CreateInstance<InputActionAsset>();
		inputActionAsset.LoadFromJson(json);
		return inputActionAsset;
	}

	public InputAction FindAction(string actionNameOrId, bool throwIfNotFound = false)
	{
		if (actionNameOrId == null)
		{
			throw new ArgumentNullException("actionNameOrId");
		}
		if (m_ActionMaps != null)
		{
			int num = actionNameOrId.IndexOf('/');
			if (num == -1)
			{
				InputAction inputAction = null;
				for (int i = 0; i < m_ActionMaps.Length; i++)
				{
					InputAction inputAction2 = m_ActionMaps[i].FindAction(actionNameOrId);
					if (inputAction2 != null)
					{
						if (inputAction2.enabled || inputAction2.m_Id == actionNameOrId)
						{
							return inputAction2;
						}
						if (inputAction == null)
						{
							inputAction = inputAction2;
						}
					}
				}
				if (inputAction != null)
				{
					return inputAction;
				}
			}
			else
			{
				Substring right = new Substring(actionNameOrId, 0, num);
				Substring right2 = new Substring(actionNameOrId, num + 1);
				if (right.isEmpty || right2.isEmpty)
				{
					throw new ArgumentException("Malformed action path: " + actionNameOrId, "actionNameOrId");
				}
				for (int j = 0; j < m_ActionMaps.Length; j++)
				{
					InputActionMap inputActionMap = m_ActionMaps[j];
					if (Substring.Compare(inputActionMap.name, right, StringComparison.InvariantCultureIgnoreCase) != 0)
					{
						continue;
					}
					InputAction[] actions = inputActionMap.m_Actions;
					foreach (InputAction inputAction3 in actions)
					{
						if (Substring.Compare(inputAction3.name, right2, StringComparison.InvariantCultureIgnoreCase) == 0)
						{
							return inputAction3;
						}
					}
					break;
				}
			}
		}
		if (throwIfNotFound)
		{
			throw new ArgumentException($"No action '{actionNameOrId}' in '{this}'");
		}
		return null;
	}

	public int FindBinding(InputBinding mask, out InputAction action)
	{
		int num = m_ActionMaps.LengthSafe();
		for (int i = 0; i < num; i++)
		{
			int num2 = m_ActionMaps[i].FindBinding(mask, out action);
			if (num2 >= 0)
			{
				return num2;
			}
		}
		action = null;
		return -1;
	}

	public InputActionMap FindActionMap(string nameOrId, bool throwIfNotFound = false)
	{
		if (nameOrId == null)
		{
			throw new ArgumentNullException("nameOrId");
		}
		if (m_ActionMaps == null)
		{
			return null;
		}
		if (nameOrId.Contains('-') && Guid.TryParse(nameOrId, out var result))
		{
			for (int i = 0; i < m_ActionMaps.Length; i++)
			{
				InputActionMap inputActionMap = m_ActionMaps[i];
				if (inputActionMap.idDontGenerate == result)
				{
					return inputActionMap;
				}
			}
		}
		for (int j = 0; j < m_ActionMaps.Length; j++)
		{
			InputActionMap inputActionMap2 = m_ActionMaps[j];
			if (string.Compare(nameOrId, inputActionMap2.name, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				return inputActionMap2;
			}
		}
		if (throwIfNotFound)
		{
			throw new ArgumentException($"Cannot find action map '{nameOrId}' in '{this}'");
		}
		return null;
	}

	public InputActionMap FindActionMap(Guid id)
	{
		if (m_ActionMaps == null)
		{
			return null;
		}
		for (int i = 0; i < m_ActionMaps.Length; i++)
		{
			InputActionMap inputActionMap = m_ActionMaps[i];
			if (inputActionMap.idDontGenerate == id)
			{
				return inputActionMap;
			}
		}
		return null;
	}

	public InputAction FindAction(Guid guid)
	{
		if (m_ActionMaps == null)
		{
			return null;
		}
		for (int i = 0; i < m_ActionMaps.Length; i++)
		{
			InputAction inputAction = m_ActionMaps[i].FindAction(guid);
			if (inputAction != null)
			{
				return inputAction;
			}
		}
		return null;
	}

	public int FindControlSchemeIndex(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		if (m_ControlSchemes == null)
		{
			return -1;
		}
		for (int i = 0; i < m_ControlSchemes.Length; i++)
		{
			if (string.Compare(name, m_ControlSchemes[i].name, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				return i;
			}
		}
		return -1;
	}

	public InputControlScheme? FindControlScheme(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		int num = FindControlSchemeIndex(name);
		if (num == -1)
		{
			return null;
		}
		return m_ControlSchemes[num];
	}

	public bool IsUsableWithDevice(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		int num = m_ControlSchemes.LengthSafe();
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				if (m_ControlSchemes[i].SupportsDevice(device))
				{
					return true;
				}
			}
		}
		else
		{
			int num2 = m_ActionMaps.LengthSafe();
			for (int j = 0; j < num2; j++)
			{
				if (m_ActionMaps[j].IsUsableWithDevice(device))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void Enable()
	{
		foreach (InputActionMap actionMap in actionMaps)
		{
			actionMap.Enable();
		}
	}

	public void Disable()
	{
		foreach (InputActionMap actionMap in actionMaps)
		{
			actionMap.Disable();
		}
	}

	public bool Contains(InputAction action)
	{
		InputActionMap inputActionMap = action?.actionMap;
		if (inputActionMap == null)
		{
			return false;
		}
		return inputActionMap.asset == this;
	}

	public IEnumerator<InputAction> GetEnumerator()
	{
		if (m_ActionMaps == null)
		{
			yield break;
		}
		int i = 0;
		while (i < m_ActionMaps.Length)
		{
			ReadOnlyArray<InputAction> actions = m_ActionMaps[i].actions;
			int actionCount = actions.Count;
			int num;
			for (int n = 0; n < actionCount; n = num)
			{
				yield return actions[n];
				num = n + 1;
			}
			num = i + 1;
			i = num;
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	internal void MarkAsDirty()
	{
	}

	internal void OnWantToChangeSetup()
	{
		if (m_ActionMaps.LengthSafe() > 0)
		{
			m_ActionMaps[0].OnWantToChangeSetup();
		}
	}

	internal void OnSetupChanged()
	{
		MarkAsDirty();
		if (m_ActionMaps.LengthSafe() > 0)
		{
			m_ActionMaps[0].OnSetupChanged();
		}
		else
		{
			m_SharedStateForAllMaps = null;
		}
	}

	private void ReResolveIfNecessary(bool fullResolve)
	{
		if (m_SharedStateForAllMaps != null)
		{
			m_ActionMaps[0].LazyResolveBindings(fullResolve);
		}
	}

	internal void ResolveBindingsIfNecessary()
	{
		if (m_ActionMaps.LengthSafe() > 0)
		{
			InputActionMap[] array = m_ActionMaps;
			for (int i = 0; i < array.Length && !array[i].ResolveBindingsIfNecessary(); i++)
			{
			}
		}
	}

	private void OnDestroy()
	{
		Disable();
		if (m_SharedStateForAllMaps != null)
		{
			m_SharedStateForAllMaps.Dispose();
			m_SharedStateForAllMaps = null;
		}
	}
}
