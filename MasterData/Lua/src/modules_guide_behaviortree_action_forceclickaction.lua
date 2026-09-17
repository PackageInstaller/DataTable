local this = L_BevTree:registClass("guide.forceClickAction", L_BevTree.action)

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.effectPath = ""
  self.effectScale = ""
  self.dimension = ""
  self.offset = ""
  self.isShowEffectArrow = 0
  self.effectArrowDirection = 0
  self.isOnlyShowEffectArrow = 0
  self.isListItem = 0
  self.useEventTransfer = 0
  self.delayPlayTime = 0
  self.isHideMask = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.effectPath = self:getParam("effectPath")
  self.effectScale = self:getParam("effectScale")
  self.dimension = self:getParam("dimension")
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
  self.delayPlayTime = self:getParam("delayPlayTime", true)
  self.isHideMask = self:getParam("isHideMask", true) ~= 0
  self.isDestroy = false
end

function this:onEnter()
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if string.isEmpty(self.effectPath) then
    printf("guide提示", "特效路径是空的forceClick必须配合特效使用  ID: " .. self.id)
    return L_BevTree.taskResult.Failure
  end
  if self.result == L_BevTree.taskResult.Success or self.result == L_BevTree.taskResult.Failure then
    return self.result
  end
  if self.waitClick then
    if not L_CommonUtil.isValid(self.effectGameObject) and not self.waitDelay then
      self:dealClickFinished()
    end
    return self.result
  end
  local page = L_UI:getPage(self.pageName)
  if L_UI:checkPageShown(self.pageName) then
    if self.isUseListItem then
      self.parentTrans = self.tree.targetListItem.transform
    elseif string.isEmpty(self.targetPath) then
      self.parentTrans = page.transform
    else
      local node = page.gameObject.transform:Find(self.targetPath)
      if node ~= nil then
        self.parentTrans = node
      end
    end
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
  Timer.once(self.delayPlayTime, function()
    L_UI:setTempTopGuideMask(false)
    if self.result == L_BevTree.taskResult.Failure then
      return self.result
    end
    self:dealEffect()
    self:dealArrowEffect()
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

function this:getPageAnimationTime(page)
  if not page then
    return 0.3
  end
  local blendDefinition = L_UI:getPageBlendDefinition(page)
  if not blendDefinition then
    return 0.3
  end
  if not blendDefinition.m_openStyle.animation then
    return 0.3
  end
  local clipName = blendDefinition.m_openStyle.clipName
  local clip
  if not clipName then
    clip = blendDefinition.m_openStyle.animation.clip
  else
    clip = blendDefinition.m_openStyle.animation:GetClip(clipName)
  end
  if clip then
    return clip.length + 0.1
  end
  return 0.3
end

function this:openBlank(delayTime)
  if L_UI:checkPageOpen("pageBlank") then
    L_UI:close("pageBlank")
    Timer.once(0.1, function()
      L_UI:open("pageBlank", {timeClose = delayTime})
    end)
  else
    L_UI:open("pageBlank", {timeClose = delayTime})
  end
end

function this:dealEffect()
  if self.result == L_BevTree.taskResult.Failure then
    return
  end
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.effectScale, self.dimension, self.offset, self.parentTrans)
  local page = L_UI:getPage(self.pageName)
  local board = page.gameObject.transform:Find("board") or page.gameObject.transform:Find("Board")
  board = board or page.gameObject.transform
  local parentRect = self.parentTrans:GetComponent(typeof(C_RectTransform))
  targetWorldPosition = parentRect:TransformPoint(C_Vector3.zero)
  self.effectGameObject = L_EffectUtil.playEffect(self.effectPath, board, scale, offset, dimension, targetWorldPosition, targetRotation)
  if L_CommonUtil.isValid(self.effectGameObject) and not self.isDestroy then
    local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
    if guideFxManager then
      self.scrollRect = self.parentTrans.gameObject:GetComponentInParent(typeof(C_LScrollRect))
      self:setScrollDisable(true)
      self:changeLongPressStatus(false)
      guideFxManager.useMask = not self.isHideMask
      guideFxManager.useEventTransfer = self.isUseEventTransfer
      guideFxManager:InitGuide(self.parentTrans.gameObject)
      self.finishCallback = self.finishCallback or handler(self, self.dealClickFinished)
      guideFxManager:RemoveClickCheckHandler(self.finishCallback)
      guideFxManager:AddClickCheckHandler(self.finishCallback)
    end
  end
  if not self.isHideMask and self.tree.inputActions then
    C_InputManager.EnableHighLevelControl(self.tree.inputActions, nil)
  end
  if not self.isHideMask and not self.isDestroy then
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = true})
  end
end

function this:dealArrowEffect()
  if self.effectGameObject == nil then
    return
  end
  L_EffectUtil.setArrowEffectParams(self.effectGameObject, self.isShowEffectArrow, self.effectArrowDirection, self.isOnlyShowEffectArrow)
end

function this:closeRefreshTimer()
  if not self.refreshTimer then
    return
  end
  self.refreshTimer:destroy()
  self.refreshTimer = nil
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
  targetWorldPosition = parentRect:TransformPoint(C_Vector3.zero)
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
end

function this:dealClickFinished()
  self.isDestroy = true
  self.result = L_BevTree.taskResult.Success
  if not self.isHideMask then
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
  end
  if L_CommonUtil.isValid(self.effectGameObject) and self.isDestroy then
    C_GameObject.Destroy(self.effectGameObject.gameObject)
    if not self.isHideMask and not self.tree.inputActions then
      C_InputManager.DisableHighLevelControl()
    end
  end
end

function this:onReset()
  self.isDestroy = true
  self.result = L_BevTree.taskResult.Failure
  self:dealDestroy()
end

function this:onFinish()
  if self.result ~= L_BevTree.taskResult.Success then
    self.isDestroy = true
    self:dealDestroy()
    if not self.isHideMask then
      L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
    end
  end
  self:setScrollDisable(false)
  self:changeLongPressStatus(true)
  L_UI:setTempTopGuideMask(false)
end

function this:dealDestroy()
  if L_CommonUtil.isValid(self.effectGameObject) and self.isDestroy then
    C_GameObject.DestroyImmediate(self.effectGameObject.gameObject)
  end
  self:closeRefreshTimer()
end

return this
