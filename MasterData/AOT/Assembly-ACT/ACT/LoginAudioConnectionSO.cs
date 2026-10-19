using ACT.LocalLoader;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Audio/Mute Login BGM")]
public class LoginAudioConnectionSO : BoolConnectionSO
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
			bool value2 = m_Setting.Owner.GetSettingBool("Audio.Mute.LoginBGM").GetValue();
			Set(value2);
		}

		public override void Set(bool value)
		{
			Object.FindObjectOfType<LocalAudioManager>()?.SoundBtnClick(!value);
		}
	}

	public override IConnection<bool> CreateConnection(ISettingWithValue<bool> owner)
	{
		return new Connection(this, owner);
	}
}
