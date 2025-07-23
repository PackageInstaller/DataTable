--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4520_3
@Description    : 黎寒之骑·朝晖皮肤2互动
@date           : 2024年12月9日 11:56:44
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4520_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4520"
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