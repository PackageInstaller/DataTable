local module = class("moduleAchieve", G_UIModuleBase)
local _achievementTpl = L_GameTpl:getAchievementTpl()

function module.bind()
  return {
    go_content = false,
    txt_title = "",
    txt_content = "",
    go_bg = false
  }
end

function module.methods()
  return {
    onClick_Achieve = function(self)
      local id = L_AchievementUtil.getStore():GetAchieveTrackID()
      L_UI:open("pageAchieveMainContent", {achieveId = id})
    end,
    onSelected = function(self)
      C_LeftHudFocusMgr:SetSubmitKey(self, true)
    end,
    onDeselected = function(self)
      C_LeftHudFocusMgr:SetSubmitKey(self, false)
    end,
    onClick_Gamepad = function(self)
      C_LeftHudFocusMgr:UnFocusTaskHUD()
      self.methods.onClick_Achieve(self)
    end
  }
end

function module:open()
  self:refreshView()
  self:RefreshFocusTaskUI()
  self._onRefreshTrackAchieve = handler(self, self.onEvent_trackUpdateHandle)
  C_AchievementEvent.instance:Listen(C_EAchievementEvent.RefreshTrackAchieve, self._onRefreshTrackAchieve)
  self._syncChallengeDataHandler = handler(self, self.onEvent_syncChallengeData)
  AzurWorld.ChallengeMgr:RegisterEvent(C_EChallengeEvent.ChallengeRefresh, self._syncChallengeDataHandler)
  self._onChallengeTargetOpenHandler = handler(self, self.onChallengeStart)
  self._onChallengeTargetCloseHandler = handler(self, self.onChallengeStop)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnChallengeTargetOpen, self._onChallengeTargetOpenHandler)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnChallengeTargetCloseDone, self._onChallengeTargetCloseHandler)
  self._onUpdateFocusStateHandler = handler(self, self.onUpdateFocusState)
  C_LeftHudFocusMgr:RegisterEvent(C_EMainCityLeftHudFocusEvent.Active, self._onUpdateFocusStateHandler)
  C_LeftHudFocusMgr:RegisterEvent(C_EMainCityLeftHudFocusEvent.DeActive, self._onUpdateFocusStateHandler)
  C_LeftHudFocusMgr:RegisterEvent(C_EMainCityLeftHudFocusEvent.OnFocus, self._onUpdateFocusStateHandler)
  C_LeftHudFocusMgr:RegisterEvent(C_EMainCityLeftHudFocusEvent.OnUnFocus, self._onUpdateFocusStateHandler)
  C_LeftHudFocusMgr:InitSubmitKey(self, L_Const.AnchorType.Right, self.bindComponents.textTarget.transform)
  C_LeftHudFocusMgr:InitFocusKey(self, L_Const.AnchorType.Middle, self.bindComponents.txtAndbtn, C_Vector2(0, 0), 0.75)
end

function module:close()
  if self._onRefreshTrackAchieve then
    C_AchievementEvent.instance:Cancel(C_EAchievementEvent.RefreshTrackAchieve, self._onRefreshTrackAchieve)
  end
  if self._syncChallengeDataHandler then
    AzurWorld.ChallengeMgr:UnregisterEvent(C_EChallengeEvent.ChallengeRefresh, self._syncChallengeDataHandler)
  end
  if self._onChallengeTargetOpenHandler then
    C_WorldEvent.instance:Cancel(C_EWorldEvent.OnChallengeTargetOpen, self._onChallengeTargetOpenHandler)
  end
  if self._onChallengeTargetCloseHandler then
    C_WorldEvent.instance:Cancel(C_EWorldEvent.OnChallengeTargetCloseDone, self._onChallengeTargetCloseHandler)
  end
  if self._onUpdateFocusStateHandler then
    C_LeftHudFocusMgr:UnregisterEvent(C_EMainCityLeftHudFocusEvent.Active, self._onUpdateFocusStateHandler)
    C_LeftHudFocusMgr:UnregisterEvent(C_EMainCityLeftHudFocusEvent.DeActive, self._onUpdateFocusStateHandler)
    C_LeftHudFocusMgr:UnregisterEvent(C_EMainCityLeftHudFocusEvent.OnFocus, self._onUpdateFocusStateHandler)
    C_LeftHudFocusMgr:UnregisterEvent(C_EMainCityLeftHudFocusEvent.OnUnFocus, self._onUpdateFocusStateHandler)
  end
  C_LeftHudFocusMgr:ClearAllKey(self)
end

function module:show()
  self.isShow = true
  self:refreshView()
  self:RefreshFocusTaskUI()
end

function module:hide()
  self.isShow = nil
  self.isHidden = true
end

function module:refreshView()
  if not self.isShow then
    self.bind.go_content = false
    return
  end
  if self:isChallengeTargetShowing() then
    self.bind.go_content = false
    return
  end
  local trackId = L_AchievementUtil.getStore():GetAchieveTrackID()
  if trackId <= 0 then
    self.bind.go_content = false
    return
  end
  local tpl = _achievementTpl:getTplById(trackId)
  if tpl == nil then
    self.bind.go_content = false
    return
  end
  self.bind.go_content = true
  self.bind.go_bg = true
  self.bind.txt_title = _achievementTpl:getAchiName(tpl)
  self.bind.txt_content = _achievementTpl:getAchiDesc(tpl)
  self.isAchieved = L_AchievementUtil.getStore():GetIsAchievementCompleted(trackId)
  if trackId ~= self.trackId then
    self.trackId = trackId
    self:playShowAnim(true)
  elseif self.isHidden then
    self:playShowAnim()
  end
  self:refreshTimers()
end

function module:onEvent_trackUpdateHandle()
  self:refreshView()
  self:RefreshFocusTaskUI()
end

function module:onEvent_achievementUpdateHandle()
  if self.trackId ~= nil then
    local isAchieved = L_AchievementUtil.getStore():GetIsAchievementCompleted(self.trackId)
    if not self.isAchieved and isAchieved then
      self.isAchieved = true
      self:playCompleteAnim()
    end
  end
end

function module:refreshTimers()
  self:reset()
  self.originText = self.bind.txt_title
  if self.originText ~= "" then
    self.bind.startPosition = Unity.Vector3(0, 0, 0)
    local targetTransform = self.bindComponents.taskDetails.transform
    targetTransform.localPosition = self.bind.startPosition
    local text = targetTransform:GetComponent(typeof(C_LTextMeshProUGUI))
    local originText = self.originText
    local width = string.widthSingle(originText)
    if 20 < width then
      text.text = string.subWidthText(originText, 18) .. "..."
      self.timer = Timer.repeated(10, function()
        text.text = originText
        self.tween = targetTransform:DOLocalMoveX(-200, 5):SetEase(Tweening.Ease.Linear):OnComplete(function()
          targetTransform.localPosition = self.bind.startPosition
          text.text = string.subWidthText(originText, 18) .. "..."
          if self.timer == nil then
            return
          end
          self.timer:pause()
          self.onceTimer = Timer.once(5, function()
            self.timer:resume()
          end, self)
        end, self)
      end, self, self.gameObject)
    else
      text.text = self.originText
    end
  end
end

function module:reset()
  if self.timer then
    self.timer:destroy()
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.onceTimer then
    self.onceTimer:destroy()
    Timer.remove(self.onceTimer)
    self.onceTimer = nil
  end
  if self.tween then
    self.tween:Kill()
  end
  L_TimerManager:clearTimer(self)
end

function module:playAnim(name)
  self.bindComponents.animation:Stop()
  self.bindComponents.animation:Play(name)
end

function module:playDetailAnim(name)
  self.bindComponents.detailAnimation:Stop()
  self.bindComponents.detailAnimation:Play(name)
end

function module:playShowAnim(isNew)
  L_TimerManager:stopTimer(self, "playHideAnim")
  self.isHidden = false
  self:playAnim(isNew and "anim_taskitem_new_in" or "anim_taskitem_in")
  self:playDetailAnim(isNew and "anim_taskitem_detail_new_in" or "anim_taskitem_detail_in")
end

function module:playHideAnim(cb)
  self.isHidden = true
  self:playAnim("anim_taskitem_out")
  local animClip = self.bindComponents.animation:GetClip("anim_taskitem_out")
  if cb then
    L_TimerManager:newOrResetTimer(self, "playHideAnim", cb, animClip.length)
  end
end

function module:playCompleteAnim()
  self:playDetailAnim("anim_taskitem_detail_complete")
end

function module:onEvent_syncChallengeData()
  self:setAchieveModuleActiveByChallengeData()
end

function module:onChallengeStart()
  if self:isInDungeonTaskHudFilterScene() then
    self.newChallengeTargetShowing = self:hasActiveChallengeContent()
  else
    self.newChallengeTargetShowing = true
  end
  self:setAchieveModuleActiveByChallengeData()
end

function module:onChallengeStop()
  self.newChallengeTargetShowing = false
  self:setAchieveModuleActiveByChallengeData()
end

function module:setAchieveModuleActiveByChallengeData()
  self:RefreshFocusTaskUI()
  self:refreshView()
end

function module:isChallengeTargetShowing()
  if AzurWorld.ChallengeMgr == nil then
    return false
  end
  local challengeTargetPageOpened = AzurWorld.ChallengeMgr:CheckChallengeTargetUIOpened()
  if self:isInDungeonTaskHudFilterScene() then
    return not self:hasActiveChallengeContent() or self.newChallengeTargetShowing or challengeTargetPageOpened
  end
  return self.newChallengeTargetShowing == true or challengeTargetPageOpened
end

function module:isInDungeonTaskHudFilterScene()
  return AzurWorld.DungeonMgr ~= nil and AzurWorld.DungeonMgr:CheckIsDungeonScene() and AzurWorld.DungeonMgr:IsInDungeonTaskInstance()
end

function module:hasActiveChallengeContent()
  return AzurWorld.ChallengeMgr ~= nil and AzurWorld.ChallengeMgr:HasActiveChallengeContent()
end

function module:GetNavigationSelectable()
  return self.bindComponents.textTarget
end

function module:CanGamepadFocus()
  return self.bind.go_content
end

function module:onUpdateFocusState(focusEvent, args)
  if not args then
    return
  end
  local focusTaskUI = args:GetInt(0)
  if not focusTaskUI or focusTaskUI ~= C_EGamepadFocusTaskUI.Achieve then
    return
  end
  local show
  if focusEvent == C_EMainCityLeftHudFocusEvent.OnUnFocus or focusEvent == C_EMainCityLeftHudFocusEvent.Active then
    show = true
  elseif focusEvent == C_EMainCityLeftHudFocusEvent.OnFocus or focusEvent == C_EMainCityLeftHudFocusEvent.DeActive then
    show = false
  end
  if show == nil then
    return
  end
  C_LeftHudFocusMgr:SetFocusKey(self, show)
end

function module:RefreshFocusTaskUI()
  if self.bind.go_content then
    C_LeftHudFocusMgr:TryActivateFocusTaskUI(C_EGamepadFocusTaskUI.Achieve)
  else
    C_LeftHudFocusMgr:DeactivateFocusTaskUI(C_EGamepadFocusTaskUI.Achieve)
  end
end

return module
