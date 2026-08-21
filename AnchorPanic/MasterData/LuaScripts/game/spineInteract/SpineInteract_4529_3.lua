--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4529_3
@Description    : 玄枝皮肤3互动
@date           : 2026-04-02 11:06:10
@Author         : Jacob
@copyright      : (LY) 2026 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4529_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4529"
end

function initSpineGo(self)
    super.initSpineGo(self)
    self.playAnim02State = 0
end

function onClick1(self)
    if self.playAnim02State == 0 then
        self.spineAnim:Play("anim01")
        self:startInteract("showtime01")
    end
end
function onClick2(self)
    if self.playAnim02State == 0 then
        self.spineAnim:Play("anim02")
        self:startInteract("showtime02")
        self.playAnim02State = 1
    elseif self.playAnim02State == 1 then
        self.spineAnim:Play("anim04")
        self.playAnim02State = 0
    end
end
function onClick3(self)
    if self.playAnim02State == 0 then
        self.spineAnim:Play("anim03")
        self:startInteract("showtime03")
    end
end



return _M