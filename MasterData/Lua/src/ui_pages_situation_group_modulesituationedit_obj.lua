local this = class("moduleSituationEdit_obj", require("ui.pages.situation.group.moduleSituationEditBase"))
local _objTpl = L_GameTpl:getSituationObjectsTpl()
local _situationTabTpl = L_GameTpl:getSituationTabTpl()

function this.bind()
  return {
    txt_curNum = "",
    txt_maxNum = "",
    active_blur = true,
    activeObjList = nil,
    objList = {
      moduleName = "pages/situation/cell/cellSituationObjItem"
    },
    dragHandler = {
      moduleName = "pages/situation/module/moduleSituationDragHandler"
    },
    activeDragHandler = nil,
    title = true
  }
end

function this.methods()
  return {
    objList = {
      onClickAdd = function(self, id)
        self:addObj(id)
        self:refreshShowInfo()
      end,
      onClickDel = function(self, id)
        self:refreshShowInfo()
      end
    },
    onClickCloseList = function(self)
      self.bind.active_blur = false
      self.bind.activeObjList = false
      self.bind.title = false
      self.parent.bind.editTabId = -1
    end,
    dragHandler = {
      onClickCancel = function(self)
        self:deleteObj()
      end,
      onClickConfirm = function(self)
        self:deSelectObj()
      end,
      onRotChanged = function(self, startY, endY)
        self:onRotChanged(startY, endY)
      end,
      onPosChanged = function(self, startPos, endPos)
        self:onPosChanged(startPos, endPos)
      end
    }
  }
end

function this:open()
  self:initModule()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
end

function this:initModule()
  self.bind.activeObjList = true
  self.bind.active_blur = true
  self.bind.title = true
  self:initObjList()
  self:deSelectObj()
end

function this:show()
  self:refreshShowInfo()
end

function this:hide()
  self:deSelectObj()
end

function this:refresh()
end

function this:refreshShowInfo()
  self.bind.txt_curNum = string.format("%d", L_SituationManager:getCount(L_Const.situationGroup.obj))
  local tpl_situationTab = _situationTabTpl:getTplById(L_Const.situationGroup.obj)
  self.bind.txt_maxNum = string.format("/%d", _situationTabTpl:getNumber(tpl_situationTab))
  for _, v in pairs(self.modules.objList) do
    v:refreshNum()
  end
end

function this:close()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
end

function this:initObjList()
  local list = {}
  for i, v in pairs(_objTpl.data) do
    local unlock = _objTpl:getUnlock(v)
    local isOpen = true or L_ConditionManager:isComplete(unlock)
    if isOpen then
      local data = {
        id = _objTpl:getId(v),
        img_icon = _objTpl:getObjIcon(v)
      }
      table.insert(list, data)
    end
  end
  self.bind.objList:clear()
  self.bind.objList:insert_array(list)
end

function this:addObj(id)
  local param = {
    configId = id,
    pos = L_SituationManager:getLookPos(),
    rot = L_Vector3.new(0, 0, 0)
  }
  L_SituationManager:addCreateObjCommand(param)
end

function this:selectObj(objContainer)
  if objContainer == self.curSelectObjContainer then
    return
  end
  self:deSelectObj()
  self.curSelectObjContainer = objContainer
  self.selectGuid = objContainer.guid
  self.bind.activeDragHandler = true
  self.modules.dragHandler:bindObj(objContainer.gameObject)
end

function this:deSelectObj()
  self.bind.activeDragHandler = false
  self.modules.dragHandler:bindObj(nil)
  self.curSelectObjContainer = nil
  self.selectGuid = nil
end

function this:deleteObj()
  local param = {
    guid = self.selectGuid
  }
  L_SituationManager:addRemoveObjCommand(param)
end

function this:onPosChanged(startPos, endPos)
  local param = {
    guid = self.selectGuid,
    startPos = startPos,
    endPos = endPos
  }
  L_SituationManager:addMoveObjCommand(param)
end

function this:onRotChanged(startY, endY)
  local param = {
    guid = self.selectGuid,
    startRotate = L_Vector3.new(0, startY, 0),
    endRotate = L_Vector3.new(0, endY, 0)
  }
  L_SituationManager:addRotateObjCommand(param)
end

function this:onUndoChanged()
  if not self.isBind then
    return
  end
  if self.selectGuid then
    local has = L_SituationManager:hasObj(self.selectGuid)
    if not has then
      self:deSelectObj()
    end
  end
  self:refreshShowInfo()
end

return this
