local base = UIBaseNode
local UINReinforceCardDunLvlDetailNodeItem = class("UINReinforceCardDunLvlDetailNodeItem", base)

function UINReinforceCardDunLvlDetailNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINReinforceCardDunLvlDetailNodeItem:RefreshLevelItem(cfg, isUnlock, isCurrent)
  self.ui.Obj_Lock:SetActive(not isUnlock)
  self.ui.Tex_Des.gameObject:SetActive(isUnlock)
  self.ui.Tex_Lvl.text = LanguageUtil.GetLocaleText(cfg.tip_name)
  self.ui.Tex_Des.text = LanguageUtil.GetLocaleText(cfg.tip_des)
  self.ui.Obj_NowTag:SetActive(isCurrent)
  if not isUnlock then
    self.ui.Tex_LockDes.text = string.format(ConfigData:GetTipContent(59031), tostring(cfg.unlock_layer))
    self.ui.Tex_LockDes.color = Color.New(1, 1, 1, 0.2)
    self.ui.Img_LockIcon.color = Color.New(1, 1, 1, 0.2)
  end
end

function UINReinforceCardDunLvlDetailNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardDunLvlDetailNodeItem
