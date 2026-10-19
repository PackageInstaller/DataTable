using System.Collections.Generic;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/FrameRate")]
public class FrameRateConnectionSO : OptionsConnectionSO<string>
{
	private class Connection : BaseConnectionWithOptions<string>
	{
		public OptionsPlatformConfig<string> PlatformConfig;

		public List<int> FrameRates;

		private const int HighFrameRate = 60;

		private const int LowFrameRate = 30;

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override int GetDefault()
		{
			return PlatformConfig.Default;
		}

		public override void Init(int value)
		{
			ResetFrameRate(FrameRates[value]);
		}

		public override void Set(int value)
		{
			ResetFrameRate(FrameRates[value]);
		}

		private void ResetFrameRate(int frame)
		{
			SettingsManager.Instance.FrameRateLimiter.SetTargetFrameRate(frame);
			int num = 60;
			Time.fixedDeltaTime = 1f / (float)num;
			Time.maximumDeltaTime = Time.fixedDeltaTime * 3f;
		}

		public override bool HasOptions()
		{
			return PlatformConfig.Options.Count > 0;
		}

		public override List<string> GetOptionLabels()
		{
			return PlatformConfig.Options;
		}

		public override void RefreshOptions()
		{
		}
	}

	public OptionsPlatformConfig<string> Current;

	public List<int> CurrentFrameRates = new List<int>();

	protected override IConnectionWithOptions<string> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current,
			FrameRates = CurrentFrameRates
		};
	}
}
