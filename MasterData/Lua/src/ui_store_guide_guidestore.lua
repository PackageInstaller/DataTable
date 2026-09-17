local cls = class("guideStore", G_BaseStore)
local tag = cls:getName()
local _guideGroupTpl = L_GameTpl:getGuideGroupTpl()
local _tutorialTpl = L_GameTpl:getTutorialTpl()
cls:importPartialClass(require("ui.store.guide.guideState"))
cls.event = {onUpdate = "onUpdate"}

function cls:updateGuideData(id, step, sendEvent)
  if id == nil then
    return
  end
  if table.isEmpty(self.data.guideDataMap[id]) and self.data.setHasInitSync == true then
    local tpl = _guideGroupTpl:getTplById(id)
    local tutorialIds = _guideGroupTpl:getTutorialId(tpl)
    if not table.isEmpty(tutorialIds) then
      for _, tutorialId in pairs(tutorialIds) do
        L_ReddotManager:markNew(L_ReddotManager.DotDef.NewTutorialGuide, tutorialId)
        local data = _tutorialTpl:getTplById(tutorialId)
        if data then
          local tutorialType = _tutorialTpl:getTutorialTypeId(data)
          local eventData = {
            act_type = 1,
            tutorial_id = tutorialId,
            tutorial_type = tutorialType
          }
          L_GameUtil.logEvent(L_Const.logEventName.guide_book, eventData)
        end
      end
    end
  end
  self.data.guideDataMap[id] = self.data.guideDataMap[id] or {}
  self.data.guideDataMap[id][step] = true
  if step == 0 and self.onGuideCompleted then
    self:onGuideCompleted(id)
  end
  if sendEvent then
    self:call(self.event.onUpdate, self.guideData)
  end
end

function cls:rsp_syncGuideData(protoData)
  if protoData.infos then
    for i = 0, protoData.infos.Count - 1 do
      local id = protoData.infos[i].id
      self:updateGuideData(id, protoData.infos[i].subId)
    end
  end
  if self.rebuildMutualCompleteMap then
    self:rebuildMutualCompleteMap()
  end
  self.data.setHasInitSync = true
  self:call(self.event.onUpdate)
end

function cls:updateGuideDataByGM(id, step, complete)
  if id == nil then
    return
  end
  if complete == true then
    self.data.guideDataMap[id] = self.data.guideDataMap[id] or {}
    self.data.guideDataMap[id][step] = true
  else
    self.data.guideDataMap[id] = nil
  end
  if self.rebuildMutualCompleteMap then
    self:rebuildMutualCompleteMap()
  end
  self:call(self.event.onUpdate)
end

function cls:rebuildMutualCompleteMap()
  self.data.mutualCompleteMap = {}
  for guideId, stepMap in pairs(self.data.guideDataMap) do
    if stepMap[0] == true then
      self:onGuideCompleted(guideId)
    end
  end
end

function cls:onConditionRecordChanged(ids)
  if ids == nil then
    return
  end
  for _, id in ipairs(ids) do
    self.data.enabledConditions[id] = true
  end
end

function cls:req_updateGuideData(id, step, callback)
  local data = {id = id, sub_id = step}
  L_Net:sendMessage(MsgGenCode.CSProtoGuideUpdate, data, function(rsp, errorCode)
    if errorCode == 0 then
      self:updateGuideData(data.id, data.sub_id)
    end
    if callback then
      callback(errorCode == 0)
    end
  end)
end

return cls
