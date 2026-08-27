local UINNormalTitleItem = class("UINStageRewardPreItem", UIBaseNode)
local base = UIBaseNode
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local CS_ColorUtility = CS.UnityEngine.ColorUtility
local util = require("XLua.Common.xlua_util")
local titleEnum = require("Game.CommonUI.Title.TitleEnum")
local CS_Material = CS.UnityEngine.Material

function UINNormalTitleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.bgImgMat = CS_Material(self.ui.img_bg.material)
  self.ui.img_bg.material = self.bgImgMat
end

function UINNormalTitleItem:InitNormalTitleItem(titlePrefix, titlePostfix, titleBG, resloader, bgAtlas)
  self.titleResloader = resloader
  self.bgAtlas = bgAtlas
  self.titlePrefix = titlePrefix
  self.titlePostfix = titlePostfix
  self.titleBg = titleBG
  self:RefreshTitle(titlePrefix, titlePostfix, titleBG)
end

function UINNormalTitleItem:RefreshTitle(titlePrefix, titlePostfix, titleBG)
  if titlePostfix == nil or titlePostfix == 0 then
    self.postConfig = {name = ""}
  else
    self.postConfig = ConfigData.title[titlePostfix]
  end
  if titlePrefix == nil or titlePrefix == 0 then
    self.preConfig = {name = ""}
  else
    self.preConfig = ConfigData.title[titlePrefix]
  end
  local bgId = titleBG
  if titleBG == nil or titleBG == 0 then
    bgId = titleEnum.NormalBGItemId
  end
  self.bgConfig = ConfigData.title_background[bgId]
  local realTitle
  local atlasSprite = AtlasUtil.GetResldSprite(self.bgAtlas, self.bgConfig.icon)
  local atlasTex = atlasSprite.texture
  if self.bgTex ~= atlasTex then
    self.bgImgMat:SetTexture("_MainTex", atlasTex)
    self.bgTex = atlasTex
  end
  if string.IsNullOrEmpty(LanguageUtil.GetLocaleText(self.preConfig.name)) and string.IsNullOrEmpty(LanguageUtil.GetLocaleText(self.postConfig.name)) then
    realTitle = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(6050))
  else
    realTitle = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(6047)), LanguageUtil.GetLocaleText(self.preConfig.name), LanguageUtil.GetLocaleText(self.postConfig.name))
  end
  self.realTitle = realTitle
  local success, color = CS_ColorUtility.TryParseHtmlString(self.bgConfig.font_colour)
  if success then
    self.ui.tex_ApDes.color = color
  end
  self.ui.tex_ApDes.text = realTitle
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tran_tex)
  local realWidth = math.clamp(0, self.ui.tran_tex.sizeDelta.x + 60, self.ui.img_bg.transform.sizeDelta.x)
  self.ui.tran_view.sizeDelta = Vector2.Temp(realWidth, self.ui.tran_tex.sizeDelta.y)
  local xTiling = realWidth / self.ui.img_bg.rectTransform.rect.width
  self.bgImgMat:SetFloat("_XTiling", xTiling)
  local textureRect = atlasSprite.textureRect
  local mainTiling = Vector2.zero
  local mainOffset = Vector2.zero
  mainTiling.x = textureRect.width / atlasTex.width
  mainTiling.y = textureRect.height / atlasTex.height
  mainOffset.x = textureRect.x / atlasTex.width
  mainOffset.y = textureRect.y / atlasTex.height
  self.bgImgMat:SetTextureScale("_MainTex", mainTiling)
  self.bgImgMat:SetTextureOffset("_MainTex", mainOffset)
end

function UINNormalTitleItem:SetPreTitle(preTitleCfg)
  self.titlePrefix = preTitleCfg.id
  self:RefreshTitle(self.titlePrefix, self.titlePostfix, self.titleBg)
end

function UINNormalTitleItem:SetPostTitle(postTitleCfg)
  self.titlePostfix = postTitleCfg.id
  self:RefreshTitle(self.titlePrefix, self.titlePostfix, self.titleBg)
end

function UINNormalTitleItem:SetTitleBg(titleBgCfg)
  self.titleBg = titleBgCfg.id
  self:RefreshTitle(self.titlePrefix, self.titlePostfix, self.titleBg)
end

function UINNormalTitleItem:OnDelete()
  DestroyUnityObject(self.bgImgMat)
  self.bgImgMat = nil
  base.OnDelete(self)
end

return UINNormalTitleItem
