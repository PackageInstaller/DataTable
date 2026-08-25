local function createAwakerSpecialSkillModelState(hasList)
  local state = {}
  
  state.filter = CommonDefine.AwakerSpecialSkillType.All
  state.filterSwitch = false
  
  function state.specialSkillList()
    if not hasList then
      return {}
    end
    if state.filter == CommonDefine.AwakerSpecialSkillType.All then
      do return end
      return AwakerDataUtils.GetAllSpecialSkillList, CommonDefine.AwakerSpecialSkillType.All
    end
    do return AwakerDataUtils.GetSpecialSkillListByType end
    return AwakerDataUtils.GetSpecialSkillListByType, state.filter
  end
  
  return state
end

local function createAwakerSpecialSkillModelViews(_)
  local views = {}
  
  function views:GetEffectListByType(effectType, module)
    if effectType then
      do return AwakerDataUtils.GetSpecialSkillListByType, effectType end
      return AwakerDataUtils.GetSpecialSkillListByType, effectType, module
    end
    return {}
  end
  
  function views:GetAllSpecialSkillList()
    do return end
    return AwakerDataUtils.GetAllSpecialSkillList
  end
  
  function views:IsSpecialSkill_HasOrCan_Active(effectType, module)
    do return TalentDataUtils.IsSpecialSkill_HasOrCan_Active, effectType end
    return TalentDataUtils.IsSpecialSkill_HasOrCan_Active, effectType, module
  end
  
  function views:IsSpecialSkill_Can_Active(effectType, module)
    do return TalentDataUtils.IsSpecialSkill_Can_Active, effectType end
    return TalentDataUtils.IsSpecialSkill_Can_Active, effectType, module
  end
  
  function views:IsEffectActive(tid, awakerTid)
    do return TalentDataUtils.IsTalentUnlocked, tid end
    return TalentDataUtils.IsTalentUnlocked, tid, awakerTid
  end
  
  function views:GetSpecialSkillTitle(tid)
    do return AwakerDataUtils.GetSpecialSkillTitle end
    return AwakerDataUtils.GetSpecialSkillTitle, tid
  end
  
  function views:GetSpecialSkillDesc(tid)
    do return AwakerDataUtils.GetSpecialSkillDesc end
    return AwakerDataUtils.GetSpecialSkillDesc, tid
  end
  
  function views:GetSpecialSkillAwakerIcon(tid)
    do return AwakerDataUtils.GetSpecialSkillAwakerIcon end
    return AwakerDataUtils.GetSpecialSkillAwakerIcon, tid
  end
  
  function views:GetOwnerName(tid)
    do return AwakerDataUtils.GetSpecialSkillOwnerName end
    return AwakerDataUtils.GetSpecialSkillOwnerName, tid
  end
  
  function views:GetSpecialSkillOwnerQualityFrame(tid)
    do return AwakerDataUtils.GetSpecialSkillOwnerQualityFrame end
    return AwakerDataUtils.GetSpecialSkillOwnerQualityFrame, tid
  end
  
  function views:GetSpecialSkillEffectTypeName(effectType)
    if not effectType then
      return
    end
    if "All" == effectType then
      do return LT.Text end
      return LT.Text, "总览", nil
    end
    local config = DT.CommonID[effectType]
    return config and LT.Text(config.Desc)
  end
  
  function views:GetSpecialSkillActiveNum(effectType)
    do return AwakerDataUtils.GetEffectActiveNum end
    return AwakerDataUtils.GetEffectActiveNum, effectType
  end
  
  function views:GetFilters()
    local enums = CommonDefine.AwakerSpecialSkillType
    local list = {}
    for k, v in pairs(enums) do
      if k and "__kind" ~= k then
        table.insert(list, v)
      end
    end
    table.sort(list)
    return list
  end
  
  return views
end

local function createAwakerSpecialSkillModelActions(data)
  local actions = {}
  
  function actions:SetFilter(filter)
    if not filter then
      return
    end
    data.filter = filter
  end
  
  function actions:SetFilterSwitch(state)
    data.filterSwitch = state
  end
  
  return actions
end

local function onSetup(_, _)
end

local AwakerSpecialSkillModel = Vue.model("AwakerSpecialSkillModel", createAwakerSpecialSkillModelState):views(createAwakerSpecialSkillModelViews):actions(createAwakerSpecialSkillModelActions):setup(onSetup)
return AwakerSpecialSkillModel
