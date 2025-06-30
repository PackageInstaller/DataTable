--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4517_2
@Description    : 阿尔戈皮肤互动
@date           : 2024-08-20 18:02:35
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4517_2', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4517"
end

function initSpineGo(self)
    local spineTrans = self.mSpineGo.transform:Find("mGroup/spine_" .. self.modelId)
    local anim = spineTrans:GetComponent(ty.Animator)
    self.mSpineTrans = spineTrans
    self.spineAnim = self.mSpineTrans:GetComponent(ty.Animator)
    if not self.spineAnim then
        return
    end

    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.mSpineGo)

    self:addOnClick(self.m_childGos["mImgClick1"], self.onClick1)
    self:addOnClick(self.m_childGos["mImgClick2"], self.onClick2)
    self:addOnClick(self.m_childGos["mImgClick3"], self.onClick3)
    self:addOnClick(self.m_childGos["mImgClick4"], self.onClick4)
end


function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime01")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime03")
end
function onClick3(self)
    self.spineAnim:Play("anim03")
end
function onClick4(self)
    self.spineAnim:Play("anim04")
    self:startInteract("showtime02")
end


return _M