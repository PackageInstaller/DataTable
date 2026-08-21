_class("UISeasonS1CollageCollectionItem", UICustomWidget)
UISeasonS1CollageCollectionItem = UISeasonS1CollageCollectionItem

function UISeasonS1CollageCollectionItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS1CollageCollectionItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.unlockIcon = self:GetGameObject("unlockIcon")
  self.new = self:GetGameObject("new")
  self.iconImage = self:GetUIComponent("RawImage", "icon")
  self.select = self:GetGameObject("select")
  self.root = self:GetUIComponent("RectTransform", "Root")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonS1CollageCollectionItem:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self:SetNew(data:IsNew())
  local cfg = Cfg.cfg_item_season_collection[data:ID()]
  self.icon:LoadImage(cfg.HdImage)
  if data:IsGot() then
    self.icon:SetColor(Color.white)
    self.unlockIcon:SetActive(false)
    if data:IsComposeUsed() then
      self.icon:SetColor(Color(0.32941176470588235, 0.20784313725490197, 0.12549019607843137, 0.7))
    end
  else
    self.icon:SetColor(Color(0, 0, 0, 0.8))
    self.unlockIcon:SetActive(true)
  end
  self:SetSelect(false)
end

function UISeasonS1CollageCollectionItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS1CollageCollectionItem:SetNew(new)
  self._isNew = new
  self.new:SetActive(new)
end

function UISeasonS1CollageCollectionItem:SetSelect(select)
  self._anim:Stop()
  if select then
    self.select:SetActive(true)
    self._anim:Stop()
    self._anim:Play("uieffanim_UISeasonS1CollageCollectionItem_in")
  else
    self.select:SetActive(false)
    self._anim:Stop()
    self._anim:Play("uieffanim_UISeasonS1CollageCollectionItem_out")
  end
end

function UISeasonS1CollageCollectionItem:PlayExitAnim()
  self._anim:Play("uieffanim_UISeasonS1CollageCollectionItem_out")
end
