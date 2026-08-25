local FuncBattleCardDisplayPanel, Super = System.NewClass("FuncBattleCardDisplayPanel", FuncBattleCardInfoPanel)
FuncBattleCardDisplayPanel.uiResCls = Func_Battle_CardDisplayResource

function FuncBattleCardDisplayPanel:ctor(battleCardClient, battleTouchPos, extraParams)
  Super.ctor(self, battleCardClient, battleTouchPos, extraParams)
  self.ignoreReShow = false
end

function FuncBattleCardDisplayPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self.binder = binder
  self.ui.Btn_Mask:SetActive(false)
  self:_OnBindEvent()
end

function FuncBattleCardDisplayPanel:_OnBindEvent()
  self.binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self._OnTouchEndEvent))
end

function FuncBattleCardDisplayPanel:_OnTouchEndEvent()
  if self:IsRendering() == false then
    return
  end
  self:HideForReuse()
end

function FuncBattleCardDisplayPanel:HideForReuse()
  self.ignoreReShow = true
  self:SetRendered(false)
end

function FuncBattleCardDisplayPanel:SetRendered(isRendering)
  if isRendering and self.ignoreReShow then
    return
  end
  if not isRendering then
    self:KillCardInfoTween()
  end
  Super.SetRendered(self, isRendering)
  if self.uiResCls ~= Func_Battle_CardDisplayResource then
    return
  end
  if not self.binder then
    return
  end
  if isRendering then
    AudioManager.Instance:PostSoundEvent("SET_STATE_A_FT_CARDVIEW")
  else
    AudioManager.Instance:PostSoundEvent("SET_STATE_A_FT_CARDVIEW_END")
  end
end

function FuncBattleCardDisplayPanel:GetCardInfoTargetPosY()
  return self.extraParams.targetPosY or 55
end

function FuncBattleCardDisplayPanel:BindCardComponent()
  Super.BindCardComponent(self)
end

function FuncBattleCardDisplayPanel:RevertKeyWord(posX)
  self:UpdateKeywordSide(posX, -566, 560, 269)
end

function FuncBattleCardDisplayPanel:OnUnbind()
  Super.OnUnbind(self)
  FrameWaiter.RemoveWaiter(self.frameTicker)
end

function FuncBattleCardDisplayPanel:ShowOrRefresh(card, battleTouchPos, extraParams)
  if extraParams then
    self.extraParams = extraParams
  end
  local isInitShow = self:IsRendering() == false
  self.ignoreReShow = false
  self:SetRendered(true)
  self:UpdateBattleTouchPos(card, battleTouchPos, isInitShow)
end

return FuncBattleCardDisplayPanel
