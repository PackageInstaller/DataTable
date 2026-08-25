local AvgCmdAvgRoleScaleRevert = System.NewClass("AvgCmdAvgRoleScaleRevert", AvgCmdBase)

function AvgCmdAvgRoleScaleRevert:Awake()
  local talkRoleId = self.cmdComp.avgModel:GetTalkRoleId()
  local roleId = tonumber(self.params[1]) or talkRoleId
  self.cmdComp.avgModel:SetRoleScale(roleId, 1, nil)
end

return AvgCmdAvgRoleScaleRevert
