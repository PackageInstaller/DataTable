local this = {}
local currencyTpl = L_GameTpl:getCurrencyTpl()

function this:init()
  this.super.init(self)
  self.data = {
    mapInfo = require(L_R.store .. "player.data.playerMapInfo").new(),
    baseInfo = require(L_R.store .. "player.data.playerBaseInfo").new(),
    attrInfo = {},
    actAttrInfo = {},
    modAvatar = nil
  }
  self.expUpParam = {
    curLv = 0,
    curExp = 0,
    lastLv = 0,
    lastExp = 0,
    isLevelUp = false
  }
  self.totalExpParam = {
    fromExp = 0,
    fromLv = 0,
    toExp = 0,
    toLv = 0,
    isLevelUp = false
  }
  self.lastLv = 0
  self.expMsgQueued = false
  self.expMsgOngoing = false
  self.expMsgQueuedIsReplay = false
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange, self)
end

function this:getPlayerModHeadImgName()
  return self:getAvatarTexturePath(L_Const.avatarTextureIndex.head)
end

function this:getPlayerModHalfBodyName()
  return self:getAvatarTexturePath(L_Const.avatarTextureIndex.half_raffle)
end

function this:getAvatarTexturePath(index)
  local modData = self.data.modAvatar
  local avatarUrl = ""
  if modData ~= nil then
    if index == L_Const.avatarTextureIndex.painting then
      avatarUrl = modData.paintUrl
    elseif index == L_Const.avatarTextureIndex.half_raffle then
      avatarUrl = modData.halfBodyUrl
    elseif index == L_Const.avatarTextureIndex.half_formation then
      avatarUrl = modData.halfsHeadUrl
    elseif index == L_Const.avatarTextureIndex.head then
      avatarUrl = modData.headImgUrl
    elseif index == L_Const.avatarTextureIndex.head_circle then
      avatarUrl = modData.circleHeadUrl
    elseif index == L_Const.avatarTextureIndex.head_talk then
      avatarUrl = modData.battleHeadUrl
    elseif index == L_Const.avatarTextureIndex.body then
      avatarUrl = modData.bodyUrl
    end
  end
  if string.isEmpty(avatarUrl) then
    local screenShotType = L_Const.avatarTextureIndex2screenShotType[index]
    if screenShotType then
      return screenShotType
    end
    return L_Const.screenShotType.hearHeadImg
  end
  return avatarUrl
end

function this:getPlayerMapInfo()
  return self.data.mapInfo
end

function this:getPlayerMount()
  return self.data.mapInfo.mount
end

function this:playerInMountStatus()
  return self:getPlayerStatus() == L_Const.WorldMapPlayerStatusType.WMPST_MOUNT
end

function this:getPlayerStatus()
  return self.data.mapInfo.status
end

function this:getMountStatus()
  return self.data.mapInfo.mount_status
end

function this:getPlayerBaseInfo()
  return self.data.baseInfo
end

function this:getPlayerId()
  return self.data.baseInfo.id
end

function this:getPlayerName()
  return self.data.baseInfo.name
end

function this:getLv()
  if self.data == nil or self.data.baseInfo == nil then
    return 1, false
  end
  local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
  local minLv = playerLevelTpl:getId(playerLevelTpl.data[1])
  local maxLv = playerLevelTpl:getId(playerLevelTpl.data[#playerLevelTpl.data])
  local curLv = math.clamp(self.data.baseInfo.lv, minLv, maxLv)
  return curLv, curLv == maxLv
end

function this:checkIsMaxLv()
  if self.data == nil or self.data.baseInfo == nil then
    return false
  end
  local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
  local minLv = playerLevelTpl:getId(playerLevelTpl.data[1])
  local maxLv = playerLevelTpl:getId(playerLevelTpl.data[#playerLevelTpl.data])
  local curLv = math.clamp(self.data.baseInfo.lv, minLv, maxLv)
  return curLv == maxLv
end

function this:getExp()
  return self.data.baseInfo.exp
end

function this:getSex()
  return self.data.baseInfo.sex
end

function this:getSign()
  return self.data.baseInfo.sign
end

function this:getDisplayHero()
  local hero = self.data.baseInfo.info.hero or {}
  local res = {}
  for i, v in pairs(hero) do
    res[v.pos] = v
  end
  return res
end

function this:getDisplayPet()
  return self.data.baseInfo.info.pet or {}
end

function this:getDisplayAchievement()
  local res = {
    0,
    0,
    0
  }
  if self.data.baseInfo.info == nil or self.data.baseInfo.info.achievement == nil then
    return res
  end
  for i, v in pairs(self.data.baseInfo.info.achievement) do
    res[i] = v
  end
  return res
end

function this:getPreTitle()
  return self.data.baseInfo.preffix_title == 0 and 171000 or self.data.baseInfo.preffix_title
end

function this:getLaterTitle()
  return self.data.baseInfo.suffix_title == 0 and 172000 or self.data.baseInfo.suffix_title
end

function this:getLastChangeNameTime()
  return self.data.baseInfo.last_change_name_time
end

function this:getExpUpParam()
  return self.expUpParam
end

function this:getCurrency(currencyID, isCreate)
  if currencyID == L_Const.currencyType.accountExp then
    return {
      attr_id = currencyID,
      attr_val = self.data.baseInfo.exp
    }
  end
  local res = self.data.attrInfo[currencyID]
  if res == nil and isCreate then
    res = require(L_R.store .. "player.data.playerAttr").new()
    res.attr_id = currencyID
    res.extraLimit = 0
    self.data.attrInfo[currencyID] = res
  elseif math.floor(currencyID / 100) == 2 then
    local techType = math.fmod(currencyID, 100)
    res = {
      attr_id = currencyID,
      attr_val = L_TechnologyStore:getTechTypeInfo(techType).point,
      extraLimit = 0
    }
  end
  return res
end

function this:getActCurrency(actId, currencyID, isCreate)
  local resDic = self.data.actAttrInfo[actId]
  if resDic == nil then
    if isCreate then
      resDic = {}
      self.data.actAttrInfo[actId] = resDic
    else
      return nil
    end
  end
  local res = resDic[currencyID]
  if res == nil and isCreate then
    res = require(L_R.store .. "player.data.playerAttr").new()
    res.attr_id = currencyID
    res.extraLimit = 0
    resDic[currencyID] = res
  end
  return res
end

function this:onEvent_refreshDayChange()
  local list = L_GameConstTpl:getCurrencyElementList()
  for key, value in pairs(list) do
    local player_attr = self:getCurrency(value)
    if player_attr then
      player_attr.hasShowLimit = false
    end
  end
end

function this:isElementCurrency(currencyID)
  local list = L_GameConstTpl:getCurrencyElementList()
  if table.containsValue(list, currencyID) then
    return true
  end
  return false
end

function this:getShowElementCurrencyLimitFlag(itemId)
  local player_attr = self:getCurrency(itemId)
  if player_attr and player_attr.hasShowLimit and player_attr.hasShowLimit == true then
    return true
  end
  return false
end

function this:getElementCurrencyMaxNum(currencyID)
  local currency = self:getCurrency(currencyID)
  local extraLimit = 0
  if currency then
    extraLimit = currency.extraLimit
  end
  local tpl = currencyTpl:getTplById(currencyID)
  local maxValue = currencyTpl:getMaxNum(tpl)
  return extraLimit + maxValue
end

function this:getCurrencyNum(currencyID)
  local debt = 0
  if C_BagMgr then
    debt = C_BagMgr:GetDebtNum(currencyID)
  end
  if currencyID == L_Const.currencyType.tiedDiamond or currencyID == L_Const.currencyType.tiedDiamondExtend then
    local currencyTied = self:getCurrency(L_Const.currencyType.tiedDiamond)
    local currencyTiedEx = self:getCurrency(L_Const.currencyType.tiedDiamondExtend)
    local tiedNum = currencyTied and currencyTied.attr_val or 0
    local tiedExNum = currencyTiedEx and currencyTiedEx.attr_val or 0
    debt = C_BagMgr:GetDebtNum(L_Const.currencyType.tiedDiamond) + C_BagMgr:GetDebtNum(L_Const.currencyType.tiedDiamondExtend)
    return tiedNum + tiedExNum - debt
  end
  local currency = self:getCurrency(currencyID)
  return currency and currency.attr_val - debt or 0 - debt
end

function this:getActCurrencyNum(actId, currencyID)
  local currency = self:getActCurrency(actId, currencyID)
  return currency and currency.attr_val or 0
end

function this:getAllCurrencies()
  return self.data.attrInfo
end

function this:getCurrencyElementTotalNum()
  local num = 0
  local list = L_GameConstTpl:getCurrencyElementList()
  if list then
    for key, value in ipairs(list) do
      num = num + self:getCurrencyNum(value)
    end
  end
  return num
end

return this
