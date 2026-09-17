local this = class("moduleCollectSkillBtn", G_UIModuleBase)
local _collectionToolTypeTpl = L_GameTpl:getCollectionToolTypeTpl()

function this.bind()
  return {
    collectionToolActive = false,
    collectionToolAdd = false,
    collectionToolSwitch = false,
    collectionContent = false,
    collectionEndurance = 0,
    collectionEnduranceTxt = 0,
    collectionToolIcon = "",
    collectionToolIconActive = false,
    img_tool = "",
    txt_efficiency = "",
    go_canvas_efficiency = false
  }
end

function this.methods()
  return {}
end

function this:open(...)
  this.super.open(self, ...)
  self.isCollecting = false
  self.collectionToolInteract = {}
  
  function self._onEventTriggerCollectHandle(_, varList)
    self:onEvent_triggerCollect(varList:GetBool(0), varList:GetInt(1))
  end
  
  function self._onEventCollectStatusChangeHandle(_, varList)
    self:onEvent_collectStatusChange(varList:GetBool(0))
  end
  
  function self._onEventCollectTriggerBtnChangeHandle(_, varList)
    self:collectTriggerBtnChange(varList:GetBool(0), varList:GetInt(1))
  end
  
  function self._onEventRefreshCollectionToolHandle()
    self:refreshCollectionTool()
  end
  
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.TriggerCollect, self._onEventTriggerCollectHandle)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.DataUpdate, self._onEventRefreshCollectionToolHandle)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.CollectStatusChange, self._onEventCollectStatusChangeHandle)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.CollectTriggerBtnChange, self._onEventCollectTriggerBtnChangeHandle)
end

function this:close(...)
  this.super.close(self, ...)
  self.collectionToolInteract = {}
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.CollectTriggerBtnChange, self._onEventCollectTriggerBtnChangeHandle)
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.CollectStatusChange, self._onEventCollectStatusChangeHandle)
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.TriggerCollect, self._onEventTriggerCollectHandle)
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.DataUpdate, self._onEventRefreshCollectionToolHandle)
  self._onEventCollectTriggerBtnChangeHandle = nil
  self._onEventCollectStatusChangeHandle = nil
  self._onEventTriggerCollectHandle = nil
  self._onEventRefreshCollectionToolHandle = nil
end

function this:canShowCollectionToolUi()
  local store = C_CollectionToolStore.GetStore()
  return store ~= nil and store:CanUseCollectionTool()
end

function this:onEvent_triggerCollect(isIn, toolType)
  local canShowCollect = isIn or self.isCollecting
  self.inRange = isIn
  self.bind.collectionToolActive = canShowCollect and self:canShowCollectionToolUi()
  if not self.isCollecting then
    self.toolType = toolType
  end
  if math.isEmpty(self.toolType) then
    return
  end
  if canShowCollect and self:canShowCollectionToolUi() then
    self:refreshCollectionTool()
  else
    self.bind.collectionToolAdd = false
    self.bind.collectionToolIconActive = false
    self.bind.collectionToolSwitch = false
    self.bind.go_canvas_efficiency = false
  end
end

function this:onEvent_collectStatusChange(isBegin)
  self:playAnim(isBegin)
  self:refreshCollectionStatus(isBegin)
end

function this:playAnim(isIn)
  if isIn then
    self.bindComponents.EfficiencyAni:Play("anim_effciency_show")
  else
    if self.bind.go_canvas_efficiency == false then
      return
    end
    self.bindComponents.EfficiencyAni:Play("anim_effciency_hide")
    self:newOrResetTimer("animTimer", function()
      self.bind.go_canvas_efficiency = false
    end, 0.167)
  end
end

function this:refreshCollectionTool()
  if math.isEmpty(self.toolType) then
    return
  end
  local store = C_CollectionToolStore.GetStore()
  if not store:CanUseCollectionTool() then
    self.bind.collectionToolAdd = false
    self.bind.collectionToolSwitch = false
    self.bind.collectionToolIconActive = false
    self.bind.go_canvas_efficiency = false
    return
  end
  local configId = store:GetBestToolConfigId(self.toolType)
  if math.isEmpty(configId) then
    self.bind.collectionToolAdd = true
    self.bind.collectionToolSwitch = false
    self.bind.collectionToolIconActive = false
    self.bind.go_canvas_efficiency = false
    return
  end
  self.bind.collectionToolAdd = false
  self.bind.collectionToolSwitch = false
  self.bind.collectionToolIconActive = true
  self.bind.go_canvas_efficiency = true
  local configTable = CS.Azur.Gameplay.Table.TDCollectionToolTable.GetData(configId)
  local conf = L_ItemTplManager:getItemConfig(L_Const.resType.collectionTool, configId)
  if conf == nil then
    self.bind.collectionToolAdd = false
    self.bind.collectionToolSwitch = false
    self.bind.collectionToolIconActive = false
    self.bind.go_canvas_efficiency = false
    return
  end
  self.bind.collectionEndurance = 0
  self.bind.collectionEnduranceTxt = 0
  self.bind.collectionToolIcon = conf.icon
  local toolTypeTpl = _collectionToolTypeTpl:getTplById(self.toolType)
  if toolTypeTpl ~= nil then
    self.bind.img_tool = _collectionToolTypeTpl:getTypeIcon(toolTypeTpl)
  end
  if configTable ~= nil then
    local actualEfficiency = math.floor(configTable.dropRate / 100)
    self.bind.txt_efficiency = L_GameTpl:getWordsTpl():getTplById("ui_gather_manifestation", {
      [0] = actualEfficiency
    })
  end
end

function this:collectTriggerBtnChange(isIn, toolType)
  self.btnTypeStatus = self.btnTypeStatus or {}
  self.btnTypeStatus[toolType] = self.btnTypeStatus[toolType] or {}
  if isIn == false and self.toolType == toolType then
    self:onEvent_triggerCollect(isIn, toolType)
  end
end

function this:refreshCollectionStatus(isBegin)
  self.isCollecting = isBegin
  self.bind.collectionContent = isBegin
end

return this
