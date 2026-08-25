local AvgCmdResetAvgOption = System.NewClass("AvgCmdResetAvgOption", AvgCmdBase)

function AvgCmdResetAvgOption:Awake()
  self.cmdComp.avgModel:ResetChoosedOption()
end

return AvgCmdResetAvgOption
