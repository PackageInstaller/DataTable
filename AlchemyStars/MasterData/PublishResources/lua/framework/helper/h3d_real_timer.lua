require("h3d_timer")
_class("H3DRealTimer", H3DTimer)
H3DRealTimer = H3DRealTimer

function H3DRealTimer:Constructor()
end

function H3DRealTimer:_GetCurrentTime()
  return GameGlobal:GetInstance():GetCurrentRealTime()
end
