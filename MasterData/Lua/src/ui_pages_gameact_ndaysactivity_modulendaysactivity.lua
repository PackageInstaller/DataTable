local this = class("moduleNDaysActivity", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventStore = L_GameEventStore
local _StateDesc = {
  [1] = "ui_seven_day_task_in_progress",
  [2] = "ui_seven_day_task_reward_receive",
  [3] = "ui_seven_day_task_complete"
}
local _RewardBgImg = {
  [1] = "UI/Atlas/ActivityNDayTask/tex_gameevents_seven_day_bg_12_s.png",
  [2] = "UI/Atlas/ActivityNDayTask/tex_gameevents_seven_day_bg_11_s.png"
}
local _RewardTxtHtmlColor = {
  [1] = "#cbdfa5",
  [2] = "#faffd3"
}
local _ProgressTweenSpeed = 4
local _ProgressTweenMaxTime = 0.7
local _ProgressTweenMinTime = 0.4

function this.bind()
  return {
    curDayTabId = -1,
    list_day_menu = {
      moduleName = "pages/gameAct/nDaysActivity/cellNDayTaskTab"
    },
    list_target = {
      moduleName = "pages/gameAct/nDaysActivity/cellActivityTarget"
    },
    list_processLine = {
      moduleName = "pages/gameAct/nDaysActivity/cellTaskProgressLine"
    },
    txt_progress_cur = "",
    txt_progress_max = "",
    slider_progress_value = 0,
    txt_Desc = "",
    img_reward_hero = "",
    color_txt_reward_hero = nil,
    txt_reward_hero = "",
    img_reward_spirit = "",
    color_txt_reward_spirit = nil,
    txt_reward_spirit = "",
    img_sprit = "",
    obj_block = nil
  }
end

function this.methods()
  return {
    list_day_menu = {
      onClick_day = function(self, tabId, animation)
        if tabId == -1 or self.groupId == tabId then
          return
        end
        animation:Play("anim_cellNDayTaskTab")
        self.groupId = tabId
        local tableView = self.bindComponents.tableView
        tableView.FirstFrameLoader.enabled = true
        tableView.FirstFrameLoader.showAnim = "anim_cellActivityTarget_show"
        self:refreshView(self.groupId)
        self:refreshDayTxtColor()
      end
    },
    list_target = {
      onClickReward = function(self, rewardType, uid)
        L_GameEventStore:call(L_GameEventStore.event.gameEventMaskOpen)
        self.bind.obj_block = true
        local rewardingTargets = {}
        for i = 1, #self.modules.list_target do
          local target = self.bind.list_target:getItemCls(i)
          local state = target.bind.state
          if state == C_ETargetState.Rewarding then
            table.insert(rewardingTargets, target)
          end
        end
        local delay = 0.9
        for _, target in ipairs(rewardingTargets) do
          local animation = target.bindComponents.animation
          target.bind.bgCompleteing = true
          target.bind.fx = true
          for i = 1, #target.bind.rewardList do
            target.bind.rewardList:getItemCls(i):setReceiveActive(true)
          end
          animation:Play("anim_cellActivityTarget_finish")
        end
        self.rewardProgressFrom = self.curProgress or C_NDaysActivityStore.GetInstance():TotalCompletedNum()
        C_AudioManager.Play("Play_SFX_System_UI_SevenDay_PeiPei_Claim")
        Timer.once(delay, function()
          L_GameStore:call(L_GameStore.event.nDayActivityRefreshAnimation, {false})
          C_NDaysActivityStore.GetInstance():ReqNDayReward(rewardType, uid)
        end)
      end
    },
    onClick_Question = function(self)
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end,
    onClick_Tip1 = function(self)
      if C_NDaysActivityStore.GetInstance():GetTotalState() == C_ETotalRewardState.Gaining then
        C_NDaysActivityStore.GetInstance():ReqTotalReward()
        return
      end
      local rewardData = C_NDaysActivityStore.GetInstance():GetRewardItemData()
      L_ItemTplManager:showInfoTip(rewardData[2], rewardData[3])
    end,
    onClick_Tip2 = function(self)
      if C_NDaysActivityStore.GetInstance():GetTotalState() == C_ETotalRewardState.Gaining then
        C_NDaysActivityStore.GetInstance():ReqTotalReward()
        return
      end
      local rewardData = C_NDaysActivityStore.GetInstance():GetRewardItemData()
      L_ItemTplManager:showInfoTip(rewardData[0], rewardData[1])
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {id = 0, isInPanel = false}
end

function this:open()
  L_GameStore:listenCallFunc(L_GameStore.event.nDayActivityRefresh, self.refreshPanel, self)
  L_GameStore:listenCallFunc(L_GameStore.event.nDayActivityRefresh, self.refreshDay, self)
  L_GameStore:listenCallFunc(L_GameStore.event.nDayActivityReqRewardCloseCallBack, self.rewardCloseCallBack, self)
end

function this:setActId(id)
  local descStrs = C_NDaysActivityStore.GetInstance():GetActivitDesc()
  self.bind.txt_Desc = L_WordsTpl:getValue("ui_seven_day_reward_desc", {
    [0] = C_NDaysActivityStore.GetInstance():GetRewardGoalNum(1),
    [1] = descStrs[0],
    [2] = descStrs[1],
    [3] = descStrs[2]
  })
  local soulessenceTpl = L_GameTpl:getSoulessenceTpl()
  local heroTpl = L_GameTpl.getHeroTpl()
  local rewardData = C_NDaysActivityStore.GetInstance():GetRewardItemData()
  local itemId = rewardData[3]
  local heroId = rewardData[1]
  local tpl = soulessenceTpl:getTplById(itemId)
  local tplhero = heroTpl:getTplById(heroId)
  local avatarTexture = soulessenceTpl:getAvatarTexture(tpl, 1)
  self.bind.img_sprit = avatarTexture
  self.bind.txt_reward_hero = heroTpl:getName(tplhero)
  self.bind.txt_reward_spirit = soulessenceTpl:getName(tpl)
  self.data.id = id
  self.tpl = _GameEventTpl:getTplById(self.data.id)
  self.helpGroupId = _GameEventTpl:getHelp(self.tpl)
  if not self.data.isInPanel or self.groupId then
    local tableView = self.bindComponents.tableView
    tableView.FirstFrameLoader.enabled = true
    tableView.FirstFrameLoader.showAnim = "anim_cellActivityTarget_show"
    local init = not self.groupId
    local isEnter = not self.data.isInPanel or not self.groupId
    self:initData(id, init, isEnter, true)
    C_AudioManager.Play("Play_SFX_System_UI_SevenDay_PeiPei_In")
  end
  self.data.isInPanel = true
end

function this:initData(id, isInit, isEnter, isRefreshLine)
  L_GameEventStore:call(L_GameEventStore.event.gameEventMaskClose)
  self.bind.obj_block = false
  local gameEventData = _GameEventStore:getGameEventData(id)
  if not gameEventData then
    errorf("活动", "没有找到对应id的活动数据 id: " .. id)
    return
  end
  if isEnter then
    self.groupId = C_NDaysActivityStore.GetInstance():GetDefaultGroupId()
  end
  local savedGroupId = self.groupId
  self:refreshDay()
  self.groupId = savedGroupId
  self.bind.curDayTabId = self.groupId
  if isEnter then
    self.bindComponents.tableView.gameObject:SetActive(false)
    Timer.once(0.4, function()
      self:refreshView(self.groupId)
    end)
  else
    self:refreshView(self.groupId)
  end
  self:refreshReward(isRefreshLine)
  self:initAllProcessLineFx()
end

function this:refreshDay()
  local dayInfos = C_NDaysActivityStore.GetInstance():GetDayIds()
  local daysCount = dayInfos.Count - 1
  local daysMenu = {}
  for i = 0, daysCount do
    local isLock = C_NDaysActivityStore.GetInstance():GetDayState(dayInfos[i]) == C_EDayState.Lock
    local isComplete = C_NDaysActivityStore.GetInstance():GetDayState(dayInfos[i]) == C_EDayState.Complete
    local day = C_NDaysActivityStore.GetInstance():GetDayByGroupId(dayInfos[i])
    local a, color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    local alphaValue = 1
    if isLock then
      a, color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      alphaValue = 0.3
    end
    if self.groupId == dayInfos[i] then
      a, color = C_ColorUtility.TryParseHtmlString("#4F525D")
      alphaValue = 1
    end
    table.insert(daysMenu, {
      uid = dayInfos[i],
      txtDay = L_WordsTpl:getValue("ui_seven_day_days_num", {
        [0] = tostring(day)
      }),
      activeLock = isLock,
      activeComplete = isComplete,
      reddot = C_NDaysActivityStore.GetInstance():HasRewardByDay(dayInfos[i]),
      color_txt = color,
      alpha = alphaValue
    })
  end
  self.bind.list_day_menu:clear()
  self.bind.list_day_menu:insert_array(daysMenu)
  self:refreshDayTxtColor()
end

function this:refreshDayTxtColor()
  for i = 1, #self.bind.list_day_menu do
    local data = self.bind.list_day_menu:getItemCls(i)
    data:refreshDayState(self.groupId)
  end
end

function this:refreshView(groupId)
  self.bindComponents.tableView.gameObject:SetActive(true)
  local targetItems = C_NDaysActivityStore.GetInstance():GetTargetByGroup(groupId)
  local targetsList = {}
  local targetsCount = targetItems.Count - 1
  for i = 0, targetsCount do
    local targetState = C_NDaysActivityStore.GetInstance():GetTargetStateByTargetId(targetItems[i])
    local jumpID = C_NDaysActivityStore.GetInstance():GetJumpId(targetItems[i])
    local progressing = targetState.state == C_ETargetState.Progressing
    local rewarding = targetState.state == C_ETargetState.Rewarding
    local rewarded = targetState.state == C_ETargetState.Rewarded
    local lock = targetState.state == C_ETargetState.Lock
    local isTop = targetState.isTop
    local interactive = false
    local isGoto = progressing and 0 < jumpID and not lock
    local targetDesc = ""
    local processNum = targetState.progress >= targetState.maxProgress and targetState.maxProgress or targetState.progress
    if progressing then
      targetDesc = _StateDesc[1]
    elseif rewarding then
      targetDesc = _StateDesc[2]
      interactive = true
    elseif rewarded then
      targetDesc = _StateDesc[3]
    end
    table.insert(targetsList, {
      targetId = targetItems[i],
      bgLock = lock,
      targetDescribe_Lock = targetState:GetDesc(),
      targetProgress_Lock = string.format("%s/%s", tostring(processNum), tostring(targetState.maxProgress)),
      bgProgressing = progressing,
      obj_go = isGoto,
      obj_process = not isGoto,
      targetDescribe_processing = targetState:GetDesc(),
      targetProgress_processing = string.format("%s/%s", tostring(processNum), tostring(targetState.maxProgress)),
      bgRewarding = rewarding,
      targetDescribe_reward = targetState:GetDesc(),
      targetProgress_reward = string.format("%s/%s", tostring(processNum), tostring(targetState.maxProgress)),
      bgCompleteing = rewarded,
      targetDescribe_complete = targetState:GetDesc(),
      targetProgress_complete = string.format("%s/%s", tostring(processNum), tostring(targetState.maxProgress)),
      moduleName = "pages/gameAct/nDaysActivity/cellActivityTarget",
      interactiveBtn = interactive,
      jumpId = jumpID,
      obj_Line = isTop,
      fx = false
    })
  end
  self.bind.list_target:clear()
  self.bind.list_target:insert_array(targetsList)
end

function this:refreshReward(isRefreshLine)
  local curProgress = C_NDaysActivityStore.GetInstance():TotalCompletedNum()
  if isRefreshLine then
    self.curProgress = curProgress
    self:refreshProcessLineToValue(curProgress)
  end
  local state = C_NDaysActivityStore.GetInstance():GetTotalState()
  self.bindComponents.darken1:ResetColors()
  self.bindComponents.darken2:ResetColors()
  self.bindComponents.fx_soulesse_canReceive.gameObject:SetActive(false)
  self.bindComponents.fx_hero_canReceive.gameObject:SetActive(false)
  self.bindComponents.go_received1.gameObject:SetActive(false)
  self.bindComponents.go_received2.gameObject:SetActive(false)
  local a = false
  if state == C_ETotalRewardState.Unahieved then
    self.bind.img_reward_hero = _RewardBgImg[1]
    a, self.bind.color_txt_reward_hero = C_ColorUtility.TryParseHtmlString(_RewardTxtHtmlColor[1])
    self.bind.img_reward_spirit = _RewardBgImg[1]
    a, self.bind.color_txt_reward_spirit = C_ColorUtility.TryParseHtmlString(_RewardTxtHtmlColor[1])
  elseif state == C_ETotalRewardState.Gaining then
    self.bindComponents.fx_soulesse_canReceive.gameObject:SetActive(true)
    self.bindComponents.fx_hero_canReceive.gameObject:SetActive(true)
    self.bind.img_reward_hero = _RewardBgImg[2]
    a, self.bind.color_txt_reward_hero = C_ColorUtility.TryParseHtmlString(_RewardTxtHtmlColor[2])
    self.bind.img_reward_spirit = _RewardBgImg[2]
    a, self.bind.color_txt_reward_hero = C_ColorUtility.TryParseHtmlString(_RewardTxtHtmlColor[2])
  else
    self.bindComponents.darken1:SetGray()
    self.bindComponents.darken2:SetGray()
    self.bindComponents.go_received1.gameObject:SetActive(true)
    self.bindComponents.go_received2.gameObject:SetActive(true)
    self.bind.img_reward_hero = _RewardBgImg[1]
    a, self.bind.color_txt_reward_hero = C_ColorUtility.TryParseHtmlString(_RewardTxtHtmlColor[1])
    self.bind.img_reward_spirit = _RewardBgImg[1]
    a, self.bind.color_txt_reward_spirit = C_ColorUtility.TryParseHtmlString(_RewardTxtHtmlColor[1])
  end
end

function this:updateProgressValue(curProgress, triggerFx)
  triggerFx = triggerFx ~= false
  local maxNum = C_NDaysActivityStore.GetInstance():GetRewardGoalNum(1)
  self.bind.txt_progress_cur = tostring(math.floor(curProgress))
  self.bind.txt_progress_max = "/" .. tostring(maxNum)
  self.bindComponents.slider_task.minValue = 0
  self.bindComponents.slider_task.maxValue = maxNum + 5
  if curProgress >= maxNum then
    self.bindComponents.slider_task.value = curProgress + 5
  else
    self.bindComponents.slider_task.value = curProgress
  end
  if triggerFx and self.progress2Fx ~= nil then
    local lastProgress = math.floor(self.lastProgressValue or curProgress)
    local currentProgress = math.floor(curProgress)
    if lastProgress <= currentProgress then
      for progress, fx in pairs(self.progress2Fx) do
        if progress > lastProgress and progress <= currentProgress and L_CommonUtil.isValid(fx) then
          fx.gameObject:SetActive(true)
        end
      end
    end
  end
  self.lastProgressValue = curProgress
end

function this:refreshProcessLineToValue(curProgress, oldProgress, showFx)
  self:updateProgressValue(curProgress, false)
  local maxNum = C_NDaysActivityStore.GetInstance():GetRewardGoalNum(1)
  local lineNum = maxNum / 5
  local tmp = {}
  local rewardFxMap = {}
  local fromProgress = oldProgress and math.floor(oldProgress) or nil
  local toProgress = math.floor(curProgress)
  if showFx and fromProgress and fromProgress < toProgress then
    for progress = fromProgress + 1, toProgress do
      if progress % 5 == 0 then
        rewardFxMap[progress] = true
      end
    end
  end
  for i = 1, lineNum + 1 do
    local taskNum = i * 5
    table.insert(tmp, {
      curProgress = curProgress,
      taskNum = taskNum,
      isShowEndStar = i == lineNum
    })
  end
  self.bind.list_processLine:clear()
  self.bind.list_processLine:insert_array(tmp)
  self:initAllProcessLineFx()
end

function this:initAllProcessLineFx()
  self.progress2Fx = {}
  if self.bind.list_processLine == nil then
    return
  end
  for i = 1, #self.bind.list_processLine do
    local cell = self.bind.list_processLine:getItemCls(i)
    if cell ~= nil and cell.bindComponents ~= nil then
      local progress = cell.taskNum or cell.bind.taskNum or cell.curProgress or cell.bind.curProgress
      local fx = cell.bindComponents.fx_activate
      if progress ~= nil and fx ~= nil then
        fx.gameObject:SetActive(false)
        self.progress2Fx[progress] = fx
      end
    end
  end
end

function this:getProgressTweenCurve()
  local curveHolder = self.bindComponents.progressCurveHolder
  if curveHolder ~= nil and curveHolder.curves ~= nil and curveHolder.curves.Count > 0 then
    return curveHolder.curves[0]
  end
  return nil
end

function this:killProgressTween()
  if self.progressTween then
    self.progressTween:Kill()
    self.progressTween = nil
  end
end

function this:playProgressTween(fromValue, toValue)
  self:killProgressTween()
  fromValue = fromValue or 0
  toValue = toValue or fromValue
  self.lastProgressValue = fromValue
  local delta = math.abs(toValue - fromValue)
  if delta <= 0 or _ProgressTweenSpeed <= 0 then
    self.curProgress = toValue
    self:refreshProcessLineToValue(toValue)
    return
  end
  local duration = delta / _ProgressTweenSpeed
  if duration > _ProgressTweenMaxTime then
    duration = _ProgressTweenMaxTime
  elseif duration < _ProgressTweenMinTime then
    self.curProgress = toValue
    self:refreshProcessLineToValue(toValue)
    return
  end
  self:updateProgressValue(fromValue, false)
  
  local function getter()
    return fromValue
  end
  
  local function setter(value)
    self:updateProgressValue(value)
  end
  
  self.progressTween = DOTween.To(getter, setter, toValue, duration)
  local curve = self:getProgressTweenCurve()
  if curve ~= nil then
    self.progressTween:SetEase(curve)
  else
    self.progressTween:SetEase(Tweening.Ease.Linear)
  end
  self.progressTween:OnComplete(function()
    self.progressTween = nil
    self.curProgress = toValue
    self:updateProgressValue(toValue)
  end)
end

function this:close()
  self.data.isInPanel = false
  self:killProgressTween()
  L_GameStore:unListenCallFunc(L_GameStore.event.nDayActivityRefresh, self.refreshDay)
  L_GameStore:unListenCallFunc(L_GameStore.event.nDayActivityRefresh, self.refreshPanel)
  L_GameStore:unListenCallFunc(L_GameStore.event.nDayActivityReqRewardCloseCallBack, self.rewardCloseCallBack, self)
end

function this:refreshPanel()
  if self.bind.obj_block then
    return
  end
  if not self.data.id or self.data.id == 0 or not self.groupId then
    return
  end
  if self.data.isInPanel then
    local tableView = self.bindComponents.tableView
    tableView.FirstFrameLoader.enabled = false
    self:refreshDay()
    self.bind.curDayTabId = self.groupId
    self:refreshView(self.groupId)
    self:refreshReward(true)
    self:initAllProcessLineFx()
    return
  end
  local tableView = self.bindComponents.tableView
  tableView.FirstFrameLoader.enabled = true
  tableView.FirstFrameLoader.showAnim = "anim_cellActivityTarget_show"
  self:initData(self.data.id, false, false, true)
end

function this:rewardCloseCallBack()
  L_GameStore:call(L_GameStore.event.nDayActivityRefreshAnimation, {true})
  local fromValue = self.rewardProgressFrom or self.curProgress or 0
  local toValue = C_NDaysActivityStore.GetInstance():TotalCompletedNum()
  self.rewardProgressFrom = nil
  self:initData(self.data.id, false, false, false)
  self:refreshEntranceReddot()
  self:playProgressTween(fromValue, toValue)
end

function this:refreshEntranceReddot()
  if not C_NDaysActivityStore.GetInstance():HasRewardAnyDay() then
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, self.data.id)
  end
end

return this
