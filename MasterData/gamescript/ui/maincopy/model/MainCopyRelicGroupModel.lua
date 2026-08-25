local RelicGroupTabType = CommonDefine.RelicGroupTabType

local function createMainCopyRelicGroupModelState(stageTid, relicGroupList)
  local state = {}
  state.stageTid = stageTid
  state.showTab = RelicGroupTabType.RELIC
  
  function state.relicVisible()
    return state.showTab == RelicGroupTabType.RELIC
  end
  
  function state.enchantVisible()
    return state.showTab == RelicGroupTabType.ENCHANT
  end
  
  state.currSelectRelicTid = 0
  state.currSelectEnchantTid = 0
  state.relicGroupList = relicGroupList or MainCopyDataUtils.GetRelicGroups(stageTid)
  state.enchantGroupList = MainCopyDataUtils.GetEnchantGroups(stageTid)
  return state
end

local function createMainCopyRelicGroupModelViews(_)
  local views = {}
  
  function views:GetRelicName(relicTid)
    do return RelicDataUtils.GetRelicName end
    return RelicDataUtils.GetRelicName, relicTid
  end
  
  function views:GetEnchantName(enchantTid)
    do return EnchantDataUtils.GetEnchantName end
    return EnchantDataUtils.GetEnchantName, enchantTid
  end
  
  function views:GetRelicDesc(relicTid)
    if not relicTid then
      return
    end
    local desc = RelicDataUtils.GetRelicDesc(relicTid, nil, self.stageTid)
    return desc and LT.Text(desc) or ""
  end
  
  function views:GetRelicStoryDesc(relicTid)
    do return RelicDataUtils.GetStoryDesc end
    return RelicDataUtils.GetStoryDesc, relicTid
  end
  
  function views:GetRelicTypeName(relicTid)
    do return RelicDataUtils.GetTypeName end
    return RelicDataUtils.GetTypeName, relicTid
  end
  
  function views:GetEnchantDesc(enchantTid)
    do return SkillUtils.GetEnchantDesc, enchantTid end
    return SkillUtils.GetEnchantDesc, enchantTid, self.stageTid
  end
  
  function views:GetEnchantTypeName(enchantTid)
    do return EnchantDataUtils.GetTypeName end
    return EnchantDataUtils.GetTypeName, enchantTid
  end
  
  function views:GetRelicIcon(relicTid)
    do return RelicDataUtils.GetRelicIcon end
    return RelicDataUtils.GetRelicIcon, relicTid
  end
  
  function views:GetEnchantIcon(enchantTid)
    do return EnchantDataUtils.GetEnchantIcon end
    return EnchantDataUtils.GetEnchantIcon, enchantTid
  end
  
  function views:GetRelicListByGroup(group)
    do return RelicDataUtils.GetRelicListByGroup end
    return RelicDataUtils.GetRelicListByGroup, group
  end
  
  function views:GetEnchantListByGroup(group)
    do return EnchantDataUtils.GetEnchantListByGroup end
    return EnchantDataUtils.GetEnchantListByGroup, group
  end
  
  function views:GetRelicGroupName(group)
    do return RelicDataUtils.GetRelicGroupName end
    return RelicDataUtils.GetRelicGroupName, group
  end
  
  function views:GetEnchantGroupName(group)
    do return EnchantDataUtils.GetEnchantGroupName end
    return EnchantDataUtils.GetEnchantGroupName, group
  end
  
  return views
end

local function createMainCopyRelicGroupModelActions(data)
  local actions = {}
  
  function actions:SetShowTab(tab)
    if not tab then
      return
    end
    data.showTab = tab
  end
  
  function actions:SetCurrSelectRelicTid(tid)
    tid = tid or 0
    data.currSelectRelicTid = tid
  end
  
  function actions:SetCurrSelectEnchantTid(tid)
    tid = tid or 0
    data.currSelectEnchantTid = tid
  end
  
  return actions
end

local function onSetup(_, _)
end

local MainCopyRelicGroupModel = Vue.model("MainCopyRelicGroupModel", createMainCopyRelicGroupModelState):views(createMainCopyRelicGroupModelViews):actions(createMainCopyRelicGroupModelActions):setup(onSetup)
return MainCopyRelicGroupModel
