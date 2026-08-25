local AvgActionWaterColor = System.NewClass("AvgActionWaterColor", AvgActionBase)

function AvgActionWaterColor:DoAction(_, params, finishCb)
  if finishCb then
    finishCb()
  end
end

return AvgActionWaterColor
