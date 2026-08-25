local function createSocialRelationBanModelState(relationListType)
  local state = {}
  
  state.relationListType = relationListType
  
  function state.showGroup()
    if state.sortOrderType == CommonDefine.SortOrder.Ascend then
      return SocialDataUtils.GetRelationListByType(relationListType) or {}
    else
      local rst = {}
      local tmpGroup = {}
      local relationList = table.clone(SocialDataUtils.GetRelationListByType(relationListType))
      for idx, facade in pairs(relationList) do
        table.insert(tmpGroup, {idx = idx, facade = facade})
      end
      table.sort(tmpGroup, function(a, b)
        return a.idx > b.idx
      end)
      for _, tbl in ipairs(tmpGroup) do
        table.insert(rst, tbl.facade)
      end
      return rst
    end
  end
  
  function state.banNum()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return myPlayerData and myPlayerData.banNum or 0
  end
  
  state.scrollBarVal = nil
  state.perQueryNum = 20
  state.maxListNum = SocialDataUtils.GetRelationListLimitByType(relationListType)
  state.sortOrderType = CommonDefine.SortOrder.Ascend
  return state
end

local function createSocialRelationBanModelViews(model)
  local views = {}
  return views
end

local function createSocialRelationBanModelActions(model)
  local actions = {}
  
  function actions:SetScrollBarVal(nVal)
    model.scrollBarVal = nVal
  end
  
  function actions:SetSortOrderType(sortType)
    if sortType == CommonDefine.SortOrder.Ascend then
      SocialDataUtils.ResetRelationListByType(model.relationListType)
      SocialDataUtils.ReqOnSocialQueryList(model.relationListType, 1, model.perQueryNum, 1)
    else
      SocialDataUtils.ResetRelationListByType(model.relationListType)
      SocialDataUtils.ReqOnSocialQueryList(model.relationListType, model.followNum - model.perQueryNum + 1, model.followNum, 1)
    end
    model.sortOrderType = sortType
  end
  
  return actions
end

local function onSetup(binder, model)
  SocialDataUtils.ResetRelationListByType(model.relationListType)
  SocialDataUtils.ReqOnSocialQueryList(model.relationListType, 1, model.perQueryNum, 1)
end

local SocialRelationBanModel = Vue.model("SocialRelationBanModel", createSocialRelationBanModelState):views(createSocialRelationBanModelViews):actions(createSocialRelationBanModelActions):setup(onSetup)
return SocialRelationBanModel
