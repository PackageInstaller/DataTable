local FriendshipData = class("FriendshipData")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local maxLevel = 0

function FriendshipData:ctor()
  self.isInitData = false
  self.FriendshipDataList = {}
  self.AddedTotalLevel = nil
  maxLevel = #ConfigData.friendship_level
end

function FriendshipData:InitFriendship()
  if self.isInitData then
    return
  end
  self.isInitData = true
  self:AddFriendshipgBonus()
  self:AddFosterBonus()
end

function FriendshipData:UpdateData(heroIntimacy)
  local levelChangeDic
  for heroId, data in pairs(heroIntimacy) do
    local oriData = self.FriendshipDataList[heroId]
    self.FriendshipDataList[heroId] = data
    if oriData ~= nil and oriData.lv < data.lv then
      if levelChangeDic == nil then
        levelChangeDic = {}
      end
      levelChangeDic[heroId] = data.lv
    end
  end
  if levelChangeDic == nil then
    return
  end
  MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    if window == nil then
      return
    end
    for heroId, intimacyLv in pairs(levelChangeDic) do
      local heroCfg = ConfigData.hero_data[heroId]
      if heroCfg ~= nil then
        local heroName = LanguageUtil.GetLocaleText(heroCfg.name)
        window:ShowTips(string.format(ConfigData:GetTipContent(552), heroName, tostring(intimacyLv)), nil, eMessageSideType.normal, true)
      end
    end
  end)
end

function FriendshipData:GetLevel(heroId)
  local data = self.FriendshipDataList[heroId]
  if data == nil then
    return 1
  end
  return data.lv
end

function FriendshipData:GetExp(heroId)
  local data = self.FriendshipDataList[heroId]
  if data == nil then
    return 0
  end
  return data.exp
end

function FriendshipData:IsFriendShipMaxLevel(heroId)
  local level = self:GetLevel(heroId)
  return level >= maxLevel
end

function FriendshipData:GetBattleTimes(heroId)
  local data = self.FriendshipDataList[heroId]
  if data == nil then
    return 0
  end
  return data.times
end

function FriendshipData:GetTotalLevel()
  local totalLevel = 0
  for id, value in pairs(PlayerDataCenter.heroDic) do
    totalLevel = totalLevel + self:GetLevel(id)
  end
  return totalLevel
end

function FriendshipData:IsForestLineUnlock(heroId, fosterId)
  local data = self.FriendshipDataList[heroId]
  if data == nil then
    return false
  end
  if data.lineData[fosterId] ~= nil then
    return true
  end
  return false
end

function FriendshipData:GetForestLineLevel(heroId, fosterId)
  if not self:IsForestLineUnlock(heroId, fosterId) then
    return 0
  end
  local data = self.FriendshipDataList[heroId]
  if data.lineData[fosterId] ~= nil then
    return data.lineData[fosterId]
  end
  return 0
end

function FriendshipData:GetCouldUnlockOrUpgrade(heroId, fosterId)
  local friendshipLevel = self:GetLevel(heroId)
  local heroLevel = PlayerDataCenter.heroDic[heroId].level
  local curLineLevel = self:GetForestLineLevel(heroId, fosterId)
  local cfg = ConfigData.friendship_foster[fosterId][curLineLevel + 1]
  if cfg == nil then
    return false
  end
  local requireFriendshipLevel = cfg.friendship_level
  local requireHeroLevel = cfg.hero_level
  local fitMaterialRequire = true
  local nextCfg = ConfigData.friendship_foster[fosterId][self:GetForestLineLevel(heroId, fosterId) + 1]
  if nextCfg == nil then
    return false
  end
  for index, itemId in ipairs(nextCfg.deduct_itemIds) do
    local num = nextCfg.deduct_itemNums[index] or 0
    local hasNum = PlayerDataCenter:GetItemCount(itemId)
    if num > hasNum then
      fitMaterialRequire = false
    end
  end
  return friendshipLevel >= requireFriendshipLevel and heroLevel >= requireHeroLevel and fitMaterialRequire, curLineLevel == 0, requireFriendshipLevel, requireHeroLevel, friendshipLevel >= requireFriendshipLevel, heroLevel >= requireHeroLevel, fitMaterialRequire
end

function FriendshipData:GetCouldUnlockForestLine(heroId)
  local friendshipHeroCfg = ConfigData.friendship_hero[heroId]
  if friendshipHeroCfg == nil or friendshipHeroCfg.foster_id == nil then
    error("can't read friendshipHeroCfg with heroId" .. tostring(heroId))
    return false
  end
  for _, fosterId in ipairs(friendshipHeroCfg.foster_id) do
    local could, isUnlock = self:GetCouldUnlockOrUpgrade(heroId, fosterId)
    if could and isUnlock then
      return true
    end
  end
  return false
end

function FriendshipData:GetCouldUpgradeForestLine(heroId)
  local friendshipHeroCfg = ConfigData.friendship_hero[heroId]
  if friendshipHeroCfg == nil or friendshipHeroCfg.foster_id == nil then
    error("can't read friendshipHeroCfg with heroId" .. tostring(heroId))
    return false
  end
  for _, fosterId in ipairs(friendshipHeroCfg.foster_id) do
    local could, isUnlock = self:GetCouldUnlockOrUpgrade(heroId, fosterId)
    if could and not isUnlock then
      return true
    end
  end
  return false
end

function FriendshipData:AddFriendshipgBonus(totalLevel)
  totalLevel = totalLevel or self:GetTotalLevel()
  self.AddedTotalLevel = totalLevel
end

function FriendshipData:AddFosterBonus()
  for heroID, cfg in pairs(self.FriendshipDataList) do
    for lineId, lineLevel in pairs(cfg.lineData) do
      local fosterLevelCfgs = ConfigData.friendship_foster[lineId]
      if fosterLevelCfgs == nil then
        error(string.format("can't read friendship_foster with heroID:%s lineId:%s", tostring(heroID), tostring(lineId)))
        return
      end
      local levelCfg = fosterLevelCfgs[lineLevel]
      if levelCfg == nil then
        error(string.format("can't read levelCfg with heroID:%s lineId:%s level:%s", tostring(heroID), tostring(lineId), tostring(lineLevel)))
        return
      end
      for index, attrId in ipairs(levelCfg.attributeIds) do
        PlayerDataCenter.attributeBonus:SetSingleHroeBonus(heroID, attrId, levelCfg.attributeNums[index])
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
end

function FriendshipData:RemoveFosterBonus()
  for heroID, cfg in pairs(self.FriendshipDataList) do
    for lineId, lineLevel in pairs(cfg.lineData) do
      local levelCfg = ConfigData.friendship_foster[lineId][lineLevel]
      for index, attrId in ipairs(levelCfg.attributeIds) do
        PlayerDataCenter.attributeBonus:SetSingleHroeBonus(heroID, attrId, -levelCfg.attributeNums[index])
      end
    end
  end
end

function FriendshipData:HeroAddFriendshipExp(heroIds, addExp, isbattle)
  local needUpdradeFrienshipLevel
  for _, heroId in ipairs(heroIds) do
    local data = self.FriendshipDataList[heroId]
    if data ~= nil then
      data.times = data.times + 1
      data.exp = data.exp + addExp or 0
      while data.exp >= ConfigData.friendship_level[data.lv].friendship and not (data.lv + 1 >= maxLevel) do
        data.lv = data.lv + 1
        needUpdradeFrienshipLevel = true
        data.exp = data.exp - ConfigData.friendship_level[data.lv].friendship
      end
    end
  end
  self:AddFriendshipgBonus()
  MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
  if needUpdradeFrienshipLevel then
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.FrienshipLevel)
  end
end

return FriendshipData
