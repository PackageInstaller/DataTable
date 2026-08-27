local UINCommonQuickCheck = class("UINCommonQuickCheck", UIBaseNode)
local base = UIBaseNode

function UINCommonQuickCheck:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_QuickEntrance, self, self.OnClickBtnQuickEntrance)
end

function UINCommonQuickCheck:InitUINQuickCheck(actLbCtrl, callback)
  self.actLbCtrl = actLbCtrl
  self.callback = callback
end

function UINCommonQuickCheck:ShowQuickEntranceBlueDot(isShow)
  self.ui.obj_QuickEntranceBlueDot:SetActive(isShow)
end

function UINCommonQuickCheck:ShowShareTip(isShow)
  self.ui.obj_ShareTip:SetActive(isShow)
end

function UINCommonQuickCheck:SetShareItem(itemId, itemNum)
  local itemCfg = ConfigData.item[itemId]
  self.ui.img_ItemIcon.sprite = CRH:GetSprite(itemCfg.icon)
  self.ui.tex_ItemNum.text = tostring(itemNum)
end

function UINCommonQuickCheck:OnClickBtnQuickEntrance()
  if self.callback then
    self.callback()
  end
end

function UINCommonQuickCheck:OnDelete()
end

return UINCommonQuickCheck
