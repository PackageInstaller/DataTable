local this = class("commonTimelinePrefabHandle", require("ui.manager.hero.timeline.timelinePrefabHandle"))
local TimelineSpliteHelper = CS.Gameplay.Tools.TimelineSplitTool.TimelineSpliteHelper

function this:ctor()
  this.super.ctor(self)
  self.actorInfoList = {}
end

function this:getFilePath(timelineName)
  local path = "Timeline/UI/" .. timelineName .. "/pre_timeline_common.prefab"
  return path
end

function this:getTimelineStateComponent(prefab)
  return prefab:GetComponent(typeof(CS.Gameplay.Tools.TimelineSplitTool.Common.TimelineCommonState))
end

function this:playTimelineAsset(timelineAsset)
  self.isEnd = false
  local state = self._timelineStateMap[self._timelineName]
  if state then
    self.subDirIndex = nil
    self.bindparent = {}
    self.moveMode = {}
    local actorPlayerInfos = state.actorPlayerInfos
    local dynamicBinds = {}
    for i, v in pairs(actorPlayerInfos) do
      local actor = self:getRealActorEntity(v.actorPath, v.name)
      if actor ~= nil and v.actorPath ~= nil then
        dynamicBinds[v.actorPath] = actor
      end
    end
    self:bindMainPlayer(self._timelineName, dynamicBinds)
    state.onSubDirectorStart = handler(self, self.onSubDirectorStart)
    state.director:Play()
  end
end

function this:getTimelineActor(actorName)
  local state = self._timelineStateMap[self._timelineName]
  if state == nil then
    return
  end
  local info = state:GetActorPlayerInfo(actorName)
  if info == nil then
    return
  end
  local go = state.transform:Find(info.actorPath)
  return go
end

function this:getRealActorEntity(remarkName, actorName)
  remarkName = remarkName or ""
  actorName = actorName or ""
  local key = remarkName .. "@" .. actorName
  if self.actorInfoList[key] == nil and self.getRealActorEntityHandle then
    self.actorInfoList[key] = self.getRealActorEntityHandle(remarkName, actorName)
  end
  return self.actorInfoList[key]
end

function this:getRealActorNode(remarkName, actorName)
  local actor = self:getRealActorEntity(remarkName, actorName)
  if actor == nil then
    return nil
  end
  return actor:getGameObject()
end

function this:onSubDirectorStart(index)
  if self.subDirIndex == index then
    return
  end
  self.subDirIndex = index
  local state = self._timelineStateMap[self._timelineName]
  if state then
    local timelineBindDatas = state.timelineBindDatas
    if 0 <= index and index < timelineBindDatas.Count then
      local bindData = timelineBindDatas[index]
      for i = 0, bindData.playableBindingInfo.Count - 1 do
        local info = bindData.playableBindingInfo[i]
        local actorInfo = state:GetActorPlayerInfoByActorPath(info.actorPath)
        local actorName
        if actorInfo then
          actorName = actorInfo.name
        end
        local actor = self:getRealActorNode(info.actorPath, actorName)
        if actor ~= nil then
          local go = state.transform:Find(info.actorPath)
          if go == nil then
            local lastSlashIndex = string.match(info.actorPath, ".*/()")
            if lastSlashIndex == nil then
              lastSlashIndex = 0
            end
            if 0 < lastSlashIndex then
              local path = string.sub(info.actorPath, 1, lastSlashIndex - 2)
              go = state.transform:Find(path)
            end
          else
            go.gameObject:SetActive(false)
            go = go.transform.parent.gameObject
          end
          if go then
            if not self.bindparent[actor] then
              self.bindparent[actor] = actor.transform.parent
            end
            actor.transform:SetParent(go.transform)
            L_Vector3.setLocalPos(actor.transform, L_Vector3.getTemp())
            L_Vector3.setLocalRot(actor.transform, L_Vector3.getTemp())
          end
        end
      end
    end
  end
end

function this:resetTimeline(director)
  if self.isEnd then
    return
  end
  self.isEnd = true
  if self.bindparent then
    for i, v in pairs(self.bindparent) do
      i.transform:SetParent(v)
    end
  end
  self.bindparent = nil
  if self.moveMode then
    for entity, v in pairs(self.moveMode) do
      if entity then
        local rotate = entity.gameObject.transform.eulerAngles.y
        entity:setRotation(L_Vector3.getTemp(0, rotate, 0))
      end
    end
  end
  self.moveMode = nil
  local state = self._timelineStateMap[self._timelineName]
  if state then
    state.onSubDirectorStart = nil
  end
end

function this:onTimelinePlayEndInter(director)
  self:resetTimeline()
end

function this:emitterReleaseEvent(director)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    state:EmitterReleaseEvent()
  end
end

function this:dispose()
  for i, v in pairs(self.actorInfoList) do
    v:dispose()
  end
  self.actorInfoList = {}
  self:resetTimeline()
  this.super.dispose(self)
end

function this:setPosition(position)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    L_Vector3.setRelativePos(state.transform, position)
  end
end

function this:setLocalPosition(position)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    L_Vector3.setLocalPos(state.transform, position)
  end
end

function this:setRotation(rotation)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    L_Vector3.setLocalRot(state.transform, rotation)
  end
end

function this:setWorldRotation(rotation)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    L_Vector3.setRot(state.transform, rotation)
  end
end

function this:setParent(trans)
  local state = self._timelineStateMap[self._timelineName]
  if not state then
    return
  end
  state.transform:SetParent(trans, false)
end

return this
