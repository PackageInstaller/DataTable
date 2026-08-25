local AwakerOriginChangeComp, Super = System.NewComponent("AwakerOriginChangeComp")

function AwakerOriginChangeComp:ctor(parentUi, model)
  Super.ctor(self)
  self.ui = parentUi
  self.model = model
end

function AwakerOriginChangeComp:OnBind(binder)
  binder:BindToRaw(function()
    self:UpdateShow()
  end, function()
    return self.model.selectAwakerId
  end)
  binder:BindToRaw(function()
    self:UpdateShow()
  end, function()
    return self.model.page
  end)
  binder:BindButtonClick(self.ui.Group_Disable, function()
    if not self:IsUnlocked() then
      UIManager.Instance:Reopen(Urls.AwakerOriginUnlockPanel, self.model.selectAwakerId)
    end
  end)
  binder:BindToVisible(self.ui.Group_Disable, function()
    return not self:IsUnlocked()
  end)
  binder:BindButtonClick(self.ui.Group_Disable, function()
    if not self:IsUnlocked() then
      UIManager.Instance:Reopen(Urls.AwakerOriginUnlockPanel, self.model.selectAwakerId)
    end
  end)
  binder:BindToVisible(self.ui.Group_Base, function()
    return self:IsUnlocked() and AwakerDataUtils.IsBaseType(self.model.selectAwakerId)
  end)
  binder:BindButtonClick(self.ui.Group_Base, function()
    self:OnSwitchAwakerShape()
  end)
  binder:BindToVisible(self.ui.Group_Origin, function()
    return self:IsUnlocked() and AwakerDataUtils.IsOriginType(self.model.selectAwakerId)
  end)
  binder:BindButtonClick(self.ui.Group_Origin, function()
    self:OnSwitchAwakerShape()
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Unlock, CommonDefine.RedDotType.Dot, function()
    do return self.CanUnlock end
    return self.CanUnlock, self
  end))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Base, CommonDefine.RedDotType.TextNew, function()
    local chargeFormAwakerTid = AwakerDataUtils.GetChangerForm(self.model.selectAwakerId)
    if 0 ~= chargeFormAwakerTid and AwakerSkinUtils.IsAwakerHasNewSkin(chargeFormAwakerTid) then
      return RedPointDataUtils.RedAttrType.IsNew
    end
    return false
  end))
  binder:BindEvent(EventMgr.Instance.UnlockAwakerOriginEvent, function()
    self:OnSwitchAwakerShape()
  end)
  binder:BindEvent(EventMgr.Instance.CSSendEventStr, System.fn(self, self.OnCSSendEventStr))
  binder:BindEvent(EventMgr.Instance.JumpAwakerOriSwitch, System.fn(self, self.JumpAwakerOriSwitch))
end

function AwakerOriginChangeComp:JumpAwakerOriSwitch()
  AudioManager.Instance:PostSoundEvent("Stop_Anim_AwakerEX_Switch_C01_AF")
  self:ClearTimeline()
  local panel = UIManager.Instance:GetWindow(Urls.AwakerBasePanel)
  if panel then
    panel.uiAnimController:PlayState("UI_Awaker_Panel_Main_Minihead_OriginSwitch_Skip")
  end
end

function AwakerOriginChangeComp:OnCSSendEventStr(eventName, eventValue1, eventValue2)
  if "PortraitEffect" == eventName then
    self:PortraitEffect(eventValue1, eventValue2)
  end
end

function AwakerOriginChangeComp:PortraitEffect(eventValue1, eventValue2)
  local effectIdx = tonumber(eventValue1)
  local time = tonumber(eventValue2)
  local panel = UIManager.Instance:GetWindow(Urls.AwakerBasePanel)
  local portaitComp = panel.portaitComp
  portaitComp:ShowEffect(effectIdx, time)
end

function AwakerOriginChangeComp:OnSwitchAwakerShape()
  EventMgr.Instance.OpenReqMask:Dispatch()
  
  function self.switchResult()
    local changeId = AwakerDataUtils.GetChangerForm(self.model.selectAwakerId)
    self.model:SetSelectAwaker(changeId)
    self.model:SetSelectAwakerId(changeId)
  end
  
  local function calFunc()
    ProtoManager.Instance:ReqServer("GameRequest", "OnSwitchAwakerShape", function()
      self:PlaySwitchTimeline(self.switchResult)
    end, function(_, code)
      Logger.Error("[本源形态] 切换失败！错误码: %s", code.code)
    end, self.model.selectAwakerId)
  end
  
  if not self.assetsLoader then
    self.assetsLoader = MultiResourcesLoader()
  end
  self.assetsLoader:Clear()
  local assetsPath = {}
  local isBaseToOri = AwakerDataUtils.IsBaseType(self.model.selectAwakerId)
  local timelingPath = self:GetTimeLinePath(isBaseToOri)
  table.insert(assetsPath, timelingPath)
  self.assetsLoader:Load(assetsPath, function()
    calFunc()
  end, true)
end

function AwakerOriginChangeComp:GetTimeLinePath(isBaseToOri)
  local timelinePath
  local awakerData = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
  local isWearSkin = 0 ~= (awakerData and awakerData.curSkin or 0)
  local changeId = AwakerDataUtils.GetChangerForm(self.model.selectAwakerId)
  local changeAwakerData = changeId and AwakerDataUtils.GetAwakerData(changeId)
  local isChangeAwakerWearSkin = 0 ~= (changeAwakerData and changeAwakerData.curSkin or 0)
  local commonSwitchTime = "TimelineRoot/AwakerPortrait/Common/CommonPortrait.prefab"
  if isWearSkin or isChangeAwakerWearSkin then
    timelinePath = commonSwitchTime
  elseif isBaseToOri then
    local awakerCfg = changeId and DT.AwakerConfig[changeId]
    local awakerResNum = awakerCfg and awakerCfg.AwakerResNum
    timelinePath = string.format("TimelineRoot/AwakerPortrait/Awaker_%s/Awaker_%s.prefab", awakerResNum, awakerResNum)
  else
    timelinePath = commonSwitchTime
  end
  return timelinePath
end

function AwakerOriginChangeComp:PlaySwitchTimeline(finishCall)
  local isBaseToOri = AwakerDataUtils.IsBaseType(self.model.selectAwakerId)
  local timelingPath = self:GetTimeLinePath(isBaseToOri)
  local awakerBasePanel = UIManager.Instance:GetWindow(Urls.AwakerBasePanel)
  if awakerBasePanel then
    awakerBasePanel:SetIgnorePushBackCommand()
  end
  self:ClearTimeline()
  self.timelinePlayer = PortraitTimelinePlayer(self.ui.uiNode)
  self.timelinePlayer.isSync = true
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelingPath
  
  function timelineConfig.onComplete()
    UIManager.Instance:CloseByUrl(Urls.AwakerOriChangeJumpPanel)
    awakerBasePanel = UIManager.Instance:GetWindow(Urls.AwakerBasePanel)
    if awakerBasePanel then
      awakerBasePanel:ReSetIgnorePushBackCommand()
    end
  end
  
  self.timelinePlayer:SetSwitchPortraitCall(finishCall)
  self.timelinePlayer:Play(timelineConfig)
  UIManager.Instance:Show(Urls.AwakerOriChangeJumpPanel, isBaseToOri)
end

function AwakerOriginChangeComp:UpdateShow()
  local hasOriginType = AwakerDataUtils.HasOriginType(self.model.selectAwakerId)
  local inDetail = self.model.page == CommonDefine.AwakerPage.Detail
  local ownAwaker = self.model:HasOwnedAwaker(self.model.selectAwakerId)
  self.ui.Btn_Origin:SetActive(hasOriginType and inDetail and ownAwaker)
end

function AwakerOriginChangeComp:IsUnlocked()
  do return AwakerDataUtils.IsUnlockedOriginType end
  return AwakerDataUtils.IsUnlockedOriginType, self.model.selectAwakerId
end

function AwakerOriginChangeComp:CanUnlock()
  do return RedPointDataUtils.CanUnlock_OriAwaker end
  return RedPointDataUtils.CanUnlock_OriAwaker, self.model.selectAwakerId
end

function AwakerOriginChangeComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

function AwakerOriginChangeComp:OnUnbind()
  Super.OnUnbind(self)
  if self.assetsLoader then
    self.assetsLoader:Clear()
  end
end

return AwakerOriginChangeComp
