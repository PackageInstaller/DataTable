_class("UIBookRoleMapPointItem", UICustomWidget)
UIBookRoleMapPointItem = UIBookRoleMapPointItem

function UIBookRoleMapPointItem:Constructor()
  self._isSelect = false
  self._size = {
    Vector2(280, 280),
    Vector2(280, 280)
  }
end

function UIBookRoleMapPointItem:OnShow()
  self:_GetComponents()
end

function UIBookRoleMapPointItem:_GetComponents()
  self._pointIcon = self:GetUIComponent("RawImageLoader", "PointIcon")
  self._name = self:GetUIComponent("UILocalizedTMP", "Name")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._layout = self:GetUIComponent("LayoutElement", "rect")
  self._bg = self:GetUIComponent("Image", "bg")
  self._txtBg = self:GetUIComponent("Image", "txtBg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._owner = self:RootUIOwner()
  self._altas = self._owner.altas
end

function UIBookRoleMapPointItem:SetData(pointData, callback)
  self._pointData = pointData
  self._callback = callback
  self:_InitComponents()
end

function UIBookRoleMapPointItem:_InitComponents()
  if self._pointData.type == BookRoleMapPointType.ClassA then
    self._cfg = Cfg.cfg_force_book[self._pointData.id]
    self._rect.sizeDelta = self._size[1]
  else
    self._cfg = Cfg.cfg_force_book_second[self._pointData.id]
    self._rect.sizeDelta = self._size[2]
  end
  self._pointIcon:LoadImage(self._cfg.MapIcon)
  self._name:SetText(StringTable.Get(self._cfg.Name))
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
  self._rect.anchoredPosition = Vector2(self._cfg.Pos[1] / 100, self._cfg.Pos[2] / 100)
  self._req = ResourceManager:GetInstance():SyncLoadAsset("ui_book_role_map_font.mat", LoadType.Mat)
  if self._req and self._req.Obj then
    self.material = self._req.Obj
    local oldMaterial = self._name.fontMaterial
    self._name.fontMaterial = self.material
    self._name.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  end
end

function UIBookRoleMapPointItem:SetSelect(isSelect)
  if self._isSelect == isSelect then
    return
  end
  self._isSelect = isSelect
  if isSelect then
    self._bg.sprite = self._altas:GetSprite("n9_rsqb_di06")
    self._txtBg.sprite = self._altas:GetSprite("n9_rsqb_di12")
    self._rect.localScale = Vector3(1.1, 1.1, 1.1)
    self._anim:Play("uianim_UIBookRoleMapPointItem_xuanze_in")
  else
    self._bg.sprite = self._altas:GetSprite("n9_rsqb_di05")
    self._txtBg.sprite = self._altas:GetSprite("n9_rsqb_di11")
    self._rect.localScale = Vector3(1, 1, 1)
    self._anim:Play("uianim_UIBookRoleMapPointItem_xuanze_out")
  end
end

function UIBookRoleMapPointItem:FullBtnOnClick()
  if self._callback then
    self._callback(self._cfg, self)
  end
end
