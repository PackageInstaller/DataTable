local UINGiftPageDetail = class("UINGiftPageDetail", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINGiftPageDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINGiftPageDetail:InitGiftPageItem(day, itemList, isReceived, showProcess)
  self.ui.tex_Day:SetIndex(0, tostring(day))
  self.ui.tex_WaitState.gameObject:SetActive(not isReceived and showProcess)
  self.ui.done:SetActive(isReceived and showProcess)
  self.rewardPool:HideAll()
  if itemList ~= nil then
    for _, data in ipairs(itemList) do
      local item = self.rewardPool:GetOne()
      item:InitItemWithCount(data.itemCfg, data.count)
    end
  end
end

return UINGiftPageDetail
