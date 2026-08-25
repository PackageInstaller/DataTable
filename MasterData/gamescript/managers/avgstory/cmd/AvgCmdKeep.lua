local AvgCmdKeep = System.NewClass("AvgCmdKeep", AvgCmdBase)

function AvgCmdKeep:Awake()
  self.cmdComp.avgModel:SetKeepDialogInVideo(true)
end

return AvgCmdKeep
