using System;
using System.Collections.Generic;
using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class WorldStateManager : IGameModule
{
	private enum FrameRateTarget
	{
		FPS_30,
		FPS_60,
		FPS_120,
		FPS_90_PC_ONLY
	}

	public const string TEXT_LANGUAGE_KEY = "text_language";

	public const string COOPERATE_UNIQUE_SKILL_FULL_PLAY_CONTROLLED_TYPE_KEY = "CooperateUniqueSkillFullPlayControlledType";

	public const string COOPERATE_UNIQUE_SKILL_FULL_PLAYED_OF_DAILY = "CooperateUniqueSkillFullPlayedOfDaily";

	public Action<int> lockTargetEvent;

	private Action onWorldStateManagerShutdown;

	public Action<bool> mQteFinshEvent;

	public bool hasManualLock;

	public float lockedTime;

	public int lockedAgentID;

	public int lockedAgentPart;

	public bool isGameOver;

	public int mPlayerAgentID;

	private int firstAgentID;

	private int secondAgentID;

	private int thirdAgentID;

	public StatisticsData data = new StatisticsData();

	public bool getRewardIfFailed;

	public int GameOverConditionTriggerID;

	public int gameStratFrame;

	public int show_battle_hit_num_mine = 2;

	public int show_battle_hit_num_teammate = 2;

	public LockType lockType;

	public bool ignoreSystemLockSetting;

	public int worldTimeScale;

	public int lastWorldTimeScale;

	public UITimeType uITimeType;

	public int totalTime;

	public bool m_isInReversed;

	public bool hide_teammate_hit_number;

	public int m_SourceSpaceKeepTime;

	public int m_breakEntityID;

	public bool m_cooperateUniqueSkillIsActive;

	public int m_cooperateUniqueSkillEnergyValue;

	public int m_cooperateUniqueSkillEnergyMaxValue;

	public int m_cooperateUniqueSkillCD;

	public int m_cooperateUniqueSkillMaxCD;

	public bool m_cooperateUniqueSkillVaild;

	public string m_battleTipsStartUID;

	public float m_battleTipsMaxTime;

	public float m_battleTipsCurrrentTime;

	public List<int> ClickStaticsData = new List<int>();

	public Dictionary<int, GameObject> PressingFingers = new Dictionary<int, GameObject>();

	public string QTEResurrectUIPath;

	public string textLanguageSetting;

	public bool notMuteBattleVoice = true;

	public bool notMuteCharacterVoice = true;

	public bool notMuteEffectVoice = true;

	private int maxHpTipsCount = 40;

	private Dictionary<string, Stack<HpTips>> hptipsPool = new Dictionary<string, Stack<HpTips>>();

	public uint currentFrameNumber;

	public uint logicTimerPauseFlag;

	public bool CanFullPlayOfCooperateUniqueSkill()
	{
		switch (BattleScene.PlayControlledType)
		{
		case En_CooperateUniqueSkillPlayControlledType.All:
			return false;
		case En_CooperateUniqueSkillPlayControlledType.OnceBattle:
			if (BattleScene.PlayedOfBattle)
			{
				return false;
			}
			break;
		case En_CooperateUniqueSkillPlayControlledType.OnceStart:
			if (BattleScene.PlayedOfStart)
			{
				return false;
			}
			break;
		case En_CooperateUniqueSkillPlayControlledType.OnceDaily:
			if (BattleScene.PlayedOfDaily)
			{
				return false;
			}
			BattleScene.PlayedOfDaily = PlayerPrefs.GetInt("CooperateUniqueSkillFullPlayedOfDaily", 0) == DateTime.Now.DayOfYear;
			if (BattleScene.PlayedOfDaily)
			{
				return false;
			}
			break;
		}
		BattleScene.PlayedOfBattle = true;
		BattleScene.PlayedOfStart = true;
		if (!BattleScene.PlayedOfDaily)
		{
			BattleScene.PlayedOfDaily = true;
			PlayerPrefs.SetInt("CooperateUniqueSkillFullPlayedOfDaily", DateTime.Now.DayOfYear);
		}
		return true;
	}

	public HpTips GetHpTip(string path)
	{
		if (maxHpTipsCount < 0)
		{
			return null;
		}
		maxHpTipsCount--;
		if (hptipsPool == null)
		{
			hptipsPool = new Dictionary<string, Stack<HpTips>>();
		}
		if (!hptipsPool.TryGetValue(path, out var value))
		{
			value = new Stack<HpTips>();
			hptipsPool[path] = value;
		}
		if (value.Count > 0)
		{
			HpTips hpTips = value.Pop();
			hpTips.gameObject.SetActive(value: true);
			return hpTips;
		}
		GameObject gameObject = Asset.Instantiate(path);
		if (null == gameObject)
		{
			Debug.LogError("Can't Find hpTip " + path);
		}
		HpTips hpTips2 = U3DUtil.Get<HpTips>(gameObject);
		if (null == hpTips2)
		{
			Debug.LogError("Can't Get hpTip " + path);
		}
		hpTips2.path = path;
		onWorldStateManagerShutdown = (Action)Delegate.Combine(onWorldStateManagerShutdown, new Action(hpTips2.DestroyOrReturn));
		return hpTips2;
	}

	public bool ReturnHpTips(HpTips goToReturn, string path)
	{
		if (hptipsPool == null)
		{
			return false;
		}
		if (string.IsNullOrEmpty(path) || hptipsPool[path] == null)
		{
			return false;
		}
		if (goToReturn == null)
		{
			return false;
		}
		goToReturn.gameObject.SetActive(value: false);
		hptipsPool[path].Push(goToReturn);
		maxHpTipsCount++;
		return true;
	}

	public void Initialize()
	{
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntityDespawnedEvent>(OnUnitDespawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntitySpawnedEvent>(OnSimUnitSpawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<HitTargetEvent>(OnHitTargetEventHandler);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntityHitRecoverStatusEvent>(OnHitRecoverStatusEventHandler);
		CameraExtension component = Camera.main.GetComponent<CameraExtension>();
		int num = PlayerPrefs.GetInt("allowHDR");
		component.hdr = num == 1;
		if (PlayerPrefs.GetInt("allowMSAA") != 0)
		{
			SimPipelineSettings.AliasingEnable = true;
		}
		else
		{
			SimPipelineSettings.AliasingEnable = false;
		}
		int num2 = PlayerPrefs.GetInt("battle_hit_num_mine");
		int num3 = PlayerPrefs.GetInt("battle_hit_num_teammate");
		show_battle_hit_num_mine = num2;
		show_battle_hit_num_teammate = num3;
		switch ((FrameRateTarget)PlayerPrefs.GetInt("frame"))
		{
		case FrameRateTarget.FPS_30:
			BattleSimulatorSystem.sTargetRenderFrameRate = 30;
			break;
		case FrameRateTarget.FPS_60:
			BattleSimulatorSystem.sTargetRenderFrameRate = 60;
			break;
		case FrameRateTarget.FPS_120:
			BattleSimulatorSystem.sTargetRenderFrameRate = 120;
			break;
		case FrameRateTarget.FPS_90_PC_ONLY:
			BattleSimulatorSystem.sTargetRenderFrameRate = 90;
			break;
		}
		lockType = (LockType)PlayerPrefs.GetInt("battle_lock_type");
		textLanguageSetting = PlayerPrefs.GetString("text_language");
	}

	private void OnHitRecoverStatusEventHandler(EntityHitRecoverStatusEvent hitRecoverEvent)
	{
		if (hitRecoverEvent.mHitRecoverStatus != E_HitRecoverStatus.HitFloor)
		{
			return;
		}
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(hitRecoverEvent.mEntityID);
		if (null != agent)
		{
			if ((agent.Blackboard as BBHumanoid).m_NextSimFrameData.HitRecoverCasterID == mPlayerAgentID)
			{
				data.dataForLua.knockoutNum++;
			}
			else if (hitRecoverEvent.mEntityID == mPlayerAgentID)
			{
				data.dataForLua.fallDownNum++;
			}
		}
		else
		{
			Debug.LogWarning("Can't Find Agent By " + hitRecoverEvent.mEntityID);
		}
	}

	private void OnHitTargetEventHandler(HitTargetEvent eventReceived)
	{
		if (eventReceived.mTargetID == mPlayerAgentID)
		{
			data.dataForLua.totalHittedNum++;
		}
	}

	private void OnSimUnitSpawnedInSim(EntitySpawnedEvent eventReceived)
	{
		if (eventReceived.mIsPlayer)
		{
			mPlayerAgentID = eventReceived.NewEntity;
		}
		if (eventReceived.mRolePosition == MemberPosition.First)
		{
			firstAgentID = eventReceived.NewEntity;
		}
		if (eventReceived.mRolePosition == MemberPosition.Second)
		{
			secondAgentID = eventReceived.NewEntity;
		}
		if (eventReceived.mRolePosition == MemberPosition.Third)
		{
			thirdAgentID = eventReceived.NewEntity;
		}
	}

	private void OnUnitDespawnedInSim(EntityDespawnedEvent eventReceived)
	{
		data.deathInfos.Add(new DeadAgent
		{
			frameCount = eventReceived.mDespawnedFrame,
			agentID = eventReceived.DestroyedEntity,
			camp = (RoleType)eventReceived.mAgentCamp,
			isLocalPlayer = (eventReceived.DestroyedEntity == mPlayerAgentID),
			killerID = eventReceived.KillingEntity,
			IsKillerLocalPlayer = (eventReceived.KillingEntity == mPlayerAgentID),
			killerAbilityID = eventReceived.mAbilityID
		});
		if (eventReceived.mAgentCamp == 1)
		{
			data.dataForLua.totalDeadNum++;
		}
	}

	private int GetAgentOrder(int agentID)
	{
		if (agentID == firstAgentID && firstAgentID != 0)
		{
			return 1;
		}
		if (agentID == secondAgentID && secondAgentID != 0)
		{
			return 2;
		}
		if (agentID == thirdAgentID && thirdAgentID != 0)
		{
			return 3;
		}
		return 0;
	}

	public int GetAgentIDByRoleID(int roleID)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (firstAgentID != 0)
		{
			NAgent agent = agentManager.GetAgent(firstAgentID);
			if (agent != null && agent.AgentConfigID == roleID)
			{
				return firstAgentID;
			}
		}
		if (secondAgentID != 0)
		{
			NAgent agent2 = agentManager.GetAgent(secondAgentID);
			if (agent2 != null && agent2.AgentConfigID == roleID)
			{
				return secondAgentID;
			}
		}
		if (thirdAgentID != 0)
		{
			NAgent agent3 = agentManager.GetAgent(thirdAgentID);
			if (agent3 != null && agent3.AgentConfigID == roleID)
			{
				return thirdAgentID;
			}
		}
		return 0;
	}

	private void AddHurtInfo(int agentID, uint frameCount, List<ModifyHPInfo> modifyHPInfos)
	{
		for (int i = 0; i < modifyHPInfos.Count; i++)
		{
			HurtInfo item = new HurtInfo
			{
				frameCount = frameCount,
				agentID = agentID,
				isLocalPlayer = (agentID == mPlayerAgentID),
				casterID = modifyHPInfos[i].mCasterID,
				IsCasterLocalPlayer = (modifyHPInfos[i].mCasterID == mPlayerAgentID),
				casterAbilityID = modifyHPInfos[i].mActionID,
				casterRootAbilityID = modifyHPInfos[i].mRootAbilityID,
				casterOrder = GetAgentOrder(modifyHPInfos[i].mCasterID),
				damageType = modifyHPInfos[i].mDamageType,
				damageValue = modifyHPInfos[i].mAmount,
				agentOrder = GetAgentOrder(agentID)
			};
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent agent = agentManager.GetAgent(modifyHPInfos[i].mCasterID);
				if ((object)agent != null && ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(agent.AgentConfigID, out var config))
				{
					int agentIDByRoleID = GetAgentIDByRoleID(config.SameDamageSourceRoleIDs);
					if (agentIDByRoleID > 0)
					{
						item.casterID = agentIDByRoleID;
						item.IsCasterLocalPlayer = agentIDByRoleID == mPlayerAgentID;
						item.casterOrder = GetAgentOrder(agentIDByRoleID);
					}
				}
			}
			if (agentID == mPlayerAgentID && modifyHPInfos[i].mAmount < 0)
			{
				data.dataForLua.injuredNum -= modifyHPInfos[i].mAmount;
			}
			data.hurtInfos.Add(item);
		}
	}

	public float GetCurrentDPS(int entityID)
	{
		long currentDamage = GetCurrentDamage(entityID);
		if (data.hurtInfos.Count >= 1)
		{
			float b = (currentFrameNumber - data.hurtInfos[0].frameCount) / 30;
			b = Mathf.Max(1f, b);
			return (float)currentDamage / b;
		}
		return 0f;
	}

	public long GetCurrentDamage(int entityID)
	{
		long num = 0L;
		for (int num2 = data.hurtInfos.Count - 1; num2 >= 0; num2--)
		{
			HurtInfo hurtInfo = data.hurtInfos[num2];
			if (hurtInfo.casterID == entityID && hurtInfo.damageValue < 0)
			{
				num += hurtInfo.damageValue;
			}
		}
		return -num;
	}

	public void SendOfflineCommand(int offlineMember)
	{
		PlayerOfflineCommand playerOfflineCommand = CommandFactory.Create(NetprotoOperationCode.CmdPlayerOffline) as PlayerOfflineCommand;
		playerOfflineCommand.SetData(offlineMember);
		ClientSimulator.Instance.SendLocalCommand(playerOfflineCommand);
	}

	public void UpdateLogic(SimStateFrame stateFrame)
	{
		if (isGameOver)
		{
			return;
		}
		float num = (float)(1000 / BattleSimulatorSystem.sTargetLogicFrameRate) / 1000f;
		if (!stateFrame.IsPrediction)
		{
			currentFrameNumber = stateFrame.FrameNumber;
		}
		if (gameStratFrame != 0)
		{
			data.dataForLua.battleTime = (float)(currentFrameNumber - gameStratFrame) * num;
		}
		int count = stateFrame.AllEntityStates.Count;
		for (int i = 0; i < count; i++)
		{
			if (stateFrame.AllEntityStates[i] is WorldState)
			{
				WorldState worldState = stateFrame.AllEntityStates[i] as WorldState;
				isGameOver = worldState.mIsGameOver;
				logicTimerPauseFlag = worldState.mLogicTimerPauseFlag;
				m_SourceSpaceKeepTime = worldState.mSourceSpaceKeepTime;
				m_breakEntityID = worldState.mBreakEntityID;
				lastWorldTimeScale = worldTimeScale;
				worldTimeScale = worldState.mWorldTimeScale;
				m_cooperateUniqueSkillIsActive = worldState.mCooperateUniqueSkillIsActive > 0;
				m_cooperateUniqueSkillEnergyValue = worldState.mCooperateUniqueSkillEnergyValue;
				m_cooperateUniqueSkillEnergyMaxValue = worldState.mCooperateUniqueSkillEnergyMaxValue;
				m_cooperateUniqueSkillCD = worldState.mCooperateUniqueSkillCD;
				m_cooperateUniqueSkillMaxCD = worldState.mCooperateUniqueSkillMaxCD;
				m_cooperateUniqueSkillVaild = worldState.mCooperateUniqueSkillVaild;
				if (worldState.mOfflineMember != 0)
				{
					SendOfflineCommand(worldState.mOfflineMember);
				}
			}
			if (stateFrame.AllEntityStates[i] is UnitState)
			{
				UnitState unitState = stateFrame.AllEntityStates[i] as UnitState;
				if (unitState.mPredictionID <= 0 && unitState.mModfiyInfo != null && unitState.mModfiyInfo.Count > 0)
				{
					AddHurtInfo(unitState.EntityID, stateFrame.FrameNumber, unitState.mModfiyInfo);
				}
			}
		}
		if (logicTimerPauseFlag != 0)
		{
			gameStratFrame++;
		}
	}

	public void FixedUpdate()
	{
	}

	public void Update()
	{
		if (!hasManualLock)
		{
			lockedTime += Time.deltaTime;
			if (lockedTime > 3f)
			{
				lockedAgentID = 0;
				lockedTime = 0f;
			}
		}
	}

	public void LateUpdate()
	{
	}

	public void Reset()
	{
	}

	public void Shutdown()
	{
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntityDespawnedEvent>(OnUnitDespawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntitySpawnedEvent>(OnSimUnitSpawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<HitTargetEvent>(OnHitTargetEventHandler);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntityHitRecoverStatusEvent>(OnHitRecoverStatusEventHandler);
		if (onWorldStateManagerShutdown != null)
		{
			onWorldStateManagerShutdown();
		}
		if (hptipsPool != null)
		{
			Dictionary<string, Stack<HpTips>>.Enumerator enumerator = hptipsPool.GetEnumerator();
			while (enumerator.MoveNext())
			{
				Stack<HpTips> value = enumerator.Current.Value;
				while (value != null && value.Count > 0)
				{
					PooledAsset.DestroyOrReturn(value.Pop().gameObject);
				}
			}
		}
		data = new StatisticsData();
		lockTargetEvent = null;
		onWorldStateManagerShutdown = null;
	}

	public bool CalcCurrentHp()
	{
		data.dataForLua.currentHP.Clear();
		data.dataForLua.currentHPHero.Clear();
		data.dataForLua.MaxHP.Clear();
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return false;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return false;
		}
		NAgent agent = agentManager.GetAgent(firstAgentID);
		if (agent != null)
		{
			data.dataForLua.currentHP.Add((agent.Blackboard as BBHumanoid).HP);
			data.dataForLua.MaxHP.Add((agent.Blackboard as BBHumanoid).MaxHP);
			data.dataForLua.currentHPHero.Add(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID);
		}
		else
		{
			data.dataForLua.currentHP.Add(0L);
			data.dataForLua.MaxHP.Add(0L);
			data.dataForLua.currentHPHero.Add(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID);
		}
		agent = agentManager.GetAgent(secondAgentID);
		if (agent != null)
		{
			data.dataForLua.currentHP.Add((agent.Blackboard as BBHumanoid).HP);
			data.dataForLua.MaxHP.Add((agent.Blackboard as BBHumanoid).MaxHP);
			data.dataForLua.currentHPHero.Add(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(1).ID);
		}
		else if (battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count > 1)
		{
			data.dataForLua.currentHP.Add(0L);
			data.dataForLua.MaxHP.Add(0L);
			data.dataForLua.currentHPHero.Add(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(1).ID);
		}
		agent = agentManager.GetAgent(thirdAgentID);
		if (agent != null)
		{
			data.dataForLua.currentHP.Add((agent.Blackboard as BBHumanoid).HP);
			data.dataForLua.MaxHP.Add((agent.Blackboard as BBHumanoid).MaxHP);
			data.dataForLua.currentHPHero.Add(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(2).ID);
		}
		else if (battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count > 2)
		{
			data.dataForLua.currentHP.Add(0L);
			data.dataForLua.MaxHP.Add(0L);
			data.dataForLua.currentHPHero.Add(battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(2).ID);
		}
		return true;
	}

	public static string GetTipsContent(int id)
	{
		bool num = ConfigHelper.GetInstance().TryGetConfig<BattleTips>(id, out var config);
		string result = "";
		if (num)
		{
			result = config.Content;
			WorldStateManager worldStateManager = GetWorldStateManager();
			if (worldStateManager != null && !string.IsNullOrEmpty(worldStateManager.textLanguageSetting))
			{
				switch (worldStateManager.textLanguageSetting)
				{
				case "zh_cn":
					result = config.Content;
					break;
				case "en":
					result = config.ContentEn;
					break;
				case "jp":
					result = config.ContentJp;
					break;
				case "kr":
					result = config.ContentKr;
					break;
				case "tc":
					result = config.ContentTc;
					break;
				case "de":
					result = config.ContentDe;
					break;
				case "fr":
					result = config.ContentFr;
					break;
				}
			}
		}
		return result;
	}

	public static string GetSystemTableI18N(string key)
	{
		WorldStateManager worldStateManager = GetWorldStateManager();
		if (worldStateManager == null || string.IsNullOrEmpty(worldStateManager.textLanguageSetting))
		{
			return key;
		}
		return I18NRuntimeManager.Instance.GetI18NText(key) ?? key;
	}

	public static WorldStateManager GetWorldStateManager()
	{
		if (SceneDirector.Instance == null)
		{
			return null;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetWorldSatetManager();
	}

	public void UpdateSetting()
	{
		if (isGameOver)
		{
			return;
		}
		int num = PlayerPrefs.GetInt("battle_hit_num_mine");
		int num2 = PlayerPrefs.GetInt("battle_hit_num_teammate");
		show_battle_hit_num_mine = num;
		show_battle_hit_num_teammate = num2;
		if (mPlayerAgentID != 0 && !ignoreSystemLockSetting)
		{
			lockType = (LockType)PlayerPrefs.GetInt("battle_lock_type");
			ChooseTargetCommand chooseTargetCommand = CommandFactory.Create(NetprotoOperationCode.CmdChooseTarget) as ChooseTargetCommand;
			chooseTargetCommand.SetData(mPlayerAgentID, (int)lockType, -2);
			ClientSimulator.Instance.SendLocalCommand(chooseTargetCommand);
		}
		string s = PlayerPrefs.GetString("battle_ui_cur_type");
		BattleUI battleUI = BattleUI.GetBattleUI();
		if (battleUI != null && battleUI.adapter != null)
		{
			float alpha = PlayerPrefs.GetFloat("battle_ui_cur_alpha_value", 1f);
			battleUI.adapter.Set(s, alpha);
			if (battleUI.joystickController != null)
			{
				battleUI.joystickController.moveable = PlayerPrefs.GetInt("moveable_stick") == 1;
				if (battleUI.joystickController.lockJoystickMoveable)
				{
					battleUI.joystickController.moveable = false;
				}
			}
			if (lockType != LockType.lockNearest && battleUI.lockButton != null)
			{
				battleUI.lockButton.SetActive(isActive: true, BattleUIElementActiveChangeReason.SystemSetting);
			}
		}
		if (battleUI != null && battleUI.cameraCtrl != null)
		{
			battleUI.cameraCtrl.speed = Mathf.Clamp(PlayerPrefs.GetFloat("battle_ui_cur_rotate_speed", 0.5f), 0.01f, 1f) * 2f;
		}
		textLanguageSetting = PlayerPrefs.GetString("text_language");
		BattleScene.PlayControlledType = (En_CooperateUniqueSkillPlayControlledType)PlayerPrefs.GetInt("CooperateUniqueSkillFullPlayControlledType", 0);
		BattleScene.PlayedOfDaily = PlayerPrefs.GetInt("CooperateUniqueSkillFullPlayedOfDaily", 0) == DateTime.Now.DayOfYear;
	}

	public void GetItem(int id, int num)
	{
		Dictionary<int, int> items = data.dataForLua.items;
		if (ConfigHelper.GetInstance().TryGetConfig<Item>(id, out var config))
		{
			if (items.TryGetValue(config.SystemId, out var value))
			{
				items[config.SystemId] = value + num;
			}
			else
			{
				items[config.SystemId] = num;
			}
		}
	}

	public void RecordData(int id, int num)
	{
		Dictionary<int, int> recordDatas = data.dataForLua.recordDatas;
		if (ConfigHelper.GetInstance().TryGetConfig<battle_record_data_type>(id, out var config))
		{
			if (recordDatas.TryGetValue(config.TypeId, out var value))
			{
				recordDatas[config.TypeId] = value + num;
			}
			else
			{
				recordDatas[config.TypeId] = num;
			}
		}
	}

	public MemberPosition GetMemberPosition(int agentID)
	{
		if (agentID == firstAgentID)
		{
			return MemberPosition.First;
		}
		if (agentID == secondAgentID)
		{
			return MemberPosition.Second;
		}
		if (agentID == thirdAgentID)
		{
			return MemberPosition.Third;
		}
		return MemberPosition.None;
	}

	public int GetLocalPlayerPosition()
	{
		int result = -1;
		if (mPlayerAgentID == firstAgentID)
		{
			result = 0;
		}
		else if (mPlayerAgentID == secondAgentID)
		{
			result = 1;
		}
		else if (mPlayerAgentID == thirdAgentID)
		{
			result = 2;
		}
		return result;
	}

	public static string GetNumberString(int value)
	{
		if (value >= CommonString.Numbers.Length || value < 0)
		{
			return value.ToString();
		}
		return CommonString.Numbers[value];
	}

	public static string GetCfgDescription(int id, int level = 1)
	{
		object[] array = LuaHelper.CallFunction("GetCfgDescription", id, level);
		string result = "";
		if (array != null && array.Length != 0)
		{
			result = (string)array[0];
		}
		return result;
	}
}
