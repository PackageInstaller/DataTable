local this = class("moduleActivityBanner", G_UIModuleBase)
local WIDTH_CELLACTIVEITY = 523
local DRAG_THRESHOLD_DISTANCE = 260
local MIN_SWIPE_DISTANCE = 50
local commonBannerTpl = L_GameTpl:getCommonBannerTpl()
local commonJumpTpl = L_GameTpl:getCommonJumpTpl()
local gameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    activityConf = {},
    curIndex = 1,
    autoTimer = nil,
    isDragging = false,
    dragStartPos = nil,
    dragDeltaX = 0,
    isMoving = false,
    isTransitioning = false,
    dragMoveNum = 0
  }
  self.funcMap = {
    [1] = self.jumpToSystem,
    [2] = self.jumpToEventSid,
    [3] = self.jumpToNet,
    [4] = function()
    end,
    [5] = self.jumpToGacha
  }
  self.checkOpenMap = {
    [1] = self.checkOpenSystem,
    [2] = self.checkOpenGameEvent,
    [5] = self.checkGachaPool
  }
end

function this.bind()
  return {
    loopListBannerPoint = {
      moduleName = "pages/Main/cellActivityPoint"
    },
    snapToItemIndex = 0,
    cell_current = {
      moduleName = "pages/Main/cellActivity"
    },
    cell_left = {
      moduleName = "pages/Main/cellActivity"
    },
    cell_right = {
      moduleName = "pages/Main/cellActivity"
    },
    active_cur = true,
    active_left = false,
    active_right = false,
    active_module = false
  }
end

function this.methods()
  return {
    onSnapFinished = function(self, index)
      self:openAutoPlay()
    end,
    onDrag = function(self, isDragging)
      if isDragging then
        self:closeAutoPlay()
      end
    end,
    cell_current = {
      onPointerEnter = function(self)
        self.bindComponents.animaHight:Play("highlight")
      end,
      onPointerExit = function(self)
        self.bindComponents.animaHight:Play("normal")
      end
    }
  }
end

function this:hide()
  self.isHide = true
  self:closeAutoPlay()
end

function this:show()
  if self.isHide then
    self.isHide = false
    self.bind.snapToItemIndex = self.realIndex + 1
    self:openAutoPlay()
  end
end

function this:initModule()
  self.realIndex = 0
  self.isHide = false
  self:initBannerData()
  self.updateTimer = Timer.repeated(0.33, self.onScrollBox, self)
  self:openAutoPlay()
  self:initDragFunc()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.initBannerData, self)
end

function this:initDragFunc()
  local scroller = self.bindComponents.scrollBanner
  if scroller then
    function scroller.mOnBeginDragActionWithData(eventData)
      self:onBeginDrag(eventData)
    end
    
    function scroller.mOnDragingActionWithData(eventData)
      self:onDrag(eventData)
    end
    
    function scroller.mOnEndDragActionWithData(eventData)
      self:onEndDrag(eventData)
    end
  end
end

function this:initBannerData()
  local activityConf = {}
  local activityPointList = {}
  for _, tpl in pairs(commonBannerTpl:getAllData()) do
    if commonBannerTpl:getShow(tpl) == 1 then
      local openTime = L_TimeUtil.getDateTimeStamp(commonBannerTpl:getStartTime(tpl))
      local closeTime = L_TimeUtil.getDateTimeStamp(commonBannerTpl:getEndTime(tpl))
      local nowTime = L_TimeUtil.getServerTime()
      local open = true
      if self.checkOpenMap[commonBannerTpl:getType(tpl)] then
        open = self.checkOpenMap[commonBannerTpl:getType(tpl)](self, commonBannerTpl:getParam(tpl))
      end
      if openTime <= nowTime and closeTime >= nowTime and open then
        C_MJLog.LogDebug("当前banner活动开启中，活动id: " .. commonBannerTpl:getId(tpl) .. "该活动开启时间: " .. openTime .. "关闭时间：" .. closeTime .. "当前时间：" .. nowTime, C_ELogModule.Home)
        local bannerId = commonBannerTpl:getId(tpl)
        local bannerType = commonBannerTpl:getType(tpl)
        local bannerParam = commonBannerTpl:getParam(tpl)
        local origCallback = self.funcMap[bannerType]
        table.insert(activityConf, {
          img_activity = commonBannerTpl:getPic(tpl),
          clickBannerCallback = function(cellSelf, param)
            local pageName = self:getPageNameByBannerType(bannerType, param)
            if pageName ~= "" then
              AzurWorld.StatisticPointMgr:DispatchMainPage2(pageName, 5, tostring(bannerId))
            end
            if origCallback then
              origCallback(cellSelf, param)
            end
          end,
          activityId = bannerId,
          order = commonBannerTpl:getOrder(tpl),
          param = bannerParam
        })
        table.insert(activityPointList, {
          activityId = commonBannerTpl:getId(tpl),
          order = commonBannerTpl:getOrder(tpl)
        })
      end
    end
  end
  table.sort(activityConf, function(a, b)
    return a.order < b.order
  end)
  table.sort(activityPointList, function(a, b)
    return a.order < b.order
  end)
  self.data.activityConf = activityConf
  self.bind.active_module = #activityConf ~= 0
  self.bindComponents.trans_imgBanner.gameObject:SetActive(#activityConf ~= 0)
  self.bind.loopListBannerPoint:clear()
  self.bind.loopListBannerPoint:insert_array(1 < #activityPointList and activityPointList or {})
  self:setupInitialState()
end

function this:setupInitialState()
  self.data.curIndex = 1
  if #self.data.activityConf == 0 then
    return
  end
  self:updateAllCellsContent()
  self:setPointListActive()
  self:openAutoPlay()
end

function this:setPointListActive()
  local index = self.data.curIndex
  for i = 1, #self.bind.loopListBannerPoint do
    local id = self.modules.cell_current.bind.activityId
    local active = id == self.bind.loopListBannerPoint:getValue(i, "activityId")
    self.bind.loopListBannerPoint:change(i, {go_active = active})
    local cell = self.bind.loopListBannerPoint:getItemCls(i)
    cell:setBool(active)
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.list_activityPoint)
end

function this:openAutoPlay()
  if self.data.autoTimer or #self.data.activityConf <= 1 then
    return
  end
  
  local function _run()
    if not self.isBind then
      return
    end
    if self.data.isDragging or self.data.isTransitioning then
      return
    end
    self.data.isTransitioning = true
    self:closeAutoPlay()
    local conf = self.data.activityConf
    local total = #conf
    local currentIndex = self.data.curIndex
    local nextIndex = currentIndex % total + 1
    local rightCell = self.modules.cell_right
    self.modules.cell_current:refreshData(conf[nextIndex])
    rightCell:refreshData(conf[currentIndex])
    self.bind.active_right = true
    local anim = self.bindComponents.rightAnim
    local animName = "anim_banner_switch_right"
    local animState = self:getAnimationStateByName(anim, animName)
    if not animState then
      print("错误：自动轮播找不到动画 " .. animName)
      self:onTransitionComplete(1)
      return
    end
    animState.speed = 1
    animState.normalizedTime = 0
    anim:Play(animName)
    Timer.once(animState.length, function()
      if not self.isBind then
        return
      end
      self:onTransitionComplete(1)
    end)
  end
  
  local interval = L_GameTpl:getGameConstTpl():getData("COMMON_BANNER_STAYTIME", L_Const.GameTplType.int) / 1000
  self.data.autoTimer = Timer.repeated(interval, _run)
end

function this:onScrollBox()
  if not self.isBind then
    return
  end
  self:setPointListActive()
end

function this:jumpToSystem(param)
  if string.isEmpty(param) then
    return
  end
  L_JumpMgr:jumpTo(tonumber(param))
end

function this:getPageNameByBannerType(bannerType, param)
  if bannerType == 1 then
    if not string.isEmpty(param) then
      local jumpData = commonJumpTpl:getTplById(tonumber(param))
      return jumpData and jumpData.page or ""
    end
  elseif bannerType == 2 then
    if not string.isEmpty(param) then
      local id = tonumber(param)
      local tpl = gameEventTpl:getTplById(id)
      local eType = gameEventTpl:getType(tpl)
      if eType == L_Const.ActivityType.AT_DAILY_SIGN then
        return "pageActivityNDaySign"
      else
        return "pageGameAct"
      end
    end
  elseif bannerType == 5 then
    return "pageGacha"
  end
  return ""
end

function this:jumpToEventSid(param)
  if string.isEmpty(param) then
    return
  end
  local id = tonumber(param)
  local tpl = gameEventTpl:getTplById(id)
  local eType = gameEventTpl:getType(tpl)
  if eType == L_Const.ActivityType.AT_DAILY_SIGN then
    local sevenDaySignGameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_DAILY_SIGN)
    if sevenDaySignGameEventData and sevenDaySignGameEventData:canParticipateIn() then
      L_UI:open("pageActivityNDaySign", {
        gameEventType = L_Const.ActivityType.AT_DAILY_SIGN
      })
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_completeTask_01"))
      return
    end
  else
    L_UI:open("pageGameAct", {
      gameEventId = tonumber(param)
    })
  end
end

function this:jumpToNet(param)
  local communityUnlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.community)
  if not communityUnlock then
    return
  end
  if string.isEmpty(param) then
    return
  end
  CS.UnityEngine.Application.OpenURL(param)
end

function this:jumpToGacha(param)
  if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.gacha) then
    return
  end
  L_UI:open("pageGacha", {
    jumpParams = {
      tonumber(param)
    }
  })
end

function this:checkOpenSystem(param)
  if string.isEmpty(param) then
    return true
  end
  return L_JumpMgr:checkJumpFuncOpen(tonumber(param))
end

function this:checkOpenGameEvent(param)
  if string.isEmpty(param) then
    return true
  end
  if commonBannerTpl:getIsFake(param) then
    return true
  end
  local activityGameEventData = L_GameEventStore:getGameEventData(tonumber(param))
  if activityGameEventData and activityGameEventData:isShow() then
    return true
  else
    return false
  end
end

function this:checkGachaPool(param)
  if string.isEmpty(param) then
    return true
  end
  local info = C_GachaMgr:GetGachaInfo()
  if info and info.gachaPools then
    for k, v in pairs(info.gachaPools) do
      if v.gachaPool.poolId == tonumber(param) then
        return true
      end
    end
  end
  return false
end

function this:closeAutoPlay()
  if self.data.autoTimer == nil then
    return
  end
  self.data.autoTimer:destroy()
  self.data.autoTimer = nil
end

function this:close()
  this.super.close(self)
  self.isHide = false
  if self.updateTimer ~= nil then
    self.updateTimer:destroy()
    self.updateTimer = nil
  end
  if self.timer1 then
    self.timer1:destroy()
    self.timer1 = nil
  end
  self:closeAutoPlay()
  local scroller = self.bindComponents.scrollBanner
  if scroller then
    scroller.mOnBeginDragActionWithData = nil
    scroller.mOnDragingActionWithData = nil
    scroller.mOnEndDragActionWithData = nil
  end
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.initBannerData, self)
end

function this:onEndDrag(eventData)
  if not self.data.isDragging then
    return
  end
  self.data.isDragging = false
  local direction = 0
  if math.abs(self.data.dragDeltaX) > MIN_SWIPE_DISTANCE then
    if 0 > self.data.dragDeltaX then
      direction = 1
    else
      direction = -1
    end
  end
  self:playTransitionAnimation(direction)
end

function this:onBeginDrag(eventData)
  if self.data.isTransitioning or #self.data.activityConf <= 1 then
    return
  end
  self:closeAutoPlay()
  self.data.isDragging = true
  self.data.dragStartPos = eventData.position
  self.data.dragDeltaX = 0
  if self.data.isTransitioning or #self.data.activityConf <= 1 then
    return
  end
  self.data.isDataSwapped = false
  self.data.dragMoveNum = 0
  local leftAnim = self.bindComponents.leftAnim
  if leftAnim and leftAnim.anim_banner_switch_left then
    leftAnim:Play("anim_banner_switch_left")
    leftAnim.anim_banner_switch_left.speed = 0
  end
  local rightAnim = self.bindComponents.rightAnim
  if rightAnim and rightAnim.anim_banner_switch_right then
    rightAnim:Play("anim_banner_switch_right")
    rightAnim.anim_banner_switch_right.speed = 0
  end
end

function this:onDrag(eventData)
  if not self.data.isDragging then
    return
  end
  self.data.dragDeltaX = eventData.position.x - self.data.dragStartPos.x
  local conf = self.data.activityConf
  local total = #conf
  if total <= 1 then
    return
  end
  local anim, animName, activeCell
  if self.data.dragDeltaX < 0 then
    anim = self.bindComponents.rightAnim
    animName = "anim_banner_switch_right"
    activeCell = self.modules.cell_right
  elseif self.data.dragDeltaX > 0 then
    anim = self.bindComponents.leftAnim
    animName = "anim_banner_switch_left"
    activeCell = self.modules.cell_left
  else
    return
  end
  if not self.data.isDataSwapped then
    local currentIndex = self.data.curIndex
    local targetIndex
    if self.data.dragDeltaX < 0 then
      targetIndex = currentIndex % total + 1
      self.bind.active_right = true
    else
      targetIndex = (currentIndex - 2 + total) % total + 1
      self.bind.active_left = true
    end
    self.modules.cell_current:refreshData(conf[targetIndex])
    activeCell:refreshData(conf[currentIndex])
    self.data.isDataSwapped = true
  end
  local animState = self:getAnimationStateByName(anim, animName)
  if not animState then
    return
  end
  if not anim:IsPlaying(animName) then
    anim:Play(animName)
  end
  animState.speed = 0
  local normalizedTime = math.min(1, math.abs(self.data.dragDeltaX) / DRAG_THRESHOLD_DISTANCE)
  animState.normalizedTime = normalizedTime
end

function this:getAnimationStateByName(animComponent, clipName)
  if not L_CommonUtil.isValid(animComponent) or not clipName then
    return nil
  end
  for _, state in pairs(animComponent) do
    if state and state.name == clipName then
      return state
    end
  end
  return nil
end

function this:playTransitionAnimation(direction)
  self.data.isTransitioning = true
  local anim, animName
  if self.data.dragDeltaX < 0 then
    anim = self.bindComponents.rightAnim
    animName = "anim_banner_switch_right"
  else
    anim = self.bindComponents.leftAnim
    animName = "anim_banner_switch_left"
  end
  local animState = self:getAnimationStateByName(anim, animName)
  if not animState then
    self:onTransitionComplete(direction)
    return
  end
  if direction == 0 then
    animState.speed = -1
    local duration = animState.normalizedTime * animState.length
    self.timer1 = Timer.once(duration, function()
      if not self.isBind then
        return
      end
      if L_UI:getPageStatus(self:getName()) then
        return
      end
      self:onTransitionComplete(0)
    end)
  else
    animState.speed = 1
    local remainingTime = (1 - animState.normalizedTime) * animState.length
    self.timer1 = Timer.once(remainingTime, function()
      if not self.isBind then
        return
      end
      self:onTransitionComplete(direction)
    end)
  end
end

function this:onTransitionComplete(direction)
  if not (self.isBind and L_CommonUtil.isValid(self.bindComponents.leftAnim)) or not L_CommonUtil.isValid(self.bindComponents.rightAnim) then
    return
  end
  local total = #self.data.activityConf
  if direction == 1 then
    self.data.curIndex = self.data.curIndex % total + 1
  elseif direction == -1 then
    self.data.curIndex = (self.data.curIndex - 2 + total) % total + 1
  end
  local leftAnim = self.bindComponents.leftAnim
  if leftAnim then
    leftAnim:Stop()
    for _, state in pairs(leftAnim) do
      state.normalizedTime = 0
    end
  end
  local rightAnim = self.bindComponents.rightAnim
  if rightAnim then
    rightAnim:Stop()
    for _, state in pairs(rightAnim) do
      state.normalizedTime = 0
    end
  end
  self:updateAllCellsContent()
  self.bind.active_left = false
  self.bind.active_right = false
  self.data.isTransitioning = false
  self:openAutoPlay()
end

function this:updateAllCellsContent()
  local conf = self.data.activityConf
  local total = #conf
  if total == 0 then
    return
  end
  local currentIndex = self.data.curIndex
  if currentIndex ~= nil then
    local prevIndex = (currentIndex - 2 + total) % total + 1
    local nextIndex = currentIndex % total + 1
    self.modules.cell_current:refreshData(conf[currentIndex])
    self.modules.cell_left:refreshData(conf[prevIndex])
    self.modules.cell_right:refreshData(conf[nextIndex])
  end
end

return this
