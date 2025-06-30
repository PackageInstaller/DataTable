-- 效果执行器，统筹动画和特效的调用
module("eliminate.EliminateEffectExecutor", Class.impl())

function init(self, parentTrans)
    self:resetTweenList()
    self:resetEffectList()
    self:resetTimerList()
    self.mEffectParentTrans = parentTrans
end

function createEffect(self, prefabName, startLocalPosX, startLocalPosY, endLocalPosX, endLocalPosY, delayTime, showTime, showFinishCall)
    local create = function()
        local tweener = nil
        local effectVo = nil
        local loadFinishCall = function(result, effectGo)
            if(result and endLocalPosX ~= nil and endLocalPosY ~= nil and (startLocalPosX ~= endLocalPosX or startLocalPosY ~= endLocalPosY))then
                tweener = TweenFactory:move2Lpos(effectGo.transform, math.Vector3(endLocalPosX, endLocalPosY, 0), showTime, nil, nil, false, nil, nil)
                table.insert(self.mTweenList, tweener)
            end
        end
        effectVo = UIEffectMgr:addEffect(prefabName, self.mEffectParentTrans, startLocalPosX, startLocalPosY, loadFinishCall, nil, false)
        table.insert(self.mEffectList, effectVo)

        if(showTime > 0)then
            table.insert(self.mTimerList, LoopManager:addTimer(showTime, 1, self,
            function() 
                self:removeEffect(effectVo, tweener)
                if(showFinishCall)then
                    showFinishCall()
                end
            end))
        else
            if(showFinishCall)then
                showFinishCall()
            end
        end
    end
    if(delayTime and delayTime > 0)then
        table.insert(self.mTimerList, LoopManager:addTimer(delayTime, 1, self, function() create() end))
    else
        create()
    end
end

function removeEffect(self, effectVo, tweener)
    if(effectVo and self.mEffectList)then
        table.removebyvalue(self.mEffectList, effectVo)
        UIEffectMgr:removeEffectByVo(effectVo)
    end
    if(tweener and self.mTweenList)then
        tweener:Kill()
        table.removebyvalue(self.mTweenList, tweener)
    end
end

function reset(self)
    self:resetTweenList()
    self:resetEffectList()
    self:resetTimerList()
    self.mEffectParentTrans = nil
end

function resetTweenList(self)
    if(self.mTweenList)then
        for _, tweener in pairs(self.mTweenList) do
            tweener:Kill()
        end
    end
    self.mTweenList = {}
end

function resetEffectList(self)
    if(self.mEffectList)then
        for _, effectVo in pairs(self.mEffectList) do
            UIEffectMgr:removeEffectByVo(effectVo)
        end
    end
    self.mEffectList = {}
end

function resetTimerList(self)
    if(self.mTimerList)then
        for _, timerSn in pairs(self.mTimerList) do
            LoopManager:removeTimerByIndex(timerSn)
        end
    end
    self.mTimerList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
