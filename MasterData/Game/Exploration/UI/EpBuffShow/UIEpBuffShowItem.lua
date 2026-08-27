local UIEpBuffShowItem = class("UIEpBuffShowItem")

function UIEpBuffShowItem:ctor()
end

function UIEpBuffShowItem:InitEpBuffShowItem(iconObj, nameObj, buffCfg)
  self.img_Icon = iconObj:FindComponent(eUnityComponentID.Image)
  self.tex_Name = nameObj:FindComponent(eUnityComponentID.ExText)
  self.img_Icon.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.tex_Name.text = LanguageUtil.GetLocaleText(buffCfg.name)
end

return UIEpBuffShowItem
