_class("UISeasonS2CollageBtn", UICustomWidget)
UISeasonS2CollageBtn = UISeasonS2CollageBtn

function UISeasonS2CollageBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS2CollageBtn:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.text = self:GetUIComponent("UILocalizationText", "Text")
  self.count = self:GetUIComponent("UILocalizationText", "Count")
  self.root = self:GetUIComponent("Image", "Root")
  self.newGo = self:GetGameObject("New")
end

function UISeasonS2CollageBtn:SetData(type, onClick, data)
  self._type = type
  self._onClick = onClick
  self._data = data
  self._select = false
  local format = "%s/%s"
  if self._type == 1 then
    self.text:SetText(StringTable.Get("str_season_s1_collection"))
    local cur, total = self._data:GetCollectionProgress()
    self.count:SetText(string.format(format, cur, total))
  elseif self._type == 2 then
    self.text:SetText(StringTable.Get("str_season_s1_cg"))
    local cur, total = self._data:GetCgProgress()
    self.count:SetText(string.format(format, cur, total))
  elseif self._type == 3 then
    self.text:SetText(StringTable.Get("str_season_s1_music"))
    local cur, total = self._data:GetMusicProgress()
    self.count:SetText(string.format(format, cur, total))
  end
  self:RefreshNew()
end

function UISeasonS2CollageBtn:SetSelect(select)
  self._select = select
  local atlas = self:GetAsset("UIS2Collages.spriteatlas", LoadType.SpriteAtlas)
  if self._select then
    self.root.sprite = atlas:GetSprite("exp_s2_book_yeqian7")
    self.text.color = Color(1, 0.9882352941176471, 0.9176470588235294)
    self.count.color = Color(0.3058823529411765, 0.20392156862745098, 0.11764705882352941)
  else
    self.root.sprite = atlas:GetSprite("exp_s2_book_yeqian8")
    self.text.color = Color(0.3058823529411765, 0.20392156862745098, 0.11764705882352941)
    self.count.color = Color(1, 0.9882352941176471, 0.9176470588235294)
  end
  if self._type == 1 then
    if self._select then
      self.icon.sprite = atlas:GetSprite("exp_s2_book_yeqian1")
    else
      self.icon.sprite = atlas:GetSprite("exp_s2_book_yeqian4")
    end
  elseif self._type == 2 then
    if self._select then
      self.icon.sprite = atlas:GetSprite("exp_s2_book_yeqian2")
    else
      self.icon.sprite = atlas:GetSprite("exp_s2_book_yeqian5")
    end
  elseif self._type == 3 then
    if self._select then
      self.icon.sprite = atlas:GetSprite("exp_s2_book_yeqian3")
    else
      self.icon.sprite = atlas:GetSprite("exp_s2_book_yeqian6")
    end
  end
end

function UISeasonS2CollageBtn:RefreshNew()
  local new = false
  if self._type == 1 then
    new = self._data:CollectionHasNew()
  elseif self._type == 2 then
    new = self._data:CGHasNew()
  elseif self._type == 3 then
    new = self._data:MusicHasNew()
  end
  self.newGo:SetActive(new)
end

function UISeasonS2CollageBtn:RootOnClick(go)
  self._onClick()
end
