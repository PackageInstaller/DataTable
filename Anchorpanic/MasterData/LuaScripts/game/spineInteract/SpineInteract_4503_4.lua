--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4503_4
@Description    : 燕欧氤氲青鸟互动
@date           : 2024-07-05 17:47:41
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4503_4', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4503"
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
    self.spineAnim:Play("anim03")
    self:startInteract("showtime02")
end


return _M