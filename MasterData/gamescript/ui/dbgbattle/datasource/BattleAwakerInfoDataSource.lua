local BattleAwakerInfoDataSource = System.NewClass("BattleAwakerDataSource")

function BattleAwakerInfoDataSource:ctor(awakerDataModel)
  self.awakerDataModel = awakerDataModel
end

function BattleAwakerInfoDataSource:GetAwakerConfig()
  return self.awakerDataModel.configData
end

function BattleAwakerInfoDataSource:GetCurSkin()
  return self.awakerDataModel.curSkin
end

function BattleAwakerInfoDataSource:GetAwakerLevel()
  if bg.battleDataCenter then
    return self.awakerDataModel.level
  end
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerDataModel.tid)
  if nil == awakerData then
    return 0
  end
  return awakerData.level
end

function BattleAwakerInfoDataSource:GetAwakerDataModel()
  return self.awakerDataModel
end

function BattleAwakerInfoDataSource:GetShowAttrIds()
  local attrNames = {}
  for id, cfg in pairs(DT.ActorAttrType) do
    if cfg.BattleShow then
      table.insert(attrNames, id)
    end
  end
  table.sort(attrNames, function(a, b)
    local cfgA = DT.ActorAttrType[a]
    local cfgB = DT.ActorAttrType[b]
    if cfgA.AttributeSort and cfgB.AttributeSort then
      return cfgA.AttributeSort < cfgB.AttributeSort
    end
    return a < b
  end)
  return attrNames
end

function BattleAwakerInfoDataSource:IsAwakeSkillVisible()
  do return self.HasAwaked end
  return self.HasAwaked, self
end

function BattleAwakerInfoDataSource:HasAwaked()
  return self.awakerDataModel.awaked
end

function BattleAwakerInfoDataSource:GetProperty(propertyName)
  do return self.awakerDataModel.GetProperty, self.awakerDataModel end
  return self.awakerDataModel.GetProperty, self.awakerDataModel, propertyName
end

function BattleAwakerInfoDataSource:GetUltiSkillId()
  return self.awakerDataModel.skillId
end

function BattleAwakerInfoDataSource:GetUltiSkillLevel()
  return self.awakerDataModel.skillLevel
end

function BattleAwakerInfoDataSource:GetUltiSkillDesc()
  local skillId = self.awakerDataModel.skillId
  local skillLevel = self.awakerDataModel.skillLevel
  local skillArgs = self.awakerDataModel.descArgs
  do return SkillUtils.GetAwakerSkillDesc, self.awakerDataModel, skillId, skillLevel end
  return SkillUtils.GetAwakerSkillDesc, self.awakerDataModel, skillId, skillLevel, skillArgs
end

function BattleAwakerInfoDataSource:GetSuperUltlSkillDesc()
  local skillId = self.awakerDataModel.skillId
  local skillLevel = self.awakerDataModel.skillLevel
  local skillArgs = self.awakerDataModel.descArgs
  do return SkillUtils.GetAwakerSkillDesc, self.awakerDataModel, skillId, skillLevel, skillArgs, nil, nil end
  return SkillUtils.GetAwakerSkillDesc, self.awakerDataModel, skillId, skillLevel, skillArgs, nil, nil, true
end

function BattleAwakerInfoDataSource:GetUltiSkillName()
  local skillId = self.awakerDataModel.skillId
  local skillConfig = DT.Skill[skillId]
  local params = {
    awaker = self.awakerDataModel
  }
  do return BattleSkillUtils.GetSkillName, skillConfig, 0, 0 end
  return BattleSkillUtils.GetSkillName, skillConfig, 0, 0, params
end

function BattleAwakerInfoDataSource:GetAwakeCardDesc()
  local awakerConfig = self:GetAwakerConfig()
  local awakerSkillId = awakerConfig.SkillList[bc.SlotOrder.Slot_Awake]
  local card = bg.battleRender.cardMgr:GetCardByConfigId(awakerSkillId)
  if nil == card then
    return ""
  end
  do return card.GetCardDescription end
  return card.GetCardDescription, card
end

function BattleAwakerInfoDataSource:GetAwakerCardName()
  local awakerConfig = self:GetAwakerConfig()
  local awakerSkillId = awakerConfig.SkillList[bc.SlotOrder.Slot_Awake]
  local skillConfig = DT.Skill[awakerSkillId]
  do return BattleSkillUtils.GetSkillName, skillConfig, 0 end
  return BattleSkillUtils.GetSkillName, skillConfig, 0, 0
end

function BattleAwakerInfoDataSource:GetWeapon(slotType)
  if bg.battleData and bg.battleData.isMock and slotType == cd.WeaponSlotType.Primary then
    for _, weapon in ipairs(bg.battleData.mockWeaponList) do
      if weapon.awakerTid == self.awakerDataModel.tid then
        return ItemDataUtils.ConstructWeaponItem(weapon.tid, {potencyLv = 1})
      end
    end
  end
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerDataModel.tid)
  do return CopyAwakerDataUtils.GetWeapon, awakerData end
  return CopyAwakerDataUtils.GetWeapon, awakerData, slotType, nil, nil, ItemDataUtils.ConstructWeaponItem(weapon.tid, {potencyLv = 1})
end

function BattleAwakerInfoDataSource:GetWeaponConfig(slotType)
  if bg.battleData and bg.battleData.isMock and slotType == cd.WeaponSlotType.Primary then
    for _, weapon in ipairs(bg.battleData.mockWeaponList) do
      if weapon.awakerTid == self.awakerDataModel.tid then
        return bg.DT.Item[weapon.tid]
      end
    end
  end
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerDataModel.tid)
  if awakerData then
    do return CopyAwakerDataUtils.GetWeaponConfig, awakerData end
    return CopyAwakerDataUtils.GetWeaponConfig, awakerData, slotType, nil, nil, bg.DT.Item[weapon.tid], weapon.tid
  else
    return nil
  end
end

function BattleAwakerInfoDataSource:GetAwakerUid()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerDataModel.tid)
  if nil == awakerData then
    return 0
  end
  return awakerData.uid
end

function BattleAwakerInfoDataSource:GetPvPAwakerUid()
  return self.awakerDataModel.uid
end

function BattleAwakerInfoDataSource:IsUltiSkillConfuse()
  if not bg.isPVP then
    return false
  end
  local ErosionColorInk = self:GetProperty(bc.BattleProperty.ErosionColorInk)
  if not ErosionColorInk or ErosionColorInk <= 0 then
    return false
  end
  local myCamp = bg.battleDataCenter:GetMyCamp()
  return self.awakerDataModel.camp == myCamp
end

function BattleAwakerInfoDataSource:GetPVPKeyWordTips()
  if not bg.isPVP then
    return
  end
  local keyWordTips = {}
  local uid = self.awakerDataModel.uid
  local states = bg.battleDataCenter.stateData:GetShowStateList(uid)
  local showType
  for _, state in ipairs(states or {}) do
    local stateCfg = state.configData
    showType = stateCfg.ShowType
    if showType and bc.StateHideMap[showType] then
    else
      local stateDataClient = BattleStateDataClient(state, true)
      if not stateDataClient:ShowJudgement() then
      else
        local icon
        if stateCfg.Icon ~= nil then
          icon = bc.ICON_PATH_PERFIX .. stateCfg.Icon
        end
        table.insert(keyWordTips, {
          icon = icon,
          name = stateDataClient:GetBuffName(),
          desc = stateDataClient:GetDesc(),
          isYellow = false,
          subDesc = state.layer > 0 and LT.Textf("Battle_State_Layer", state.layer),
          subDescColor = state.layer > 0 and StateDataUtils.GetPvpStatusLayerColor(stateCfg)
        })
      end
    end
  end
  return keyWordTips
end

return BattleAwakerInfoDataSource
