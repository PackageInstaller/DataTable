using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/Resolution")]
public class ResolutionConnectionSO : OptionsConnectionSO<string>
{
	[Serializable]
	public class AspectRatioPreset
	{
		public string Name;

		public float AspectRatio;

		public List<Vector2Int> Resolutions = new List<Vector2Int>();
	}

	internal class Connection : BaseConnectionWithOptions<string>
	{
		private List<Vector2Int> _resolutions = new List<Vector2Int>();

		private List<string> _labels = new List<string>();

		public ResolutionConnectionSO TConnectionSO => m_ConnectionSO as ResolutionConnectionSO;

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
			RefreshOptions();
		}

		public override int GetDefault()
		{
			return Mathf.Clamp(TConnectionSO.Default, 0, Mathf.Max(0, _resolutions.Count - 1));
		}

		public override void Init(int value)
		{
			ApplyResolution(GetAppliedResolutionOption(value));
		}

		public override void Set(int value)
		{
			ApplyResolution(GetAppliedResolutionOption(value));
			if (IsWindowed())
			{
				PlayerPrefs.SetInt("Graphic.ResolutionCache", value);
			}
		}

		private int GetAppliedResolutionOption(int value)
		{
			if (!IsWindowed())
			{
				return 0;
			}
			return value;
		}

		private bool IsWindowed()
		{
			SettingOptions settingOptions = m_Setting.Owner.GetSettingOptions("Graphic.WindowStyle");
			if (settingOptions == null)
			{
				return false;
			}
			return settingOptions.GetValue() == 1;
		}

		private void ApplyResolution(int value)
		{
			if (value >= 0 && value < _resolutions.Count)
			{
				Vector2Int vector2Int = _resolutions[value];
				Screen.SetResolution(vector2Int.x, vector2Int.y, Screen.fullScreenMode);
			}
		}

		public bool TryGetResolutionValue(int value, out Vector2Int resolution)
		{
			if (value < 0 || value >= _resolutions.Count)
			{
				resolution = default;
				return false;
			}
			resolution = _resolutions[value];
			return true;
		}

		public Vector2Int GetResolutionValue(int value)
		{
			if (value < 0 || value >= _resolutions.Count)
			{
				return default;
			}
			return _resolutions[value];
		}

		public override bool HasOptions()
		{
			return _labels.Count > 0;
		}

		public override List<string> GetOptionLabels()
		{
			return _labels;
		}

		public override void RefreshOptions()
		{
			_resolutions.Clear();
			_labels.Clear();
			ResolutionConnectionSO tConnectionSO = TConnectionSO;
			int width = Screen.currentResolution.width;
			int height = Screen.currentResolution.height;
			float num = (float)width / (float)height;
			AspectRatioPreset aspectRatioPreset = null;
			foreach (AspectRatioPreset preset in tConnectionSO.Presets)
			{
				if (Mathf.Abs(num - preset.AspectRatio) < tConnectionSO.AspectMatchTolerance)
				{
					aspectRatioPreset = preset;
					break;
				}
			}
			if (aspectRatioPreset != null)
			{
				Vector2Int item = new Vector2Int(width, height);
				_resolutions.Add(item);
				foreach (Vector2Int resolution in aspectRatioPreset.Resolutions)
				{
					if (resolution.x < width && resolution.y < height && !_resolutions.Contains(resolution))
					{
						_resolutions.Add(resolution);
					}
					if (_resolutions.Count >= tConnectionSO.MaxOptions)
					{
						break;
					}
				}
			}
			else
			{
				_resolutions.Add(new Vector2Int(width, height));
				foreach (float fallbackScale in tConnectionSO.FallbackScales)
				{
					int num2 = (int)((float)width * fallbackScale) / 2 * 2;
					int num3 = (int)((float)height * fallbackScale) / 2 * 2;
					if (num2 > 0 && num3 > 0)
					{
						_resolutions.Add(new Vector2Int(num2, num3));
					}
					if (_resolutions.Count >= tConnectionSO.MaxOptions)
					{
						break;
					}
				}
			}
			foreach (Vector2Int resolution2 in _resolutions)
			{
				_labels.Add($"{resolution2.x} x {resolution2.y}");
			}
		}
	}

	internal const string ResolutionCacheKey = "Graphic.ResolutionCache";

	internal const int DisplayResolutionOption = 0;

	internal const int WindowedStyleOption = 1;

	[Header("比例-分辨率预设表")]
	public List<AspectRatioPreset> Presets = new List<AspectRatioPreset>();

	[Header("最大选项数")]
	public int MaxOptions = 5;

	[Header("近似匹配容差")]
	public float AspectMatchTolerance = 0.02f;

	[Header("Fallback-缩放比例")]
	public List<float> FallbackScales = new List<float> { 0.75f, 0.667f, 0.5f };

	[Header("当前端默认值")]
	public int Default;

	protected override IConnectionWithOptions<string> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner);
	}
}
