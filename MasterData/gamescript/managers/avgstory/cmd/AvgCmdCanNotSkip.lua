local AvgCmdCanNotSkip = System.NewClass("AvgCmdCanNotSkip", AvgCmdBase)

function AvgCmdCanNotSkip:Awake()
  self.cmdComp.avgModel:SetCanNotSkip()
end

return AvgCmdCanNotSkip
