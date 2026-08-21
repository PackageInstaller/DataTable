--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4526_3
@Description    : 泽菲琳皮肤2互动
@date           : 2026-01-13 16:07:43
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4526_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4526"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self.isPlayAnim04 = false
    self.isPlayAnim05 = false
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
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim03")
        self:startInteract("showtime03")
    end
end
function onClick4(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim04")
        self.isPlayAnim04 = true
        self.isPlayAnim05 = false
    elseif self.isPlayAnim04 == true then
        self.spineAnim:Play("anim05")
        self.isPlayAnim04 = false
        self.isPlayAnim05 = true
    elseif self.isPlayAnim05 == true then
        self.spineAnim:Play("anim06")
        self.isPlayAnim04 = false
        self.isPlayAnim05 = false
    end
end


return _M