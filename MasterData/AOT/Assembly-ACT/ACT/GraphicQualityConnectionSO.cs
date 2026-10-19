using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/GraphicQuality")]
public class GraphicQualityConnectionSO : OptionsConnectionSO<LocalizedString>
{
	internal class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		private enum PresetApplyMode
		{
			PlayerSelection,
			RuntimeDefault,
			RuntimeValue,
			Reset
		}

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override bool GetUsable()
		{
			return m_Setting.Owner?.GetGraphicQualityUsable() ?? false;
		}

		public override int GetDefault()
		{
			return m_Setting.Owner?.GetGraphicQualityDefault() ?? 0;
		}

		public override void Init(int value)
		{
		}

		public override void Set(int value)
		{
			if (TryGetPreset(value, out var preset))
			{
				ApplyPreset(preset, PresetApplyMode.PlayerSelection);
			}
		}

		public override bool HasOptions()
		{
			return GetOptionLabels().Count > 0;
		}

		public override List<LocalizedString> GetOptionLabels()
		{
			return m_Setting.Owner?.GetGraphicQualityOptions() ?? new List<LocalizedString>();
		}

		public override void RefreshOptions()
		{
		}

		public void ApplyPresetAsRuntimeDefault(int value)
		{
			if (TryGetPreset(value, out var preset))
			{
				ApplyPreset(preset, PresetApplyMode.RuntimeDefault);
			}
		}

		public void ApplyPresetAsRuntimeValue(int value, bool forceValues)
		{
			if (TryGetPreset(value, out var preset))
			{
				ApplyPreset(preset, PresetApplyMode.RuntimeValue, forceValues);
			}
		}

		public void ResetToPreset(int value)
		{
			if (TryGetPreset(value, out var preset))
			{
				ApplyPreset(preset, PresetApplyMode.Reset);
			}
		}

		private void ApplyPreset(GraphicGradePreset preset, PresetApplyMode applyMode, bool forceValues = false)
		{
			GameSettings owner = m_Setting.Owner;
			GraphicSettingPreset[] array = preset?.GraphicPresets;
			if (owner == null || array == null)
			{
				return;
			}
			GraphicSettingPreset[] array2 = array;
			foreach (GraphicSettingPreset graphicSettingPreset in array2)
			{
				if (graphicSettingPreset == null || graphicSettingPreset.OnlyForInitUse || graphicSettingPreset.OptionId == "Graphic.Quality")
				{
					continue;
				}
				SettingOptions settingOptions = owner.GetSettingOptions(graphicSettingPreset.OptionId);
				if (settingOptions != null)
				{
					switch (applyMode)
					{
					case PresetApplyMode.RuntimeDefault:
						settingOptions.SetRuntimeDefaultValue(graphicSettingPreset.Value);
						break;
					case PresetApplyMode.RuntimeValue:
						settingOptions.SetRuntimeValue(graphicSettingPreset.Value, forceValues);
						break;
					case PresetApplyMode.Reset:
						settingOptions.ResetToValueFromPreset(graphicSettingPreset.Value);
						break;
					default:
						settingOptions.SetValueFromPreset(graphicSettingPreset.Value);
						break;
					}
				}
			}
		}

		private bool TryGetPreset(int value, out GraphicGradePreset preset)
		{
			preset = null;
			List<LocalizedString> list = m_Setting.Owner?.GetGraphicQualityOptions();
			if (list == null || value < 0 || value >= list.Count - 1)
			{
				return false;
			}
			return m_Setting.Owner.TryGetGraphicQualityPreset(value, out preset);
		}
	}

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner);
	}
}
