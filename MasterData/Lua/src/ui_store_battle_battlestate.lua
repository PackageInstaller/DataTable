local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    battleId = nil,
    battleItems = {},
    battleServerData = nil,
    rewardList = nil,
    catchRewardList = nil,
    createBattleType = nil,
    tagDic = {},
    heroCache = nil,
    oneKeyChangeType = C_PlayerPrefsUtility.GetInt(L_Const.SaveKey_OneKeyBattleChangeType, L_Const.OneKeyBattleChangeType.loop),
    objBattleInfo = {},
    battleRewardShowMark = false
  }
  self:setFightOver()
end

function this:getObjBattleInfo(uuid)
  return self.data.objBattleInfo[uuid] or {}
end

function this:getBattleTagByItemId(itemId)
  return self.data.tagDic[itemId]
end

function this:getBattleId()
  return self.data.battleId
end

function this:getBattleServerData()
  return self.data.battleServerData
end

function this:getBattleIsBackstab()
  if not self:getBattleServerData() then
    return false
  end
  return self.data.battleServerData.backstab == 1
end

function this:getIsInBattle()
  return L_BattleDataManager:checkPlayerBattle()
end

function this:getBattleItems()
  return self.data.battleItems
end

function this:getBattleReward()
  return self.data.rewardList or {}
end

function this:getCatchReward()
  return self.data.catchRewardList or {}
end

function this:getParseBattleReward(sType)
  local data = self:getBattleReward()
  if sType and sType == L_Const.FightRewardReason.FRR_Catch then
    data = self:getCatchReward()
  end
  local res = {}
  for i, v in pairs(data) do
    local item = v
    if item.itemtype ~= nil then
      if not res[item.itemtype] then
        res[item.itemtype] = {}
      end
      if not math.isEmpty(item.guid) then
        res[item.itemtype][item.guid] = v
      else
        res[item.itemtype][item.itemid] = v
      end
    end
  end
  return res
end

function this:getCreateBattleType()
  return self.data.createBattleType
end

function this:getHeroCacheData()
  return self.data.heroCache
end

function this:getBattleEntry()
  if self.data.battleServerData == nil then
    return L_Const.BattleEntryType.BET_INTERIMER
  end
  return self.data.battleServerData.entry
end

function this:getOneKeyChangeType()
  return self.data.oneKeyChangeType
end

function this:checkRewardShown()
  return self.data.battleRewardShowMark
end

return this
