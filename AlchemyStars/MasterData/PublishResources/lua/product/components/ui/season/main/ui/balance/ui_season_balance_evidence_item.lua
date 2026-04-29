_class("UISeasonBalanceEvidenceItem", UICustomWidget)
UISeasonBalanceEvidenceItem = UISeasonBalanceEvidenceItem

function UISeasonBalanceEvidenceItem:Constructor()
end

function UISeasonBalanceEvidenceItem:OnShow()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._not_desc = self:GetUIComponent("UILocalizationText", "not_desc")
  self._img = self:GetUIComponent("Image", "img")
  self._imgRT = self:GetUIComponent("RectTransform", "img")
  self._have = self:GetGameObject("have")
  self._not = self:GetGameObject("not")
  self._atlas = self:GetAsset("UIS2Balance.spriteAtlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._alpha = self:GetUIComponent("CanvasGroup", "rect")
end

function UISeasonBalanceEvidenceItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonBalanceEvidenceItem:SetData(idx, have, cfg, yieldTime)
  self._idx = idx
  self._cfg = cfg
  self._have:SetActive(have)
  self._not:SetActive(not have)
  if have then
    self._type_cfg = Cfg.cfg_season_evidence_type[self._cfg.EvidenceType]
    self._img.sprite = self._atlas:GetSprite(self._type_cfg.Img)
    local pos = self._type_cfg.Pos
    local size = self._type_cfg.Size
    local rot = self._type_cfg.Rot
    self._imgRT.sizeDelta = Vector2(size[1], size[2])
    self._imgRT.anchoredPosition = Vector2(pos[1], pos[2])
    self._imgRT.rotation = Quaternion.Euler(0, 0, rot)
    self._desc:SetText(StringTable.Get(self._cfg.Desc))
  else
    self._not_desc:SetText(StringTable.Get(self._cfg.LockDesc))
  end
  if yieldTime and 0 < yieldTime then
    self._alpha.alpha = 0
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._alpha.alpha = 1
      local animName = have and "uieffanim_UISeasonBalanceEvidenceItem_have_in" or "uieffanim_UISeasonBalanceEvidenceItem_not_in"
      self._anim:Play(animName)
    end)
  else
    self._alpha.alpha = 1
  end
end
