--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4534_2
@Description    : 蛰吻皮肤2互动
@date           : 2026-07-02 14:04:45
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4534_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4534"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self.isPlayAnim05 = false
end

function onClick1(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim01")
        self:startInteract("showtime02")
    end
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime01")
end
function onClick3(self)
    if self:getAnimIsName("loop02") then
        self.spineAnim:Play("anim03")
        self:startInteract("showtime03")
    end
end
function onClick4(self)
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim04")
    end
end

return _M