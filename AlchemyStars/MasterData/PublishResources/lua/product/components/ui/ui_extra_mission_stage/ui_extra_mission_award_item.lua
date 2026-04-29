_class("UIExtraMisionAwardItem", UICustomWidget)
UIExtraMisionAwardItem = UIExtraMisionAwardItem

function UIExtraMisionAwardItem:OnShow()
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._txt3Star = self:GetUIComponent("UILocalizationText", "txt3Star")
  self._imgType = self:GetGameObject("imgType")
  self._trans = self:GetGameObject()
end

function UIExtraMisionAwardItem:Flush(v)
  if not v then
    return
  end
  self._v = v
  self._imgIcon:LoadImage(v.icon)
  if self._txtName then
    self._txtName.text = v.name
  end
  if self._txtCount then
    self._txtCount.text = "X" .. v.count
  end
  if self._txt3Star then
    local strKey = ""
    if v.type == StageAwardType.Star then
      strKey = "str_discovery_3star_award"
    else
      strKey = "str_discovery_normal_award"
    end
    self._txt3Star.text = StringTable.Get(strKey)
  end
  if self._qualityIcon then
    local frameName = UIEnum.ItemColorFrame(v.color)
    if frameName ~= "" then
      local _uiItemAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
      self._qualityIcon.gameObject:SetActive(true)
      self._qualityIcon.sprite = _uiItemAtlas:GetSprite(frameName)
    else
      self._qualityIcon.gameObject:SetActive(false)
    end
  end
  if self._imgType then
    self._imgType:SetActive(v.type ~= StageAwardType.Normal)
  end
end

function UIExtraMisionAwardItem:bgOnClick(go)
  if self._v then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._v.id, self._trans.transform.position)
  end
end
