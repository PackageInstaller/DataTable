local AvgCmdOptionEnd = System.NewClass("AvgCmdOptionEnd", AvgCmdBase)

function AvgCmdOptionEnd:Awake()
  local endIndex = tonumber(self.params[1]) or self.params[1]
  self.cmdComp.avgModel:SetOptionEndIndex(endIndex)
end

return AvgCmdOptionEnd
