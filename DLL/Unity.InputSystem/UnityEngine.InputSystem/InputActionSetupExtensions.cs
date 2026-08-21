using System;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public static class InputActionSetupExtensions
{
	public struct BindingSyntax
	{
		private readonly InputActionMap m_ActionMap;

		private readonly InputAction m_Action;

		internal readonly int m_BindingIndexInMap;

		public bool valid
		{
			get
			{
				if (m_ActionMap != null && m_BindingIndexInMap >= 0)
				{
					return m_BindingIndexInMap < m_ActionMap.m_Bindings.LengthSafe();
				}
				return false;
			}
		}

		public int bindingIndex
		{
			get
			{
				if (!valid)
				{
					return -1;
				}
				if (m_Action != null)
				{
					return m_Action.BindingIndexOnMapToBindingIndexOnAction(m_BindingIndexInMap);
				}
				return m_BindingIndexInMap;
			}
		}

		public InputBinding binding
		{
			get
			{
				if (!valid)
				{
					throw new InvalidOperationException("BindingSyntax accessor is not valid");
				}
				return m_ActionMap.m_Bindings[m_BindingIndexInMap];
			}
		}

		internal BindingSyntax(InputActionMap map, int bindingIndexInMap, InputAction action = null)
		{
			m_ActionMap = map;
			m_BindingIndexInMap = bindingIndexInMap;
			m_Action = action;
		}

		public BindingSyntax WithName(string name)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap].name = name;
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax WithPath(string path)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap].path = path;
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax WithGroup(string group)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (string.IsNullOrEmpty(group))
			{
				throw new ArgumentException("Group name cannot be null or empty", "group");
			}
			if (group.IndexOf(';') != -1)
			{
				throw new ArgumentException($"Group name cannot contain separator character '{';'}'", "group");
			}
			return WithGroups(group);
		}

		public BindingSyntax WithGroups(string groups)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (string.IsNullOrEmpty(groups))
			{
				return this;
			}
			string groups2 = m_ActionMap.m_Bindings[m_BindingIndexInMap].groups;
			if (!string.IsNullOrEmpty(groups2))
			{
				groups = string.Join(";", groups2, groups);
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap].groups = groups;
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax WithInteraction(string interaction)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (string.IsNullOrEmpty(interaction))
			{
				throw new ArgumentException("Interaction cannot be null or empty", "interaction");
			}
			if (interaction.IndexOf(';') != -1)
			{
				throw new ArgumentException($"Interaction string cannot contain separator character '{';'}'", "interaction");
			}
			return WithInteractions(interaction);
		}

		public BindingSyntax WithInteractions(string interactions)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (string.IsNullOrEmpty(interactions))
			{
				return this;
			}
			string interactions2 = m_ActionMap.m_Bindings[m_BindingIndexInMap].interactions;
			if (!string.IsNullOrEmpty(interactions2))
			{
				interactions = string.Join(";", interactions2, interactions);
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap].interactions = interactions;
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax WithInteraction<TInteraction>() where TInteraction : IInputInteraction
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			InternedString internedString = InputProcessor.s_Processors.FindNameForType(typeof(TInteraction));
			if (internedString.IsEmpty())
			{
				throw new NotSupportedException($"Type '{typeof(TInteraction)}' has not been registered as a processor");
			}
			return WithInteraction(internedString);
		}

		public BindingSyntax WithProcessor(string processor)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (string.IsNullOrEmpty(processor))
			{
				throw new ArgumentException("Processor cannot be null or empty", "processor");
			}
			if (processor.IndexOf(';') != -1)
			{
				throw new ArgumentException($"Processor string cannot contain separator character '{';'}'", "processor");
			}
			return WithProcessors(processor);
		}

		public BindingSyntax WithProcessors(string processors)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (string.IsNullOrEmpty(processors))
			{
				return this;
			}
			string processors2 = m_ActionMap.m_Bindings[m_BindingIndexInMap].processors;
			if (!string.IsNullOrEmpty(processors2))
			{
				processors = string.Join(";", processors2, processors);
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap].processors = processors;
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax WithProcessor<TProcessor>()
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			InternedString internedString = InputProcessor.s_Processors.FindNameForType(typeof(TProcessor));
			if (internedString.IsEmpty())
			{
				throw new NotSupportedException($"Type '{typeof(TProcessor)}' has not been registered as a processor");
			}
			return WithProcessor(internedString);
		}

		public BindingSyntax Triggering(InputAction action)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			if (action == null)
			{
				throw new ArgumentNullException("action");
			}
			if (action.isSingletonAction)
			{
				throw new ArgumentException($"Cannot change the action a binding triggers on singleton action '{action}'", "action");
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap].action = action.name;
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax To(InputBinding binding)
		{
			if (!valid)
			{
				throw new InvalidOperationException("Accessor is not valid");
			}
			m_ActionMap.m_Bindings[m_BindingIndexInMap] = binding;
			if (m_ActionMap.m_SingletonAction != null)
			{
				m_ActionMap.m_Bindings[m_BindingIndexInMap].action = m_ActionMap.m_SingletonAction.name;
			}
			m_ActionMap.OnBindingModified();
			return this;
		}

		public BindingSyntax NextBinding()
		{
			return Iterate(next: true);
		}

		public BindingSyntax PreviousBinding()
		{
			return Iterate(next: false);
		}

		public BindingSyntax NextPartBinding(string partName)
		{
			if (string.IsNullOrEmpty(partName))
			{
				throw new ArgumentNullException("partName");
			}
			return IteratePartBinding(next: true, partName);
		}

		public BindingSyntax PreviousPartBinding(string partName)
		{
			if (string.IsNullOrEmpty(partName))
			{
				throw new ArgumentNullException("partName");
			}
			return IteratePartBinding(next: false, partName);
		}

		public BindingSyntax NextCompositeBinding(string compositeName = null)
		{
			return IterateCompositeBinding(next: true, compositeName);
		}

		public BindingSyntax PreviousCompositeBinding(string compositeName = null)
		{
			return IterateCompositeBinding(next: false, compositeName);
		}

		private BindingSyntax Iterate(bool next)
		{
			if (m_ActionMap == null)
			{
				return default(BindingSyntax);
			}
			InputBinding[] bindings = m_ActionMap.m_Bindings;
			if (bindings == null)
			{
				return default(BindingSyntax);
			}
			int num = m_BindingIndexInMap;
			do
			{
				num += (next ? 1 : (-1));
				if (num < 0 || num >= bindings.Length)
				{
					return default(BindingSyntax);
				}
			}
			while (m_Action != null && !bindings[num].TriggersAction(m_Action));
			return new BindingSyntax(m_ActionMap, num, m_Action);
		}

		private BindingSyntax IterateCompositeBinding(bool next, string compositeName)
		{
			BindingSyntax result = Iterate(next);
			while (result.valid)
			{
				if (result.binding.isComposite)
				{
					if (compositeName == null)
					{
						return result;
					}
					if (compositeName.Equals(result.binding.name, StringComparison.InvariantCultureIgnoreCase))
					{
						return result;
					}
					string value = NameAndParameters.ParseName(result.binding.path);
					if (compositeName.Equals(value, StringComparison.InvariantCultureIgnoreCase))
					{
						return result;
					}
				}
				result = result.Iterate(next);
			}
			return default(BindingSyntax);
		}

		private BindingSyntax IteratePartBinding(bool next, string partName)
		{
			if (!valid)
			{
				return default(BindingSyntax);
			}
			if (binding.isComposite)
			{
				if (!next)
				{
					return default(BindingSyntax);
				}
			}
			else if (!binding.isPartOfComposite)
			{
				return default(BindingSyntax);
			}
			BindingSyntax result = Iterate(next);
			while (result.valid)
			{
				if (!result.binding.isPartOfComposite)
				{
					return default(BindingSyntax);
				}
				if (partName.Equals(result.binding.name, StringComparison.InvariantCultureIgnoreCase))
				{
					return result;
				}
				result = result.Iterate(next);
			}
			return default(BindingSyntax);
		}

		public void Erase()
		{
			if (!valid)
			{
				throw new InvalidOperationException("Instance not valid");
			}
			bool isComposite = m_ActionMap.m_Bindings[m_BindingIndexInMap].isComposite;
			ArrayHelpers.EraseAt(ref m_ActionMap.m_Bindings, m_BindingIndexInMap);
			if (isComposite)
			{
				while (m_BindingIndexInMap < m_ActionMap.m_Bindings.LengthSafe() && m_ActionMap.m_Bindings[m_BindingIndexInMap].isPartOfComposite)
				{
					ArrayHelpers.EraseAt(ref m_ActionMap.m_Bindings, m_BindingIndexInMap);
				}
			}
			m_Action.m_BindingsCount = m_ActionMap.m_Bindings.LengthSafe();
			m_ActionMap.OnBindingModified();
			if (m_ActionMap.m_SingletonAction != null)
			{
				m_ActionMap.m_SingletonAction.m_SingletonActionBindings = m_ActionMap.m_Bindings;
			}
		}

		public BindingSyntax InsertPartBinding(string partName, string path)
		{
			if (string.IsNullOrEmpty(partName))
			{
				throw new ArgumentNullException("partName");
			}
			if (!valid)
			{
				throw new InvalidOperationException("Binding accessor is not valid");
			}
			InputBinding inputBinding = binding;
			if (!inputBinding.isPartOfComposite && !inputBinding.isComposite)
			{
				throw new InvalidOperationException("Binding accessor must point to composite or part binding");
			}
			AddBindingInternal(m_ActionMap, new InputBinding
			{
				path = path,
				isPartOfComposite = true,
				name = partName
			}, m_BindingIndexInMap + 1);
			return new BindingSyntax(m_ActionMap, m_BindingIndexInMap + 1, m_Action);
		}
	}

	public struct CompositeSyntax
	{
		private readonly InputAction m_Action;

		private readonly InputActionMap m_ActionMap;

		private int m_BindingIndexInMap;

		public int bindingIndex
		{
			get
			{
				if (m_ActionMap == null)
				{
					return -1;
				}
				if (m_Action != null)
				{
					return m_Action.BindingIndexOnMapToBindingIndexOnAction(m_BindingIndexInMap);
				}
				return m_BindingIndexInMap;
			}
		}

		internal CompositeSyntax(InputActionMap map, InputAction action, int compositeIndex)
		{
			m_Action = action;
			m_ActionMap = map;
			m_BindingIndexInMap = compositeIndex;
		}

		public CompositeSyntax With(string name, string binding, string groups = null, string processors = null)
		{
			using (InputActionRebindingExtensions.DeferBindingResolution())
			{
				int bindingIndexInMap;
				if (m_Action != null)
				{
					bindingIndexInMap = m_Action.AddBinding(binding, null, processors, groups).m_BindingIndexInMap;
				}
				else
				{
					bindingIndexInMap = m_ActionMap.AddBinding(binding, null, groups, null, processors).m_BindingIndexInMap;
				}
				m_ActionMap.m_Bindings[bindingIndexInMap].name = name;
				m_ActionMap.m_Bindings[bindingIndexInMap].isPartOfComposite = true;
			}
			return this;
		}
	}

	public struct ControlSchemeSyntax
	{
		private readonly InputActionAsset m_Asset;

		private readonly int m_ControlSchemeIndex;

		private InputControlScheme m_ControlScheme;

		internal ControlSchemeSyntax(InputActionAsset asset, int index)
		{
			m_Asset = asset;
			m_ControlSchemeIndex = index;
			m_ControlScheme = default(InputControlScheme);
		}

		internal ControlSchemeSyntax(InputControlScheme controlScheme)
		{
			m_Asset = null;
			m_ControlSchemeIndex = -1;
			m_ControlScheme = controlScheme;
		}

		public ControlSchemeSyntax WithBindingGroup(string bindingGroup)
		{
			if (string.IsNullOrEmpty(bindingGroup))
			{
				throw new ArgumentNullException("bindingGroup");
			}
			if (m_Asset == null)
			{
				m_ControlScheme.m_BindingGroup = bindingGroup;
			}
			else
			{
				m_Asset.m_ControlSchemes[m_ControlSchemeIndex].bindingGroup = bindingGroup;
			}
			return this;
		}

		public ControlSchemeSyntax WithRequiredDevice<TDevice>() where TDevice : InputDevice
		{
			return WithRequiredDevice(DeviceTypeToControlPath<TDevice>());
		}

		public ControlSchemeSyntax WithOptionalDevice<TDevice>() where TDevice : InputDevice
		{
			return WithOptionalDevice(DeviceTypeToControlPath<TDevice>());
		}

		public ControlSchemeSyntax OrWithRequiredDevice<TDevice>() where TDevice : InputDevice
		{
			return OrWithRequiredDevice(DeviceTypeToControlPath<TDevice>());
		}

		public ControlSchemeSyntax OrWithOptionalDevice<TDevice>() where TDevice : InputDevice
		{
			return OrWithOptionalDevice(DeviceTypeToControlPath<TDevice>());
		}

		public ControlSchemeSyntax WithRequiredDevice(string controlPath)
		{
			AddDeviceEntry(controlPath, InputControlScheme.DeviceRequirement.Flags.None);
			return this;
		}

		public ControlSchemeSyntax WithOptionalDevice(string controlPath)
		{
			AddDeviceEntry(controlPath, InputControlScheme.DeviceRequirement.Flags.Optional);
			return this;
		}

		public ControlSchemeSyntax OrWithRequiredDevice(string controlPath)
		{
			AddDeviceEntry(controlPath, InputControlScheme.DeviceRequirement.Flags.Or);
			return this;
		}

		public ControlSchemeSyntax OrWithOptionalDevice(string controlPath)
		{
			AddDeviceEntry(controlPath, InputControlScheme.DeviceRequirement.Flags.Optional | InputControlScheme.DeviceRequirement.Flags.Or);
			return this;
		}

		private string DeviceTypeToControlPath<TDevice>() where TDevice : InputDevice
		{
			string text = InputControlLayout.s_Layouts.TryFindLayoutForType(typeof(TDevice)).ToString();
			if (string.IsNullOrEmpty(text))
			{
				text = typeof(TDevice).Name;
			}
			return "<" + text + ">";
		}

		public InputControlScheme Done()
		{
			if (m_Asset != null)
			{
				return m_Asset.m_ControlSchemes[m_ControlSchemeIndex];
			}
			return m_ControlScheme;
		}

		private void AddDeviceEntry(string controlPath, InputControlScheme.DeviceRequirement.Flags flags)
		{
			if (string.IsNullOrEmpty(controlPath))
			{
				throw new ArgumentNullException("controlPath");
			}
			InputControlScheme inputControlScheme = ((m_Asset != null) ? m_Asset.m_ControlSchemes[m_ControlSchemeIndex] : m_ControlScheme);
			ArrayHelpers.Append(ref inputControlScheme.m_DeviceRequirements, new InputControlScheme.DeviceRequirement
			{
				m_ControlPath = controlPath,
				m_Flags = flags
			});
			if (m_Asset == null)
			{
				m_ControlScheme = inputControlScheme;
			}
			else
			{
				m_Asset.m_ControlSchemes[m_ControlSchemeIndex] = inputControlScheme;
			}
		}
	}

	public static InputActionMap AddActionMap(this InputActionAsset asset, string name)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		if (asset.FindActionMap(name) != null)
		{
			throw new InvalidOperationException("An action map called '" + name + "' already exists in the asset");
		}
		InputActionMap inputActionMap = new InputActionMap(name);
		inputActionMap.GenerateId();
		asset.AddActionMap(inputActionMap);
		return inputActionMap;
	}

	public static void AddActionMap(this InputActionAsset asset, InputActionMap map)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (map == null)
		{
			throw new ArgumentNullException("map");
		}
		if (string.IsNullOrEmpty(map.name))
		{
			throw new InvalidOperationException("Maps added to an input action asset must be named");
		}
		if (map.asset != null)
		{
			throw new InvalidOperationException($"Cannot add map '{map}' to asset '{asset}' as it has already been added to asset '{map.asset}'");
		}
		if (asset.FindActionMap(map.name) != null)
		{
			throw new InvalidOperationException("An action map called '" + map.name + "' already exists in the asset");
		}
		map.OnWantToChangeSetup();
		asset.OnWantToChangeSetup();
		ArrayHelpers.Append(ref asset.m_ActionMaps, map);
		map.m_Asset = asset;
		asset.OnSetupChanged();
	}

	public static void RemoveActionMap(this InputActionAsset asset, InputActionMap map)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (map == null)
		{
			throw new ArgumentNullException("map");
		}
		map.OnWantToChangeSetup();
		asset.OnWantToChangeSetup();
		if (!(map.m_Asset != asset))
		{
			ArrayHelpers.Erase(ref asset.m_ActionMaps, map);
			map.m_Asset = null;
			asset.OnSetupChanged();
		}
	}

	public static void RemoveActionMap(this InputActionAsset asset, string nameOrId)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (nameOrId == null)
		{
			throw new ArgumentNullException("nameOrId");
		}
		InputActionMap inputActionMap = asset.FindActionMap(nameOrId);
		if (inputActionMap != null)
		{
			asset.RemoveActionMap(inputActionMap);
		}
	}

	public static InputAction AddAction(this InputActionMap map, string name, InputActionType type = InputActionType.Value, string binding = null, string interactions = null, string processors = null, string groups = null, string expectedControlLayout = null)
	{
		if (map == null)
		{
			throw new ArgumentNullException("map");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentException("Action must have name", "name");
		}
		map.OnWantToChangeSetup();
		if (map.FindAction(name) != null)
		{
			throw new InvalidOperationException("Cannot add action with duplicate name '" + name + "' to set '" + map.name + "'");
		}
		InputAction inputAction = new InputAction(name, type)
		{
			expectedControlType = expectedControlLayout
		};
		inputAction.GenerateId();
		ArrayHelpers.Append(ref map.m_Actions, inputAction);
		inputAction.m_ActionMap = map;
		if (!string.IsNullOrEmpty(binding))
		{
			inputAction.AddBinding(binding, interactions, processors, groups);
		}
		else
		{
			if (!string.IsNullOrEmpty(groups))
			{
				throw new ArgumentException($"No binding path was specified for action '{inputAction}' but groups was specified ('{groups}'); cannot apply groups without binding", "groups");
			}
			inputAction.m_Interactions = interactions;
			inputAction.m_Processors = processors;
			map.OnSetupChanged();
		}
		return inputAction;
	}

	public static void RemoveAction(this InputAction action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		InputActionMap actionMap = action.actionMap;
		if (actionMap == null)
		{
			throw new ArgumentException($"Action '{action}' does not belong to an action map; nowhere to remove from", "action");
		}
		actionMap.OnWantToChangeSetup();
		InputBinding[] array = action.bindings.ToArray();
		int index = actionMap.m_Actions.IndexOfReference(action);
		ArrayHelpers.EraseAt(ref actionMap.m_Actions, index);
		action.m_ActionMap = null;
		action.m_SingletonActionBindings = array;
		int num = actionMap.m_Bindings.Length - array.Length;
		if (num == 0)
		{
			actionMap.m_Bindings = null;
		}
		else
		{
			InputBinding[] array2 = new InputBinding[num];
			InputBinding[] bindings = actionMap.m_Bindings;
			int num2 = 0;
			foreach (InputBinding binding in bindings)
			{
				if (array.IndexOf((InputBinding b) => b == binding) == -1)
				{
					array2[num2++] = binding;
				}
			}
			actionMap.m_Bindings = array2;
		}
		actionMap.OnSetupChanged();
	}

	public static void RemoveAction(this InputActionAsset asset, string nameOrId)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (nameOrId == null)
		{
			throw new ArgumentNullException("nameOrId");
		}
		asset.FindAction(nameOrId)?.RemoveAction();
	}

	public static BindingSyntax AddBinding(this InputAction action, string path, string interactions = null, string processors = null, string groups = null)
	{
		return action.AddBinding(new InputBinding
		{
			path = path,
			interactions = interactions,
			processors = processors,
			groups = groups
		});
	}

	public static BindingSyntax AddBinding(this InputAction action, InputControl control)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		return action.AddBinding(control.path);
	}

	public static BindingSyntax AddBinding(this InputAction action, InputBinding binding = default(InputBinding))
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		binding.action = action.name;
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		int bindingIndexInMap = AddBindingInternal(orCreateActionMap, binding);
		return new BindingSyntax(orCreateActionMap, bindingIndexInMap);
	}

	public static BindingSyntax AddBinding(this InputActionMap actionMap, string path, string interactions = null, string groups = null, string action = null, string processors = null)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path", "Binding path cannot be null");
		}
		return actionMap.AddBinding(new InputBinding
		{
			path = path,
			interactions = interactions,
			groups = groups,
			action = action,
			processors = processors
		});
	}

	public static BindingSyntax AddBinding(this InputActionMap actionMap, string path, InputAction action, string interactions = null, string groups = null)
	{
		if (action != null && action.actionMap != actionMap)
		{
			throw new ArgumentException($"Action '{action}' is not part of action map '{actionMap}'", "action");
		}
		if (action == null)
		{
			return actionMap.AddBinding(path, interactions, groups);
		}
		return actionMap.AddBinding(path, action.id, interactions, groups);
	}

	public static BindingSyntax AddBinding(this InputActionMap actionMap, string path, Guid action, string interactions = null, string groups = null)
	{
		if (action == Guid.Empty)
		{
			return actionMap.AddBinding(path, interactions, groups);
		}
		return actionMap.AddBinding(path, interactions, groups, action.ToString());
	}

	public static BindingSyntax AddBinding(this InputActionMap actionMap, InputBinding binding)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (binding.path == null)
		{
			throw new ArgumentException("Binding path cannot be null", "binding");
		}
		int bindingIndexInMap = AddBindingInternal(actionMap, binding);
		return new BindingSyntax(actionMap, bindingIndexInMap);
	}

	public static CompositeSyntax AddCompositeBinding(this InputAction action, string composite, string interactions = null, string processors = null)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (string.IsNullOrEmpty(composite))
		{
			throw new ArgumentException("Composite name cannot be null or empty", "composite");
		}
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		InputBinding binding = new InputBinding
		{
			name = NameAndParameters.ParseName(composite),
			path = composite,
			interactions = interactions,
			processors = processors,
			isComposite = true,
			action = action.name
		};
		int compositeIndex = AddBindingInternal(orCreateActionMap, binding);
		return new CompositeSyntax(orCreateActionMap, action, compositeIndex);
	}

	private static int AddBindingInternal(InputActionMap map, InputBinding binding, int bindingIndex = -1)
	{
		if (string.IsNullOrEmpty(binding.m_Id))
		{
			binding.GenerateId();
		}
		if (bindingIndex < 0)
		{
			bindingIndex = ArrayHelpers.Append(ref map.m_Bindings, binding);
		}
		else
		{
			ArrayHelpers.InsertAt(ref map.m_Bindings, bindingIndex, binding);
		}
		if (map.asset != null)
		{
			map.asset.MarkAsDirty();
		}
		if (map.m_SingletonAction != null)
		{
			map.m_SingletonAction.m_SingletonActionBindings = map.m_Bindings;
		}
		map.OnBindingModified();
		return bindingIndex;
	}

	public static BindingSyntax ChangeBinding(this InputAction action, int index)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		int bindingIndexInMap = action.BindingIndexOnActionToBindingIndexOnMap(index);
		return new BindingSyntax(action.GetOrCreateActionMap(), bindingIndexInMap, action);
	}

	public static BindingSyntax ChangeBinding(this InputAction action, string name)
	{
		return action.ChangeBinding(new InputBinding
		{
			name = name
		});
	}

	public static BindingSyntax ChangeBinding(this InputActionMap actionMap, int index)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (index < 0 || index >= actionMap.m_Bindings.LengthSafe())
		{
			throw new ArgumentOutOfRangeException("index");
		}
		return new BindingSyntax(actionMap, index);
	}

	public static BindingSyntax ChangeBindingWithId(this InputAction action, string id)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		return action.ChangeBinding(new InputBinding
		{
			m_Id = id
		});
	}

	public static BindingSyntax ChangeBindingWithId(this InputAction action, Guid id)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		return action.ChangeBinding(new InputBinding
		{
			id = id
		});
	}

	public static BindingSyntax ChangeBindingWithGroup(this InputAction action, string group)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		return action.ChangeBinding(new InputBinding
		{
			groups = group
		});
	}

	public static BindingSyntax ChangeBindingWithPath(this InputAction action, string path)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		return action.ChangeBinding(new InputBinding
		{
			path = path
		});
	}

	public static BindingSyntax ChangeBinding(this InputAction action, InputBinding match)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		int num = -1;
		_ = action.idDontGenerate;
		match.action = action.id.ToString();
		num = orCreateActionMap.FindBindingRelativeToMap(match);
		if (num == -1)
		{
			match.action = action.name;
			num = orCreateActionMap.FindBindingRelativeToMap(match);
		}
		if (num == -1)
		{
			return default(BindingSyntax);
		}
		return new BindingSyntax(orCreateActionMap, num, action);
	}

	public static BindingSyntax ChangeCompositeBinding(this InputAction action, string compositeName)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (string.IsNullOrEmpty(compositeName))
		{
			throw new ArgumentNullException("compositeName");
		}
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		InputBinding[] bindings = orCreateActionMap.m_Bindings;
		int num = bindings.LengthSafe();
		for (int i = 0; i < num; i++)
		{
			ref InputBinding reference = ref bindings[i];
			if (reference.isComposite && reference.TriggersAction(action) && (compositeName.Equals(reference.name, StringComparison.InvariantCultureIgnoreCase) || compositeName.Equals(NameAndParameters.ParseName(reference.path), StringComparison.InvariantCultureIgnoreCase)))
			{
				return new BindingSyntax(orCreateActionMap, i, action);
			}
		}
		return default(BindingSyntax);
	}

	public static void Rename(this InputAction action, string newName)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (string.IsNullOrEmpty(newName))
		{
			throw new ArgumentNullException("newName");
		}
		if (action.name == newName)
		{
			return;
		}
		InputActionMap actionMap = action.actionMap;
		if (actionMap?.FindAction(newName) != null)
		{
			throw new InvalidOperationException($"Cannot rename '{action}' to '{newName}' in map '{actionMap}' as the map already contains an action with that name");
		}
		string name = action.m_Name;
		action.m_Name = newName;
		actionMap?.ClearActionLookupTable();
		if (actionMap?.asset != null)
		{
			actionMap?.asset.MarkAsDirty();
		}
		InputBinding[] bindings = action.GetOrCreateActionMap().m_Bindings;
		int num = bindings.LengthSafe();
		for (int i = 0; i < num; i++)
		{
			if (string.Compare(bindings[i].action, name, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				bindings[i].action = newName;
			}
		}
	}

	public static void AddControlScheme(this InputActionAsset asset, InputControlScheme controlScheme)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (string.IsNullOrEmpty(controlScheme.name))
		{
			throw new ArgumentException("Cannot add control scheme without name to asset " + asset.name, "controlScheme");
		}
		if (asset.FindControlScheme(controlScheme.name).HasValue)
		{
			throw new InvalidOperationException("Asset '" + asset.name + "' already contains a control scheme called '" + controlScheme.name + "'");
		}
		ArrayHelpers.Append(ref asset.m_ControlSchemes, controlScheme);
		asset.MarkAsDirty();
	}

	public static ControlSchemeSyntax AddControlScheme(this InputActionAsset asset, string name)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		int count = asset.controlSchemes.Count;
		asset.AddControlScheme(new InputControlScheme(name));
		return new ControlSchemeSyntax(asset, count);
	}

	public static void RemoveControlScheme(this InputActionAsset asset, string name)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		int num = asset.FindControlSchemeIndex(name);
		if (num != -1)
		{
			ArrayHelpers.EraseAt(ref asset.m_ControlSchemes, num);
		}
		asset.MarkAsDirty();
	}

	public static InputControlScheme WithBindingGroup(this InputControlScheme scheme, string bindingGroup)
	{
		return new ControlSchemeSyntax(scheme).WithBindingGroup(bindingGroup).Done();
	}

	public static InputControlScheme WithDevice(this InputControlScheme scheme, string controlPath, bool required)
	{
		if (required)
		{
			return new ControlSchemeSyntax(scheme).WithRequiredDevice(controlPath).Done();
		}
		return new ControlSchemeSyntax(scheme).WithOptionalDevice(controlPath).Done();
	}

	public static InputControlScheme WithRequiredDevice(this InputControlScheme scheme, string controlPath)
	{
		return new ControlSchemeSyntax(scheme).WithRequiredDevice(controlPath).Done();
	}

	public static InputControlScheme WithOptionalDevice(this InputControlScheme scheme, string controlPath)
	{
		return new ControlSchemeSyntax(scheme).WithOptionalDevice(controlPath).Done();
	}

	public static InputControlScheme OrWithRequiredDevice(this InputControlScheme scheme, string controlPath)
	{
		return new ControlSchemeSyntax(scheme).OrWithRequiredDevice(controlPath).Done();
	}

	public static InputControlScheme OrWithOptionalDevice(this InputControlScheme scheme, string controlPath)
	{
		return new ControlSchemeSyntax(scheme).OrWithOptionalDevice(controlPath).Done();
	}
}
