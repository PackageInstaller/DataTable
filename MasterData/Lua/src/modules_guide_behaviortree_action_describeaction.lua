local this = L_BevTree:registClass("guide.describeAction", L_BevTree.action)
local _guideClickPathTpl = L_GameTpl:getGuideClickPathTpl()
local guideStuckTime = L_GameTpl:getGameConstTpl():getData("GUIDE_SKIP_BUTTON_DISPLAY_TIME", L_Const.GameTplType.int)

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
  self.arrowDirection = 5
  self.wordsIds = ""
  self.storyTextIds = ""
  self.bubbleArrowDirection = 0
  self.bubbleArrowPos = ""
  self.alignTip = 1
  self.tipOffset = ""
  self.tipPos = ""
  self.isUseMask = 0
  self.isListItem = 0
  self.inputActions = ""
  self.validPages = ""
  self.forceCloseRecoverInputOne = 0
  self.gamepadOffset = ""
  self.gamepadNoUseSubmit = 0
  self.gamepadText = ""
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
  self.delayPlayTime = self:getParam("delayPlayTime", true) or 0
  self.isUseMask = self:getParam("isUseMask", true) ~= 0
  self.tipPos = self:getParam("tipPos")
  if string.isEmpty(self.tipPos) then
    self.tipPos = "0|0"
  end
  self.tipOffset = self:getParam("tipOffset") or ""
  self.delayTime = self:getParam("delayTime", true) or 0
  self.inputActions = self:getParam("inputActions")
  self.storyTextIds = self:getParam("storyTextIds")
  self.wordsIds = self:getParam("wordsIds")
  self.headIcon = self:getParam("headIcon")
  self.isDestroy = false
  self.validPages = self:getParam("validPages") or ""
  self.arrowDirection = self:getParam("arrowDirection", true) or 5
  self.bubbleArrowDirection = self:getParam("bubbleArrowDirection", true) or 4
  self.bubbleArrowPos = self:getParam("bubbleArrowPos")
  self.alignTip = self:getParam("alignTip", true) ~= 0
  self.validPages = string.split(self.validPages, "|")
  local tempForceCloseRecoverInputOne = self:getParam("forceCloseRecoverInputOne", true)
  self.forceCloseRecoverInputOne = tempForceCloseRecoverInputOne and tempForceCloseRecoverInputOne ~= 0
  table.insert(self.validPages, self.pageName)
  local gamepadOffset = self:getParam("gamepadOffset")
  if string.isEmpty(gamepadOffset) then
    self.gamepadOffset = "0|-100"
  else
    self.gamepadOffset = gamepadOffset
  end
  local gamepadNoUseSubmit = self:getParam("gamepadNoUseSubmit", true)
  if gamepadNoUseSubmit and gamepadNoUseSubmit ~= 0 then
    self.gamepadInputKey = C_InputManager_KeyType.EBack
    self.gamepadInputAction = "UI/Cancel"
  else
    self.gamepadInputKey = C_InputManager_KeyType.ESubmit
    self.gamepadInputAction = "UI/Submit"
  end
  local gamepadText = self:getParam("gamepadText")
  if string.isEmpty(gamepadText) then
    self.gamepadText = "ui_shortcut_text_continue"
  else
    self.gamepadText = gamepadText
  end
end

function this:onEnter()
  if self.isDestroy then
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
  self:blockAllAction()
  self.curCheckTime = C_Time.time
  self.logMsgTable = {}
  C_MJLog.LogInfo(string.format("[GuideSkip] source=describeAction.onEnter guideId=%s isShow=false skipNotSave=nil reason=enter pageName=%s targetPath=%s", tostring(self.tree.param.guideId), tostring(self.pageName), tostring(self.targetPath)), C_ELogModule.Guide)
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
    guideId = self.tree.param.guideId,
    isShow = false
  })
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
  local isStuck = self.isUseMask and C_Time.time - self.curCheckTime >= guideStuckTime
  if isStuck ~= self.lastStuck then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=describeAction.checkUIShow guideId=%s isShow=%s skipNotSave=%s elapsed=%s threshold=%s targetPagesReady=%s isUseMask=%s pageName=%s targetPath=%s inputActions=%s", tostring(self.tree.param.guideId), tostring(isStuck), tostring(self.skipNotSave), tostring(C_Time.time - self.curCheckTime), tostring(guideStuckTime), tostring(isShow), tostring(self.isUseMask), tostring(self.pageName), tostring(self.targetPath), tostring(self.inputActions)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
      skipNotSave = self.skipNotSave,
      guideId = self.tree.param.guideId,
      isShow = isStuck
    })
    C_MJLog.LogError(table.concat(self.logMsgTable, "\n"), C_ELogModule.Guide)
    if not isStuck then
      self:dealHighInputAction()
    end
  end
  self.lastStuck = isStuck
  if not isShow then
    return
  end
  self:checkClickStuck()
end

function this:checkClickStuck()
  local result, errorMsg = L_GuideManager:checkPageOpen(self.pageName)
  if result == false then
    self.logMsgTable = {}
    table.insert(self.logMsgTable, "describeAction.lua checkClickStuck: checkPageOpen Fail")
    table.insert(self.logMsgTable, tostring(C_Time.time))
    table.insert(self.logMsgTable, errorMsg)
    return
  end
  local page = L_UI:getPage(self.pageName)
  if page == nil or page.gameObject == nil then
    self.logMsgTable = {}
    table.insert(self.logMsgTable, "describeAction.lua checkClickStuck: getPage Fail")
    table.insert(self.logMsgTable, tostring(C_Time.time))
    return
  end
  local parent = self:getParentTrans(page)
  if parent == nil then
    self.logMsgTable = {}
    table.insert(self.logMsgTable, "describeAction.lua checkClickStuck: getParentTrans Fail")
    table.insert(self.logMsgTable, tostring(C_Time.time))
    return
  end
  if not parent.gameObject.activeInHierarchy or not parent.gameObject.activeSelf then
    self.logMsgTable = {}
    table.insert(self.logMsgTable, "describeAction.lua checkClickStuck: parent.gameObject.active is false")
    table.insert(self.logMsgTable, tostring(C_Time.time))
    return
  end
  self.curCheckTime = C_Time.time
end

function this:execute()
  if string.isEmpty(self.effectPath) then
    printf("guide提示", "特效路径是空的describeAction必须配合特效使用  ID: " .. self.id)
    self.result = L_BevTree.taskResult.Failure
  end
  if self.result == L_BevTree.taskResult.Success or self.result == L_BevTree.taskResult.Failure then
    return self.result
  end
  if self.result == L_BevTree.taskResult.Running then
    self:checkUIShow()
  end
  if self.waitClick then
    if not L_CommonUtil.isValid(self.effectGameObject) and not self.waitDelay then
      self:dealClickFinished(true)
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
  if L_UI:checkPagePlayingAnim(page) then
    if not self.isPlayingAnimation then
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
  self.delayTimer = Timer.once(self.delayPlayTime, function()
    self.delayTimer = nil
    if self.isDestroy then
      return
    end
    L_UI:setTempTopGuideMask(false)
    if self.delayPlayTime ~= nil and self.delayPlayTime > 0 and not self:dealHighInputAction() then
      C_InputManager.DisableHighLevelControl()
    end
    if self.result == L_BevTree.taskResult.Failure then
      return self.result
    end
    self:dealEffect()
    self:dealArrowEffect()
    self:dealShowGuideClickTips(self.effectGameObject, self.effectDimension)
    self:dealHighInputAction()
    self.waitDelay = false
    self.isPlayingAnimation = false
  end, self)
  if self.refreshTimer == nil then
    self.refreshTimer = Timer.repeated(0.1, function()
      self:updateEffect()
    end)
  end
  return self.result
end

function this:dealShowGuideClickTips(effectGameObject, effectSize)
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = true})
  if not L_CommonUtil.isValid(self.parentTrans) then
    return
  end
  if self.isDestroy then
    return
  end
  self.finishCallback = self.finishCallback or handler(self, self.dealClickFinished)
  self.showTipData = {
    parentTrans = self.parentTrans,
    effectGameobject = effectGameObject,
    effectSize = effectSize,
    isDescribeAction = true,
    tipPos = self.alignTip and self.tipPos or string.empty,
    validPages = self.validPages,
    headIcon = self.headIcon,
    storyTextIds = self.storyTextIds,
    wordsIds = self.wordsIds,
    finishCallback = self.finishCallback,
    headDirection = self.arrowDirection > 4 and self.arrowDirection - 4 or 0,
    arrowDirection = self.alignTip and self.arrowDirection or self.bubbleArrowDirection,
    arrowPos = self.bubbleArrowPos,
    tipOffset = self.tipOffset,
    gamepadOffset = self.gamepadOffset,
    gamepadInputKey = self.gamepadInputKey,
    gamepadInputAction = self.gamepadInputAction,
    gamepadText = self.gamepadText
  }
  L_UI:open("pageGuideClickTips", self.showTipData)
end

function this:disposeTimer()
  if self.showTimer ~= nil then
    Timer.remove(self.showTimer)
    self.showTimer = nil
  end
  if self.delayTimer ~= nil then
    Timer.remove(self.delayTimer)
    self.delayTimer = nil
  end
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
    self.result = L_BevTree.taskResult.Failure
    return
  end
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.effectScale, self.dimension, self.offset, self.parentTrans)
  local board = page.gameObject.transform:Find("board") or page.gameObject.transform:Find("Board")
  board = board or page.gameObject.transform
  local parentRect = self.parentTrans:GetComponent(typeof(C_RectTransform))
  local _pivot = parentRect.pivot
  local _size = parentRect.rect.size
  local _centerOffset = C_Vector3((0.5 - _pivot.x) * _size.x, (0.5 - _pivot.y) * _size.y, 0)
  local targetWorldPosition = parentRect:TransformPoint(_centerOffset)
  self.effectGameObject = L_EffectUtil.playEffect(self.effectPath, board, scale, offset, dimension, targetWorldPosition, targetRotation)
  self.effectDimension = dimension
  if L_CommonUtil.isValid(self.effectGameObject) and not self.isDestroy then
    local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
    if guideFxManager then
      guideFxManager.useMask = self.isUseMask
      guideFxManager.useEventTransfer = false
      guideFxManager:InitGuide()
    end
  end
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
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.effectScale, self.dimension, self.offset, self.parentTrans)
  local parentRect = self.parentTrans:GetComponent(typeof(C_RectTransform))
  local _pivot = parentRect.pivot
  local _size = parentRect.rect.size
  local _centerOffset = C_Vector3((0.5 - _pivot.x) * _size.x, (0.5 - _pivot.y) * _size.y, 0)
  local targetWorldPosition = parentRect:TransformPoint(_centerOffset)
  L_EffectUtil.setEffectParams(self.effectGameObject, scale, offset, dimension, targetWorldPosition, targetRotation)
  local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
  if guideFxManager ~= nil then
    guideFxManager:ResetMask()
  end
end

function this:closeRefreshTimer()
  if not self.refreshTimer then
    return
  end
  self.refreshTimer:destroy()
  self.refreshTimer = nil
end

function this:dealClickFinished(isDestroy)
  if self.isClickBlock then
    return
  end
  if isDestroy then
    self.result = L_BevTree.taskResult.Failure
  else
    self.result = L_BevTree.taskResult.Success
  end
  if L_UI:checkPageOpen("pageGuideClickTips") then
    L_UI:close("pageGuideClickTips")
  end
end

function this:onReset()
  self.isDestroy = true
  self.result = L_BevTree.taskResult.Failure
  self:dealDestroy()
  self:disposeTimer()
end

function this:onDestroy()
  self:doDestroy()
end

function this:doDestroy()
  self:dealDestroy()
  C_MJLog.LogInfo(string.format("[GuideSkip] source=describeAction.doDestroy guideId=%s isShow=false skipNotSave=nil reason=destroy pageName=%s targetPath=%s", tostring(self.tree.param.guideId), tostring(self.pageName), tostring(self.targetPath)), C_ELogModule.Guide)
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
    guideId = self.tree.param.guideId,
    isShow = false
  })
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
end

function this:onFinish()
  self.isDestroy = true
  self:doDestroy()
end

function this:dealDestroy()
  self:disposeTimer()
  if L_CommonUtil.isValid(self.effectGameObject) and self.isDestroy then
    C_GameObject.DestroyImmediate(self.effectGameObject.gameObject)
  end
  if L_UI:checkPageOpen("pageGuideClickTips") then
    L_UI:close("pageGuideClickTips")
  end
  self.logMsgTable = {}
  self:closeRefreshTimer()
  L_UI:setTempTopGuideMask(false)
  self:dealDisableHighInputAction()
end

function this:blockAllAction()
  if self.isUseMask then
    C_InputManager.EnableHighLevelControl({}, nil)
  end
end

function this:dealHighInputAction()
  local inputActions
  if C_InputManager.IsEnableGamePad then
    inputActions = self.gamepadInputAction
  else
    inputActions = self.inputActions
  end
  if not string.isEmpty(inputActions) then
    local actions = string.split(inputActions, "|")
    C_InputManager.EnableHighLevelControl(actions, nil)
    return true
  end
  if string.isEmpty(inputActions) then
    C_InputManager.DisableHighLevelControl()
  end
  return false
end

function this:dealDisableHighInputAction()
  if not string.isEmpty(self.inputActions) and not self.forceCloseRecoverInputOne then
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

return this
