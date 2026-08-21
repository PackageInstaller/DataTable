--[[ 
-----------------------------------------------------
@filename       : MiningLivething
@Description    : 捞宝藏 物体结构
@date           : 2023-11-29 11:06:47
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.MiningLivething', Class.impl())

function createThing(self, cusId, cusData, cusParent, cusClawParent)
    self.mclawParent = cusClawParent
    self.mId = cusId
    self.mEventId = cusData.event_id
    self.mStartPos = cusData.pos
    self.mMovePos = cusData.movePos
    self.mEventVo = mining.MiningManager:getEventVo(self.mEventId)

    self.mLivething = gs.ResMgr:LoadGO("arts/fx/ui/mining_01/prefabs/" .. self.mEventVo.prefabName)
    gs.TransQuick:SetParentOrg(self.mLivething.transform, cusParent)
    gs.TransQuick:Scale0(self.mLivething.transform, self.mEventVo.interactType / 10000)
    gs.TransQuick:LPos(self.mLivething.transform, self.mStartPos[1], self.mStartPos[2], 0)

    self.mColliderCall = self.mLivething:GetComponent(ty.ColliderCall)
    if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall = self.mLivething:AddComponent(ty.ColliderCall)
        self.mColliderCall:OpenColliderCheck()
        self.mColliderCall:AddColliderTags({ "MiningClaw" })
        self.mColliderCall.SelfColliderTag = "MiningThing"
        self.mColliderCall.IsTrigger = true
    end

    self.mColliderCall.onTriggerEnterCall = function(tag, colliderTagID)
        self:onColliderEnter(tag, colliderTagID)
    end

    self.moveSpeed = -self.mEventVo.moveSpeed / 10000

    if self.mEventVo.isBubble == 1 then
        self.mBubblehing = gs.ResMgr:LoadGO("arts/fx/ui/mining_01/prefabs/MiningBubble.prefab")
        gs.TransQuick:SetParentOrg(self.mBubblehing.transform, self.mLivething.transform)
        gs.TransQuick:Scale0(self.mBubblehing.transform, 1.6)
    end

    self:createMiningAI()
end

function onColliderEnter(self)
    if mining.MiningManager.currCatchId ~= nil then
        return
    end
    if mining.MiningManager.currCatchState == 0 then
        return
    end
    mining.MiningManager.currCatchState = 0
    local isCatch = false
    if self.mAiIns then
        isCatch = self.mAiIns:colliderEnter(self.mclawParent)
    end
    if isCatch then
        mining.MiningManager.currCatchId = self.mId .. "_" .. self.mEventId
        mining.MiningManager:setGrabSpeed(self.mEventVo.grabSpeed / 10000)
    else
        -- 发送事件给服务器
        GameDispatcher:dispatchEvent(EventName.SEND_MINING_EVENT_TO_SEVER, self.mEventId)
    end
    if self.mBubblehing then
        local bubbleAnim = self.mBubblehing:GetComponent(ty.Animator)
        bubbleAnim:SetTrigger("show")
        local animTime = AnimatorUtil.getAnimatorClipTime(bubbleAnim, "MiningBubble_Show")
        self.animTimeoutId = LoopManager:setTimeout(animTime, self, function()
            gs.GameObject.Destroy(self.mBubblehing)
            self.mBubblehing = nil
        end)
    end
end

-- 添加到挂点
function setToClawParent(self, cusParent)
    self.mLivething.transform:SetParent(cusParent, false);
    gs.TransQuick:LPos(self.mLivething.transform, gs.Vector3.zero)
end

-- 移动
function move(self)
    if gs.GoUtil.IsGoNull(self.mLivething) then
        return
    end
    if self.moveSpeed == 0 then
        return
    end
    local pos = self.mLivething.transform.localPosition
    local scaleX = self.mLivething.transform.localScale.x
    gs.TransQuick:LPosX(self.mLivething.transform, pos.x + self.moveSpeed)

    local minX = -700
    local maxX = 700
    if not table.empty(self.mMovePos) then
        if self.mStartPos[1] < self.mMovePos[1] then
            minX = self.mStartPos[1]
            maxX = self.mMovePos[1]
        else
            minX = self.mMovePos[1]
            maxX = self.mStartPos[1]
        end
    end

    if pos.x <= minX then
        -- self.mAni = self.mLivething:GetComponent(ty.Animator)
        -- self.mAni:SetTrigger("show")
        gs.TransQuick:ScaleX(self.mLivething.transform, -math.abs(scaleX))
        self.moveSpeed = math.abs(self.moveSpeed)
    end
    if pos.x >= maxX then
        -- self.mAni = self.mLivething:GetComponent(ty.Animator)
        -- self.mAni:SetTrigger("show")
        gs.TransQuick:ScaleX(self.mLivething.transform, math.abs(scaleX))
        self.moveSpeed = -math.abs(self.moveSpeed)
    end
end

-- 播放展示动作
function showAnim(self, animName)
    local anim = self.mLivething:GetComponent(ty.Animator)
    if anim then
        local aniTime = AnimatorUtil.getAnimatorClipTime(anim, animName)
        anim:SetTrigger("show")
        return aniTime
    end
end

function getThingGo(self)
    return self.mLivething
end

function getEventVo(self)
    return self.mEventVo
end

-- 实例化存储的key
function getEventKey(self)
    return self.mId .. "_" .. self.mEventId
end

-- 鱼雷炸处理
function boom(self)
    local skillVo = mining.MiningManager:getEventSkillVo(self.mEventId)
    if skillVo and skillVo.type == 1 then
        self.mAiIns:boom()
    end
    self:destroy()
end

-- 惊喜宝箱产出
function boxCreate(self, eventId)

end

-----------------------------------

-- 创建可ai
function createMiningAI(self)
    local cls = self:getAIUtil()
    if not cls then
        return
    end
    self.mAiIns = cls:poolGet()
    self.mAiIns:setData(self.mEventId, self)
end

-- 获取对应的ai文件
function getAIUtil(self)
    local ai = nil
    if self.mEventId == 1001 then
        ai = require("game/mining/manager/ai/MiningAi_1001")
    elseif self.mEventId == 1002 then
        ai = require("game/mining/manager/ai/MiningAi_1002")
    elseif self.mEventId == 1003 then
        ai = require("game/mining/manager/ai/MiningAi_1003")
    else
        ai = mining.MiningAi
    end
    return ai
end

-- 抓取完成
function catchFinish(self)
    if self.mAiIns then
        self.mAiIns:finishEvent()
    end
    self:destroy()
end

function destroy(self)
    if self.mLivething then
        gs.GameObject.Destroy(self.mLivething)
        self.mLivething = nil
    end
    if self.mBubblehing then
        gs.GameObject.Destroy(self.mBubblehing)
        self.mBubblehing = nil
    end
    if self.mAiIns then
        self.mAiIns:poolRecover()
        self.mAiIns = nil
    end
end

return _M