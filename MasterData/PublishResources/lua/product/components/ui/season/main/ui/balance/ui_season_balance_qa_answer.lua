_class("UISeasonBalanceQA_Answer", UICustomWidget)
UISeasonBalanceQA_Answer = UISeasonBalanceQA_Answer

function UISeasonBalanceQA_Answer:Constructor()
end

function UISeasonBalanceQA_Answer:OnShow()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._descOnly = self:GetUIComponent("UILocalizationText", "descOnly")
  self._descWithImg = self:GetGameObject("descWithImg")
  self._onlyDesc = self:GetGameObject("onlyDesc")
  self._Btn = self:GetUIComponent("Image", "Btn")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._alpha = self:GetUIComponent("CanvasGroup", "Btn")
end

function UISeasonBalanceQA_Answer:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonBalanceQA_Answer:SetDataOnlyDesc(desc)
  self._onlyDesc:SetActive(true)
  self._descWithImg:SetActive(false)
  self._descOnly:SetText(desc)
end

function UISeasonBalanceQA_Answer:SetData(idx, cfg, callback)
  self._onlyDesc:SetActive(false)
  self._descWithImg:SetActive(true)
  self._idx = idx
  self._callback = callback
  self._cfg = cfg
  self._succIdx = self._cfg.SuccIdx
  self._desc:SetText(StringTable.Get(self._cfg.Answers[self._idx]))
  if self._callback then
    self._Btn.raycastTarget = true
  else
    self._Btn.raycastTarget = false
  end
end

function UISeasonBalanceQA_Answer:PlayAnim(yieldTime)
  self._alpha.alpha = 0
  if 0 < yieldTime then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play("uieffanim_UISeasonBalanceQA_Answer_in")
    end)
  else
    self._anim:Play("uieffanim_UISeasonBalanceQA_Answer_in")
  end
end

function UISeasonBalanceQA_Answer:BtnOnClick(go)
  if self._callback then
    self._callback(self._idx == self._succIdx, self._cfg, self._idx)
  end
end
