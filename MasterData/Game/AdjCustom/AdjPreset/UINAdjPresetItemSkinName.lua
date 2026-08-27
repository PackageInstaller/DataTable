local UINAdjPresetItemSkinName = class("UINAdjPresetItemSkinName", UIBaseNode)
local base = UIBaseNode
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")

function UINHeroSkinTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._tagItem = UINHeroSkinTag.New()
  self._tagItem:Init(self.ui.tagItem)
end

function UINHeroSkinTag:RefreshAdjPresetItemSkinName(skinId, usingL2d)
  local skinCfg = ConfigData.skin[skinId]
  local heroData = PlayerDataCenter:GetHeroData(skinCfg.heroId)
  self.ui.tex_HeroName.text = heroData:GetHeroName(true) .. "\n" .. LanguageUtil.GetLocaleText(skinCfg.name)
  if not usingL2d then
    self._tagItem:Hide()
  else
    self._tagItem:Show()
    self._tagItem:InitSkinTagLive2dLevel(PlayerDataCenter.skinData:GetSkinLive2dLevel(skinId))
  end
end

return UINHeroSkinTag
