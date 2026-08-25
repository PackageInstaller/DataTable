local AvgCmdChangeBg, Super = System.NewClass("AvgCmdChangeBg", AvgCmdBase)

function AvgCmdChangeBg:Awake()
  local bgId = self.params[1]
  local layer = tonumber(self.params[2])
  if not DT.AvgBg[bgId] then
    for _, info in pairs(DT.AvgBg) do
      if info.CnID == bgId then
        bgId = info.ID
        break
      end
    end
  end
  self.cmdComp.avgModel:SetBg(bgId)
end

return AvgCmdChangeBg
