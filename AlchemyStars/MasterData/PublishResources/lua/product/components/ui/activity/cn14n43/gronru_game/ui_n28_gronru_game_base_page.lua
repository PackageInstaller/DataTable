_class("UIN28GronruGameBasePage", UICustomWidget)
UIN28GronruGameBasePage = UIN28GronruGameBasePage

function UIN28GronruGameBasePage:Constructor()
  self._parent = nil
  self._cfg = nil
  self._atlas = nil
  self._isHighlight = false
end

function UIN28GronruGameBasePage:OnShow(uiParams)
  self._uiNormal = self:GetUIComponent("Image", "uiNormal")
  self._uiHighlight = self:GetUIComponent("Image", "uiHighlight")
  self._txtNormal = self:GetUIComponent("UILocalizationText", "txtNormal")
  self._txtNormalSub = self:GetUIComponent("UILocalizationText", "txtNormalSub")
  self._txtHighlightShadow = self:GetUIComponent("UILocalizationText", "txtHighlightShadow")
  self._txtHighlight = self:GetUIComponent("UILocalizationText", "txtHighlight")
  self._txtHighlightSub = self:GetUIComponent("UILocalizationText", "txtHighlightSub")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._atlas = self:RootUIOwner():GetSpriteAtlas()
  self._uiNormalCanvasGroup = self:GetUIComponent("CanvasGroup", "uiNormal")
  self._uiHighlightCanvasGroup = self:GetUIComponent("CanvasGroup", "uiHighlight")
  self._txtHighlightShadowCo = self:GetUIComponent("H3D.UGUI.CircleOutline", "txtHighlightShadow")
  self._txtHighlightCo = self:GetUIComponent("H3D.UGUI.CircleOutline", "txtHighlight")
  self:SetHighlight(false)
end

function UIN28GronruGameBasePage:OnHide()
end

function UIN28GronruGameBasePage:PlayPageBtnAudio()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceTab)
end

function UIN28GronruGameBasePage:BtnPageOnClick(go)
  self:PlayPageBtnAudio()
end

function UIN28GronruGameBasePage:SetHighlight(inShow)
  self._isHighlight = inShow
  self._uiNormal.gameObject:SetActive(not inShow)
  self._uiHighlight.gameObject:SetActive(inShow)
  self._uiNormalCanvasGroup.alpha = 1
  self._uiHighlightCanvasGroup.alpha = 1
  self._uiHighlight.transform.anchoredPosition = Vector2(30, 0)
  local effectColor = self._txtHighlightShadow.color
  effectColor.a = 1
  self._txtHighlightShadow.color = effectColor
  local effectColor = self._txtHighlight.color
  effectColor.a = 1
  self._txtHighlight.color = effectColor
  local effectColor = self._txtHighlightSub.color
  effectColor.a = 1
  self._txtHighlightSub.color = effectColor
  local effectColor = self._txtHighlightShadowCo.effectColor
  effectColor.a = 1
  self._txtHighlightShadowCo.effectColor = effectColor
  local effectColor = self._txtHighlightCo.effectColor
  effectColor.a = 1
  self._txtHighlightCo.effectColor = effectColor
end

function UIN28GronruGameBasePage:IsHighlight()
  return self._isHighlight
end

function UIN28GronruGameBasePage:ShowNormalHighlight(showNormal, showHighlight)
  self._uiNormal.gameObject:SetActive(showNormal)
  self._uiHighlight.gameObject:SetActive(showHighlight)
end

function UIN28GronruGameBasePage:GetCfg()
  return self._cfg
end

function UIN28GronruGameBasePage:PlayAnimation(animName, duration, cbComplete)
  local lockName = "UIN28GronruGameBasePage:PlayAnimation_" .. animName
  TaskManager:GetInstance():StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play(animName)
    YIELD(TT, duration)
    self:UnLock(lockName)
    if cbComplete then
      cbComplete()
    end
  end)
end

_class("UIN28GronruGameAlbumPage", UIN28GronruGameBasePage)
UIN28GronruGameAlbumPage = UIN28GronruGameAlbumPage

function UIN28GronruGameAlbumPage:Flush(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._uiNormal.sprite = self._atlas:GetSprite(cfg.SpriteNormal)
  self._uiHighlight.sprite = self._atlas:GetSprite(cfg.SpriteHighlight)
  self._txtNormal:SetText(StringTable.Get(cfg.Name))
  self._txtHighlightShadow:SetText(StringTable.Get(cfg.Name))
  self._txtHighlight:SetText(StringTable.Get(cfg.Name))
  self._txtNormalSub:SetText(StringTable.Get(cfg.SubName))
  self._txtHighlightSub:SetText(StringTable.Get(cfg.SubName))
end

function UIN28GronruGameAlbumPage:BtnPageOnClick(go)
  self._parent:OpenPageAnimation(self._cfg)
  self:SetHighlight(true)
  self:PlayPageBtnAudio()
end

_class("UIN28GronruGameAdventurePage", UIN28GronruGameBasePage)
UIN28GronruGameAdventurePage = UIN28GronruGameAdventurePage

function UIN28GronruGameAdventurePage:Flush(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._txtNormal:SetText(StringTable.Get(cfg.Name))
  self._txtHighlightShadow:SetText(StringTable.Get(cfg.Name))
  self._txtHighlight:SetText(StringTable.Get(cfg.Name))
end

function UIN28GronruGameAdventurePage:BtnPageOnClick(go)
  self._parent:OpenPageAnimation(self._cfg)
  self:SetHighlight(true)
  self:PlayPageBtnAudio()
end
