local this = class("moduleSituationEdit_stamp", require("ui.pages.situation.group.moduleSituationEditBase"))
local _photoPicTpl = L_GameTpl:getPhotographPicTpl()
local _situationTabTpl = L_GameTpl:getSituationTabTpl()

function this.bind()
  return {
    txt_curNum = "",
    txt_maxNum = "",
    active_blur = true,
    activeStampList = true,
    stampSelList = {
      moduleName = "pages/situation/cell/cellSituationStampSelectItem"
    },
    activeDrag = nil,
    moduleDragHandler = {
      moduleName = "pages/photoEdit/modulePhotoStampHandle"
    },
    title = true,
    instruection = false
  }
end

function this.methods()
  return {
    stampSelList = {
      onClickAdd = function(self, id)
        self:onClickAddStamp(id)
        self:refreshShowInfo()
      end,
      onClickDel = function(self, id)
        self:refreshShowInfo()
      end
    },
    moduleDragHandler = {
      onPosChanged = function(self, startPos, endPos)
        self:onPosChanged(startPos, endPos)
      end,
      onScaleChanged = function(self, startScale, endScale)
        self:onScaleChanged(startScale, endScale)
      end
    },
    onClickCloseList = function(self)
      self.bind.active_blur = false
      self.bind.activeStampList = false
      self.bind.title = false
      self.parent.bind.editTabId = -1
    end,
    onClick_del = function(self)
      self:onClickDelStamp()
      self:refreshShowInfo()
    end
  }
end

function this:open()
  self:initModule()
end

function this:initModule()
  self.bind.activeStampList = true
  self.bind.active_blur = true
  self.bind.title = true
  self.moduleDragHandler = self.modules.moduleDragHandler
  self:initList()
  self:deselectStamp()
  self:refreshShowInfo()
end

function this:refresh()
end

function this:refreshShowInfo()
  self.bind.txt_curNum = string.format("%d", L_SituationManager:getCount(L_Const.situationGroup.stamp))
  local tpl_situationTab = _situationTabTpl:getTplById(L_Const.situationGroup.stamp)
  self.bind.txt_maxNum = string.format("/%d", _situationTabTpl:getNumber(tpl_situationTab))
  for _, v in pairs(self.modules.stampSelList) do
    v:refreshNum()
  end
end

function this:show()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
end

function this:hide()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
  self:deselectStamp()
end

function this:close()
end

function this:initList()
  local list = {}
  for i, v in pairs(_photoPicTpl.data) do
    local can = L_ConditionManager:singleIsComplete(_photoPicTpl:getSystemUnlock(v))
    if can then
      local temp = {
        id = i,
        img_icon = _photoPicTpl:getIcon(v)
      }
      table.insert(list, temp)
    end
  end
  self.bind.stampSelList:clear()
  self.bind.stampSelList:insert_array(list)
end

function this:selectStamp(stampContainer)
  self.bind.activeDrag = true
  self.curSelectStamp = stampContainer
  self.moduleDragHandler:bindStamp(stampContainer.rectTrans, true)
  self.moduleDragHandler:setActive(true)
end

function this:deselectStamp()
  self.bind.activeDrag = false
  self.curSelectStamp = nil
  self.moduleDragHandler:setActive(false)
end

function this:onClickAddStamp(id)
  local index = L_SituationManager.curSolution:getNextStampIndex()
  local param = {
    configId = id,
    pos = {x = 0, y = 0},
    scale = 1,
    index = index
  }
  L_SituationManager:addCreateStampCommand(param)
end

function this:onClickDelStamp()
  if self.curSelectStamp ~= nil then
    local param = {
      guid = self.curSelectStamp.guid
    }
    L_SituationManager:addRemoveStampCommand(param)
  end
  for _, v in pairs(self.modules.stampSelList) do
    v:refreshNum()
  end
end

function this:onPosChanged(startPos, endPos)
  if self.curSelectStamp ~= nil then
    local param = {
      guid = self.curSelectStamp.guid,
      startPos = startPos,
      endPos = endPos
    }
    L_SituationManager:addMoveStampCommand(param)
  end
end

function this:onScaleChanged(startScale, endScale)
  if self.curSelectStamp ~= nil then
    local param = {
      guid = self.curSelectStamp.guid,
      startScale = startScale,
      endScale = endScale
    }
    L_SituationManager:addScaleStampCommand(param)
  end
end

function this:onUndoChanged()
  if not self.isBind then
    return
  end
  if self.curSelectStamp then
    local has = L_SituationManager:hasStamp(self.curSelectStamp.guid)
    if not has then
      self:deselectStamp()
    else
      self.moduleDragHandler:bindStamp(self.curSelectStamp.rectTrans, true)
    end
  end
  self:refreshShowInfo()
end

return this
