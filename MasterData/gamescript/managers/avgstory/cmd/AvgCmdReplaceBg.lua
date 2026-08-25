local AvgCmdReplaceBg = System.NewClass("AvgCmdReplaceBg", AvgCmdBase)

function AvgCmdReplaceBg:Awake()
  local gender = self.params[1]
  local bgId = self.params[2]
  if PlayerDataUtils.GetGenderStr() == gender then
    self.cmdComp.avgModel:SetBg(bgId)
  end
end

return AvgCmdReplaceBg
