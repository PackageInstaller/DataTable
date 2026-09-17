local this = class("moduleActivityParty", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    moduleActivityBg = {
      moduleName = "pages/GameAct/moduleActivityBg"
    },
    textDesc = "",
    textMissionName = "",
    text_score = "",
    text_score_max = "",
    text_left_time = "",
    bgN = C_Vector2(0, 0),
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    listReward = {
      moduleName = "modulePages/cellIconBag"
    },
    active_btn_property = true,
    active_btn_property_sw = true,
    left_Content = C_Vector2(1200, 674),
    Content = C_Vector2(0, -735.8)
  }
end

function this.methods()
  return {
    OnClick_Go = function(self)
      self:onClickGo()
    end,
    OnClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end,
    OnClick_reward = function(self)
      self:onClickReward()
    end,
    Onclick_shop = function(self)
      self:onClickShop()
    end
  }
end

function this:setActId(id)
  self.actId = id
  self:init()
end

function this:init()
  self.tpl = _GameEventTpl:getTplById(self.actId)
  self:initBg()
  self:setupWideScreenState()
  self._data = L_GameEventStore:getGameEventData(self.actId)
  self.bind.textMissionName = L_Lang:get(_GameEventTpl:getName(self.tpl))
  self.bind.textDesc = L_Lang:get(_GameEventTpl:getDesc(self.tpl))
  self:setupActivityTime()
  self:setupRewards()
  self:setupScore()
  self.helpGroupId = _GameEventTpl:getHelp(self.tpl)
  self:setupConditions()
  self:startTimer()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.onGameEventSync, self)
end

function this:onGameEventSync()
  self._data = L_GameEventStore:getGameEventData(self.actId)
  self:setupWideScreenState()
  self:setupActivityTime()
  self:setupScore()
  self:setupConditions()
end

function this:setupWideScreenState()
  local w, h = C_Screen.width, C_Screen.height
  local isSuperWidthScene = C_ResolutionUtility.CheckSuperWidthScreen() or 0 < h and 2.3333 < w / h
  local bgPos = self.bind.bgN or C_Vector2(0, 0)
  self.bind.bgN = C_Vector2(bgPos.x, isSuperWidthScene and -421 or 0)
  self.bind.left_Content = C_Vector2(isSuperWidthScene and 1305 or 1200, isSuperWidthScene and 674 or 674)
  self.bind.Content = C_Vector2(isSuperWidthScene and -8 or 0, isSuperWidthScene and -735.8 or -735.8)
  if isSuperWidthScene then
    self.bind.active_btn_property_sw = true
    self.bind.active_btn_property = false
    if self.gameObject then
      local rt = self.gameObject.transform:Find("btn_property_sw")
      if rt then
        local pos = rt.anchoredPosition
        rt.anchoredPosition = C_Vector2(pos.x, -421)
      end
    end
  else
    self.bind.active_btn_property_sw = false
    self.bind.active_btn_property = true
    if self.gameObject then
      local rt = self.gameObject.transform:Find("btn_property_sw")
      if rt then
        local pos = rt.anchoredPosition
        rt.anchoredPosition = C_Vector2(pos.x, 0)
      end
    end
  end
end

function this:_pollScreenSizeForWideState()
  if not (self.isBind and self.gameObject) or not self.gameObject.activeInHierarchy then
    return
  end
  local w, h = C_Screen.width, C_Screen.height
  if self._lastPartyScreenW == w and self._lastPartyScreenH == h then
    return
  end
  self._lastPartyScreenW = w
  self._lastPartyScreenH = h
  self:setupWideScreenState()
end

function this:_rememberCurrentScreenSize()
  self._lastPartyScreenW = C_Screen.width
  self._lastPartyScreenH = C_Screen.height
end

function this:startScreenPollTimer()
  self:stopScreenPollTimer()
  if not self.gameObject then
    return
  end
  self._screenPollTimer = Timer.repeated(0.15, function()
    self:_pollScreenSizeForWideState()
  end, self, self.gameObject)
end

function this:stopScreenPollTimer()
  if self._screenPollTimer then
    self._screenPollTimer:stop()
    Timer.remove(self._screenPollTimer)
    self._screenPollTimer = nil
  end
end

function this:setupActivityTime()
  local endTime = 0
  if self.tpl and _GameEventTpl.getTimeLimit then
    endTime = tonumber(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.tpl))) or 0
  end
  if endTime <= 0 and self.tpl and _GameEventTpl.getEndTime then
    endTime = tonumber(L_TimeUtil.parseConfigDatetime(_GameEventTpl:getEndTime(self.tpl))) or 0
  end
  if endTime <= 0 and self._data and self._data.getEndTime then
    endTime = tonumber(self._data:getEndTime()) or 0
  end
  self.endTime = endTime
  self:updateRemainingTime()
end

function this:updateRemainingTime()
  local now = L_TimeUtil:getServerTime()
  local remaining = self.endTime - now
  if remaining <= 0 then
    self.bind.text_left_time = L_WordsTpl:getValue("ui_game_events_day_attendance_end")
    return
  end
  local days = math.floor(remaining / 86400)
  local hours = math.floor(remaining % 86400 / 3600)
  local minutes = math.floor(remaining % 3600 / 60)
  local seconds = remaining % 60
  if 0 < days then
    self.bind.text_left_time = string.format("剩余:" .. "%d天%d时", days, hours)
  elseif 0 < hours then
    self.bind.text_left_time = string.format("剩余:" .. "%d时%d分", hours, minutes)
  else
    self.bind.text_left_time = string.format("剩余:" .. "%d分%d秒", minutes, seconds)
  end
end

function this:setupRewards()
  local rewards = _GameEventTpl:getRewardShow(self.tpl)
  if rewards then
    local rewardsData = L_DataUtil.parseRewardConfig(rewards)
    self.bind.listReward:clear()
    self.bind.listReward:insert_array(rewardsData)
  end
end

function this:setupScore()
  local currentScore = 0
  local maxScore = 0
  if self._data and self._data.getGameEvent then
    local ge = self._data:getGameEvent()
    local serverData = ge and ge.getData and ge:getData() or nil
    if serverData then
      currentScore = tonumber(serverData.score) or 0
      maxScore = tonumber(serverData.scoreLimit) or tonumber(serverData.score_limit) or 0
    end
  end
  if maxScore <= 0 then
    maxScore = self:getRewardMaxScoreLimit()
  end
  self.bind.text_score = tostring(currentScore)
  self.bind.text_score_max = tostring(maxScore)
end

function this:getRewardMaxScoreLimit()
  local maxScore = 0
  if not self._data or not self._data.getRewardStateList then
    return maxScore
  end
  local rewardStateList = self._data:getRewardStateList() or {}
  local rewardTpl = L_GameTpl:getGameEventsRewardTpl()
  for _, reward in ipairs(rewardStateList) do
    local tpl = rewardTpl:getTplById(reward.reward_id)
    local targetScore = tpl and tonumber(rewardTpl:getPara(tpl)) or 0
    if maxScore < targetScore then
      maxScore = targetScore
    end
  end
  return maxScore
end

function this:setupConditions()
  local conditions = _GameEventTpl:getCondition(self.tpl)
  local lockJumps = _GameEventTpl:getLockJump(self.tpl) or {}
  local lockTexts = _GameEventTpl:getLockText(self.tpl) or {}
  self.isUnlock = true
  self.bind.condition_list:clear()
  self.firstLockJump = nil
  self.firstLockDesc = nil
  local data = {}
  if conditions then
    for i, v in ipairs(conditions) do
      if not L_ConditionManager:singleIsComplete(v) then
        self.isUnlock = false
        local lockJump = lockJumps[i]
        local lockDesc = L_Lang:get(lockTexts[i])
        if self.firstLockJump == nil then
          self.firstLockJump = lockJump
          self.firstLockDesc = lockDesc
        end
        table.insert(data, {
          lockParam = lockJump and {lockJump} or nil,
          txt_lockDesc = lockDesc
        })
      end
    end
  end
  if 0 < #data then
    self.bind.condition_list:insert_array(data)
  end
end

function this:initBg()
  self.modules.moduleActivityBg:setPath(self.actId)
end

function this:onClickGo()
  if not self.isUnlock then
    if self.firstLockDesc and not string.isEmpty(self.firstLockDesc) then
      L_FlyMsgManager:showNormalMsg(self.firstLockDesc)
    end
    return
  end
  local pageConfig = L_UI and L_UI.getPageConfig and L_UI:getPageConfig("pageGameActivityParty")
  if pageConfig then
    pageConfig.blackMaskClosedCallBack = true
  end
  L_UI:open("pageGameActivityParty", {
    actId = self.actId
  })
end

function this:onClickReward()
  L_UI:open("pageActivityPartyReward", {
    id = self.actId
  })
end

function this:onClickShop()
end

function this:startTimer()
  self.timer = Timer.repeated(1, function()
    self:updateRemainingTime()
  end, self, self.gameObject)
end

function this:stopTimer()
  if self.timer then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:preOpen(options)
  self.timer = nil
  self.isUnlock = false
end

function this:open()
  self:setupWideScreenState()
  self:_rememberCurrentScreenSize()
  self:startScreenPollTimer()
end

function this:show()
  self:setupWideScreenState()
  self:_rememberCurrentScreenSize()
  self:startScreenPollTimer()
end

function this:hide()
  this.super.hide(self)
  self:stopScreenPollTimer()
end

function this:close()
  self:stopTimer()
  self:stopScreenPollTimer()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.onGameEventSync)
end

return this
