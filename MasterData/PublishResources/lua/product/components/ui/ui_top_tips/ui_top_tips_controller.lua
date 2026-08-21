_class("UITopTipsController", UIController)
UITopTipsController = UITopTipsController

function UITopTipsController:OnShow(uiParams)
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self:UnLock("UITopTips")
  self._maskBGCanvas = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas").gameObject
  self._maskBGCanvas:SetActive(false)
  local offset = {}
  offset.x = 121
  offset.y = -30
  local enum = uiParams[1]
  local anchorPos = uiParams[2]
  local deltaPosition = uiParams[3]
  local cfg = Cfg.cfg_top_tips[enum]
  if cfg == nil then
    Log.fatal("[toptip] error --> cfg_top_tips cfg is nil ! enum --> " .. enum)
    return
  end
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._rectLayoutElement = self:GetUIComponent("LayoutElement", "rect")
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
  self._intrTex = self:GetUIComponent("UILocalizationText", "intr")
  self._icon = self:GetUIComponent("Image", "icon")
  self._titleTex:SetText(StringTable.Get(cfg.Title))
  self._intrTex:SetText(StringTable.Get(cfg.Intr))
  UIWidgetHelper.InitImageSpriteOrRaw(self, "icon", self._icon.transform.gameObject)
  UIWidgetHelper.SetImageSpriteOrRaw(self, "icon", self.atlas, cfg.Icon)
  local safeOffset = {}
  safeOffset.x = 0
  safeOffset.y = 0
  if deltaPosition ~= nil then
    self._rect.position = self._safeArea.position + deltaPosition
    anchorPos = self._rect.anchoredPosition + anchorPos
  end
  local v2 = Vector2(anchorPos.x + offset.x, offset.y + anchorPos.y)
  local safeRect = self._safeArea.rect
  local layoutElementWidth = self._rectLayoutElement.preferredWidth
  if v2.x > 0 then
    if v2.x + layoutElementWidth * 0.5 > safeRect.width * 0.5 then
      safeOffset.x = safeRect.width * 0.5 - (v2.x + layoutElementWidth * 0.5)
    end
  elseif math.abs(v2.x) + layoutElementWidth * 0.5 > safeRect.width * 0.5 then
    safeOffset.x = math.abs(v2.x) + layoutElementWidth * 0.5 - safeRect.width * 0.5
  end
  if v2.y > 0 then
    if v2.y + self._rect.sizeDelta.y * 0.5 > safeRect.height * 0.5 then
      safeOffset.y = safeRect.height * 0.5 - (v2.y + self._rect.sizeDelta.y * 0.5)
    end
  elseif math.abs(v2.y) + self._rect.sizeDelta.y * 0.5 > safeRect.height * 0.5 then
    safeOffset.y = math.abs(v2.y) + self._rect.sizeDelta.y * 0.5 - safeRect.height * 0.5
  end
  self._rect.anchoredPosition = Vector2(v2.x + safeOffset.x, safeOffset.y + v2.y)
end

function UITopTipsController:OnHide()
  self._titleTex = nil
  self._intrTex = nil
  self._icon = nil
  self._rect = nil
  if self._maskBGCanvas then
    self._maskBGCanvas:SetActive(true)
  end
  self:UnLock("UITopTips")
end

function UITopTipsController:bgOnClick()
  self:CloseDialog()
end

function UITopTipsController:Update()
end
