local UINActSGMiniGameBallPools = class("UINActSGMiniGameBallPools", UIBaseNode)
local base = UIBaseNode

function UINActSGMiniGameBallPools:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActSGMiniGameBallPools:GetSGMiniGameBalls()
  return self.ui.balls
end

function UINActSGMiniGameBallPools:OnDelete()
end

return UINActSGMiniGameBallPools
