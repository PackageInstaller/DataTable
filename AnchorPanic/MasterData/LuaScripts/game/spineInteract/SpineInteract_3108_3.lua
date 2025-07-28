--[[ 
-----------------------------------------------------
@filename       : SpineInteract_3108_3
@Description    : 言泳装互动
@date           : 2024-05-28 11:12:16
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_3108_3', Class.impl("lib.component.BaseContainer"))

function ctor(self)
    super.ctor(self)
    self.baseModelId = "3108"
end

function setup(self, go, modelId)
    self.mSpineGo = go
    self.modelId = modelId

    local spineTrans = self.mSpineGo.transform:Find("mGroup/spine_" .. modelId)
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
end

function onClick1(self)
    self.spineAnim:Play("anim02")
    self:startInteract("showtime01")
end
function onClick2(self)
    self.spineAnim:Play("anim01")
    self:startInteract("showtime02")
end
function onClick3(self)
    self:startInteract("showtime03")
end

function startInteract(self, actName)
    local baseData = hero.HeroInteractManager:getConfigData01(self.baseModelId, self.modelId, actName)

    local finishPlayCvCall = function()
        GameDispatcher:dispatchEvent(EventName.MAINUI_LIVEVIEW_CVCALLFINISH)
        mainui.MainUIManager:setCurPlayCv(nil)
    end

    local audioData = AudioManager:playHeroCVOnReplace(baseData.cv_id, finishPlayCvCall)
    mainui.MainUIManager:setCurPlayCv(audioData)

    GameDispatcher:dispatchEvent(EventName.MODEL_PLAYED, baseData)
end


function destroy(self)
    self:removeOnClick(self.m_childGos["mImgClick1"])
    self:removeOnClick(self.m_childGos["mImgClick2"])
    self:removeOnClick(self.m_childGos["mImgClick3"])
end

return _M