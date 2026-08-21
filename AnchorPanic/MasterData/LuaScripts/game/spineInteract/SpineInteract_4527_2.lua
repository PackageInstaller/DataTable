--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4527_2
@Description    : 瞳光皮肤1互动
@date           : 2025-09-12 16:00:45
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4527_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4527"
end

function onClick1(self)
    if self:getAnimIsName("loop") then
        self.spineAnim:Play("anim01")
        self:startInteract("showtime1001")
    end

    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim02")
        self:startInteract("showtime1002")
    end

    if self:getAnimIsName("loop02") then
        self.spineAnim:Play("anim03")
        self:startInteract("showtime02")
    end

end
function onClick2(self)
    if self:getAnimIsName("loop") then
        self.spineAnim:Play("anim04")
        self:startInteract("showtime03")
    end
end
function onClick3(self)
    if self:getAnimIsName("loop") then
        self.spineAnim:Play("anim05")
        self:startInteract("showtime01")
    end
end


return _M