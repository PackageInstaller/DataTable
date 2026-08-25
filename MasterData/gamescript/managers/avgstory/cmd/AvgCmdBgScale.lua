local AvgCmdBgScale, Super = System.NewClass("AvgCmdBgScale", AvgCmdBase)

function AvgCmdBgScale:Awake()
  self.cmdComp.avgModel:SetBgScale(tonumber(self.params[1]))
end

return AvgCmdBgScale
