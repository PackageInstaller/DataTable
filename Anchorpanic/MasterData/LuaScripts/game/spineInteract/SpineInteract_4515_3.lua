--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4515_3
@Description    : 刺玫皮肤2互动
@date           : 2024-12-06 10:19:30
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4515_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4515"
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime02")
end
function onClick2(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime03")
end
function onClick3(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime01")
end


return _M