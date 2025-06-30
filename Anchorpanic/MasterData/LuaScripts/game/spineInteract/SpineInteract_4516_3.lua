--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4516_3
@Description    : 霆渊·艾丽西亚皮肤2互动
@date           : 2025-01-15 17:20:58
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4516_3', Class.impl("game.spineInteract.SpineInteract_3108_3"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "4516"
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
    self:addOnClick(self.m_childGos["mImgClick5"], self.onClick5)
end

function onClick1(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime01")
end
function onClick2(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime02")
end
function onClick3(self)
    self.spineAnim:Play("anim03")
    self:startInteract("showtime03")
end
function onClick4(self)
    self.spineAnim:Play("anim05")
end
function onClick5(self)
    self.spineAnim:Play("anim04")
end


return _M