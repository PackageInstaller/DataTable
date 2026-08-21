_class("UISeasonBalanceQAEvidence", UICustomWidget)
UISeasonBalanceQAEvidence = UISeasonBalanceQAEvidence

function UISeasonBalanceQAEvidence:Constructor()
end

function UISeasonBalanceQAEvidence:OnShow()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._alpha = self:GetUIComponent("CanvasGroup", "alpha")
  self._anim = self:GetUIComponent("Animation", "alpha")
end

function UISeasonBalanceQAEvidence:PlayAnim(yieldTime)
  if 0 < yieldTime then
    self._alpha.alpha = 0
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._alpha.alpha = 1
      self._anim:Play("uieffanim_UISeasonBalanceQAEvidence_in")
    end)
  else
    self._anim:Play("uieffanim_UISeasonBalanceQAEvidence_in")
  end
end

function UISeasonBalanceQAEvidence:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonBalanceQAEvidence:SetData(idx, cfg)
  self._idx = idx
  self._cfg = cfg
  self._desc:SetText(StringTable.Get(self._cfg.Desc))
end
