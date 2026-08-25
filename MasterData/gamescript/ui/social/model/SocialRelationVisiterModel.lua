local function createSocialRelationVisiterModelState(relationListType)
  local state = {}
  
  state.relationListType = relationListType
  
  function state.showGroup()
    return SocialDataUtils.GetRelationListByType(relationListType) or {}
  end
  
  function state.followNum()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return myPlayerData and myPlayerData.visiterNum or 0
  end
  
  state.scrollBarVal = nil
  state.perQueryNum = 20
  state.maxListNum = SocialDataUtils.GetRelationListLimitByType(relationListType)
  return state
end

local function createSocialRelationVisiterModelViews(model)
  local views = {}
  return views
end

local function createSocialRelationVisiterModelActions(model)
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

local SocialRelationVisiterModel = Vue.model("SocialRelationVisiterModel", createSocialRelationVisiterModelState):views(createSocialRelationVisiterModelViews):actions(createSocialRelationVisiterModelActions):setup(onSetup)
return SocialRelationVisiterModel
