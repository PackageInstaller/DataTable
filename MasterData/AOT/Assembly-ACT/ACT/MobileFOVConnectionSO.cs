using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Other/MobileFOV")]
public class MobileFOVConnectionSO : OptionsConnectionSO<LocalizedString>
{
	public class Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting) : BaseConnectionWithOptions<LocalizedString>(connectionSO, setting)
	{
		public List<LocalizedString> Options = new List<LocalizedString>();

		public override int GetDefault()
		{
			return 1;
		}

		public override void Init(int value)
		{
		}

		public override void Set(int value)
		{
		}

		public override bool HasOptions()
		{
			return Options.Count > 0;
		}

		public override List<LocalizedString> GetOptionLabels()
		{
			return Options;
		}

		public override void RefreshOptions()
		{
		}
	}

	public LocalizedString Option0;

	public LocalizedString Option1;

	public LocalizedString Option2;

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			Options = new List<LocalizedString> { Option0, Option1, Option2 }
		};
	}
}
