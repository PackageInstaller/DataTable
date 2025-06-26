-- @FileName:   FieldExplorationEventModel.lua
-- @Description:   荒野行动模型基类
-- @Author: ZDH
-- @Date:   2023-07-25 15:35:17
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.model.FieldExplorationEventModel', Class.impl(model.modelBase))

function loadFinish(self, go, finishCall, sorceId)
    super.loadFinish(self, go, nil, sorceId)

    if self.m_ani then
        self:setPreLoadAnisByHashList(FieldExplorationConst.EVENT_ACT_LIST, finishCall)
    else
        if finishCall then
            finishCall(false, self)
        end
    end
end

function setModelGoName(self, name)
    if not name then
        local strArr = string.split(self.m_prefabName, "/")
        self.m_rootGo.name = strArr[#strArr] .. "_Root"
    else
        self.m_rootGo.name = name
    end
end

function AddFrameCallEvent(self, acitonName, callback, frameCount)
    if not self.m_ani then
        logError("annimaCtrl is null")
        return
    end
    self.m_ani:AddFrameCallEvent(acitonName, callback, frameCount)
end

function setScale(self, scale)
    self.m_trans.localScale = scale
end

function setVisible(self, beVisible)
    if self.m_rootGo.activeSelf ~= beVisible then
        self.m_rootGo:SetActive(beVisible)
    end
end

function setPositionTween(self, lpos, tweenTime, callback)
    if not lpos then return end
    if self.m_position == lpos then return end
    self.m_position:copy(lpos)

    if self.posTweener then
        self.posTweener:Kill()
        self.posTweener = nil
    end
    if self.m_trans and lpos then
        self.posTweener = TweenFactory:move2pos(self.m_trans, lpos, tweenTime, nil, callback)
    end
end

function setAngle(self, angle, isNow, callback)
    if isNow then
        self:stopTurnAngle()
        self.m_angle = angle
        gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
        if callback then 
            callback()
        end
    else
        if angle ~= self.m_angle then
            self:stopTurnAngle()
            self.m_angle = angle
            self.m_angle_tweener = TweenFactory:rotate(self.m_trans, math.Vector3(0, self.m_angle, 0), 0.3, callback)
            fight.TweenManager:addTweener(self.m_angle_tweener)
        end
    end
end

return _M
