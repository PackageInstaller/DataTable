using System;
using System.Linq;
using System.Text;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[Serializable]
public struct InputBinding : IEquatable<InputBinding>
{
	[Flags]
	public enum DisplayStringOptions
	{
		DontUseShortDisplayNames = 1,
		DontOmitDevice = 2,
		DontIncludeInteractions = 4,
		IgnoreBindingOverrides = 8
	}

	[Flags]
	internal enum MatchOptions
	{
		EmptyGroupMatchesAny = 1
	}

	[Flags]
	internal enum Flags
	{
		None = 0,
		Composite = 4,
		PartOfComposite = 8
	}

	public const char Separator = ';';

	internal const string kSeparatorString = ";";

	[SerializeField]
	private string m_Name;

	[SerializeField]
	internal string m_Id;

	[SerializeField]
	[Tooltip("Path of the control to bind to. Matched at runtime to controls from InputDevices present at the time.\n\nCan either be graphically from the control picker dropdown UI or edited manually in text mode by clicking the 'T' button. Internally, both methods result in control path strings that look like, for example, \"<Gamepad>/buttonSouth\".")]
	private string m_Path;

	[SerializeField]
	private string m_Interactions;

	[SerializeField]
	private string m_Processors;

	[SerializeField]
	internal string m_Groups;

	[SerializeField]
	private string m_Action;

	[SerializeField]
	internal Flags m_Flags;

	[NonSerialized]
	private string m_OverridePath;

	[NonSerialized]
	private string m_OverrideInteractions;

	[NonSerialized]
	private string m_OverrideProcessors;

	public string name
	{
		get
		{
			return m_Name;
		}
		set
		{
			m_Name = value;
		}
	}

	public Guid id
	{
		get
		{
			if (string.IsNullOrEmpty(m_Id))
			{
				return default(Guid);
			}
			return new Guid(m_Id);
		}
		set
		{
			m_Id = value.ToString();
		}
	}

	public string path
	{
		get
		{
			return m_Path;
		}
		set
		{
			m_Path = value;
		}
	}

	public string overridePath
	{
		get
		{
			return m_OverridePath;
		}
		set
		{
			m_OverridePath = value;
		}
	}

	public string interactions
	{
		get
		{
			return m_Interactions;
		}
		set
		{
			m_Interactions = value;
		}
	}

	public string overrideInteractions
	{
		get
		{
			return m_OverrideInteractions;
		}
		set
		{
			m_OverrideInteractions = value;
		}
	}

	public string processors
	{
		get
		{
			return m_Processors;
		}
		set
		{
			m_Processors = value;
		}
	}

	public string overrideProcessors
	{
		get
		{
			return m_OverrideProcessors;
		}
		set
		{
			m_OverrideProcessors = value;
		}
	}

	public string groups
	{
		get
		{
			return m_Groups;
		}
		set
		{
			m_Groups = value;
		}
	}

	public string action
	{
		get
		{
			return m_Action;
		}
		set
		{
			m_Action = value;
		}
	}

	public bool isComposite
	{
		get
		{
			return (m_Flags & Flags.Composite) == Flags.Composite;
		}
		set
		{
			if (value)
			{
				m_Flags |= Flags.Composite;
			}
			else
			{
				m_Flags &= ~Flags.Composite;
			}
		}
	}

	public bool isPartOfComposite
	{
		get
		{
			return (m_Flags & Flags.PartOfComposite) == Flags.PartOfComposite;
		}
		set
		{
			if (value)
			{
				m_Flags |= Flags.PartOfComposite;
			}
			else
			{
				m_Flags &= ~Flags.PartOfComposite;
			}
		}
	}

	public bool hasOverrides
	{
		get
		{
			if (overridePath == null && overrideProcessors == null)
			{
				return overrideInteractions != null;
			}
			return true;
		}
	}

	public string effectivePath => overridePath ?? path;

	public string effectiveInteractions => overrideInteractions ?? interactions;

	public string effectiveProcessors => overrideProcessors ?? processors;

	internal bool isEmpty
	{
		get
		{
			if (string.IsNullOrEmpty(effectivePath) && string.IsNullOrEmpty(action))
			{
				return string.IsNullOrEmpty(groups);
			}
			return false;
		}
	}

	public InputBinding(string path, string action = null, string groups = null, string processors = null, string interactions = null, string name = null)
	{
		m_Path = path;
		m_Action = action;
		m_Groups = groups;
		m_Processors = processors;
		m_Interactions = interactions;
		m_Name = name;
		m_Id = null;
		m_Flags = Flags.None;
		m_OverridePath = null;
		m_OverrideInteractions = null;
		m_OverrideProcessors = null;
	}

	public string GetNameOfComposite()
	{
		if (!isComposite)
		{
			return null;
		}
		return NameAndParameters.Parse(effectivePath).name;
	}

	internal void GenerateId()
	{
		m_Id = Guid.NewGuid().ToString();
	}

	internal void RemoveOverrides()
	{
		m_OverridePath = null;
		m_OverrideInteractions = null;
		m_OverrideProcessors = null;
	}

	public static InputBinding MaskByGroup(string group)
	{
		return new InputBinding
		{
			groups = group
		};
	}

	public static InputBinding MaskByGroups(params string[] groups)
	{
		return new InputBinding
		{
			groups = string.Join(";", groups.Where((string x) => !string.IsNullOrEmpty(x)))
		};
	}

	public bool Equals(InputBinding other)
	{
		if (string.Equals(effectivePath, other.effectivePath, StringComparison.InvariantCultureIgnoreCase) && string.Equals(effectiveInteractions, other.effectiveInteractions, StringComparison.InvariantCultureIgnoreCase) && string.Equals(effectiveProcessors, other.effectiveProcessors, StringComparison.InvariantCultureIgnoreCase) && string.Equals(groups, other.groups, StringComparison.InvariantCultureIgnoreCase))
		{
			return string.Equals(action, other.action, StringComparison.InvariantCultureIgnoreCase);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is InputBinding other)
		{
			return Equals(other);
		}
		return false;
	}

	public static bool operator ==(InputBinding left, InputBinding right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(InputBinding left, InputBinding right)
	{
		return !(left == right);
	}

	public override int GetHashCode()
	{
		return (((((((((effectivePath != null) ? effectivePath.GetHashCode() : 0) * 397) ^ ((effectiveInteractions != null) ? effectiveInteractions.GetHashCode() : 0)) * 397) ^ ((effectiveProcessors != null) ? effectiveProcessors.GetHashCode() : 0)) * 397) ^ ((groups != null) ? groups.GetHashCode() : 0)) * 397) ^ ((action != null) ? action.GetHashCode() : 0);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (!string.IsNullOrEmpty(action))
		{
			stringBuilder.Append(action);
			stringBuilder.Append(':');
		}
		string value = effectivePath;
		if (!string.IsNullOrEmpty(value))
		{
			stringBuilder.Append(value);
		}
		if (!string.IsNullOrEmpty(groups))
		{
			stringBuilder.Append('[');
			stringBuilder.Append(groups);
			stringBuilder.Append(']');
		}
		return stringBuilder.ToString();
	}

	public string ToDisplayString(DisplayStringOptions options = (DisplayStringOptions)0, InputControl control = null)
	{
		string deviceLayoutName;
		string controlPath;
		return ToDisplayString(out deviceLayoutName, out controlPath, options, control);
	}

	public string ToDisplayString(out string deviceLayoutName, out string controlPath, DisplayStringOptions options = (DisplayStringOptions)0, InputControl control = null)
	{
		if (isComposite)
		{
			deviceLayoutName = null;
			controlPath = null;
			return string.Empty;
		}
		InputControlPath.HumanReadableStringOptions humanReadableStringOptions = InputControlPath.HumanReadableStringOptions.None;
		if ((options & DisplayStringOptions.DontOmitDevice) == 0)
		{
			humanReadableStringOptions |= InputControlPath.HumanReadableStringOptions.OmitDevice;
		}
		if ((options & DisplayStringOptions.DontUseShortDisplayNames) == 0)
		{
			humanReadableStringOptions |= InputControlPath.HumanReadableStringOptions.UseShortNames;
		}
		string text = InputControlPath.ToHumanReadableString(((options & DisplayStringOptions.IgnoreBindingOverrides) != 0) ? path : effectivePath, out deviceLayoutName, out controlPath, humanReadableStringOptions, control);
		if (!string.IsNullOrEmpty(effectiveInteractions) && (options & DisplayStringOptions.DontIncludeInteractions) == 0)
		{
			string text2 = string.Empty;
			foreach (NameAndParameters item in NameAndParameters.ParseMultiple(effectiveInteractions))
			{
				string displayName = InputInteraction.GetDisplayName(item.name);
				if (!string.IsNullOrEmpty(displayName))
				{
					text2 = (string.IsNullOrEmpty(text2) ? displayName : (text2 + " or " + displayName));
				}
			}
			if (!string.IsNullOrEmpty(text2))
			{
				text = text2 + " " + text;
			}
		}
		return text;
	}

	internal bool TriggersAction(InputAction action)
	{
		if (string.Compare(action.name, this.action, StringComparison.InvariantCultureIgnoreCase) != 0)
		{
			return this.action == action.m_Id;
		}
		return true;
	}

	public bool Matches(InputBinding binding)
	{
		return Matches(ref binding);
	}

	internal bool Matches(ref InputBinding binding, MatchOptions options = (MatchOptions)0)
	{
		if (name != null && (binding.name == null || !StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(name, binding.name, ';')))
		{
			return false;
		}
		if (path != null && (binding.path == null || !StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(path, binding.path, ';')))
		{
			return false;
		}
		if (action != null && (binding.action == null || !StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(action, binding.action, ';')))
		{
			return false;
		}
		if (groups != null)
		{
			bool flag = !string.IsNullOrEmpty(binding.groups);
			if (!flag && (options & MatchOptions.EmptyGroupMatchesAny) == 0)
			{
				return false;
			}
			if (flag && !StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(groups, binding.groups, ';'))
			{
				return false;
			}
		}
		if (!string.IsNullOrEmpty(m_Id) && binding.id != id)
		{
			return false;
		}
		return true;
	}
}
