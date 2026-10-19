using System.Collections.Generic;
using Fundamental;

namespace ACT.Model;

public class AudioModel : Model<AudioModel>
{
	private readonly List<string> _defaultSounds = new List<string> { "event:/Common/SnapShot/Battle_State", "event:/Common/SnapShot/Game_State" };

	private event AudioEventHandler OnAudioEvent;

	public void PlayDefaultSounds()
	{
		foreach (string defaultSound in _defaultSounds)
		{
			PlaySound(defaultSound);
		}
	}

	public void AddDefaultSound(string soundName)
	{
		if (!_defaultSounds.Contains(soundName))
		{
			_defaultSounds.Add(soundName);
		}
	}

	public void RemoveDefaultSound(string soundName)
	{
		_defaultSounds.Remove(soundName);
	}

	public void PlaySound(string soundName)
	{
		Singleton<GameManager>.instance.audioManager?.PlaySound(soundName);
		OnAudioEvent?.Invoke(soundName);
	}

	protected override void Init()
	{
		PlayDefaultSounds();
	}

	protected override void UnInit()
	{
	}
}
