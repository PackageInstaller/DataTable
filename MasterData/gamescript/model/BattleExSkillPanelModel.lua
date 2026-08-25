local function createBattleExSkillPanelState(awakerId)
  local state = {}
  
  state.awakerId = awakerId
  state.curShowContent = ""
  return state
end

local function createBattleExSkillPanelViews(data)
  local views = {}
  return views
end

local function createBattleExSkillPanelActions(data)
  local actions = {}
  
  function actions:SetCurShowContent(val)
    if not val then
      Logger.Warn("Error! Set nil Val")
      return
    end
    data.curShowContent = val
  end
  
  return actions
end

local function onSetup(binder, model)
end

local BattleExSkillPanelModel = Vue.model("BattleExSkillPanelModel", createBattleExSkillPanelState):views(createBattleExSkillPanelViews):actions(createBattleExSkillPanelActions):setup(onSetup)
return BattleExSkillPanelModel
