using System;
using ACT.Sound;
using Fundamental;

namespace Lumin.LoungeSystem;

public class LoungeMusicManager
{
	private MusicBoxData _data;

	public MusicBoxData CurrentData => _data;

	public event Action<int> OnMusicChanged;

	public LoungeMusicManager(MusicBoxData data)
	{
		_data = data;
		OnMusicChanged += OnFavorValueChanged;
	}

	private void OnFavorValueChanged(int musicId)
	{
	}

	public void PlayMusic(int musicId)
	{
		MusicBoxData music = Singleton<LoungeSystemManager>.instance.loungeConfig.GetMusic(musicId);
		if (music != null)
		{
			_data = music;
			Singleton<BGMManager>.instance.SetBGM(BGMType.Special, music?.MusicPath);
			OnMusicChanged?.Invoke(musicId);
		}
	}
}
