local UINWATechConsumeItem = class("UINWATechConsumeItem", UIBaseNode)
local base = UIBaseNode

function UINWATechConsumeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self._OnClickIcon)
end

function UINWATechConsumeItem:InitStOConsumeItem(itemId, costNum)
  self.ui.img_SmallIcon.gameObject:SetActive(true)
  self.ui.tex_Consume.gameObject:SetActive(true)
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

function UINWATechConsumeItem:TempSetOtherConditon(text)
  self.ui.img_SmallIcon.gameObject:SetActive(false)
  self.ui.tex_Consume.gameObject:SetActive(false)
  self.ui.text_unlockConditon.gameObject:SetActive(true)
  self.ui.text_unlockConditon.text = text
end

function UINWATechConsumeItem:_OnClickIcon()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(self.itemCfg)
  end)
end

function UINWATechConsumeItem:OnDelete()
  base.OnDelete(self)
end

return UINWATechConsumeItem
