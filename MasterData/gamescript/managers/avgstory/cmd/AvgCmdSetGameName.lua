local AvgCmdSetGameName = System.NewClass("AvgCmdSetGameName", AvgCmdBase)

function AvgCmdSetGameName:Awake()
  self.cmdComp.avgModel:SetGameName()
end

return AvgCmdSetGameName
