_class("UISeasonBalanceQAEvidenceType", UICustomWidget)
UISeasonBalanceQAEvidenceType = UISeasonBalanceQAEvidenceType

function UISeasonBalanceQAEvidenceType:Constructor()
end

function UISeasonBalanceQAEvidenceType:OnShow()
  self._img = self:GetUIComponent("Image", "img")
  self._Btn = self:GetUIComponent("Image", "Btn")
  self._rect = self:GetUIComponent("RectTransform", "pos")
  self._atlas = self:GetAsset("UIS2Balance.spriteAtlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._alpha = self:GetUIComponent("CanvasGroup", "Btn")
end

function UISeasonBalanceQAEvidenceType:PlayAnim(yieldTime)
  self._alpha.alpha = 0
  if 0 < yieldTime then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play("uieffanim_UISeasonBalanceQAEvidenceType_in")
    end)
  else
    self._anim:Play("uieffanim_UISeasonBalanceQAEvidenceType_in")
  end
end

function UISeasonBalanceQAEvidenceType:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonBalanceQAEvidenceType:BtnOnClick(go)
  if self._callback then
    self._callback(self._idx, self._cfg.ID)
  end
end

function UISeasonBalanceQAEvidenceType:Select(idx)
  local spriteName = idx == self._idx and "exp_s2_tp_di08" or "exp_s2_tp_di07"
  local sprite = self._atlas:GetSprite(spriteName)
  self._Btn.sprite = sprite
  local pos = idx == self._idx and 20 or 0
  self._rect.anchoredPosition = Vector2(0, pos)
end

function UISeasonBalanceQAEvidenceType:SetData(idx, cfg, callback)
  self._idx = idx
  self._cfg = cfg
  self._callback = callback
  self._img.sprite = self._atlas:GetSprite(self._cfg.Img)
end
