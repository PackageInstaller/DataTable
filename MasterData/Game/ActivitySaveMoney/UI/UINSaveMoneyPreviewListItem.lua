local UINSaveMoneyPreviewListItem = class("UINSaveMoneyPreviewListItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINSaveMoneyPreviewListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINSaveMoneyPreviewListItem:InitSaveMoneyPreviewListItem(startTime, endTime, itemList)
  self.ui.rect_Day.sizeDelta = Vector2.New(400, self.ui.rect_Day.rect.height)
  self.ui.tex_Day:SetIndex(1, tostring(startTime), tostring(endTime))
  self.ui.tex_WaitState.gameObject:SetActive(false)
  self.ui.done:SetActive(false)
  self.rewardPool:HideAll()
  if itemList ~= nil then
    for _, data in ipairs(itemList) do
      local item = self.rewardPool:GetOne()
      item:InitItemWithCount(data.itemCfg, data.count)
    end
  end
end

return UINSaveMoneyPreviewListItem
