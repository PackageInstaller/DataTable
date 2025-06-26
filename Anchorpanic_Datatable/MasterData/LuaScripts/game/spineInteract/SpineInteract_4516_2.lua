--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4516_2
@Description    : 霆渊·艾丽西亚互动
@date           : 2024-07-09 19:46:43
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4516_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4516"
end

function onClick1(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime03")
end
function onClick2(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime01")
end
function onClick3(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime02")
end


return _M