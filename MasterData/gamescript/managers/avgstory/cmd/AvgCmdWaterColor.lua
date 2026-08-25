local AvgCmdWaterColor = System.NewClass("AvgCmdWaterColor", AvgCmdBase)

function AvgCmdWaterColor:Awake()
  local roleId = tonumber(self.params[1]) or 0
  local isEnabld = false
  if self.params[2] then
    isEnabld = 1 == tonumber(self.params[2] or 0)
  end
  local offsetx = tonumber(self.params[3] or 0)
  local offsety = tonumber(self.params[4] or 0)
  self.cmdComp.avgModel:SetWaterColorOffset(roleId, isEnabld, offsetx, offsety)
end

return AvgCmdWaterColor
