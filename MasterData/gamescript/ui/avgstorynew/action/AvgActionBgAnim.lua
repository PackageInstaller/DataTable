local AvgActionBgAnim = System.NewClass("AvgActionBgAnim", AvgActionBase)

function AvgActionBgAnim:DoAction(childBinder, bgAnimName, finishCb)
  local animEndFunc
  
  function animEndFunc()
    function animEndFunc()
    end
    
    finishCb()
  end
  
  if not bgAnimName then
    animEndFunc()
    return
  end
  bgAnimName = string.replace(bgAnimName, "BG.", "", true)
  self.avgPanel.bgComp:PlayBgAnim(bgAnimName, function()
    animEndFunc()
  end)
  childBinder:BindTimer(3.5, 0, nil, function()
    animEndFunc()
  end)
end

return AvgActionBgAnim
