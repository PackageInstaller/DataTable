--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4531_2
@Description    : 雾涅尔皮肤2互动
@date           : 2026-03-09 16:30:45
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4531_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4531"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self.isPlayAnim04 = false
    self.isPlayAnim05 = false
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime01")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime02")
end
function onClick3(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime03")
end
function onClick4(self)
    if self.isPlayAnim04 == false then
        self.spineAnim:Play("anim04")
        self.isPlayAnim04 = true
    else
        self.spineAnim:Play("anim05")
        self.isPlayAnim04 = false
    end
end
function onClick5(self)
    if self.isPlayAnim05 == false then
        self.spineAnim:Play("anim06")
        self.isPlayAnim05 = true
    else
        self.spineAnim:Play("anim07")
        self.isPlayAnim05 = false
    end
end



return _M