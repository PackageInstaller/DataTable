_class("UIBookRoleMapOverviewItem", UICustomWidget)
UIBookRoleMapOverviewItem = UIBookRoleMapOverviewItem

function UIBookRoleMapOverviewItem:Constructor()
end

function UIBookRoleMapOverviewItem:OnShow()
  self:_GetComponents()
end

function UIBookRoleMapOverviewItem:_GetComponents()
  self._icon = self:GetUIComponent("Image", "Icon")
  self._name = self:GetUIComponent("UILocalizedTMP", "Name")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "anim")
  self._rect = self:GetUIComponent("RectTransform", "bg")
  self._owner = self:RootUIOwner()
  self._altas = self._owner.altas
  self._req = ResourceManager:GetInstance():SyncLoadAsset("ui_book_role_map_font.mat", LoadType.Mat)
  if self._req and self._req.Obj then
    self.material = self._req.Obj
    local oldMaterial = self._name.fontMaterial
    self._name.fontMaterial = self.material
    self._name.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  end
end

function UIBookRoleMapOverviewItem:SetData(cfg, index, callback)
  self._cfg = cfg
  self._index = index
  self._callback = callback
  self:_InitComponents()
end

function UIBookRoleMapOverviewItem:PlayInAnimation()
  local yieldTime = 100
  self:StartTask(function(TT)
    self:Lock("UIBookRoleMapOverviewItem:PlayInAnimation" .. self._index)
    YIELD(TT, (self._index - 1) * yieldTime)
    self._anim:Play("uianim_UIBookRoleMapOverviewItem_in")
    self:UnLock("UIBookRoleMapOverviewItem:PlayInAnimation" .. self._index)
  end)
end

function UIBookRoleMapOverviewItem:ResetAnim()
  self._canvasGroup.alpha = 0
  self._rect.anchoredPosition = Vector2(0, -20)
end

function UIBookRoleMapOverviewItem:_InitComponents()
  self._icon.sprite = self._altas:GetSprite(self._cfg.ForceIcon)
  self._name:SetText(StringTable.Get(self._cfg.Name))
end

function UIBookRoleMapOverviewItem:GoBtnOnClick()
  if self._callback then
    self._callback(self._cfg.Tags)
  end
end
