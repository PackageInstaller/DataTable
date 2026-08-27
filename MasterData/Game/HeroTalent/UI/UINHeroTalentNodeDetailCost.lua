local UINHeroTalentNodeDetailCost = class("UINHeroTalentNodeDetailCost", UIBaseNode)
local base = UIBaseNode

function UINHeroTalentNodeDetailCost:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self.OnClickItemIcon)
end

function UINHeroTalentNodeDetailCost:RefresheDetailCost(itemId, itemNum)
  self._itemId = itemId
  self._itemNum = itemNum
  local img = CRH:GetSpriteByItemId(itemId)
  self.ui.img_Icon.sprite = img
  self:RefreshDetailCostState()
end

function UINHeroTalentNodeDetailCost:RefreshDetailCostState()
  local hasNum = PlayerDataCenter:GetItemCount(self._itemId)
  local isComplete = hasNum >= self._itemNum
  self.ui.text_Count:SetIndex(isComplete and 1 or 0, tostring(hasNum), tostring(self._itemNum))
end

function UINHeroTalentNodeDetailCost:OnClickItemIcon()
  local itemCfg = ConfigData.item[self._itemId]
  if itemCfg == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win == nil then
      return
    end
    win:InitCommonItemDetail(itemCfg)
    win:TryShowGiftJump(true)
  end)
end

return UINHeroTalentNodeDetailCost
