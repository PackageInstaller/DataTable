local RelationListType = SocialDefine.RelationListType

local function createSocialRelationSearchModelState()
  local state = {}
  state.showingGroup = {}
  state.changeBtnCD = 0
  state.inputStr = ""
  return state
end

local function createSocialRelationSearchModelViews(model)
  local views = {}
  
  function views:CheckHaveInputStr()
    return model.inputStr and model.inputStr ~= ""
  end
  
  function views:SortStrangerGroup(strangerMap)
    local rst = {}
    if not strangerMap then
      return rst
    end
    for _, facade in pairs(strangerMap) do
      table.insert(rst, facade)
    end
    return rst
  end
  
  return views
end

local function createSocialRelationSearchModelActions(model)
  local actions = {}
  
  function actions:SetShowingGroup(group)
    if not group then
      return
    end
    model.showingGroup = group
  end
  
  function actions:SetChangeBtnCD(num)
    if not num then
      return
    end
    model.changeBtnCD = num
  end
  
  function actions:SetInputStr(str)
    if not str then
      return
    end
    model.inputStr = str
  end
  
  function actions:UpdateFacadeRelation(index, newRelation)
    if not index or not newRelation then
      return
    end
    if model.showingGroup and model.showingGroup[index] then
      model.showingGroup[index].relation = newRelation
    end
  end
  
  return actions
end

local function onSetup(_, model)
  model:SetShowingGroup(model:SortStrangerGroup(SocialDataUtils.GetStrangerMap()))
end

local SocialRelationSearchModel = Vue.model("SocialRelationSearchModel", createSocialRelationSearchModelState):views(createSocialRelationSearchModelViews):actions(createSocialRelationSearchModelActions):setup(onSetup)
return SocialRelationSearchModel
