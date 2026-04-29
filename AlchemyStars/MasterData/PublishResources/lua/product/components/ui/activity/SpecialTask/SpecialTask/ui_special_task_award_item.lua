_class("UISpecialTaskAwardItem", UICustomWidget)
UISpecialTaskAwardItem = UISpecialTaskAwardItem

function UISpecialTaskAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UISpecialTaskAwardItem:_GetComponents()
  self._bg = self:GetUIComponent("Image", "bg")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._CountBg = self:GetUIComponent("Image", "CountBg")
end

function UISpecialTaskAwardItem:SetData(roleAsset, callback, lock, id)
  self.roleAsset = roleAsset
  self._callback = callback
  self._lock = lock
  self._id = id
  local cfg = Cfg.cfg_item[roleAsset[1]]
  local icon = cfg.Icon
  local count = roleAsset[2]
  self._imgIcon:LoadImage(icon)
  self._txtCount:SetText(self:FormatCount(count))
  self:_SetImage()
end

function UISpecialTaskAwardItem:_SetImage()
  local cfg = Cfg.cfg_special_task[self._id]
  local atlasName = cfg.Atlas .. ".spriteatlas"
  self._atlas = self:GetAsset(atlasName, LoadType.SpriteAtlas)
  if not self._atlas then
    return
  end
  self._bg.sprite = self._atlas:GetSprite(cfg.AwardBG)
  self._CountBg.sprite = self._atlas:GetSprite(cfg.AwardCountBG)
end

function UISpecialTaskAwardItem:ImgIconOnClick(go)
  if not self._lock and self._callback then
    self._callback(self.roleAsset[1], go.transform.position)
  end
end

function UISpecialTaskAwardItem:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
