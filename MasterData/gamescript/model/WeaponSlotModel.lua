local function createState(awakerModel, slotType)
  local state = {}
  
  state.awakerModel = awakerModel
  state.slotType = slotType
  return state
end

local function createViews()
  local views = {}
  
  function views:GetType()
    return self.slotType
  end
  
  function views:GetUnlockBreakthroughLevel()
    if self.slotType == CommonDefine.WeaponSlotType.Primary then
      do return DT.GetConstant end
      return DT.GetConstant, "MainWeaponSlotUnlockBreakthroughLevel"
    elseif self.slotType == CommonDefine.WeaponSlotType.Secondary then
      do return DT.GetConstant end
      return DT.GetConstant, "SecondaryWeaponSlotUnlockBreakthroughLevel"
    end
    return 0
  end
  
  function views:IsLocked()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot then
      return not slot.unlocked
    else
      return true
    end
  end
  
  function views:GetLockTips()
    local tips = ""
    if self.slotType == CommonDefine.WeaponSlotType.Primary then
      tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.MainWeapon, 0)
    elseif self.slotType == CommonDefine.WeaponSlotType.Secondary then
      tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.SecondaryWeapon, 0)
    end
    do return LT.Text end
    return LT.Text, tips, 0
  end
  
  function views:HasWeapon()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot then
      return 0 ~= slot.weaponUid
    else
      return false
    end
  end
  
  function views:GetWeaponIconLarge()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot and 0 ~= slot.weaponUid then
      local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
      if weapon then
        local weaponCfg = DT.Item[weapon.tid]
        return weaponCfg.SpIcon
      else
        return ""
      end
    else
      return ""
    end
  end
  
  function views:GetWeaponQualityLarge()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot and 0 ~= slot.weaponUid then
      local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
      if weapon then
        local weaponCfg = DT.Item[weapon.tid]
        local qualityCfg = DT.ItemQuality[weaponCfg.Quality]
        return qualityCfg.PaitingFrame
      else
        return ""
      end
    else
      return ""
    end
  end
  
  function views:GetWeaponName()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot and 0 ~= slot.weaponUid then
      local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
      if weapon then
        local weaponCfg = DT.Item[weapon.tid]
        do return LT.Text end
        return LT.Text, weaponCfg.Name
      else
        return ""
      end
    else
      return ""
    end
  end
  
  function views:GetWeaponRefineLevel()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot and 0 ~= slot.weaponUid then
      local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
      if weapon then
        return weapon.level or 0
      else
        return 0
      end
    else
      return 0
    end
  end
  
  function views:GetWeaponSecondaryAttr()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot and 0 ~= slot.weaponUid then
      local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
      if weapon then
        do return ItemDataUtils.GetWeaponSecAttr end
        return ItemDataUtils.GetWeaponSecAttr, weapon
      else
        do return ItemDataUtils.GetWeaponSecAttr end
        return ItemDataUtils.GetWeaponSecAttr, {}
      end
    else
      do return ItemDataUtils.GetWeaponSecAttr end
      return ItemDataUtils.GetWeaponSecAttr, {}, {}
    end
  end
  
  function views:GetStateDesc()
    local slot = self:_GetSelectedAwakerWeaponSlot()
    if slot and 0 ~= slot.weaponUid then
      local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
      if weapon then
        do return SkillUtils.GetWeaponStateDesc, weapon.tid end
        return SkillUtils.GetWeaponStateDesc, weapon.tid, weapon.level
      else
        return ""
      end
    else
      return ""
    end
  end
  
  function views:_GetSelectedAwakerWeaponSlot()
    local awakerTid = self.awakerModel.selectAwakerId
    local awakerData = self.awakerModel:GetAwakerData(awakerTid)
    if awakerData then
      do return AwakerDataUtils.GetWeaponSlotDataWithType, awakerData end
      return AwakerDataUtils.GetWeaponSlotDataWithType, awakerData, self.slotType
    end
  end
  
  return views
end

local function createActions(_)
  local actions = {}
  return actions
end

local function onSetup(_, _)
end

local WeaponSlotModel = Vue.model("WeaponSlotModel", createState):views(createViews):actions(createActions):setup(onSetup)
return WeaponSlotModel
