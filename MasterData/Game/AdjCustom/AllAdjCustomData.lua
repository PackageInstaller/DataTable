local AllAdjCustomData = class("AllAdjCustomData")
local AdjCustomPresetData = require("Game.AdjCustom.AdjCustomPresetData")

function AllAdjCustomData:ctor()
  self._dataDic = nil
  self._selectId = nil
end

function AllAdjCustomData:InitAdjCustonData(msg)
  self._dataDic = {}
  self._selectId = msg.curPresetId
  self.isRandomMainPresent = msg.isRandomMainPresent
  self.isHideText = msg.hideText
  for _, singleMsg in ipairs(msg.mainPresets) do
    self:SetAdjPresetData(singleMsg)
  end
  if self.needToChangeSkinIds ~= nil and table.count(self.needToChangeSkinIds) > 0 then
    for _, data in ipairs(self.needToChangeSkinIds) do
      self:TryAdjSkinLimitChange(data.heroId, data.skinId)
    end
    self.needToChangeSkinIds = nil
  end
end

function AllAdjCustomData:GetUsingAdjCustomPresetId()
  return self._selectId
end

function AllAdjCustomData:IsRandomMainPresent()
  if self.isRandomMainPresent == nil then
    return false
  end
  return self.isRandomMainPresent
end

function AllAdjCustomData:SetIsRandomMainPresent(bool)
  self.isRandomMainPresent = bool
end

function AllAdjCustomData:IsHideText()
  if self.isHideText == nil then
    return false
  end
  return self.isHideText
end

function AllAdjCustomData:SetIsHideText(bool)
  self.isHideText = bool
end

function AllAdjCustomData:GetUsingCustomPreset()
  return self._dataDic and self._dataDic[self._selectId]
end

function AllAdjCustomData:SetUsingAdjCustomPresetId(id)
  self._selectId = id
end

function AllAdjCustomData:GetAdjCustomPresetData(id)
  return self._dataDic[id]
end

function AllAdjCustomData:SetAdjPresetData(data)
  local id = data.id
  if id > ConfigData.game_config.adjCustomTeamMax then
    return
  end
  if self._dataDic[id] == nil then
    self._dataDic[id] = AdjCustomPresetData.New()
    self._dataDic[id]:InitPresetData(id)
  end
  self._dataDic[id]:UpdatePresetMsg(data)
end

function AllAdjCustomData:SetAdjPresetName(id, name)
  if self._dataDic[id] == nil then
    return
  end
  self._dataDic[id]:SetAdjPresetName(name)
end

function AllAdjCustomData:DelAdjPreset(id)
  self._dataDic[id] = nil
end

function AllAdjCustomData:IsAdjPresetUnlock(id)
  if id > ConfigData.game_config.adjCustomTeamMax then
    return false
  end
  local cfg = ConfigData.main_interface[id]
  if cfg == nil then
    return false
  end
  return CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
end

function AllAdjCustomData:HasAdjPresetCount()
  return table.count(self._dataDic)
end

function AllAdjCustomData:AdjUpdateSkinData(heroId, skinId)
  for k, presetData in pairs(self._dataDic) do
    if presetData:GetAdjPresetElemData(heroId) ~= nil and presetData:GetAdjPresetUseL2d() ~= true and presetData:GetAdjMainHeroSkinId() == skinId then
      local msg = presetData:TryGetAdjSkinUpgradeMsg()
      if msg then
        PlayerDataCenter.allAdjCustomData:SetAdjPresetData(msg)
        MsgCenter:Broadcast(eMsgEventId.AdjCustomModify, msg.id)
      end
    end
  end
end

function AllAdjCustomData:TryAdjSkinLimitEnd(heroId, skinId)
  for k, presetData in pairs(self._dataDic) do
    if presetData:GetAdjPresetElemData(heroId) ~= nil and presetData:GetAdjMainHeroSkinId() == skinId then
      local msg = presetData:GetAdjSkinMsgCheckL2d()
      if msg then
        do
          local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
          network:CS_MainInterface_PresetUpdate(msg, function()
            PlayerDataCenter.allAdjCustomData:SetAdjPresetData(msg)
          end)
        end
      end
    end
  end
end

function AllAdjCustomData:TryAdjSkinChange(heroId, skinId, teamId)
  local adjTeamId = teamId
  local adjData = self:GetAdjCustomPresetData(adjTeamId)
  local bgId = ConfigData.game_config.defaultBackgroundMain
  local adjTeamName = ""
  if adjData ~= nil then
    bgId = adjData:GetAdjPresetBgId()
    adjTeamName = adjData:GetAdjPresetName()
  end
  local skinCfg = ConfigData.skin[skinId]
  local isL2dOpen = false
  if skinCfg ~= nil and PlayerDataCenter.skinData:GetSkinLive2dLevel(skinCfg.id) > 0 then
    isL2dOpen = true
  end
  local elem = {}
  elem.heroId = heroId
  elem.skinId = skinCfg.id
  elem.posX = 0
  elem.posY = 0
  elem.heroSize = 0
  local data = {}
  data.id = adjTeamId
  data.name = adjTeamName
  data.useL2D = isL2dOpen
  data.bgId = bgId
  data.mainHero = elem
  local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
  network:CS_MainInterface_PresetUpdate(data, function()
    network:CS_MainInterface_PresetChange(1)
  end)
end

function AllAdjCustomData:TryAdjSkinLimitChange(heroId, skinId)
  if self._dataDic == nil then
    if self.needToChangeSkinIds == nil then
      self.needToChangeSkinIds = {}
    end
    local data = {}
    data.heroId = heroId
    data.skinId = skinId
    table.insert(self.needToChangeSkinIds, data)
    return
  end
  for k, presetData in pairs(self._dataDic) do
    if presetData:GetAdjPresetElemData(heroId) ~= nil and (presetData:GetAdjMainHeroSkinId() == skinId or presetData:GetAdjMinorHeroSkinId() == skinId) then
      local msg = presetData:GetAdjPresetMsg()
      if presetData:GetAdjMainHeroSkinId() == skinId then
        msg.mainHero.skinId = 0
      end
      if presetData:GetAdjMinorHeroSkinId() == skinId then
        msg.minorHero.skinId = 0
      end
      local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
      network:CS_MainInterface_PresetUpdate(msg, function()
        PlayerDataCenter.allAdjCustomData:SetAdjPresetData(msg)
      end)
    end
  end
end

return AllAdjCustomData
