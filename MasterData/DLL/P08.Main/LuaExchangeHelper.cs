using System;
using System.Collections.Generic;
using System.IO;
using NetProcol;
using P08Main.Loading;
using Packages.P08Base.Net;
using UnityEngine;

public class LuaExchangeHelper
{
	public static StatisticsData data;

	private static Op_C2B_PlayerReady GetReadyMessage(SceneDataForExcehange luaDataForExcehange)
	{
		Op_C2B_PlayerReady op_C2B_PlayerReady = new Op_C2B_PlayerReady();
		op_C2B_PlayerReady.BattleID = luaDataForExcehange.battleID;
		op_C2B_PlayerReady.Uuid = luaDataForExcehange.Uuid;
		SceneDataForExcehangeInfo sceneDataForExcehangeInfo = new SceneDataForExcehangeInfo();
		sceneDataForExcehangeInfo.MSceneID = luaDataForExcehange.mSceneID;
		sceneDataForExcehangeInfo.MMissionClearTimes = luaDataForExcehange.mMissionClearTimes;
		if (luaDataForExcehange.typeIDListAffix.Length == luaDataForExcehange.levelList.Length && luaDataForExcehange.levelList.Length == luaDataForExcehange.enemyTypes.Length)
		{
			for (int i = 0; i < luaDataForExcehange.typeIDListAffix.Length; i++)
			{
				sceneDataForExcehangeInfo.TypeIDListAffix.Add(luaDataForExcehange.typeIDListAffix[i]);
				sceneDataForExcehangeInfo.LevelList.Add(luaDataForExcehange.levelList[i]);
				sceneDataForExcehangeInfo.EnemyTypes.Add(luaDataForExcehange.enemyTypes[i]);
			}
		}
		sceneDataForExcehangeInfo.ChallengeFactor = luaDataForExcehange.challengeFactor;
		sceneDataForExcehangeInfo.Difficulty = luaDataForExcehange.difficulty;
		sceneDataForExcehangeInfo.AdaptiveEnemyLevel = luaDataForExcehange.adaptiveEnemyLevel;
		sceneDataForExcehangeInfo.NeedResurrect = luaDataForExcehange.needResurrect;
		sceneDataForExcehangeInfo.CoinNumber = luaDataForExcehange.coinNumber;
		sceneDataForExcehangeInfo.CoinConsume = luaDataForExcehange.coinConsume;
		sceneDataForExcehangeInfo.ResurrectHP = luaDataForExcehange.resurrectHP;
		sceneDataForExcehangeInfo.CooperateUniqueSkillID = luaDataForExcehange.cooperateUniqueSkillID;
		sceneDataForExcehangeInfo.AttributeFactorX = luaDataForExcehange.attributeFactor.x;
		sceneDataForExcehangeInfo.AttributeFactorY = luaDataForExcehange.attributeFactor.y;
		sceneDataForExcehangeInfo.AttributeFactorZ = luaDataForExcehange.attributeFactor.z;
		sceneDataForExcehangeInfo.IndexOfMaxCountRace = luaDataForExcehange.maxRaceID;
		sceneDataForExcehangeInfo.NumOfMaxCountRace = luaDataForExcehange.maxRacePlayerCount;
		sceneDataForExcehangeInfo.LeftTime = luaDataForExcehange.leftTime;
		sceneDataForExcehangeInfo.TargetEnemyID = luaDataForExcehange.targetEnemyID;
		RoleDataForExchange[] roleDataInLua = luaDataForExcehange.roleDataInLua;
		foreach (RoleDataForExchange roleDataForExchange in roleDataInLua)
		{
			RoleDataForExchangeInfo roleDataForExchangeInfo = new RoleDataForExchangeInfo();
			roleDataForExchangeInfo.ID = roleDataForExchange.ID;
			roleDataForExchangeInfo.Level = roleDataForExchange.Level;
			roleDataForExchangeInfo.PlayerLevel = roleDataForExchange.playerLevel;
			if (roleDataForExchange.attributeID != null && roleDataForExchange.attributeValue != null && roleDataForExchange.attributeID.Length == roleDataForExchange.attributeValue.Length)
			{
				for (int k = 0; k < roleDataForExchange.attributeID.Length; k++)
				{
					roleDataForExchangeInfo.AttributeID.Add(roleDataForExchange.attributeID[k]);
					roleDataForExchangeInfo.AttributeValue.Add(roleDataForExchange.attributeValue[k]);
				}
			}
			roleDataForExchangeInfo.AttributeID.Add(2222);
			roleDataForExchangeInfo.AttributeValue.Add(roleDataForExchange.mainDamageType);
			if (roleDataForExchange.astrolabe != null)
			{
				int[] astrolabe = roleDataForExchange.astrolabe;
				foreach (int item in astrolabe)
				{
					roleDataForExchangeInfo.Astrolabe.Add(item);
				}
			}
			if (roleDataForExchange.equipment != null)
			{
				int[] astrolabe = roleDataForExchange.equipment;
				foreach (int item2 in astrolabe)
				{
					roleDataForExchangeInfo.Equipment.Add(item2);
				}
			}
			if (roleDataForExchange.skillLevel != null)
			{
				int[] astrolabe = roleDataForExchange.skillLevel;
				foreach (int item3 in astrolabe)
				{
					roleDataForExchangeInfo.SkillLevel.Add(item3);
				}
			}
			if (roleDataForExchange.equipSkillID != null)
			{
				int[] astrolabe = roleDataForExchange.equipSkillID;
				foreach (int item4 in astrolabe)
				{
					roleDataForExchangeInfo.EquipmentSkill.Add(item4);
				}
			}
			if (roleDataForExchange.equipSkillLv != null)
			{
				int[] astrolabe = roleDataForExchange.equipSkillLv;
				foreach (int item5 in astrolabe)
				{
					roleDataForExchangeInfo.EquipmentSkillLv.Add(item5);
				}
			}
			roleDataForExchangeInfo.WeaponEffectID = roleDataForExchange.weaponEffectID;
			roleDataForExchangeInfo.WeaponEffectLevel = roleDataForExchange.weaponEffectLevel;
			if (roleDataForExchange.AIChip != null)
			{
				int[] astrolabe = roleDataForExchange.AIChip;
				foreach (int item6 in astrolabe)
				{
					roleDataForExchangeInfo.AIChip.Add(item6);
				}
			}
			roleDataForExchangeInfo.IsVow = roleDataForExchange.isVow;
			sceneDataForExcehangeInfo.RoleDataInLua.Add(roleDataForExchangeInfo);
		}
		sceneDataForExcehangeInfo.CooperateUniqueSkillLevel = luaDataForExcehange.cooperateUniqueSkillLevel;
		sceneDataForExcehangeInfo.VHLResult = luaDataForExcehange.VHLResult;
		if (luaDataForExcehange.VHLSkillID != null)
		{
			for (int m = 0; m < luaDataForExcehange.VHLSkillID.Length; m++)
			{
				sceneDataForExcehangeInfo.VHLSkillID.Add(luaDataForExcehange.VHLSkillID[m]);
			}
		}
		if (luaDataForExcehange.masterSkill != null)
		{
			RoleDataForExchangeInfo roleDataForExchangeInfo2 = new RoleDataForExchangeInfo();
			roleDataForExchangeInfo2.ID = luaDataForExcehange.masterSkill.ID;
			if (luaDataForExcehange.masterSkill.attributeID != null && luaDataForExcehange.masterSkill.attributeValue != null && luaDataForExcehange.masterSkill.attributeID.Length == luaDataForExcehange.masterSkill.attributeValue.Length)
			{
				for (int n = 0; n < luaDataForExcehange.masterSkill.attributeID.Length; n++)
				{
					roleDataForExchangeInfo2.AttributeID.Add(luaDataForExcehange.masterSkill.attributeID[n]);
					roleDataForExchangeInfo2.AttributeValue.Add(luaDataForExcehange.masterSkill.attributeValue[n]);
				}
			}
			roleDataForExchangeInfo2.IsVow = luaDataForExcehange.masterSkill.isVow;
			sceneDataForExcehangeInfo.MasterSkill = roleDataForExchangeInfo2;
		}
		op_C2B_PlayerReady.SceneDataForExcehange = sceneDataForExcehangeInfo;
		op_C2B_PlayerReady.BattleVersionCode = GlobalStaticLoader.battleVersionCode;
		return op_C2B_PlayerReady;
	}

	private static void InitBattleScene(SceneDataForExcehange sceneDataForExcehange, BattleScene s)
	{
		s.ready = GetReadyMessage(sceneDataForExcehange);
		s.mGameMode = ((!sceneDataForExcehange.isMultiplayer) ? GameMode.SinglePlayer : GameMode.Multiplayer);
		s.resurrectImmediately = sceneDataForExcehange.resurrectImmediately;
		s.resurrectCoinNumber = sceneDataForExcehange.coinNumber;
		s.maxResurrectCoinNumber = ((sceneDataForExcehange.maxCoinNumber == 0L) ? 3 : sceneDataForExcehange.maxCoinNumber);
		s.nickName = sceneDataForExcehange.nickName;
		s.localPlayerIndex = 0;
		if (sceneDataForExcehange.isMultiplayer)
		{
			for (int i = 0; i < sceneDataForExcehange.roleDataInLua.Length; i++)
			{
				if (sceneDataForExcehange.roleDataInLua[i].UID == (long)sceneDataForExcehange.Uuid)
				{
					s.localPlayerIndex = i;
					break;
				}
			}
		}
		if (sceneDataForExcehange.masterSkill != null)
		{
			s.masterSkillLevel = sceneDataForExcehange.masterSkill.masterSkillRenderLevel;
			s.masterSkinID = sceneDataForExcehange.masterSkill.masterSkinID;
			s.roleSkinID = sceneDataForExcehange.masterSkill.roleSkinID;
			s.isMasterSkillVow = sceneDataForExcehange.masterSkill.isVow;
		}
	}

	private static bool SameRole(Op_C2B_PlayerReady ready, SceneDataForExcehange sceneDataForExcehange)
	{
		if (ready.SceneDataForExcehange.RoleDataInLua.Count != sceneDataForExcehange.roleDataInLua.Length)
		{
			return false;
		}
		for (int i = 0; i < ready.SceneDataForExcehange.RoleDataInLua.Count; i++)
		{
			if (ready.SceneDataForExcehange.RoleDataInLua.get_Item(i).ID != sceneDataForExcehange.roleDataInLua[i].ID)
			{
				return false;
			}
		}
		return true;
	}

	public static void Launcher(SceneDataForExcehange sceneDataForExcehange, Action callback, Action onSceneReadyCallback = null)
	{
		ReloadBattleRecordData();
		if (string.IsNullOrEmpty(BattleScene.Port))
		{
			Debug.LogError("战斗服务器端口非法！(IP:" + BattleScene.IP + ",PORT: " + BattleScene.Port + ")");
			return;
		}
		BattleScene.PlayedOfBattle = false;
		try
		{
			BattleScene s = NScene.GetCurrentScene() as BattleScene;
			if (s != null)
			{
				s.CloseSimulator();
			}
			if (string.IsNullOrEmpty(BattleScene.Port))
			{
				Debug.LogError("战斗服务器端口非法！(IP:" + BattleScene.IP + ",PORT: " + BattleScene.Port + ")");
				return;
			}
			ClientUDPNet net = SceneDirector.Instance.gameObject.GetComponent<ClientUDPNet>();
			if (net != null)
			{
				UnityEngine.Object.DestroyImmediate(net);
			}
			net = SceneDirector.Instance.gameObject.AddComponent<ClientUDPNet>();
			int oldSceneID = -1;
			if (s != null && s.ready != null && s.ready.SceneDataForExcehange != null)
			{
				oldSceneID = s.ready.SceneDataForExcehange.MSceneID;
			}
			if (s == null || oldSceneID != sceneDataForExcehange.mSceneID || !SameRole(s.ready, sceneDataForExcehange))
			{
				net.Connect(BattleScene.IP, int.Parse(BattleScene.Port), delegate
				{
					try
					{
						if (callback != null)
						{
							callback();
						}
						BattleSceneLoader.customLoading = sceneDataForExcehange.customLoading;
						BattleScene battleScene = NScene.Load<BattleScene>();
						if (onSceneReadyCallback != null)
						{
							battleScene.onBattleSceneReady = onSceneReadyCallback;
						}
						battleScene.SetNetwork(net);
						InitBattleScene(sceneDataForExcehange, battleScene);
					}
					catch (Exception ex2)
					{
						Debug.LogError(ex2.Message);
						Debug.LogError(ex2.StackTrace);
					}
				}, BattleServerConnectError);
				return;
			}
			net.Connect(BattleScene.IP, int.Parse(BattleScene.Port), delegate
			{
				try
				{
					if (callback != null)
					{
						callback();
					}
					s.SetNetwork(net);
					InitBattleScene(sceneDataForExcehange, s);
					SceneDirector.Instance.Restart(oldSceneID);
				}
				catch (Exception ex2)
				{
					Debug.LogError(ex2.Message);
					Debug.LogError(ex2.StackTrace);
				}
			}, BattleServerConnectError);
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.Message);
			Debug.LogError(ex.StackTrace);
		}
	}

	private static void BattleServerConnectError(int errorCode)
	{
		LuaHelper.CallFunction("BattleServerConnectError", errorCode);
	}

	public static void Reload()
	{
		ReloadBattleRecordData();
		SceneDirector.Instance.Reload();
	}

	public static void GoToMain(int customLoading = -1)
	{
		if (customLoading != -1)
		{
			MainScene.UseCustomLoading = true;
			MainScene.customLoading = (LoadingImpl)customLoading;
		}
		NScene.Load<MainScene>();
	}

	public static bool GetSceneIsHanding()
	{
		return NScene.IsHanding();
	}

	public static void ReloadBattleRecordData()
	{
		BattleScene.isPause = false;
	}

	public static void ContinueGame()
	{
		BattleScene.isPause = false;
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			battleScene.GetBattleSimulatorSystem().ResumeGame();
		}
		else
		{
			Debug.LogError("Continue Failed");
		}
	}

	public static void PauseGame()
	{
		if (!BattleScene.isPause)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && BattleUI.GetBattleUIIsActive())
			{
				battleScene.ShowPauseUI();
				battleScene.GetBattleSimulatorSystem().PauseGame();
			}
		}
	}

	public static void GameOver(int result, int customSceneID = -1)
	{
		if (customSceneID != -1)
		{
			BattleSceneLoader.customLoading = customSceneID;
		}
		ContinueGame();
		GameStopCommand gameStopCommand = CommandFactory.Create(NetprotoOperationCode.CmdGameStop) as GameStopCommand;
		for (MemberPosition memberPosition = MemberPosition.First; memberPosition <= MemberPosition.Third; memberPosition++)
		{
			NAgent agentByMemberPostion = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgentByMemberPostion(memberPosition);
			if (agentByMemberPostion != null)
			{
				gameStopCommand.SetData(agentByMemberPostion.AgentID, (E_BattleResult)result);
				ClientSimulator.Instance.SendLocalCommand(gameStopCommand);
				break;
			}
		}
	}

	public static void SetIPAndPort(string ip, string port)
	{
		BattleScene.IP = ip;
		BattleScene.Port = port;
		Debug.Log("IP ====> " + ip + " PORT " + port);
	}

	public static void SetNewbie(bool newbie)
	{
		BattleScene.Newbie = newbie;
	}

	public static void SetPlayerQuality(int quality)
	{
		BattleScene.MainPlayerQuality = (EEffectQuality)quality;
	}

	public static void SetAIQuality(int quality)
	{
		BattleScene.AIQuality = (EEffectQuality)quality;
	}

	public static void SetFriendQuality(bool isHide)
	{
		BattleScene.IsHideFriendEffect = isHide;
	}

	public static StatisticsData GetBattleStatisticsData()
	{
		return data;
	}

	public static StatisticsData GetBattleStatisticsDataBeforeBattleEnd()
	{
		return (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().data;
	}

	public static bool ClearDownloadAssetsFolder()
	{
		GameMain.DeleteFolder(Platform.GetDownloadPersistentDataPath());
		Application.Quit();
		return Directory.Exists(Platform.GetDownloadPersistentDataPath());
	}

	public static List<Vector3> GetCurrentAffixInScene()
	{
		List<Vector3> list = new List<Vector3>();
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		for (int i = 0; i < battleScene.ready.SceneDataForExcehange.TypeIDListAffix.Count; i++)
		{
			if (battleScene.ready.SceneDataForExcehange.EnemyTypes.get_Item(i) == 3)
			{
				int num = battleScene.ready.SceneDataForExcehange.TypeIDListAffix.get_Item(i);
				int num2 = battleScene.ready.SceneDataForExcehange.LevelList.get_Item(i);
				int num3 = battleScene.ready.SceneDataForExcehange.EnemyTypes.get_Item(i);
				list.Add(new Vector3(num, num2, num3));
			}
		}
		return list;
	}

	public static void ApplyBattleSetting()
	{
		WorldStateManager.GetWorldStateManager()?.UpdateSetting();
	}

	public static void ActionInvoke(Action action)
	{
		action();
	}

	public static void SetRoleData(SceneDataForExcehange sceneDataForExcehange)
	{
	}

	public static void EndWaitReadyAck()
	{
		ClientSimulator.Instance.mWasSimRunning = true;
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return;
		}
		if (battleScene.battlePanelGameObject != null)
		{
			battleScene.battlePanelGameObject.SetActive(value: false);
		}
		Dictionary<int, GameObject> renderCharactor = battleScene.GetRenderCharactor();
		if (renderCharactor == null)
		{
			return;
		}
		foreach (KeyValuePair<int, GameObject> item in renderCharactor)
		{
			item.Value.SetActive(value: false);
		}
	}

	public static string GetDescription(string templete, object[] param)
	{
		return string.Format(templete, param);
	}

	public static void SetCooperateUniqueSkillPlayControlledType(int type)
	{
		BattleScene.PlayControlledType = (En_CooperateUniqueSkillPlayControlledType)type;
	}

	public static void SetCacheSize(int size)
	{
		RunTimeTimelineAndHitCache.cache.SetMaxLength(size);
	}

	public static void EnableATrigger(int oriID, int targetID)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null)
		{
			if (targetID != -1)
			{
				ChangeTriggerStateCommand changeTriggerStateCommand = CommandFactory.Create(NetprotoOperationCode.CmdModifyTriggerState) as ChangeTriggerStateCommand;
				changeTriggerStateCommand.SetData(agentManager.mPlayerAgentID, oriID, targetID, enable: true);
				ClientSimulator.Instance.SendLocalCommand(changeTriggerStateCommand);
			}
		}
	}

	public static int GetBattleModuleBuffEnum()
	{
		return 2150;
	}

	public static void LoadEmpty(Action action)
	{
		SceneDirector.Instance.LoadEmptyScene(action);
	}
}
