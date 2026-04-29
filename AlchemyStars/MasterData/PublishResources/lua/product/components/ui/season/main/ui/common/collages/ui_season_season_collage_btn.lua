_class("UISeasonSeasonCollageBtn", UICustomWidget)
UISeasonSeasonCollageBtn = UISeasonSeasonCollageBtn

function UISeasonSeasonCollageBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonSeasonCollageBtn:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.text = self:GetUIComponent("UILocalizationText", "Text")
  self.count = self:GetUIComponent("UILocalizationText", "Count")
  self.root = self:GetUIComponent("Image", "Root")
  self.newGo = self:GetGameObject("New")
  self.iconBG = self:GetUIComponent("Image", "IconBG")
  self._selectObj = self:GetGameObject("Select")
end

function UISeasonSeasonCollageBtn:SetData(type, onClick, data)
  self._type = type
  self._onClick = onClick
  self._data = data
  self._select = false
  local cfg = UISeasonHelper.GetCurCollectionCfg()
  local tabNames
  if cfg then
    tabNames = cfg.TabBtnNames
  else
    Log.error("UISeasonSeasonCollageBtn can'f find collectionCfg ")
    return
  end
  local format = "%s/%s"
  if self._type == 1 then
  elseif self._type == 2 then
    self.text:SetText(StringTable.Get(tabNames[self._type]))
    local cur, total = self._data:GetCgProgress()
    self.count:SetText(string.format(format, cur, total))
  elseif self._type == 3 then
    self.text:SetText(StringTable.Get(tabNames[self._type]))
    local cur, total = self._data:GetMusicProgress()
    self.count:SetText(string.format(format, cur, total))
  end
  self:RefreshNew()
end

function UISeasonSeasonCollageBtn:SetSelect(select)
  self._select = select
  local atlas = self:GetAsset("UISeasonCollages.spriteatlas", LoadType.SpriteAtlas)
  if self._select then
  else
  end
  self._selectObj:SetActive(self._select)
  if self._type == 1 then
  elseif self._type == 2 then
    self.icon.sprite = atlas:GetSprite("exp_tongyong_book_yeqian2")
  elseif self._type == 3 then
    self.icon.sprite = atlas:GetSprite("exp_tongyong_book_yeqian3")
  end
end

function UISeasonSeasonCollageBtn:RefreshNew()
  local new = false
  if self._type == 1 then
  elseif self._type == 2 then
    new = self._data:CGHasNew()
  elseif self._type == 3 then
    new = self._data:MusicHasNew()
  end
  self.newGo:SetActive(new)
end

function UISeasonSeasonCollageBtn:RootOnClick(go)
  self._onClick()
end
