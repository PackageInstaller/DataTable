_class("UISeasonS4CollageBtn", UICustomWidget)
UISeasonS4CollageBtn = UISeasonS4CollageBtn

function UISeasonS4CollageBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS4CollageBtn:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.text = self:GetUIComponent("UILocalizationText", "Text")
  self.count = self:GetUIComponent("UILocalizationText", "Count")
  self.root = self:GetUIComponent("Image", "Root")
  self.newGo = self:GetGameObject("New")
  self.iconBG = self:GetUIComponent("Image", "IconBG")
  self._selectObj = self:GetGameObject("Select")
end

function UISeasonS4CollageBtn:SetData(type, onClick, data)
  self._type = type
  self._onClick = onClick
  self._data = data
  self._select = false
  local format = "%s/%s"
  if self._type == 1 then
  elseif self._type == 2 then
    self.text:SetText(StringTable.Get("str_season_s4_cg"))
    local cur, total = self._data:GetCgProgress()
    self.count:SetText(string.format(format, cur, total))
  elseif self._type == 3 then
    self.text:SetText(StringTable.Get("str_season_s4_music"))
    local cur, total = self._data:GetMusicProgress()
    self.count:SetText(string.format(format, cur, total))
  end
  self:RefreshNew()
end

function UISeasonS4CollageBtn:SetSelect(select)
  self._select = select
  local atlas = self:GetAsset("UIS4Collages.spriteatlas", LoadType.SpriteAtlas)
  if self._select then
    self.root.sprite = atlas:GetSprite("exp_s4_book_yeqian7")
  else
    self.root.sprite = atlas:GetSprite("exp_s4_book_yeqian8")
  end
  self._selectObj:SetActive(self._select)
  if self._type == 1 then
  elseif self._type == 2 then
    self.icon.sprite = atlas:GetSprite("exp_s4_book_yeqian3")
    self.iconBG.sprite = atlas:GetSprite("exp_s4_book_yeqian4")
  elseif self._type == 3 then
    self.icon.sprite = atlas:GetSprite("exp_s4_book_yeqian1")
    self.iconBG.sprite = atlas:GetSprite("exp_s4_book_yeqian2")
  end
end

function UISeasonS4CollageBtn:RefreshNew()
  local new = false
  if self._type == 1 then
  elseif self._type == 2 then
    new = self._data:CGHasNew()
  elseif self._type == 3 then
    new = self._data:MusicHasNew()
  end
  self.newGo:SetActive(new)
end

function UISeasonS4CollageBtn:RootOnClick(go)
  self._onClick()
end
