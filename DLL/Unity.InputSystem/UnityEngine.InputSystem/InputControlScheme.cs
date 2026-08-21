using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Unity.Collections;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[Serializable]
public struct InputControlScheme : IEquatable<InputControlScheme>
{
	public struct MatchResult : IEnumerable<MatchResult.Match>, IEnumerable, IDisposable
	{
		internal enum Result
		{
			AllSatisfied,
			MissingRequired,
			MissingOptional
		}

		public struct Match
		{
			internal int m_RequirementIndex;

			internal DeviceRequirement[] m_Requirements;

			internal InputControlList<InputControl> m_Controls;

			public InputControl control => m_Controls[m_RequirementIndex];

			public InputDevice device => control?.device;

			public int requirementIndex => m_RequirementIndex;

			public DeviceRequirement requirement => m_Requirements[m_RequirementIndex];

			public bool isOptional => requirement.isOptional;
		}

		private struct Enumerator : IEnumerator<Match>, IEnumerator, IDisposable
		{
			internal int m_Index;

			internal DeviceRequirement[] m_Requirements;

			internal InputControlList<InputControl> m_Controls;

			public Match Current
			{
				get
				{
					if (m_Requirements == null || m_Index < 0 || m_Index >= m_Requirements.Length)
					{
						throw new InvalidOperationException("Enumerator is not valid");
					}
					return new Match
					{
						m_RequirementIndex = m_Index,
						m_Requirements = m_Requirements,
						m_Controls = m_Controls
					};
				}
			}

			object IEnumerator.Current => Current;

			public bool MoveNext()
			{
				m_Index++;
				if (m_Requirements != null)
				{
					return m_Index < m_Requirements.Length;
				}
				return false;
			}

			public void Reset()
			{
				m_Index = -1;
			}

			public void Dispose()
			{
			}
		}

		internal Result m_Result;

		internal float m_Score;

		internal InputControlList<InputDevice> m_Devices;

		internal InputControlList<InputControl> m_Controls;

		internal DeviceRequirement[] m_Requirements;

		public float score => m_Score;

		public bool isSuccessfulMatch => m_Result != Result.MissingRequired;

		public bool hasMissingRequiredDevices => m_Result == Result.MissingRequired;

		public bool hasMissingOptionalDevices => m_Result == Result.MissingOptional;

		public InputControlList<InputDevice> devices
		{
			get
			{
				if (m_Devices.Count == 0 && !hasMissingRequiredDevices)
				{
					int count = m_Controls.Count;
					if (count != 0)
					{
						m_Devices.Capacity = count;
						for (int i = 0; i < count; i++)
						{
							InputControl inputControl = m_Controls[i];
							if (inputControl != null)
							{
								InputDevice device = inputControl.device;
								if (!m_Devices.Contains(device))
								{
									m_Devices.Add(device);
								}
							}
						}
					}
				}
				return m_Devices;
			}
		}

		public Match this[int index]
		{
			get
			{
				if (index < 0 || m_Requirements == null || index >= m_Requirements.Length)
				{
					throw new ArgumentOutOfRangeException("index");
				}
				return new Match
				{
					m_RequirementIndex = index,
					m_Requirements = m_Requirements,
					m_Controls = m_Controls
				};
			}
		}

		public IEnumerator<Match> GetEnumerator()
		{
			return new Enumerator
			{
				m_Index = -1,
				m_Requirements = m_Requirements,
				m_Controls = m_Controls
			};
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		public void Dispose()
		{
			m_Controls.Dispose();
			m_Devices.Dispose();
		}
	}

	[Serializable]
	public struct DeviceRequirement : IEquatable<DeviceRequirement>
	{
		[Flags]
		internal enum Flags
		{
			None = 0,
			Optional = 1,
			Or = 2
		}

		[SerializeField]
		internal string m_ControlPath;

		[SerializeField]
		internal Flags m_Flags;

		public string controlPath
		{
			get
			{
				return m_ControlPath;
			}
			set
			{
				m_ControlPath = value;
			}
		}

		public bool isOptional
		{
			get
			{
				return (m_Flags & Flags.Optional) != 0;
			}
			set
			{
				if (value)
				{
					m_Flags |= Flags.Optional;
				}
				else
				{
					m_Flags &= ~Flags.Optional;
				}
			}
		}

		public bool isAND
		{
			get
			{
				return !isOR;
			}
			set
			{
				isOR = !value;
			}
		}

		public bool isOR
		{
			get
			{
				return (m_Flags & Flags.Or) != 0;
			}
			set
			{
				if (value)
				{
					m_Flags |= Flags.Or;
				}
				else
				{
					m_Flags &= ~Flags.Or;
				}
			}
		}

		public override string ToString()
		{
			if (!string.IsNullOrEmpty(controlPath))
			{
				if (isOptional)
				{
					return controlPath + " (Optional)";
				}
				return controlPath + " (Required)";
			}
			return base.ToString();
		}

		public bool Equals(DeviceRequirement other)
		{
			if (string.Equals(m_ControlPath, other.m_ControlPath) && m_Flags == other.m_Flags && string.Equals(controlPath, other.controlPath))
			{
				return isOptional == other.isOptional;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj == null)
			{
				return false;
			}
			if (obj is DeviceRequirement)
			{
				return Equals((DeviceRequirement)obj);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (((((((m_ControlPath != null) ? m_ControlPath.GetHashCode() : 0) * 397) ^ m_Flags.GetHashCode()) * 397) ^ ((controlPath != null) ? controlPath.GetHashCode() : 0)) * 397) ^ isOptional.GetHashCode();
		}

		public static bool operator ==(DeviceRequirement left, DeviceRequirement right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(DeviceRequirement left, DeviceRequirement right)
		{
			return !left.Equals(right);
		}
	}

	[Serializable]
	internal struct SchemeJson
	{
		[Serializable]
		public struct DeviceJson
		{
			public string devicePath;

			public bool isOptional;

			public bool isOR;

			public DeviceRequirement ToDeviceEntry()
			{
				return new DeviceRequirement
				{
					controlPath = devicePath,
					isOptional = isOptional,
					isOR = isOR
				};
			}

			public static DeviceJson From(DeviceRequirement requirement)
			{
				return new DeviceJson
				{
					devicePath = requirement.controlPath,
					isOptional = requirement.isOptional,
					isOR = requirement.isOR
				};
			}
		}

		public string name;

		public string bindingGroup;

		public DeviceJson[] devices;

		public InputControlScheme ToScheme()
		{
			DeviceRequirement[] array = null;
			if (devices != null && devices.Length != 0)
			{
				int num = devices.Length;
				array = new DeviceRequirement[num];
				for (int i = 0; i < num; i++)
				{
					array[i] = devices[i].ToDeviceEntry();
				}
			}
			return new InputControlScheme
			{
				m_Name = (string.IsNullOrEmpty(name) ? null : name),
				m_BindingGroup = (string.IsNullOrEmpty(bindingGroup) ? null : bindingGroup),
				m_DeviceRequirements = array
			};
		}

		public static SchemeJson ToJson(InputControlScheme scheme)
		{
			DeviceJson[] array = null;
			if (scheme.m_DeviceRequirements != null && scheme.m_DeviceRequirements.Length != 0)
			{
				int num = scheme.m_DeviceRequirements.Length;
				array = new DeviceJson[num];
				for (int i = 0; i < num; i++)
				{
					array[i] = DeviceJson.From(scheme.m_DeviceRequirements[i]);
				}
			}
			return new SchemeJson
			{
				name = scheme.m_Name,
				bindingGroup = scheme.m_BindingGroup,
				devices = array
			};
		}

		public static SchemeJson[] ToJson(InputControlScheme[] schemes)
		{
			if (schemes == null || schemes.Length == 0)
			{
				return null;
			}
			int num = schemes.Length;
			SchemeJson[] array = new SchemeJson[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = ToJson(schemes[i]);
			}
			return array;
		}

		public static InputControlScheme[] ToSchemes(SchemeJson[] schemes)
		{
			if (schemes == null || schemes.Length == 0)
			{
				return null;
			}
			int num = schemes.Length;
			InputControlScheme[] array = new InputControlScheme[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = schemes[i].ToScheme();
			}
			return array;
		}
	}

	[SerializeField]
	internal string m_Name;

	[SerializeField]
	internal string m_BindingGroup;

	[SerializeField]
	internal DeviceRequirement[] m_DeviceRequirements;

	public string name => m_Name;

	public string bindingGroup
	{
		get
		{
			return m_BindingGroup;
		}
		set
		{
			m_BindingGroup = value;
		}
	}

	public ReadOnlyArray<DeviceRequirement> deviceRequirements => new ReadOnlyArray<DeviceRequirement>(m_DeviceRequirements);

	public InputControlScheme(string name, IEnumerable<DeviceRequirement> devices = null, string bindingGroup = null)
	{
		this = default(InputControlScheme);
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		SetNameAndBindingGroup(name, bindingGroup);
		m_DeviceRequirements = null;
		if (devices != null)
		{
			m_DeviceRequirements = devices.ToArray();
			if (m_DeviceRequirements.Length == 0)
			{
				m_DeviceRequirements = null;
			}
		}
	}

	internal void SetNameAndBindingGroup(string name, string bindingGroup = null)
	{
		m_Name = name;
		if (!string.IsNullOrEmpty(bindingGroup))
		{
			m_BindingGroup = bindingGroup;
		}
		else
		{
			m_BindingGroup = (name.Contains(';') ? name.Replace(";", "") : name);
		}
	}

	public static InputControlScheme? FindControlSchemeForDevices<TDevices, TSchemes>(TDevices devices, TSchemes schemes, InputDevice mustIncludeDevice = null, bool allowUnsuccesfulMatch = false) where TDevices : IReadOnlyList<InputDevice> where TSchemes : IEnumerable<InputControlScheme>
	{
		if (devices == null)
		{
			throw new ArgumentNullException("devices");
		}
		if (schemes == null)
		{
			throw new ArgumentNullException("schemes");
		}
		if (!FindControlSchemeForDevices(devices, schemes, out var controlScheme, out var matchResult, mustIncludeDevice, allowUnsuccesfulMatch))
		{
			return null;
		}
		matchResult.Dispose();
		return controlScheme;
	}

	public static bool FindControlSchemeForDevices<TDevices, TSchemes>(TDevices devices, TSchemes schemes, out InputControlScheme controlScheme, out MatchResult matchResult, InputDevice mustIncludeDevice = null, bool allowUnsuccessfulMatch = false) where TDevices : IReadOnlyList<InputDevice> where TSchemes : IEnumerable<InputControlScheme>
	{
		if (devices == null)
		{
			throw new ArgumentNullException("devices");
		}
		if (schemes == null)
		{
			throw new ArgumentNullException("schemes");
		}
		MatchResult? matchResult2 = null;
		InputControlScheme? inputControlScheme = null;
		foreach (InputControlScheme item in schemes)
		{
			MatchResult value = item.PickDevicesFrom(devices, mustIncludeDevice);
			if (!value.isSuccessfulMatch && (!allowUnsuccessfulMatch || value.score <= 0f))
			{
				value.Dispose();
				continue;
			}
			if (mustIncludeDevice != null && !value.devices.Contains(mustIncludeDevice))
			{
				value.Dispose();
				continue;
			}
			if (matchResult2.HasValue && matchResult2.Value.score >= value.score)
			{
				value.Dispose();
				continue;
			}
			matchResult2?.Dispose();
			matchResult2 = value;
			inputControlScheme = item;
		}
		matchResult = matchResult2.GetValueOrDefault();
		controlScheme = inputControlScheme.GetValueOrDefault();
		return matchResult2.HasValue;
	}

	public static InputControlScheme? FindControlSchemeForDevice<TSchemes>(InputDevice device, TSchemes schemes) where TSchemes : IEnumerable<InputControlScheme>
	{
		if (schemes == null)
		{
			throw new ArgumentNullException("schemes");
		}
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		return FindControlSchemeForDevices(new OneOrMore<InputDevice, ReadOnlyArray<InputDevice>>(device), schemes);
	}

	public bool SupportsDevice(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		for (int i = 0; i < m_DeviceRequirements.Length; i++)
		{
			if (InputControlPath.TryFindControl(device, m_DeviceRequirements[i].controlPath) != null)
			{
				return true;
			}
		}
		return false;
	}

	public MatchResult PickDevicesFrom<TDevices>(TDevices devices, InputDevice favorDevice = null) where TDevices : IReadOnlyList<InputDevice>
	{
		if (m_DeviceRequirements == null || m_DeviceRequirements.Length == 0)
		{
			return new MatchResult
			{
				m_Result = MatchResult.Result.AllSatisfied,
				m_Score = 0.5f
			};
		}
		bool flag = true;
		bool flag2 = true;
		int num = m_DeviceRequirements.Length;
		float num2 = 0f;
		InputControlList<InputControl> controls = new InputControlList<InputControl>(Allocator.Persistent, num);
		try
		{
			bool flag3 = false;
			bool flag4 = false;
			for (int i = 0; i < num; i++)
			{
				bool isOR = m_DeviceRequirements[i].isOR;
				bool isOptional = m_DeviceRequirements[i].isOptional;
				if (isOR & flag3)
				{
					controls.Add(null);
					continue;
				}
				string controlPath = m_DeviceRequirements[i].controlPath;
				if (string.IsNullOrEmpty(controlPath))
				{
					num2++;
					controls.Add(null);
					continue;
				}
				InputControl inputControl = null;
				for (int j = 0; j < devices.Count; j++)
				{
					InputDevice inputDevice = devices[j];
					if (favorDevice != null)
					{
						if (j == 0)
						{
							inputDevice = favorDevice;
						}
						else if (inputDevice == favorDevice)
						{
							inputDevice = devices[0];
						}
					}
					InputControl inputControl2 = InputControlPath.TryFindControl(inputDevice, controlPath);
					if (inputControl2 != null && !controls.Contains(inputControl2))
					{
						inputControl = inputControl2;
						InternedString firstLayout = new InternedString(InputControlPath.TryGetDeviceLayout(controlPath));
						if (firstLayout.IsEmpty())
						{
							num2++;
							break;
						}
						InternedString layout = inputControl2.device.m_Layout;
						num2 = ((!InputControlLayout.s_Layouts.ComputeDistanceInInheritanceHierarchy(firstLayout, layout, out var distance)) ? (num2 + 1f) : (num2 + (1f + 1f / (float)(Math.Abs(distance) + 1))));
						break;
					}
				}
				if (i + 1 < num && m_DeviceRequirements[i + 1].isOR)
				{
					if (inputControl != null)
					{
						flag3 = true;
					}
					else if (!isOptional)
					{
						flag4 = true;
					}
				}
				else if (isOR && i == num - 1)
				{
					if (inputControl == null)
					{
						if (flag4)
						{
							flag = false;
						}
						else
						{
							flag2 = false;
						}
					}
				}
				else
				{
					if (inputControl == null)
					{
						if (isOptional)
						{
							flag2 = false;
						}
						else
						{
							flag = false;
						}
					}
					if (i > 0 && m_DeviceRequirements[i - 1].isOR)
					{
						if (!flag3)
						{
							if (flag4)
							{
								flag = false;
							}
							else
							{
								flag2 = false;
							}
						}
						flag3 = false;
					}
				}
				controls.Add(inputControl);
			}
		}
		catch (Exception)
		{
			controls.Dispose();
			throw;
		}
		return new MatchResult
		{
			m_Result = ((!flag) ? MatchResult.Result.MissingRequired : ((!flag2) ? MatchResult.Result.MissingOptional : MatchResult.Result.AllSatisfied)),
			m_Controls = controls,
			m_Requirements = m_DeviceRequirements,
			m_Score = num2
		};
	}

	public bool Equals(InputControlScheme other)
	{
		if (!string.Equals(m_Name, other.m_Name, StringComparison.InvariantCultureIgnoreCase) || !string.Equals(m_BindingGroup, other.m_BindingGroup, StringComparison.InvariantCultureIgnoreCase))
		{
			return false;
		}
		if (m_DeviceRequirements == null || m_DeviceRequirements.Length == 0)
		{
			if (other.m_DeviceRequirements != null)
			{
				return other.m_DeviceRequirements.Length == 0;
			}
			return true;
		}
		if (other.m_DeviceRequirements == null || m_DeviceRequirements.Length != other.m_DeviceRequirements.Length)
		{
			return false;
		}
		int num = m_DeviceRequirements.Length;
		for (int i = 0; i < num; i++)
		{
			DeviceRequirement deviceRequirement = m_DeviceRequirements[i];
			bool flag = false;
			for (int j = 0; j < num; j++)
			{
				if (other.m_DeviceRequirements[j] == deviceRequirement)
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

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is InputControlScheme)
		{
			return Equals((InputControlScheme)obj);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((((m_Name != null) ? m_Name.GetHashCode() : 0) * 397) ^ ((m_BindingGroup != null) ? m_BindingGroup.GetHashCode() : 0)) * 397) ^ ((m_DeviceRequirements != null) ? m_DeviceRequirements.GetHashCode() : 0);
	}

	public override string ToString()
	{
		if (string.IsNullOrEmpty(m_Name))
		{
			return base.ToString();
		}
		if (m_DeviceRequirements == null)
		{
			return m_Name;
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(m_Name);
		stringBuilder.Append('(');
		bool flag = true;
		DeviceRequirement[] array = m_DeviceRequirements;
		foreach (DeviceRequirement deviceRequirement in array)
		{
			if (!flag)
			{
				stringBuilder.Append(',');
			}
			stringBuilder.Append(deviceRequirement.controlPath);
			flag = false;
		}
		stringBuilder.Append(')');
		return stringBuilder.ToString();
	}

	public static bool operator ==(InputControlScheme left, InputControlScheme right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(InputControlScheme left, InputControlScheme right)
	{
		return !left.Equals(right);
	}
}
