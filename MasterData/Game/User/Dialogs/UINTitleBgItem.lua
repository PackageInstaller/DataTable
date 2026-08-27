local UINTitleBgItem = class("UINTitleBgItem", UIBaseNode)
local base = UIBaseNode
local CS_ColorUtility = CS.UnityEngine.ColorUtility

function UINTitleBgItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bgItem, self, self.OnClickTitleBg)
end

function UINTitleBgItem:InitTitleBgItem(cfg, resloader, bgAtlas, clickFunc)
  self.cfg = cfg
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.name)
  local newTitleItemDic = PlayerDataCenter.gameSettingData:GetNewTitleItemDic()
  if newTitleItemDic[cfg.id] then
    self.ui.img_New:SetActive(true)
  else
    self.ui.img_New:SetActive(false)
  end
  local success, color = CS_ColorUtility.TryParseHtmlString(cfg.font_colour)
  if success then
    self.ui.tex_ApDes.color = color
  end
  self.bgAtlas = bgAtlas
  self.resloader = resloader
  self.ui.img_Bg.sprite = AtlasUtil.GetResldSprite(self.bgAtlas, cfg.icon)
  self.clickFunc = clickFunc
end

function UINTitleBgItem:SetTitleBgSelect(flag)
  if flag then
    self.ui.outline.color = self.ui.selectColor
  else
    self.ui.outline.color = self.ui.normalColor
  end
end

function UINTitleBgItem:OnClickTitleBg()
  if self.clickFunc then
    self.clickFunc(self.cfg)
  end
end

function UINTitleBgItem:OnDelete()
  base.OnDelete(self)
end

return UINTitleBgItem
