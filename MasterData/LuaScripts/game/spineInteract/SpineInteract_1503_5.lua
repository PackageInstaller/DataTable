--[[ 
-----------------------------------------------------
@filename       : SpineInteract_1503_5
@Description    : 莉丽拉皮肤5互动
@date           : 2025-10-23 11:36:57
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_1503_5', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "1503"
end
function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
end
function onClick1(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim01")
        self:startInteract("showtime01")
    end

    if self:getAnimIsName("loop02") then
        self.spineAnim:Play("anim02")
        -- self:startInteract("showtime02")
    end
end
function onClick2(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim03")
        self:startInteract("showtime02")
    end
end
function onClick3(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim04")
        self:startInteract("showtime03")
    end
end
function onClick4(self)
    if self:getAnimIsName("loop01") then
        self.spineAnim:Play("anim05")
    end
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim06")
    end
end


return _M