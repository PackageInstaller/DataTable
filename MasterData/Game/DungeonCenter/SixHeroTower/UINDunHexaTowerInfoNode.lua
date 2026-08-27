local UINDunHexaTowerInfoNode = class("UINDunHexaTowerInfoNode", UIBaseNode)
local base = UIBaseNode

function UINDunHexaTowerInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDunHexaTowerInfoNode:RefreshTitle()
end

function UINDunHexaTowerInfoNode:RefreshEndtime(isHave, endTime)
  self.ui.Obj_Time:SetActive(isHave)
  if isHave then
    self.ui.Tex_Time.text = TimeUtil:TimestampToDateString(endTime, false, true, ConfigData:GetTipContent(6052))
  end
end

return UINDunHexaTowerInfoNode
