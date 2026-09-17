local this = class("pageEditBirthday", G_UIPageBase)
local Month2DayMap = {
  [1] = 31,
  [2] = 29,
  [3] = 31,
  [4] = 30,
  [5] = 31,
  [6] = 30,
  [7] = 31,
  [8] = 31,
  [9] = 30,
  [10] = 31,
  [11] = 30,
  [12] = 31
}

function this.bind()
  return {
    scrollList_month = {
      moduleName = "pages/playerCard/cellBirthdayDate"
    },
    scrollList_day = {
      moduleName = "pages/playerCard/cellBirthdayDate"
    },
    moveToIndex_day = 0,
    moveToIndex_month = 0
  }
end

function this.methods()
  return {
    onClick_cancel = function(self)
      if self._startConfirm then
        return
      end
      L_UI:close(self.pageName)
    end,
    onClick_confirm = function(self)
      self.bindComponents.loopList_day.ScrollRect.enabled = false
      self.bindComponents.loopList_day.ScrollRect.enabled = true
      self.bindComponents.loopList_month.ScrollRect.enabled = false
      self.bindComponents.loopList_month.ScrollRect.enabled = true
      self._startConfirm = true
      self._waitFrameTaskId = FrameScheduler.add(function()
        local day = self.bindComponents.loopList_day.CurSnapNearestItemIndex
        self.bind.moveToIndex_day = day - 1
        self._selectDay = day
        local month = self.bindComponents.loopList_month.CurSnapNearestItemIndex
        self.bind.moveToIndex_month = month - 1
        self._selectMonth = month
        self:confirmSelect()
        self._startConfirm = false
      end, 5)
    end,
    onSnapFinished_scrollList_month = function(self, index)
      if index ~= self._selectMonth then
        self._selectMonth = index
        self._recordSelectDay = self._selectDay
        self.playDayAudio = false
        self:initDayList()
      end
    end,
    onSnapFinished_scrollList_day = function(self, index)
      self._selectDay = index
    end,
    onSnapPosition_scrollList_day = function(self, index)
      if self.playDayAudio then
        C_AudioManager.Play("Play_SFX_System_UI_NameCard_Birthday_Slider")
      end
    end,
    onSnapPosition_scrollList_month = function(self, index)
      if self.playDayAudio then
        C_AudioManager.Play("Play_SFX_System_UI_NameCard_Birthday_Slider")
      end
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._selectMonth = 1
  self._selectDay = 1
  self._recordSelectDay = 1
  C_AudioManager.Play("Play_SFX_System_UI_NameCard_Birthday_Open")
  self:initMonthList()
  self:initDayList()
end

function this:escHandle()
  if self._startConfirm then
    return
  end
  L_UI:close(self.pageName)
end

function this:close()
  if self._waitFrameTaskId then
    FrameScheduler.remove(self._waitFrameTaskId)
  end
end

function this:initMonthList()
  local tmp = {}
  table.insert(tmp, {})
  for i = 1, 12 do
    table.insert(tmp, {date = i})
  end
  table.insert(tmp, {})
  self.bind.scrollList_month:clear()
  self.bind.scrollList_month:insert_array(tmp)
end

function this:initDayList()
  local tmp = {}
  local dayCount = Month2DayMap[self._selectMonth]
  local newDay = math.min(self._recordSelectDay, dayCount)
  self._selectDay = newDay
  table.insert(tmp, {})
  for i = 1, dayCount do
    table.insert(tmp, {date = i})
  end
  table.insert(tmp, {})
  self.bind.scrollList_day:clear()
  self.bind.scrollList_day:insert_array(tmp)
  self.bind.moveToIndex_day = newDay - 1
  self.playDayAudio = true
end

function this:confirmSelect()
  local curDay = self._selectDay
  local curMonth = self._selectMonth
  local data_tip = {
    txtContent = L_WordsTpl:getValue("ui_playercard_determine_changebirthday", {month = curMonth, day = curDay}),
    txtSubContent = L_WordsTpl:getValue("notice_playercard_changebirthday_cannotalter"),
    confirmCallback = function()
      L_PlayerStore:req_CSProtoChangeBirthday(curMonth, curDay, function()
        L_UI:close(self.pageName)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_changebirthday_success"))
      end)
    end
  }
  L_GameUtil.showCommonTip(data_tip)
end

return this
