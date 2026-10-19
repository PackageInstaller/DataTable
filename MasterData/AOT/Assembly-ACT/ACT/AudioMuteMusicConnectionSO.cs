using ACT.Sound;
using Fundamental;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Audio/MuteMusic")]
public class AudioMuteMusicConnectionSO : BoolConnectionSO
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
			if (value)
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Music, 0f);
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Music, m_Setting.Owner.GetSettingFloat("Audio.Volume.Music").GetValue() / 100f);
			}
		}

		public override void Set(bool value)
		{
			if (value)
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Music, 0f);
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Music, m_Setting.Owner.GetSettingFloat("Audio.Volume.Music").GetValue() / 100f);
			}
		}
	}

	public override IConnection<bool> CreateConnection(ISettingWithValue<bool> owner)
	{
		return new Connection(this, owner);
	}
}
