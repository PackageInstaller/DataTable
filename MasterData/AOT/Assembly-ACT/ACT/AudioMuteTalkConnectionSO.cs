using ACT.Sound;
using Fundamental;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Audio/MuteTalk")]
public class AudioMuteTalkConnectionSO : BoolConnectionSO
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
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Voice, 0f);
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Voice, m_Setting.Owner.GetSettingFloat("Audio.Volume.Talk").GetValue() / 100f);
			}
		}

		public override void Set(bool value)
		{
			if (value)
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Voice, 0f);
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Voice, m_Setting.Owner.GetSettingFloat("Audio.Volume.Talk").GetValue() / 100f);
			}
		}
	}

	public override IConnection<bool> CreateConnection(ISettingWithValue<bool> owner)
	{
		return new Connection(this, owner);
	}
}
