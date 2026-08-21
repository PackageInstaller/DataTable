--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4528_3
@Description    : 白蔷薇皮肤3互动
@date           : 2026-05-22 11:42:44
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4528_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4528"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
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
function onClick4(self)
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim04")
    end
end

function onClick5(self)
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim05")
    end
end


return _M