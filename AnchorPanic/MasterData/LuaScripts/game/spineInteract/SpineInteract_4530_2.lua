--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4530_2
@Description    : 鸣晔皮肤1互动
@date           : 2026-01-15 14:58:35
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4530_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4530"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self.isPlayAnim03 = false
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
        self.isPlayAnim03 = true
        self.isPlayAnim04 = false
        self.isPlayAnim05 = false
    elseif self.isPlayAnim03 == true then
        self.spineAnim:Play("anim04")
        self.isPlayAnim03 = false
        self.isPlayAnim04 = true
        self.isPlayAnim05 = false
    elseif self.isPlayAnim04 == true then
        self.spineAnim:Play("anim05")
        self.isPlayAnim03 = false
        self.isPlayAnim04 = false
        self.isPlayAnim05 = true
    elseif self.isPlayAnim05 == true then
        self.spineAnim:Play("anim06")
        self:startInteract("showtime03")
        self.isPlayAnim03 = false
        self.isPlayAnim04 = false
        self.isPlayAnim05 = false
    end
end



return _M