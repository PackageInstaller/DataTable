local this = class("pageGuideClickTips", G_UIPageBase)
local _guideWordsTpl = L_GameTpl:getGuideWordsTpl()
local skipTime = L_GameTpl:getGameConstTpl():getData("GUIDE_UI_TEXT_SKIP_TIME", L_Const.GameTplType.float)
local typingSpeed = L_GameTpl:getGameConstTpl():getData("GUIDE_UI_TEXT_PRINT_TIME", L_Const.GameTplType.float)
local headBasePath = "UI/Atlas/HeroM/tex_icon_hero_m_%s.png"
local starDirection = {
  up = 1,
  down = 2,
  left = 3,
  right = 4,
  headLeft = 5,
  headRight = 6
}
local headDirectionMap = {left = 1, right = 2}
local directDicMap = {
  [1] = "anim_guide_tipin_d_2",
  [2] = "anim_guide_tipin_u_2",
  [3] = "anim_guide_tipin_r_2",
  [4] = "anim_guide_tipin_l_2",
  [5] = "anim_guide_tipin_r_2",
  [6] = "anim_guide_tipin_l_2"
}

function this.bind()
  return {
    tipText = "",
    keyList = {
      moduleName = "pages/Guide/cellKeyCombinedIcon"
    },
    progress_left = 0,
    progress_right = 0,
    progress_up = 0,
    progress_down = 0,
    progress_head_left = 0,
    progress_head_right = 0,
    progressNodeActive_left = false,
    progressNodeActive_right = false,
    progressNodeActive_up = false,
    progressNodeActive_down = false,
    progressNodeActive_head_left = false,
    progressNodeActive_head_right = false,
    checkMarkActive = false,
    timerIconActive = false,
    tipAnchoredPos = C_Vector2(0, 0),
    starNode = true,
    starAcnchoredPos = C_Vector2(0, 0),
    guideClickTipsActive = true,
    canvasGroup_board = 0,
    tab_direction = 1,
    leftHead = "",
    rightHead = "",
    storyBtnActive = false,
    arrowIconActive = false,
    dotIconActive = false,
    gamepadCutAnchoredPos = C_Vector2(0, 0),
    gamepadText = ""
  }
end

function this.methods()
  return {
    onClick_storyNextBtn = function(self)
      C_MJLog.LogInfo("[点击] board=" .. tostring(self.bind.canvasGroup_board) .. " typing=" .. tostring(self.isTyping), C_ELogModule.Guide)
      if self.isUpdatePos or self.bind.canvasGroup_board == 0 then
        return
      end
      if self.waitClose then
        return
      end
      if not self.options.isDescribeAction or self.isTyping and not self.canSkipTyping then
        return
      end
      if self.isTyping and self.canSkipTyping then
        self.bindComponents.typeWriter:SkipTyping()
        return
      end
      if self.currentStoryIndex >= #self.storyData then
        self.waitClose = true
        self:doClose(function()
          if self.options.finishCallback then
            self.options.finishCallback()
          end
        end)
        return
      end
      self:playNextStory()
    end
  }
end

function this:update()
  if self.isUpdatePos then
    return
  end
  if not self.options or self.bStopLogic then
    return
  end
  local isParentShow = true
  if not L_CommonUtil.isValid(self.options.parentTrans) then
    isParentShow = false
  else
    isParentShow = self.options.parentTrans.gameObject.activeInHierarchy
  end
  if L_GuideManager:checkCurrentAllPages(self.options.validPages) then
    self.bind.canvasGroup_board = 1
  else
    self.bind.canvasGroup_board = 0
  end
  if self.bind.canvasGroup_board == 1 then
    self:refreshPos()
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.GuideClickInputChecked, self.onInputChecked, self)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.GuideClickPass, self.onGuideClickPass, self)
end

function this:updateTipsPosWithCoordinates()
  local parentTrans = self.options.parentTrans
  if parentTrans == nil then
    return
  end
  if not string.isEmpty(self.options.tipPos) then
    self.bindComponents.tipsRect.anchoredPosition = self.options._tipPos
  end
  if not string.isEmpty(self.options.tipOffset) then
    local pos = self.bindComponents.tipsRect.anchoredPosition
    local finalPos = pos + self.options._tipOffset
    self.bindComponents.tipsRect.anchoredPosition = finalPos
  end
end

function this:updateTipsPos()
  if not self.isBind then
    return
  end
  self:refreshPos()
  self.isUpdatePos = false
  self.bind.canvasGroup_board = 1
  self.bindComponents.tipAnimation:Play(directDicMap[self.curDirection])
end

function this:refreshPos()
  if not self.isBind then
    return
  end
  if not L_CommonUtil.isValid(self.options.effectGameobject) then
    return
  end
  local parentTrans = self.options.parentTrans
  if parentTrans == nil then
    return
  end
  local boxSize = self.bindComponents.textBoxRect.sizeDelta
  local tipSize = self.bindComponents.tipsRect.sizeDelta
  local pos = self.options.effectGameobject.transform.position
  local posNew = L_UI:getRoot():InverseTransformPoint(pos)
  local effectSize = self.options.effectSize
  self.curDirection = starDirection.up
  if string.isEmpty(self.options.tipPos) and self.options.effectSize ~= nil then
    local curDirection = self.options.arrowDirection
    local rect = L_UI:getRoot().rect
    if curDirection == starDirection.left and posNew.x + effectSize.x / 2 + boxSize.x > rect.xMax then
      curDirection = starDirection.right
    elseif curDirection == starDirection.right and posNew.x - effectSize.x / 2 - boxSize.x < rect.xMin then
      curDirection = starDirection.left
    end
    if curDirection == starDirection.down and posNew.y + effectSize.y / 2 + boxSize.y > rect.yMax then
      curDirection = starDirection.up
    elseif curDirection == starDirection.up and posNew.y - effectSize.y / 2 - boxSize.y < rect.yMin then
      curDirection = starDirection.down
    end
    if curDirection == starDirection.up then
      posNew.y = posNew.y - effectSize.y / 2 - boxSize.y / 2 - 35
    elseif curDirection == starDirection.down then
      posNew.y = posNew.y + effectSize.y / 2 + boxSize.y / 2 + 35
    elseif curDirection == starDirection.left then
      posNew.x = posNew.x + effectSize.x / 2 + boxSize.x / 2 + 25
    elseif curDirection == starDirection.right then
      posNew.x = posNew.x - effectSize.x / 2 - boxSize.x / 2 - 25
    else
      posNew.y = posNew.y - effectSize.y / 2 - boxSize.y / 2 - 35
    end
    self.bindComponents.tipsRect.anchoredPosition = C_Vector2(posNew.x, posNew.y)
    self.bindComponents.tipsRect.anchoredPosition = C_Vector2(posNew.x, posNew.y)
    self.curDirection = curDirection
  end
  self:updateTipsPosWithCoordinates()
  local starPos = C_Vector2.zero
  local starRotation = C_Vector3.zero
  if self.curDirection == starDirection.up then
    starPos.y = starPos.y + boxSize.y / 2 - 15
    starRotation.z = -90
  elseif self.curDirection == starDirection.down then
    starPos.y = starPos.y - boxSize.y / 2 + 15
    starRotation.z = 90
  elseif self.curDirection == starDirection.left then
    starPos.x = starPos.x - boxSize.x / 2 + 10
    starRotation.z = 0
  elseif self.curDirection == starDirection.right then
    starPos.x = starPos.x + boxSize.x / 2 - 12
    starRotation.z = 180
  else
    starPos.y = starPos.y + boxSize.y / 2
    starRotation.z = 0
  end
  if not string.isEmpty(self.options.arrowPos) then
    starPos = starPos + self.options._arrowPos
  end
  self.bind.starAcnchoredPos = starPos
  self.bindComponents.starRect.localRotation = Unity.Quaternion.Euler(starRotation)
  self.bind.tab_direction = self.curDirection
  if self.options.headDirection == headDirectionMap.left then
    self.bind.tab_direction = self.curDirection ~= starDirection.left and starDirection.headLeft or starDirection.headRight
  end
  if self.options.headDirection == headDirectionMap.right then
    self.bind.tab_direction = self.curDirection ~= starDirection.right and starDirection.headRight or starDirection.headLeft
  end
end

function this:parseOptions()
  if not string.isEmpty(self.options.arrowPos) then
    local arrowPos = string.split(self.options.arrowPos, "|")
    self.options._arrowPos = C_Vector2(tonumber(arrowPos[1]), tonumber(arrowPos[2]))
  end
  if not string.isEmpty(self.options.tipPos) then
    local tipPos = string.split(self.options.tipPos, "|")
    self.options._tipPos = C_Vector2(tonumber(tipPos[1]), tonumber(tipPos[2]))
  end
  if not string.isEmpty(self.options.tipOffset) then
    local tipOffset = string.split(self.options.tipOffset, "|")
    self.options._tipOffset = C_Vector2(tonumber(tipOffset[1]), tonumber(tipOffset[2]))
  end
end

function this:open(options)
  if options.isDescribeAction then
    if not string.isEmpty(options.gamepadOffset) then
      local gamepadOffset = string.split(options.gamepadOffset, "|")
      self.bind.gamepadCutAnchoredPos = C_Vector2(tonumber(gamepadOffset[1]), tonumber(gamepadOffset[2]))
    end
    if not string.isEmpty(options.gamepadText) then
      self.bind.gamepadText = L_WordsTpl:getValue(options.gamepadText)
    end
    if not string.isEmpty(options.gamepadInputAction) then
      L_ShortCutManager:addShortKeyFlag(self, options.gamepadInputAction, L_Const.AnchorType.Middle, self.bindComponents.keyGamepadRect)
      if not self.onGamepadKeyHandle then
        self.onGamepadKeyHandle = handler(self, self.onGamepadKey)
        C_InputManager.AddKeyListener(options.gamepadInputKey, self.onGamepadKeyHandle)
      end
    end
  elseif not string.isEmpty(options.gamepadkey) and self.gamepadkey ~= options.gamepadkey then
    L_ShortCutManager:addShortKeyFlag(self, options.gamepadkey, L_Const.AnchorType.Middle, self.bindComponents.gamepadPartShortKeyRect)
    self.gamepadkey = options.gamepadkey
  end
end

function this:close()
  self:disposeVoice()
  self.bindComponents.typeWriter:RemoveCompletedCallback()
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.GuideClickInputChecked, self.onInputChecked, self)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.GuideClickPass, self.onGuideClickPass, self)
  self:disposeSkipTimer()
  self:disposeTween()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  L_ShortCutManager:clearShortKeyFlag(self)
  if self.onGamepadKeyHandle then
    C_InputManager.RemoveKeyListener(self.options.gamepadInputKey, self.onGamepadKeyHandle)
    self.onGamepadKeyHandle = nil
  end
end

function this:disposeVoice()
  if self.curVoice ~= nil then
    L_AudioUtil.stopSound(self.curVoice)
    self.curVoice = nil
  end
end

function this:onGuideClickPass()
  self:doClose()
end

function this:onInputChecked()
  self.bind.checkMarkActive = true
  self.bind.timerIconActive = false
  if L_UI:checkPageOpen(self.pageName) then
    self.bindComponents.tipAnimation:Play("anim_guide_tipcheck")
    self:playEffectAnim()
    self.bStopLogic = true
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
    self.timer = Timer.once(0.6, function()
      L_UI:close(self.pageName)
    end, self)
  end
end

function this:show(options)
  self.options = options
  self:parseOptions()
  self.bind.arrowIconActive = false
  self.bind.dotIconActive = false
  self:disposeTween()
  self.bind.canvasGroup_board = 0
  self.isUpdatePos = true
  self.waitClose = false
  self:updateUI(options)
  Timer.once(0.016, function()
    self:updateTipsPos()
  end, self, self.gameObject)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  self.bStopLogic = false
  self.bind.starNode = not self.options.isDescribeAction or string.isEmpty(self.options.tipPos)
end

function this:updateUI(options)
  self.bind.keyList:clear()
  self.bind.storyBtnActive = options.isDescribeAction or false
  self.bindComponents.typeWriter:ResetMaxCharacter()
  if not options.isDescribeAction then
    self:setNormalTips(options)
  else
    self:setStoryTips(options)
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.tipsRect)
  L_GameUtil.forceRebuildLayout(self.bindComponents.textBoxRect)
end

function this:onTypingEnd()
  self.isTyping = false
  self:refreshStoryArrow()
end

function this:refreshStoryArrow()
  if not self.isBind then
    return
  end
  self.bind.arrowIconActive = self.canSkipTyping or not self.isTyping
  self.bind.dotIconActive = not self.canSkipTyping and self.isTyping
end

function this:setStoryTips(options)
  self:setProgress(false)
  self.bindComponents.typeWriter:SetTypingSpeed(typingSpeed)
  self.typingHandler = self.typingHandler or handler(self, self.onTypingEnd)
  self.bindComponents.typeWriter:SetCompletedCallback(self.typingHandler)
  self.isStoryText = not string.isEmpty(options.storyTextIds)
  if self.isStoryText then
    self.storyData = string.split(options.storyTextIds, "|")
  else
    self.storyData = string.split(options.wordsIds, "|")
  end
  self.currentStoryIndex = 0
  self:playNextStory()
end

function this:disposeSkipTimer()
  if self.skipTimer ~= nil then
    Timer.remove(self.skipTimer)
    self.skipTimer = nil
  end
end

function this:playNextStory()
  self.currentStoryIndex = self.currentStoryIndex + 1
  self.canSkipTyping = false
  self:disposeSkipTimer()
  self.skipTimer = Timer.once(skipTime, function()
    self.canSkipTyping = true
    self:refreshStoryArrow()
  end, self)
  if self.isStoryText then
    if not string.isEmpty(self.options.headIcon) then
      self.bind.leftHead = string.format(headBasePath, self.options.headIcon)
      self.bind.rightHead = string.format(headBasePath, self.options.headIcon)
    end
    if not string.isEmpty(self.storyData[self.currentStoryIndex]) then
      local textId = tonumber(self.storyData[self.currentStoryIndex])
      local storyTextCfg = CS.Azur.Gameplay.Table.TDStoryTextTable.GetData(textId)
      self.bindComponents.typeWriter:StartTyping(storyTextCfg.dialog_Detail.value)
      if not string.isEmpty(storyTextCfg.voiceEventId) then
        self:disposeVoice()
        self.curVoice = L_AudioUtil.playVoiceSound(storyTextCfg.voiceEventId)
      end
      self.isTyping = true
    end
  elseif not string.isEmpty(self.storyData[self.currentStoryIndex]) then
    local wordId = self.storyData[self.currentStoryIndex]
    local wordIdNum = tonumber(wordId)
    if wordIdNum then
      self.bindComponents.typeWriter:StartTyping(_guideWordsTpl:getWords(wordIdNum))
      local guideWordsTpl = _guideWordsTpl:getTplById(wordIdNum)
      self.bind.leftHead = _guideWordsTpl:getTalkIcon(guideWordsTpl)
      self.bind.rightHead = _guideWordsTpl:getTalkIcon(guideWordsTpl)
    else
      self.bindComponents.typeWriter:StartTyping(wordId)
    end
    self.isTyping = true
  end
  self:refreshStoryArrow()
end

function this:setNormalTips(options)
  if not string.isEmpty(options.storyTextId) then
    local textId = tonumber(options.storyTextId)
    local storyTextCfg = CS.Azur.Gameplay.Table.TDStoryTextTable.GetData(textId)
    self.bind.tipText = storyTextCfg.dialog_Detail.value
    if not string.isEmpty(storyTextCfg.voiceEventId) then
      self:disposeVoice()
      self.curVoice = L_AudioUtil.playVoiceSound(storyTextCfg.voiceEventId)
    end
  else
    self.bind.tipText = options.showTips
  end
  if not string.isEmpty(self.options.headIcon) then
    self.bind.leftHead = string.format(headBasePath, self.options.headIcon)
    self.bind.rightHead = string.format(headBasePath, self.options.headIcon)
  end
  self.bind.checkMarkActive = false
  self.bind.timerIconActive = false
  self.bind.keyList:clear()
  local keyData = {}
  for _, key in ipairs(options.showKeys) do
    if not string.isEmpty(key) then
      table.insert(keyData, {keyText = key, isLongPress = false})
    end
  end
  if not string.isEmpty(options.longPressKey) then
    table.insert(keyData, {
      keyText = options.longPressKey,
      isLongPress = true
    })
  end
  self.bind.keyList:insert_array(keyData)
  if self.options.showTime ~= nil and self.options.showTime > 0 then
    self:setShowTime()
  end
  self:setProgress(not math.isEmpty(self.options.showTime))
end

function this:setShowTime()
  self.progress = 0
  self.bind.checkMarkActive = false
  self.bind.timerIconActive = true
  if self.bind.canvasGroup_board == 0 then
    self.bind.canvasGroup_board = 1
    self:refreshPos()
  end
  
  local function getter()
    return self.progress
  end
  
  local function setter(r)
    self.progress = r
    self:setProgress(true, self.progress)
  end
  
  self:setProgress(true, self.progress)
  if self.options.showEndTime == nil then
    self.options.showEndTime = L_TimeUtil:getServerTime()
  end
  local showTime = self.options.showEndTime - L_TimeUtil:getServerTime()
  self.tween = DOTween.To(getter, setter, 1, showTime):SetEase(Tweening.Ease.Linear):OnComplete(function()
    self.bind.timerIconActive = false
    self.bStopLogic = true
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
    self:doClose()
    self:disposeTween()
  end)
end

function this:doClose(callback)
  if self.bindComponents.tipAnimation ~= nil then
    self.bindComponents.tipAnimation:Play("anim_guide_tipout")
    printf("guide pageGuideClickTips", "强引导提示播放out动画")
  end
  self:playEffectAnim()
  self.timer = Timer.once(0.167, function()
    printf("guide pageGuideClickTips", "强引导提示正式关闭")
    L_UI:close(self.pageName)
    if callback then
      callback()
    end
  end, self)
end

function this:playEffectAnim()
  if L_CommonUtil.isValid(self.options.effectGameobject) then
    local animator = self.options.effectGameobject:GetComponent(typeof(C_CsAnimator))
    if animator ~= nil then
      local aniName = "anim_guide_squareBtn_hide"
      if string.find(self.options.effectGameobject.name, "circle") then
        aniName = "anim_guide_circleBtn_hide"
      end
      animator:Play(aniName, -1, 0)
      printf("guide pageGuideClickTips", aniName)
    end
  end
end

function this:disposeTween()
  if L_CommonUtil.isValid(self.tween) then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:escHandle()
end

function this:setProgress(isActive, progressNum)
  self.bind.progressNodeActive_left = isActive
  self.bind.progressNodeActive_right = isActive
  self.bind.progressNodeActive_up = isActive
  self.bind.progressNodeActive_down = isActive
  self.bind.progressNodeActive_head_left = isActive
  self.bind.progressNodeActive_head_right = isActive
  if isActive and progressNum then
    self.bind.progress_left = progressNum
    self.bind.progress_right = progressNum
    self.bind.progress_up = progressNum
    self.bind.progress_down = progressNum
    self.bind.progress_head_left = progressNum
    self.bind.progress_head_right = progressNum
  end
end

function this:refreshNormalTipsInfo(options, needInitKeyboard)
  if not options then
    return
  end
  if string.isEmpty(options.storyTextId) then
    self.bind.tipText = options.showTips
  end
  if not string.isEmpty(options.gamepadkey) and self.gamepadkey ~= options.gamepadkey then
    L_ShortCutManager:addShortKeyFlag(self, options.gamepadkey, L_Const.AnchorType.Middle, self.bindComponents.gamepadPartShortKeyRect)
    self.gamepadkey = options.gamepadkey
  end
  if needInitKeyboard then
    self:setNormalTips(options)
  end
end

function this:onGamepadKey(isPress)
  if not C_InputManager.IsEnableGamePad or not isPress then
    return
  end
  self.methods.onClick_storyNextBtn(self)
end

return this
