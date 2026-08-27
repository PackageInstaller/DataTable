local UINEventGrowBagReward = class("UINEventGrowBagReward", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINEventGrowBagReward:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINEventGrowBagReward:InitItem(id, count, isGetReward, isLocked)
  self.ui.obj_lock:SetActive(isLocked)
  self.ui.obj_isPicked:SetActive(isGetReward)
  if count <= 1 then
    self.ui.count:SetActive(false)
  else
    self.ui.count:SetActive(true)
    self.ui.tex_TotalCount.text = tostring(count)
  end
  self.baseItem:InitBaseItem(ConfigData.item[id])
end

return UINEventGrowBagReward
