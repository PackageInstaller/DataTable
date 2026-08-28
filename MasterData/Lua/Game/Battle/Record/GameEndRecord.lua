--
-- Author:luqucheng
-- Date: 2019-12-11 19:30:46
--
local GameEndRecord = Class("GameEndRecord")
function  GameEndRecord:__init(isWin, skipServerValidation)
    self.isWin = isWin
    self.turn = BattleMgr.totalTurnCount
    self.skipServerValidation = skipServerValidation or 0
    local all = BattleMgr:GetRolesWithoutSpecialSummon(BattleInfo.myCamp)
    local alives = BattleMgr:GetAliveRolesWithoutSpecialSummon(BattleInfo.myCamp)
    self.oppoAliveCount = #BattleMgr:GetAliveRoles(BattleInfo.otherCamp)

    --记录当前所有角色信息
    local nowWave = BattleMgr.nowWave
    local nowSelfWave = BattleMgr.nowSelfWave
    local rInfos = {}
    for i,v in ipairs(BattleMgr.roles) do
        rInfos[v.id] = {
            id = v.id,
            nowHp = v:GetNowHp(),
            nowSp = v:GetUltraPoint()
        }
    end

  

    local initData = BattleMgr.initData
    local healths = {}
    local energys = {}

    local rs = BattleMgr:GetAliveRoles()
    for i,v in ipairs(rs) do
        table.insert(healths, table.concat( {v.moudleId, "=", v:GetNowHp()}))
        table.insert(healths, "&")
        table.insert(energys, table.concat( {v.moudleId, "=", v:GetUltraPoint()}))
        table.insert(energys, "&")
    end

    -- for p, wave in ipairs(initData.playerTeam) do
    --     for i,v in ipairs(wave) do
    --         if p < nowSelfWave then--当前波次前的都死了
    --             table.insert(healths, table.concat( {v.id, "=", 0}))
    --             table.insert(healths, "&")
    --             table.insert(energys, table.concat( {v.id, "=", 0}))
    --             table.insert(energys, "&")
    --         else
    --             local info = rInfos[v.id]
    --             if info then
    --                 table.insert(healths, table.concat( {v.id, "=", info.nowHp}))
    --                 table.insert(healths, "&")
    --                 table.insert(energys, table.concat( {v.id, "=", info.nowSp}))
    --                 table.insert(energys, "&")
    --             end
    --         end
    --     end
    -- end

    -- for p,wave in ipairs(initData.enemyTeam) do
    --     for i,v in ipairs(wave) do
    --         if p < nowWave then--当前波次前的怪都死了
    --             table.insert(healths, table.concat( {v.id, "=", 0}))
    --             table.insert(healths, "&")
    --             table.insert(energys, table.concat( {v.id, "=", 0}))
    --             table.insert(energys, "&")
    --         else
    --             local info = rInfos[v.id]
    --             if info then
    --                 table.insert(healths, table.concat( {v.id, "=", info.nowHp}))
    --                 table.insert(healths, "&")
    --                 table.insert(energys, table.concat( {v.id, "=", info.nowSp}))
    --                 table.insert(energys, "&")
    --             end
    --         end
    --     end
    -- end
    --去除最后个&符号
    table.remove(healths, #healths)
    table.remove(energys, #energys)

    self.healthData = table.concat(healths)
    self.energyData = table.concat(energys)

    -- print("healthData:"..(self.healthData))
    -- print("energyData:"..(self.energyData))

    self.deadCount = #all - #alives

    self.totalGiveDamage = BattleMgr.selfTotalDamage
    self.totalUsedCard = {}
    self.totalUnitedCard = {}
    self.totalUsedSp = 0
    BattleMgr:CallPlayersFunc(Constants.Camp.One, function (player)
        self.totalUsedCard = table.link(self.totalUsedCard, player.cardMgr.totalUsedCard)
        self.totalUnitedCard = table.link(self.totalUnitedCard, player.cardMgr.totalUnitedCard) 
        self.totalUsedSp = player.cardMgr.totalUsedSp + self.totalUsedSp
    end)

    -- 战斗统计
    local statistics = BattleMgr.statistics
    BattleMgr:CallPlayersFunc(nil, function (player)
        if player.cardMgr then
            local stt = player.cardMgr.statistics
            for roleId, data in pairs(stt) do
                statistics[roleId] = statistics[roleId] or {}
                statistics[roleId].useCard = data.useCard
            end
        end
    end)
    local stt = {}
    for roleId, data in pairs(statistics) do
        stt = table.link(stt, {roleId, "=", data.damage or "", "=", data.cure or "", "=", data.bear or "", "=", data.useCard or "", "&"})
    end
    table.remove(stt, #stt)
    self.statistics = table.concat(stt)
    print("[战斗统计数据]", self.statistics, table.dump(statistics, nil, 3))

    self.starConditions = {
        conditions = {},
        context = ConditionMgr.context,
        totalQuestCount = ConditionMgr.totalQuestCount,
    }
    for i,v in ipairs(ConditionMgr.threeStarConditions) do
        local con = {
            conditionId = v.starConditionId,
            conditionNum = v.targetNum,
            rounds = v.limitRound,
            num = v.num,
            isSucceed = v.isSucceed,
            isComplete = v.isComplete,
        }
        table.insert(self.starConditions.conditions, con)
    end

    -- 战斗结束时是否开启着自动战斗
    self.isAuto = -1
    if isNotNull(UIBattleSettingMgr) and isNotNull(UIBattleSettingMgr.isAutoBattle) then
        self.isAuto = UIBattleSettingMgr.isAutoBattle and 1 or 0
    end
end

function GameEndRecord:ToData()
    return {
        r = Constants.RecordType.GameOver,--战报类型
        w = self.isWin,
        t = self.turn,--总回合数
        dc = self.deadCount,--我方死亡人数
        oac = self.oppoAliveCount,   -- 对方剩余人数
        healthData = self.healthData,--剩余信息
        energyData = self.energyData,--剩余信息
        totalGiveDamage = self.totalGiveDamage,
        totalUsedCard = self.totalUsedCard,
        totalUnitedCard = self.totalUnitedCard,
        totalUsedSp = self.totalUsedSp,
        recordData = self.recordData,
        starConditions = self.starConditions,
        ssv = self.skipServerValidation,
        isA = self.isAuto,  -- 战斗结束时是否开启着自动战斗
        stt = self.statistics,   -- 战斗统计
    }
end
return  GameEndRecord