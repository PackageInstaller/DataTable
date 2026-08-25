local AvgCmdLongCapAutoDuration, Super = System.NewClass("AvgCmdLongCapAutoDuration", AvgCmdBase)

function AvgCmdLongCapAutoDuration:Awake()
  if not self.params or not self.params[1] then
    return
  end
  local duration = tonumber(self.params[1])
  self.cmdComp.avgModel:SetLongCapAutoDuration(duration)
end

return AvgCmdLongCapAutoDuration
