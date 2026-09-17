local this = L_BevTree:registClass("guide.guideClick", L_BevTree.action)
local guideStuckTime = L_GameTpl:getGameConstTpl():getData("GUIDE_SKIP_BUTTON_DISPLAY_TIME", L_Const.GameTplType.int)
local _guideClickPathTpl = L_GameTpl:getGuideClickPathTpl()
local _guideWordsTpl = L_GameTpl:getGuideWordsTpl()
local tag = "guide"

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.guideClickPathId = 0
  self.effectPath = ""
  self.dimension = ""
  self.effectScale = ""
  self.offset = ""
  self.isShowEffectArrow = 0
  self.effectArrowDirection = 0
  self.isOnlyShowEffectArrow = 0
  self.delayPlayTime = 0
  self.headIcon = ""
  self.headDirection = 0
  self.tipsKey = ""
  self.storyTextId = ""
  self.arrowDirection = 0
  self.arrowPos = ""
  self.tipPos = ""
  self.tipOffset = ""
  self.showTime = 0
  self.skipCurTreeAfterShowTime = 0
  self.showKeys = ""
  self.longPressKeys = ""
  self.longPressTime = 0
  self.isHideMask = 0
  self.isListItem = 0
  self.isClickBlock = 0
  self.skipNotSave = 0
  self.useEventTransfer = 0
  self.inputActions = ""
  self.validPages = ""
  self.forceCloseRecoverInputOne = 0
  self.gamepadInputAction = ""
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.guideClickPathId = self:getParam("guideClickPathId", true) or 0
  self.effectPath = self:getParam("effectPath")
  self.effectScale = self:getParam("effectScale")
  self.offset = self:getParam("offset")
  local tempIsShowEffectArrow = self:getParam("isShowEffectArrow", true)
  self.isShowEffectArrow = tempIsShowEffectArrow ~= nil and tempIsShowEffectArrow ~= 0
  self.effectArrowDirection = self:getParam("effectArrowDirection", true) or 0
  local tempIsOnlyShowEffectArrow = self:getParam("isOnlyShowEffectArrow", true)
  self.isOnlyShowEffectArrow = tempIsOnlyShowEffectArrow ~= nil and tempIsOnlyShowEffectArrow ~= 0
  self.isListItem = self:getParam("isListItem", true)
  self.dimension = self:getParam("dimension")
  self.isUseListItem = self:getParam("isListItem", true) ~= 0
  self.isUseEventTransfer = self:getParam("useEventTransfer", true) == 0
  self.delayPlayTime = self:getParam("delayPlayTime", true) or 0
  self.isHideMask = self:getParam("isHideMask", true) ~= 0
  self.arrowDirection = self:getParam("arrowDirection", true) or 4
  self.arrowPos = self:getParam("arrowPos")
  self.tipPos = self:getParam("tipPos")
  self.tipsKey = self:getParam("tipsKey", true) or 0
  self.showKeys = self:getParam("showKeys")
  self.showTime = self:getParam("showTime", true) or 0
  local tempSkipCurTreeAfterShowTime = self:getParam("skipCurTreeAfterShowTime", true) or 0
  self.skipCurTreeAfterShowTime = 0 < tempSkipCurTreeAfterShowTime
  self.longPressKeys = self:getParam("longPressKeys")
  self.longPressTime = self:getParam("longPressTime", true) or 0
  self.delayTime = self:getParam("delayTime", true) or 0
  self.inputActions = self:getParam("inputActions")
  self.isClickBlock = self:getParam("isClickBlock", true)
  self.isClickBlock = self.isClickBlock ~= 0 and self.isClickBlock ~= nil
  self.isDestroy = false
  self.validPages = self:getParam("validPages") or ""
  self.skipNotSave = self:getParam("skipNotSave", true) or 0
  self.tipOffset = self:getParam("tipOffset")
  self.headDirection = self:getParam("headDirection", true) or 0
  self.storyTextId = self:getParam("storyTextId")
  self.headIcon = self:getParam("headIcon")
  self.forceCloseRecoverInputOne = self:getParam("forceCloseRecoverInputOne", true) ~= 0
  self.gamepadInputAction = self:getParam("gamepadInputAction")
end

function this:logFailure(reason)
  if self.failureLogged or tonumber(self.tree.param.guideId) ~= 30023 then
    return
  end
  self.failureLogged = true
  local pageOpen = not string.isEmpty(self.pageName) and L_UI:checkPageOpen(self.pageName)
  local parentValid = self.parentTrans ~= nil and L_CommonUtil.isValid(self.parentTrans)
  local effectValid = self.effectGameObject ~= nil and L_CommonUtil.isValid(self.effectGameObject)
  C_MJLog.LogInfo(string.format("[GuideRace] event=guideClickFailure guideId=%s nodeId=%s reason=%s pageName=%s targetPath=%s pageOpen=%s loadingOpen=%s parentValid=%s effectValid=%s waitClick=%s waitDelay=%s isDestroy=%s", tostring(self.tree.param.guideId), tostring(self.id), tostring(reason), tostring(self.pageName), tostring(self.targetPath), tostring(pageOpen), tostring(L_UI:checkPageOpen("loading")), tostring(parentValid), tostring(effectValid), tostring(self.waitClick), tostring(self.waitDelay), tostring(self.isDestroy)), C_ELogModule.Guide)
end

function this:onEnter()
  self.failureLogged = false
  if self.isDestroy then
    self:logFailure("alreadyDestroyedOnEnter")
    self.result = L_BevTree.taskResult.Failure
    return
  end
  if self.guideClickPathId > 0 then
    local guideClickPathTpl = _guideClickPathTpl:getTplById(self.guideClickPathId)
    if guideClickPathTpl ~= nil then
      self.targetPath = _guideClickPathTpl:getPath(guideClickPathTpl)
    end
  end
  self.lastStuck = false
  self.result = L_BevTree.taskResult.Running
  self.parentTrans = nil
  self.waitClick = false
  self.waitDelay = false
  self.submitInit = false
  self:blockAllAction()
  self:dealDetectKeys()
  self.curCheckTime = C_Time.time
  C_MJLog.LogInfo(string.format("[GuideSkip] source=guideClick.onEnter guideId=%s isShow=false skipNotSave=nil reason=enter pageName=%s targetPath=%s", tostring(self.tree.param.guideId), tostring(self.pageName), tostring(self.targetPath)), C_ELogModule.Guide)
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
    guideId = self.tree.param.guideId,
    isShow = false
  })
end

function this:dealDetectKeys()
  local tips = _guideWordsTpl:getWords(self.tipsKey)
  self.isDetectLongPress = not string.isEmpty(self.longPressKeys) and self.longPressTime > 0
  self.isDetectKeys = not string.isEmpty(self.showKeys)
  self.validPages = string.split(self.validPages, "|")
  table.insert(self.validPages, self.pageName)
  self.tempPressKeys = string.split(self.showKeys, "|")
  self:initKeyboardKeys()
  if not string.isEmpty(self.gamepadInputAction) then
    self.gamepadkey = self.gamepadInputAction
  elseif not table.isEmpty(self.tempPressKeys) and not string.isEmpty(self.tempPressKeys[1]) then
    self.gamepadkey = self.tempPressKeys[1]
  else
    self.gamepadkey = self.longPressKeys
  end
  self.showTipData = {
    showTips = tips,
    showKeys = self.pressKeys or {},
    longPressKey = self.longPressKeysName,
    showTime = self.showTime,
    showEndTime = self.showTime + L_TimeUtil:getServerTime(),
    tipPos = self.tipPos,
    arrowDirection = self.arrowDirection,
    arrowPos = self.arrowPos,
    showPageName = self.pageName,
    validPages = self.validPages,
    tipOffset = self.tipOffset,
    headDirection = self.headDirection,
    storyTextId = self.storyTextId,
    headIcon = self.headIcon,
    gamepadkey = self.gamepadkey
  }
end

function this:checkUIShow()
  local isShow = L_GuideManager:checkCurrentAllPages(self.validPages)
  if L_CommonUtil.isValid(self.effectGameObject) then
    self.validPages = self.validPages or {}
    if self.lastIsShow ~= isShow then
      self.effectGameObject:SetActive(isShow)
    end
    self.lastIsShow = isShow
  end
  local isStuck = not self.isHideMask and C_Time.time - self.curCheckTime >= guideStuckTime
  if isStuck ~= self.lastStuck then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=guideClick.checkUIShow guideId=%s isShow=%s skipNotSave=%s elapsed=%s threshold=%s targetPagesReady=%s isHideMask=%s pageName=%s targetPath=%s inputActions=%s", tostring(self.tree.param.guideId), tostring(isStuck), tostring(self.skipNotSave), tostring(C_Time.time - self.curCheckTime), tostring(guideStuckTime), tostring(isShow), tostring(self.isHideMask), tostring(self.pageName), tostring(self.targetPath), tostring(self.inputActions)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
      skipNotSave = self.skipNotSave,
      guideId = self.tree.param.guideId,
      isShow = isStuck
    })
    if not isStuck then
      self:dealHighInputAction()
    end
  end
  self.lastStuck = isStuck
  if not isShow then
    return
  end
  self:checkClickStuck()
  self:checkControlSchemeChange()
end

function this:checkClickStuck()
  if not L_GuideManager:checkPageOpen(self.pageName) then
    return
  end
  local page = L_UI:getPage(self.pageName)
  if page == nil or page.gameObject == nil then
    return
  end
  self.parentTrans = self:getParentTrans(page)
  if self.parentTrans == nil then
    return
  end
  if not self.parentTrans.gameObject.activeInHierarchy or not self.parentTrans.gameObject.activeSelf then
    return
  end
  self.curCheckTime = C_Time.time
end

function this:execute()
  if string.isEmpty(self.effectPath) then
    printf(tag, "特效路径是空的forceClick必须配合特效使用  ID: " .. self.id)
    self:logFailure("effectPathEmpty")
    self.result = L_BevTree.taskResult.Failure
  end
  if string.find(self.effectPath, "pre_keyboardEffect") then
    printf(tag, "@guide pre_keyboardEffect没有适配多平台，需要开启使用联系相关程序")
    self:logFailure("unsupportedKeyboardEffect")
    self.result = L_BevTree.taskResult.Failure
  end
  if self.waitSkipCurTree then
    return self.result
  end
  self:checkWaitResult()
  if self.result == L_BevTree.taskResult.Success or self.result == L_BevTree.taskResult.Failure then
    return self.result
  end
  if self.waitSuccess or self.waitFailure then
    return self.result
  end
  if self.result == L_BevTree.taskResult.Running then
    self:checkUIShow()
  end
  if self.waitClick then
    if not L_CommonUtil.isValid(self.effectGameObject) and not self.waitDelay then
      self:dealClickFinished(true)
    end
    if self.startCheckInput then
      self:dealDetectInputAction()
    end
    return self.result
  end
  local page = L_UI:getPage(self.pageName)
  if L_GuideManager:checkPageOpen(self.pageName) then
    self.parentTrans = self:getParentTrans(page)
  else
    L_UI:setTempTopGuideMask(false)
    return L_BevTree.taskResult.Running
  end
  if L_GuideManager:isPlayingEnterAnimation(page) then
    if not self.isPlayingAnimation and not self.isDestroy then
      L_UI:setTempTopGuideMask(true)
    end
    self.isPlayingAnimation = true
    self.result = L_BevTree.taskResult.Running
    return L_BevTree.taskResult.Running
  end
  if not L_CommonUtil.isValid(self.parentTrans) then
    self.result = L_BevTree.taskResult.Running
    L_UI:setTempTopGuideMask(false)
    return L_BevTree.taskResult.Running
  end
  if not self.parentTrans.gameObject.activeInHierarchy or not self.parentTrans.gameObject.activeSelf then
    self.result = L_BevTree.taskResult.Running
    L_UI:setTempTopGuideMask(false)
    return L_BevTree.taskResult.Running
  end
  self.waitClick = true
  self.waitDelay = true
  L_UI:setTempTopGuideMask(true)
  if self.delayPlayTime ~= nil and self.delayPlayTime > 0 then
    C_InputManager.EnableHighLevelControl({}, nil)
  end
  Timer.once(self.delayPlayTime, function()
    L_UI:setTempTopGuideMask(false)
    if self.delayPlayTime ~= nil and self.delayPlayTime > 0 and not self:dealHighInputAction() then
      C_InputManager.DisableHighLevelControl()
    end
    if self.result == L_BevTree.taskResult.Failure then
      return self.result
    end
    self:dealEffect()
    self:dealArrowEffect()
    self:dealHighInputAction()
    self.waitDelay = false
    self.isPlayingAnimation = false
    self.startCheckInput = true
  end, self)
  if self.refreshTimer == nil then
    self.refreshTimer = Timer.repeated(0.1, function()
      self:updateEffect()
    end)
  end
  return self.result
end

function this:skipCurTree()
  if not L_GuideManager:isOnDebugMode() then
    L_GuideManager:saveStepId(self.tree.param.guideId, 0)
  else
    L_GuideManager:clearAllControl()
    L_GuideManager:forceEndGuide(self.tree.param.guideId)
  end
end

function this:dealShowGuideClickTips(effectGameObject, dimension)
  if not self.showTipData or string.isEmpty(self.showTipData.showTips) and string.isEmpty(self.showTipData.storyTextId) then
    return
  end
  if not L_CommonUtil.isValid(self.parentTrans) then
    return
  end
  self.showTipData.parentTrans = self.parentTrans
  self.showTipData.effectGameobject = effectGameObject
  self.showTipData.effectSize = dimension
  L_UI:open("pageGuideClickTips", self.showTipData)
end

function this:dealDetectInputAction()
  if self.result == L_BevTree.taskResult.Success or self.result == L_BevTree.taskResult.Failure then
    return
  end
  if not self.waitClick then
    return
  end
  if not self.waitAction and self.showTime ~= nil and self.showTime > 0 then
    self.waitAction = true
    self:disposeTimer()
    self.showTimer = Timer.once(self.showTime, function()
      self.waitAction = false
      if self.skipCurTreeAfterShowTime then
        self.waitSkipCurTree = true
        self:skipCurTree()
        return
      end
      if self.isHideMask then
        self.waitFailure = true
      else
        self.waitSuccess = true
      end
    end)
  end
  local keyCorrect = false
  if self.isDetectKeys then
    keyCorrect = L_GuideManager:isInputActionTriggered()
  end
  if self.isDetectLongPress then
    keyCorrect = keyCorrect or false
  end
  if not keyCorrect and C_InputManager.IsEnableGamePad and not string.isEmpty(self.gamepadInputAction) then
    keyCorrect = L_GuideManager:isInputActionTriggered()
  end
  if keyCorrect then
    self.waitSuccess = true
    self.bSendEvent = true
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideClickInputChecked)
  end
end

function this:disposeTimer()
  if self.showTimer ~= nil then
    Timer.remove(self.showTimer)
    self.showTimer = nil
  end
end

function this:closeRefreshTimer()
  if not self.refreshTimer then
    return
  end
  self.refreshTimer:destroy()
  self.refreshTimer = nil
end

function this:dealEffect()
  if self.result == L_BevTree.taskResult.Failure then
    return
  end
  if self.isDestroy then
    return
  end
  local page = L_UI:getPage(self.pageName)
  if page == nil then
    self:logFailure("pageMissingBeforeEffect")
    self.result = L_BevTree.taskResult.Failure
    return
  end
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.effectScale, self.dimension, self.offset, self.parentTrans)
  local board = page.gameObject.transform:Find("board") or page.gameObject.transform:Find("Board")
  board = board or page.gameObject.transform
  self.effectGameObject = L_EffectUtil.playEffect(self.effectPath, board, scale, offset, dimension, targetWorldPosition, targetRotation)
  if L_CommonUtil.isValid(self.effectGameObject) and not self.isDestroy then
    local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
    if guideFxManager then
      self.scrollRect = self.parentTrans.gameObject:GetComponentInParent(typeof(C_LScrollRect))
      self.scrollView = self.parentTrans.gameObject:GetComponentInParent(typeof(CS.UnityEngine.UI.ScrollRect))
      self:setScrollDisable(true)
      self:changeLongPressStatus(false)
      guideFxManager.useMask = not self.isHideMask
      guideFxManager.useEventTransfer = self.isUseEventTransfer
      if self.isClickBlock then
        guideFxManager:InitGuide()
      else
        guideFxManager:InitGuide(self.parentTrans.gameObject)
      end
      self.finishCallback = self.finishCallback or handler(self, self.dealClickFinished)
      guideFxManager:RemoveClickCheckHandler(self.finishCallback)
      guideFxManager:AddClickCheckHandler(self.finishCallback)
    end
  end
  if not self.isHideMask and not self.isDestroy then
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = true})
  end
  self:dealShowGuideClickTips(self.effectGameObject, dimension)
end

function this:dealArrowEffect()
  if self.effectGameObject == nil then
    return
  end
  L_EffectUtil.setArrowEffectParams(self.effectGameObject, self.isShowEffectArrow, self.effectArrowDirection, self.isOnlyShowEffectArrow)
end

function this:updateEffect()
  if not (self.parentTrans ~= nil and self.effectGameObject ~= nil and L_CommonUtil.isValid(self.effectGameObject)) or self.isDestroy then
    return
  end
  if not L_CommonUtil.isValid(self.parentTrans) then
    self:logFailure("targetDestroyed")
    self.result = L_BevTree.taskResult.Failure
    return
  end
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.effectScale, self.dimension, self.offset, self.parentTrans)
  L_EffectUtil.setEffectParams(self.effectGameObject, scale, offset, dimension, targetWorldPosition, targetRotation)
  local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
  if guideFxManager ~= nil then
    guideFxManager:ResetMask()
  end
end

function this:changeLongPressStatus(status)
  C_LButton.GlobalLongInteractable = status
end

function this:setScrollDisable(disable)
  if L_CommonUtil.isValid(self.scrollRect) then
    self.scrollRect.disableScroll = disable
  end
  if L_CommonUtil.isValid(self.scrollView) then
    self.scrollView.enabled = not disable
  end
end

function this:dealClickFinished(isDestroy)
  if self.isClickBlock then
    return
  end
  if isDestroy then
    self:logFailure("effectDestroyed")
    self.result = L_BevTree.taskResult.Failure
    if L_UI:checkPageOpen("pageGuideClickTips") then
      L_UI:close("pageGuideClickTips")
    end
  else
    self.waitSuccess = true
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideClickPass)
  end
end

function this:checkWaitResult()
  if not self.waitSuccess and not self.waitFailure then
    return
  end
  if not L_UI:checkPageOpen("pageGuideClickTips") then
    if self.waitSuccess then
      self.result = L_BevTree.taskResult.Success
    end
    if self.waitFailure then
      self:logFailure("waitFailure")
      self.result = L_BevTree.taskResult.Failure
    end
  end
end

function this:onReset()
  self.isDestroy = true
  if self.lastResult == L_BevTree.taskResult.Running then
    self:logFailure("treeReset")
  end
  self.bSendEvent = false
  self.result = L_BevTree.taskResult.Failure
  self:dealDestroy()
  self:disposeTimer()
end

function this:onDestroy()
  self.isDestroy = true
  self:doDestroy()
end

function this:doDestroy()
  self:dealDestroy()
  C_MJLog.LogInfo(string.format("[GuideSkip] source=guideClick.doDestroy guideId=%s isShow=false skipNotSave=nil reason=destroy pageName=%s targetPath=%s", tostring(self.tree.param.guideId), tostring(self.pageName), tostring(self.targetPath)), C_ELogModule.Guide)
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
    guideId = self.tree.param.guideId,
    isShow = false
  })
  if not self.isHideMask then
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
  end
end

function this:onFinish()
  self.isDestroy = true
  self:doDestroy()
end

function this:dealDestroy()
  if L_CommonUtil.isValid(self.effectGameObject) and self.isDestroy then
    C_GameObject.DestroyImmediate(self.effectGameObject.gameObject)
  end
  if not self.bSendEvent and L_UI:checkPageOpen("pageGuideClickTips") then
    L_UI:close("pageGuideClickTips")
  end
  self.bSendEvent = false
  L_GuideManager:clearInputAction()
  self:setScrollDisable(false)
  self:changeLongPressStatus(true)
  L_UI:setTempTopGuideMask(false)
  self:closeRefreshTimer()
  self:dealDisableHighInputAction()
end

function this:blockAllAction()
  if not self.isHideMask then
    C_InputManager.EnableHighLevelControl({}, nil)
  end
end

function this:dealHighInputAction()
  if self.isDestroy then
    return
  end
  if not string.isEmpty(self.gamepadInputAction) and C_InputManager.IsEnableGamePad then
    local actions = {}
    table.insert(actions, self.gamepadInputAction)
    C_InputManager.EnableHighLevelControl(actions, nil)
    return true
  end
  if not string.isEmpty(self.inputActions) and not self.isHideMask then
    local actions = string.split(self.inputActions, "|")
    C_InputManager.EnableHighLevelControl(actions, nil)
    return true
  end
  if string.isEmpty(self.inputActions) and not self.isHideMask and not self.forceCloseRecoverInputOne then
    C_InputManager.DisableHighLevelControl()
  end
  return false
end

function this:dealDisableHighInputAction()
  if not self.isHideMask and not string.isEmpty(self.inputActions) and not self.forceCloseRecoverInputOne then
    C_InputManager.DisableHighLevelControl()
  end
  if string.isEmpty(self.inputActions) and not string.isEmpty(self.gamepadInputAction) then
    C_InputManager.DisableHighLevelControl()
  end
end

function this:getParentTrans(page)
  local parentTrans
  if self.isUseListItem then
    parentTrans = self.tree.targetListItem.transform
  elseif string.isEmpty(self.targetPath) then
    parentTrans = page.transform
  else
    parentTrans = page.gameObject.transform:Find(self.targetPath)
  end
  return parentTrans
end

function this:initKeyboardKeys()
  if C_InputManager.IsEnableGamePad or self.isInitKeyboard then
    return
  end
  self.pressKeys = {}
  if self.isDetectKeys then
    L_GuideManager:registerInputAction(self.tempPressKeys)
    printf(tag, "@guide listen events, presskey: " .. tostring(self.showKeys))
    for _, key in ipairs(self.tempPressKeys) do
      if not string.isEmpty(key) then
        local action = C_InputManager.GetAction(key)
        local str = ""
        if action ~= nil then
          str = C_InputManager.GetActionName(action)
          printf(tag, "@guide action name: " .. tostring(str))
        end
        if str ~= "" then
          table.insert(self.pressKeys, str)
        end
      end
    end
  end
  self.longPressKeysName = ""
  if self.isDetectLongPress then
    L_GuideManager:registerLongInputAction(self.longPressKeys)
    local action = C_InputManager.GetAction(self.longPressKeys)
    local str = ""
    if action ~= nil then
      str = C_InputManager.GetActionName(action)
      printf(tag, "@guide action name: " .. tostring(str))
    end
    if str ~= "" then
      self.longPressKeysName = str
    end
    printf(tag, "@guide listen events, long presskey: " .. tostring(self.longPressKeys) .. "long press time: " .. tostring(self.longPressTime))
  end
  self.isInitKeyboard = true
end

function this:checkControlSchemeChange()
  if self.enableGamepad == C_InputManager.IsEnableGamePad then
    return
  end
  if not L_UI:checkPageOpen(self.pageName) then
    return
  end
  if self.parentTrans == nil then
    return
  end
  if not string.isEmpty(self.inputActions) and string.isEmpty(self.gamepadInputAction) and not self.isClickBlock then
    local inputAction = C_InputManager.GetAction(self.gamepadkey)
    if not C_InputManager.HasGamepadInputBinding(inputAction) then
      self.gamepadkey = "Submit"
      self.gamepadInputAction = "Submit"
      self.showTipData.gamepadkey = self.gamepadkey
    end
  end
  if self.gamepadInputAction == "Submit" and not self.submitInit and L_CommonUtil.isValid(self.effectGameObject) then
    local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
    if guideFxManager then
      guideFxManager:InitSubmitForGamepad(self.parentTrans.gameObject)
      self.submitInit = true
    end
  end
  if not L_UI:checkPageOpen("pageGuideClickTips") then
    return
  end
  if C_InputManager.IsEnableGamePad then
    local tempTb = {}
    table.insert(tempTb, self.gamepadkey)
    L_GuideManager:registerInputAction(tempTb)
  elseif self.isDetectKeys and not table.isEmpty(self.tempPressKeys) then
    L_GuideManager:registerInputAction(self.tempPressKeys)
  end
  self:dealHighInputAction()
  local needInitKeyboard = false
  if not self.isInitKeyboard then
    self:initKeyboardKeys()
    if self.isInitKeyboard then
      needInitKeyboard = true
      self.showTipData.showKeys = self.pressKeys
      self.showTipData.longPressKey = self.longPressKeysName
    end
  end
  local tips = _guideWordsTpl:getWords(self.tipsKey)
  self.showTipData.showTips = tips
  local page = L_UI:getPage("pageGuideClickTips")
  page:refreshNormalTipsInfo(self.showTipData, needInitKeyboard)
  self.enableGamepad = C_InputManager.IsEnableGamePad
end

return this
