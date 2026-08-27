local UINCarnival22BallEft = class("UINCarnival22BallEft", UIBaseNode)
local base = UIBaseNode
local CS_UnityEngine_Time = CS.UnityEngine.Time

function UINCarnival22BallEft:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnival22BallEft:InitBallEft(index, reverse)
  self._playeTime = CS_UnityEngine_Time.time
  local scales = reverse and self.ui.reverse_scales ~= nil and self.ui.reverse_scales or self.ui.scales
  local scale = scales[index]
  if scale == nil then
    scale = scales[#scales]
  end
  self.ui.uI_Carnival22MiniGame_click.scale = scale
end

function UINCarnival22BallEft:IsBallEftFnish()
  return CS_UnityEngine_Time.time - self._playeTime > self.ui.still_time
end

return UINCarnival22BallEft
