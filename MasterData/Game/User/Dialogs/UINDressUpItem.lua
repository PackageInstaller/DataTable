local UINDressUpItem = class("UINDressUpItem", UIBaseNode)
local base = UIBaseNode

function UINDressUpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_dressUpItem, self, self.OnDressUpItemClick)
end

function UINDressUpItem:InitDressUpItem(cfg, clickCallback, sprite, cfgId)
  self._cfg = cfg
  self._clickCallback = clickCallback
  self.ui.tex_DressName.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.img_Pic.sprite = sprite
  local selectPlateId = PlayerDataCenter.inforData:GetBackgroudPlateId()
  if ConfigData.portrait_card[selectPlateId] == nil then
    selectPlateId = ConfigData.game_config.userInfoUIBG
  end
  if cfgId == selectPlateId then
    self.ui.img_Select:SetActive(true)
  else
    self.ui.img_Select:SetActive(false)
  end
end

function UINDressUpItem:OnDressUpItemClick()
  if self._clickCallback ~= nil then
    self._clickCallback(self._cfg)
  end
end

function UINDressUpItem:OnDelete()
  base.OnDelete(self)
end

return UINDressUpItem
