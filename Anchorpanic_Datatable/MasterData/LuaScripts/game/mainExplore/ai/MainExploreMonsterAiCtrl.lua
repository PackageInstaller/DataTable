--[[ 
-----------------------------------------------------
@filename       : MainExploreMonsterAiCtrl
@Description    : 主线探索怪物 AI
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreMonsterAiCtrl", Class.impl(mainExplore.MainExploreBaseAiCtrl))

--构造
function ctor(self)
    super.ctor(self)
    self.mIsLog = false
end

--析构
function dtor(self)
    super.dtor(self)
end

function __print(self, str)
	if(self.mIsLog)then 
        local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
        if(playerThing and playerThing:isPlayingState(mainExplore.BehaviorState.KEYBOARD_MOVE))then
            print(str)
        end
	end
end

function initData(self)
    super.initData(self)

    -- 特殊设置的索敌能力
    self.mFindAiEnable = true
    -- 特殊设置的移动能力
    self.mMoveEnable = true
    -- 物件配置
    self.mItemConfigVo = nil

    -- 自动巡逻的路径列表
    self.mAudioPathList = nil
    -- 自动巡逻的目标点索引
    self.mAudioTargetIndex = nil
    -- 自动巡逻的目标点
    self.mAudioTargetPos = nil
    -- 自动巡逻每个点休息时间
    self.__autoRestTime = 1
    -- 自动巡逻每个点休息时间
    self.mAutoRestTime = nil

    -- 仇恨是否有目标
    self.mTargetHate = nil
    -- 仇恨是否可攻击
    self.mIsAttackHate = nil
    -- 跟随追敌的第一个坐标
    self.mFirstFollowPos = nil
    -- 是否撤销追敌
    self.mIsCancelFollow = nil
    -- 追敌抵达后又立即被目标远离，重新追敌需要个休息时间
    self.__followRestTime = 0.3
    -- 追敌抵达后又立即被目标远离，重新追敌需要个休息时间
    self.mFollowRestTime = nil

    -- 是否玩家模型正在更换
    self.mIsPlayerModelUpdate = nil
    -- 是否已经通知服务器进入战斗，等待服务器中
    self.mIsWaitFight = nil
end

function create(self, thing)
    super.create(self, thing)
    self.mItemConfigVo = mainExplore.MainExploreSceneManager:getItemConfigVo(mainExplore.MainExploreManager:getTriggerDupData().mapId, self.mThing:getEventConfigVo().eventId)
    self.partolType = mainExplore.PartolType.BIHE

    -- 策划保证巡随机逻点两两之间是直线，除此之外为其补充中间路径拐点
    self.mAudioPathList = {}
    local pointCount = #self.mItemConfigVo.list
    if(pointCount == 1)then
        self.mAudioPathList = {self.mItemConfigVo.list[pointCount].position}
    elseif(pointCount > 1)then
        for i = 1, pointCount do
            local curShowData = self.mItemConfigVo.list[i]
            table.insert(self.mAudioPathList, curShowData.position)

            local nextShowData = self.mItemConfigVo.list[i + 1]
            if(nextShowData)then
                local navMeshHit, pathList = mainExplore.getNavMeshPath(curShowData.position.x, curShowData.position.y, curShowData.position.z, nextShowData.position.x, nextShowData.position.y, nextShowData.position.z, "", false)
                if(pathList and #pathList > 0)then
                    for j = 1, #pathList do
                        table.insert(self.mAudioPathList, pathList[j].position)
                    end
                end
            else
                local nowCount = #self.mAudioPathList
                if(self.partolType == mainExplore.PartolType.LAIHUI)then
                    for j = nowCount - 1, 1, -1 do
                        table.insert(self.mAudioPathList, self.mAudioPathList[j])
                    end
                elseif(self.partolType == mainExplore.PartolType.BIHE)then
                    local firstPoint = self.mAudioPathList[1]
                    local endPoint = self.mAudioPathList[nowCount]
                    local navMeshHit, pathList = mainExplore.getNavMeshPath(endPoint.x, endPoint.y, endPoint.z, firstPoint.x, firstPoint.y, firstPoint.z, "", false)
                    if(pathList and #pathList > 0)then
                        for j = 1, #pathList do
                            table.insert(self.mAudioPathList, pathList[j].position)
                        end
                    end
                elseif(self.partolType == mainExplore.PartolType.RANDOM)then
                end
            end
        end

    end
    self:checkTargetPos()
end

function reset(self)
    super.reset(self)
end

function addEvents(self)
    super.addEvents(self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)
end

function removeEvents(self)
    super.removeEvents(self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)
end

function onAddThingHandler(self, thing)
    if(thing == mainExplore.MainExplorePlayerProxy:getThing())then
        self.mIsPlayerModelUpdate = false
    end
end

function onRemoveThingHandler(self, thing)
    if(thing == mainExplore.MainExplorePlayerProxy:getThing())then
        self.mIsPlayerModelUpdate = true
    end
end

-- 帧循环
function step(self, deltaTime)
    super.step(self, deltaTime)

    if(not self.mMoveEnable)then
        self.mThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
        return
    end
    if(self.mIsWaitFight or self.mThing:isPlayingState(mainExplore.BehaviorState.BOSS_ATTACK) or self.mThing:isPlayingState(mainExplore.BehaviorState.MONSTER_ATTACK))then
        return
    end
    local eventConfigVo = self.mThing:getEventConfigVo()
    if(self:isCancelingFollow())then
        self:__print("开始快速撤销追寻")
        self.mThing:setAniSpeed(eventConfigVo.normalAnimationSpeed * eventConfigVo.cancelFollowSpeed / eventConfigVo.normalSpeed)
        self.mThing:moveStpe(deltaTime, self.mFirstFollowPos, 0, eventConfigVo.cancelFollowSpeed * 2, 0)
        if(self.mThing:getBehaviorState() == mainExplore.BehaviorState.IDLE)then
            self.mIsCancelFollow = nil
            self.mFirstFollowPos = nil
            self:__print("快速撤销追寻完毕")
        end
        return
    else
        -- 是否可触发
        local isCanTrigger = nil
        if(mainExplore.MainExploreManager:getIsInProtecting())then
            isCanTrigger = false
        else
            -- 是否可自动触发
            isCanTrigger = eventConfigVo.isAutoTrigger
            -- 是否完成前置事件已有触发能力
            if(isCanTrigger)then
                isCanTrigger = mainExplore.MainExploreManager:getEventTriggerEnable(eventConfigVo.eventId)
            end
        end
        if(not self.mIsPlayerModelUpdate)then
            self:checkAttack(isCanTrigger, eventConfigVo.findAngle, eventConfigVo.maxFollowRange, eventConfigVo.findRange, eventConfigVo.attackRange, eventConfigVo.reactionRange)
        end
        if(self.mTargetHate)then
            if(self.mIsAttackHate)then
                self:playAttack()
            else
                if(self.mThing:getBehaviorState() == mainExplore.BehaviorState.IDLE)then
                    if(not self.mFollowRestTime or self.mFollowRestTime <= 0)then
                        self.mFollowRestTime = self.__followRestTime
                    end
                    self.mFollowRestTime = self.mFollowRestTime - deltaTime
                    if(self.mFollowRestTime > 0)then
                        self:__print("追到了，缓一下，不然动作反复立即跑立即停会抽搐")
                        self:playAttack()
                        return
                    end
                end
                self:__print("拼命追赶中")
                local playerPos = self.mTargetHate:getPosition()
                self.mThing:setAniSpeed(eventConfigVo.normalAnimationSpeed * eventConfigVo.followSpeed / eventConfigVo.normalSpeed)
                self.mThing:moveStpe(deltaTime, playerPos, eventConfigVo.attackRange, eventConfigVo.followSpeed, 0)
            end
        else
            if(self.mThing:getBehaviorState() == mainExplore.BehaviorState.IDLE)then
                if(not self.mAutoRestTime or self.mAutoRestTime <= 0)then
                    self.mAutoRestTime = self.__autoRestTime
                end
                self.mAutoRestTime = self.mAutoRestTime - deltaTime
                if(self.mAutoRestTime > 0)then
                    return
                end
                self:checkTargetPos()
                self:__print("获得新的移动目标点")
            end
            self.mThing:setAniSpeed(eventConfigVo.normalAnimationSpeed)
            self.mThing:moveStpe(deltaTime, self.mAudioTargetPos, 0, eventConfigVo.normalSpeed, 0)
        end
    end
end

-- 开始攻击
function playAttack(self)
    if(not self.mIsPlayerModelUpdate)then
        -- local function attackFinishCall()
        --     self.mIsWaitFight = true
        --     self.mThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
        -- end
        -- local eventConfigVo = self.mThing:getEventConfigVo()
        -- self.mThing:setAniSpeed(eventConfigVo.normalAnimationSpeed)
        -- if(eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then
        --     self.mThing:setBehaviorState(mainExplore.BehaviorState.MONSTER_ATTACK, nil, attackFinishCall)
        --     self:__print("设置完毕小怪攻击类型", self.mThing:getBehaviorState() == mainExplore.BehaviorState.MONSTER_ATTACK)
        -- elseif(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER)then
        --     self.mThing:setBehaviorState(mainExplore.BehaviorState.BOSS_ATTACK, nil, attackFinishCall)
        --     self:__print("设置完毕BOSS攻击类型", self.mThing:getBehaviorState() == mainExplore.BehaviorState.BOSS_ATTACK)
        -- end
        -- mainExplore.MainExploreEventExecutor:checkTriggerEvent(eventConfigVo, {attacker = self.mThing})
    
        self.mIsWaitFight = true
        mainExplore.MainExploreEventExecutor:checkTriggerEvent(self.mThing:getEventConfigVo(), {attacker = self.mThing})
    end
end

-- 检查目标
function checkAttack(self, isCanTrigger, findAngle, maxFollowRange, findRange, attackRange, reactionRange)
    if(isCanTrigger)then
        local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
        local playerThingVo = mainExplore.MainExplorePlayerProxy:getThingVo()
        if(playerThing and playerThingVo)then
            local monsterThing = self.mThing
            local monsterThingVo = monsterThing:getThingVo()
    
            -- 是否已经通知服务器进入战斗，等待服务器中
            if(not self.mIsWaitFight)then
                -- 以怪物开始跟随追敌时的坐标基准，超过最大追踪距离，放弃
                if (self.mFirstFollowPos and math.v3Distance(monsterThingVo:getPosition(), self.mFirstFollowPos) > maxFollowRange) then
                    -- self:__print("与跟随追敌的第一个坐标的距离超过最大追踪距离，放弃")
                    self.mIsCancelFollow = true
                    self.mTargetHate = nil
                    self.mIsAttackHate = false
                    return
                end
        
                -- 以怪物当前坐标点基准，超过索敌距离，放弃
                if (math.v3Distance(monsterThingVo:getPosition(), playerThingVo:getPosition()) > findRange) then
                    -- self:__print("与怪物当前坐标的距离超过索敌距离，放弃")
                    if(self.mFirstFollowPos)then
                        self.mIsCancelFollow = true
                    end
                    self.mTargetHate = nil
                    self.mIsAttackHate = false
                    return
                end
        
                -- 处于扇形攻击范围，允许攻击
                if(mainExplore.isInUmbrella(playerThing:getTrans(), monsterThing:getTrans(), findAngle, attackRange))then
                    -- self:__print("处于扇形攻击范围，允许攻击")
                    if(not self.mFirstFollowPos)then
                        self.mFirstFollowPos = math.Vector3(monsterThingVo:getPosition().x, monsterThingVo:getPosition().y, monsterThingVo:getPosition().z)
                        self:__print("设置跟随追敌的第一个坐标", self.mFirstFollowPos)
                    end
                    self.mTargetHate = playerThingVo
                    self.mIsAttackHate = true
                    return
                end
        
                -- 处于扇形仇恨范围，允许追踪
                if(mainExplore.isInUmbrella(playerThing:getTrans(), monsterThing:getTrans(), findAngle, findRange))then
                    -- self:__print("处于扇形仇恨范围，允许追踪")
                    if(not self.mFirstFollowPos)then
                        self.mFirstFollowPos = math.Vector3(monsterThingVo:getPosition().x, monsterThingVo:getPosition().y, monsterThingVo:getPosition().z)
                        self:__print("设置跟随追敌的第一个坐标", self.mFirstFollowPos)
                    end
                    self.mTargetHate = playerThingVo
                    self.mIsAttackHate = false
                    return
                end
                
                -- 处于感应范围，允许追踪
                if (math.v3Distance(monsterThingVo:getPosition(), playerThingVo:getPosition()) <= reactionRange) then
                    -- self:__print("处于感应仇恨范围，允许追踪")
                    if(self.mFirstFollowPos)then
                        self.mIsCancelFollow = true
                    end
                    self.mTargetHate = playerThingVo
                    self.mIsAttackHate = false
                    return
                end
            end
        end
    end

    -- 自动巡逻
    self:__print("自动巡逻")
    if(self.mFirstFollowPos)then
        self.mIsCancelFollow = true
    end
    self.mTargetHate = nil
    self.mIsAttackHate = false
end

-- 检查寻路点
function checkTargetPos(self)
    if(self.mAudioTargetIndex == nil)then
        self.mAudioTargetIndex = 1
        -- 初始设置
        local showData = self.mItemConfigVo.list[self.mAudioTargetIndex]
        self.mThing:getThingVo():setPosXYZ(showData.position.x, showData.position.y, showData.position.z)
        self.mThing:getThingVo():setRotationXYZ(showData.rotation.x, showData.rotation.y, showData.rotation.z)
        self.mThing:getThingVo():setScaleXYZ(showData.scale.x, showData.scale.y, showData.scale.z)
    else
        if(self.partolType == mainExplore.PartolType.LAIHUI or self.partolType == mainExplore.PartolType.BIHE)then
            if(self.mAudioTargetIndex >= #self.mAudioPathList)then
                self.mAudioTargetIndex = 1
            else
                self.mAudioTargetIndex = self.mAudioTargetIndex + 1
            end
        elseif(self.partolType == mainExplore.PartolType.RANDOM)then
            self.mAudioTargetIndex = math.random(1, #self.mAudioPathList)
        end
    end
    local pos = self.mAudioPathList[self.mAudioTargetIndex]
    self.mAudioTargetPos = pos and pos or self.mAudioTargetPos
end

-- 是否撤销追随
function isCancelingFollow(self)
    return self.mIsCancelFollow and self.mFirstFollowPos
end

-- 特殊设置怪物索敌能力
function setFindAiEnable(self, enable)
    self.mFindAiEnable = enable
end

-- 特殊设置怪物移动能力
function setMoveEnable(self, enable)
    self.mMoveEnable = enable
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
