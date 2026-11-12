local ConfigData = require("GameCore.Data.ConfigData")
local AttrConfig = require("GameCore.Common.AttrConfig")
local EquipmentData = class("EquipmentData")

function EquipmentData:ctor(mapEquipment, nCharId, nGemId)
  self:Clear()
  self:InitEquip(mapEquipment, nCharId, nGemId)
end

function EquipmentData:Clear()
  self.nCharId = nil
  self.nGemId = nil
  self.sName = nil
  self.sIcon = nil
  self.sDesc = nil
  self.nType = nil
  self.nGenerateId = nil
  self.nRefreshId = nil
  self.bLock = nil
  self.tbAffix = nil
  self.tbUpgradeCount = nil
  self.tbAlterAffix = nil
  self.tbAlterUpgradeCount = nil
  self.tbPotentialAffix = nil
  self.tbSkillAffix = nil
  self.tbRandomAttr = nil
  self.tbEffect = nil
end

function EquipmentData:InitEquip(mapEquipment, nCharId, nGemId)
  self.nCharId = nCharId
  self.nGemId = nGemId
  local equipmentCfg = ConfigTable.GetData("CharGem", nGemId)
  if nil == equipmentCfg then
    printError(string.format("获取装备表配置失败！！！id = [%s]", nGemId))
    return
  end
  self:ParseConfigData(equipmentCfg)
  self:ParseServerData(mapEquipment)
end

function EquipmentData:ParseConfigData(equipmentCfg)
  self.sName = equipmentCfg.Title
  self.sIcon = equipmentCfg.Icon
  self.sDesc = equipmentCfg.Desc
  self.nType = equipmentCfg.Type
  self.nGenerateId = equipmentCfg.GenerateCostTid
  self.nRefreshId = equipmentCfg.RefreshCostTid
  self.tbRandomAttr = {}
end

function EquipmentData:ParseServerData(mapEquipment)
  self.bLock = mapEquipment.Lock
  self:UpdateAffix(mapEquipment.Attributes, mapEquipment.OverlockCount)
  self:UpdateAlterAffix(mapEquipment.AlterAttributes, mapEquipment.AlterOverlockCount)
end

function EquipmentData:UpdateAffix(tbAttributes, tbCount)
  self.tbAffix = tbAttributes
  self.tbUpgradeCount = tbCount
  self:UpdateRandomAttr(self.tbAffix, self.tbUpgradeCount)
end

function EquipmentData:UpdateAlterAffix(tbAttributes, tbCount)
  self.tbAlterAffix = tbAttributes
  self.tbAlterUpgradeCount = tbCount
end

function EquipmentData:ReplaceRandomAttr()
  if not self.tbAlterAffix or next(self.tbAlterAffix) == nil then
    return
  end
  if not self.tbAlterUpgradeCount or next(self.tbAlterUpgradeCount) == nil then
    return
  end
  self.tbAffix = clone(self.tbAlterAffix)
  for k, _ in ipairs(self.tbAlterAffix) do
    self.tbAlterAffix[k] = 0
  end
  self.tbUpgradeCount = clone(self.tbAlterUpgradeCount)
  for k, _ in ipairs(self.tbAlterUpgradeCount) do
    self.tbAlterUpgradeCount[k] = 0
  end
  self:UpdateRandomAttr(self.tbAffix, self.tbUpgradeCount)
end

function EquipmentData:UpdateRandomAttr(mapAttrs, tbCount)
  self.tbPotentialAffix = {}
  self.tbSkillAffix = {}
  self.tbRandomAttr = {}
  self.tbEffect = {}
  
  local function add(mapCfg, nAttrId)
    if not mapCfg then
      return
    end
    if mapCfg.AttrType == GameEnum.CharGemEffectType.Potential then
      table.insert(self.tbPotentialAffix, mapCfg)
    elseif mapCfg.AttrType == GameEnum.CharGemEffectType.SkillLevel then
      table.insert(self.tbSkillAffix, mapCfg)
    elseif mapCfg.AttrType == GameEnum.effectType.ATTR_FIX or mapCfg.AttrType == GameEnum.effectType.PLAYER_ATTR_FIX then
      if mapCfg.AttrTypeSecondSubtype == GameEnum.parameterType.BASE_VALUE then
        local value = tonumber(mapCfg.Value) or 0
        local mapData = {
          AttrId = nAttrId,
          Value = value,
          CfgValue = value / ConfigData.IntFloatPrecision
        }
        table.insert(self.tbRandomAttr, mapData)
      else
        table.insert(self.tbEffect, mapCfg.EffectId)
      end
    end
  end
  
  for k, v in ipairs(mapAttrs) do
    if 0 < v then
      local mapCfg = ConfigTable.GetData("CharGemAttrValue", v)
      if mapCfg then
        if tbCount and tbCount[k] and 0 < tbCount[k] then
          local nId = mapCfg.TypeId * 100 + tbCount[k] + mapCfg.Level
          local mapAfterCfg = ConfigTable.GetData("CharGemAttrValue", nId)
          add(mapAfterCfg, nId)
        else
          add(mapCfg, v)
        end
      end
    end
  end
end

function EquipmentData:UpdateLockState(bLock)
  self.bLock = bLock
end

function EquipmentData:GetEnhancedPotential()
  local tbPotential = {}
  for _, v in ipairs(self.tbPotentialAffix) do
    local nPotentialId = UTILS.GetPotentialId(self.nCharId, v.AttrTypeFirstSubtype)
    if not tbPotential[nPotentialId] then
      tbPotential[nPotentialId] = 0
    end
    tbPotential[nPotentialId] = tbPotential[nPotentialId] + tonumber(v.Value)
  end
  return tbPotential
end

function EquipmentData:GetEnhancedSkill()
  local tbSkillId = PlayerData.Char:GetSkillIds(self.nCharId)
  local tbSkill = {}
  for _, v in ipairs(self.tbSkillAffix) do
    local nSkillId = tbSkillId[v.AttrTypeFirstSubtype]
    if not tbSkill[nSkillId] then
      tbSkill[nSkillId] = 0
    end
    tbSkill[nSkillId] = tbSkill[nSkillId] + tonumber(v.Value)
  end
  return tbSkill
end

function EquipmentData:GetRandomAttr()
  return self.tbRandomAttr
end

function EquipmentData:GetEffect()
  return self.tbEffect
end

function EquipmentData:CheckAlterEmpty()
  if not self.tbAlterAffix or next(self.tbAlterAffix) == nil then
    return true
  end
  for _, v in pairs(self.tbAlterAffix) do
    if v == 0 then
      return true
    end
  end
  return false
end

function EquipmentData:GetUpgradeCount()
  local nAll = 0
  if self.tbUpgradeCount then
    for _, v in ipairs(self.tbUpgradeCount) do
      nAll = nAll + v
    end
  end
  return nAll
end

function EquipmentData:ChangeUpgradeCount(nAttrIndex, nChange)
  if self.tbAlterUpgradeCount[nAttrIndex] == self.tbUpgradeCount[nAttrIndex] and self.tbAlterAffix[nAttrIndex] == self.tbAffix[nAttrIndex] then
    self.tbAlterUpgradeCount[nAttrIndex] = self.tbAlterUpgradeCount[nAttrIndex] + nChange
  end
  self.tbUpgradeCount[nAttrIndex] = self.tbUpgradeCount[nAttrIndex] + nChange
end

function EquipmentData:CheckUpgradeAble()
  local nAll = self:GetUpgradeCount()
  local nLimit = ConfigTable.GetConfigNumber("CharGemOverlockCount")
  return nAll < nLimit
end

function EquipmentData:CheckUpgradeAlterSame(nAttrIndex)
  if not self.tbAlterAffix or next(self.tbAlterAffix) == nil then
    return true
  end
  if not self.tbAlterUpgradeCount or next(self.tbAlterUpgradeCount) == nil then
    return true
  end
  if self.tbAlterAffix[nAttrIndex] == 0 then
    return true
  end
  if self.tbAlterUpgradeCount[nAttrIndex] == self.tbUpgradeCount[nAttrIndex] and self.tbAlterAffix[nAttrIndex] == self.tbAffix[nAttrIndex] then
    return true
  end
  return false
end

function EquipmentData:GetTypeDesc()
  local sLanguage = AllEnum.EquipmentType[self.nType].Language
  return ConfigTable.GetUIText(sLanguage)
end

function EquipmentData:GetTypeIcon()
  return AllEnum.EquipmentType[self.nType].Icon
end

function EquipmentData:GetEffectDescId(attrSybType1, attrSybType2)
  return GameEnum.effectType.ATTR_FIX * 10000 + attrSybType1 * 10 + attrSybType2
end

return EquipmentData
