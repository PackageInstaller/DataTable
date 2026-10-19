using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Other/Other Bloodstain Disabled")]
public class OtherBloodstainDisabledSO : BoolConnectionSO
{
	public class Connection : BaseConnection<bool>
	{
		public Connection(ConnectionSO<bool> connectionSO, ISettingWithValue<bool> setting)
			: base(connectionSO, setting)
		{
		}

		public override bool GetDefault()
		{
			return false;
		}

		public override void Init(bool value)
		{
		}

		public override void Set(bool value)
		{
		}
	}

	public override IConnection<bool> CreateConnection(ISettingWithValue<bool> owner)
	{
		return new Connection(this, owner);
	}
}
