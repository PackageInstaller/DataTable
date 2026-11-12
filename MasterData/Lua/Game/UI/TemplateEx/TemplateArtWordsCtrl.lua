local TemplateArtWordsCtrl = class("TemplateArtWordsCtrl", BaseCtrl)
local NumberEnum = {
  [0] = {
    level = "zs_vestige_level_0"
  },
  [1] = {
    level = "zs_vestige_level_1"
  },
  [2] = {
    level = "zs_vestige_level_2"
  },
  [3] = {
    level = "zs_vestige_level_3"
  },
  [4] = {
    level = "zs_vestige_level_4"
  },
  [5] = {
    level = "zs_vestige_level_5"
  },
  [6] = {
    level = "zs_vestige_level_6"
  },
  [7] = {
    level = "zs_vestige_level_7"
  },
  [8] = {
    level = "zs_vestige_level_8"
  },
  [9] = {
    level = "zs_vestige_level_9"
  }
}
local FontType = {Bold = 1, Level = 2}
TemplateArtWordsCtrl._mapNodeConfig = {
  imgNum = {sComponentName = "Image", nCount = 3}
}
TemplateArtWordsCtrl._mapEventConfig = {}

function TemplateArtWordsCtrl:SetText(nCount, nType)
  if nCount == nil then
    printError("设置失败, 内容为nil")
    return
  end
  if type(nCount) == "number" then
    self:SetNum(nCount, nType)
  else
    self:SetPunctuation(nCount, nType)
  end
end

function TemplateArtWordsCtrl:SetNum(nCount, nType)
  if nCount < 0 or 999 < nCount then
    printError("设置数字失败, 数字区间0~999, 当前数字: " .. nCount)
    return
  end
  local nHundreds, _ = math.modf(nCount / 100 % 10)
  local nTens, _ = math.modf(nCount / 10 % 10)
  local nOnes, _ = math.modf(nCount % 10)
  if 0 < nHundreds then
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgNum[1], self:GetSpriteByFontStyle(nType, nHundreds))
    NovaAPI.SetImageNativeSize(self._mapNode.imgNum[1])
    self._mapNode.imgNum[1].gameObject:SetActive(true)
  else
    self._mapNode.imgNum[1].gameObject:SetActive(false)
  end
  if 0 < nHundreds or 0 < nTens then
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgNum[2], self:GetSpriteByFontStyle(nType, nTens))
    NovaAPI.SetImageNativeSize(self._mapNode.imgNum[2])
    self._mapNode.imgNum[2].gameObject:SetActive(true)
  else
    self._mapNode.imgNum[2].gameObject:SetActive(false)
  end
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgNum[3], self:GetSpriteByFontStyle(nType, nOnes))
  NovaAPI.SetImageNativeSize(self._mapNode.imgNum[3])
  self._mapNode.imgNum[3].gameObject:SetActive(true)
end

function TemplateArtWordsCtrl:SetPunctuation(sText, nType)
  self._mapNode.imgNum[1].gameObject:SetActive(false)
  self._mapNode.imgNum[2].gameObject:SetActive(false)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgNum[3], self:GetSpriteByFontStyle(nType, sText))
  NovaAPI.SetImageNativeSize(self._mapNode.imgNum[3])
  self._mapNode.imgNum[3].gameObject:SetActive(true)
end

function TemplateArtWordsCtrl:GetSpriteByFontStyle(nType, nNumber)
  return self:GetAtlasSprite("05_number", NumberEnum[nNumber].Level)
end

return TemplateArtWordsCtrl
