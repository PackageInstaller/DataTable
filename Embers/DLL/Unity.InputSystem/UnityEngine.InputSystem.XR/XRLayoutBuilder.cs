using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.XR;

internal class XRLayoutBuilder
{
	private string parentLayout;

	private string interfaceName;

	private XRDeviceDescriptor descriptor;

	private static readonly string[] poseSubControlNames = new string[6] { "/isTracked", "/trackingState", "/position", "/rotation", "/velocity", "/angularVelocity" };

	private static readonly FeatureType[] poseSubControlTypes = new FeatureType[6]
	{
		FeatureType.Binary,
		FeatureType.DiscreteStates,
		FeatureType.Axis3D,
		FeatureType.Rotation,
		FeatureType.Axis3D,
		FeatureType.Axis3D
	};

	private static uint GetSizeOfFeature(XRFeatureDescriptor featureDescriptor)
	{
		return featureDescriptor.featureType switch
		{
			FeatureType.Binary => 1u, 
			FeatureType.DiscreteStates => 4u, 
			FeatureType.Axis1D => 4u, 
			FeatureType.Axis2D => 8u, 
			FeatureType.Axis3D => 12u, 
			FeatureType.Rotation => 16u, 
			FeatureType.Hand => 104u, 
			FeatureType.Bone => 32u, 
			FeatureType.Eyes => 76u, 
			FeatureType.Custom => featureDescriptor.customSize, 
			_ => 0u, 
		};
	}

	private static string SanitizeString(string original, bool allowPaths = false)
	{
		int length = original.Length;
		StringBuilder stringBuilder = new StringBuilder(length);
		for (int i = 0; i < length; i++)
		{
			char c = original[i];
			if (char.IsUpper(c) || char.IsLower(c) || char.IsDigit(c) || c == '_' || (allowPaths && c == '/'))
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	internal static string OnFindLayoutForDevice(ref InputDeviceDescription description, string matchedLayout, InputDeviceExecuteCommandDelegate executeCommandDelegate)
	{
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Invalid comparison between Unknown and I4
		if (description.interfaceName != "XRInputV1" && description.interfaceName != "XRInput")
		{
			return null;
		}
		if (string.IsNullOrEmpty(description.capabilities))
		{
			return null;
		}
		XRDeviceDescriptor xRDeviceDescriptor;
		try
		{
			xRDeviceDescriptor = XRDeviceDescriptor.FromJson(description.capabilities);
		}
		catch (Exception)
		{
			return null;
		}
		if (xRDeviceDescriptor == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(matchedLayout))
		{
			if ((xRDeviceDescriptor.characteristics & 1) != 0)
			{
				matchedLayout = "XRHMD";
			}
			else if ((xRDeviceDescriptor.characteristics & 0x44) == 68)
			{
				matchedLayout = "XRController";
			}
		}
		string text = ((!string.IsNullOrEmpty(description.manufacturer)) ? (SanitizeString(description.interfaceName) + "::" + SanitizeString(description.manufacturer) + "::" + SanitizeString(description.product)) : (SanitizeString(description.interfaceName) + "::" + SanitizeString(description.product)));
		XRLayoutBuilder layout = new XRLayoutBuilder
		{
			descriptor = xRDeviceDescriptor,
			parentLayout = matchedLayout,
			interfaceName = description.interfaceName
		};
		InputSystem.RegisterLayoutBuilder(() => layout.Build(), text, matchedLayout);
		return text;
	}

	private static string ConvertPotentialAliasToName(InputControlLayout layout, string nameOrAlias)
	{
		InternedString internedString = new InternedString(nameOrAlias);
		ReadOnlyArray<InputControlLayout.ControlItem> controls = layout.controls;
		for (int i = 0; i < controls.Count; i++)
		{
			InputControlLayout.ControlItem controlItem = controls[i];
			if (controlItem.name == internedString)
			{
				return nameOrAlias;
			}
			ReadOnlyArray<InternedString> aliases = controlItem.aliases;
			for (int j = 0; j < aliases.Count; j++)
			{
				if (aliases[j] == nameOrAlias)
				{
					return controlItem.name.ToString();
				}
			}
		}
		return nameOrAlias;
	}

	private bool IsSubControl(string name)
	{
		return name.Contains('/');
	}

	private string GetParentControlName(string name)
	{
		int length = name.IndexOf('/');
		return name.Substring(0, length);
	}

	private bool IsPoseControl(List<XRFeatureDescriptor> features, int startIndex)
	{
		for (int i = 0; i < 6; i++)
		{
			if (!features[startIndex + i].name.EndsWith(poseSubControlNames[i]) || features[startIndex + i].featureType != poseSubControlTypes[i])
			{
				return false;
			}
		}
		return true;
	}

	private InputControlLayout Build()
	{
		InputControlLayout.Builder builder = new InputControlLayout.Builder
		{
			stateFormat = new FourCC('X', 'R', 'S', '0'),
			extendsLayout = parentLayout,
			updateBeforeRender = true
		};
		InputControlLayout inputControlLayout = ((!string.IsNullOrEmpty(parentLayout)) ? InputSystem.LoadLayout(parentLayout) : null);
		List<string> list = new List<string>();
		List<string> list2 = new List<string>();
		uint num = 0u;
		for (int i = 0; i < descriptor.inputFeatures.Count; i++)
		{
			XRFeatureDescriptor featureDescriptor = descriptor.inputFeatures[i];
			list2.Clear();
			if (featureDescriptor.usageHints != null)
			{
				foreach (UsageHint usageHint in featureDescriptor.usageHints)
				{
					if (!string.IsNullOrEmpty(usageHint.content))
					{
						list2.Add(usageHint.content);
					}
				}
			}
			string name = featureDescriptor.name;
			name = SanitizeString(name, allowPaths: true);
			if (inputControlLayout != null)
			{
				name = ConvertPotentialAliasToName(inputControlLayout, name);
			}
			name = name.ToLower();
			if (IsSubControl(name))
			{
				string parentControlName = GetParentControlName(name);
				if (!list.Contains(parentControlName) && IsPoseControl(descriptor.inputFeatures, i))
				{
					builder.AddControl(parentControlName).WithLayout("Pose").WithByteOffset(0u);
					list.Add(parentControlName);
				}
			}
			uint num2 = GetSizeOfFeature(featureDescriptor);
			if (interfaceName == "XRInput")
			{
				if (num2 < 4)
				{
					num2 = 4u;
				}
			}
			else if (num2 >= 4 && num % 4 != 0)
			{
				num += 4 - num % 4;
			}
			switch (featureDescriptor.featureType)
			{
			case FeatureType.Binary:
				builder.AddControl(name).WithLayout("Button").WithByteOffset(num)
					.WithFormat(InputStateBlock.FormatBit)
					.WithUsages(list2);
				break;
			case FeatureType.DiscreteStates:
				builder.AddControl(name).WithLayout("Integer").WithByteOffset(num)
					.WithFormat(InputStateBlock.FormatInt)
					.WithUsages(list2);
				break;
			case FeatureType.Axis1D:
				builder.AddControl(name).WithLayout("Analog").WithRange(-1f, 1f)
					.WithByteOffset(num)
					.WithFormat(InputStateBlock.FormatFloat)
					.WithUsages(list2);
				break;
			case FeatureType.Axis2D:
				builder.AddControl(name).WithLayout("Stick").WithByteOffset(num)
					.WithFormat(InputStateBlock.FormatVector2)
					.WithUsages(list2);
				builder.AddControl(name + "/x").WithLayout("Analog").WithRange(-1f, 1f);
				builder.AddControl(name + "/y").WithLayout("Analog").WithRange(-1f, 1f);
				break;
			case FeatureType.Axis3D:
				builder.AddControl(name).WithLayout("Vector3").WithByteOffset(num)
					.WithFormat(InputStateBlock.FormatVector3)
					.WithUsages(list2);
				break;
			case FeatureType.Rotation:
				builder.AddControl(name).WithLayout("Quaternion").WithByteOffset(num)
					.WithFormat(InputStateBlock.FormatQuaternion)
					.WithUsages(list2);
				break;
			case FeatureType.Bone:
				builder.AddControl(name).WithLayout("Bone").WithByteOffset(num)
					.WithUsages(list2);
				break;
			case FeatureType.Eyes:
				builder.AddControl(name).WithLayout("Eyes").WithByteOffset(num)
					.WithUsages(list2);
				break;
			}
			num += num2;
		}
		return builder.Build();
	}
}
