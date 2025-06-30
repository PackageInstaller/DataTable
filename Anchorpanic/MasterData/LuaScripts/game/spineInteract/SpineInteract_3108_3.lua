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
    self:initSpineGo()
    self:showGuideEffect()
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

    if self.cvTimeout then
        LoopManager:clearTimeout(self.cvTimeout)
        self.cvTimeout = nil
    end

    local function _playCV()
        local audioData
        if AudioManager:preloadCvByCvId(baseData.cv_id, true) then
            audioData = AudioManager:playHeroCVOnReplace(baseData.cv_id, finishPlayCvCall)
        else
            self.mTimeSn = LoopManager:setTimeout(10, nil, finishPlayCvCall) 
        end
        mainui.MainUIManager:setCurPlayCv(audioData)
    end
    local layback = baseData["spine_voice_layback"] / 1000
    self:destroyTimeSn()
    self.cvTimeout = LoopManager:setTimeout(math.max(layback, 0.1), self, _playCV)


    GameDispatcher:dispatchEvent(EventName.MODEL_PLAYED, baseData)
end

-- 添加引导特效
function showGuideEffect(self)
    local isFirst = role.RoleManager:getMainUISpineIsFirstShow(self.modelId)
    if isFirst == 1 then
        return
    end
    role.RoleManager:setMainUISpineIsFirstShow(self.modelId, 1)
    for k, v in pairs(self.m_childTrans) do
        if string.find(v.name, "mImgClick") then
            gs.GoUtil.AddComponent(v.gameObject, ty.Canvas)
            v:GetComponent(ty.Canvas).overrideSorting = true
            v:GetComponent(ty.Canvas).sortingOrder = 202
            UIEffectMgr:addEffect("fx_ui_common_guide_1", v)
        end
    end
    if self.effTimerSn then
        LoopManager:removeTimerByIndex(self.effTimerSn)
        self.effTimerSn = nil
    end

    self.effTimerSn = LoopManager:addTimer(6, 1, self, self.removeGuideEffect)
end

-- 清除引导特效
function removeGuideEffect(self)
    if self.effTimerSn then
        LoopManager:removeTimerByIndex(self.effTimerSn)
        self.effTimerSn = nil
    end

    for k, v in pairs(self.m_childTrans) do
        if string.find(v.name, "mImgClick") then
            if not gs.GoUtil.IsCompNull(v.gameObject:GetComponent(ty.Canvas)) then
                gs.GoUtil.RemoveComponent(v.gameObject, ty.Canvas)
                UIEffectMgr:removeEffect("fx_ui_common_guide_1", v)
            end
        end
    end
end

function destroyTimeSn(self)
    if self.mTimeSn then
        LoopManager:clearTimeout(self.mTimeSn)
        self.mTimeSn = nil
    end
end

function destroy(self)
    self:removeOnClick(self.m_childGos["mImgClick1"])
    self:removeOnClick(self.m_childGos["mImgClick2"])
    self:removeOnClick(self.m_childGos["mImgClick3"])
    self:removeGuideEffect()
    if self.cvTimeout then
        LoopManager:clearTimeout(self.cvTimeout)
        self.cvTimeout = nil
    end
    self:destroyTimeSn()
end

return _M