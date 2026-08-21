--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4518_4
@Description    : 聆风皮肤1互动
@date           : 2025-09-11 15:53:57
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4518_4', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4518"
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime03")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime02")
end
function onClick3(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime01")
end


return _M