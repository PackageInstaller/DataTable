--[[ 
-----------------------------------------------------
@filename       : MiningAi
@Description    : 捞宝藏的ai
@date           : 2023-11-29 11:07:07
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.ai.MiningAi', Class.impl())


function ctor(self)
    self:initData()
end

function initData(self)
end

-- 设置ai角色
function setData(self, cusId, cusLive)
    self.mEventId = cusId
    self.mMinigLive = cusLive

    self:startAI()
end

-- 启动ai
function startAI(self)
    if not self.mAiFrameId then
        self.mAiFrameId = LoopManager:addFrame(1, 0, self, self.onAIStep)
    end
end

-- 停止ai
function stopAI(self)
    self:reset()
end

-- 开始ai随机
function onAIStep(self)
    if self.mMinigLive then
        self.mMinigLive:move()
    end
end

-- 开始移动
function startMove(self)
    self:moveTo()
end

-- 碰撞触发
function colliderEnter(self, cusParent)
    self:stopAI()
    self.mMinigLive:setToClawParent(cusParent)
    return true
end

-- 抓取完成触发
function finishEvent(self)
    
end

-- 销毁矿
function destroyLive(self)
    local thingDic = mining.MiningController:getMiningSceneThingDic()
    if thingDic and self.mMinigLive then
        thingDic[self.mMinigLive:getEventKey()] = nil
        self.mMinigLive:destroy()
    end
end

-- 重置ai
function reset(self, isRecover)
    LoopManager:removeFrameByIndex(self.mAiFrameId)
    self.mAiFrameId = nil
    LoopManager:clearTimeout(self.animTimeoutId)
    self.animTimeoutId = nil
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:reset(true)
    LuaPoolMgr:poolRecover(self)
end


return _M