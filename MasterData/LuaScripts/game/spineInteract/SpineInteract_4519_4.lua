--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4519_4
@Description    : 克里安卡皮肤4互动
@date           : 2025-12-08 16:53:53
@Author         : Jacob
@copyright      : (LY) 2025  雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4519_4', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4519"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self:addOnClick(self.m_childGos["mImgClick6"], self.onClick6)
    self:addOnClick(self.m_childGos["mImgClick7"], self.onClick7)
    self.isPlayAnim04 = false
    self.isPlayAnim06 = false
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
    self.spineAnim:Play("anim04")
    self.isPlayAnim04 = true
end
function onClick5(self)
    if self.isPlayAnim04 then
        self.spineAnim:Play("anim05")
        self.isPlayAnim04 = false
    end
end
function onClick6(self)
    self.spineAnim:Play("anim06")
    self.isPlayAnim06 = true
end
function onClick7(self)
    if self.isPlayAnim06 then
        self.spineAnim:Play("anim07")
        self.isPlayAnim06 = false
    end
end

return _M