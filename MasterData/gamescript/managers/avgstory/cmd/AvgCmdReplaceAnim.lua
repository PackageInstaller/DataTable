local AvgCmdReplaceAnim = System.NewClass("AvgCmdReplaceAnim", AvgCmdBase)

function AvgCmdReplaceAnim:Awake()
  local gender = self.params[1]
  local animStr = self.params[2]
  if PlayerDataUtils.GetGenderStr() == gender then
    self.cmdComp.avgModel:SetAnim(animStr)
  end
end

return AvgCmdReplaceAnim
