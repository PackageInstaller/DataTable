local AvgCmdKeepPre = System.NewClass("AvgCmdKeepPre", AvgCmdBase)

function AvgCmdKeepPre:Awake()
  self.cmdComp.avgModel:SetKeepPreDialog(true)
end

return AvgCmdKeepPre
