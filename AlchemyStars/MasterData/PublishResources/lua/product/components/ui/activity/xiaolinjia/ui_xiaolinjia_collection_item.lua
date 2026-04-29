_class("UIXiaoLinJiaCollectionItem", UICustomWidget)
UIXiaoLinJiaCollectionItem = UIXiaoLinJiaCollectionItem

function UIXiaoLinJiaCollectionItem:OnShow(uiParams)
  self.atlas = self:RootUIOwner():GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.icon = self:GetUIComponent("Image", "icon")
  self.unlockBG = self:GetGameObject("unlockBG")
  self.lockBG = self:GetGameObject("lockBG")
  self.red = self:GetGameObject("red")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.isLock = false
  self.hasRed = false
end

function UIXiaoLinJiaCollectionItem:SetData(cfg, uiController)
  self.cfg = cfg
  self.uiController = uiController
  self.itemId = self.cfg.ItemID
  self.itemModule = GameGlobal.GetModule(ItemModule)
  local items = self.itemModule:GetItemByTempId(self.itemId)
  for _, v in pairs(items) do
    self.item = v
  end
  if self.item then
    if self.item:IsNewOverlay() then
      self.hasRed = true
      self.red:SetActive(true)
    end
    self.isLock = false
  else
    self.isLock = true
  end
  self.unlockBG:SetActive(not self.isLock)
  self.lockBG:SetActive(self.isLock)
  self.icon.sprite = self.atlas:GetSprite(self.cfg.Icon)
end

function UIXiaoLinJiaCollectionItem:SetUnNew()
  self:StartTask(function(TT)
    local pstID = self.item:GetID()
    self.itemModule:SetItemUnnewOverlay(TT, pstID)
    self.itemModule:SetItemUnnew(TT, pstID)
    self.red:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnXiaoLinJiaMainPanelRefresh, true)
  end)
end

function UIXiaoLinJiaCollectionItem:BtnOnClick()
  if self.hasRed then
    self:SetUnNew()
  end
  self.uiController:OnSelectCollection(self.cfg.ID, self.isLock)
end

function UIXiaoLinJiaCollectionItem:OnSelect(last, current)
  if last == self.cfg.ID then
    self.anim:Play("uieff_UIXiaoLinJiaCollectionItem_unselect")
  end
  if current == self.cfg.ID then
    self.anim:Play("uieff_UIXiaoLinJiaCollectionItem_select")
  end
end
