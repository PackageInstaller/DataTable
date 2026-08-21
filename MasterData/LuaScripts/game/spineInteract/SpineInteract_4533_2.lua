--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4533_2
@Description    : 垂星皮肤2互动
@date           : 2026-03-09 16:30:45
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4533_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4533"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self:addOnClick(self.m_childGos["mImgClick6"], self.onClick6)
    self:addOnClick(self.m_childGos["mImgClick7"], self.onClick7)
    self.isPlayAnim05 = false
    self.isPlayAnim06 = false
    self.isPlayAnim07 = false
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
    self.spineAnim:Play("anim04")
end

function onClick5(self)
    if self.isPlayAnim05 == false then
        self.spineAnim:Play("anim05")
        self.isPlayAnim05 = true
    else
        self.spineAnim:Play("anim06")
        self.isPlayAnim05 = false
    end
end
function onClick6(self)
    if self.isPlayAnim06 == false then
        self.spineAnim:Play("anim07")
        self.isPlayAnim06 = true
    else
        self.spineAnim:Play("anim08")
        self.isPlayAnim06 = false
    end
end
function onClick7(self)
    if self.isPlayAnim07 == false then
        self.spineAnim:Play("anim09")
        self.isPlayAnim07 = true
    else
        self.spineAnim:Play("anim10")
        self.isPlayAnim07 = false
    end
end



return _M