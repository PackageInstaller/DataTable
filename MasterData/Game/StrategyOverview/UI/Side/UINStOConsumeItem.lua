local UINStOConsumeItem = class("UINStOConsumeItem", UIBaseNode)
local base = UIBaseNode

function UINStOConsumeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self._OnClickIcon)
end

function UINStOConsumeItem:InitStOConsumeItem(itemId, costNum)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, itemId = " .. tostring(itemId))
    return
  end
  self.itemCfg = itemCfg
  self.ui.img_SmallIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
  local containNum = PlayerDataCenter:GetItemCount(itemId)
  local enough = costNum <= containNum
  self.ui.tex_Consume:SetIndex(enough and 0 or 1, tostring(containNum), tostring(costNum))
end

function UINStOConsumeItem:_OnClickIcon()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(self.itemCfg)
  end)
end

function UINStOConsumeItem:OnDelete()
  base.OnDelete(self)
end

return UINStOConsumeItem
