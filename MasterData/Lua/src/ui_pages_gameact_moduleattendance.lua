local this = class("moduleAttendance", G_UIModuleBase)
local attendanceTpl = L_GameTpl:getDailyAttendanceTpl()
local attendanceTeamTpl = L_GameTpl:getDailyAttendanceTeamTpl()
local gameActTpl = L_GameTpl:getGameActTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    signIn_list = {
      moduleName = "pages/GameAct/cellSignInItem"
    },
    currentMonth = "",
    freshTime = "",
    durationTime = "",
    show_receivedTodayReward = false
  }
end

function this.methods()
  return {
    signIn_list = {
      onClick = function(self, data)
        L_ItemTplManager:showInfoTip(data.reward.itemType, data.rewardId)
      end
    }
  }
end

function this:setActId(id)
  self.actId = id
end

function this:open()
  self:initPage()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.refreshSignIn, self, nil, 0)
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.refreshSignIn)
  self:disposeTimer()
end

function this:refreshSignIn()
  self:initPage()
end

function this:initPage()
  local gameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_SIGN)
  if not gameEventData then
    return
  end
  local gameEvent = gameEventData:getGameEvent()
  local currTime = L_TimeUtil.getServerTime()
  local differ = 0
  if L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int) then
    differ = tonumber(L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int)) * 3600
  end
  local date = L_TimeUtil.getDateInfo(currTime - differ)
  self.monthId = date.year * 1000 + date.month
  local tpl = attendanceTpl:getTplById(self.monthId)
  self.bind.currentMonth = "CHECK IN IN " .. attendanceTpl:getEnglishMonth(date.month)
  local attendanceId = attendanceTpl:getReward(tpl)
  local attendanceList = attendanceTeamTpl:getGroupRewards(attendanceId)
  table.sort(attendanceList, function(a, b)
    return a.day < b.day
  end)
  self.bind.signIn_list:clear()
  local data = {}
  for i, v in ipairs(attendanceList) do
    local item = L_ItemManager:parseItem(v.reward[1][1], v.reward[1][2])
    local num = v.reward[1][3]
    table.insert(data, {
      id = v.id,
      reward = item,
      rewardId = v.reward[1][2],
      show_important_icon = v.important == 1,
      show_received_icon = i <= gameEvent.count,
      show_today = i == gameEvent.count,
      group_alpha = i <= gameEvent.count and 0.2 or 1,
      item_icon = item.icon,
      day_num = v.day < 10 and "0" .. v.day or tostring(v.day),
      item_num = "x" .. tostring(num)
    })
  end
  self.bind.signIn_list:insert_array(data)
  self:startDateTimer()
end

function this:startDateTimer()
  self:disposeTimer()
  local nowTime = L_TimeUtil:getServerTime()
  local nextDayTime = L_TimeUtil.getNextDayRefreshTime()
  local gapTime = nextDayTime - nowTime
  self.bind.freshTime = L_WordsTpl:getValue("ui_systemMessage_19") .. L_TimeUtil.secondToLangString(gapTime)
  self.timer = Timer.repeated(1, function()
    if 0 < gapTime then
      gapTime = gapTime - 1
      self.bind.freshTime = L_WordsTpl:getValue("ui_systemMessage_19") .. L_TimeUtil.secondToLangString(gapTime)
    else
      self.bind.freshTime = ""
      self:disposeTimer()
    end
  end, self, self.gameObject)
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
