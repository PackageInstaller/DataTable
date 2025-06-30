mainExplore.Rad2Deg = 180 / math.pi

-- 通过格子的xyz索引获取格子的本地坐标
mainExplore.getGridLocalPos = function(mapId, gridRow, gridCol, gridHeightNum)
    local mapConfigVo = mainExplore.MainExploreSceneManager:getClientMapConfigVo(mapId)
    local leftBottomPos = mapConfigVo.leftBottomPos
    local gridSize = mapConfigVo.gridSize
    local gridHeight = gridHeightNum * gridSize
    return math.Vector3(leftBottomPos.x + (gridCol - 1) * gridSize, leftBottomPos.y + gridHeight / 2, leftBottomPos.z + (gridRow - 1) * gridSize)
end

-- 通过格子的本地坐标获取格子的xyz索引
mainExplore.getGridXYZ = function(mapId, localPosition)
    local mapConfigVo = mainExplore.MainExploreSceneManager:getClientMapConfigVo(mapId)
    local leftBottomPos = mapConfigVo.leftBottomPos
    local gridSize = mapConfigVo.gridSize
    return math.Vector3(gs.Mathf.RoundToInt((localPosition.x - leftBottomPos.x) / gridSize + 1), (localPosition.y - leftBottomPos.y) * 2 / gridSize, gs.Mathf.RoundToInt((localPosition.z - leftBottomPos.z) / gridSize + 1))
end

-- 扇形攻击范围（待放到C#封装）
-- attacker:攻击者
-- attacked:被攻击方
-- attackerAngle:索敌角度
-- attackerRadius:索敌半径
mainExplore.isInUmbrella = function(attackedTrans, attackerTrans, attackerAngle, attackerRadius)
    -- local deltaAngle = attackedTrans.position - attackerTrans.position
    -- -- gs.Mathf.Rad2Deg : 弧度值到度转换常度
    -- -- gs.Mathf.Acos(f) : 返回参数f的反余弦值
    -- local tmpAngle = math.acos(gs.Vector3.Dot(deltaAngle.normalized, attackerTrans.forward)) * mainExplore.Rad2Deg
    -- if (tmpAngle < attackerAngle * 0.5 and deltaAngle.magnitude < attackerRadius)then
    --     return true
    -- end
    -- return false
    return gs.MathUtil.isInUmbrella(attackedTrans, attackerTrans, attackerAngle, attackerRadius)
end

-- 判断是否零向量
mainExplore.isZeroVector3 = function(vector3)
    if(not vector3)then
        return true
    end
    return vector3.x == 0 and vector3.y == 0 and vector3.z == 0
end

-- 行为状态
mainExplore.BehaviorState = {
    -- 站立状态
    IDLE = 1,
    -- 键盘移动
    KEYBOARD_MOVE = 2,
    -- 摇杆移动
    JOYSTICK_MOVE = 3,
    -- 玩家定点跑动
    PLAYER_TARGET_POS_RUN = 4,
    -- 怪物定点移动
    MONSTER_TARGET_POS_MOVE = 5,
    -- 通用定点移动
    COMMON_TARGET_POS_MOVE = 6,
    -- 玩家攻击
    PLAYER_ATTACK = 7,
    -- 小怪攻击
    MONSTER_ATTACK = 8,
    -- BOSS攻击
    BOSS_ATTACK = 9,
}

-- 物件类型
mainExplore.ThingType = {
    -- 通用物件
    NORMAL = 1,
    -- 玩家
    PLAYER = 2,
    -- 其他玩家
    OTHER_PLAYER = 3,
    -- NPC
    NPC = 4,
    -- 巡逻怪
    MONSTER = 5,
}

-- 事件总类型
mainExplore.TotalType = {
    -- 常规类型
    NORMAL = 1,
    -- 环境类型
    ENVIRONMENT = 2,
}

-- 事件类型
mainExplore.EventType = {
    -- 宝箱
    AWARD_BOX = 1,
    -- 小怪副本
    DUP_MONSTER = 2,
    -- BOSS副本
    DUP_BOSS = 3,
    -- 传送门
    DELIVERY = 4,
    -- 隐藏对话
    HIDE_TALK = 5,
    -- 物资箱
    GOODS = 6,
    -- 指引提示
    REMIND_TIP = 7,
    -- 锚点核心
    ANCHOR_CORE = 8,
    -- NPC对话
    NPC_TALK = 9,
    -- 障碍物（开）
    OBSTACLE_OPEN = 10,
    -- 障碍物（关）
    OBSTACLE_CLOSE = 11,
    -- 障碍物控制开关
    OBSTACLE_SWITCHER = 12,
    -- 营地
    CAMP_ADD_HP = 13,
    -- 陷阱
    TRAP_DEL_HP = 14,
    -- 减速地带（后端没有详细位置，所以不经过后端，客户端自己处理）
    DECELERATE_AREA = 15,
}

-- 巡逻类型
mainExplore.PartolType = {
    -- 来回循环
    LAIHUI = 1,
    -- 闭合循环
    BIHE = 2,
    -- 随机循环
    RANDOM = 3,
}

-- 触发状态
mainExplore.TriggerState = {
    -- 无
    NONE = 0,
    -- 游戏暂停
    GAME_PAUSE = 1,
    -- 玩家不可操作
    PLAYER_FORBID_CONTROL = 2,
    -- 怪物取消索敌
    MONSTER_FORBID_FIND_AI = 3,
    -- 主角模型隐藏
    PLAYER_HIDE = 4,
    -- 怪物模型隐藏
    MONSTER_HIDE = 5,
    -- 相机更新能力
    CAMERA_UPDATE_ENABLE = 6,
    -- 界面UI显示能力
    UI_VISIBLE_ENABLE = 7,
}

-- 英雄来源类型（和后端一致）
mainExplore.HERO_SOURCE_TYPE = {
    -- 玩家自己的英雄
    OWN = 0,
    -- 外援英雄
    SUPPORT = 1,
}

--------------------------------------------- 根据类型获取对象 ---------------------------------------------
mainExplore.getThingVo = function(thingType)
    local class = nil
    if (thingType == mainExplore.ThingType.PLAYER) then
        class = mainExplore.MainExplorePlayerThingVo
    elseif (thingType == mainExplore.ThingType.MONSTER) then
        class = mainExplore.MainExploreMonsterThingVo
    else
        class = mainExplore.MainExploreBaseThingVo
    end
    local thingVo = LuaPoolMgr:poolGet(class)
    thingVo:setType(thingType)
    return thingVo
end

mainExplore.getThing = function(thingType)
    local class = nil
    if (thingType == mainExplore.ThingType.PLAYER) then
        class = mainExplore.MainExplorePlayerThing
    elseif (thingType == mainExplore.ThingType.MONSTER) then
        class = mainExplore.MainExploreMonsterThing
    elseif (thingType == mainExplore.ThingType.NPC) then
        class = mainExplore.MainExploreMonsterThing
    else
        class = mainExplore.MainExploreNormalThing
    end
    return LuaPoolMgr:poolGet(class)
end

-- 判断两点间是否存在阻碍物
mainExplore.getNavMeshHit = function(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, areaMask)
    return gs.UnityEngineUtil.GetNavMeshHit(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, areaMask)
end

-- 获取路径节点
mainExplore.getNavMeshPath = function(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, areaName, isIncludeStartEnd)
    local posList = nil
    local navMeshHit = nil
    local areaMask = gs.UnityEngineUtil.GetAreaMask(areaName)
    navMeshHit = mainExplore.getNavMeshHit(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, areaMask)
    if(not navMeshHit or not navMeshHit.hit)then
        local navMeshPath = gs.UnityEngineUtil.GetNavMeshPath(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, areaMask)
        local result = gs.UnityEngineUtil.NavMeshPathToString(navMeshPath, 0)
        if(result ~= "")then
            posList = {}
            if(isIncludeStartEnd)then
                table.insert(posList, math.Vector3(startPosX, startPosY, startPosZ))
            end
            local posStrList = string.split(string.sub(result, 2, -2), ")(")
            for i = 1, #posStrList do
                local pos = string.split(posStrList[i], ",")
                table.insert(posList, math.Vector3(tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3])))
            end
            if(isIncludeStartEnd)then
                table.insert(posList, math.Vector3(endPosX, endPosY, endPosZ))
            end
        end
    end
    return navMeshHit, posList
end

-- 根据状态获取动作hash
mainExplore.getActionHashByState = function(state)
    local hash = fight.FightDef.ACT_STAND
    if(state == mainExplore.BehaviorState.IDLE)then                         -- 站立状态
        hash = fight.FightDef.ACT_STAND
    elseif(state == mainExplore.BehaviorState.KEYBOARD_MOVE)then            -- 键盘移动
        hash = fight.FightDef.ACT_RUN
    elseif(state == mainExplore.BehaviorState.JOYSTICK_MOVE)then            -- 摇杆移动
        hash = fight.FightDef.ACT_RUN
    elseif(state == mainExplore.BehaviorState.PLAYER_TARGET_POS_RUN)then    -- 玩家定点跑动
        hash = fight.FightDef.ACT_RUN
    elseif(state == mainExplore.BehaviorState.MONSTER_TARGET_POS_MOVE)then  -- 怪物定点移动
        hash = fight.FightDef.ACT_WALK
    elseif(state == mainExplore.BehaviorState.COMMON_TARGET_POS_MOVE)then   -- 通用定点移动
        hash = fight.FightDef.ACT_WALK
    elseif(state == mainExplore.BehaviorState.PLAYER_ATTACK)then            -- 玩家攻击
        hash = fight.FightDef.ACT_ATTACK_1
    elseif(state == mainExplore.BehaviorState.MONSTER_ATTACK)then           -- 小怪攻击
        hash = fight.FightDef.ACT_SKILL_1
    elseif(state == mainExplore.BehaviorState.BOSS_ATTACK)then              -- BOSS攻击
        hash = fight.FightDef.ACT_SKILL_2
    end
    return hash
end

-- 根据状态获取触发hash
mainExplore.getTriggerHashByState = function(state)
    local hash = nil
    if(state == mainExplore.BehaviorState.IDLE)then                         -- 站立状态
        hash = fight.FightDef.ANI_TRIGGER_TO_STAND
    elseif(state == mainExplore.BehaviorState.KEYBOARD_MOVE)then            -- 键盘移动
        hash = fight.FightDef.ANI_TRIGGER_TO_RUN
    elseif(state == mainExplore.BehaviorState.JOYSTICK_MOVE)then            -- 摇杆移动
        hash = fight.FightDef.ANI_TRIGGER_TO_RUN
    elseif(state == mainExplore.BehaviorState.PLAYER_TARGET_POS_RUN)then    -- 玩家定点跑动
        hash = fight.FightDef.ANI_TRIGGER_TO_RUN
    -- elseif(state == mainExplore.BehaviorState.MONSTER_TARGET_POS_MOVE)then  -- 怪物定点移动（状态机暂无此触发）
    --     hash = fight.FightDef.ANI_TRIGGER_TO_WALK
    -- elseif(state == mainExplore.BehaviorState.COMMON_TARGET_POS_MOVE)then   -- 通用定点移动（状态机暂无此触发）
    --     hash = fight.FightDef.ANI_TRIGGER_TO_WALK
    end
    return hash
end
 
--[[ 替换语言包自动生成，请勿修改！
]]
