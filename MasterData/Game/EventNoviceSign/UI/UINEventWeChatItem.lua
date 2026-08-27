local UINEventWeChatItem = class("UINEventWeChatItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINEventWeChatItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINEventWeChatItem:InitWeChatItem(awardCfg, awardId, awardCount, resloader)
  self.awardCfg = awardCfg
  self.awardId = awardId
  self.awardCount = awardCount
  self.resloader = resloader
  if self.awardCount > 1 then
    self.ui.tex_TotalCount.text = tostring(self.awardCount)
  else
    self.ui.count:SetActive(false)
  end
  self.baseItem:SetNotNeedAnyJump(true)
  self.baseItem:InitBaseItem(awardCfg)
end

function UINEventWeChatItem:RefreshItem(flag)
  self.ui.obj_isPicked:SetActive(flag)
  if flag then
    self.baseItem:CloseGreatRewardLoopFx()
  end
end

function UINEventWeChatItem:OnDelete()
  base.OnDelete(self)
end

return UINEventWeChatItem
