using System;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class ProtagonistManager : Singleton<ProtagonistManager>
{
	private Entity _protagonistEntity;

	private PlayerControlState _playerControlState;

	private Action<PlayerControlState> _playerControlStateChange;

	private const MonoECS.PlayerTag ProtagonistOperationTags = MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove;

	private const int ProtagonistId = 10001;

	public PlayerControlState PlayerControlState
	{
		get
		{
			return _playerControlState;
		}
		private set
		{
			if (value != _playerControlState)
			{
				_playerControlState = value;
				_playerControlStateChange?.Invoke(value);
			}
		}
	}

	public bool IsProtagonist => _playerControlState == PlayerControlState.Protagonist;

	public override ContextType ContextType => ContextType.GAME;

	public bool CanEnterProtagonistMode
	{
		get
		{
			if (HudOpened() && !Model<GuideModel>.Interface.IsInStrongGuide() && !Singleton<GameState>.instance.InInteractObjectProcessing && !Singleton<LoadManager>.instance.InLoading && (!Singleton<TeleportMoveManager>.HasInstance() || !Singleton<TeleportMoveManager>.instance.IsWebberCabinFlow) && !MonoECS.instance.HasAnyPlayerTag(MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove))
			{
				return Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal;
			}
			return false;
		}
	}

	public event Action<PlayerControlState> PlayerControlStateChange
	{
		add
		{
			_playerControlStateChange = (Action<PlayerControlState>)Delegate.Combine(_playerControlStateChange, value);
		}
		remove
		{
			_playerControlStateChange = (Action<PlayerControlState>)Delegate.Remove(_playerControlStateChange, value);
		}
	}

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeEnterWorld, OnExitEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
	}

	private void OnExitEvent(BaseEventContent obj)
	{
		_protagonistEntity = default;
		_playerControlState = PlayerControlState.Character;
	}

	private void OnAfterEnterWorld(BaseEventContent obj)
	{
		_playerControlStateChange?.Invoke(_playerControlState);
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeEnterWorld, OnExitEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
		_protagonistEntity = default;
		_playerControlState = PlayerControlState.Character;
		_playerControlStateChange = null;
		base.UnInit();
	}

	public async UniTask EnterProtagonistMode()
	{
		if (IsProtagonist || !CanEnterProtagonistMode)
		{
			return;
		}
		MonoECS.instance.PushPauseAllInput();
		MonoECS monoECS = MonoECS.instance;
		MPPlayer localPlayer = monoECS.localPlayer;
		Entity currentMainEntity = monoECS.mainEntity;
		int protagonistId = 10001;
		Character character = G.localPlayer.GetCharacter(protagonistId);
		if (character == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[ProtagonistManager] Character {protagonistId} not found");
			}
			return;
		}
		PlayerControlState = PlayerControlState.Protagonist;
		Vector3 pos = (currentMainEntity.IsValid ? currentMainEntity.GetCompTransform().physicsPosition : Vector3.zero);
		_protagonistEntity = await monoECS.SpawnOwnerCharacter(MPEntityType.Character, protagonistId, 0, character, left: false, pos, loadSave: false, 0);
		if (!_protagonistEntity.IsValid)
		{
			Debug.LogError($"[ProtagonistManager] Failed to spawn protagonist {protagonistId}");
			MonoECS.instance.PopPauseAllInput();
			return;
		}
		localPlayer.SetProtagonistEntity(_protagonistEntity);
		EntityTags entityTags = _protagonistEntity.GetCompBehave().EntityTags;
		entityTags.AddTag(EntityTag.IgnoreAttack);
		entityTags.AddTag(EntityTag.IgnoreControl);
		entityTags.AddTag(EntityTag.IgnoreTrap);
		if (currentMainEntity.IsValid)
		{
			MonoECS monoECS2 = MonoECS.instance;
			GameManager.cameraSystem.ShowCharacterVCam(show: false, currentMainEntity.Id);
			CompTransform compTransform = currentMainEntity.GetCompTransform();
			monoECS2.ShowCharacter(currentMainEntity, show: false, isLeft: false, compTransform.physicsRotateDegree, compTransform.physicsPosition, currentMainEntity.GetCompPhysics().GetConstZ);
		}
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Vibrate", value: true);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/RegularAttack", value: true);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/SkillAttack", value: true);
		ClawStateEvt evt = Singleton<EventManager>.instance.GetEvt<ClawStateEvt>();
		evt.canUse = false;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ClawStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		CharacterNormalEnergyActiveChangeEvt evt2 = Singleton<EventManager>.instance.GetEvt<CharacterNormalEnergyActiveChangeEvt>();
		evt2.active = false;
		evt2.entity = currentMainEntity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterNormalEnergyActiveChange, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
		CharacterSpecialEnergyActiveChangeEvt evt3 = Singleton<EventManager>.instance.GetEvt<CharacterSpecialEnergyActiveChangeEvt>();
		evt3.active = false;
		evt3.entity = currentMainEntity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterSpecialEnergyActiveChange, evt3);
		Singleton<EventManager>.instance.ReleaseEvt(evt3);
		CharacterAssistActiveChangeEvt evt4 = Singleton<EventManager>.instance.GetEvt<CharacterAssistActiveChangeEvt>();
		evt4.active = false;
		evt4.entity = currentMainEntity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterAssetActiveChange, evt4);
		Singleton<EventManager>.instance.ReleaseEvt(evt4);
		MonoECS.instance.PopPauseAllInput();
	}

	public async UniTask ExitProtagonistMode()
	{
		if (IsProtagonist)
		{
			MPPlayer localPlayer = MonoECS.instance.localPlayer;
			EntityTags entityTags = _protagonistEntity.GetCompBehave().EntityTags;
			entityTags.RemoveTag(EntityTag.IgnoreAttack);
			entityTags.RemoveTag(EntityTag.IgnoreControl);
			entityTags.RemoveTag(EntityTag.IgnoreTrap);
			Vector3 positionImmediately = _protagonistEntity.GetCompTransform()?.physicsPosition ?? Vector3.zero;
			localPlayer.RestoreFromProtagonist();
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid)
			{
				mainEntity.GetCompTransform()?.SetPositionImmediately(positionImmediately);
				mainEntity.GetRoot()?.SetActive(value: true);
				mainEntity.SetActive(value: true);
				GameManager.cameraSystem.ShowCharacterVCam(show: true, mainEntity.Id);
				MonoECS.instance.ShowCharacter(mainEntity, show: true, _protagonistEntity.IsFaceLeft(), _protagonistEntity.GetCompTransform().physicsRotateDegree, _protagonistEntity.GetCompTransform().physicsPosition, _protagonistEntity.GetCompPhysics().GetConstZ);
			}
			if (_protagonistEntity.IsValid)
			{
				GameManager.cameraSystem.ShowCharacterVCam(show: false, _protagonistEntity.Id);
				MonoECS.instance.ShowCharacter(_protagonistEntity, show: false, _protagonistEntity.IsFaceLeft(), _protagonistEntity.GetCompTransform().physicsRotateDegree, _protagonistEntity.GetCompTransform().physicsPosition, _protagonistEntity.GetCompPhysics().GetConstZ);
				MonoECS.instance.ReleaseCharacterBattleEntity(_protagonistEntity);
				_protagonistEntity = default;
			}
			PlayerControlState = PlayerControlState.Character;
			Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Vibrate", value: false);
			Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/RegularAttack", value: false);
			Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/SkillAttack", value: false);
			ClawStateEvt evt = Singleton<EventManager>.instance.GetEvt<ClawStateEvt>();
			evt.canUse = true;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ClawStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			CharacterNormalEnergyActiveChangeEvt evt2 = Singleton<EventManager>.instance.GetEvt<CharacterNormalEnergyActiveChangeEvt>();
			evt2.active = true;
			evt2.entity = mainEntity;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterNormalEnergyActiveChange, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			CharacterSpecialEnergyActiveChangeEvt evt3 = Singleton<EventManager>.instance.GetEvt<CharacterSpecialEnergyActiveChangeEvt>();
			evt3.active = true;
			evt3.entity = mainEntity;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterSpecialEnergyActiveChange, evt3);
			Singleton<EventManager>.instance.ReleaseEvt(evt3);
			CharacterAssistActiveChangeEvt evt4 = Singleton<EventManager>.instance.GetEvt<CharacterAssistActiveChangeEvt>();
			evt4.active = true;
			evt4.entity = mainEntity;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterAssetActiveChange, evt4);
			Singleton<EventManager>.instance.ReleaseEvt(evt4);
		}
	}

	private bool HudOpened()
	{
		if (Singleton<NewUIManager>.HasInstance())
		{
			IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
			if (topActivePanel != null && topActivePanel.UIType == UI_TYPE.UI_BATTLEMAIN)
			{
				return topActivePanel.State == UIState.Opened;
			}
			return false;
		}
		return false;
	}
}
