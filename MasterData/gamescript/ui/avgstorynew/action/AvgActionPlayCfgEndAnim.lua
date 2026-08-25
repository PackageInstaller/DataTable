local AvgActionPlayCfgEndAnim = System.NewClass("AvgActionPlayCfgEndAnim", AvgActionBase)

function AvgActionPlayCfgEndAnim:DoAction(_, _, finishCb)
  finishCb()
end

return AvgActionPlayCfgEndAnim
