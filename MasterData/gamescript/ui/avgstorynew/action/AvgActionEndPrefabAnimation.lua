local AvgActionEndPrefabAnimation = System.NewClass("AvgActionEndPrefabAnimation", AvgActionBase)

function AvgActionEndPrefabAnimation:DoAction(childBinder, cfgEndAnim, finishCb)
  local _, time = table.unpack(cfgEndAnim)
  self.avgPanel.bgComp:PlayCfgEndAnim(cfgEndAnim)
  time = tonumber(time) or 1
  childBinder:BindTimer(time, 0, nil, function()
    finishCb()
  end)
end

return AvgActionEndPrefabAnimation
