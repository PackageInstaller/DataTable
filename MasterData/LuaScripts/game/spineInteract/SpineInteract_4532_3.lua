--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4532_3
@Description    : 赫梅克皮肤3互动
@date           : 2026-08-07 15:20:51
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4532_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4532"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self:addOnClick(self.m_childGos["mImgClick6"], self.onClick6)
    self:addOnClick(self.m_childGos["mImgClick7"], self.onClick7)
    self.isPlayAnim05 = false
    self.isPlayAnim06 = false
end

function onClick1(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim01")
        self:startInteract("showtime01")
    end
end

function onClick2(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim02")
        self:startInteract("showtime02")
    end
end

function onClick3(self)
    if self:getAnimIsName("loop02") then
        self.spineAnim:Play("anim03")
    end
end
function onClick4(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim04")
        self:startInteract("showtime03")
    end
end
function onClick5(self)
    self.spineAnim:Play("anim05")
    self.isPlayAnim05 = true
end
function onClick6(self)
    if self.isPlayAnim05 then
        self.spineAnim:Play("anim06")
        self.isPlayAnim05 = false
        self.isPlayAnim06 = true
    end
end
function onClick7(self)
    if self.isPlayAnim06 then
        self.spineAnim:Play("anim07")
        self.isPlayAnim06 = false
    end
end


return _M