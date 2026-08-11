using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class CommandSystem : BaseSystem, ICommandSystemHandle
{
	private enum AutoBattleMode
	{
		Disabled,
		Switchable,
		Locked
	}

	private DRCopyType autoBattleCopyTypeConfig;

	private AutoBattleMode autoBattleMode;

	private int autoSwitchDelay = -1;

	private float autoIdleTimer;

	private bool autoUseBattleProp;

	private bool autoFightToogle;

	private bool showAutoFight = true;

	private bool unLockAutoFight;

	private bool nextFrameChangeAutoFight;

	private bool isReconnectLockstepWorld;

	private bool authorityAutoFightInitialized;

	private bool pendingAuthorityAutoFightStatistics;

	private bool pendingAuthorityAutoFightUiRefresh;

	private float switchStateTimer;

	private readonly string saveKeyStr = "AutoFightState";

	private BattleSystem battleSystem;

	private int openAutoFightTimer;

	public bool OpenCommandFilter = true;

	private int _recodeSkillState = -1;

	private HeroSkillTypeEnum _recodeSkillEnum;

	private Dictionary<HeroSkillTypeEnum, List<MsgPlayerInput>> _waitMergeInput;

	private Queue<MsgPlayerInput> _waitExecuteInputQueue;

	private Queue<MsgAiSkillInput> _waitExecuteAiInputQueue;

	private List<HeroSkillTypeEnum> _sameTickCommandOrder;

	private Vector2 InputKeyboardUV;

	private Vector2 _inputTouchSkillUV;

	private Vector2 InputTouchUV;

	private CameraSystem cameraSystem;

	private int _commandLocalId;

	private Vector2 _lastSendInputUv;

	private HeroEntity _operationEntity;

	private int[] _upOrDragged = new int[2] { 1, 2 };

	private int[] _draggedOrUp = new int[2] { 2, 3 };

	private int[] _upOrDown = new int[2] { 3, 1 };

	private int[] _downOrDraggedOrUp = new int[3] { 1, 2, 3 };

	private int[] _cancel = new int[1] { 4 };

	public bool AotoFightToogle => autoFightToogle;

	public bool AutoBattleSwitchable => autoBattleMode == AutoBattleMode.Switchable;

	public bool AutoBattleLocked => autoBattleMode == AutoBattleMode.Locked;

	public bool AutoBattleAvailable => autoBattleMode != AutoBattleMode.Disabled;

	public int OpenAutoFightTimer => openAutoFightTimer;

	public MsgPlayerInput PlayerInput
	{
		get
		{
			bool flag = false;
			Vector2 vector = InputTouchUV + InputKeyboardUV;
			if (!(_lastSendInputUv == Vector2.zero) || !(vector == Vector2.zero))
			{
				if (_lastSendInputUv == Vector2.zero)
				{
					_lastSendInputUv = vector;
					flag = true;
				}
				else if ((vector - _lastSendInputUv).sqrMagnitude > 0.0025000002f)
				{
					_lastSendInputUv = vector;
					flag = true;
				}
			}
			MsgPlayerInput msgPlayerInput = CollectInputCommand();
			if (msgPlayerInput.IsValid())
			{
				msgPlayerInput.inputUV = vector.normalized;
				return msgPlayerInput;
			}
			if (flag)
			{
				msgPlayerInput.inputUV = vector.normalized;
				msgPlayerInput.skillJoyUv = _inputTouchSkillUV;
				return msgPlayerInput;
			}
			ReferencePool.Release(msgPlayerInput);
			return null;
		}
	}

	protected override bool IsLogicSystem => true;

	private BattleSystem GetBattleSystem()
	{
		if (battleSystem == null)
		{
			battleSystem = GetSystem<BattleSystem>();
		}
		return battleSystem;
	}

	private void InitializeAutoBattle(WorldData worldData)
	{
		isReconnectLockstepWorld = worldData is LockstepBattleWorldData lockstepBattleWorldData && lockstepBattleWorldData.LockStepWorldType == LockStepWorldType.Reconnect;
		authorityAutoFightInitialized = false;
		pendingAuthorityAutoFightStatistics = false;
		pendingAuthorityAutoFightUiRefresh = false;
		autoUseBattleProp = GameEntry.Setting.GetBool("自动战斗时使用战斗道具");
		bool flag = GameEntry.Setting.GetBool("沿用自动战斗设置");
		autoBattleCopyTypeConfig = null;
		autoBattleMode = AutoBattleMode.Disabled;
		autoSwitchDelay = -1;
		autoIdleTimer = 0f;
		DRCopy dRCopy = null;
		if (worldData is BattleWorldData battleWorldData)
		{
			dRCopy = GameEntry.DataTable.GetDataRow<DRCopy>(battleWorldData.CopyId);
			if (dRCopy == null)
			{
				return;
			}
			autoBattleCopyTypeConfig = GameEntry.DataTable.GetDataRow<DRCopyType>(dRCopy.CopyType);
		}
		if (worldData is ClimbTowerWorldData climbTowerWorldData)
		{
			autoBattleCopyTypeConfig = GameEntry.DataTable.GetDataRow<DRCopyType>(climbTowerWorldData.CopyType);
		}
		if (autoBattleCopyTypeConfig == null)
		{
			showAutoFight = false;
			return;
		}
		int num = (worldData.isMutil ? autoBattleCopyTypeConfig.CoopAuto : autoBattleCopyTypeConfig.SoloAuto);
		autoBattleMode = (AutoBattleMode)num;
		autoSwitchDelay = autoBattleCopyTypeConfig.AutoSwitchDelay;
		int actorId = world.ActorId;
		EntitySystem system = GetSystem<EntitySystem>();
		if (system == null)
		{
			return;
		}
		if (system.GetEntity(actorId, isGetCache: true) is HeroEntity heroEntity)
		{
			unLockAutoFight = heroEntity.BattleHeroData.HeroModel.UnLockAutoFight;
		}
		if (AutoBattleLocked)
		{
			autoFightToogle = true;
		}
		else if (!AutoBattleAvailable)
		{
			autoFightToogle = false;
		}
		else if (AutoBattleSwitchable && unLockAutoFight && flag)
		{
			if (PlayerPrefs.GetInt(saveKeyStr, 0) == 1)
			{
				autoFightToogle = true;
			}
			else
			{
				autoFightToogle = false;
			}
		}
		if (!isReconnectLockstepWorld)
		{
			ChangeAutoFightState(autoFightToogle, statisticsChangeCount: false);
			GetBattleSystem()?.BattleStartSetAutoFight(autoFightToogle);
			GetBattleSystem()?.AutoFightBtnStateChange(GetAutoFightBtnState());
		}
		else
		{
			nextFrameChangeAutoFight = false;
		}
	}

	public override UniTask<bool> OnGamePreparationEnd(object data = null)
	{
		InitializeAutoBattle(data as WorldData);
		return base.OnGamePreparationEnd(data);
	}

	public MsgPlayerInput SetMsgPlayerAutoFight(MsgPlayerInput msgPlayerInput, float deltaTime)
	{
		if (isReconnectLockstepWorld && !authorityAutoFightInitialized)
		{
			return msgPlayerInput;
		}
		if (msgPlayerInput != null)
		{
			msgPlayerInput.AutoFight = autoFightToogle;
			msgPlayerInput.AutoUseProp = autoUseBattleProp;
		}
		if (autoFightToogle)
		{
			openAutoFightTimer++;
		}
		switchStateTimer++;
		bool entityBattleState = GetSystem<BattleStateSystem>().GetEntityBattleState(world.ActorId);
		if (AutoBattleSwitchable)
		{
			bool flag = BreakAutoFightOperation(msgPlayerInput);
			if (autoFightToogle)
			{
				if (flag)
				{
					ChangeAutoFightState(isOpen: false, statisticsChangeCount: true);
					GetBattleSystem()?.AutoFightTip(AutoFightTipEnum.InputBreakAutoFight);
				}
			}
			else if (autoSwitchDelay != -1)
			{
				bool resetAutoFightTimer = battleSystem.GetResetAutoFightTimer();
				if ((!flag & entityBattleState) && !resetAutoFightTimer)
				{
					autoIdleTimer += deltaTime;
				}
				else if (flag | resetAutoFightTimer)
				{
					autoIdleTimer = 0f;
				}
				if (autoIdleTimer >= (float)autoSwitchDelay && !autoFightToogle)
				{
					ChangeAutoFightState(isOpen: true, statisticsChangeCount: true);
					autoIdleTimer = 0f;
					GetBattleSystem()?.TimeOutOpenAutoFight();
					GetBattleSystem()?.AutoFightTip(AutoFightTipEnum.OpenAutoFight);
				}
			}
		}
		if (nextFrameChangeAutoFight)
		{
			if (msgPlayerInput == null)
			{
				msgPlayerInput = ReferencePool.Acquire<MsgPlayerInput>();
			}
			if (autoFightToogle)
			{
				msgPlayerInput.Clear();
			}
			msgPlayerInput.AutoFight = autoFightToogle;
			msgPlayerInput.AutoUseProp = autoUseBattleProp;
			nextFrameChangeAutoFight = false;
		}
		return msgPlayerInput;
	}

	private bool BreakAutoFightOperation(MsgPlayerInput msgPlayerInput)
	{
		if (msgPlayerInput == null)
		{
			return false;
		}
		if (msgPlayerInput.inputUV != Vector2.zero)
		{
			return true;
		}
		if (msgPlayerInput.optionCode == HeroSkillTypeEnum.None)
		{
			return false;
		}
		return true;
	}

	public void SwitchAutoFightToogle(bool openToogle)
	{
		if (AutoBattleSwitchable)
		{
			if (switchStateTimer * 0.033f < 1f)
			{
				battleSystem.AutoFightTip(AutoFightTipEnum.FrequentSwitch);
				return;
			}
			ChangeAutoFightState(openToogle, statisticsChangeCount: true);
			autoIdleTimer = 0f;
			switchStateTimer = 0f;
		}
	}

	private void ChangeAutoFightState(bool isOpen, bool statisticsChangeCount)
	{
		autoFightToogle = isOpen;
		nextFrameChangeAutoFight = true;
		PlayerPrefs.SetInt(saveKeyStr, autoFightToogle ? 1 : 0);
		pendingAuthorityAutoFightUiRefresh = true;
		if (statisticsChangeCount)
		{
			pendingAuthorityAutoFightStatistics = true;
		}
		autoIdleTimer = 0f;
	}

	private void ApplyAuthorityAutoFightState(bool isOpen, bool syncPlayerPrefs)
	{
		autoFightToogle = isOpen;
		if (syncPlayerPrefs)
		{
			PlayerPrefs.SetInt(saveKeyStr, autoFightToogle ? 1 : 0);
		}
		autoIdleTimer = 0f;
	}

	public void SyncAuthorityAutoFightState(bool isOpen, uint tick)
	{
		if (isReconnectLockstepWorld)
		{
			if (!authorityAutoFightInitialized)
			{
				authorityAutoFightInitialized = true;
				ApplyAuthorityAutoFightState(isOpen, syncPlayerPrefs: true);
				pendingAuthorityAutoFightStatistics = false;
				pendingAuthorityAutoFightUiRefresh = false;
				GetBattleSystem()?.BattleStartSetAutoFight(isOpen);
				GetBattleSystem()?.AutoFightBtnStateChange(GetAutoFightBtnState());
				return;
			}
			bool flag = autoFightToogle != isOpen;
			if (flag)
			{
				ApplyAuthorityAutoFightState(isOpen, syncPlayerPrefs: true);
				pendingAuthorityAutoFightUiRefresh = true;
				pendingAuthorityAutoFightStatistics = true;
			}
			if (pendingAuthorityAutoFightUiRefresh)
			{
				GetBattleSystem()?.AutoFightBtnStateChange(GetAutoFightBtnState());
			}
			if (pendingAuthorityAutoFightStatistics | flag)
			{
				GetBattleSystem()?.ChangeAutoFightState(isOpen, tick);
			}
			pendingAuthorityAutoFightStatistics = false;
			pendingAuthorityAutoFightUiRefresh = false;
		}
		else
		{
			if (autoFightToogle != isOpen)
			{
				ApplyAuthorityAutoFightState(isOpen, syncPlayerPrefs: true);
			}
			if (pendingAuthorityAutoFightUiRefresh)
			{
				GetBattleSystem()?.AutoFightBtnStateChange(GetAutoFightBtnState());
			}
			if (pendingAuthorityAutoFightStatistics)
			{
				GetBattleSystem()?.ChangeAutoFightState(isOpen, tick);
			}
			pendingAuthorityAutoFightStatistics = false;
			pendingAuthorityAutoFightUiRefresh = false;
		}
	}

	public AutoFightToogleEnum GetAutoFightBtnState()
	{
		if (!showAutoFight)
		{
			return AutoFightToogleEnum.DisActive;
		}
		if (AutoBattleLocked)
		{
			return AutoFightToogleEnum.BanClose;
		}
		if (!unLockAutoFight)
		{
			return AutoFightToogleEnum.LevelLock;
		}
		if (!AutoBattleAvailable)
		{
			return AutoFightToogleEnum.BanOpen;
		}
		if (!autoFightToogle)
		{
			return AutoFightToogleEnum.Close;
		}
		return AutoFightToogleEnum.Open;
	}

	public void BindTargetEntity(HeroEntity heroEntity)
	{
		_operationEntity = heroEntity;
	}

	public static bool IsMergeCommand(OneBattleFrameMessage command1, OneBattleFrameMessage command2)
	{
		if (command1.SkillState == 3 || command2.SkillState == 1)
		{
			return false;
		}
		if (command1.SkillState == 1 || command2.SkillState == 3)
		{
			return false;
		}
		return true;
	}

	public static OneBattleFrameMessage MergeCommand(OneBattleFrameMessage command1, OneBattleFrameMessage command2)
	{
		if (command1.optionCode == 0 || command1.optionCode == 1)
		{
			return command2;
		}
		if (command2.optionCode == 0 || command2.optionCode == 1)
		{
			return command1;
		}
		if (command1.optionCode == 1 && command2.optionCode == 1)
		{
			if (command1.SkillState == 3)
			{
				return command1;
			}
			if (command2.SkillState == 3)
			{
				return command2;
			}
		}
		if (command1.optionCode == command2.optionCode)
		{
			if (command1.SkillState == 2 && (command2.SkillState == 3 || command2.SkillState == 1))
			{
				if (command2.SkillState == 1)
				{
					command2.skillJoyUv.Clear();
					command2.skillJoyUv.Add(command1.skillJoyUv[0]);
					command2.skillJoyUv.Add(command1.skillJoyUv[1]);
				}
			}
			else if (command2.SkillState == 2 && (command1.SkillState == 3 || command1.SkillState == 1))
			{
				if (command1.SkillState == 1)
				{
					command1.skillJoyUv.Clear();
					command1.skillJoyUv.Add(command2.skillJoyUv[0]);
					command1.skillJoyUv.Add(command2.skillJoyUv[1]);
				}
				return command1;
			}
			return command2;
		}
		return command2;
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_waitMergeInput = new Dictionary<HeroSkillTypeEnum, List<MsgPlayerInput>>();
		_sameTickCommandOrder = new List<HeroSkillTypeEnum>();
		_waitExecuteInputQueue = new Queue<MsgPlayerInput>();
		_waitExecuteAiInputQueue = new Queue<MsgAiSkillInput>();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		cameraSystem = GetSystem<CameraSystem>();
	}

	public void UpdateKeyBoardInput(Vector2 inputUv)
	{
		inputUv = VectorExtensions.GetCameraOffsetDirect(inputUv, cameraSystem.GetCameraDirect().y, world.IsStoryWorld);
		InputKeyboardUV = inputUv;
	}

	public void UpdateInputUv(Vector2 inputUv)
	{
		if (cameraSystem != null && world != null)
		{
			inputUv = VectorExtensions.GetCameraOffsetDirect(inputUv, cameraSystem.GetCameraDirect().y, world.IsStoryWorld);
			InputTouchUV = inputUv;
		}
	}

	public void UpdateSkillUv(Vector2 skillUv)
	{
		_inputTouchSkillUV = skillUv;
	}

	public void AddKeyBoardInput(MsgPlayerInput playerInput)
	{
		if (!CanAddCommand(playerInput))
		{
			ReferencePool.Release(playerInput);
		}
		else
		{
			CollectCommand(playerInput);
		}
	}

	public void AddTouchInput(MsgPlayerInput playerInput)
	{
		if (!CanAddCommand(playerInput))
		{
			ReferencePool.Release(playerInput);
		}
		else
		{
			CollectCommand(playerInput);
		}
	}

	private void CollectCommand(MsgPlayerInput playerInput)
	{
		if (playerInput != null && _sameTickCommandOrder != null && _waitMergeInput != null)
		{
			if (!_sameTickCommandOrder.Contains(playerInput.optionCode))
			{
				_sameTickCommandOrder.Add(playerInput.optionCode);
			}
			if (!_waitMergeInput.TryGetValue(playerInput.optionCode, out var value))
			{
				value = CollectionPool<List<MsgPlayerInput>, MsgPlayerInput>.Get();
				_waitMergeInput.Add(playerInput.optionCode, value);
			}
			MsgPlayerInput sameCommand2;
			MsgPlayerInput sameCommand3;
			MsgPlayerInput sameCommand4;
			if (IsContainsSameStateCommand(4, value, out var _))
			{
				ReferencePool.Release(playerInput);
			}
			else if (playerInput.SkillState == 2 && IsContainsSameStateCommand(2, value, out sameCommand2))
			{
				ReferencePool.Release(playerInput);
			}
			else if (playerInput.SkillState == 1 && IsContainsSameStateCommand(1, value, out sameCommand3))
			{
				ReferencePool.Release(playerInput);
			}
			else if (playerInput.SkillState == 3 && IsContainsSameStateCommand(3, value, out sameCommand4))
			{
				ReferencePool.Release(playerInput);
			}
			else
			{
				value.Add(playerInput);
			}
		}
	}

	private void ClearCollectCommand()
	{
		_sameTickCommandOrder.Clear();
		foreach (List<MsgPlayerInput> value in _waitMergeInput.Values)
		{
			value.Clear();
		}
	}

	private void MergeCommand()
	{
		for (int i = 0; i < _sameTickCommandOrder.Count; i++)
		{
			List<MsgPlayerInput> list = _waitMergeInput[_sameTickCommandOrder[i]];
			if (IsMergeCommand(list, _upOrDragged))
			{
				for (int j = 0; j < list.Count; j++)
				{
					if (list[j].SkillState == 1)
					{
						ReferencePool.Release(list[j]);
						list[j] = null;
					}
				}
			}
			else if (IsMergeCommand(list, _downOrDraggedOrUp))
			{
				for (int k = 0; k < list.Count; k++)
				{
					if (list[k].SkillState == 2)
					{
						ReferencePool.Release(list[k]);
						list[k] = null;
					}
				}
			}
			else if (IsMergeCommand(list, _draggedOrUp))
			{
				for (int l = 0; l < list.Count; l++)
				{
					if (list[l].SkillState == 2)
					{
						ReferencePool.Release(list[l]);
						list[l] = null;
					}
				}
			}
			else if (IsMergeCommand(list, _cancel))
			{
				for (int m = 0; m < list.Count; m++)
				{
					if (list[m].SkillState != 4)
					{
						ReferencePool.Release(list[m]);
						list[m] = null;
					}
				}
			}
			for (int n = 0; n < list.Count; n++)
			{
				if (list[n] != null)
				{
					_waitExecuteInputQueue.Enqueue(list[n]);
				}
			}
		}
	}

	private bool IsMergeCommand(List<MsgPlayerInput> commandList, int[] commandStateList)
	{
		if (commandList == null || commandList.Count == 0)
		{
			return false;
		}
		if (commandList.Count != commandStateList.Length)
		{
			return false;
		}
		int num = 0;
		for (int i = 0; i < commandList.Count; i++)
		{
			for (int j = 0; j < commandStateList.Length; j++)
			{
				if (commandList[i].SkillState == commandStateList[j])
				{
					num++;
					break;
				}
			}
		}
		return commandStateList.Length == num;
	}

	private bool IsContainsSameStateCommand(int inputState, List<MsgPlayerInput> commandList, out MsgPlayerInput sameCommand)
	{
		if (commandList == null)
		{
			sameCommand = null;
			return false;
		}
		for (int i = 0; i < commandList.Count; i++)
		{
			MsgPlayerInput msgPlayerInput = commandList[i];
			if (msgPlayerInput != null && msgPlayerInput.SkillState == inputState)
			{
				sameCommand = commandList[i];
				return true;
			}
		}
		sameCommand = null;
		return false;
	}

	private bool CanAddCommand(MsgPlayerInput playerInput)
	{
		if (_operationEntity == null)
		{
			return true;
		}
		if (OpenCommandFilter)
		{
			if (_recodeSkillState != -1)
			{
				if (playerInput.optionCode != _recodeSkillEnum)
				{
					return false;
				}
				if (playerInput.SkillState != 1 && playerInput.SkillState != 2)
				{
					_recodeSkillState = -1;
					_recodeSkillEnum = HeroSkillTypeEnum.None;
				}
			}
			else if (playerInput.SkillState == 1 && playerInput.optionCode != HeroSkillTypeEnum.Interaction1 && playerInput.optionCode != HeroSkillTypeEnum.Interaction2 && playerInput.optionCode != HeroSkillTypeEnum.Interaction3 && playerInput.optionCode != HeroSkillTypeEnum.Interaction4 && playerInput.optionCode != HeroSkillTypeEnum.Rescue1 && playerInput.optionCode != HeroSkillTypeEnum.Rescue2)
			{
				_recodeSkillState = playerInput.SkillState;
				_recodeSkillEnum = playerInput.optionCode;
			}
			return true;
		}
		return false;
	}

	public void ClearLastDownOrDragInput()
	{
		_recodeSkillState = -1;
		_recodeSkillEnum = HeroSkillTypeEnum.None;
	}

	private MsgPlayerInput CollectInputCommand()
	{
		if (_waitExecuteInputQueue == null)
		{
			return null;
		}
		MsgPlayerInput msgPlayerInput = null;
		MergeCommand();
		if (_waitExecuteInputQueue.Count == 0)
		{
			msgPlayerInput = ReferencePool.Acquire<MsgPlayerInput>();
			msgPlayerInput.optionCode = HeroSkillTypeEnum.None;
			msgPlayerInput.SkillState = 0;
		}
		else
		{
			msgPlayerInput = _waitExecuteInputQueue.Dequeue();
		}
		ClearCollectCommand();
		return msgPlayerInput;
	}

	public void CollectAiSkill(int entityID, string paramKey, int paramValue)
	{
		_waitExecuteAiInputQueue.Enqueue(new MsgAiSkillInput
		{
			entityID = entityID,
			paradoxKey = paramKey,
			paradoxValue = paramValue
		});
	}

	public void ExecuteAiSkill()
	{
		if (_waitExecuteAiInputQueue.Count != 0)
		{
			MsgAiSkillInput msgAiSkillInput = _waitExecuteAiInputQueue.Dequeue();
			if (msgAiSkillInput != null)
			{
				world.RecodeCommand(msgAiSkillInput.entityID, msgAiSkillInput.paradoxKey, msgAiSkillInput.paradoxValue);
				GetSystem<EntitySystem>().GetEntity(msgAiSkillInput.entityID)?.GetComponent<AIParadoxComponent>().SetVariableValues(msgAiSkillInput.paradoxKey, msgAiSkillInput.paradoxValue == 1);
			}
		}
	}

	public void ClearCacheCommand()
	{
		InputKeyboardUV = Vector2.zero;
		InputTouchUV = Vector2.zero;
	}

	public override void OnPause()
	{
		ClearCacheCommand();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		InputKeyboardUV = Vector2.zero;
		InputTouchUV = Vector2.zero;
		_operationEntity = null;
		cameraSystem = null;
	}
}
