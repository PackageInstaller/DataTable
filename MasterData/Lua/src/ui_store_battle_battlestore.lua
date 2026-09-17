local this = class("battleStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "battle.battleState"))
this:importPartialClass(require(L_R.store .. "battle.battleAction"))
this.event = {}

function this:ctor()
  this.super.ctor(self)
end

function this:setBattleId(battleId)
  self.data.battleId = battleId
end

function this:addItem(item)
  table.insert(self.data.battleItems, item)
end

function this:setItemIdToTag(itemId, tag)
  self.data.tagDic[itemId] = tag
end

function this:exitBattle()
  self.data.battleItems = {}
  self.data.battleId = nil
  self.data.createBattleType = nil
  self.data.newPos = nil
end

function this:setCreateBattleType(type)
  self.data.createBattleType = type
end

function this:setHeroDataCache(cache)
  self.data.heroCache = cache
end

function this:setOneKeyTeamChange(changeType)
  self.data.oneKeyChangeType = changeType
  C_PlayerPrefsUtility.SetInt(L_Const.SaveKey_OneKeyBattleChangeType, changeType)
end

return this
