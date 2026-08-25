local AvgActionSetOption = System.NewClass("AvgActionSetOption", AvgActionBase)

function AvgActionSetOption:DoAction(_, _, finishCb)
  self.avgPanel.isShowOption.value = true
  finishCb()
end

return AvgActionSetOption
