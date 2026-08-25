local function createAwakerLevelUpItemUsePanelState(itemUid)
  local state = {}
  
  state.itemUid = itemUid
  state.awakerTid = nil
  
  local function GetFastPromotionSpParam()
    local rst = {}
    local item = ItemDataUtils.GetItemByUid(state.itemUid)
    if item then
      local cfg = DT.Item[item.tid]
      rst = cfg.SpParam
    end
    return rst
  end
  
  function state.toLevel()
    return tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.DirectPromotionLevel)) or 0
  end
  
  function state.toSkillLevel()
    return tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.DirectSkillPromotionLevel)) or 0
  end
  
  function state.toBreakLevel()
    return tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.DirectBreakthroughStage)) or 0
  end
  
  function state.toBreakSkillUnlock1()
    do return tonumber, ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.BreakthroughSkill1Unlocked) end
    return tonumber, ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.BreakthroughSkill1Unlocked)
  end
  
  function state.toBreakSkillUnlock2()
    do return tonumber, ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.BreakthroughSkill2Unlocked) end
    return tonumber, ItemDataUtils.GetFastPromotionSpParamValByKey(GetFastPromotionSpParam(), CommonDefine.FastPromotionSpParamKey.BreakthroughSkill2Unlocked)
  end
  
  function state.awakerList()
    local awakerList = ItemDataUtils.GetItemLevelUpAwakerList(state.itemUid, true)
    table.sort(awakerList, function(a, b)
      if a.isCanUse ~= b.isCanUse then
        return a.isCanUse
      end
      if a.qualitySort ~= b.qualitySort then
        return a.qualitySort > b.qualitySort
      end
      if a.awakerData.level ~= b.awakerData.level then
        return a.awakerData.level < b.awakerData.level
      end
      return a.awakerData.tid > b.awakerData.tid
    end)
    return awakerList
  end
  
  return state
end

local function createAwakerLevelUpItemUsePanelViews(_)
  local views = {}
  
  function views:GetAvailAwakerList(_)
  end
  
  return views
end

local function createAwakerLevelUpItemUsePanelActions(_)
  local actions = {}
  
  function actions:SetAwakerTid(tid)
    self.awakerTid = tid
  end
  
  return actions
end

local function onSetup(_, _)
end

local AwakerLevelUpItemUsePanelModel = Vue.model("AwakerLevelUpItemUsePanelModel", createAwakerLevelUpItemUsePanelState):views(createAwakerLevelUpItemUsePanelViews):actions(createAwakerLevelUpItemUsePanelActions):setup(onSetup)
return AwakerLevelUpItemUsePanelModel
