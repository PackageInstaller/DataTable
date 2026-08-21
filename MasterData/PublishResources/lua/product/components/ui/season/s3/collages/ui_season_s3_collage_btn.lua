_class("UISeasonS3CollageBtn", UICustomWidget)
UISeasonS3CollageBtn = UISeasonS3CollageBtn

function UISeasonS3CollageBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS3CollageBtn:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.text = self:GetUIComponent("UILocalizationText", "Text")
  self.count = self:GetUIComponent("UILocalizationText", "Count")
  self.root = self:GetUIComponent("Image", "Root")
  self.newGo = self:GetGameObject("New")
end

function UISeasonS3CollageBtn:SetData(type, onClick, data)
  self._type = type
  self._onClick = onClick
  self._data = data
  self._select = false
  local format = "%s/%s"
  if self._type == 1 then
    self.text:SetText(StringTable.Get("str_season_s3_collection"))
    local cur, total = self._data:GetCollectionProgress()
    self.count:SetText(string.format(format, cur, total))
  elseif self._type == 2 then
    self.text:SetText(StringTable.Get("str_season_s3_cg"))
    local cur, total = self._data:GetCgProgress()
    self.count:SetText(string.format(format, cur, total))
  elseif self._type == 3 then
    self.text:SetText(StringTable.Get("str_season_s3_music"))
    local cur, total = self._data:GetMusicProgress()
    self.count:SetText(string.format(format, cur, total))
  end
  self:RefreshNew()
end

function UISeasonS3CollageBtn:SetSelect(select)
  self._select = select
  local atlas = self:GetAsset("UIS3Collages.spriteatlas", LoadType.SpriteAtlas)
  if self._select then
    self.root.sprite = atlas:GetSprite("exp_s3_book_yeqian7")
    self.text.color = Color.white
    self.count.color = Color.white
  else
    self.root.sprite = atlas:GetSprite("exp_s3_book_yeqian8")
    self.text.color = Color(0.369, 0.6, 0.776, 1)
    self.count.color = Color(0.369, 0.6, 0.776, 1)
  end
  if self._type == 1 then
    if self._select then
      self.icon.sprite = atlas:GetSprite("exp_s3_book_yeqian1")
    else
      self.icon.sprite = atlas:GetSprite("exp_s3_book_yeqian4")
    end
  elseif self._type == 2 then
    if self._select then
      self.icon.sprite = atlas:GetSprite("exp_s3_book_yeqian2")
    else
      self.icon.sprite = atlas:GetSprite("exp_s3_book_yeqian5")
    end
  elseif self._type == 3 then
    if self._select then
      self.icon.sprite = atlas:GetSprite("exp_s3_book_yeqian3")
    else
      self.icon.sprite = atlas:GetSprite("exp_s3_book_yeqian6")
    end
  end
end

function UISeasonS3CollageBtn:RefreshNew()
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

function UISeasonS3CollageBtn:RootOnClick(go)
  self._onClick()
end
