_class("UIStageTopItem", UICustomWidget)
UIStageTopItem = UIStageTopItem

function UIStageTopItem:OnShow()
  self.bg2 = self:GetGameObject("bg2")
  self.bg1 = self:GetGameObject("bg1")
  self.icon = self:GetUIComponent("Image", "icon")
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self.btn = self:GetGameObject("btn")
  self.bg2img = self:GetUIComponent("Image", "bg2")
  self.bg1img = self:GetUIComponent("Image", "bg1")
  self._atlas = self:GetAsset("UIStageItem.spriteatlas", LoadType.SpriteAtlas)
end

function UIStageTopItem:SetData(id, sprite, txt, iconClick, callback, isBetween)
  self.id = id
  if callback then
    self.bg1:SetActive(true)
    self.bg2:SetActive(false)
    self.btn:SetActive(true)
    local sprite
    if isBetween then
      sprite = "spirit_touming4_frame"
    else
      sprite = "map_guanqia_ludian44"
    end
    self.bg1img.sprite = self._atlas:GetSprite(sprite)
  else
    self.bg2:SetActive(true)
    self.bg1:SetActive(false)
    self.btn:SetActive(false)
    local sprite
    if isBetween then
      sprite = "map_guanqia_ludian39"
    else
      sprite = "map_guanqia_ludian37"
    end
    self.bg2img.sprite = self._atlas:GetSprite(sprite)
  end
  self.icon.sprite = sprite
  self.txt:SetText(txt)
  self.callback = callback
  self.iconClick = iconClick
end

function UIStageTopItem:SetText(txt)
  self.txt:SetText(txt)
end

function UIStageTopItem:BtnOnClick(go)
  if self.callback then
    self.callback(self.id, go)
  end
end

function UIStageTopItem:IconOnClick(go)
  if self.iconClick then
    self.iconClick(self.id, go)
  end
end

function UIStageTopItem:SetBgCallBack(bgCallback)
  self.bgCallback = bgCallback
end

function UIStageTopItem:BgOnClick(go)
  if self.bgCallback then
  end
end
