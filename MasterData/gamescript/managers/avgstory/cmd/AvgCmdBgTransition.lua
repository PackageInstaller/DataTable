local AvgCmdBgTransition, Super = System.NewClass("AvgCmdBgTransition", AvgCmdBase)

function AvgCmdBgTransition:Awake()
  self.cmdComp.avgModel:SetBgTransAnim(tonumber(self.params[1]))
end

return AvgCmdBgTransition
