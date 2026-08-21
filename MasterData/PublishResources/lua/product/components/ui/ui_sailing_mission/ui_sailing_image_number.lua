_class("UISailingImageNumber", Object)
UISailingImageNumber = UISailingImageNumber

function UISailingImageNumber:Constructor(uiController, spriteFormat)
  self._uiController = uiController
  self._atlasNumber = uiController:GetAsset("UISailing.spriteatlas", LoadType.SpriteAtlas)
  self._spriteFormat = spriteFormat
  self._imgList = {}
  self._displayValue = 0
end

function UISailingImageNumber:AddDigitImage(inImage)
  table.insert(self._imgList, inImage)
end

function UISailingImageNumber:SetValue(inNumber)
  local count = #self._imgList
  for i = 1, count do
    local bit = math.floor(inNumber) % 10
    inNumber = inNumber / 10
    local spriteName = string.format(self._spriteFormat, bit)
    local img = self._imgList[i]
    img.sprite = self._atlasNumber:GetSprite(spriteName)
  end
  self._displayValue = inNumber
end
