--[[****************************************************************************
Brief  :STravelBase 技能特效轨迹基础类
Author :James Ou
Date   :2020-03-09
****************************************************************************
]]
module("STravelBase", Class.impl())
-- 根据不同的轨迹 子类可重写
SPERF_CLS = SPerfBase

-------------------------------
function ctor(self)
    -- 对应的引用数据
    self.m_perfRo = nil
    -- 基础特效资源名
    self.m_rootPrefabName = nil
    -- 当前位置
    self.m_curPosV3 = nil
    -- 目标ID
    self.m_targetID = nil
    -- 目标点
    self.m_targetVec3 = nil
    -- 基础速度
    self.m_speed = 1
    -- 是否暂停中
    self.m_isPause = false
    -- 标志开始计时
    self.m_timeStart = nil
    -- 触发打中目标的回调
    self.m_hitCall = nil
    -- 整个播放结束的回调
    self.m_endCall = nil

    ---用于结算的数据----------------------------------------
    -- 施法者ID
    self.m_casterID = nil
    -- 属性于的技能编号
    self.m_skillID = nil

    -- 最大的攻击目标数
    self.m_maxHitCnt = nil
    -- 生命持续时间
    self.m_lifeTime = -1

    ---扩展属性----------------------------------------
    -- 是否可以追踪目标
    self.m_isTrack = false

    -- 移动过程中是否可以攻击范围内目标
    self.m_isMoveAtk = false
    -- 移动过程中击中其它目标是否结束
    self.m_isMoveAtkEnd = true

    -- 结束时的爆炸特效名 (有的话，在结束时触发)
    self.m_endEftName = nil

    -- 时间制约型技能使用 (即技能的开展到结束有指定的时间限制)
    self.m_timeLimit = nil
    -- 在特定时间内 产生伤害或数值的间隔 (是个数组间隔不是平均的)
    self.m_injuryIntervals = nil
    -- 在特定时间内 产生伤害或数值的间隔 (是数值间隔是平均值)
    self.m_averageInjuryInterval = nil
    -- 用于平均间隔的时间计算
    self.m_averageIntervalelapsedTime = 0
    -- 触发间隔事件的计数器
    self.m_intervalCnt = 0
    -- 用于记录已被击中的目标 (有些技能要求多次攻击, 但被击中过的, 不再受当次技能影响了)
    self.m_hitedTargets = {}

    self.mc_sn = SnMgr:getSn()

    -- 通常为非战斗场景使用
    -- 施法者 Live
    self.m_casterLive = nil
    -- 目标者 Live
    self.m_targetLive = nil
end

function dtor(self)
    SnMgr:disposeSn(self.mc_sn)
    self.mc_sn = nil
end
function sn(self)
    return self.mc_sn
end
-- 通常为非战斗场景使用
function setTempLive(self, casterLive, targetLive)
    self.m_casterLive = casterLive
    self.m_targetLive = targetLive
end

function createPerf(self)
    if self.SPERF_CLS then
        -- print("SPERF_CLS", self.SPERF_CLS.__cname)
        return self.SPERF_CLS.new()
    end
end

-- 添加事件回调
function setEventCall(self, hitCall, endCall)
    self.m_hitCall = hitCall
    self.m_endCall = endCall
end

-- 表现数据
function setPerfData(self, rootPrefabName, endEftName, lifeTime, param)
    self.m_rootPrefabName = rootPrefabName
    self.m_endEftName = endEftName
    self.m_param = param
    if lifeTime and lifeTime > 0 then
        self:setTimeLimit(lifeTime)
    else
        self:setTimeLimit(nil)
    end
end

function setSimplePoint(self, pointType)
    self.m_simplePoint = pointType
end

function getSimplePoint(self)
    if self.m_simplePoint == 1 then --目标位置
        local liveThing = self:getTarget()
        if liveThing then
            return liveThing:getCurPos(), liveThing:getTrans()
        end
    elseif self.m_simplePoint == 2 then --施法者阵营中心
        local liveVo = self:getCasterVo()
        if self:getCasterSide() == 1 then
            return fight.SceneGrid:getACenter()
        end
        -- 通常为非战斗场景使用
        if self.m_casterLive then
            return self.m_casterLive.position, self.m_casterLive
        end
        return fight.SceneGrid:getDCenter()
    elseif self.m_simplePoint == 3 then --目标阵营中心
        local liveVo = self:getCasterVo()
        if self:getCasterSide() == 1 then
            return fight.SceneGrid:getDCenter()
        end
        -- 通常为非战斗场景使用
        if self.m_targetLive then
            return self.m_targetLive.position, self.m_targetLive
        end
        return fight.SceneGrid:getACenter()
    elseif self.m_simplePoint == 4 then --释法者位置的地上
        local liveThing = self:getCaster()
        if liveThing then
            return liveThing:getCurPos(), fight.SceneGrid:getRootTrans(), liveThing:getAngle()
        end
    elseif self.m_simplePoint == 5 then --战场中央
        local liveThing = self:getCaster()
        if liveThing then
            return gs.VEC3_ZERO, nil, liveThing:getLiveVo().isAtt == 1 and 0 or 180
        end
    else --施法者位置
        local liveThing = self:getCaster()
        if liveThing then
            return liveThing:getCurPos(), liveThing:getTrans()
        end
    end
end

-- 取施法者阵营
function getCasterSide(self)
    local liveVo = self:getCasterVo()
    if liveVo then
        return liveVo:isAttacker()
    end
    return self:getSide()
end

function setTargetStartPoint(self, pointType)
    self.m_targetStartPoint = pointType
end
function setSelfStartPoint(self, pointType)
    self.m_selfStartPoint = pointType
end
function setEndPointType(self, pointType)
    self.m_endPointType = pointType
end

function getStartPointPos(self)
    if self.m_targetStartPoint then
        local liveThing = self:getTarget()
        if liveThing then
            local root = liveThing:getPointTrans(self.m_targetStartPoint)
            if not root then
                root = liveThing:getTrans()
            end
            if root then
                local pos = root.position
                return math.Vector3(pos.x, pos.y, pos.z), root
            end
        end
        local liveVo = self:getTargetVo()
        if liveVo then
            return liveVo:getCurPos()
        end
        if self.m_targetLive then
            return self.m_targetLive.position
        end
    end
    if self.m_selfStartPoint then
        local liveThing = self:getCaster()
        if liveThing then
            local root = liveThing:getPointTrans(self.m_selfStartPoint)
            if not root then
                root = liveThing:getTrans()
            end
            if root then
                local pos = root.position
                return math.Vector3(pos.x, pos.y, pos.z), root
            end
        end
        local liveVo = self:getCasterVo()
        if liveVo then
            return liveVo:getCurPos()
        end
        if self.m_casterLive then
            return self.m_casterLive.position
        end
    end
    return math.Vector3(0, 0, 0)
    -- if self.m_startPointType==0 then
    -- 	return math.Vector3(0,0,0)
    -- elseif self.m_startPointType>4 then
    -- 	local liveThing = self:getTarget()
    -- 	if liveThing then
    -- 		local pos =nil
    -- 		if self.m_startPointType==5 then
    -- 			pos = liveThing:getPointPos(fight.FightDef.POINT_ROOT)
    -- 		elseif self.m_startPointType==6 then
    -- 			pos = liveThing:getPointPos(fight.FightDef.POINT_SPINE)
    -- 		end
    -- 		if pos then
    -- 			return math.Vector3(pos.x, pos.y, pos.z)
    -- 		end
    -- 	end
    -- 	local liveVo = self:getTargetVo()
    -- 	if liveVo then
    -- 		return liveVo:getCurPos()
    -- 	end
    -- else
    -- 	local liveThing = self:getCaster()
    -- 	if liveThing then
    -- 		local pos =nil
    -- 		if self.m_startPointType==1 then
    -- 			pos = liveThing:getPointPos(fight.FightDef.POINT_LWEAPON)
    -- 		elseif self.m_startPointType==2 then
    -- 			pos = liveThing:getPointPos(fight.FightDef.POINT_RWEAPON)
    -- 		elseif self.m_startPointType==3 then
    -- 			pos = liveThing:getPointPos(fight.FightDef.POINT_ROOT)
    -- 		elseif self.m_startPointType==4 then
    -- 			pos = liveThing:getPointPos(fight.FightDef.POINT_SPINE)
    -- 		end
    -- 		if pos then
    -- 			return math.Vector3(pos.x, pos.y, pos.z)
    -- 		end
    -- 	end
    -- 	local liveVo = self:getCasterVo()
    -- 	if liveVo then
    -- 		return liveVo:getCurPos()
    -- 	end
    -- end
end

function getEndPointPos(self)
    if self.m_endPointType == 0 then
        return math.Vector3(0, 0, 0)
    else
        local liveThing = self:getTarget()
        if liveThing then
            local pos = nil
            if self.m_endPointType == 1 then
                pos = liveThing:getPointPos(fight.FightDef.POINT_ROOT)
            elseif self.m_endPointType == 2 then
                pos = liveThing:getPointPos(fight.FightDef.POINT_SPINE)
            end
            if pos then
                return math.Vector3(pos.x, pos.y, pos.z)
            end
        end
        local liveVo = self:getTargetVo()
        if liveVo then
            return liveVo:getCurPos()
        end
        if self.m_targetLive then
            return self.m_targetLive.position
        end
    end
end

-- function getPerfID(self)
-- 	return self.m_perfRo:getPerfId()
-- end
function getCurPos(self)
    return self.m_curPosV3
end
function setCurPos(self, v3)
    self.m_curPosV3 = v3
end

function getCaster(self)
    local live = fight.SceneItemManager:getLivething(self.m_casterID)
    if live then
        return live
    end
    if self.m_casterLive then
        return self.m_casterLive
    end
end
function getCasterVo(self)
    return fight.SceneManager:getThing(self.m_casterID)
end

function getTarget(self)
    local live = fight.SceneItemManager:getLivething(self.m_targetID)
    if live then
        return live
    end
    if self.m_taragetLive then
        return self.m_taragetLive
    end
end
function getTargetVo(self)
    return fight.SceneManager:getThing(self.m_targetID)
end
function isVoNearV3(self, vo, v3)
    local curPos = vo:getCurPos()
    if math.v3DistanceNoSqrt(v3, curPos) < 1.5 then
        return true
    end
    return false
end

-- 设置所属的技能ID
function setSkillID(self, skillID)
    self.m_skillID = skillID
end
function getSkillID(self)
    return self.m_skillID
end
-- 设置最大攻击数
function setMaxHitCnt(self, hitCnt)
    self.m_maxHitCnt = hitCnt
end

-- 启动
function start(self)
    STravelHandle:addTravel(self)
    STravelHandle:addPerf(self)
    self.m_timeStart = true
end
-- 开始伤害间隔触发事件
function startInjuryInterval(self)
    return true
    -- local interval = self.m_perfRo:getInterval()
    -- if interval>0 then
    -- 	self:setInjuryInterval00(interval)
    -- 	return true
    -- end
    -- return false
end

-- 暂停
function pause(self)
    self.m_isPause = true
    STravelHandle:perfHandle(self, STravelDef.PERF_PAUSE)
end
-- 继续
function resume(self)
    self.m_isPause = false
    STravelHandle:perfHandle(self, STravelDef.PERF_RESUME)
end
-- 返回真正的目标点
function _getTargetVec3(self)
    if self.m_targetID then
        --获取目标实体的坐标
        local liveVo = self:getTargetVo()
        if liveVo then
            return liveVo:getCurPos()
        end
        if self.m_targetLive then
            return self.m_targetLive.position
        end
    end
    return self.m_targetVec3
end
-- 设置施法者实体ID
function setCasterID(self, casterID)
    self.m_casterID = casterID
end
function getCasterID(self)
    return self.m_casterID
end
-- 目标id
function getTragetID(self)
    return self.m_targetID
end
-- 设置朝向目标实体ID
function setTargetID(self, targetID)
    self.m_targetID = targetID
end
-- 设置朝向目标坐标
function setTargetVec3(self, vec3)
    self.m_targetVec3 = vec3
end
-- 设置基础速度
function setSpeed(self, speed)
    self.m_speed = speed
    STravelHandle:perfHandle(self, STravelDef.PERF_SPEED, speed)
end
function getBaseSpeed(self)
    return self.m_speed
end
-- 设置移动中是否会有追踪功能
function setTrackEnable(self, beTrack)
    self.m_isTrack = beTrack
end
-- 设置施法者阵营
function setSide(self, side)
    self.m_side = side
end
-- 获取施法者阵营
function getSide(self)
    return self.m_side
end
---扩展属性----------------------------------------
-- 设置移动中是否有攻击行为
function setMoveAtkData(self, isMoveAtk, isMoveAtkEnd)
    self.m_isMoveAtk = isMoveAtk
    self.m_isMoveAtkEnd = isMoveAtkEnd
end
-- 设置结束时的爆炸特效
function setEndEftName(self, eftName)
    self.m_endEftName = eftName
end

-- 设置制约时间
function setTimeLimit(self, timeLimit)
    self.m_timeLimit = timeLimit
end
function getTimeLimit(self)
    return self.m_timeLimit
end

-- 设置触发事件间隔 averageInterval 为平均值
function setInjuryInterval00(self, averageInterval)
    self.m_averageInjuryInterval = averageInterval
    self.m_injuryIntervals = nil
end
-- 设置触发事件间隔 intervals 为间隔数组
function setInjuryInterval01(self, intervals)
    self.m_injuryIntervals = intervals
    self.m_averageInjuryInterval = nil
end

-- 获取范围内目标s (由子类重写)
function getRangeTarget(self)
end
-- 设置特定的数据 具体逻辑由轨迹子类实现
function setSpecialData(self, ...)
end

-- 更新 具体由子类实现
function updateTravel(self, deltaTime)
    if self.m_timeStart and self.m_isPause == false then
        -- 有时间制约的处理
        if self.m_timeLimit ~= nil then
            -- print(self.m_timeLimit, deltaTime)
            self.m_timeLimit = self.m_timeLimit - deltaTime

            if self.m_timeLimit <= 0 then
                self:onEnd()
                return false
            end
        end
        -- 定时触发伤害或计算事件的处理 (固定时间间隔)
        if not table.empty(self.m_injuryIntervals) then
            local interval = self.m_injuryIntervals[1]
            interval = interval - deltaTime
            if interval <= 0 then
                table.remove(self.m_injuryIntervals, 1)
                self.m_intervalCnt = self.m_intervalCnt + 1
                self:onIntervalInjury(self.m_intervalCnt)
                if not table.empty(self.m_injuryIntervals) then
                    self.m_injuryIntervals[1] = self.m_injuryIntervals[1] + interval
                end
            end
            -- 平均间隔
        elseif self.m_averageInjuryInterval then
            self.m_averageIntervalelapsedTime = self.m_averageIntervalelapsedTime + deltaTime
            if self.m_averageIntervalelapsedTime >= self.m_averageInjuryInterval then
                self.m_averageIntervalelapsedTime = 0
                self.m_intervalCnt = self.m_intervalCnt + 1
                self:onIntervalInjury(self.m_intervalCnt)
            end
        end
        return true
    end
    return false
end

-- 触发击中事件
function onHitTargetIds(self, targetIds, ...)
    if targetIds then
        if type(targetIds) == "table" then
            for _, id in ipairs(targetIds) do
                self.m_hitedTargets[id] = true
            end
        else
            self.m_hitedTargets[targetIds] = true
            targetIds = { targetIds }
        end
        STravelHandle:perfHandle(self, STravelDef.PERF_HIT, targetIds)
        -- print("caster "..self.m_casterID.." use skill "..self.m_skillID.." hit ", table.concat(targetIds, ", "))
        if self.m_hitCall then
            self.m_hitCall(self.m_skillID, self.m_casterID, targetIds, ...)
        end
    end
end
-- 轨道类到达目标点
function onArrive(self)
    STravelHandle:perfHandle(self, STravelDef.PERF_ARRIVE)
end
-- 触发间隔伤害 (由子类扩展)
function onIntervalInjury(self, cnt)
end
-- 整个播放结束
function onEnd(self)
    if self.m_endCall then
        self.m_endCall(self)
        self.m_endCall = nil
    end
    self.m_timeStart = false
    STravelHandle:perfHandle(self, STravelDef.PERF_END)
    STravelHandle:removeTravel(self.mc_sn)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]