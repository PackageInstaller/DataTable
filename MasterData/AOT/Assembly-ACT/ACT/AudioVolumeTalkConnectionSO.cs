using ACT.Sound;
using Fundamental;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Audio/VolumeTalk")]
public class AudioVolumeTalkConnectionSO : FloatConnectionSO
{
	public class Connection : BaseConnection<float>
	{
		public Connection(ConnectionSO<float> connectionSO, ISettingWithValue<float> setting)
			: base(connectionSO, setting)
		{
		}

		public override float GetDefault()
		{
			return 100f;
		}

		public override void Init(float value)
		{
			bool value2 = m_Setting.Owner.GetSettingBool("Audio.Mute.Talk").GetValue();
			Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Voice, ((value <= 0f) | value2) ? 0f : (value / 100f));
		}

		public override void Set(float value)
		{
			bool flag = m_Setting.Owner.GetSettingBool("Audio.Mute.Talk")?.GetValue() ?? false;
			Singleton<GameManager>.instance.audioManager.SetVCAVolume(AudioVCAType.Voice, ((value <= 0f) | flag) ? 0f : (value / 100f));
		}
	}

	public override IConnection<float> CreateConnection(ISettingWithValue<float> owner)
	{
		return new Connection(this, owner);
	}
}
