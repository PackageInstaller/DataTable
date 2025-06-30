--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4523_3
@Description    : 红叶皮肤2互动
@date           : 2025-05-19 19:45:18
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4523_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4523"
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime02")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime03")
end
function onClick3(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime01")
end


return _M