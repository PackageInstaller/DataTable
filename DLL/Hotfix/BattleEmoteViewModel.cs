using System;
using System.Collections.Generic;
using Ase;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

public class BattleEmoteViewModel : OptionBase, IObserverHandler
{
	private BattleViewModel _battleViewModel;

	private InteractionRequest _sendEmoteRequest;

	private InteractionRequest<TempEmoteData> _showEmoteRequest;

	private bool _isOpen;

	private bool _isShowProhibitionTitle;

	private int _selectEmoteIndex;

	private float _time;

	private int _sendTime;

	private float _prohibitionSendTime;

	private float _tempProhibition;

	private bool _prohibitionState;

	private float _refreshSendTime;

	private float _prohibitionShowTime;

	private float _tempProhibitionShowTime;

	private bool _enterTime;

	private int _maxSendTime;

	private ISubscription<BattleReceiveEmoteNotify> subscription_ReceiveMsg;

	private HeroEntity _heroEntity;

	public IInteractionRequest SendEmoteRequest => _sendEmoteRequest;

	public IInteractionRequest ShowEmoteRequest => _showEmoteRequest;

	public bool IsShowProhibitionTitle
	{
		get
		{
			return _isShowProhibitionTitle;
		}
		private set
		{
			Set(ref _isShowProhibitionTitle, value, "IsShowProhibitionTitle");
		}
	}

	public bool IsOpen
	{
		get
		{
			return _isOpen;
		}
		private set
		{
			Set(ref _isOpen, value, "IsOpen");
		}
	}

	public Dictionary<int, BattleEmoteModel> BattleEmoteModels => SelfEntity?.BattleHeroData?.BattleEmoteModels;

	public HeroEntity SelfEntity => _heroEntity;

	public BattleEmoteViewModel()
	{
	}

	public BattleEmoteViewModel(BattleViewModel battleViewModel)
	{
		_battleViewModel = battleViewModel;
		if (_battleViewModel.BattleWorldMode != BattleWorldMode.SyncBattle && _battleViewModel.BattleWorldMode != BattleWorldMode.SingleBattle)
		{
			IsOpen = false;
			return;
		}
		IsOpen = true;
		_sendTime = 0;
		_time = 0f;
		subscription_ReceiveMsg = Singleton<NetworkSystem>.Instance.Subscribe<BattleReceiveEmoteNotify>(RecEmoteNotify);
		_sendEmoteRequest = new InteractionRequest(this);
		_showEmoteRequest = new InteractionRequest<TempEmoteData>(this);
	}

	public void InitHeroData(HeroEntity heroEntity)
	{
		_heroEntity = heroEntity;
		if (_heroEntity == null || _heroEntity.BattleHeroData == null)
		{
			return;
		}
		for (int i = 0; i < _heroEntity.BattleHeroData.BattleEmoteModels.Count; i++)
		{
			_heroEntity.BattleHeroData.BattleEmoteModels[i].Init(i + 1, this);
		}
		foreach (BattleEmoteModel value in _heroEntity.BattleHeroData._battleEmoteEventModels.Values)
		{
			value.Init(this);
		}
		BattleObserverSystem system = _heroEntity.GetSystem<BattleObserverSystem>();
		if (system == null)
		{
			return;
		}
		foreach (BattleObserverEventEnum key in SelfEntity.BattleHeroData._battleEmoteEventModels.Keys)
		{
			system.Attach(key, this);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		if (SelfEntity == null || SelfEntity.BattleHeroData == null)
		{
			return;
		}
		if (param is ObserverEntityDeadParams observerEntityDeadParams)
		{
			if (observerEntityDeadParams.DeadEntityIsBoss())
			{
				BattleEmoteModel emoteModelByBattleEvent = SelfEntity.BattleHeroData.GetEmoteModelByBattleEvent(param.ObserverEventType);
				SendBattleEventEmote(emoteModelByBattleEvent, SelfEntity);
			}
		}
		else
		{
			BattleEmoteModel emoteModelByBattleEvent = SelfEntity.BattleHeroData.GetEmoteModelByBattleEvent(param.ObserverEventType);
			SendBattleEventEmote(emoteModelByBattleEvent, SelfEntity);
		}
	}

	public override void Close()
	{
		base.Close();
		subscription_ReceiveMsg?.Dispose();
	}

	public void InitData(float refreshSendTime, float prohibitionSendTime, int maxSendTime, float prohibitionShowTime)
	{
		_refreshSendTime = refreshSendTime;
		_prohibitionSendTime = prohibitionSendTime;
		_tempProhibition = _prohibitionSendTime;
		_prohibitionShowTime = prohibitionShowTime;
		_tempProhibitionShowTime = _prohibitionShowTime;
		_maxSendTime = maxSendTime;
		_prohibitionState = false;
		_enterTime = false;
	}

	public void Update(float deltaTime)
	{
		if (_prohibitionState)
		{
			_tempProhibition = Mathf.Clamp(_tempProhibition - deltaTime, 0f, _tempProhibition);
			if (_tempProhibition == 0f)
			{
				_prohibitionState = false;
				_tempProhibition = _prohibitionSendTime;
				_time = 0f;
				_sendTime = 0;
			}
		}
		if (_enterTime)
		{
			_time += deltaTime;
			if (_time >= _refreshSendTime)
			{
				_time = 0f;
				_sendTime = 0;
				_enterTime = false;
			}
		}
		if (IsShowProhibitionTitle)
		{
			_tempProhibitionShowTime = Mathf.Clamp(_tempProhibitionShowTime - deltaTime, 0f, _tempProhibitionShowTime);
			if (_tempProhibitionShowTime == 0f)
			{
				_tempProhibitionShowTime = _prohibitionShowTime;
				IsShowProhibitionTitle = false;
			}
		}
	}

	private void RecEmoteNotify(BattleReceiveEmoteNotify obj)
	{
		if (obj == null)
		{
			return;
		}
		HeroEntity entity = GetEntity((int)obj.BattleActorId);
		if (entity != null)
		{
			BattleEmoteModel battleEmoteModel = entity.BattleHeroData?.GetEmoteModelByConfigId(obj.Index);
			if (battleEmoteModel != null)
			{
				ShowEmote(battleEmoteModel, entity);
			}
		}
	}

	private HeroEntity GetEntity(int entityId)
	{
		if (SelfEntity == null)
		{
			return null;
		}
		EntitySystem system = SelfEntity.GetSystem<EntitySystem>();
		if (system == null)
		{
			return null;
		}
		List<HeroEntity> teamHero = system.GetTeamHero();
		for (int i = 0; i < teamHero.Count; i++)
		{
			if (entityId == teamHero[i].Id)
			{
				return teamHero[i];
			}
		}
		return null;
	}

	public void ShowEmote(BattleEmoteModel emoteModel, HeroEntity heroEntity)
	{
		TempEmoteData context = new TempEmoteData
		{
			HeroEntity = heroEntity,
			EmoteSprite = emoteModel.EmoteSprite
		};
		_showEmoteRequest.Raise(context);
	}

	public void SelectEmote(int emoteIndex)
	{
		_selectEmoteIndex = emoteIndex;
	}

	public void SendEmote()
	{
		if (_selectEmoteIndex == 0)
		{
			return;
		}
		if (_sendTime == _maxSendTime)
		{
			_prohibitionState = true;
			_enterTime = false;
			IsShowProhibitionTitle = true;
			return;
		}
		_sendEmoteRequest.Raise();
		try
		{
			_battleViewModel.SendEmote(_selectEmoteIndex);
			_sendTime++;
			_selectEmoteIndex = 0;
			_enterTime = true;
		}
		catch (Exception)
		{
		}
	}

	public void SetShowFlag()
	{
		_battleViewModel.ResetAutoFightTimerExcute();
	}

	private void SendBattleEventEmote(BattleEmoteModel battleEmoteModel, HeroEntity heroEntity)
	{
		if (battleEmoteModel == null || heroEntity == null || battleEmoteModel.IsNull)
		{
			return;
		}
		try
		{
			_battleViewModel.SendEmote(battleEmoteModel.EmoteConfigId, heroEntity);
			_selectEmoteIndex = 0;
			_enterTime = true;
		}
		catch (Exception)
		{
		}
	}
}
