local AvgActionBgAnim = System.NewClass("AvgActionBgAnim", AwakerChatActionBase)

function AvgActionBgAnim:DoAction(childBinder, bgAnimName, finishCb)
  Logger.Error("通讯器中未实现背景动画")
  finishCb()
end

return AvgActionBgAnim
