local RelationListType = SocialDefine.RelationListType
local RelationSortType = SocialDefine.SocialRelationSortType

local function createSocialRelationFansModelState(relationListType)
  local state = {}
  state.relationListType = relationListType
  state.relationSortType = RelationSortType.Fans
  
  function state.showGroup()
    local relationSortTypeData = state.relationSortTypeList[state.relationSortType]
    return SocialDataUtils.GetRelationListByType(relationSortTypeData.relation) or {}
  end
  
  function state.followNum()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return myPlayerData and myPlayerData.followerNum or 0
  end
  
  state.scrollBarVal = nil
  state.perQueryNum = 20
  state.maxListNum = SocialDataUtils.GetRelationListLimitByType(relationListType)
  state.isShowRelationFilter = false
  
  function state.relationSortTypeList()
    local ret = {}
    local relationSortTypeList = RelationSortType
    for index, data in pairs(relationSortTypeList) do
      local name
      if data == RelationSortType.Fans then
        name = LT.Text("CommonTabAll")
      elseif data == RelationSortType.MutualFans then
        name = LT.Text("SocialSystemInterrelated")
      elseif data == RelationSortType.UnfollowedFans then
        name = LT.Text("SocialUnfollowedFans")
      end
      ret[data] = {
        type = data,
        name = name,
        relation = index
      }
    end
    return ret
  end
  
  return state
end

local function createSocialRelationFansModelViews(model)
  local views = {}
  return views
end

local function createSocialRelationFansModelActions(model)
  local actions = {}
  
  function actions:SetScrollBarVal(nVal)
    model.scrollBarVal = nVal
  end
  
  function actions:SetRelationSortType(relationSortType)
    model.relationSortType = relationSortType
  end
  
  function actions:SetRelationType(relationType)
    model.relationListType = relationType
  end
  
  function actions:SetShowRelationFilter(isShow)
    model.isShowRelationFilter = isShow
  end
  
  function actions:SetSortOrderType(sortType)
    SocialDataUtils.ResetRelationListByType(sortType)
    SocialDataUtils.ReqOnSocialQueryList(sortType, 1, model.perQueryNum, 1)
  end
  
  return actions
end

local function onSetup(_, model)
  SocialDataUtils.ResetRelationListByType(model.relationListType)
  SocialDataUtils.ReqOnSocialQueryList(model.relationListType, 1, model.perQueryNum, 1)
end

local SocialRelationFansModel = Vue.model("SocialRelationFansModel", createSocialRelationFansModelState):views(createSocialRelationFansModelViews):actions(createSocialRelationFansModelActions):setup(onSetup)
return SocialRelationFansModel
