using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Sound;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CommonAcquireCharacterShowView : BaseUIView
{
	public CharacterTimelineShowComponent characterTimelineShowComponent;

	public GameObject GoBlack;

	private CommonAcquireCharacterShowData _viewData;

	private readonly List<CharacterTimelineShowData> _characterShowDataList = new List<CharacterTimelineShowData>();

	private int _currentCharacterIndex;

	private int _characterShowSession;

	private bool _hasShownCharacter;

	private uint _acquireCharacterBgmId;

	private uint _acquireCharacterTimelineId;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		GoBlack.SetActive(value: true);
		_viewData = uiViewData as CommonAcquireCharacterShowData;
		await Singleton<UISceneManager>.instance.LoadScene<CharacterTimelineShowViewScene>(GameLoader.meta.characterTimelineShowSceneReferenceAssetID.GUID);
	}

	protected override void Init()
	{
		base.Init();
		ChangeGameState(show: true);
		_hasShownCharacter = false;
		_currentCharacterIndex = 0;
		_characterShowSession++;
		_characterShowDataList.Clear();
		if (_viewData?.universalItems != null)
		{
			foreach (UniversalItem universalItem in _viewData.universalItems)
			{
				AddCharacterShowData(universalItem);
			}
		}
		if (_characterShowDataList.Count == 0 || characterTimelineShowComponent == null)
		{
			Close();
			return;
		}
		PlayAcquireCharacterBgm();
		characterTimelineShowComponent.Init(_characterShowDataList[0], Station, StopCharacterTimeline, OnCharacterPanelClosed);
		PlayCurrentCharacterTimelineAsync().Forget();
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<CharacterTimelineShowViewScene>();
	}

	protected override void OnMoveToHide()
	{
		_characterShowSession++;
		Singleton<UISceneManager>.instance.CloseScene<CharacterTimelineShowViewScene>();
	}

	public override void Close()
	{
		StopAcquireCharacterSounds();
		Action action = _viewData?.CallBack;
		base.Close();
		action?.Invoke();
	}

	protected override void CloseComplete()
	{
		Singleton<UISceneManager>.instance.ReleaseScene<CharacterTimelineShowViewScene>();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GachaAcquireCharacterShow, OnCharacterTimelineShowSignal);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GachaAcquireCharacterShow, OnCharacterTimelineShowSignal);
		base.RemoveEventListener();
	}

	private void OnCharacterTimelineShowSignal(BaseEventContent eventContent)
	{
		ShowCharacterPanel();
	}

	private void AddCharacterShowData(UniversalItem universalItem)
	{
		if (universalItem != null && universalItem.Type == UniversalItemType.UniversalItemCharacter)
		{
			_characterShowDataList.Add(new CharacterTimelineShowData
			{
				CharacterItemId = universalItem.Index,
				IsNew = universalItem.IsNew
			});
		}
	}

	private async UniTaskVoid PlayCurrentCharacterTimelineAsync()
	{
		if (_currentCharacterIndex >= _characterShowDataList.Count)
		{
			Close();
			return;
		}
		_hasShownCharacter = false;
		int session = _characterShowSession;
		CharacterTimelineShowViewScene scene = Singleton<UISceneManager>.instance.GetScene<CharacterTimelineShowViewScene>();
		int characterItemId = _characterShowDataList[_currentCharacterIndex].CharacterItemId;
		int quality = CoreUtils.GetData(characterItemId, RuntimeConfigs.data.itemDatas)?.quality ?? 0;
		bool flag = scene == null;
		if (!flag)
		{
			flag = !(await scene.PlayCharacterTimelineAsync(characterItemId, quality));
		}
		if (flag)
		{
			if (!(this == null) && (bool)gameObject && session == _characterShowSession)
			{
				GoBlack?.SetActive(value: false);
				ShowCharacterPanel();
			}
		}
		else if (!(this == null) && (bool)gameObject && session == _characterShowSession)
		{
			GoBlack?.SetActive(value: false);
		}
	}

	private void ShowCharacterPanel()
	{
		if (!_hasShownCharacter)
		{
			_hasShownCharacter = true;
			characterTimelineShowComponent?.Show(_characterShowDataList[_currentCharacterIndex]);
		}
	}

	private void OnCharacterPanelClosed()
	{
		if (!(this == null) && (bool)gameObject && gameObject.activeInHierarchy)
		{
			_currentCharacterIndex++;
			if (_currentCharacterIndex >= _characterShowDataList.Count)
			{
				Close();
				return;
			}
			GoBlack?.SetActive(value: true);
			characterTimelineShowComponent.gameObject.SetActive(value: false);
			PlayCurrentCharacterTimelineAsync().Forget();
		}
	}

	private void StopCharacterTimeline()
	{
		Singleton<UISceneManager>.instance.GetScene<CharacterTimelineShowViewScene>()?.StopCharacterTimeline();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void UnInit()
	{
		StopAcquireCharacterSounds();
		base.UnInit();
		ChangeGameState(show: false);
		characterTimelineShowComponent.Close();
	}

	private void PlayAcquireCharacterBgm()
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		StopSound(audioManager, ref _acquireCharacterBgmId);
		_acquireCharacterBgmId = audioManager.PlaySound("event:/Mus/UI/DrawCard_Role_2");
	}

	public void PlayAcquireCharacterTimelineSound(int quality)
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		StopSound(audioManager, ref _acquireCharacterTimelineId, fadeOut: false);
		_acquireCharacterTimelineId = audioManager.PlaySound("event:/Mus/UI/DrawCard_Role_1");
		int value = ((quality < 5) ? 1 : 2);
		Singleton<GameManager>.instance.audioManager.SetParameter(_acquireCharacterTimelineId, "Music_DrawCard_Stinger", value);
	}

	public void StopAcquireCharacterTimelineSound()
	{
		StopSound(Singleton<GameManager>.instance.audioManager, ref _acquireCharacterTimelineId, fadeOut: false);
	}

	private void StopAcquireCharacterSounds()
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		StopSound(audioManager, ref _acquireCharacterBgmId);
		StopSound(audioManager, ref _acquireCharacterTimelineId, fadeOut: false);
	}

	private static void StopSound(AudioManager audioManager, ref uint soundId, bool fadeOut = true)
	{
		if (soundId == 0 || audioManager == null)
		{
			soundId = 0u;
			return;
		}
		audioManager.Stop(soundId, fadeOut);
		soundId = 0u;
	}

	private void ChangeGameState(bool show)
	{
		GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
		evt.IsInState = show;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnGachaChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
