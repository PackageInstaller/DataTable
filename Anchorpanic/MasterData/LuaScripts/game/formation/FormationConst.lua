local ENUM_IDX = 0
local function _enumID()
    ENUM_IDX = ENUM_IDX + 1
    return ENUM_IDX
end

--灾厄特殊阵型
formation.DISASTAERIMID = 19099

-- 阵型关闭后，回调原因参数
formation.CALL_FUN_REASON = {
    -- 被动关闭界面
    CLOSE = 1,
    -- 玩家主动关闭界面
    PLAYER_CLOSE = 2,
    -- 玩家主动关闭全部界面
    PLAYER_CLOSE_ALL = 3
}

-- 英雄来源类型
formation.HERO_SOURCE_TYPE = {
    -- 玩家自己的英雄
    OWN = 1,
    -- 主线关卡剧情外援英雄
    MAIN_STORY = 2,
    -- 竞技场敌方玩家或机器人
    ARENA = 3,
    -- 迷宫支援英雄
    MAZE_SUPPORT = 4,
    -- 新手训练英雄
    TEACHING = 5,
    -- 主探索支援英雄
    MAIN_EXPLORE_SUPPORT = 6,
    -- 保护平民
    PROTECT_PEOPLE = 7,
}

-- 阵型数据类型（和后端对应）
formation.DATA_TYPE = {
    -- 通用
    NORMAL = 1,
    -- 竞技场
    ARENA_DEFENSE = 2,
    -- 迷宫
    MAZE = 3,
    -- 竞技场进攻
    ARENA_ATTACK = 4,
    -- 元素塔
    ELEMENT_TOWER = 5,
    -- 锚点探索走地图
    MAIN_EXPLORE = 6,
    -- 使徒之战2
    APOSTLE2WAR = 7,
    --代号希望
    CODE_HOPE = 8,

    --默示之境
    DUPIMPLIED = 9,

    --事影循回
    CYCLE = 10,
    --活动本
    ACTIVEDUP = 11,
    -- 综合对抗赛（巅峰竞技场）
    ARENA_PEAK_ATTACK = 12,
    -- 综合对抗赛（巅峰竞技场）
    ARENA_PEAK_DEFENSE = 13,
    -- 联盟boss战
    GUILD_BOSS_WAR = 14,
    --无限城
    DOUNDLESS = 15,
    --联盟扫荡
    GUILD_SWEEP = 16,
    --沙盒地图阵型
    SANDPLAY = 17,
    --无限城锁定
    DOUNDLESSLOCK = 18,
    --灾厄
    DISASTER = 19,
    --公会训练场
    GUILD_IMITATE = 20,

    --海底
    SEABED = 21,

    --团战防御
    GUILDWAR_DEF = 22,
    --团战攻击
    GUILDWAR_ATK = 23,
   
}

-- 根据 后端阵型分段类型 获取 阵型类型
formation.getFormationTypeByDataType = function(dataType)
    if (dataType == formation.DATA_TYPE.ARENA_DEFENSE) then
        return formation.TYPE.ARENA_DEFENSE
        -- elseif (dataType == formation.DATA_TYPE.MAZE) then
        --     return formation.TYPE.MAZE
    elseif (dataType == formation.DATA_TYPE.ARENA_ATTACK) then
        return formation.TYPE.ARENA_ATTACK
        -- elseif(dataType == formation.DATA_TYPE.ROGUELIKE) then
        --     return formation.TYPE.ROGUELIKE
    elseif (dataType == formation.DATA_TYPE.MAIN_EXPLORE) then
        return formation.TYPE.MAIN_EXPLORE
    elseif (dataType == formation.DATA_TYPE.APOSTLE2WAR) then
        return formation.TYPE.DUP_APOSTLES
    elseif (dataType == formation.DATA_TYPE.CODE_HOPE) then
        return formation.TYPE.CODE_HOPE
    elseif (dataType == formation.DATA_TYPE.DUPIMPLIED) then
        return formation.TYPE.DUPIMPLIED
    elseif (dataType == formation.DATA_TYPE.ELEMENT_TOWER) then
        return formation.TYPE.ELEMENT
    elseif (dataType == formation.DATA_TYPE.ACTIVEDUP) then
        return formation.TYPE.ACTIVEDUP
    elseif (dataType == formation.DATA_TYPE.ARENA_PEAK_DEFENSE) then
        return formation.TYPE.ARENA_PEAK_DEFENSE
    elseif (dataType == formation.DATA_TYPE.ARENA_PEAK_ATTACK) then
        return formation.TYPE.ARENA_PEAK_ATTACK
    elseif (dataType == formation.DATA_TYPE.GUILD_BOSS_WAR) then
        return formation.TYPE.GUILD_BOSS_WAR
    elseif (dataType == formation.DATA_TYPE.DOUNDLESS) then
        return formation.TYPE.DOUNDLESS
    elseif(dataType == formation.DATA_TYPE.GUILD_SWEEP) then
        return formation.TYPE.GUILD_SWEEP
    elseif(dataType == formation.DATA_TYPE.SANDPLAY) then
        return formation.TYPE.SANDPLAY
    elseif(dataType == formation.DATA_TYPE.GUILD_IMITATE) then
        return formation.TYPE.GUILD_IMITATE
    elseif(dataType == formation.DATA_TYPE.DOUNDLESSLOCK) then
        return formation.TYPE.DOUNDLESSLOCK
    elseif(dataType == formation.DATA_TYPE.DISASTER) then
        return formation.TYPE.DISASTER
    elseif(dataType == formation.DATA_TYPE.SEABED) then
        return formation.TYPE.SEABED
    elseif(dataType == formation.DATA_TYPE.GUILDWAR_DEF) then
        return formation.TYPE.GUILDWARDEF
    elseif(dataType == formation.DATA_TYPE.GUILDWAR_ATK) then
        return formation.TYPE.GUILDWARATK
    else
        return formation.TYPE.NORMAL
    end
end

-- 根据 阵型类型 获取 后端阵型分段类型
formation.getDataTypeByFormationType = function(formationType)
    if (formationType == formation.TYPE.ARENA_DEFENSE) then
        return formation.DATA_TYPE.ARENA_DEFENSE
        -- elseif (formationType == formation.TYPE.MAZE) then
        --     return formation.DATA_TYPE.MAZE
    elseif (formationType == formation.TYPE.ARENA_ATTACK) then
        return formation.DATA_TYPE.ARENA_ATTACK
    elseif (formationType == formation.TYPE.ROGUELIKE) then
        return formation.DATA_TYPE.ROGUELIKE
    elseif (formationType == formation.TYPE.MAIN_EXPLORE) then
        return formation.DATA_TYPE.MAIN_EXPLORE
    elseif (formationType == formation.TYPE.DUP_APOSTLES) then
        return formation.DATA_TYPE.APOSTLE2WAR
    elseif (formationType == formation.TYPE.CODE_HOPE) then
        return formation.DATA_TYPE.CODE_HOPE
    elseif (formationType == formation.TYPE.DUPIMPLIED) then
        return formation.DATA_TYPE.DUPIMPLIED
    elseif (formationType == formation.TYPE.CYCLE) then
        return formation.DATA_TYPE.CYCLE
    elseif (formationType == formation.TYPE.ELEMENT) then
        return formation.DATA_TYPE.ELEMENT_TOWER
    elseif (formationType == formation.TYPE.ACTIVEDUP) then
        return formation.DATA_TYPE.ACTIVEDUP
    elseif (formationType == formation.TYPE.ARENA_PEAK_DEFENSE) then
        return formation.DATA_TYPE.ARENA_PEAK_DEFENSE
    elseif (formationType == formation.TYPE.ARENA_PEAK_ATTACK) then
        return formation.DATA_TYPE.ARENA_PEAK_ATTACK
    elseif (formationType == formation.TYPE.GUILD_BOSS_WAR) then
        return formation.DATA_TYPE.GUILD_BOSS_WAR
    elseif (formationType == formation.TYPE.DOUNDLESS) then
        return formation.DATA_TYPE.DOUNDLESS
    elseif (formationType == formation.TYPE.GUILD_SWEEP) then
        return formation.DATA_TYPE.GUILD_SWEEP
    elseif (formationType == formation.TYPE.SANDPLAY) then
        return formation.DATA_TYPE.SANDPLAY
    elseif (formationType == formation.TYPE.GUILD_IMITATE) then
        return formation.DATA_TYPE.GUILD_IMITATE
    elseif(formationType == formation.TYPE.DOUNDLESSLOCK) then
        return formation.DATA_TYPE.DOUNDLESSLOCK
    elseif (formationType == formation.TYPE.DISASTER) then
        return formation.DATA_TYPE.DISASTER
    elseif(formationType == formation.TYPE.SEABED) then
        return formation.DATA_TYPE.SEABED
    elseif (formationType == formation.TYPE.GUILDWARDEF) then
        return formation.DATA_TYPE.GUILDWAR_DEF
    elseif (formationType == formation.TYPE.GUILDWARATK) then
        return formation.DATA_TYPE.GUILDWAR_ATK
    else
        return formation.DATA_TYPE.NORMAL
    end
end

-- 根据阵型类型和数据id求得符合后端数据的teamid
formation.getTeamIdByDataType = function(formationType, dataId)
    dataId = dataId or 0
    return formation.getDataTypeByFormationType(formationType) * 1000 + dataId
end

----------------------------------------------------- start 模块类型 ------------------------------------------------------
formation.TYPE = {}
-- 通用阵容类型（编辑 + 进攻）
formation.TYPE.NORMAL = _enumID()
-- 玩家的编辑阵容类型
formation.TYPE.PLAYER_EDIT = _enumID()
-- 竞技场防守阵容类型
formation.TYPE.ARENA_DEFENSE = _enumID()
-- 主线可选支援阵容类型
formation.TYPE.MAIN_SUPPORT = _enumID()
-- 主线固定支援阵容类型
formation.TYPE.MAIN_FIXED = _enumID()
-- 主线分配支援阵容类型
formation.TYPE.MAIN_DISTRIBUTE = _enumID()

-- 迷宫·副本
formation.TYPE.MAZE = _enumID()
-- 代号·希望副本
formation.TYPE.CODE_HOPE = _enumID()
-- 新手训练
formation.TYPE.TEACHING = _enumID()
-- 力场
formation.TYPE.POWER = _enumID()
-- 竞技场进攻队列
formation.TYPE.ARENA_ATTACK = _enumID()
-- 肉鸽
formation.TYPE.ROGUELIKE = _enumID()
-- 锚点探索走地图
formation.TYPE.MAIN_EXPLORE = _enumID()
-- 使徒之战2
formation.TYPE.DUP_APOSTLES = _enumID() --14
-- 无用，新手训练用到阵型协议，给那边特殊用，无实际意义
formation.TYPE.NONE = _enumID()
--联合扫荡 末世之景
formation.TYPE.DUPIMPLIED = _enumID() --16
-- 元素塔
formation.TYPE.ELEMENT = _enumID() --17
--事影循回
formation.TYPE.CYCLE = _enumID()
-- 爬塔
formation.TYPE.CLIMBTOWER = _enumID()
-- 活动副本
formation.TYPE.ACTIVEDUP = _enumID()
-- 巅峰竞技场进攻
formation.TYPE.ARENA_PEAK_ATTACK = _enumID()
-- 巅峰竞技场防御
formation.TYPE.ARENA_PEAK_DEFENSE = _enumID()
-- 联盟boss战
formation.TYPE.GUILD_BOSS_WAR = _enumID()
-- 无限城
formation.TYPE.DOUNDLESS = _enumID()
--联萌扫荡
formation.TYPE.GUILD_SWEEP = _enumID()

--沙盒地图挑战
formation.TYPE.SANDPLAY = _enumID()

--公会训练场
formation.TYPE.GUILD_IMITATE = _enumID()

-- 无限城锁定
formation.TYPE.DOUNDLESSLOCK = _enumID()
--灾厄
formation.TYPE.DISASTER = _enumID()

formation.TYPE.SEABED = _enumID()

--公会团战
formation.TYPE.GUILDWARATK = _enumID()
formation.TYPE.GUILDWARDEF = _enumID()

------------------------------------------------------ end 模块类型 -------------------------------------------------------
-- 通过模块类型获取队列id列表（队列id和后端定义保持一致）
formation.getTeamIdListByType = function(formationType, dataId)
    if (not formation.TYPE_TEAM_DIC) then
        formation.TYPE_TEAM_DIC = {}
    end
    local isInit = false
    local teamIdList = formation.TYPE_TEAM_DIC[formationType]
    if (not teamIdList) then
        isInit = true
        teamIdList = {}
        formation.TYPE_TEAM_DIC[formationType] = teamIdList
    end
    if (formationType == formation.TYPE.ARENA_DEFENSE) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.TEACHING) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.POWER) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.ARENA_ATTACK) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.ROGUELIKE) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.CODE_HOPE) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
        -- elseif (formationType == formation.TYPE.MAZE) then
        --     -- 动态数据，迷宫类型对应多套阵型数据（dataId为迷宫id）
        --     teamIdList = { formation.getTeamIdByDataType(formationType, dataId) }
    elseif (formationType == formation.TYPE.MAIN_EXPLORE) then
        -- 动态数据，锚点走地图对应多套阵型数据（dataId为副本类型）
        teamIdList = {formation.getTeamIdByDataType(formationType, dataId)}
    elseif (formationType == formation.TYPE.DUP_APOSTLES) then
        -- 动态数据，使徒之战2对应多套阵型数据（dataId为bossid）
        teamIdList = {formation.getTeamIdByDataType(formationType, dataId)}
    elseif (formationType == formation.TYPE.DUPIMPLIED) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.CYCLE) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.ELEMENT) then
        teamIdList = {formation.getTeamIdByDataType(formationType, dataId)}
    elseif (formationType == formation.TYPE.ACTIVEDUP) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.ARENA_PEAK_ATTACK) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 2))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 3))
        end
    elseif (formationType == formation.TYPE.ARENA_PEAK_DEFENSE) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 2))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 3))
        end
    elseif (formationType == formation.TYPE.GUILD_BOSS_WAR) then
        -- 动态数据，联盟boss战对应多套阵型数据（dataId为副本类型）
        teamIdList = {formation.getTeamIdByDataType(formationType, dataId)}
    elseif (formationType == formation.TYPE.DOUNDLESS) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.GUILD_SWEEP) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.SANDPLAY) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.GUILD_IMITATE) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.DOUNDLESSLOCK) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end
    elseif (formationType == formation.TYPE.DISASTER) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 2))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 3))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 4))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 5))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 99))
        end
    elseif(formationType == formation.TYPE.SEABED) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        end

    elseif(formationType == formation.TYPE.GUILDWARATK) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 2))
        end
    elseif(formationType == formation.TYPE.GUILDWARDEF) then
        if (isInit) then
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
            table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 2))
        end
    elseif (isInit) then
        table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 1))
        table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 2))
        table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 3))
        table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 4))
        table.insert(teamIdList, formation.getTeamIdByDataType(formationType, 5))
        return formation.TYPE_TEAM_DIC[formationType]
    end
    return teamIdList or {}
end

-- 根据队列id获取所在队列id模块的索引位置
formation.getTeamIndex = function(type, teamId)
    if (formation.TYPE_TEAM_DIC and formation.TYPE_TEAM_DIC[type]) then
        local teamIdList = formation.TYPE_TEAM_DIC[type]
        for index = 1, #teamIdList do
            if (teamIdList[index] == teamId) then
                return index
            end
        end
    end
    return 1
end

-- 根据队列id获取所在类型包含的队列列表
formation.getTeamIdListById = function(teamId)
    if (formation.TYPE_TEAM_DIC) then
        for type, teamIdList in pairs(formation.TYPE_TEAM_DIC) do
            for _index, _teamId in pairs(teamIdList) do
                if (_teamId == teamId) then
                    return teamIdList
                end
            end
        end
    end
    return {}
end

-- 根据队列id获取所属阵型类型
formation.getFormationTypeById = function(teamId)
    if (formation.DATA_TYPE) then
        -- for _, _dataType in pairs(formation.DATA_TYPE) do
        --     if (string.starts(tostring(teamId), tostring(_dataType))) then
                return formation.getFormationTypeByDataType(math.floor(teamId / 1000))
        --     end
        -- end
    end
    return formation.TYPE.NORMAL
end

-- 重登时调用
formation.resetTypeTeamDic = function()
    formation.TYPE_TEAM_DIC = nil
end

------------------------------------------------------------------------ 英雄阵型战斗流程入口 ------------------------------------------------------------------------
-- 检查是否进入到阵型界面
formation.checkFormationFight = function(cusBattleType, cusDupType, cusDupId, cusFormationType, cusDataId, cusData, cusCallFun, multiTimes)
    local dupMapConfigVo = mainExplore.MainExploreSceneManager:getDupMapConfigVo(cusDupType, cusDupId)
    if (dupMapConfigVo) then
        GameDispatcher:dispatchEvent(EventName.REQ_ENTER_MAIN_EXPLORE_MAP, {dupType = cusDupType, dupId = cusDupId})
    else
        -- 准备进入阵型战斗流程
        formation.readyFormationFight(cusBattleType, cusDupType, cusDupId, cusFormationType, cusDataId, cusData, cusCallFun, multiTimes)
    end
end

-- 准备进入阵型战斗流程
formation.readyFormationFight = function(cusBattleType, cusDupType, cusDupId, cusFormationType, cusDataId, cusData, cusCallFun, multiTimes)
    LoadOnManager:setNowBattleSign(cusBattleType, cusDupId)
    local function _storyFinishCall(successFlag, storyRo)
        local function callFun(callReason)
            if (cusCallFun) then
                cusCallFun(callReason)
            end
            if (callReason == formation.CALL_FUN_REASON.CLOSE) then
                if(subPack and subPack.SubDownLoadController and subPack.SubDownLoadController:checkBattleDownLoadState(cusBattleType, cusDupId))then
                    return
                end
                fight.FightManager:reqBattleEnter(cusBattleType, cusDupId, multiTimes)
            end
        end

        local defaultData = {data = cusData, battleType = cusBattleType, dupType = cusDupType, dupId = cusDupId}
        if (successFlag and storyRo) then
            storyRo.data = cusData
            storyRo.battleType = cusBattleType
            storyRo.dupType = cusDupType
            storyRo.dupId = cusDupId
            if (storyRo:getEffectType() == storyTalk.Effect.TYPE_7) then -- TYPE_7：固定阵型
                formation.openFormation(formation.TYPE.MAIN_FIXED, cusDataId, storyRo:getEffectParam(), callFun)
            elseif (storyRo:getEffectType() == storyTalk.Effect.TYPE_8 or storyRo:getEffectType() == storyTalk.Effect.TYPE_10) then -- TYPE_8：队员分配 TYPE_10：读取队员分配里面保存的数据
                formation.openFormation(formation.TYPE.MAIN_DISTRIBUTE, cusDataId, storyRo, callFun)
            elseif (storyRo:getEffectType() == storyTalk.Effect.TYPE_11) then
                formation.openFormation(formation.TYPE.TEACHING, cusDataId, storyRo, callFun)
            elseif (storyRo:getEffectType() == storyTalk.Effect.TYPE_12) then
                formation.openFormation(formation.TYPE.POWER, cusDataId, storyRo:getEffectParam(), callFun)
            elseif (storyRo:getEffectType() == storyTalk.Effect.TYPE_14) then
                if cusBattleType == PreFightBattleType.Doundless then
                    formation.openFormation(formation.TYPE.DOUNDLESSLOCK, cusDataId, storyRo, callFun)
                else
                    formation.openFormation(formation.TYPE.ACTIVEDUP, cusDataId, storyRo, callFun)
                end
            else
                formation.openFormation(cusFormationType or formation.TYPE.NORMAL, cusDataId, defaultData, callFun)
            end
        else
            formation.openFormation(cusFormationType or formation.TYPE.NORMAL, cusDataId, defaultData, callFun)
        end

        guide.GuideCondition:condition14(cusBattleType, cusDupId)
    end

    -- Debug:log_error("FormationController", "===========%d %d", cusBattleType, cusDupId)
    if not storyTalk.StoryTalkCondition:condition09(cusBattleType, cusDupId, _storyFinishCall) then
        guide.GuideCondition:condition14(cusBattleType, cusDupId)
    end
end

-- 打开阵型界面
formation.openFormation = function(cusFormationType, cusDataId, cusData, cusCallFun)
    formation.FormationManager:initPetData()
    local controller = formation.getFormationController(cusFormationType)
    controller:openFormationPanel(cusFormationType, cusDataId, cusData, cusCallFun)
end

-- 根据类型获取控制器
formation.getFormationController = function(cusFormationType)
    if (cusFormationType == formation.TYPE.NORMAL) then
        return formation.FormationController
    elseif (cusFormationType == formation.TYPE.PLAYER_EDIT) then
        return formation.FormationPlayerEditController
    elseif (cusFormationType == formation.TYPE.ARENA_DEFENSE) then
        return formation.FormationArenaDefenseController
    elseif (cusFormationType == formation.TYPE.MAIN_SUPPORT) then
        return formation.FormationMainSupportController
    elseif (cusFormationType == formation.TYPE.MAIN_FIXED) then
        return formation.FormationMainFixedController
    elseif (cusFormationType == formation.TYPE.MAIN_DISTRIBUTE) then
        return formation.FormationDistributeController
    elseif (cusFormationType == formation.TYPE.CODE_HOPE) then
        return formation.FormationCodeHopeController
        -- elseif (cusFormationType == formation.TYPE.MAZE) then
        --     return formation.FormationMazeController
    elseif (cusFormationType == formation.TYPE.TEACHING) then
        return formation.FormationTeachingController
    elseif (cusFormationType == formation.TYPE.POWER) then
        return formation.FormationPowerController
    elseif (cusFormationType == formation.TYPE.ARENA_ATTACK) then
        return formation.FormationArenaAttackController
        -- elseif(cusFormationType == formation.TYPE.ROGUELIKE) then
        --     return formation.FormationRogueLikeController
    elseif (cusFormationType == formation.TYPE.MAIN_EXPLORE) then
        return formation.FormationMainExploreController
    elseif (cusFormationType == formation.TYPE.DUP_APOSTLES) then
        return formation.FormationApostlesController
    elseif (cusFormationType == formation.TYPE.DUPIMPLIED) then
        return formation.DupImpliedExploreController
    elseif (cusFormationType == formation.TYPE.ELEMENT) then
        return formation.FormationElementTowerController
    elseif (cusFormationType == formation.TYPE.CYCLE) then
        return formation.FormationCycleController
    elseif (cusFormationType == formation.TYPE.CLIMBTOWER) then
        return formation.FormationClimbTowerController
    elseif (cusFormationType == formation.TYPE.ACTIVEDUP) then
        return formation.FormationActivityDupController
    elseif (cusFormationType == formation.TYPE.ARENA_PEAK_DEFENSE) then
        return formation.FormationArenaPeakDefenseController
    elseif (cusFormationType == formation.TYPE.ARENA_PEAK_ATTACK) then
        return formation.FormationArenaPeakAttackController
    elseif (cusFormationType == formation.TYPE.GUILD_BOSS_WAR) then
        return formation.FormationGuildBossWarController
    elseif (cusFormationType == formation.TYPE.SANDPLAY) then
        return formation.FormationSandPlayController
    elseif (cusFormationType == formation.TYPE.GUILD_IMITATE) then
        return formation.FormationGuildBossImitateController
    elseif (cusFormationType == formation.TYPE.DOUNDLESSLOCK) then
        return formation.FormationDoundlessController
    elseif(cusFormationType == formation.TYPE.DISASTER) then
        return formation.FormationDisasterController
    elseif(cusFormationType == formation.TYPE.SEABED) then
        return formation.FormationSeabedController    
    elseif(cusFormationType == formation.TYPE.GUILDWARATK) then
        return formation.FormationGuildWarAtkController 
    elseif(cusFormationType == formation.TYPE.GUILDWARDEF) then
        return formation.FormationGuildWarDefController 
    end
    return formation.FormationController
end

-- start 纯前端用，为找到指定对应控制器
formation.getFormationTypeByController = function(controller)
    if (controller.__cname == formation.FormationController.__cname) then
        return formation.TYPE.NORMAL
    elseif (controller.__cname == formation.FormationPlayerEditController.__cname) then
        return formation.TYPE.PLAYER_EDIT
    elseif (controller.__cname == formation.FormationArenaDefenseController.__cname) then
        return formation.TYPE.ARENA_DEFENSE
    elseif (controller.__cname == formation.FormationMainSupportController.__cname) then
        return formation.TYPE.MAIN_SUPPORT
    elseif (controller.__cname == formation.FormationMainFixedController.__cname) then
        return formation.TYPE.MAIN_FIXED
    elseif (controller.__cname == formation.FormationDistributeController.__cname) then
        return formation.TYPE.MAIN_DISTRIBUTE
    elseif (controller.__cname == formation.FormationCodeHopeController.__cname) then
        return formation.TYPE.CODE_HOPE
        -- elseif (controller.__cname == formation.FormationMazeController.__cname) then
        --     return formation.TYPE.MAZE
    elseif (controller.__cname == formation.FormationTeachingController.__cname) then
        return formation.TYPE.TEACHING
    elseif (controller.__cname == formation.FormationPowerController.__cname) then
        return formation.TYPE.POWER
    elseif (controller.__cname == formation.FormationArenaAttackController.__cname) then
        return formation.TYPE.ARENA_ATTACK
        -- elseif(controller.__cname == formation.FormationRogueLikeController.__cname) then
        --     return formation.TYPE.ROGUELIKE
    elseif (controller.__cname == formation.FormationMainExploreController.__cname) then
        return formation.TYPE.MAIN_EXPLORE
    elseif (controller.__cname == formation.FormationApostlesController.__cname) then
        return formation.TYPE.DUP_APOSTLES
    elseif (controller.__cname == formation.DupImpliedExploreController.__cname) then
        return formation.TYPE.DUPIMPLIED
    elseif (controller.__cname == formation.FormationElementTowerController.__cname) then
        return formation.TYPE.ELEMENT
    elseif (controller.__cname == formation.FormationCycleController.__cname) then
        return formation.TYPE.CYCLE
    elseif (controller.__cname == formation.FormationClimbTowerController.__cname) then
        return formation.TYPE.CLIMBTOWER
    elseif (controller.__cname == formation.FormationActivityDupController.__cname) then
        return formation.TYPE.ACTIVEDUP
    elseif (controller.__cname == formation.FormationArenaPeakDefenseController.__cname) then
        return formation.TYPE.ARENA_PEAK_DEFENSE
    elseif (controller.__cname == formation.FormationArenaPeakAttackController.__cname) then
        return formation.TYPE.ARENA_PEAK_ATTACK
    elseif (controller.__cname == formation.FormationGuildBossWarController.__cname) then
        return formation.TYPE.GUILD_BOSS_WAR
    elseif (controller.__cname == formation.FormationSandPlayController.__cname) then
        return formation.TYPE.SANDPLAY
    elseif (controller.__cname == formation.FormationGuildBossImitateController.__cname) then
        return formation.TYPE.GUILD_IMITATE
    elseif (controller.__cname == formation.FormationDisasterController.__cname) then
        return formation.TYPE.DISASTER
    elseif(controller.__cname == formation.FormationSeabedController.__cname) then
        return formation.TYPE.SEABED

    elseif(controller.__cname == formation.FormationGuildWarAtkController.__cname) then
        return formation.TYPE.GUILDWARATK
    elseif(controller.__cname == formation.FormationGuildWarDefController.__cname) then
        return formation.TYPE.GUILDWARDEF
        -- elseif (controller.__cname == formation.FormationDoundlessController.__cname) then
        --     return formation.TYPE.DOUNDLESS
    end
    return formation.TYPE.NORMAL

end

--[[ 替换语言包自动生成，请勿修改！
]]
