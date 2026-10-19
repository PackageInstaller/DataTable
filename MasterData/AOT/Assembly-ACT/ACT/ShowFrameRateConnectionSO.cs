using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Other/Show FrameRate")]
public class ShowFrameRateConnectionSO : BoolConnectionSO
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
			ShowFps evt = Singleton<EventManager>.instance.GetEvt<ShowFps>();
			evt.show = value;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ShowFps, evt);
		}

		public override void Set(bool value)
		{
			ShowFps evt = Singleton<EventManager>.instance.GetEvt<ShowFps>();
			evt.show = value;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ShowFps, evt);
			m_Setting.Owner.GetSettingBool("Other.ShowFrameRate")?.SetValue(value);
		}
	}

	public override IConnection<bool> CreateConnection(ISettingWithValue<bool> owner)
	{
		return new Connection(this, owner);
	}
}
