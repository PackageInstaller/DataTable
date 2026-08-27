local UINHBHeroSkinTheme = class("UINHBHeroSkinTheme", UIBaseNode)
local base = UIBaseNode
local UINHandBookSkinTag = require("Game.HandBook.UI.Skin.UINHandBookSkinTag")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINHBHeroSkinTheme:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.skinItem, self, self.OnClickTheme)
  self._tagPool = UIItemPool.New(UINHandBookSkinTag, self.ui.hot.gameObject)
  self.ui.hot.gameObject:SetActive(false)
end

function UINHBHeroSkinTheme:InitHBThemeItem(themeCfg, count, resloder, callback)
  self._themeId = themeCfg.id
  self.ui.img_SkinBg.gameObject:SetActive(false)
  self._tagPool:HideAll()
  local totalCount = 0
  for _, skinId in pairs(ConfigData.skin.themeDic[self._themeId]) do
    if PlayerDataCenter.skinData:IsSkinUnlocked(skinId) then
      totalCount = totalCount + 1
    end
  end
  self._totalCount = totalCount
  resloder:LoadABAssetAsync(PathConsts:GetHeroSkinThemePicPath(themeCfg.pic), function(Texture)
    if Texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_SkinBg.texture = Texture
    self.ui.img_SkinBg.gameObject:SetActive(true)
  end)
  self:RefreshHBThemeCollect(count)
  self._callback = callback
end

function UINHBHeroSkinTheme:RefreshHBThemeCollect(count)
  self.ui.tex_Progress:SetIndex(0, tostring(count), tostring(self._totalCount))
end

function UINHBHeroSkinTheme:SetHBHeroSkinThemeTag(index)
  local tag = self._tagPool:GetOne()
  tag:InitBookSkinTag(index)
end

function UINHBHeroSkinTheme:PlayHBHeroSkinThemTween(delayTime)
  self:__StopTween()
  self.ui.canvasGroup:DOFade(0, 0.2):From():SetDelay(delayTime)
  self.ui.bottom:DOLocalMoveY(-20, 0.2):From():SetDelay(delayTime)
  self.ui.hot:DOFade(0, 0.2):From():SetDelay(0.1 + delayTime)
  self.ui.hot.transform:DOLocalMoveX(-205, 0.2):From():SetDelay(0.1 + delayTime)
end

function UINHBHeroSkinTheme:__StopTween()
  self.ui.canvasGroup:DOComplete()
  self.ui.hot:DOComplete()
  self.ui.bottom:DOComplete()
  self.ui.hot.transform:DOComplete()
end

function UINHBHeroSkinTheme:GetHBThemeId()
  return self._themeId
end

function UINHBHeroSkinTheme:OnClickTheme()
  if self._callback ~= nil then
    self._callback(self)
  end
end

function UINHBHeroSkinTheme:OnDelete()
  self:__StopTween()
  base.OnDelete(self)
end

return UINHBHeroSkinTheme
