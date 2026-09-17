local this = L_BevTree:registClass("guide.showGuideTipsCombined", L_BevTree.action)
local _guideWordsTpl = L_GameTpl:getGuideWordsTpl()
local tag = "guide"

function this:param()
  self.pageName = ""
  self.tipsKey = ""
  self.showKeys = ""
  self.showTime = 0
  self.longPressKeys = ""
  self.longPressTime = 0
  self.delayTime = 0
  self.validPages = ""
  self.skipDetect = 0
  self.inputActions = ""
  self.isForce = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.tipsKey = self:getParam("tipsKey", true) or 0
  self.showKeys = self:getParam("showKeys")
  self.showTime = self:getParam("showTime", true) or 0
  self.longPressKeys = self:getParam("longPressKeys")
  self.longPressTime = self:getParam("longPressTime", true) or 0
  self.delayTime = self:getParam("delayTime", true) or 0
  self.validPages = self:getParam("validPages") or ""
  self.skipDetect = self:getParam("skipDetect", true) or 0
  self.skipDetect = self.skipDetect == 1
  local isForce = self:getParam("isForce", true) or 0
  self.isForce = isForce ~= 0
  self.inputActions = self:getParam("inputActions")
end

function this:onEnter()
  if self.isDestory then
    self.result = L_BevTree.taskResult.Failure
    return
  end
  self.waitSuccess = false
  local tips = L_GameTpl:getGuideWordsTpl():getWords(self.tipsKey)
  self.isDetectLongPress = not string.isEmpty(self.longPressKeys) and self.longPressTime > 0
  self.isDetectKeys = not string.isEmpty(self.showKeys)
  if self.isDetectKeys then
    self.tempPressKeys = string.split(self.showKeys, "|")
    L_GuideManager:registerInputAction(self.tempPressKeys)
  end
  if self.isDetectLongPress then
    L_GuideManager:registerLongInputAction(self.longPressKeys)
  end
  self:initKeyboardKeys()
  local validPages = string.split(self.validPages, "|")
  table.insert(validPages, self.pageName)
  self.checkPages = validPages
  self.controlActions = string.split(self.inputActions, "|")
  local gamepadKey = self.tempPressKeys and self.tempPressKeys[1] or self.longPressKeys
  if table.containsValue(L_Const.gamepadUseRouletteInputActions, gamepadKey) then
    gamepadKey = string.concat("GamepadUI/Guide_", gamepadKey)
    self.gamepadRouletteAction = gamepadKey
  end
  self.showTipData = {
    showTips = tips,
    showKeys = self.keyboardKeys,
    longPressKey = self.longPressKeysName,
    showTime = self.showTime,
    showPageName = self.pageName,
    validPages = validPages,
    isForce = self.isForce,
    gamepadKey = gamepadKey
  }
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if self.isDestory then
    return self.result
  end
  self:checkUIShow()
  self:checkEffectFinished()
  if self.result ~= L_BevTree.taskResult.Running then
    return self.result
  end
  if self.waitSuccess then
    return L_BevTree.taskResult.Running
  end
  if not L_GuideManager:checkPageOpen(self.pageName) then
    self.result = L_BevTree.taskResult.Running
    return L_BevTree.taskResult.Running
  end
  if not self.waitAction and not L_GuideManager:checkPageOpen("pageGuideCombinedTip") then
    if self.showTime ~= nil and self.showTime > 0 then
      self.waitAction = true
      self:disposeTimer()
      self.showTimer = Timer.once(self.showTime, function()
        self.waitAction = false
        self.waitSuccess = true
        if L_UI:checkPageOpen("pageGuideCombinedTip") then
          L_UI:close("pageGuideCombinedTip")
        end
      end)
    end
    L_UI:open("pageGuideCombinedTip", self.showTipData)
    if 0 < self.delayTime then
      L_UI:setTempTopGuideMask(true)
      self.waitDelay = true
      Timer.once(self.delayTime, function()
        self.waitDelay = false
        L_UI:setTempTopGuideMask(false)
      end, self)
    end
  end
  if self.waitDelay then
    self.result = L_BevTree.taskResult.Running
    return self.result
  end
  if self.skipDetect then
    self.result = L_BevTree.taskResult.Running
    return self.result
  end
  if self.isDetectKeys then
    self:checkInputAction()
  else
    if self.isDetectLongPress then
      self:checkLongPressAction()
    else
    end
  end
  return self.result
end

function this:checkEffectFinished()
  if not self.waitSuccess then
    return
  end
  if not L_UI:checkPageOpen("pageGuideCombinedTip") then
    self.result = L_BevTree.taskResult.Success
  end
end

function this:checkInputAction()
  local keyCorrect = false
  if self.isDetectKeys then
    keyCorrect = L_GuideManager:isInputActionTriggered()
  end
  if keyCorrect then
    self:dealKeyCorrect()
  end
end

function this:checkLongPressAction()
  local keyCorrect = false
  if self.isDetectLongPress then
    keyCorrect = keyCorrect or false
  end
  if keyCorrect then
    self:dealKeyCorrect()
  end
end

function this:dealKeyCorrect()
  self.bSendChecked = true
  printf("guide", "guide===输入监听完成,关闭界面")
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.InputChecked)
  self.waitSuccess = true
end

function this:dealDestroy()
  if L_UI:checkPageOpen("pageGuideCombinedTip") and not self.bSendChecked then
    L_UI:close("pageGuideCombinedTip")
  end
  L_GuideManager:clearInputAction()
  self:destory()
end

function this:onReset()
  self.isDestory = true
  self:dealDestroy()
end

function this:onDestroy()
  self.isDestory = true
  self:dealDestroy()
end

function this:onFinish()
  self:dealDestroy()
  if self.isForce then
    C_InputManager.DisableHighLevelControl()
  end
end

function this:destory()
  self:disposeTimer()
end

function this:disposeTimer()
  if self.showTimer ~= nil then
    Timer.remove(self.showTimer)
    self.showTimer = nil
  end
end

function this:checkUIShow()
  if self.result ~= L_BevTree.taskResult.Running then
    return
  end
  local isShow = L_GuideManager:checkCurrentAllPages(self.checkPages)
  if self.lastIsShow ~= isShow then
    self:setInputControl(isShow)
  end
  self.lastIsShow = isShow
  self:checkControlSchemeChange()
end

function this:setInputControl(isControl)
  if self.isForce then
    if isControl then
      if not string.isEmpty(self.gamepadRouletteAction) and C_InputManager.IsEnableGamePad then
        local actions = {}
        table.insert(actions, self.gamepadRouletteAction)
        C_InputManager.EnableHighLevelControl(actions, nil)
        return
      end
      if self.controlActions ~= nil and #self.controlActions > 0 then
        C_InputManager.EnableHighLevelControl(self.controlActions, nil)
      end
    else
      C_InputManager.DisableHighLevelControl()
    end
  end
end

function this:checkControlSchemeChange()
  if self.enableGamepad == C_InputManager.IsEnableGamePad then
    return
  end
  if not L_UI:checkPageOpen("pageGuideCombinedTip") then
    return
  end
  local page = L_UI:getPage("pageGuideCombinedTip")
  if not page then
    return
  end
  if not self.showTipData then
    return
  end
  local tips = L_GameTpl:getGuideWordsTpl():getWords(self.tipsKey)
  self.showTipData.showTips = tips
  local initKeyboard = self:initKeyboardKeys()
  if initKeyboard then
    self.showTipData.showKeys = self.keyboardKeys
    self.showTipData.longPressKey = self.longPressKeysName
  end
  page:refreshInfo(self.showTipData, initKeyboard)
  if not string.isEmpty(self.gamepadRouletteAction) then
    self:setInputControl(true)
  end
  self.enableGamepad = C_InputManager.IsEnableGamePad
end

function this:initKeyboardKeys()
  if C_InputManager.IsEnableGamePad or self.isInitKeyboard then
    return false
  end
  if self.isDetectKeys then
    self.keyboardKeys = {}
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
          local tempStrList = string.split(str, "|")
          for k, v in pairs(tempStrList) do
            table.insert(self.keyboardKeys, v)
          end
        end
      end
    end
  end
  if self.isDetectLongPress then
    local action = C_InputManager.GetAction(self.longPressKeys)
    local str = ""
    if action ~= nil then
      str = C_InputManager.GetActionName(action)
      printf(tag, "@guide action name: " .. tostring(str))
    end
    if str ~= "" then
      local tempStrList = string.split(str, "|")
      self.longPressKeysName = tempStrList[1]
    end
    printf(tag, "@guide listen events, long presskey: " .. tostring(self.longPressKeys) .. "long press time: " .. tostring(self.longPressTime))
  end
  self.isInitKeyboard = true
  return true
end

return this
