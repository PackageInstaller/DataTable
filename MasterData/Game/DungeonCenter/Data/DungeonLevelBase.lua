local DungeonLevelBase = class("DungeonLevelBase")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function DungeonLevelBase:ctor(stageId)
  self.__stageId = stageId
  self.__dungeonStageCfg = ConfigData.battle_dungeon[stageId]
end

function DungeonLevelBase:GetDungeonLevelStageId()
  return self.__stageId
end

function DungeonLevelBase:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.None
end

function DungeonLevelBase:GetDungeonLevelName()
  return LanguageUtil.GetLocaleText(self.__dungeonStageCfg.name)
end

function DungeonLevelBase:GetDungeonInfoDesc()
end

function DungeonLevelBase:GetDungeonLevelPic()
end

function DungeonLevelBase:GetRecommendCombat()
  return self.__dungeonStageCfg.combat
end

function DungeonLevelBase:GetRecommendBenchCombat()
  return self.__dungeonStageCfg.bench_combat
end

function DungeonLevelBase:GetEnterLevelCost()
  return ConstGlobalItem.SKey
end

function DungeonLevelBase:GetLevelResourceGroup()
  return self:GetEnterLevelCost()
end

function DungeonLevelBase:GetConsumeKeyNum()
  for index, id in pairs(self.__dungeonStageCfg.cost_itemIds) do
    if id == ConstGlobalItem.SKey then
      return self.__dungeonStageCfg.cost_itemNums[index]
    end
  end
  return 0
end

function DungeonLevelBase:GetEnterLevelCostItemName()
  local costId = self:GetEnterLevelCost()
  if costId == nil then
    return ""
  end
  return ConfigData:GetItemName(costId)
end

function DungeonLevelBase:GetDungeonFirstReward()
  return self.__dungeonStageCfg.first_reward_ids, self.__dungeonStageCfg.first_reward_nums
end

function DungeonLevelBase:GetDungeonBuffListCfg()
  return self.__dungeonStageCfg.protocol
end

function DungeonLevelBase:HasRecommendFormation()
  return false
end

function DungeonLevelBase:GetLevelUnlockConditionCfg()
  return self.__dungeonStageCfg.pre_condition, self.__dungeonStageCfg.pre_para1, self.__dungeonStageCfg.pre_para2
end

function DungeonLevelBase:GetSpecialUnlockInfo()
  return nil
end

function DungeonLevelBase:GetIsLevelUnlock()
  return CheckCondition.CheckLua(self:GetLevelUnlockConditionCfg())
end

function DungeonLevelBase:GetIsUnlockDes()
  return CheckCondition.GetUnlockInfoLua(self:GetLevelUnlockConditionCfg())
end

function DungeonLevelBase:GetEnterChipSelectCfg()
  return self.__dungeonStageCfg.enter_chip_select
end

function DungeonLevelBase:DealDungeonResult(resultInfo)
end

function DungeonLevelBase:GetDunServerRacingFrame()
  return -1
end

function DungeonLevelBase:IsDunCustomTicket()
  local dunLevelType = self:GetDungeonLevelType()
  return DungeonLevelEnum.DunCustomTicket[dunLevelType] or false
end

function DungeonLevelBase:GetDunExtraBuffDic()
  return nil
end

function DungeonLevelBase:GetDunExtraDelectedBuffDic()
  return nil
end

function DungeonLevelBase:GetIsCouldPlayOnce()
  local ticketItemId = self:GetEnterLevelCost()
  local ticketItemCount = PlayerDataCenter:GetItemCount(ticketItemId)
  local ticketSingleCost = self:GetConsumeKeyNum()
  return ticketItemCount >= ticketSingleCost
end

function DungeonLevelBase:GetAssistanceId()
  return 0
end

function DungeonLevelBase:GetIsShowRacingTime()
  return false
end

function DungeonLevelBase:GetIsShowDamageNum()
  return false
end

function DungeonLevelBase:GetIsShowDunRank()
  return false
end

function DungeonLevelBase:IsDgQuickBattleOpen()
  return self.__dungeonStageCfg.quick_battle
end

function DungeonLevelBase:IsDgQuickBattleUnlock()
  return true
end

function DungeonLevelBase:GetDgLvDoduleId()
  return self.__dungeonStageCfg.module_id
end

function DungeonLevelBase:GetBelongActData()
end

function DungeonLevelBase:GetCantAutoBattleTip()
  return nil
end

return DungeonLevelBase
