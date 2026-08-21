_class("UIHomeTopTips", UIController)
UIHomeTopTips = UIHomeTopTips

function UIHomeTopTips:OnShow(uiParams)
  local enum = uiParams[1]
  self.go = uiParams[2]
  self.uiName = uiParams[3]
  self.uiCamera = GameGlobal.UIStateManager():GetControllerCamera(self.uiName)
  local cfg = Cfg.cfg_top_tips[enum]
  if cfg == nil then
    Log.fatal("[toptip] error --> cfg is nil ! enum --> " .. enum)
    return
  end
  self.bg = self:GetGameObject("bg")
  local passEvent = self.bg:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:bgOnClick()
  end)
  self._black_mask = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas/black_mask"):GetComponent(typeof(UnityEngine.UI.Image))
  self._black_mask.raycastTarget = false
  self.rect = self:GetUIComponent("RectTransform", "rect")
  local layoutElement = self:GetUIComponent("LayoutElement", "rect")
  self.width = layoutElement.preferredWidth
  self.imgIcon = self:GetUIComponent("Image", "imgIcon")
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.imgIcon.sprite = self.atlas:GetSprite(cfg.Icon)
  self.txtTitle:SetText(StringTable.Get(cfg.Title))
  self.txtDesc:SetText(StringTable.Get(cfg.Intr))
  self:FlushPos()
end

function UIHomeTopTips:FlushPos()
  if self.go then
    local posScreen = self.uiCamera:WorldToScreenPoint(self.go.transform.position)
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.rect.parent, posScreen, camera, nil)
    self.rect.anchoredPosition = pos
  end
end

function UIHomeTopTips:OnHide()
  self._black_mask.raycastTarget = true
end

function UIHomeTopTips:bgOnClick()
  self:CloseDialog()
end
