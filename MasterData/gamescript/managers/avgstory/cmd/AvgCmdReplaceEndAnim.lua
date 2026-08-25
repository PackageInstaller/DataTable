local AvgCmdReplaceEndAnim = System.NewClass("AvgCmdReplaceEndAnim", AvgCmdBase)

function AvgCmdReplaceEndAnim:Awake()
  local gender = self.params[1]
  local animStr = self.params[2]
  if PlayerDataUtils.GetGenderStr() == gender then
    self.cmdComp.avgModel:SetEndAnim(animStr)
  end
end

return AvgCmdReplaceEndAnim
