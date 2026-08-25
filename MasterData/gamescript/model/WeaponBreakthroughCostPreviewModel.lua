local function createState(weaponDetailModel)
  local state = {}
  
  state.weaponDetailModel = weaponDetailModel
  return state
end

local function createViews()
  local views = {}
  
  function views:GetPreview()
    local levelLimitList = DT.GetOriginalConstant("WeaponBreakthroughRequiredUpgradeLevel")
    local maxBreakthroughStar = #levelLimitList
    local currBreakthroughStar = self.weaponDetailModel:GetBreakthroughStar()
    local nextBreakthroughStar = math.min(currBreakthroughStar + 1, maxBreakthroughStar)
    local weaponQuality = self.weaponDetailModel:GetWeaponQuality()
    local mtrlTypes = self.weaponDetailModel:GetWeaponBreakthroughMtrlTypes()
    local mtrlIDLists = {}
    for _, mtrlType in ipairs(mtrlTypes) do
      table.insert(mtrlIDLists, DT.GetOriginalConstant(mtrlType))
    end
    local mtrlCostLists = {}
    local goldCostList = DT.GetOriginalConstant("WeaponBreakthroughGoldConsumption")
    if "Orange" == weaponQuality then
      goldCostList = DT.GetOriginalConstant("SSRWeaponBreakthroughGoldConsumption")
      table.insert(mtrlCostLists, DT.GetOriginalConstant("SSRWeaponBreakthroughMaterialConsumptionCurve"))
      table.insert(mtrlCostLists, DT.GetOriginalConstant("SSRWeaponBreakthroughFirstWorldMaterialConsumptionCurve"))
      table.insert(mtrlCostLists, DT.GetOriginalConstant("SSRWeaponBreakthroughSecondWorldMaterialConsumptionCurve"))
    elseif "Purple" == weaponQuality then
      goldCostList = DT.GetOriginalConstant("SRWeaponBreakthroughGoldConsumption")
      table.insert(mtrlCostLists, DT.GetOriginalConstant("SRWeaponBreakthroughMaterialConsumptionCurve"))
      table.insert(mtrlCostLists, DT.GetOriginalConstant("SRWeaponBreakthroughFirstWorldMaterialConsumptionCurve"))
      table.insert(mtrlCostLists, DT.GetOriginalConstant("SRWeaponBreakthroughSecondWorldMaterialConsumptionCurve"))
    elseif "Blue" == weaponQuality then
      goldCostList = DT.GetOriginalConstant("RWeaponBreakthroughGoldConsumption")
      table.insert(mtrlCostLists, DT.GetOriginalConstant("RWeaponBreakthroughMaterialConsumptionCurve"))
      table.insert(mtrlCostLists, DT.GetOriginalConstant("RWeaponBreakthroughFirstWorldMaterialConsumptionCurve"))
      table.insert(mtrlCostLists, DT.GetOriginalConstant("RWeaponBreakthroughSecondWorldMaterialConsumptionCurve"))
    end
    local playerLevelList = DT.GetOriginalConstant("PlayerLevelRequiredForWeaponBreakthrough")
    local mtrl = {}
    for idx, mtrlIDList in ipairs(mtrlIDLists) do
      local mtrlCostList = mtrlCostLists[idx]
      table.insert(mtrl, {
        id = mtrlIDList[nextBreakthroughStar],
        count = mtrlCostList[nextBreakthroughStar]
      })
    end
    return {
      mtrl = mtrl,
      gold = goldCostList[nextBreakthroughStar],
      weaponLevel = levelLimitList[nextBreakthroughStar],
      playerLevel = playerLevelList[nextBreakthroughStar]
    }
  end
  
  return views
end

local function createActions(_)
  local actions = {}
  return actions
end

local function onSetup(_, _)
end

local WeaponBreakthroughCostPreviewModel = Vue.model("WeaponBreakthroughCostPreviewModel", createState):views(createViews):actions(createActions):setup(onSetup)
return WeaponBreakthroughCostPreviewModel
