using System;
using System.Collections.Generic;

namespace Model.ErrorAckJosn;

public class ErrorAckJSONList
{
	[Serializable]
	public class ErrorMsgList
	{
		public List<ErrorMsg> errorMsg;

		public ErrorMsgList()
			: this(new List<ErrorMsg>())
		{
		}

		public ErrorMsgList(List<ErrorMsg> list)
		{
			errorMsg = new List<ErrorMsg>
			{
				new ErrorMsg
				{
					id = 1,
					errorMassage = "HandleEnterGameReq game  is nil"
				},
				new ErrorMsg
				{
					id = 2,
					errorMassage = "HandleEnterGameReq CreateSession failed"
				},
				new ErrorMsg
				{
					id = 3,
					errorMassage = "HandleEnterGameReq Unmarshal EnterGameAck failed"
				},
				new ErrorMsg
				{
					id = 10100,
					errorMassage = "HandleWeaponWearReq failed"
				},
				new ErrorMsg
				{
					id = 10200,
					errorMassage = "Weapon Wear failed"
				},
				new ErrorMsg
				{
					id = 10300,
					errorMassage = "has not entityCHaracterData"
				},
				new ErrorMsg
				{
					id = 10400,
					errorMassage = "only can wear type"
				},
				new ErrorMsg
				{
					id = 10500,
					errorMassage = "HandleWeaponLockReq failed: no weapon"
				},
				new ErrorMsg
				{
					id = 10600,
					errorMassage = "HandleWeaponLevelUpReq failed: no weapon"
				},
				new ErrorMsg
				{
					id = 10700,
					errorMassage = "Wear failed: has not config in itemWeaponData"
				},
				new ErrorMsg
				{
					id = 10800,
					errorMassage = "Weapon LevelUp failed"
				},
				new ErrorMsg
				{
					id = 10900,
					errorMassage = "Weapon uid, id LevelUp failed: has not config in itemWeaponData"
				},
				new ErrorMsg
				{
					id = 11000,
					errorMassage = "HandleWeaponStageReq failed: no weapon"
				},
				new ErrorMsg
				{
					id = 11100,
					errorMassage = "Weapon StageUp failed: weapon() level() has not been maximum level() in current stage()"
				},
				new ErrorMsg
				{
					id = 11200,
					errorMassage = "HandleWeaponRefineReq failed: no weapon"
				},
				new ErrorMsg
				{
					id = 11300,
					errorMassage = "Weapon Refine failed"
				},
				new ErrorMsg
				{
					id = 11400,
					errorMassage = "Weapon uid , id  Refine failed"
				},
				new ErrorMsg
				{
					id = 20100,
					errorMassage = "Player TakeLevelReward failed"
				},
				new ErrorMsg
				{
					id = 40100,
					errorMassage = "Scene PickDropPackage failed"
				},
				new ErrorMsg
				{
					id = 40200,
					errorMassage = "Scenes OperateResource failed"
				},
				new ErrorMsg
				{
					id = 40300,
					errorMassage = "Scenes SetupCustomFlag failed"
				},
				new ErrorMsg
				{
					id = 40400,
					errorMassage = "Scenes DelCustomFlag failed"
				},
				new ErrorMsg
				{
					id = 40500,
					errorMassage = "Scenes LightMapBlock failed"
				},
				new ErrorMsg
				{
					id = 40600,
					errorMassage = "Scenes CompleteMapViewLayer failed"
				},
				new ErrorMsg
				{
					id = 50100,
					errorMassage = "EnterRaid failed"
				},
				new ErrorMsg
				{
					id = 50200,
					errorMassage = "EnterRaid calculate rate failed"
				},
				new ErrorMsg
				{
					id = 50300,
					errorMassage = "RechallengeRaid failed"
				},
				new ErrorMsg
				{
					id = 50400,
					errorMassage = "TakeRaidReward failed"
				},
				new ErrorMsg
				{
					id = 50500,
					errorMassage = "TakeRaidReward subtract items failed"
				},
				new ErrorMsg
				{
					id = 50600,
					errorMassage = "Not in raid"
				},
				new ErrorMsg
				{
					id = 60100,
					errorMassage = "RecordSpawnPos failed"
				},
				new ErrorMsg
				{
					id = 60200,
					errorMassage = "RecordCheckPos failed"
				},
				new ErrorMsg
				{
					id = 60300,
					errorMassage = "Profile ReplaceTeamProfile failed"
				},
				new ErrorMsg
				{
					id = 60400,
					errorMassage = "Profile RecordBattleTeam failed"
				},
				new ErrorMsg
				{
					id = 60500,
					errorMassage = "Profile SaveTeamProfile failed"
				},
				new ErrorMsg
				{
					id = 60600,
					errorMassage = "DelPresetTeam failed"
				},
				new ErrorMsg
				{
					id = 60700,
					errorMassage = "ModifyAvatarID failed: has not avatar id"
				},
				new ErrorMsg
				{
					id = 60800,
					errorMassage = "ChangeNickName update in db failed"
				},
				new ErrorMsg
				{
					id = 70100,
					errorMassage = "Missions UpdateMissionState failed"
				},
				new ErrorMsg
				{
					id = 70200,
					errorMassage = "Missions ReplaceMissionTracking failed"
				},
				new ErrorMsg
				{
					id = 70300,
					errorMassage = "Missions AcceptMission failed"
				},
				new ErrorMsg
				{
					id = 80100,
					errorMassage = "ChangeMailState failed"
				},
				new ErrorMsg
				{
					id = 80200,
					errorMassage = "ChangeMailState mail() to state() failed"
				},
				new ErrorMsg
				{
					id = 80300,
					errorMassage = "ChangeMailState call CheckMailRewards failed"
				},
				new ErrorMsg
				{
					id = 80400,
					errorMassage = "ChangeMailState mail has not config"
				},
				new ErrorMsg
				{
					id = 80500,
					errorMassage = "ChangeMailState call MoveMailToRareBox failed"
				},
				new ErrorMsg
				{
					id = 80600,
					errorMassage = "ChangeMailState call ChangeMailType failed"
				},
				new ErrorMsg
				{
					id = 80700,
					errorMassage = "ChangeMailTag failed"
				},
				new ErrorMsg
				{
					id = 80800,
					errorMassage = "ChangeMailTag mail() to tag() failed"
				},
				new ErrorMsg
				{
					id = 80900,
					errorMassage = "UnlockMail failed"
				},
				new ErrorMsg
				{
					id = 90100,
					errorMassage = "Bag UseItems failed"
				},
				new ErrorMsg
				{
					id = 90200,
					errorMassage = "Bag Use items sub cook menu item() failed:"
				},
				new ErrorMsg
				{
					id = 90300,
					errorMassage = "Bag Use items sub item() failed:"
				},
				new ErrorMsg
				{
					id = 90400,
					errorMassage = "HandleDelItemsReq failed"
				},
				new ErrorMsg
				{
					id = 90500,
					errorMassage = "BuyPower failed"
				},
				new ErrorMsg
				{
					id = 90600,
					errorMassage = "ComposeItem failed"
				},
				new ErrorMsg
				{
					id = 90700,
					errorMassage = "ComposeItem compose  subitems failed:"
				},
				new ErrorMsg
				{
					id = 90800,
					errorMassage = "ComposeItem compose  subitems first failed:"
				},
				new ErrorMsg
				{
					id = 90900,
					errorMassage = "ComposeItem compose  failed: lack item  count "
				},
				new ErrorMsg
				{
					id = 100100,
					errorMassage = "AddInterfaceLog failed"
				},
				new ErrorMsg
				{
					id = 200100,
					errorMassage = "DrawCard failed"
				},
				new ErrorMsg
				{
					id = 200200,
					errorMassage = "DrawCard subtract cost() failed"
				},
				new ErrorMsg
				{
					id = 200300,
					errorMassage = "DrawCardChooseItem failed"
				},
				new ErrorMsg
				{
					id = 300100,
					errorMassage = "HandleOperateFriend add friend failed"
				},
				new ErrorMsg
				{
					id = 300200,
					errorMassage = "HandleOperateFriend failed"
				},
				new ErrorMsg
				{
					id = 300300,
					errorMassage = "HandleSearchFriendReq failed"
				},
				new ErrorMsg
				{
					id = 400100,
					errorMassage = "Fish SetupBait failed"
				},
				new ErrorMsg
				{
					id = 400200,
					errorMassage = "Fish StartFish failed"
				},
				new ErrorMsg
				{
					id = 400300,
					errorMassage = "Fish EndFish failed"
				},
				new ErrorMsg
				{
					id = 500100,
					errorMassage = "HandleCook failed"
				},
				new ErrorMsg
				{
					id = 500200,
					errorMassage = "CookFood failed"
				},
				new ErrorMsg
				{
					id = 500300,
					errorMassage = "HandleSaveCustomMenu failed"
				},
				new ErrorMsg
				{
					id = 500400,
					errorMassage = "SaveCustomMenu failed"
				},
				new ErrorMsg
				{
					id = 500500,
					errorMassage = "ModifyCustomMenuName failed"
				},
				new ErrorMsg
				{
					id = 500600,
					errorMassage = "DelCustomMenu failed: idx  out of [0,)"
				},
				new ErrorMsg
				{
					id = 600100,
					errorMassage = "HandleChipWearReq failed: no chip()"
				},
				new ErrorMsg
				{
					id = 600200,
					errorMassage = "Chip Wear failed"
				},
				new ErrorMsg
				{
					id = 600300,
					errorMassage = "HandleChipLockReq failed: no chip()"
				},
				new ErrorMsg
				{
					id = 600400,
					errorMassage = "HandleChipLevelUpReq failed: no chip()"
				},
				new ErrorMsg
				{
					id = 600500,
					errorMassage = "Chip uid  id  LevelUp failed"
				},
				new ErrorMsg
				{
					id = 600600,
					errorMassage = "Chip LevelUp failed"
				},
				new ErrorMsg
				{
					id = 600700,
					errorMassage = "Chip LevelUp sub items failed"
				},
				new ErrorMsg
				{
					id = 700100,
					errorMassage = "HandleCharacterLevelUpReq failed: no character()"
				},
				new ErrorMsg
				{
					id = 700200,
					errorMassage = "Character LevelUp failed"
				},
				new ErrorMsg
				{
					id = 700300,
					errorMassage = "HandleCharacterStageReq failed: no character()"
				},
				new ErrorMsg
				{
					id = 700400,
					errorMassage = "Character StageUp failed"
				},
				new ErrorMsg
				{
					id = 700500,
					errorMassage = "HandleCharacterTakeStageRewardReq failed: no character()"
				},
				new ErrorMsg
				{
					id = 700600,
					errorMassage = "Character TakeStageReward failed"
				},
				new ErrorMsg
				{
					id = 700700,
					errorMassage = "HandleCharacterStatusSyncReq failed: empty array"
				},
				new ErrorMsg
				{
					id = 700800,
					errorMassage = "HandleCharacterStatusSyncReq player is nil"
				},
				new ErrorMsg
				{
					id = 700900,
					errorMassage = "Character SyncStatus failed: has not character()"
				},
				new ErrorMsg
				{
					id = 700110,
					errorMassage = "Character SyncStatus failed: status is invalid()"
				},
				new ErrorMsg
				{
					id = 700120,
					errorMassage = "HandleCharacterUpgradeSkillGroupReq failed: has not character()"
				},
				new ErrorMsg
				{
					id = 700130,
					errorMassage = "Character() UpgradeSkillGroup failed"
				},
				new ErrorMsg
				{
					id = 700140,
					errorMassage = "Character() UpgradeSkillGroup() failed"
				},
				new ErrorMsg
				{
					id = 700150,
					errorMassage = "HandleCharacterUpgradeConstellationReq failed: has not character()"
				},
				new ErrorMsg
				{
					id = 700160,
					errorMassage = "Character() SwitchConstellation failed"
				},
				new ErrorMsg
				{
					id = 800100,
					errorMassage = "HandleCreateBillOrdersReq failed"
				},
				new ErrorMsg
				{
					id = 800200,
					errorMassage = "Bill MakeSign failed"
				},
				new ErrorMsg
				{
					id = 800300,
					errorMassage = "Bill MakeSign convert app id to int failed"
				},
				new ErrorMsg
				{
					id = 800400,
					errorMassage = "HandleShopBuyCommodityReq failed"
				},
				new ErrorMsg
				{
					id = 900100,
					errorMassage = "Assist Dyeing failed"
				},
				new ErrorMsg
				{
					id = 900200,
					errorMassage = "Assist Setup failed"
				},
				new ErrorMsg
				{
					id = 900300,
					errorMassage = "Assist Equip failed"
				},
				new ErrorMsg
				{
					id = 10100,
					errorMassage = "ActivePointSystem HandleTakeDailyReward failed"
				},
				new ErrorMsg
				{
					id = 10200,
					errorMassage = "ActivePointSystem HandleTakeDailyReward sub items failed"
				},
				new ErrorMsg
				{
					id = 10300,
					errorMassage = "ActivePointSystem HandleTakeExtraReward failed"
				},
				new ErrorMsg
				{
					id = 10400,
					errorMassage = "ActivePointSystem HandleTakeExtraReward sub items failed"
				},
				new ErrorMsg
				{
					id = 20100,
					errorMassage = "Achievements TakeReward failed"
				},
				new ErrorMsg
				{
					id = 20200,
					errorMassage = "Achievements TakeGroupReward failed"
				},
				new ErrorMsg
				{
					id = 20300,
					errorMassage = "CompleteAchievement failed"
				},
				new ErrorMsg
				{
					id = 20400,
					errorMassage = "CompleteAchievement check failed"
				},
				new ErrorMsg
				{
					id = 20500,
					errorMassage = "ChangeAchievementTag failed"
				},
				new ErrorMsg
				{
					id = 20600,
					errorMassage = "RecordConversation failed"
				},
				new ErrorMsg
				{
					id = 20700,
					errorMassage = "RecordConversationOptionReq failed"
				},
				new ErrorMsg
				{
					id = 30100,
					errorMassage = "ChallengeStage failed"
				},
				new ErrorMsg
				{
					id = 30200,
					errorMassage = "Challenge failed"
				},
				new ErrorMsg
				{
					id = 30300,
					errorMassage = "CompleteSubStage failed"
				},
				new ErrorMsg
				{
					id = 30400,
					errorMassage = "TakeReward failed"
				},
				new ErrorMsg
				{
					id = 30500,
					errorMassage = "Rechallenge failed"
				},
				new ErrorMsg
				{
					id = 40100,
					errorMassage = "Bag SubItems failed: helper is nil"
				},
				new ErrorMsg
				{
					id = 40200,
					errorMassage = "Bag AddItemsWithParams failed: can not GetItemData with id()"
				},
				new ErrorMsg
				{
					id = 40300,
					errorMassage = "Bag SubItems from attribute failed"
				},
				new ErrorMsg
				{
					id = 40400,
					errorMassage = "SubAttribute can not sub k"
				},
				new ErrorMsg
				{
					id = 40500,
					errorMassage = "SubAttribute bad k"
				},
				new ErrorMsg
				{
					id = 40600,
					errorMassage = "SubAttribute k is , v: should great than 0"
				},
				new ErrorMsg
				{
					id = 40700,
					errorMassage = "SubAttribute k is , user.Props[k]: < v:"
				},
				new ErrorMsg
				{
					id = 40800,
					errorMassage = "Bag SubItems from ItemBag failed"
				},
				new ErrorMsg
				{
					id = 40900,
					errorMassage = "DefaultBaseBagNoID Sub() count() err"
				},
				new ErrorMsg
				{
					id = 40110,
					errorMassage = "DefaultBaseBagNoID Sub() count() no item"
				},
				new ErrorMsg
				{
					id = 40120,
					errorMassage = "AdjustWorldLevel failed"
				},
				new ErrorMsg
				{
					id = 40130,
					errorMassage = "Player TakeLevelReward failed"
				},
				new ErrorMsg
				{
					id = 40140,
					errorMassage = "Shop Buy failed"
				}
			};
		}
	}
}
