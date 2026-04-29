_class("UIBookRoleEntryCell", Object)
UIBookRoleEntryCell = UIBookRoleEntryCell

function UIBookRoleEntryCell:Constructor()
end

function UIBookRoleEntryCell:InitComponent(uiView)
  self.uiView = uiView
  self.nameTxt = self.uiView:GetUIComponent("UILocalizationText", "name")
  self.picImg = self.uiView:GetUIComponent("Image", "pic")
  self.picGO = self.uiView:GetGameObject("pic")
  self.selectImg = self.uiView:GetUIComponent("Image", "press")
  self.btnSelect = self.uiView:GetGameObject("press")
  self._uiCustomEventListner = UICustomUIEventListener:New()
  self._uiCustomEventListner:AddUICustomEventListener(UICustomUIEventListener.Get(self.picGO), UIEvent.Press, function(go)
    self.btnSelect:SetActive(true)
  end)
  self._uiCustomEventListner:AddUICustomEventListener(UICustomUIEventListener.Get(self.picGO), UIEvent.Release, function(go)
    self.btnSelect:SetActive(false)
  end)
  self._uiCustomEventListner:AddUICustomEventListener(UICustomUIEventListener.Get(self.picGO), UIEvent.Click, function(go)
    GameGlobal.UIStateManager():ShowDialog("UIBookRoleRelationController", self.id)
  end)
end

function UIBookRoleEntryCell:Refresh(uiView, atlas, id)
  self:InitComponent(uiView)
  self.id = id
  local cfg = Cfg.cfg_pet_tags[id]
  self.nameTxt:SetText(StringTable.Get(cfg.Name))
  self.picImg.sprite = atlas:GetSprite(cfg.SpriteIcon)
  local icon = string.split(cfg.SpriteIcon, "_")
  local num = string.sub(icon[3], 5, 6)
  local new = icon[1] .. "_" .. icon[2] .. "_" .. "guang" .. num
  self.selectImg.sprite = atlas:GetSprite(new)
end

function UIBookRoleEntryCell:OnHide()
  self._uiCustomEventListner:Dispose()
end
