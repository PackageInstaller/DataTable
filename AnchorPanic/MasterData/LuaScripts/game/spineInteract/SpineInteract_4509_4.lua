--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4509_4
@Description    : 蒂雅皮肤3互动
@date           : 2026-03-09 15:09:58
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4509_4', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4509"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self:addOnClick(self.m_childGos["mImgClick6"], self.onClick6)
    self:addOnClick(self.m_childGos["mImgClick7"], self.onClick7)

    self.isPlayAnimCount = 0
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
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim04")
    end
end
function onClick5(self)
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim05")
    end
end
function onClick6(self)
    if self:getAnimIsName("loop03") then
        self.spineAnim:Play("anim06")
    end
end
function onClick7(self)
    if self.isPlayAnimCount == 0 then
        self.spineAnim:Play("anim07")
        self.isPlayAnimCount = 1
    elseif self.isPlayAnimCount == 1 then
        self.spineAnim:Play("anim08")
        self.isPlayAnimCount = 2
    elseif self.isPlayAnimCount == 2 then
        self.spineAnim:Play("anim09")
        self.isPlayAnimCount = 3
    elseif self.isPlayAnimCount == 3 then
        self.spineAnim:Play("anim10")
        self.isPlayAnimCount = 0
    end

end



return _M