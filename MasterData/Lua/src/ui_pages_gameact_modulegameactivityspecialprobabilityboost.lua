local this = class("moduleGameActivitySpecialProbabilityBoost", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventNoviceTpl = L_GameTpl:getGameEventsNoviceTpl()
local _WordsTpl = L_GameTpl:getWordsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    active_bg = true,
    active_bg2 = false,
    txt_openTime = "",
    txt_desc = ""
  }
end

function this.methods()
  return {
    onClick_help = function(self)
      local tpl = _GameEventTpl:getTplById(self.actId)
      local helpGroupId = _GameEventTpl:getHelp(tpl)
      if math.isEmpty(helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end
  }
end

function this:setActId(id)
  self.actId = id
  self:initPage()
end

function this:open()
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.initPage, self)
end

function this:show()
  local isSuperWidthScene = C_ResolutionUtility.CheckSuperWidthScreen()
  if isSuperWidthScene then
    self.bind.active_bg = false
    self.bind.active_bg2 = true
  else
    self.bind.active_bg = true
    self.bind.active_bg2 = false
  end
end

function this:close()
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.initPage)
end

function this:initPage()
  local gameEventData = L_GameEventStore:getGameEventData(self.actId)
  if not gameEventData then
    return
  end
  local gameEvent = gameEventData:getGameEvent()
  if not gameEvent then
    return
  end
  local tpl = _GameEventTpl:getTplById(self.actId)
  self.helpGroupId = _GameEventTpl:getHelp(tpl)
  self.bind.txt_desc = _GameEventTpl:getDesc(tpl)
  local str = _GameEventTpl:getFakeTime(tpl)
  if str == nil or string.isEmpty(str) then
    self:refreshDate(tpl)
  else
    self.bind.txt_openTime = L_Lang:get(str)
  end
end

function this:refreshDate(tpl)
  local startTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local endTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local startMonth = startTime:sub(1, 2)
  local endMonth = endTime:sub(1, 2)
  local startDate = startTime:sub(4, 5)
  local endDate = endTime:sub(4, 5)
  self.bind.txt_openTime = startMonth .. "/" .. startDate .. "-" .. endMonth .. "/" .. endDate
end

return this
