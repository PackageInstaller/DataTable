--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4529_2
@Description    : 弦枝皮肤1互动
@date           : 2025-12-04 10:21:51
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4529_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4529"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
    self:addOnClick(self.m_childGos["mImgClick6"], self.onClick6)
    self.isPlayAnim04 = false
end

function onClick1(self)
    self.spineAnim:Play("anim01")

    local value = math.random(1, 3)
    if value == 1 then
        self:startInteract("showtime02")
    elseif value == 2 then
        self:startInteract("showtime1001")
    else
        self:startInteract("showtime1002")
    end
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
end
function onClick5(self)
    self.spineAnim:Play("anim05")
end
function onClick6(self)
    self.spineAnim:Play("anim06")
end


return _M