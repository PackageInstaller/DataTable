local SocialFollowSortType = SocialDefine.SocialFollowSortType

local function createSocialRelationFollowModelState(relationListType)
  local state = {}
  state.relationListType = relationListType
  
  function state.relationSortTypeList()
    local ret = {}
    local relationSortTypeList = SocialFollowSortType
    for index, data in pairs(relationSortTypeList) do
      local name
      if data == SocialFollowSortType.LastOnlineTime then
        name = LT.Text("SocialOnlineTimeLabel")
      elseif data == SocialFollowSortType.ClientLevel then
        name = LT.Text("SocializeRoleLevel")
      elseif data == SocialFollowSortType.AwakerLevel then
        name = LT.Text("SocializeAwakerLevel")
      end
      ret[data] = {
        type = data,
        name = name,
        relation = index
      }
    end
    return ret
  end
  
  state.isShowRelationFilter = false
  state.sortOrderType = CommonDefine.FollowSortOrder.LastOnlineTimeAsc
  
  function state.showGroup()
    local relationList = table.clone(SocialDataUtils.GetRelationListByType(relationListType))
    local rst = {}
    if not state.sortOrderType then
      state.sortOrderType = CommonDefine.FollowSortOrder.LastOnlineTimeAsc
    end
    if state.sortOrderType.order == CommonDefine.SortOrder.Descend then
      rst = relationList
    else
      local tmpGroup = {}
      for idx, facade in pairs(relationList) do
        table.insert(tmpGroup, {idx = idx, facade = facade})
      end
      table.sort(tmpGroup, function(a, b)
        return a.idx > b.idx
      end)
      for _, tbl in ipairs(tmpGroup) do
        table.insert(rst, tbl.facade)
      end
    end
    return rst or {}
  end
  
  function state.followNum()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return myPlayerData and myPlayerData.attentionNum or 0
  end
  
  state.scrollBarVal = nil
  state.perQueryNum = 20
  state.maxListNum = SocialDataUtils.GetRelationListLimitByType(relationListType)
  return state
end

local function createSocialRelationFollowModelViews(model)
  local views = {}
  return views
end

local function createSocialRelationFollowModelActions(model)
  local actions = {}
  
  function actions:SetScrollBarVal(nVal)
    model.scrollBarVal = nVal
  end
  
  function actions:SetSortOrderType(sortType)
    if type(sortType) ~= "table" then
      sortType = SocialDefine.SocialFollowSortParam[sortType].sortType
    end
    local s, e
    if sortType.order == CommonDefine.SortOrder.Descend then
      s = 1
      e = math.min(model.perQueryNum, model.followNum)
    else
      s = math.max(model.followNum - model.perQueryNum + 1, 1)
      e = model.followNum
    end
    SocialDataUtils.ResetRelationListByType(model.relationListType)
    SocialDataUtils.ReqOnSocialQueryList(model.relationListType, s, e, 1, nil, SocialDefine.SocialFollowSortType[sortType.feq])
    model.sortOrderType = sortType
  end
  
  function actions:SetOppositeSortOrderType(isOn)
    model:SetSortOrderType(CommonDefine.FollowSortOrder[model.sortOrderType.ops])
    if model.sortOrderType.order == CommonDefine.SortOrder.Ascend and isOn or model.sortOrderType.order == CommonDefine.SortOrder.Descend and not isOn then
      model:SetSortOrderType(CommonDefine.FollowSortOrder[model.sortOrderType.ops])
    end
  end
  
  function actions:SetShowRelationFilter(isShow)
    model.isShowRelationFilter = isShow
  end
  
  return actions
end

local function onSetup(_, model)
  SocialDataUtils.ResetRelationListByType(model.relationListType)
  model:SetSortOrderType(SocialFollowSortType.LastOnlineTime)
  DataCenter.socialData.unfollowingList = {}
  DataCenter.socialData.isUnfollowing = false
end

local SocialRelationFollowModel = Vue.model("SocialRelationFollowModel", createSocialRelationFollowModelState):views(createSocialRelationFollowModelViews):actions(createSocialRelationFollowModelActions):setup(onSetup)
return SocialRelationFollowModel
