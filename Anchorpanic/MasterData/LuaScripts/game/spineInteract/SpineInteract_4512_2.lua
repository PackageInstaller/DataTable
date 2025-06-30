--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4512_2
@Description    : 霜琼春节皮肤互动
@date           : 2024-08-26 10:19:44
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4512_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4512_2"
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime03")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime01")
end
function onClick3(self)
    self:startInteract("showtime02")
end



return _M