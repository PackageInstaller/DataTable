--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4515_2
@Description    : 刺玫泳装互动
@date           : 2024-05-28 11:12:16
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4515_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4515"
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime01")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime03")
end
function onClick3(self)
    self:startInteract("showtime02")
end


return _M