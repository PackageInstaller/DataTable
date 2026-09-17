local this = class("pageAttendance", G_UIPageBase)
local attendanceTpl = L_GameTpl:getDailyAttendanceTpl()
local attendanceTeamTpl = L_GameTpl:getDailyAttendanceTeamTpl()

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
    freshTime = ""
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      if self.disableCloseBtn ~= true then
        L_UI:close(self.pageName)
      end
    end,
    signIn_list = {
      onClick = function(self, data)
        if self.disableCloseBtn ~= true then
          L_ItemTplManager:showInfoTip(data.reward.itemType, data.rewardId)
        end
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.DailyReward, 1, false)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage, self, nil, 0)
  self:initPage()
end

function this:open()
end

function this:close(options)
  this.super.close(self, options)
  self:disposeTimer()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage)
  local gameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_SIGN)
  if not gameEventData then
    return
  end
  local gameEvent = gameEventData:getGameEvent()
  if not gameEvent.show then
    gameEvent:req_signIn()
  end
end

function this:show()
  C_InputManager.SetInputmap(C_InputManager_MapType.DefaultUIInputMap)
end

function this:escHandle()
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
  local signCount = gameEvent.show and gameEvent.count or gameEvent.count - 1
  for i, v in pairs(attendanceList) do
    local item = L_ItemManager:parseItem(v.reward[1][1], v.reward[1][2])
    local num = v.reward[1][3]
    table.insert(data, {
      id = v.id,
      reward = item,
      rewardId = v.reward[1][2],
      show_important_icon = v.important == 1,
      show_received_icon = i <= signCount,
      show_today = i == signCount,
      group_alpha = i <= signCount and 0.2 or 1,
      item_icon = item.icon,
      day_num = v.day < 10 and "0" .. v.day or tostring(v.day),
      item_num = "x" .. tostring(num)
    })
  end
  self.bind.signIn_list:insert_array(data)
  self:startDateTimer()
  if not gameEvent.show then
    self:startCountDown(0.5)
  end
end

function this:startCountDown(second)
  local gameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_SIGN)
  if not gameEventData then
    return
  end
  self.disableCloseBtn = true
  local gameEvent = gameEventData:getGameEvent()
  if not gameEvent.show then
    local tpl = attendanceTpl:getTplById(self.monthId)
    local attendanceId = attendanceTpl:getReward(tpl)
    local rewardTpl = attendanceTeamTpl:getTplByDay(attendanceId, gameEvent.count)
    self.countDown = Timer.once(second, function()
      gameEvent:req_signIn(function()
        self.disableCloseBtn = false
        L_RewardManager:showTplReward(attendanceTeamTpl:getReward(rewardTpl))
      end)
    end, self, self.gameObject)
  else
    self.disableCloseBtn = false
  end
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
      self:startDateTimer()
    end
  end, self, self.gameObject)
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.countDown ~= nil then
    self.countDown:stop()
    Timer.remove(self.countDown)
    self.countDown = nil
  end
end

return this
