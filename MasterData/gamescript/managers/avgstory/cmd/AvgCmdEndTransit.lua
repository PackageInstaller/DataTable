local AvgCmdEndTransit = System.NewClass("AvgCmdEndTransit", AvgCmdBase)

function AvgCmdEndTransit:Awake()
  local transitType = self.params[1]
  print("AvgCmdEndTransit:Awake", transitType)
  self.cmdComp.avgModel:SetEndTransit(transitType)
end

return AvgCmdEndTransit
