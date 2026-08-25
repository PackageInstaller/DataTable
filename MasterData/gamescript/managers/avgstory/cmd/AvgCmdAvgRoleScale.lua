local AvgCmdAvgRoleScale = System.NewClass("AvgCmdAvgRoleScale", AvgCmdBase)

function AvgCmdAvgRoleScale:Awake()
  local roleId = self.cmdComp.avgModel:GetTalkRoleId()
  local scale = 1.4
  local dura
  local curParamIndex = 1
  local curParamNum = tonumber(self.params[curParamIndex])
  if curParamNum then
    if DT.AvgRole[curParamNum] then
      roleId = curParamNum
      curParamIndex = curParamIndex + 1
    end
    scale = tonumber(self.params[curParamIndex] or scale)
    dura = tonumber(self.params[curParamIndex + 1] or dura)
  end
  self.cmdComp.avgModel:SetRoleScale(roleId, scale, dura)
end

return AvgCmdAvgRoleScale
