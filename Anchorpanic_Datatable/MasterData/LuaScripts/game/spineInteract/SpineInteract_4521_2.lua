--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4521_2
@Description    : 云篆皮肤互动
@date           : 2025-01-15 17:20:58
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4521_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4521"
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime02")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime01")
end
function onClick3(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime03")
end


return _M