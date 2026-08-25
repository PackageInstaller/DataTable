local function createState(weaponDetailModel)
  local state = {}
  
  state.weaponDetailModel = weaponDetailModel
  state.nextFreeSlotIdx = 1
  state.slots = {}
  for i = 1, CommonDefine.WeaponEnhance.MtrlSlotCount do
    state.slots[i] = {idx = i}
  end
  state.weaponDetailModel:UpdateEnhancePreview(0)
  state.autoSelectMtrlType = CommonDefine.WeaponEnhance.AutoMtrlType_1
  return state
end

local function createViews()
  local views = {}
  
  function views:GetAutoSelectMtrlType()
    return self.autoSelectMtrlType
  end
  
  function views:GetSlots()
    return self.slots
  end
  
  function views:GetNumSlots()
    return #self.slots
  end
  
  function views:GetNumMtrls()
    local numMtrls = 0
    for _, slot in ipairs(self.slots) do
      if slot.uid then
        numMtrls = numMtrls + 1
      end
    end
    return numMtrls
  end
  
  function views:HasFreeSlots()
    return self.nextFreeSlotIdx <= #self.slots
  end
  
  function views:GetTotalExp()
    local totalExp = 0
    for _, slot in ipairs(self.slots) do
      if slot.tid then
        totalExp = totalExp + slot.count * slot.exp
      end
    end
    return totalExp
  end
  
  function views:GetGoldCost()
    local totalCost = 0
    for _, slot in ipairs(self.slots) do
      if slot.tid then
        if slot.isWeapon then
          local baseExp = 0
          local cfg = ItemDataUtils.GetItemConfig(slot.tid)
          if cfg.Quality == "White" then
            baseExp = DT.GetConstant("WhiteWeaponMaterialExperience")
          elseif cfg.Quality == "Orange" then
            baseExp = DT.GetConstant("SSRWeaponMaterialExperience")
          elseif cfg.Quality == "Purple" then
            baseExp = DT.GetConstant("SRWeaponMaterialExperience")
          elseif cfg.Quality == "Blue" then
            baseExp = DT.GetConstant("RWeaponMaterialExperience")
          end
          totalCost = totalCost + baseExp * slot.refineLevel
        else
          totalCost = totalCost + slot.count * slot.exp
        end
      end
    end
    return totalCost * DT.GetConstant("RatioOfGoldToBasicExperienceWhenUpgradingWeapon")
  end
  
  return views
end

local function createActions(data)
  local actions = {}
  
  function actions:ClearSlots()
    for _, slot in ipairs(data.slots) do
      slot.tid = nil
      slot.uid = nil
      slot.isWeapon = nil
      slot.refineLevel = nil
      slot.enhanceLevel = nil
      slot.count = nil
      slot.exp = nil
    end
    data.nextFreeSlotIdx = 1
    data.weaponDetailModel:UpdateEnhancePreview(0)
  end
  
  function actions:PutMtrlIntoNextFreeSlot(tid, uid, isWeapon, refineLevel, enhanceLevel, count, exp)
    if data.nextFreeSlotIdx <= #data.slots then
      local freeSlot = data.slots[data.nextFreeSlotIdx]
      freeSlot.tid = tid
      freeSlot.uid = uid
      freeSlot.isWeapon = isWeapon
      freeSlot.refineLevel = refineLevel
      freeSlot.enhanceLevel = enhanceLevel
      freeSlot.count = count
      freeSlot.exp = exp
      data.nextFreeSlotIdx = data.nextFreeSlotIdx + 1
    end
    local totalExp = data:GetTotalExp()
    data.weaponDetailModel:UpdateEnhancePreview(totalExp)
  end
  
  function actions:UpdateMtrl(tid, uid, count, exp)
    for _, slot in ipairs(data.slots) do
      if slot.tid == tid and slot.uid == uid then
        slot.count = count
        slot.exp = exp
        break
      end
    end
    local totalExp = data:GetTotalExp()
    data.weaponDetailModel:UpdateEnhancePreview(totalExp)
  end
  
  function actions:RemoveMtrl(tid)
    local removeIdx
    for idx, slot in ipairs(data.slots) do
      if slot.tid == tid then
        removeIdx = idx
        break
      end
    end
    if removeIdx then
      table.remove(data.slots, removeIdx)
      table.insert(data.slots, {})
      data.nextFreeSlotIdx = data.nextFreeSlotIdx - 1
      local totalExp = data:GetTotalExp()
      data.weaponDetailModel:UpdateEnhancePreview(totalExp)
    end
  end
  
  function actions:SetAutoSelectMtrlType(mtrlType)
    data.autoSelectMtrlType = mtrlType
  end
  
  return actions
end

local function onSetup(_, _)
end

local WeaponEnhanceMaterialSlotsModel = Vue.model("WeaponEnhanceMaterialSlotsModel", createState):views(createViews):actions(createActions):setup(onSetup)
return WeaponEnhanceMaterialSlotsModel
