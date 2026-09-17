local this = class("moduleRewardUp", G_UIModuleBase)
local _GameEventDoubleDropTpl = L_GameTpl:getGameEventsDoubleDropTpl()

function this.bind()
  return {bShowSelf = false}
end

function this:open()
  self:initPage()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage, self)
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage)
end

function this:initPage()
  local gameEventId = L_GameEventStore:getIdByType(L_Const.ActivityType.AT_DOUBLE_DROP)
  if not gameEventId then
    self.eventOpen = false
    self:refreshVisible()
    return
  end
  local gameEventData = L_GameEventStore:getGameEventData(gameEventId)
  if not gameEventData then
    self.eventOpen = false
    self:refreshVisible()
    return
  end
  gameEventData = gameEventData:getGameEvent()
  if not gameEventData then
    self.eventOpen = false
    self:refreshVisible()
    return
  end
  if gameEventData:getLockState() then
    self.eventOpen = false
    self:refreshVisible()
    return
  end
  self.gameEventId = gameEventId
  self.eventOpen = true
  self:refreshVisible()
end

function this:setEntrustType(groupId)
  self.entrustTypeShow = false
  if self.gameEventId then
    local tpl = _GameEventDoubleDropTpl:getTplById(self.gameEventId)
    if tpl then
      local entrustTypeids = _GameEventDoubleDropTpl:getEntrustTypeid(tpl)
      if type(groupId) == "table" then
        for _, typeid in ipairs(groupId) do
          if table.indexOf(entrustTypeids, typeid) then
            self.entrustTypeShow = true
            break
          end
        end
      elseif table.indexOf(entrustTypeids, groupId) then
        self.entrustTypeShow = true
      end
    end
  end
  self:refreshVisible()
  return self.entrustTypeShow
end

function this:refreshVisible()
  if self.entrustTypeShow == nil then
    self.bind.bShowSelf = self.eventOpen
  else
    self.bind.bShowSelf = self.eventOpen and self.entrustTypeShow
  end
end

return this
