local RelationListType = SocialDefine.RelationListType

local function createSocialRelationPanelModelState()
  local state = {}
  state.followModel = nil
  state.fansModel = nil
  state.visiterModel = nil
  state.searchModel = nil
  state.page = nil
  return state
end

local function createSocialRelationPanelModelViews(model)
  local views = {}
  return views
end

local function createSocialRelationPanelModelActions(model)
  local actions = {}
  
  function actions:SetFollowModel(val)
    if not val then
      return
    end
    model.followModel = val
  end
  
  function actions:SetFansModel(val)
    if not val then
      return
    end
    model.fansModel = val
  end
  
  function actions:SetVisiterModel(val)
    if not val then
      return
    end
    model.visiterModel = val
  end
  
  function actions:SetSearchModel(val)
    if not val then
      return
    end
    model.searchModel = val
  end
  
  function actions:SetPage(val)
    if not val then
      return
    end
    model.page = val
  end
  
  return actions
end

local function onSetup(_, _)
end

local SocialRelationMainModel = Vue.model("SocialRelationMainModel", createSocialRelationPanelModelState):views(createSocialRelationPanelModelViews):actions(createSocialRelationPanelModelActions):setup(onSetup)
return SocialRelationMainModel
