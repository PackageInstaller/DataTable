_class("UIItemTips", UIController)
UIItemTips = UIItemTips

function UIItemTips:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
end

function UIItemTips:OnShow(uiParams)
  self.ra = uiParams[1]
  self.go = uiParams[2]
  self.uiName = uiParams[3]
  self.uiCamera = GameGlobal.UIStateManager():GetControllerCamera(self.uiName)
  self.bg = self:GetGameObject("bg")
  local passEvent = self.bg:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:closeOnClick()
  end)
  self.black_mask = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas/black_mask"):GetComponent(typeof(UnityEngine.UI.Image))
  self.black_mask.raycastTarget = false
  self.rect = self:GetUIComponent("RectTransform", "rect")
  self.itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self:Flush()
  self:FlushPos()
end

function UIItemTips:OnHide()
  self.black_mask.raycastTarget = true
end

function UIItemTips:Flush()
  local tpl = Cfg.cfg_item[self.ra.assetid]
  local ui = self.itemPool:SpawnObject("UIItem")
  ui:SetForm(UIItemForm.Base)
  ui:SetData({
    text1 = self.ra.count,
    icon = tpl.Icon,
    itemId = tpl.ID,
    quality = tpl.Color
  })
  self.txtName:SetText(StringTable.Get(tpl.Name))
  self.txtDesc:SetText(StringTable.Get(tpl.Intro))
end

function UIItemTips:FlushPos()
  if self.go then
    local posScreen = self.uiCamera:WorldToScreenPoint(self.go.transform.position)
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.rect.parent, posScreen, camera, nil)
    self.rect.anchoredPosition = pos
  end
end

function UIItemTips:closeOnClick()
  self:CloseDialog()
end
