_class("UIColorBlindItem", UICustomWidget)
UIColorBlindItem = UIColorBlindItem

function UIColorBlindItem:OnShow()
  self.img = self:GetUIComponent("RawImageLoader", "img")
  self.imgSelect = self:GetUIComponent("Image", "imgSelect")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.red = self:GetGameObject("red")
  self.mask = self:GetGameObject("mask")
  self:AttachEvent(GameEventType.ColorBlindSelect, self.FlushSelect)
end

function UIColorBlindItem:OnHide()
  self:DetachEvent(GameEventType.ColorBlindSelect, self.FlushSelect)
end

function UIColorBlindItem:Flush(cfg, clickCallback)
  self.cfg = cfg
  self.itemID = cfg.ID
  self.isNew = cfg.isNew
  self.red:SetActive(self.isNew)
  self.notGet = cfg.notGet
  self.mask:SetActive(self.notGet)
  self.clickCallback = clickCallback
  self.img:LoadImage(cfg.icon)
  local chessItemCfgs = Cfg.cfg_item({
    ID = cfg.ID
  })
  self.txtName:SetText(StringTable.Get(chessItemCfgs[1].Name))
  self:FlushSelect(nil)
end

function UIColorBlindItem:FlushSelect(id)
  self.imgSelect.gameObject:SetActive(self.itemID == id)
end

function UIColorBlindItem:SetUnNew()
  self:StartTask(function(TT)
    self.itemModule = GameGlobal.GetModule(ItemModule)
    local items = self.itemModule:GetItemByTempId(self.itemID)
    for _, vitem in pairs(items) do
      self.item = vitem
    end
    if self.item then
      local pstID = self.item:GetID()
      self.itemModule:SetItemUnnewOverlay(TT, pstID)
      self.itemModule:SetItemUnnew(TT, pstID)
      self.red:SetActive(false)
      self.isNew = false
    end
  end)
end

function UIColorBlindItem:imgOnClick(go)
  if self.clickCallback then
    self.clickCallback()
  end
  if self.isNew then
    self:SetUnNew()
  end
end
