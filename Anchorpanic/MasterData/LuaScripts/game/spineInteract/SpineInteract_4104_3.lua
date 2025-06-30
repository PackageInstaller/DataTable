--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4104_3
@Description    : 朝晖盛夏海风互动
@date           : 2024-07-05 17:47:41
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4104_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4104"
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