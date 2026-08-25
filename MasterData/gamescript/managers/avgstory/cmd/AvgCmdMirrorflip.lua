local AvgCmdMirrorflip = System.NewClass("AvgCmdMirrorflip", AvgCmdBase)

function AvgCmdMirrorflip:Awake()
  local roleId = tonumber(self.params[1])
  local switch = tonumber(self.params[2] or 1)
  if not roleId or not DT.AvgRole[roleId] then
    return
  end
  local enable = 1 == switch
  self.cmdComp.avgModel:SetRoleMirrorFlip(roleId, enable)
end

return AvgCmdMirrorflip
