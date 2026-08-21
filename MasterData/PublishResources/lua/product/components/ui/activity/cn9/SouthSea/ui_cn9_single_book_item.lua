_class("UICN9SingleBookItem", UICustomWidget)
UICN9SingleBookItem = UICN9SingleBookItem

function UICN9SingleBookItem:OnShow(uiParams)
  self:InitWidget()
  self.itemModule = GameGlobal.GetModule(ItemModule)
end

function UICN9SingleBookItem:InitWidget()
  self.itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self.itemNameText = self:GetUIComponent("UILocalizationText", "ItemNameText")
  self.itemObj = self:GetGameObject("Item")
  self.mask = self:GetGameObject("mask")
  self.new = self:GetGameObject("new")
end

function UICN9SingleBookItem:SetData(id)
  local cfg = Cfg.cfg_south_sea_antique[id]
  self._name = cfg.Name
  self._Icon = cfg.Icon
  self._ItemID = cfg.ItemID
  self._Intro = cfg.Intro
  local own = self:CheckHave()
  self.itemObj:SetActive(own)
  self.mask:SetActive(not own)
  self:RefreshNew()
  if own then
    self.itemNameText:SetText(StringTable.Get(self._name))
  else
    self.itemNameText:SetText(StringTable.Get("str_activity_intro_lock"))
  end
  self.itemIcon:LoadImage(self._Icon)
end

function UICN9SingleBookItem:BgOnClick(go)
  if not self:CheckHave() then
    return
  end
  self.new:SetActive(false)
  self:StartTask(function(TT)
    local pstID = self.item:GetID()
    self.itemModule:SetItemUnnewOverlay(TT, pstID)
    self.itemModule:SetItemUnnew(TT, pstID)
  end)
  self:ShowDialog("UIActivityCN9BookDetailPop", self._name, self._Icon, self._Intro)
end

function UICN9SingleBookItem:CheckHave()
  local count = self.itemModule:GetItemCount(self._ItemID)
  if not count or count == 0 then
    return false
  else
    self.itemObj:SetActive(true)
    self.mask:SetActive(false)
    return true
  end
end

function UICN9SingleBookItem:RefreshNew()
  local items = self.itemModule:GetItemByTempId(self._ItemID)
  self.new:SetActive(false)
  if table.count(items) <= 0 then
    return
  end
  for _, v in pairs(items) do
    self.item = v
  end
  if self.item and self.item:IsNewOverlay() then
    self.hasRed = true
    self.new:SetActive(true)
  end
end
