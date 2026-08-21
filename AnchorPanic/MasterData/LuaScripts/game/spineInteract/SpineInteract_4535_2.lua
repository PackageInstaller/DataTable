--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4535_2
@Description    : 涅普露皮肤2互动
@date           : 2026-08-10 11:51:07
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4535_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4535"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self:addOnClick(self.m_childGos["mImgClick6"], self.onClick6)
    self:addOnClick(self.m_childGos["mImgClick7"], self.onClick7)
    self:addOnClick(self.m_childGos["mImgClick8"], self.onClick8)
    self:addOnClick(self.m_childGos["mImgClick9"], self.onClick9)
    self.isPlayAnim02 = false
    self.isPlayAnim03 = false
    self.isPlayAnim04 = false
    self.isPlayAnim05 = false
    self.isPlayAnim06 = false
    self.isPlayAnim07 = false
    self.isPlayAnim08 = false
    self.isPlayAnim09 = false
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
        self.isPlayAnim02 = true
    end
end

function onClick3(self)
    if self.isPlayAnim02 then
        self.spineAnim:Play("anim03")
        self:startInteract("showtime03")
        self.isPlayAnim02 = false
        self.isPlayAnim03 = true
    end
end
function onClick4(self)
    if self.isPlayAnim03 then
        self.spineAnim:Play("anim04")
        self.isPlayAnim03 = false
        self.isPlayAnim04 = true
    end
end
function onClick5(self)
    if self.isPlayAnim04 then
        self.spineAnim:Play("anim05")
        self.isPlayAnim04 = false
        self.isPlayAnim05 = true
    elseif self.isPlayAnim07 then
        self.spineAnim:Play("anim08")
        self:startInteract("showtime02")
        self.isPlayAnim07 = false
        self.isPlayAnim08 = true
    end
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
        self.isPlayAnim07 = true
    end
end
function onClick8(self)
    if self.isPlayAnim08 then
        self.spineAnim:Play("anim09")
        self.isPlayAnim08 = false
        self.isPlayAnim09 = true
    end
end
function onClick9(self)
    if self:getAnimIsName("loop01") or self.isPlayAnim09 then
        self.spineAnim:Play("anim10")
        self.isPlayAnim09 = false
    end
end

return _M