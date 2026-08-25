local function createState(weaponUid)
  local state = {}
  
  state.weaponUid = weaponUid
  return state
end

local function createViews()
  local views = {}
  
  function views:HasWeapon()
    return true
  end
  
  function views:GetWeaponIconLarge()
    local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
    if not weapon then
      return ""
    end
    local weaponCfg = DT.Item[weapon.tid]
    return weaponCfg.SpIcon
  end
  
  function views:GetWeaponQualityLarge()
    local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
    if not weapon then
      return ""
    end
    local weaponCfg = DT.Item[weapon.tid]
    local qualityCfg = DT.ItemQuality[weaponCfg.Quality]
    return qualityCfg.PaitingFrame
  end
  
  function views:GetWeaponName()
    local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
    if not weapon then
      return ""
    end
    local weaponCfg = DT.Item[weapon.tid]
    do return LT.Text end
    return LT.Text, weaponCfg.Name
  end
  
  function views:GetWeaponRefineLevel()
    local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
    if not weapon then
      return 0
    end
    return weapon.level or 0
  end
  
  function views:GetWeaponSecondaryAttr()
    local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
    if not weapon then
      return {}
    end
    do return ItemDataUtils.GetWeaponSecAttr end
    return ItemDataUtils.GetWeaponSecAttr, weapon
  end
  
  function views:GetStateDesc()
    local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
    if not weapon then
      return ""
    end
    do return SkillUtils.GetWeaponStateDesc, weapon.tid end
    return SkillUtils.GetWeaponStateDesc, weapon.tid, weapon.level
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
