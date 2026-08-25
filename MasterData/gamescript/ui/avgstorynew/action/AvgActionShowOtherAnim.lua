local AvgActionShowOtherAnim = System.NewClass("AvgActionShowOtherAnim", AvgActionBase)

function AvgActionShowOtherAnim:DoAction(childBinder, animName, finishCb)
  local animEndFunc
  
  function animEndFunc()
    function animEndFunc()
    end
    
    finishCb()
  end
  
  if animName then
    local isBgAnim = string.contains(animName, "BG.", 0, false)
    if not isBgAnim then
      self.avgPanel.uiAnimController:PlayState(animName, function()
        animEndFunc()
      end)
    else
      animName = string.replace(animName, "BG.", "", true)
      self.avgPanel.bgComp:PlayBgAnim(animName, function()
        animEndFunc()
      end)
    end
  else
    animEndFunc()
  end
  childBinder:BindTimer(3.5, 0, nil, function()
    animEndFunc()
  end)
end

return AvgActionShowOtherAnim
