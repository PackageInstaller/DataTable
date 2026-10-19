using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/RenderScale")]
public class RenderScaleConnectionSO : OptionsConnectionSO<LocalizedString>
{
	internal class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public List<float> RenderScales;

		public RenderScaleConnectionSO TConnectionSO => m_ConnectionSO as RenderScaleConnectionSO;

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override bool GetUsable()
		{
			return PlatformConfig.Usable;
		}

		public override int GetDefault()
		{
			return PlatformConfig.Default;
		}

		public override void Init(int value)
		{
			ApplyRenderScale(value);
		}

		public override void Set(int value)
		{
			ApplyRenderScale(value);
		}

		public void ApplyRenderScale(int value)
		{
			URPGraphicSettings.SetRenderScale(ResolveRenderScale(value));
		}

		public float ResolveRenderScale(int value)
		{
			return GetRenderScale(value);
		}

		private float GetRenderScale(int value)
		{
			if (RenderScales == null || RenderScales.Count == 0)
			{
				return 1f;
			}
			int index = Mathf.Clamp(value, 0, RenderScales.Count - 1);
			return RenderScales[index];
		}

		public override bool HasOptions()
		{
			return PlatformConfig.Options.Count > 0;
		}

		public override List<LocalizedString> GetOptionLabels()
		{
			return PlatformConfig.Options;
		}

		public override void RefreshOptions()
		{
		}
	}

	public OptionsPlatformConfig<LocalizedString> Current;

	public List<float> RenderScales = new List<float>();

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current,
			RenderScales = RenderScales
		};
	}
}
