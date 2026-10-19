using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Sound.Management;
using ACT.UI;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT;

public class InteractiveDialogueManager : Singleton<InteractiveDialogueManager>
{
	private bool _asideIsPlaying;

	private bool _isInAsideOverCd;

	private Looper _looper;

	private const float _asideOverCd = 3f;

	private const float _interactiveDialogueCd = 10f;

	private bool _isInInteractiveDialogueCd;

	private Looper _interactiveDialogueCdLooper;

	private int curBattleCharacterId => MonoECS.instance.MainEntityCharacterId;

	public void DispatchTriggerInteractiveDialogue(int behaviourId)
	{
		DialogueCanPlay(behaviourId);
	}

	public async UniTask ForceTriggerInteractiveDialogueForTool(int behaviourId)
	{
		if (behaviourId == 0)
		{
			return;
		}
		if (!CurMainCharacterCanPlaySound(behaviourId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{behaviourId}的行为，不支持当前出战角色{curBattleCharacterId}");
			}
			return;
		}
		MonoAsideView pausedAsideView = null;
		try
		{
			if (_asideIsPlaying && Singleton<DramaVoiceManager>.instance.curDisplayHaveVoice && Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) is MonoBattleMainBaseView monoBattleMainBaseView)
			{
				pausedAsideView = monoBattleMainBaseView.asideUIComp;
				pausedAsideView.Pause();
			}
			CompSound compSound = MonoECS.instance.mainEntity.GetCompSound();
			if (compSound == null)
			{
				return;
			}
			uint voiceInstanceId = compSound.PlayVoice(behaviourId);
			if (voiceInstanceId != 0)
			{
				while (Singleton<GameManager>.instance.audioManager != null && Singleton<GameManager>.instance.audioManager.IsPlaying(voiceInstanceId))
				{
					await UniTask.Yield();
				}
			}
		}
		finally
		{
			if ((bool)pausedAsideView)
			{
				pausedAsideView.Resume();
			}
		}
	}

	public override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnAsideStateChange, OnDramaDisplayStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AudioPlayOver, OnAudioPlayOver);
	}

	public override void UnInit()
	{
		base.UnInit();
		if (_looper.IsValid())
		{
			_looper.Cancel();
		}
		if (_interactiveDialogueCdLooper.IsValid())
		{
			_interactiveDialogueCdLooper.Cancel();
		}
		_isInInteractiveDialogueCd = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnAsideStateChange, OnDramaDisplayStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AudioPlayOver, OnAudioPlayOver);
	}

	private void OnAudioPlayOver(BaseEventContent obj)
	{
		if (!(obj is AudioPlayOverEvt { AudioInstanceId: not 0u }))
		{
			return;
		}
		if (_interactiveDialogueCdLooper.IsValid())
		{
			_interactiveDialogueCdLooper.Cancel();
		}
		_isInInteractiveDialogueCd = true;
		float cdStartTime = Time.unscaledTime;
		_interactiveDialogueCdLooper = UpdateTimer.Default.LoopFrame(1, () =>
		{
			if (!(Time.unscaledTime - cdStartTime < 10f))
			{
				_isInInteractiveDialogueCd = false;
				if (_interactiveDialogueCdLooper.IsValid())
				{
					_interactiveDialogueCdLooper.Cancel();
				}
			}
		});
	}

	private void OnDramaDisplayStateChange(BaseEventContent obj)
	{
		if (!(obj is GameStateChange gameStateChange))
		{
			return;
		}
		_asideIsPlaying = gameStateChange.IsInState;
		if (gameStateChange.IsInState)
		{
			if (_looper.IsValid())
			{
				_looper.Cancel();
			}
			_isInAsideOverCd = true;
		}
		else if (!_looper.IsValid())
		{
			float asideOverTime = Time.unscaledTime;
			_looper = UpdateTimer.Default.LoopFrame(1, () =>
			{
				float unscaledTime = Time.unscaledTime;
				_isInAsideOverCd = unscaledTime - asideOverTime < 3f;
			});
		}
	}

	private bool CurMainCharacterCanPlaySound(int behaviourId)
	{
		return CoreUtils.GetData(behaviourId, RuntimeConfigs.data.characterBehaviors)?.characterId.Contains(curBattleCharacterId) ?? false;
	}

	private bool DialogueCanPlay(int behaviourId)
	{
		if (behaviourId == 0)
		{
			return false;
		}
		if (_isInInteractiveDialogueCd)
		{
			return false;
		}
		if (!CurMainCharacterCanPlaySound(behaviourId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{behaviourId}的行为，不支持当前出战角色{curBattleCharacterId}");
			}
			return false;
		}
		if (_asideIsPlaying)
		{
			return true;
		}
		return !_isInAsideOverCd;
	}
}
