local AvgCmdSkipFadeOut = System.NewClass("AvgCmdSkipFadeOut", AvgCmdBase)

function AvgCmdSkipFadeOut:Awake()
  self.cmdComp.avgModel:SetSkipFadeOut(true)
end

return AvgCmdSkipFadeOut
