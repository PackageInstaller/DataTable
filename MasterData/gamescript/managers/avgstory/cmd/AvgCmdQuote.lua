local AvgCmdQuote = System.NewClass("AvgCmdQuote", AvgCmdBase)

function AvgCmdQuote:Awake()
  self.cmdComp.avgModel:AddQuote()
end

return AvgCmdQuote
