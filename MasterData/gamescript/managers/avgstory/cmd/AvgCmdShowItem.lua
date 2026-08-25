local AvgCmdShowItem, Super = System.NewClass("AvgCmdShowItem", AvgCmdBase)

function AvgCmdShowItem:Awake()
  local itemId = tonumber(self.params[1])
  self.cmdComp.avgModel:SetItem(itemId)
  self.cmdComp.avgModel:SetForbidHideRoleAnim(true)
end

return AvgCmdShowItem
