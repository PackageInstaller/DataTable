local AvgCmdShakeDialog, Super = System.NewClass("AvgCmdShakeDialog", AvgCmdBase)

function AvgCmdShakeDialog:Awake()
  print("------------------AvgCmdShakeDialog:Awake()------------------")
  self.cmdComp.avgModel:SetShakeDialog(true)
end

return AvgCmdShakeDialog
