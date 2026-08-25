local RelationListType = SocialDefine.RelationListType

local function createSocialRelationNewFansModelState(relationListType, maxNum)
  local state = {}
  state.relationListType = relationListType
  
  function state.showGroup()
    return SocialDataUtils.GetRelationListByType(relationListType) or {}
  end
  
  function state.followNum()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return myPlayerData and math.min(myPlayerData.followerNum or 0, maxNum)
  end
  
  state.scrollBarVal = nil
  state.perQueryNum = math.min(20, maxNum)
  state.maxListNum = SocialDataUtils.GetRelationListLimitByType(relationListType)
  return state
end

local function createSocialRelationNewFansModelViews(model)
  local views = {}
  return views
end

local function createSocialRelationNewFansModelActions(model)
  local actions = {}
  
  function actions:SetScrollBarVal(nVal)
    model.scrollBarVal = nVal
  end
  
  return actions
end

local function onSetup(_, model)
  SocialDataUtils.ResetRelationListByType(model.relationListType)
  SocialDataUtils.ReqOnSocialQueryList(model.relationListType, 1, model.perQueryNum, 1)
end

local SocialRelationNewFansModel = Vue.model("SocialRelationNewFansModel", createSocialRelationNewFansModelState):views(createSocialRelationNewFansModelViews):actions(createSocialRelationNewFansModelActions):setup(onSetup)
return SocialRelationNewFansModel
