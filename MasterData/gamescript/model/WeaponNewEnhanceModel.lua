local AwakerPage = CommonDefine.AwakerPage

local function createWeaponNewEnhanceState(weapon)
  local state = {}
  state.weapon = weapon
  
  function state.weaponConfig()
    if state.weapon == nil then
      return nil
    end
    if 0 == state.weapon.tid then
      return CommonDefine.DummyWeapon.Config
    end
    return DT.Item[state.weapon.tid]
  end
  
  return state
end

local function createWeaponNewEnhanceModelViews(data)
  local views = {}
  
  function views:GetWeaponName()
    if self.weaponConfig == nil then
      return ""
    end
    do return LT.Text end
    return LT.Text, self.weaponConfig.Name
  end
  
  return views
end

local function createAwakerModelActions(data)
  local actions = {}
end

local function onSetup(binder, model)
end

local WeaponNewEnhanceModel = Vue.model("WeaponNewEnhanceModel", createWeaponNewEnhanceState):views(createWeaponNewEnhanceModelViews):actions(createAwakerModelActions):setup(onSetup)
return WeaponNewEnhanceModel
