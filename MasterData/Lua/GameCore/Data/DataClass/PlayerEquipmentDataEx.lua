local PlayerEquipmentData = class("PlayerEquipmentData")
local ConfigData = require("GameCore.Data.ConfigData")
local EquipmentData = require("GameCore.Data.DataClass.EquipmentDataEx")

function PlayerEquipmentData:Init()
  self.tbCharPreset = {}
  self.tbCharSelectPreset = {}
  self.tbCharEquipment = {}
  self.bRollWarning = true
  self.bRollUpgradeWarning = true
  self:ProcessTableData()
  self.isTestPresetTeam = false
end

function PlayerEquipmentData:ProcessTableData()
  self.nCharGemPresetNum = ConfigTable.GetConfigNumber("CharGemPresetNum")
  self.tbSlotControl = {}
  
  local function func_ForEach_Slot(mapData)
    table.insert(self.tbSlotControl, {
      Id = mapData.Id,
      UnlockLevel = mapData.UnlockLevel
    })
  end
  
  ForEachTableLine(DataTable.CharGemSlotControl, func_ForEach_Slot)
  table.sort(self.tbSlotControl, function(a, b)
    return a.UnlockLevel < b.UnlockLevel
  end)
end

function PlayerEquipmentData:CreateNewPresetData(tbPreset)
  local tbAllPreset = {}
  for i = 1, self.nCharGemPresetNum do
    tbAllPreset[i] = {
      sName = orderedFormat(ConfigTable.GetUIText("Equipment_PresetDefaultName"), i),
      tbSlot = {}
    }
  end
  for i, v in ipairs(tbPreset) do
    if v.Name ~= "" then
      tbAllPreset[i].sName = v.Name
    end
    for nSlotId, nGemIndex in pairs(v.SlotGem) do
      tbAllPreset[i].tbSlot[nSlotId] = nGemIndex + 1
    end
  end
  return tbAllPreset
end

function PlayerEquipmentData:CreateNewEquipmentData(tbSlotData, nCharId)
  local mapCharEquipment = {}
  for i, mapControl in ipairs(self.tbSlotControl) do
    mapCharEquipment[mapControl.Id] = {}
  end
  for _, mapSlot in ipairs(tbSlotData) do
    for i, mapInfo in ipairs(mapSlot.AlterGems) do
      local nGemId = self:GetGemIdBySlot(nCharId, mapSlot.Id)
      local equipmentData = EquipmentData.new(mapInfo, nCharId, nGemId)
      table.insert(mapCharEquipment[mapSlot.Id], equipmentData)
    end
  end
  return mapCharEquipment
end

function PlayerEquipmentData:CacheEquipmentData(mapMsgData)
  if self.tbCharPreset == nil then
    self.tbCharPreset = {}
  end
  if self.tbCharSelectPreset == nil then
    self.tbCharSelectPreset = {}
  end
  if self.tbCharEquipment == nil then
    self.tbCharEquipment = {}
  end
  for _, mapCharInfo in ipairs(mapMsgData) do
    local nCharId = mapCharInfo.Tid
    local mapPresetList = mapCharInfo.CharGemPresets
    self.tbCharSelectPreset[nCharId] = mapPresetList.InUsePresetIndex + 1
    self.tbCharPreset[nCharId] = self:CreateNewPresetData(mapPresetList.CharGemPresets)
    self.tbCharEquipment[nCharId] = self:CreateNewEquipmentData(mapCharInfo.CharGemSlots, nCharId)
  end
end

function PlayerEquipmentData:GetSelectPreset(nCharId)
  return self.tbCharSelectPreset[nCharId]
end

function PlayerEquipmentData:GetEquipmentByGemIndex(nCharId, nSlotId, nGemIndex)
  if nGemIndex == 0 then
    return
  end
  return self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
end

function PlayerEquipmentData:GetEquipmentBySlot(nCharId, nSlotId)
  return self.tbCharEquipment[nCharId][nSlotId]
end

function PlayerEquipmentData:GetSlotWithIndex(nCharId, nPresetIndex)
  local mapPreset = self.tbCharPreset[nCharId][nPresetIndex]
  local nCharLevel = PlayerData.Char:GetCharLv(nCharId)
  local tbSlot = {}
  for i, mapControl in ipairs(self.tbSlotControl) do
    tbSlot[i] = {
      nSlotId = mapControl.Id,
      nLevel = mapControl.UnlockLevel,
      bUnlock = nCharLevel >= mapControl.UnlockLevel,
      nGemIndex = mapPreset.tbSlot[mapControl.Id]
    }
  end
  return tbSlot
end

function PlayerEquipmentData:GetSlotCfgWithIndex()
  local tbSlot = {}
  for i, mapControl in ipairs(self.tbSlotControl) do
    tbSlot[i] = {
      nSlotId = mapControl.Id,
      nLevel = mapControl.UnlockLevel
    }
  end
  return tbSlot
end

function PlayerEquipmentData:GetAllPresetName(nCharId)
  local tbName = {}
  for _, v in ipairs(self.tbCharPreset[nCharId]) do
    table.insert(tbName, v.sName)
  end
  return tbName
end

function PlayerEquipmentData:GetGemIdBySlot(nCharId, nSlotId)
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  if not mapCharCfg then
    return 0
  end
  local nSlotIndex = 1
  for i, mapControl in ipairs(self.tbSlotControl) do
    if nSlotId == mapControl.Id then
      nSlotIndex = i
      break
    end
  end
  local nGemId = mapCharCfg.GemSlots[nSlotIndex]
  return nGemId
end

function PlayerEquipmentData:GetEquipedGem(nCharId)
  local nSelectPreset = self.tbCharSelectPreset[nCharId]
  if not nSelectPreset or not self.tbCharPreset[nCharId] then
    return {}
  end
  local mapPreset = self.tbCharPreset[nCharId][nSelectPreset]
  local tbEquipedGem, mapSlotData = {}, {}
  for _, mapControl in ipairs(self.tbSlotControl) do
    local nSlotId = mapControl.Id
    local nGemIndex = mapPreset.tbSlot[nSlotId]
    local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
    if mapEquipment then
      table.insert(tbEquipedGem, mapEquipment)
      table.insert(mapSlotData, {nSlotId = nSlotId, nGemIndex = nGemIndex})
    end
  end
  return tbEquipedGem, mapSlotData
end

function PlayerEquipmentData:GetEnhancedPotential(nCharId)
  local tbEnhancedPotential = {}
  local tbEquipedGem = self:GetEquipedGem(nCharId)
  for _, v in pairs(tbEquipedGem) do
    local tbPotential = v:GetEnhancedPotential()
    for nPotentialId, nAdd in pairs(tbPotential) do
      if not tbEnhancedPotential[nPotentialId] then
        tbEnhancedPotential[nPotentialId] = 0
      end
      tbEnhancedPotential[nPotentialId] = tbEnhancedPotential[nPotentialId] + nAdd
    end
  end
  return tbEnhancedPotential
end

function PlayerEquipmentData:GetEnhancedSkill(nCharId)
  local charCfgData = ConfigTable.GetData_Character(nCharId)
  if not charCfgData then
    printError("Character表找不到该角色" .. nCharId)
    return {}
  end
  local tbEnhancedSkill = {
    [charCfgData.NormalAtkId] = 0,
    [charCfgData.SkillId] = 0,
    [charCfgData.AssistSkillId] = 0,
    [charCfgData.UltimateId] = 0
  }
  local tbEquipedGem = self:GetEquipedGem(nCharId)
  for _, v in pairs(tbEquipedGem) do
    local tbSkill = v:GetEnhancedSkill()
    for nSkillId, nAdd in pairs(tbSkill) do
      if not tbEnhancedSkill[nSkillId] then
        tbEnhancedSkill[nSkillId] = 0
      end
      tbEnhancedSkill[nSkillId] = tbEnhancedSkill[nSkillId] + nAdd
    end
  end
  return tbEnhancedSkill
end

function PlayerEquipmentData:GetCharEquipmentRandomAttr(nCharId)
  local tbEquipedGem = self:GetEquipedGem(nCharId)
  if not tbEquipedGem or #tbEquipedGem == 0 then
    return {}
  end
  local tbRandomAttrList = {}
  for _, mapEquipment in pairs(tbEquipedGem) do
    local mapRandomAttr = mapEquipment:GetRandomAttr()
    for k, v in ipairs(mapRandomAttr) do
      local nAttrId = v.AttrId
      if nAttrId ~= nil then
        local nCfgValue = v.CfgValue
        local nValue = v.Value
        if nil == tbRandomAttrList[nAttrId] then
          tbRandomAttrList[nAttrId] = {CfgValue = nCfgValue, Value = nValue}
        else
          tbRandomAttrList[nAttrId].CfgValue = tbRandomAttrList[nAttrId].CfgValue + nCfgValue
          tbRandomAttrList[nAttrId].Value = tbRandomAttrList[nAttrId].Value + nValue
        end
      end
    end
  end
  for _, v in pairs(tbRandomAttrList) do
    v.CfgValue = clearFloat(v.CfgValue)
  end
  return tbRandomAttrList
end

function PlayerEquipmentData:GetCharEquipmentEffect(nCharId)
  local tbEquipedGem = self:GetEquipedGem(nCharId)
  if not tbEquipedGem or #tbEquipedGem == 0 then
    return {}
  end
  local tbAllEffect = {}
  for _, mapEquipment in pairs(tbEquipedGem) do
    local tbEffect = mapEquipment:GetEffect()
    for _, v in pairs(tbEffect) do
      table.insert(tbAllEffect, v)
    end
  end
  return tbAllEffect
end

function PlayerEquipmentData:GetRollWarning()
  return self.bRollWarning
end

function PlayerEquipmentData:SetRollWarning(bAble)
  self.bRollWarning = bAble
end

function PlayerEquipmentData:GetRollUpgradeWarning()
  return self.bRollUpgradeWarning
end

function PlayerEquipmentData:SetRollUpgradeWarning(bAble)
  self.bRollUpgradeWarning = bAble
end

function PlayerEquipmentData:CacheEquipmentSelect(nSlotId, nGemIndex, nCharId)
  self.mapSelect = {
    nSlotId = nSlotId,
    nGemIndex = nGemIndex,
    nCharId = nCharId
  }
end

function PlayerEquipmentData:GetEquipmentSelect()
  if self.mapSelect == nil then
    return false
  end
  local mapSelect = clone(self.mapSelect)
  self.mapSelect = nil
  return mapSelect
end

function PlayerEquipmentData:ClearEquipmentSelect()
  self.mapSelect = nil
end

function PlayerEquipmentData:CacheEquipmentUpgrade(nSlotId, nGemIndex, nCharId, nSelectUpgradeIndex)
  self.mapUpgrade = {
    nSlotId = nSlotId,
    nGemIndex = nGemIndex,
    nCharId = nCharId,
    nSelectUpgradeIndex = nSelectUpgradeIndex
  }
end

function PlayerEquipmentData:GetEquipmentUpgrade()
  if self.mapUpgrade == nil then
    return false
  end
  local mapUpgrade = clone(self.mapUpgrade)
  self.mapUpgrade = nil
  return mapUpgrade
end

function PlayerEquipmentData:ClearEquipmentUpgrade()
  self.mapUpgrade = nil
end

function PlayerEquipmentData:CheckAlterHighQualityAffix(tbAlterAffix, tbLockId)
  for _, v in ipairs(tbAlterAffix) do
    if v ~= 0 and table.indexof(tbLockId, v) == 0 then
      local mapCfg = ConfigTable.GetData("CharGemAttrValue", v)
      if mapCfg and mapCfg.Rare then
        return true
      end
    end
  end
  return false
end

function PlayerEquipmentData:UpdateRedDot()
end

function PlayerEquipmentData:SendCharGemEquipGemReq(nCharId, nSlotId, nGemIndex, nPresetId, callback)
  if 0 < nGemIndex then
    local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
    if mapEquipment == nil then
      printError("纹章不存在")
      return
    end
  end
  local msgData = {
    CharId = nCharId,
    SlotId = nSlotId,
    GemIndex = nGemIndex - 1,
    PresetId = nPresetId - 1
  }
  
  local function successCallback(_, mapMainData)
    self.tbCharPreset[nCharId][nPresetId].tbSlot[nSlotId] = nGemIndex
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_equip_gem_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemRenamePresetReq(nCharId, nPresetId, sNewName, callback)
  local msgData = {
    CharId = nCharId,
    PresetId = nPresetId - 1,
    NewName = sNewName
  }
  
  local function successCallback(_, mapMainData)
    self.tbCharPreset[nCharId][nPresetId].sName = sNewName
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_rename_preset_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemReplaceAttributeReq(nCharId, nSlotId, nGemIndex, callback)
  local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
  if mapEquipment == nil then
    printError("纹章不存在")
    return
  end
  local msgData = {
    CharId = nCharId,
    SlotId = nSlotId,
    GemIndex = nGemIndex - 1
  }
  
  local function successCallback(_, mapMainData)
    self.tbCharEquipment[nCharId][nSlotId][nGemIndex]:ReplaceRandomAttr()
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_replace_attribute_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemUpdateGemLockStatusReq(nCharId, nSlotId, nGemIndex, bLock, callback)
  local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
  if mapEquipment == nil then
    printError("纹章不存在")
    return
  end
  local msgData = {
    CharId = nCharId,
    SlotId = nSlotId,
    GemIndex = nGemIndex - 1,
    Lock = bLock
  }
  
  local function successCallback(_, mapMainData)
    self.tbCharEquipment[nCharId][nSlotId][nGemIndex]:UpdateLockState(bLock)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_update_gem_lock_status_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemUsePresetReq(nCharId, nPresetId, callback)
  local msgData = {
    CharId = nCharId,
    PresetId = nPresetId - 1
  }
  
  local function successCallback(_, mapMainData)
    self.tbCharSelectPreset[nCharId] = nPresetId
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_use_preset_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemRefreshReq(nCharId, nSlotId, nGemIndex, tbLockAttrs, callback)
  local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
  if mapEquipment == nil then
    printError("纹章不存在")
    return
  end
  local msgData = {
    CharId = nCharId,
    SlotId = nSlotId,
    GemIndex = nGemIndex - 1,
    LockAttrs = tbLockAttrs
  }
  
  local function successCallback(_, mapMainData)
    self.tbCharEquipment[nCharId][nSlotId][nGemIndex]:UpdateAlterAffix(mapMainData.Attributes, mapMainData.OverlockCount)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_refresh_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemGenerateReq(nCharId, nSlotId, nGemIndex, callback)
  if self.tbCharEquipment[nCharId][nSlotId][nGemIndex] ~= nil then
    printError("当前纹章已存在")
  end
  local msgData = {CharId = nCharId, SlotId = nSlotId}
  
  local function successCallback(_, mapMainData)
    local nGemId = self:GetGemIdBySlot(nCharId, nSlotId)
    local equipmentData = EquipmentData.new(mapMainData.CharGem, nCharId, nGemId)
    table.insert(self.tbCharEquipment[nCharId][nSlotId], equipmentData)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_generate_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemOverlockReq(nCharId, nSlotId, nGemIndex, nAttrIndex, callback)
  local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
  if mapEquipment == nil then
    printError("纹章不存在")
    return
  end
  local msgData = {
    CharId = nCharId,
    SlotId = nSlotId,
    GemIndex = nGemIndex - 1,
    AttrIndex = nAttrIndex - 1
  }
  
  local function successCallback(_, mapMainData)
    local mapEquip = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
    mapEquip:ChangeUpgradeCount(nAttrIndex, 1)
    mapEquip:UpdateRandomAttr(mapEquip.tbAffix, mapEquip.tbUpgradeCount)
    EventManager.Hit("EquipmentSlotChanged")
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_overlock_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:SendCharGemOverlockRevertReq(nCharId, nSlotId, nGemIndex, nAttrIndex, callback)
  local mapEquipment = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
  if mapEquipment == nil then
    printError("纹章不存在")
    return
  end
  local msgData = {
    CharId = nCharId,
    SlotId = nSlotId,
    GemIndex = nGemIndex - 1,
    AttrIndex = nAttrIndex - 1
  }
  
  local function successCallback(_, mapMainData)
    local mapEquip = self.tbCharEquipment[nCharId][nSlotId][nGemIndex]
    mapEquip:ChangeUpgradeCount(nAttrIndex, -1)
    mapEquip:UpdateRandomAttr(mapEquip.tbAffix, mapEquip.tbUpgradeCount)
    EventManager.Hit("EquipmentSlotChanged")
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_gem_overlock_revert_req, msgData, nil, successCallback)
end

function PlayerEquipmentData:CacheEquipmentDataForChar(mapMsgData)
  if self.tbCharPreset == nil then
    self.tbCharPreset = {}
  end
  if self.tbCharSelectPreset == nil then
    self.tbCharSelectPreset = {}
  end
  if self.tbCharEquipment == nil then
    self.tbCharEquipment = {}
  end
  local nCharId = mapMsgData.CharId
  local mapPresetList = mapMsgData.CharGemPresets
  self.tbCharSelectPreset[nCharId] = mapPresetList.InUsePresetIndex + 1
  self.tbCharPreset[nCharId] = self:CreateNewPresetData(mapPresetList.CharGemPresets)
  self.tbCharEquipment[nCharId] = self:CreateNewEquipmentData(mapMsgData.CharGemSlots, nCharId)
end

return PlayerEquipmentData
