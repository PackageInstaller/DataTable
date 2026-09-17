local this = class("moduleSituationEdit_env", require("ui.pages.situation.group.moduleSituationEditBase"))
local _situationSceneTpl = L_GameTpl:getSituationSceneTpl()

function this.bind()
  return {
    active_blur = true,
    activeEnvList = true,
    envList = {
      moduleName = "pages/situation/cell/cellSituationEnvItem"
    },
    curEnvID = nil,
    title = true,
    instruection = false
  }
end

function this.methods()
  return {
    onSelectEnv = function(self, id)
      if self.bind.curEnvID == id then
        return
      end
      self.bind.curEnvID = id
      self:onClickEnv(id)
    end,
    onClickCloseList = function(self)
      self.bind.activeEnvList = false
      self.bind.title = false
      self.bind.active_blur = false
      self.parent.bind.editTabId = -1
    end
  }
end

function this:open()
  self:initModule()
end

function this:initModule()
  self:initList()
  self.bind.active_blur = true
  self.bind.activeEnvList = true
  self.bind.title = true
end

function this:show()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
  self:onUndoChanged()
end

function this:hide()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
end

function this:refresh()
end

function this:close()
end

function this:initList()
  local list = {}
  for i, v in pairs(_situationSceneTpl.data) do
    local lock = _situationSceneTpl:getUnlock(v)
    if L_ConditionManager:singleIsComplete(lock) then
      local temp = {
        id = i,
        icon = _situationSceneTpl:getSceneIcon(v),
        name = _situationSceneTpl:getScenesName(v)
      }
      table.insert(list, temp)
    end
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  self.bind.envList:clear()
  self.bind.envList:insert_array(list)
end

function this:onClickEnv(id)
  local param = {
    preEnvId = L_SituationManager.curSolution.envContainer.data.configId,
    curEnvId = id
  }
  L_SituationManager:addChangeEnvCommand(param)
end

function this:onUndoChanged()
  local cur = L_SituationManager.curSolution.envContainer.data.configId
  self.bind.curEnvID = cur
end

return this
