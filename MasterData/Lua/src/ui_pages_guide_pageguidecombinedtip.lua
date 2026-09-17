local this = class("pageGuideCombinedTip", G_UIPageBase)

function this.bind()
  return {
    tipText = "",
    keyList = {
      moduleName = "pages/Guide/cellKeyCombinedIcon"
    },
    progressLeft = 0,
    progressRight = 0,
    boardAlpha = 1,
    forceNodeAlpha = 0,
    maskBlock = false
  }
end

function this:onUIOpen(pageName)
  if pageName == "pageNetworkWaiting" then
    return
  end
  local isShow = L_GuideManager:checkCurrentAllPages(self.options.validPages)
  self.bind.boardAlpha = isShow and 1 or 0
end

function this:onUIClose(pageName)
  if pageName == "pageNetworkWaiting" then
    return
  end
  local isShow = L_GuideManager:checkCurrentAllPages(self.options.validPages)
  self.bind.boardAlpha = isShow and 1 or 0
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_UI:addListener(L_UI.pageEvent.showed, self.onUIOpen, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onUIClose, self)
  self.options = options
  self:updateUI(options)
end

function this:open(options)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.InputChecked, self.onInputChecked, self)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.CombinedTipPass, self.doClose, self)
end

function this:close()
  L_UI:removeListener(L_UI.pageEvent.showed, self.onUIOpen, self)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onUIClose, self)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.InputChecked, self.onInputChecked, self)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.CombinedTipPass, self.doClose, self)
  self:disposeTween()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.closeSelfTimer then
    Timer.remove(self.closeSelfTimer)
    self.closeSelfTimer = nil
  end
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:onInputChecked()
  if L_UI:checkPageOpen(self.pageName) then
    self.bindComponents.tipAnimation:Play("anim_guide_tipspanel_done")
    self.timer = Timer.once(0.833, function()
      if L_UI:checkPageOpen(self.pageName) then
        L_UI:close(self.pageName)
      end
    end, self)
  end
end

function this:updateUI(options)
  self.bind.progressLeft = 0
  self.bind.progressRight = 0
  self.bind.keyList:clear()
  self.tipsParams = ""
  self:InitKeyboardKeys(options)
  if self.options.showTime ~= nil and 0 < self.options.showTime then
    self:setShowTime()
  end
  if not string.isEmpty(options.gamepadKey) then
    L_ShortCutManager:addShortKeyFlag(self, options.gamepadKey, L_Const.AnchorType.Middle, self.bindComponents.keyGamepadRect)
  end
  if C_InputManager.IsEnableGamePad then
    self.bind.tipText = options.showTips
  else
    self.bind.tipText = options.showTips:gsub("{0}", self.tipsParams, 1)
  end
  self.bind.forceNodeAlpha = self.options.isForce and 1 or 0
  self.bind.maskBlock = self.options.isForce
  self.bindComponents.tipAnimation:Play("anim_guide_tipspanel_in")
end

function this:setShowTime()
  local function getter()
    return self.bind.progressLeft
  end
  
  local function setter(r)
    self.bind.progressLeft = r
    self.bind.progressRight = r
  end
  
  self.tween = DOTween.To(getter, setter, 1, self.options.showTime):SetEase(Tweening.Ease.Linear):OnComplete(function()
    self:disposeTween()
    self:doClose()
  end)
end

function this:doClose()
  if self.bind.boardAlpha == 1 then
    printf("guide pageGuideCombinedTip", "提示引导播放out动画")
    self.bindComponents.tipAnimation:Play("anim_guide_tipspanel_out")
    self.closeSelfTimer = Timer.once(0.167, function()
      printf("guide pageGuideCombinedTip", "提示引导正式关闭")
      L_UI:close(self.pageName)
    end, self)
  else
    L_UI:close(self.pageName)
  end
end

function this:disposeTween()
  if L_CommonUtil.isValid(self.tween) then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:fixTextBackground()
  if self.fixedText then
    return
  end
  local size = self.bindComponents.tipTextRect.sizeDelta
  if size.x <= 0 then
    return
  end
  local bgSize = C_Vector2(size.x + 100, 70)
  if size.x < 457 then
    bgSize = C_Vector2(557, 70)
  end
  if self.bind.normalSizeDelta.x == bgSize.x or self.bind.emphasizeSizeDelta.x == bgSize.x then
    return
  end
  self.bind.emphasizeSizeDelta = bgSize
  self.bind.normalSizeDelta = bgSize
  self.fixedText = true
end

function this:refreshInfo(options, initKeyboard)
  if C_InputManager.IsEnableGamePad then
    self.bind.tipText = options.showTips
  else
    self.bind.tipText = options.showTips:gsub("{0}", self.tipsParams, 1)
    if initKeyboard then
      self:InitKeyboardKeys(options)
    end
  end
end

function this:InitKeyboardKeys(options)
  local keyData = {}
  self.tipsParams = ""
  if options.showKeys then
    for _, key in ipairs(options.showKeys) do
      if _ ~= 1 then
        self.tipsParams = self.tipsParams .. "|"
      end
      self.tipsParams = self.tipsParams .. L_GuideManager:getInputName(key)
      table.insert(keyData, {keyText = key, isLongPress = false})
    end
  end
  if not string.isEmpty(options.longPressKey) then
    table.insert(keyData, {
      keyText = options.longPressKey,
      isLongPress = true
    })
  end
  if 0 < #keyData then
    self.bind.keyList:insert_array(keyData)
  end
end

return this
