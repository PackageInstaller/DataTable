using ACT.Event;
using ACT.UI;
using Fundamental;

namespace ACT.Sound.Management;

public class CharacterVoiceManager : Singleton<CharacterVoiceManager>
{
	private const string CharacterVoiceEventPathFormat = "event:/Vo/UI/Role/{0}";

	private uint _voiceInstanceId;

	private uint _voiceOwnerUIId;

	private bool _lifecycleListenersRegistered;

	public override ContextType ContextType => ContextType.GLOBAL;

	public override void Init()
	{
		RegisterLifecycleListeners();
	}

	public override void UnInit()
	{
		UnregisterLifecycleListeners();
		StopCharacterVoice();
	}

	private void RegisterLifecycleListeners()
	{
		if (!_lifecycleListenersRegistered)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change, OnLifecycleInterrupt);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Open, OnLifecycleInterrupt);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Close, OnUIClose);
			_lifecycleListenersRegistered = true;
		}
	}

	private void UnregisterLifecycleListeners()
	{
		if (_lifecycleListenersRegistered)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change, OnLifecycleInterrupt);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Open, OnLifecycleInterrupt);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Close, OnUIClose);
			_lifecycleListenersRegistered = false;
		}
	}

	private void OnLifecycleInterrupt(BaseEventContent obj)
	{
		StopCharacterVoice();
	}

	private void OnUIClose(BaseEventContent obj)
	{
		if (obj is UIEvent { Uid: not 0u } uIEvent && uIEvent.Uid == _voiceOwnerUIId)
		{
			StopCharacterVoice();
		}
	}

	public uint PlayCharacterVoice(int characterId)
	{
		StopCharacterVoice();
		if (characterId <= 0)
		{
			return 0u;
		}
		AudioVoiceManager audioVoiceManager = Singleton<AudioVoiceManager>.instance;
		if (audioVoiceManager == null)
		{
			return 0u;
		}
		string eventPath = $"event:/Vo/UI/Role/{characterId}";
		_voiceInstanceId = audioVoiceManager.Play(eventPath);
		_voiceOwnerUIId = ((_voiceInstanceId != 0) ? (Singleton<NewUIManager>.instance?.GetTopActiveUI()?.Uid).GetValueOrDefault() : 0u);
		return _voiceInstanceId;
	}

	public void StopCharacterVoice()
	{
		if (_voiceInstanceId == 0)
		{
			_voiceOwnerUIId = 0u;
			return;
		}
		AudioVoiceManager audioVoiceManager = Singleton<AudioVoiceManager>.instance;
		AudioManager audioManager = Singleton<GameManager>.instance?.audioManager;
		if (audioManager != null && audioManager.IsPlaying(_voiceInstanceId))
		{
			audioVoiceManager.Stop(_voiceInstanceId, fadeOut: false);
		}
		_voiceInstanceId = 0u;
		_voiceOwnerUIId = 0u;
	}
}
