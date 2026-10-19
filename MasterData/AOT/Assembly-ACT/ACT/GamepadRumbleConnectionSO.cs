using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Other/GamepadRumble")]
public class GamepadRumbleConnectionSO : IntConnectionSO
{
	public class Connection : BaseConnection<int>
	{
		public PlatformConfig<int> PlatformConfig;

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
		}

		public override void Set(int value)
		{
		}
	}

	public PlatformConfig<int> Current;

	public override IConnection<int> CreateConnection(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current
		};
	}
}
