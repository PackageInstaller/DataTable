--
-- Author:luqucheng
-- Date: 2019-10-18 17:10:09
--

local Skill = import('Game.Battle.Core.Skill')
local Role = import('Game.Battle.Entity.Role')
local Trigger = import('Game.Battle.Core.Trigger')
local Tree = import('Game.Utils.Tree')
local TreeNode = import('Game.Utils.TreeNode')
local ComboTargetSelect = import('Game.Battle.Script.ComboTargetSelect')
-- local SkillRecord = import('Game.Battle.Record.SkillRecord')
-- local SkillEffectRecord = import('Game.Battle.Record.SkillEffectRecord')
-- local DamageRecord = import('Game.Battle.Record.DamageRecord')
---@class BattleMgr
local BattleMgr = {}

BattleMgr.totalActionS = 0--速度调最大值
--@RefType[Game.Battle.Entity.Role#Role<>]
BattleMgr.roles = nil--本场战斗所有角色
BattleMgr.enemyRoles = nil--本场战斗所有敌方角色
BattleMgr.myRoles = nil--本场战斗所有我方角色
BattleMgr.selectRoleID = -1--玩家标记的目标id
BattleMgr.turnCount = nil--当前波次回合数
BattleMgr.totalTurnCount = nil--总回合数
BattleMgr.nowWave = 0--当前波次
BattleMgr.nowSelfWave = 0 --当前我方波次
--@RefType [Game.Battle.Entity.Controller#Controller<>]
BattleMgr.players = nil
BattleMgr.initData = nil
BattleMgr.maxTurn = nil

BattleMgr.selfTotalDamage = nil
BattleMgr.statistics = nil       -- 统计信息

BattleMgr.isInSkill = false --当前逻辑是否在技能中

BattleMgr.trigSkillCardTree = nil
BattleMgr.nowTrigSkillCardNode = nil
BattleMgr.triggerRecordTree = nil

BattleMgr.skillStack = nil --技能记录堆栈，用于存储技能的context
BattleMgr.DOTStack = nil    -- DOT记录堆栈

BattleMgr.skillCardQueue = nil --待出的技能牌序列

BattleMgr.inputSkills = nil
BattleMgr.playerInputInfo = nil

BattleMgr.agent = nil
BattleMgr.unitSkillId = nil--合卡技ID
BattleMgr.skillCats = nil     -- 猫球角色数组

BattleMgr.buffTriggerSpanNum = 0
BattleMgr.buffTrigSpans = {
    [0] = "",
    [1] = "        ",
    [2] = "                ",
    [3] = "                        ",
    [4] = "                                ",
    [5] = "                                        ",
    [6] = "                                                ",
    [7] = "                                                        ",
    [8] = "                                                                ",
    [9] = "                                                                         ",
}

------------------------------行动相关------------------------------------
BattleMgr._actionQueue = {}--行动条排序队列

------------------------------技能暂存------------------------------------
-------------------------------------------------------------------------


function BattleMgr:Init( initData )
    -- table.insert(initData.playerTeam,initData.playerTeam[1])
    BattleConfig = import("Game.Battle.Core.BattleConfig")
    ---@type Core
    Core = import('Game.Battle.Core.Core')
    ---@type RecordMgr
    RecordMgr = import('Game.Battle.Record.RecordMgr')
    AI = import('Game.Battle.AI.AI')
    ConditionMgr = import('Game.Battle.Core.ConditionMgr').New(initData)
    local Effect = import('Game.Battle.Core.Effect')
    local DelayEffect = import('Game.Battle.Core.DelayEffect')
    local t = import("Game.Battle.BehaivorRuntime.LoadNodes")

    table.merge(self, Effect)
    table.merge(self, DelayEffect)
    self.roles = {}
    self.enemyRoles = {}
    self.enemyRoles = {}
    self.selectRoleID = -1
    self.nowWave = 0
    self.nowSelfWave = 0

    self.totalTurnCount = 0
    self.turnCount = 0
    self.levelId = tonumber(initData.questId)

    self.initData = initData
    self.selfTotalDamage = 0
    self.statistics = {}
    self.maxTurn = initData.rounds or 99

    self.summonIndex = 100

    self.skillStack = {}
    self.skillCardQueue = {}
    self.DOTStack = {}
    self.delayBuffEffects = {}  -- 延时生效的buff效果，比如buff效果生效时先记录一个什么数据，然后延迟到下回合开始时才真正触发效果

    self.players = {}

    self.isInSkill = false
    --初始化行为树
    -- CS.CustomBehavior.BehaviorManager.InitBehavic()

    local role = Role.New()
    Core:Init( initData )
    self.agent = role
    role:AgentInit(initData.myPartyCat.id or 5000, Constants.Camp.One)

    if BattleInfo.playMode ~= Constants.PlayMode.Replay then
        if BattleInfo.gameMode == Constants.GameMode.PVE
        or BattleInfo.playMode == Constants.InputMode.ReplayNoLag
        or BattleInfo.inputMode == Constants.InputMode.AutoNoLag then
            for i,v in ipairs(BattleInfo.campOnePlayerIds) do
                local p = import('Game.Battle.Entity.Player').New(Constants.Camp.One, BattleInfo.campOnePlayerIds[i], initData)
                p:SetForceCardQueue(initData.playerTeam[1], initData.skillQueue, initData.skillQueueLoop)
                table.insert(self.players, p)
                if BattleInfo.inputMode == Constants.InputMode.AutoNoLag then
                    p:SetHosting(true)
                end
            end

            for i,v in ipairs(BattleInfo.campTwoPlayerIds) do
                if BattleInfo.gameRule.enemyAIType == Constants.AIType.SkillCardMgr then
                    local enemyPlayer = import('Game.Battle.Entity.PVECardAIPlayer').New(Constants.Camp.Two, BattleInfo.campTwoPlayerIds[i], initData)
                    table.insert(self.players, enemyPlayer)
                else
                    local enemyPlayer = import('Game.Battle.Entity.PVEAIPlayer').New(Constants.Camp.Two, BattleInfo.campTwoPlayerIds[i], initData)
                    table.insert(self.players, enemyPlayer)
                end
            end
            RecordMgr:Clear()
            -- RecordMgr:AddRecord(RecordMgr.InitRecord.New(initData))
        else
            if BattleInfo.gameMode == Constants.GameMode.OnlinePVE then
                for i,v in ipairs(BattleInfo.campOnePlayerIds) do
                    local p = import('Game.Battle.Entity.OnlinePlayer').New(Constants.Camp.One, BattleInfo.campOnePlayerIds[i], initData)
                    table.insert(self.players, p)
                end
            
                local enemyPlayer = import('Game.Battle.Entity.PVEAIPlayer').New(Constants.Camp.Two, BattleInfo.campTwoPlayerIds[1], initData)
                table.insert(self.players, enemyPlayer)
            elseif BattleInfo.gameMode == Constants.GameMode.PVP then
                local p1 = import('Game.Battle.Entity.PVPPlayer').New(Constants.Camp.One, BattleInfo.campOnePlayerIds[1], initData)
                table.insert(self.players, p1)
                local p2 = import('Game.Battle.Entity.PVPPlayer').New(Constants.Camp.Two, BattleInfo.campTwoPlayerIds[1], initData)
                table.insert(self.players, p2)
            end
            RecordMgr:Clear()
        end
        self:TestInit(initData)
    end
end

function BattleMgr:Clear(  )
    if not isNull(RecordMgr) then
        RecordMgr:Clear()
    end
    if not IsNull(self.players) then
        for i,player in ipairs(self.players) do
            player:Delete()
        end
    end
    self.players = nil
    self.roles = nil
    self.skillCats = nil
    if not isNull(Core) then
        Core:Clear()
    end
    Core = nil
    AI = nil
    ConditionMgr = nil
end

function BattleMgr:InitBattle()
    -- body
    self.totalActionS = self:CalcTotalActionS(self.roles)
    self._actionQueue = {}--清空队列
    self:Test()
end

function BattleMgr:TestInit( initData )
    self.roles = {}
    ConditionMgr:CheckConditions(Constants.BattleConditionJudgeTime.BattleStart)
    self:NextWave(Constants.Camp.One)
    self:NextWave(Constants.Camp.Two)
    self:CreateSkillCat(initData)
    self:MonsterWaveSkill()
    RecordMgr:AddRecordData({r = Constants.RecordType.RoleEnter})
end

--- 猫球入场
function BattleMgr:CreateSkillCat(initData)
    -- 给主被动猫球创建角色对象
    self.skillCats = {}
    if initData.playerCatTeam and initData.playerCatTeam[1] and table.count(initData.playerCatTeam[1]) > 0 then
        for i, catData in ipairs(initData.playerCatTeam[1]) do
            local catRole = Role.New()
            catRole:CatInit(catData, Constants.Camp.One)
            table.insert(self.skillCats, catRole)
            RecordMgr:AddRecord(RecordMgr.CreateSkillCatRecord.New(catData, Constants.Camp.One))
        end
    end
    if initData.enemyCatTeam and initData.enemyCatTeam[1] and table.count(initData.enemyCatTeam[1]) > 0 then
        for i, catData in ipairs(initData.enemyCatTeam[1]) do
            local catRole = Role.New()
            catRole:CatInit(catData, Constants.Camp.Two)
            table.insert(self.skillCats, catRole)
            RecordMgr:AddRecord(RecordMgr.CreateSkillCatRecord.New(catData, Constants.Camp.Two))
        end
    end
    if self:HasSkillCat() then
        for i, roleCat in ipairs(self.skillCats) do
            roleCat:OnEnter() -- 入场上被动buff
        end
    end
end

function BattleMgr:HasSkillCat()
    return isNotNull(self.skillCats) and table.count(self.skillCats) > 0
end

function BattleMgr:NextWave(camp)
    local initData = self.initData
    --加入这个波次的角色
    local wave = {}
    local roleType = Constants.RoleType.Hero
    if camp ~= Constants.Camp.One and BattleInfo:IsPVE() then
        roleType = Constants.RoleType.Monster
    end

    if camp == Constants.Camp.Two then
        self.nowWave = self.nowWave + 1
        self.turnCount = 0
        wave = initData.enemyTeam[self.nowWave]

        if BattleInfo:IsPVE() then
            ConditionMgr:OnChangeWave()
        end
    else
        self.nowSelfWave  = self.nowSelfWave + 1
        wave = initData.playerTeam[self.nowSelfWave]
        --合卡技重新设置
        self:SetUnitSkill(initData.mergeSkillId and initData.mergeSkillId[self.nowSelfWave] or nil)
    end
    
    local waveNum = camp == Constants.Camp.Two and self.nowWave or self.nowSelfWave
    --移除当前角色内的敌方单位
    if waveNum > 1 then--第一波直接清除会对Npc产生问题
        for i,role in fipairs(self.roles) do
            if role.camp == camp then
                self:RemoveRole(role)
            end
        end
    end
   

    if not wave or #wave <= 0 then
        --如果这一波所有角色都死了，就直接进行下一波
        return self:GameOver(camp == self:GetOppoCamp(BattleInfo.myCamp))
    end

    local recs = {}
    local myNum = #self.roles
    
    local start = 0
    local maxNum = #wave
    if BattleInfo:IsPVE() then
        maxNum = math.max(self:GetWaveMaxNum(), #wave) 
        local originWaveNum = initData.enemyTeam.waveOriginNums[self.nowWave] or #wave
        start = math.floor((maxNum - originWaveNum) / 2)
    end

    for i,v in ipairs(wave) do
        --判定血量
        local pos = camp == Constants.Camp.One and i or (v.pos + start)
        local role = Role.New()
        table.insert( self.roles, role )
        role:InitWithData(v, camp, pos, roleType)

        --role:OnEnter()
        table.insert(recs, RecordMgr.CreateRoleRecord.New(role))
    end

  

    if BattleInfo:IsPVE() then
        --boss优先发送
        table.inPlaceBubbleSort(recs, function ( rec1, rec2 )
            return rec1.monsterClass > rec2.monsterClass
        end)
    end
    if camp == Constants.Camp.Two then
        RecordMgr:AddRecord(RecordMgr.ChangeWaveRecord.New(self.nowWave, wave, camp, maxNum))
    else
        RecordMgr:AddRecord(RecordMgr.ChangeWaveRecord.New(self.nowSelfWave, wave, camp, #wave))
    end
    RecordMgr:AddRecords(recs)
    if camp == Constants.Camp.Two then
        RecordMgr:AddRecord(RecordMgr.ChangeWaveEndRecord.New(self.nowWave, camp, maxNum))
    else
        RecordMgr:AddRecord(RecordMgr.ChangeWaveEndRecord.New(self.nowSelfWave, camp, #wave))
    end
    for i,role in ipairs(self.roles) do
        if role.camp == camp then
            role:OnEnter()
        end
    end

    --关卡npc
    if camp == Constants.Camp.Two and initData.specialTeam and initData.specialTeam[self.nowWave] and initData.specialTeam[self.nowWave][1] then
        local npcData = initData.specialTeam[self.nowWave][1]
        --如果有存在
        self:SpecialSummon(Constants.Camp.One, npcData)
    end
end


function BattleMgr:MonsterWaveSkill(  )
    if not BattleInfo:IsPVE() then
        return
    end
    local initData = self.initData
    --怪物会有波次被动技能释放
    if initData.battleSkill and initData.battleSkill[self.nowWave] then
        local wavePassiveSkills = initData.battleSkill[self.nowWave]
        for i,skillId in ipairs(wavePassiveSkills) do
            self:AgentUseSkill(0, skillId, 1)
        end
    end
end
--desc:
--Author:luqucheng
--date:2019-10-18 17:10:09
function  BattleMgr:Test()
    -- Core:ElementCounteTest()
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- self:HandleActionValue(self.roles)
    -- local targets = self:SelectTargets(self.roles[1], self.roles[#self.roles], 101)
    -- -- printInfo(table.toString(targets, 'targets'))
    -- local t = "targets:"
    -- for i,v in ipairs(targets) do
    --     t = t..v.id..','
    -- end
    -- printInfo(t)

    -- local ls = Tools.splitToNum('122,234,223;223,999,823;',';',',')
    -- printInfo(table.toString(ls, 'ls'))


    -- self:ActionStart(self.roles[1], self.roles[#self.roles], self.roles[1].skills[1])
    -- for i,v in ipairs(self.roles) do
    --     printInfo(v.id .. '  ' ..v:GetNowHp())
    --     -- printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Defense))
    -- end

    -- self:ActionStart(self.roles[1], self.roles[#self.roles], self.roles[1].skills[1])
    -- for i,v in ipairs(self.roles) do
    --     printInfo(v.id .. '  ' ..v:GetNowHp())
    --     -- printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Defense))
    -- end


    -- self:ActionStart( self.roles[#self.roles], self.roles[1],  self.roles[#self.roles].skills[1])
    -- for i,v in ipairs(self.roles) do
    --     printInfo(v.id .. '  ' ..v:GetNowHp())
    --     -- printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Defense))
    -- end
    -- self:ActionStart( self.roles[#self.roles], self.roles[1],  self.roles[#self.roles].skills[1])
    -- for i,v in ipairs(self.roles) do
    --     printInfo(v.id .. '  ' ..v:GetNowHp())
    --     -- printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Defense))
    -- end
    -- self:ActionStart( self.roles[#self.roles], self.roles[1],  self.roles[#self.roles].skills[1])
    -- for i,v in ipairs(self.roles) do
    --     printInfo(v.id .. '  ' ..v:GetNowHp())
    --     -- printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Defense))
    -- end
    -- self:ActionStart( self.roles[#self.roles], self.roles[1],  self.roles[#self.roles].skills[1])
    
   
    
    -- print("param", Core:GetBattleParamNum("evadeReducedDamage"))
    -- printInfo(table.toString(RecordMgr:GetData(), 'RecordMgr'))
    for i,v in ipairs(self.roles) do
        printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Speed))
        -- printInfo(v.id .. '  ' ..v:GetAttr(Constants.AttrTypeId.Defense))
    end
    self:GameStart()
    --CS.UnityEngine.Profiling.Profiler.BeginSample("CalcNakedCardStrength")
    --self.strength = InvestigateResultDojo.CalcNakedCardStrength(dojo)
    --CS.UnityEngine.Profiling.Profiler.EndSample()
    -- printInfo(table.toString(RecordMgr:GetData(), 'RecordMgr'))
    
    -- self:ActionStart(self.roles[1], self.roles[#self.roles], self.roles[1].skills[1])
    -- for i,v in ipairs(self.roles) do
    --     printInfo(v.id .. '  ' ..v:GetNowHp())
    -- end
end



--所有角色
--关卡信息
--行动槽总长度
function BattleMgr:CalcTotalActionS(roles)
    -- body
    -- local as = 0
    -- local spdType = Constants.AttrTypeId.Speed
    -- for i,role in ipairs(roles) do
    --     as = as + role:GetAttr(spdType)
    -- end
    -- return as
    return Constants.BattleMaxActionS
end

--@return [Game.Battle.Entity.Controller#Controller]
function BattleMgr:GetPlayer( playerId )
    for i,v in ipairs(self.players) do
        if v.playerId == playerId then
            return v
        end
    end
end

function BattleMgr:GameStart(  )
    -- CS.UnityEngine.Profiling.Profiler.BeginSample("GameStart")
    --两边补牌
    self:CallPlayersFunc(nil, function (player)
        player:OnGameStart()
    end)

    --添加我方玩家初始化的buff
    local data = self.initData.playerTeamSkill
    --  print("playerTeamSkill:",data)
    if not Tools.isNullKey(data) then
        local l = string.slice(data, '&')
        for i,v in ipairs(l) do
            local d = string.slice(v, '=')
            --  print("playerTeamSkill:", d[1], d[2])
            self.agent.buffMgr:AddBuff(self.agent, Core:GetBuffData(d[1], tonumber(d[2]), 1))
        end
    end
    
    self:TrigAll(Constants.TriggerMainType.GameStart)
    
    if not BattleInfo:IsOnline() and not self.skipRoundStart then
        self:RoundStart()
    end
    -- CS.UnityEngine.Profiling.Profiler.EndSample()
end

function BattleMgr:RoundStart(  )
    self.turnCount = self.turnCount + 1
    self.totalTurnCount  = self.totalTurnCount + 1
    if BattleInfo:IsPVE() then
        ConditionMgr:OnRoundStart()
    end
    
    local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
    if isGameEnd then
        self:GameOver(winCamp)
        return
    end
    if isWaveEnd then
        self:WaveOver(winCamp)
    end

    self:TrigDelayBuffEffectInfo(Constants.TriggerMainType.BeforeRoundStart)

    self:TrigAll(Constants.TriggerMainType.BeforeRoundStart)

    self:TurnStart(Constants.Camp.One)
    self:TurnStart(Constants.Camp.Two)
    if BattleMgr.BATTLE_BUFF_SHOW_LOG then
        print("[Buff] ----------------回合"..tostring(self.turnCount))
    end

    --总回合开始触发器
    self:TrigAll(Constants.TriggerMainType.RoundStart)
    self:RefreshAllBuff()
    local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
    if isGameEnd then
        self:GameOver(winCamp)
        return
    end

    --同步一次数据
    RecordMgr:AddRecord(RecordMgr.SyncRoleDataRecord.New(self.roles))


    self.inputSkills = {}
    self.inputSkills[Constants.Camp.One] = {}
    self.inputSkills[Constants.Camp.Two] = {}
    self.playerInputInfo = {}

    self:CallPlayersFunc(nil, function (player)
        player:OnRequireInput(Bind(self, self.OnPlayerInputFinished), self.inputSkills[player.camp])
    end)
    self:CallPlayersFunc(nil, function (player)
        player:AfterOnRequireInput()
    end)

    if BattleInfo.inputMode == Constants.InputMode.ReplayNoLag and BattleInfo.inputs ~= nil then
        for i,oneTurnInputs in ipairs(BattleInfo.inputs) do
            if i == self.totalTurnCount then
                for j,input in ipairs(oneTurnInputs) do
                    local player = self:GetPlayer(input.playerId)
                    player:HandleInputData(input)
                    local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
                    if isGameEnd then
                        return
                    end
                end
            end
        end
    end
end

function BattleMgr:RoundEnd(  )
    --判断游戏是否已经结束
    local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
    if isGameEnd then
        self:GameOver(winCamp)
        return
    end

    self:TrigAll(Constants.TriggerMainType.BeforeRoundEnd)

    self:TurnEnd(Constants.Camp.One)
    self:TurnEnd(Constants.Camp.Two)

    --总结束开始触发器
    self:TrigAll(Constants.TriggerMainType.RoundEnd)

    ConditionMgr:RefreshCondition(Constants.BattleConditionRefreshType.Round)

    local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
    if isGameEnd then
        self:GameOver(winCamp)
        return
    end

    self:ResetTriggerRecordTree()

    if not BattleInfo:IsOnline() and not self.skipRoundStart then
        self:RoundStart()
    end
end

--回合开始流程
function BattleMgr:TurnStart(camp)
    --找到这个回合属于的阵营
    local rs = Core:GetFriendRoles(camp)
    
    --回合开始触发
    RecordMgr:AddRecord(RecordMgr.TurnStartRecord.New(camp))

    for i,role in ipairs(rs) do
        --buff减一
        role.buffMgr:TurnStart()
        --技能cd减一
        role:TurnAllSkillCD()
    end
    
    self:TrigCamp(camp, Constants.TriggerMainType.TurnStart, {camp = camp}, nil)

    self:CallPlayersFunc(nil, function (player)
        player:OnTurnStart(camp)
    end)
    --回合开始触发

   
end

--回合结算流程
function BattleMgr:TurnEnd(camp)
    --回合结束触发
    local rs = self:GetAliveRoles()
    
    --回合开始触发
    self:HandleRoleBuff(rs, function ( role )
        role.buffMgr:TurnEnd(camp)
    end)
    self:CallPlayersFunc(nil, function (player)
        player:OnTurnEnd(camp)
    end)

    self.agent.buffMgr:AddUseTag()
    self.agent.buffMgr:TurnEnd(self.camp)
    self.agent.buffMgr:RemoveUseTag()
    -- 触发猫球buff
    if self:HasSkillCat() then
        for i, v in ipairs(self.skillCats) do
            if v.camp == camp then
                v.buffMgr:AddUseTag()
                v.buffMgr:TurnEnd(self.camp)
                v.buffMgr:RemoveUseTag()
            end
        end
    end
    
    --判断角色有没有死亡
    
    --攻击角色未死亡
    --是否有追加回合行动
    --回合结束
    self:TrigCamp(camp, Constants.TriggerMainType.TurnEnd, {camp = camp}, nil)
    -- RecordMgr:AddRecordEnd()
    RecordMgr:AddRecord(RecordMgr.TurnEndRecord.New(camp))
end

function BattleMgr:OnPlayerInputFinished(player, unitCount)
    local info = {unitCount = unitCount}
    self.playerInputInfo[player.playerId] = info

    local allInputFinished = true
    local uc = 0
    self:CallPlayersFunc(nil, function (p)
        if self.playerInputInfo[p.playerId] then
            if p.camp == Constants.Camp.One then
                uc = uc + unitCount
            end
        else
            allInputFinished = false
        end
    end)

    if allInputFinished then
        self:UnitSkill(uc)
        local skills = self:SkillFillIn(self.inputSkills[Constants.Camp.One], self.inputSkills[Constants.Camp.Two])
        RecordMgr:AddRecord(RecordMgr.InputFinishedRecord.New(BattleMgr.totalTurnCount))
        self:OnActionInput(skills)
    end
end

--嵌入技能卡槽
function BattleMgr:SkillFillIn(fs, es)
    -- local skillSlots = nil
    -- if BattleInfo.gameMode == Constants.GameMode.PVE then
    --     skillSlots = {Camp.Friend, Camp.Friend, Camp.Friend, Camp.Friend, Camp.Enemy, Camp.Enemy, Camp.Enemy, Camp.Enemy, Camp.Enemy, Camp.Enemy, Camp.Enemy}
    -- else
    --     skillSlots = {Camp.Friend, Camp.Enemy, Camp.Friend, Camp.Enemy, Camp.Friend, Camp.Enemy, Camp.Friend, Camp.Enemy, Camp.Friend, Camp.Enemy}
    -- end

    -- local skills = {}
    -- local fIndex = 1
    -- local eIndex = 1

    -- for i,v in ipairs(skillSlots) do
    --     if skillSlots[i] == Camp.Friend and fs[fIndex] and not self:IsSpecialSummonRole(fs[fIndex].roleId) then
    --         table.insert(skills, fs[fIndex])
    --         fIndex  = fIndex + 1
    --     elseif skillSlots[i] == Camp.Enemy and es[eIndex] and not self:IsSpecialSummonRole(es[eIndex].roleId) then
    --         table.insert(skills, es[eIndex])
    --         eIndex  = eIndex + 1
    --     end
    -- end

    -- --槽位不够，直接补足剩余的
    -- if fIndex <= #fs then
    --     for j=fIndex, #fs do
    --         table.insert(skills, fs[j])
    --     end
    -- end
    -- if eIndex <= #es then
    --     for j=eIndex, #es do
    --         table.insert(skills, es[j])
    --     end
    -- end

    local isFirst = BattleInfo.isFirstCamp
    if BattleInfo.firstCampNoBoss == 1
        and BattleInfo.gameMode == Constants.GameMode.PVE 
        and BattleInfo.gameRule.campPriority == 3
        and (not self:IsBossWave()) then
        isFirst = true
    end

    local skills = {}
    -- local isFirst = BattleInfo.isFirstCamp
    local firstS = isFirst and fs or es
    local nextS = isFirst and es or fs
    if BattleInfo.gameRule.skillCardSlotType == Constants.SkillCardSlotType.Camp then
        for i,v in ipairs(firstS) do
            if v and not self:IsSpecialSummonRole(v.roleId) then
                table.insert(skills, v)
            end
        end
        for i,v in ipairs(nextS) do
            if v and not self:IsSpecialSummonRole(v.roleId) then
                table.insert(skills, v)
            end
        end
    else
        local fIndex = 0
        local nIndex = 0
        while fIndex + nIndex < #firstS + #nextS do
            if fIndex < #firstS then
                fIndex = fIndex + 1
                if not self:IsSpecialSummonRole(firstS[fIndex].roleId) then
                    table.insert(skills, firstS[fIndex])
                end
            end

            if nIndex < #nextS then
                nIndex = nIndex + 1
                if not self:IsSpecialSummonRole(nextS[nIndex].roleId) then
                    table.insert(skills, nextS[nIndex])
                end
            end
        end
    end

    for i,v in ipairs(firstS) do
        if self:IsSpecialSummonRole(v.roleId) then
            table.insert(skills, v)
        end
    end
    for i,v in ipairs(nextS) do
        if self:IsSpecialSummonRole(v.roleId) then
            table.insert(skills, v)
        end
    end
    return skills
end

--行动输入流程(玩家输入和AI输入)
function BattleMgr:OnActionInput( skills )
    self.skillCardQueue = skills
    self:TrigAll(Constants.TriggerMainType.BeforeAction)
    --根据获得的数据来行动
    self.usedFriendSkillCardCount = 0
    self.usedEnemySkillCardCount = 0
    while #self.skillCardQueue > 0 do
        local skillCard = table.remove(self.skillCardQueue, 1)
        local role = Core:FindRole(skillCard.roleId)
        if role then
            if role.camp == Constants.Camp.One then
                self.usedFriendSkillCardCount = self.usedFriendSkillCardCount + 1
            else
                self.usedEnemySkillCardCount  = self.usedEnemySkillCardCount + 1
            end
        end
        --角色不能释放技能则直接跳过
        local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
        if role and not isGameEnd then
            local skillCardId = role:GetSkillCardIdByIndex(skillCard.skillIndex)
            --判断是否有目标，且目标可以被选择
            local targetId = skillCard.targetId
            local target = Core:FindRole(skillCard.targetId)
            self:HandleSkillCard(role, target, skillCardId, skillCard.star, true, skillCard.params)
        end
    end
    self:RoundEnd()
end

function BattleMgr:GameOver( winCamp, skipServerValidation )
    printInfo('game over !!!')
    if winCamp == Constants.Camp.One and BattleInfo:IsPVE() then
        ConditionMgr:CheckConditions(Constants.BattleConditionJudgeTime.GameOver)
    end
    local rec = RecordMgr.GameEndRecord.New(BattleInfo:IsUserCamp(winCamp), skipServerValidation)
    local recNode = RecordMgr:AddGameEndRecord(rec)
    if BattleInfo.inputMode ~= Constants.InputMode.AutoNoLag
    and BattleInfo.inputMode ~= Constants.InputMode.ReplayNoLag then
        -- 服务器模拟跑的时候不需要这个recordData，跳过
        rec.recordData = RecordMgr:GetRecordString()
    end
    RecordMgr:ResetNodeData(recNode, rec:ToData())
end

function BattleMgr:WaveOver(winCamp)
    if winCamp == Constants.Camp.One and self.nowWave < #self.initData.enemyTeam then
        --下一波
        self:NextWave(Constants.Camp.Two)
        self:MonsterWaveSkill()
       --  self:RoundEnd()
        -- self:RoundStart()
   elseif winCamp == Constants.Camp.Two and self.nowSelfWave < #self.initData.playerTeam then
       --我方波次切换
       --清空牌库
       self:CallPlayersFunc(Constants.Camp.One, function (player)
            local cardMgr = player:GetCardMgr()
            if cardMgr then
                local recs = cardMgr:RemoveAllCards()
                RecordMgr:AddRecords(recs)
            end
       end)
       self:NextWave(Constants.Camp.One)
       -- self:RoundEnd()
    --    self:RoundStart()
   end
   RecordMgr:AddRecordData({r = Constants.RecordType.RoleEnter})
end

function BattleMgr:GetOppoCamp( camp )
    if camp == Constants.Camp.One then
        return Constants.Camp.Two
    end

    if camp == Constants.Camp.Two then
        return Constants.Camp.One
    end
end
--[[
    @desc: 
    author:luqucheng
    time:2023-01-03 11:26:37
    @return:波次是否结束，战斗是否结束，是否胜利
]]
function BattleMgr:IsGameOver()
    local isWaveEnd, winCamp = ConditionMgr:CheckWaveOver()

    local lastWave = self.nowWave >= #self.initData.enemyTeam

    local isGameEnd = isWaveEnd and (winCamp == Constants.Camp.Two or lastWave)
    -- print("isGameEnd", isGameEnd)
    if isWaveEnd then
        return isWaveEnd, isGameEnd, winCamp
    end
    --判断游戏是否还能继续进行
    local isEnemyAllDead = BattleMgr:IsCampAllDead(Constants.Camp.Two)
    local isSelfAllDead = BattleMgr:IsCampAllDead(Constants.Camp.One)
    local isTurnOver = self.totalTurnCount > self.maxTurn

    --不能继续并且没有满足成功条件，则算失败
    if isEnemyAllDead or isSelfAllDead or isTurnOver then
        -- PVP
        if BattleInfo:IsPVP() then
            if not isSelfAllDead and not isTurnOver then
                return true, true, Constants.Camp.One
            end
        end

        local questId = tonumber(self.initData.questId)
        if questId >= 12171101 and questId <= 12176999 then
            -- 夜间巡逻算玩家胜利
            return true, true, Constants.Camp.One
        else
            -- 其他模式算玩家失败
            return true, true, Constants.Camp.Two
        end
    end

    return false
end

function BattleMgr:IsWaveOver()

end

function BattleMgr:IsCampAllDead( camp )
    local rs = self:GetAliveRolesWithoutSpecialSummon(camp)
    for i,v in ipairs(rs) do
        if not v:IsDead() then
            return false
        end
    end
    return true
end

function BattleMgr:IsCampAllBossDead( camp )
    local rs = self:GetAliveRolesWithoutSpecialSummon(camp)
    for i,v in ipairs(rs) do
        if not v:IsDead() and v:IsBoss() then
            return false
        end
    end
    return true
end

function BattleMgr:NeedInputAction(  )
    return true
end

--行动条计算流程
function BattleMgr:HandleActionValue(roles)
    --根据每个角色当前速度增加行动值，如果有某一个角色行动值到满，则表示回合开始
    --此时，如果存在某些角色的行动值相同，则要让其错开
    --套圈机制，如果一个角色再敌方行动之前连续行动超过3次，则需特殊处理
    local role = Core:HandleAction(roles, self._actionQueue, self.totalActionS)
    RecordMgr:AddRecord(RecordMgr.ActionRecord.New(self.roles))
    return role
end

function BattleMgr:SelectTargets( attacker, mainTarget, targetType )
    return Core:SelectTargets(targetType, attacker, mainTarget, self.roles)
end

--行动开始流程
--@TODO 2019-10-25 15:13:26 角色的行动应该不仅仅是技能，后面应该会添加
function BattleMgr:ActionStart(attacker, mainTarget, skill)

    local skillRec = self:HandleSkill(attacker, mainTarget, skill)
    -- local dmgEffectRec = skillRec.damageEffectRecord

    -- printInfo(table.toString(skillRec:ToData(),'skillRec'))
    --主目标是否死亡

    --如该技能有主伤害效果,且可以连击反击
    -- if dmgEffectRec and not attacker:IsDead() and not mainTarget:IsDead() then
    --     local counterRec = self:HandleCounterAttack(skillRec, dmgEffectRec)
    --     if counterRec then
    --         printInfo(table.toString(counterRec:ToData(),'counterRec'))
    --     end
    -- end


    -- if dmgEffectRec and not attacker:IsDead() and not mainTarget:IsDead() then
    --     local comboRec = self:HandleComboAttack(skillRec, dmgEffectRec)
    --     if comboRec then
    --         printInfo(table.toString(comboRec:ToData(),'comboRec'))
    --     end
    -- end
end

--[[
    @desc: 
    author:luqucheng
    time:2021-08-20 15:38:36
    --@attacker:[Game.Battle.Core.Role#Role]
	--@mainTarget:[Game.Battle.Core.Role#Role]
	--@skillCardId:
	--@star: 
    --@triggerEffectParams: 效果触发技能时附带的相关参数
    @return:
]]
function BattleMgr:HandleSkillCard(attacker, mainTarget, skillCardId, star, isInputSkill, params , triggerNode, triggerEffectParams )
    if not attacker or attacker:IsDead() then
        return
    end
    --找到卡牌对应的技能
    local skillCardData = Core:GetSkillCardData(skillCardId)

    local isWaveEnd, isGameEnd, winCamp = self:IsGameOver()
    if isGameEnd then
        self:GameOver(winCamp)
        return
    end

    if not mainTarget or not mainTarget:CanBeClicked(attacker) then
        --没有目标，则自动选择
        mainTarget = AI:ChooseSkillTarget(attacker, skillCardData)
    end
    --嘲讽的处理
    if not skillCardData.ignoreTaunt then
        mainTarget = AI:CheckTaunt(attacker, mainTarget, skillCardData, star)
    end

    if not mainTarget or not skillCardData:CanDischarge(attacker) or not attacker:CanSkill() then
        if BattleMgr.BATTLE_BUFF_SHOW_LOG then
            local attackerId = attacker.id or -1
            local scId = skillCardId or -1
            print("[Buff] ----------------技能  释放失败", string.format("角色: %04d",attackerId), string.format("牌: %d",scId))
        end
        RecordMgr:AddRecordStart(RecordMgr.SkillFailedRecord.New(attacker, skillCardId, star, isInputSkill))
        self:Trig(attacker, Constants.TriggerMainType.SkillCardDischargeFailed, {skillCard = {skillCardData = skillCardData, isInputSkill = isInputSkill}}, mainTarget)
        attacker:UseSkillAddSP(skillCardData, star, isInputSkill)--技能释放失败还是可以加sp
        RecordMgr:AddRecordEnd()
        return
    end

    if BattleMgr.BATTLE_BUFF_SHOW_LOG then
        local attackerId = attacker.id or -1
        local scId = skillCardId or -1
        print("[Buff] ----------------技能 释放成功", string.format("角色: %04d",attackerId), string.format("牌: %d",scId))
    end

    --根据条件判断是否使用复写技能
    local skillId = Core:GetOverwirteSkill(skillCardData, attacker, mainTarget, star)

    if Tools.isNullKey(skillId) then
        --找不到技能
        printError('找不到技能卡对应的技能, skillCardId:'..skillCardId .. "  star:" .. star)
        return
    end


    local skill = attacker:GetSkill(skillId, star)
    if not skill then
        return
    end

    ConditionMgr:RefreshCondition(Constants.BattleConditionRefreshType.Skill)
    skill.skillCardId = skillCardId
    self:HandleSkill(attacker, mainTarget, skill, 1, isInputSkill, params, function ()
        attacker:OnUseSkillCard(skillCardData, star, isInputSkill)
    end, function()
        attacker:UseSkillAddSP(skillCardData, star, isInputSkill)
        attacker:BeforeSkillEnd(skillCardData, star, isInputSkill)
    end , triggerNode, triggerEffectParams)
    if attacker.camp == Constants.Camp.One and BattleInfo:IsPVE() and isInputSkill then
        ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UseSomeElementCard, attacker.elementType)
        ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UseSomeTypeSkill, skillCardData.label)
        if skillCardData:IsUltra() then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UseUltraSkill)
        end
        if skillCardData.label == Constants.SkillLabel.Attack then
            local rate = Core:GetElementCounteDamage(attacker.elementType, mainTarget.elementType)
            if rate > 0 then
                ConditionMgr:UpdateConditionData(Constants.GameOverCondition.SkillElementAdvantage)
            end
        end
    end
    if attacker.camp ~= Constants.Camp.One and BattleInfo:IsPVE() and skillCardData:IsUltra() then
        ConditionMgr:UpdateConditionData(Constants.GameOverCondition.EnemyUseUltraSkill)
    end

    return true
end

--[[
    @desc: 
    author:luqucheng
    time:2019-11-26 16:34:10
    --@attacker:[Game.Battle.Core.Role#Role]
	--@mainTarget:[Game.Battle.Core.Role#Role]
	--@skill: [Game.Battle.Core.Skill#Skill]
    @return:
]]
function BattleMgr:HandleSkill( attacker, mainTarget, skill, combo, isInputSkill, params, onStart, beforeEnd, triggerNode, triggerEffectParams)
    --没有目标的技能直接跳过
    if not mainTarget then
        return
    end

    -- 清理目标角色身上记录的技能范围受击数据
    mainTarget.roleContextData:ClearSkillRangeBeAtkData()

    local isSPSkill = false
    if skill.skillType == 3 then
        isSPSkill = true
    end
    local isPassiveSkill = skill.skillClass == Constants.SkillClass.Passive
    local isRootSkill = not self.isInSkill

    if not isPassiveSkill then
        self.isInSkill = true
    end
    self:RefreshAllBuff()
    --释放技能前重置一下根基技能计算cd的触发器
    --只有非触发主动才刷新
    if not isPassiveSkill then
        local rs = self:GetAliveRoles()
        for i,v in ipairs(rs) do
            v.buffMgr:ResetCountOnSkillTrigger()
        end
    end
    
    --判断技能是否可以释放
    --释放大招需要消耗
    combo = combo or 1

    -- body
    --技能释放
    --@RefType [Game.Battle.Record.SkillRecord#SkillRecord]
    local skillRec = RecordMgr.SkillRecord.New(attacker, mainTarget, skill, isInputSkill)
    skillRec:SetSkillCardParams(params)
    self:PushSkillStack(skillRec)
    skill:Discharge(skillRec)
    local skillNode = RecordMgr:AddRecordStart(skillRec)
    RecordMgr:AddTagRecordStart(Constants.RecordType.SkillStart)
    local skillTriggerNode = nil
    if triggerNode ~= nil then
        --设置当前节点为传入的节点
        skillTriggerNode = triggerNode
        self.nowTriggerRecordNode = skillTriggerNode
    end

    if onStart then
        onStart()
    end

    -- print("HandleSkill ", skill.skillId, isRootSkill, isPassiveSkill, isInputSkill)
    

    --如有主伤害效果
    --获取生效目标
    local dmgEffectRec = nil
    local dmgRecs = {}
    local effectRec1, effectRec2, effectRec3
    local mainTargets = self:SelectTargets(skillRec.attacker, skillRec.mainTarget, skillRec.skill.damageTarget)
    skillRec.mainTargets = mainTargets

    --技能开始触发
    if not isPassiveSkill then
        self:Trig(attacker, Constants.TriggerMainType.SkillStart, {skillRec = skillRec}, mainTarget, skill.triggerRule)
        self:TrigAll(Constants.TriggerMainType.OtherSkillStart, {skillRec = skillRec}, mainTarget, {attacker}, skill.triggerRule)
        self:TrigAll(Constants.TriggerMainType.OtherSkillStart2, {skillRec = skillRec}, attacker, {attacker}, skill.triggerRule)
    end

    -- 技能开始触发之后，刷新随动buff
    self:RefreshAllBuff()

    --处理预先的几个附加效果
    for i=1,Constants.SkillPreSubEffectCount do
        local subEffect = skill.subEffects[i]
        local targets = self:HandleOtherSkillEffect( skillRec, dmgEffectRec, dmgRecs, subEffect.effectId, subEffect.effectTarget, 
            subEffect.effectCondition, subEffect.starEffect, subEffect.effectConditionPara)
        if targets and #targets > 0 then
            local effectRec, dmgRecs = self:HandleSkillEffect(
                {
                    attacker = skillRec.attacker,
                    mainTarget = skillRec.mainTarget,
                    star = skillRec.skill.star,
                    lv = skillRec.skill.lv,
                    targets = targets,
                    skillEffectID = subEffect.effectId,
                    combo = combo,
                    layNum = subEffect.stackTime,
                    effectType = subEffect.effectType,
                    isSPSkill = isSPSkill,
                    isSPSkillMainEffect = false,
                    triggerEffectParams = triggerEffectParams,
                })
            skillRec:AddEffectRec(effectRec)
            skillRec:AddDamageRecs(dmgRecs)
        end
    end
    RecordMgr:AddRecordEnd()


    if skillRec.skill.damageEffect ~= 0 then
        --处理多段脚本
        local script = ComboTargetSelect:GetScript(skillRec.skill.comboTargetSelectScript)
        local returnResult = nil
        -- print(skill.skillId)
        --处理连击效果
        --根据配置的连段来
        -- print("damageEffectType:", skillRec.skill.damageEffectType)
        for i, ratio in ipairs(skillRec.skill.hitRatio) do
            local scriptResult = script(i, skillRec, returnResult)
            local targets = scriptResult.targets
            local damageChangeRatio = scriptResult.ratio
            returnResult = scriptResult.returnParams
            table.insert(skillRec.hitTargets, targets)
            RecordMgr:AddTagRecordStart(Constants.RecordType.SkillHit)
            dmgEffectRec, dmgRecs = self:HandleSkillEffect(
            {
                attacker = attacker,
                mainTarget = mainTarget,
                star = skill.star,
                lv = skill.lv,
                targets = targets,
                skillEffectID = skillRec.skill.damageEffect,
                combo = combo,
                ratio = ratio * damageChangeRatio,
                effectType = skillRec.skill.damageEffectType,
                isSPSkill = isSPSkill,
                isSPSkillMainEffect = true,
                triggerEffectParams = triggerEffectParams,
            })

            --命中和受击触发移到这里
            if dmgRecs and not isPassiveSkill then
                local isCrit = false
                --攻击命中触发
                for i,rec in ipairs(dmgRecs) do
                    rec.hitFromType = Constants.HitFromType.SkillMainEffect
                    if rec.isCrit then
                        isCrit = true
                    end
                    --目标没有死才会触发
                    -- if rec.nowHp > 0 or rec.hpChange ~= 0 then
                        self:Trig(attacker, Constants.TriggerMainType.Attack, {damageRec = rec, skillRec = skillRec}, rec.target,  skill.triggerRule)
                    -- end
                end
                --受击触发
                for i,rec in ipairs(dmgRecs) do
                    rec.hitFromType = Constants.HitFromType.SkillMainEffect
                    -- if rec.nowHp > 0 or rec.hpChange ~= 0 then
                        self:Trig(rec.target, Constants.TriggerMainType.BeAttack, {damageRec = rec, skillRec = skillRec}, attacker,  skill.triggerRule)
                    -- end
                    
                end
                if attacker.camp == Constants.Camp.One and BattleInfo:IsPVE() and skillRec.skill.label == Constants.SkillLabel.Attack then
                    ConditionMgr:UpdateConditionData(Constants.GameOverCondition.SelfHitNum, nil, #dmgRecs)
                end
                self:TrigAll(Constants.TriggerMainType.OtherAttack, {skillRec = skillRec, isCrit = isCrit, damageRecs = dmgRecs}, mainTarget, {attacker}, skill.triggerRule)
                self:TrigAll(Constants.TriggerMainType.OtherAttack2, {skillRec = skillRec, isCrit = isCrit, damageRecs = dmgRecs}, attacker, {attacker}, skill.triggerRule)

                self:TrigAll(Constants.TriggerMainType.OtherBeAttack, {skillRec = skillRec, isCrit = isCrit, damageRecs = dmgRecs}, attacker, mainTargets, skill.triggerRule)
                self:TrigAll(Constants.TriggerMainType.OtherBeAttack2, {skillRec = skillRec, isCrit = isCrit, damageRecs = dmgRecs}, mainTarget, mainTargets, skill.triggerRule)
            end
            skillRec:AddDamageRecs(dmgRecs)
            RecordMgr:AddRecordEnd()
        end
        if dmgEffectRec then
            skillRec.mainEffect = dmgEffectRec:ToData()
            skillRec:AddEffectRec(dmgEffectRec)
        end
    end

    RecordMgr:AddTagRecordStart(Constants.RecordType.SkillEnd)

     --处理后续的几个附加效果
     for i=Constants.SkillPreSubEffectCount + 1,Constants.SkillSubEffectCount do
        local subEffect = skill.subEffects[i]
        local targets = self:HandleOtherSkillEffect( skillRec, dmgEffectRec, dmgRecs, subEffect.effectId, subEffect.effectTarget, 
            subEffect.effectCondition, subEffect.starEffect, subEffect.effectConditionPara)
        if targets and #targets > 0 then
            local effectRec, dmgRecs = self:HandleSkillEffect(
                {
                    attacker = skillRec.attacker,
                    mainTarget = skillRec.mainTarget,
                    star = skillRec.skill.star,
                    lv = skillRec.skill.lv,
                    targets = targets,
                    skillEffectID = subEffect.effectId,
                    combo = combo,
                    layNum = subEffect.stackTime,
                    effectType = subEffect.effectType,
                    isSPSkill = isSPSkill,
                    isSPSkillMainEffect = false,
                    triggerEffectParams = triggerEffectParams,
                })
            -- 子效果触发命中和受击
            if dmgRecs and not isPassiveSkill then
                local isCrit = false
                --攻击命中触发
                for i,rec in ipairs(dmgRecs) do
                    rec.hitFromType = Constants.HitFromType.SkillSubEffect
                    if rec.isCrit then
                        isCrit = true
                    end
                    --目标没有死才会触发
                    -- if rec.nowHp > 0 or rec.hpChange ~= 0 then
                        self:Trig(attacker, Constants.TriggerMainType.Attack, {damageRec = rec, skillRec = skillRec}, rec.target,  skill.triggerRule)
                    -- end
                end
                --受击触发
                for i,rec in ipairs(dmgRecs) do
                    rec.hitFromType = Constants.HitFromType.SkillSubEffect
                    -- if rec.nowHp > 0 or rec.hpChange ~= 0 then
                        self:Trig(rec.target, Constants.TriggerMainType.BeAttack, {damageRec = rec, skillRec = skillRec}, attacker,  skill.triggerRule)
                    -- end
                end
                if attacker.camp == Constants.Camp.One and BattleInfo:IsPVE() and skillRec.skill.label == Constants.SkillLabel.Attack then
                    ConditionMgr:UpdateConditionData(Constants.GameOverCondition.SelfHitNum, nil, #dmgRecs)
                end
            end
            skillRec:AddEffectRec(effectRec)
            skillRec:AddDamageRecs(dmgRecs)
        end
    end

    -- print('record', table.toString(skillRec.mainEffect, "skillRec"))

    -- --解体伤害
    -- for i,rec in ipairs(dmgRecs) do
    --     --解体再miss之后可能造成的伤害变化
    --     local pDmg = skillRec.skill.disAtkNum
    --     if not rec.isHit then
    --         pDmg = math.floor( Core:GetBattleParamNum(Constants.BattleParam.EvadePoseReduce) * pDmg ) 
    --     end
    --     rec.target:ChangeNowPose(pDmg)
    -- end
    
    if beforeEnd then
        beforeEnd()
    end

    --技能结束触发
    if not isPassiveSkill then
        self:Trig(attacker, Constants.TriggerMainType.SkillEnd, {skillRec = skillRec}, mainTarget, skill.triggerRule)
        self:TrigAll(Constants.TriggerMainType.OtherSkillEnd, {skillRec = skillRec}, mainTarget, {attacker}, skill.triggerRule)
        self:TrigAll(Constants.TriggerMainType.OtherSkillEnd2, {skillRec = skillRec}, attacker, {attacker}, skill.triggerRule)

        -- 触发吞噬卡的效果
        if params and params.swallowCard then
            local swallowCard = params.swallowCard
            local belongRoleId = swallowCard.roleId
            local belongRole = Core:FindRole(belongRoleId)
            if belongRole then
                local swallowSkillCard = belongRole:GetSkillCardDataByIndex(swallowCard.skillIndex)
                if swallowSkillCard.delayTriggerTarget > 0 then
                    local targets = Core:SelectTargets(swallowSkillCard.delayTriggerTarget, belongRole, mainTarget, self.roles)
                    if targets and #targets > 0 then
                        local effectRec, dmgRecs = self:HandleSkillEffect(
                            {
                                attacker = belongRole,
                                mainTarget = mainTarget,
                                star = swallowCard.star,
                                lv = 1,
                                targets = targets,
                                skillEffectID = swallowSkillCard.delayTriggerEffectId,
                                combo = combo,
                                effectType = swallowSkillCard.delayTriggerType,
                                isSPSkill = false,
                                isSPSkillMainEffect = false,
                            })
                        skillRec:AddEffectRec(effectRec)
                        skillRec:AddDamageRecs(dmgRecs)
                    end 
                end
            end
        end

        --只要使用了技能，就算弱点星数
        local rs = self:GetAliveRoles(self:GetOppoCamp(attacker.camp))
        local star = skill.skillType == Constants.SkillType.Final and 4 or skill.star
        if params and params.swallowCard then
            star = star + params.swallowCard.star
        end
        for i,v in ipairs(rs) do
            v.buffMgr:ElementBreak(star)
        end

        -- 释放技能过后，移除所有人身上被触发过的每技能大毅力buff
        rs = self:GetAliveRoles()
        for i, v in ipairs(rs) do
            v.buffMgr:RemoveTriggeredPerseverancePerSkill()
        end
    end
    
    RecordMgr:ResetNodeData(skillNode, skillRec:ToData())
    RecordMgr:AddRecordEnd()
    RecordMgr:AddRecordEnd()
    self:RefreshAllBuff()
    --出栈
    self:PopSkillStack()

    -- 记录角色上一次释放的技能
    -- if isInputSkill then
    --     attacker.lastSkillRec = skillRec
    -- end

    --主动技能释放触发的主动
    if not isPassiveSkill then
        self:DischargeTrigSkillCards()
    end
    -- 重置此技能的节点
    if skillTriggerNode ~= nil then
        skillTriggerNode = self.triggerRecordTree.root
        self.nowTriggerRecordNode = skillTriggerNode
    end
    --主动释放技能结束后，解除正在技能中的状态
    if self.isInSkill and isRootSkill and not isPassiveSkill then
        self.isInSkill = false
        self:ClearTrigSkills()

    end
    return skillRec
end

--专门检测技能的附加效果是否可以被加上的方法
--@skillRec: [Game.Battle.Record.SkillRecord#SkillRecord]
function BattleMgr:HandleOtherSkillEffect( skillRec, dmgEffectRec, dmgRecs, effectID, targetType, triggerID, star, conditionDatas )
    if not effectID or effectID == 0 then
        return nil
    end

    --检测附加效果对于星级的要求
    if (star & (1 << (skillRec.skill.star - 1) ) ) == 0 then
        -- print("HandleOtherSkillEffect  no")
        return nil
    end
    -- print("HandleOtherSkillEffect  yes", 1 << (skillRec.skill.star - 1), star & (1 << (skillRec.skill.star - 1) ) )
    --获取目标
    local targets = targetType == -1 and table.link({}, skillRec.mainTargets) or Core:SelectTargets(targetType, skillRec.attacker, skillRec.mainTarget, self.roles)
    
    --判断条件是否满足
    for i,target in fipairs(targets) do
        --@TODO 2019-10-31 15:47:31 需要保证targets的顺序和dmgEffectRec.damageRecords的顺序是相同的
        local trigData = dmgRecs and dmgRecs[i] or nil
        local canTrigger = Trigger.CheckTrigger(triggerID, Constants.TriggerMainType.Direct, skillRec.attacker, target, {skillRec = skillRec, damageRec = trigData}, conditionDatas )
        if not canTrigger then
            table.remove( targets,i )
        end
    end
    return targets
end

--skillRec里只需要有attacker, mainTarget, skill
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleSkillEffect( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local star = effectParams.star
    local lv = effectParams.lv
    local targets = effectParams.targets
    local skillEffectID = effectParams.skillEffectID
    local layNum = effectParams.layNum
    local combo = effectParams.combo
    local otherEffectRecs = effectParams.otherEffectRecs
    local effectType = effectParams.effectType
    local isSPSkill = effectParams.isSPSkill     -- 是否是大招的效果
    local isSPSkillMainEffect = effectParams.isSPSkillMainEffect    -- 是大招的主效果还是子效果

    if #targets <= 0 then
        return nil
    end

    local effectRec = nil
    local recs = nil
    --获得生效的表数据
    --@TODO 2019-10-24 16:30:55 效果数据可以考虑做缓存记录在技能里面
    if effectType == Constants.EffectType.SkillEffect then
        --技能效果
        local effectData = Core:GetSkillEffectData(skillEffectID, star, lv, isSPSkill, isSPSkillMainEffect)
        assert(effectData, '技能效果数据不存在:'.. skillEffectID)
        if effectData.mainEffectType == Constants.SkillEffectMainType.None then
            -- 空效果
            return nil
        end
        --效果记录
        effectRec = RecordMgr.SkillEffectRecord.New(effectData, attacker, targets)
        local effectNode = RecordMgr:AddRecordStart(effectRec)
        -- print("record...", table.toString(effectRec:ToData(), "effectRec"))
        effectParams.effectRec = effectRec
        
        local resistTargets = nil
        --检查效果抵抗
        for i,v in fipairs(targets) do
            if v.buffMgr:CheckIsResist(effectData, effectType) then
                --效果抵抗，去除目标
                table.remove(targets, i)
                if not resistTargets then
                    resistTargets = {}
                end
                table.insert(resistTargets, v)
            end
        end
        RecordMgr:ResetNodeData(effectNode, effectRec:ToData())

        --根据效果的主类型来判断应该进入那个流程
        local type = Constants.SkillEffectMainType
        local switch = {
            [type.DirectDamage] = self.HandleDirectDamage,
            [type.AddBuff] = self.HandleBuff,
            [type.AddBuffEx] = self.HandleBuffEx,
            [type.DirectHeal] = self.HandleHeal,
            [type.ActionChange] = self.HandleActionChange,
            [type.ClearBuff] = self.HandleClearBuff,
            [type.StealBuff] = self.HandleStealBuff,
            [type.SPChange] = self.HandleSpChange,
            [type.BuffDurationChange] = self.HandleChangeBuffDuration,
            [type.CopyBuff] = self.HandleCopyBuff,
            [type.CardStarChange] = self.HandleCardStarChange,
            [type.Summon] = self.HandleSummon,
            [type.HPChange] = self.HandleHPChange,
            [type.ElementChange] = self.HandleChangeElement,
            [type.CardPush] = self.HandlePushCard,
            [type.SPGive] = self.HandleSpGive,
            [type.BuffChangeLayer] = self.HandleChangeBuffLayer,
            [type.Death] = self.HandleDeath,
            [type.RemoveRole] = self.HandleRemoveRole,
            [type.SpecialSummon] = self.HandleSpecialSummon,
            [type.CardRemove] = self.HandleRemoveCard,
            [type.TriggerSkill] = self.HandleTriggerSkill,
            [type.ShieldChange] = self.HandleShieldChange,
            [type.OperateSpecialRegister] = self.HandleOperateSpecialRegister
        }
    
        local func = switch[effectData.mainEffectType]
        assert(func, '技能效果主类型没有找到：'..effectData.mainEffectType)
        recs = func(self, effectParams)

        if resistTargets then
            for i,v in ipairs(resistTargets) do
                self:Trig(v, Constants.TriggerMainType.ResistSkillEffect, nil, attacker)
            end
        end
        


        RecordMgr:AddRecordEnd()
    elseif effectType == Constants.EffectType.Buff then
        --buff
        local buffData = Core:GetBuffData(skillEffectID, star, lv)
        assert(buffData, 'buff数据不存在:'.. skillEffectID)
        --效果记录
        effectRec = RecordMgr.SkillEffectRecord.New(buffData, attacker, targets)
        -- RecordMgr:AddRecordStart(effectRec)
        local effectNode = RecordMgr:AddRecordStart(effectRec)
        -- print("record...", table.toString(effectRec:ToData(), "effectRec"))
        effectParams.effectRec = effectRec

        local resistTargets = {}
        --检查效果抵抗
        for i,v in fipairs(targets) do
            if v.buffMgr:CheckIsResist(buffData, effectType) then
                --效果抵抗，去除目标
                table.remove(targets, i)
                if not resistTargets then
                    resistTargets = {}
                end
                table.insert(resistTargets, v)
            end
        end
        RecordMgr:ResetNodeData(effectNode, effectRec:ToData())
        -- recs = self:HandleBuff(effectParams)
        local layNum = effectParams.layNum or 1
        layNum = math.max(1, layNum)--不能添加少于一层的buff
        --上buff时候的触发
        for i,v in ipairs(effectRec.targets) do
            v.buffMgr:AddBuff(attacker, effectRec.effectData, layNum, effectParams)
            v.buffMgr:AfterChangeBuff()
        end
        if resistTargets then
            for i,v in ipairs(resistTargets) do
                self:Trig(v, Constants.TriggerMainType.ResistBuff, nil, attacker)
            end
        end
        
        RecordMgr:AddRecordEnd()
    end
   

    -- RecordMgr:AddRecordEnd()
    return effectRec, recs
end

--连击流程
function BattleMgr:HandleComboAttack( skillRec, dmgEffectRec )
    --先判断技能是否可以触发连击
    if not skillRec.skill.isContinuousAttack then
        return
    end
    --根据友方所有角色来计算连击概率
    local RateID = Constants.AttrTypeId.Combo
    local rs = Core:GetFriendRoles(skillRec.attacker.camp, self.roles)
    local rate = 0
    local trueRate = 0
    local rates = {}
    for i,v in fipairs(rs) do
        --攻击者不能算入到连击率内
        if v.id ~= skillRec.attacker.id then
            local r = v:GetAttr(RateID)
            rate = rate + r
            if v:CanCombo() then
                trueRate = trueRate + r
                table.insert(rates, 1, r)
            else
                table.remove( rs, i )
            end
        end
    end

    --没有真正可以发起连击的人
    if trueRate <= 0 then
        return
    end

    --判断是否连击
    local random = Core.Random()
    if random > rate then
        return
    end

    --寻找适合连击的角色
    --连击的角色根据连击率权重随机
    local role = nil
    random = Core.Random() * trueRate
    for i,v in ipairs(rates) do
        random = random - v
        if random <= 0 then
            role = rs[i]
            break
        end
    end

    if not role then--没有可以连击的角色
        return
    end
    --开始连击
    return self:HandleSkill( role, skillRec.mainTarget, role.skill1 )
end

--反击流程
function BattleMgr:HandleCounterAttack( skillRec, dmgEffectRec )
    --先判断攻击方的技能是否可以被反击
    if not skillRec.skill.isCounterAttack then
        return
    end
    --根据被攻击命中的所有角色来计算反击率
    local RateID = Constants.AttrTypeId.CounterAttack
    local rs = dmgEffectRec.targets
    local rate = 0
    local trueRate = 0
    local rates = {}
    for i,v in fipairs(rs) do
        local r = v:GetAttr(RateID)
        rate = rate + r
        if v:CanCounter() then
            trueRate = trueRate + r
            table.insert(rates, 1, r)
        else
            table.remove( rs, i )
        end
    end
    --总反击率需要根据人数进行修正
    rate = rate * Constants.CounterFixRate[#dmgEffectRec.targets]
    --没有真正可以发起反击的人
    if trueRate <= 0 then
        return
    end

    --判断是否反击
    local random = Core.Random()
    if random > rate then
        return
    end

    --寻找适合反击的角色
    --反击的角色根据连击率权重随机
    local role = nil
    random = Core.Random() * trueRate
    for i,v in ipairs(rates) do
        random = random - v
        if random <= 0 then
            role = rs[i]
            break
        end
    end

    if not role then--没有可以反击的角色
        return
    end
    --开始连击
    return self:HandleSkill( role, skillRec.attacker, role.skill1 )

    --开始反击
end

--- 延迟效果
---@param info DelayBuffEffectInfo
function BattleMgr:HandleDelayBuffEffect(info)
    local mainType = info.mainType

    local type = Constants.SkillEffectMainType
    local switch = {
        [type.AddBuff] = self.DelayHandleBuff,
    }

    local func = switch[mainType]
    assert(func, '可以延迟执行的技能效果主类型没有找到：'..mainType)
    local recs = func(self, info)
end

--@damageTypeVo: [Game.Setting.Vo.DamageTypeVo#DamageTypeVo]
function BattleMgr:Damage( dmg, damageTypeVo, effectLv, target, attacker, star, comboRatio, dmgRec, ratioModifier )
    -- return self:MultiDamage({dmg}, {dmgType}, target, attacker, star, combo, dmgRec)
    star = star or 1
    comboRatio = comboRatio or 1
    dmgRec = dmgRec or RecordMgr.DamageRecord.New(target, attacker)
    local dmgType = damageTypeVo.damageType

    -- assert(#dmgs == #dmgTypes, "伤害数量与伤害类型数量不匹配")
    local baseDmgTotal = 0
    local finalDmgTotal = 0
    local element = dmgRec.element

    local baseDmg = dmg
    --计算税后伤害
    --计算防御，防御公式
    --计算减伤易伤
    local fd = Core:FinalDamageCalcation(attacker, target, baseDmg, damageTypeVo, dmgRec.isHit, dmgRec.isCrit, dmgRec.element, comboRatio, star)
    if BattleInfo:IsPVP() then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting4100, "PVPBuffVo")
        ---@type PVPBuffVo
        local vo = setting:Get(self.initData.pvpSettingId)
        if not isNull(vo) then
            print(string.format("PVPBuff修改前伤害:%f,修改后:%f", fd, fd * vo.globalDamage))
            fd = fd * vo.globalDamage
        end
    end
    --护盾吸收
    local finalDmg, remainShield, lostShield = target.buffMgr:ShieldAbsorb(fd, damageTypeVo, attacker)
    dmgRec.shieldAbsorb = lostShield
    -- dmgRec.nowShield = remainShield
    --伤害变更
    -- finalDmg = target.buffMgr:DamageChange(baseDmg, finalDmg, dmgType, dmgRec, attacker)
    -- if dmgType == Constants.DamageType.AntiShield then
    --     --针对护盾的伤害，计算完护盾之后就请0
    --     finalDmg = 0
    -- end

    baseDmgTotal = baseDmgTotal + baseDmg
    finalDmgTotal = finalDmgTotal + finalDmg

    finalDmgTotal = target.buffMgr:DamageChange(baseDmgTotal, finalDmgTotal, damageTypeVo, effectLv, dmgRec, attacker)
    
    if isNotNull(ratioModifier) then
        finalDmgTotal = finalDmgTotal * ratioModifier   -- 触发伤害的效果 对这次伤害的修正
        print("[伤害修正] ratioModifier ", ratioModifier)
    end

    dmgRec.damageType = damageTypeVo.id
    dmgRec.damage = baseDmgTotal
    dmgRec.finalDamage = finalDmgTotal

    local hpChange = target:ChangeNowHp(-finalDmgTotal, attacker)
    dmgRec.hpChange = -hpChange

    -- 战斗统计
    local sstDamage = math.modf(dmgRec.hpChange + dmgRec.shieldAbsorb)
    if attacker.camp == Constants.Camp.One and BattleInfo:IsPVE() then
        self.selfTotalDamage  = self.selfTotalDamage + sstDamage
    end

    local attackerId = attacker.id
    if attacker.isSummonCreep and attacker.callerId then
        -- 如果攻击者是特殊召唤物，并且有召唤来源，那么这个召唤物的伤害统计归属于召唤者
        attackerId = attacker.callerId
    end
    self.statistics[attackerId] = self.statistics[attackerId] or {}
    self.statistics[attackerId].damage = self.statistics[attackerId].damage or 0
    self.statistics[attackerId].damage = self.statistics[attackerId].damage + sstDamage

    local targetId = target.id
    self.statistics[targetId] = self.statistics[targetId] or {}
    self.statistics[targetId].bear = self.statistics[targetId].bear or 0
    self.statistics[targetId].bear = self.statistics[targetId].bear + sstDamage

    dmgRec.nowHp = target:GetNowHp()
    if BattleInfo:IsPVE() then
        if attacker.camp == Constants.Camp.One then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.GiveEnemyDamageNum, nil, dmgRec.hpChange)
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.SomeElementTotalGiveDamage, attacker.elementType, dmgRec.hpChange)
            local rate = Core:GetElementCounteDamage(attacker.elementType, target.elementType)
            if rate > 0 then
                ConditionMgr:UpdateConditionData(Constants.GameOverCondition.ElementAdvantageDamageNum, nil, dmgRec.hpChange)
            end 
        end
    end
    local node = RecordMgr:AddRecord(dmgRec)
    if hpChange < 0 then
        self:Trig(target, Constants.TriggerMainType.HPReduce, {damageRec = dmgRec}, attacker)
    end
    --计算护盾，伤害变化buff等
    return dmgRec, node
end

function BattleMgr:Heal( dmg, dmgType, target, attacker, star, combo, dmgRec )
    star = star or 1
    combo = combo or 1
    dmgRec = dmgRec or RecordMgr.DamageRecord.New(target, attacker)

    --星级系数
    local starRate = Constants.StarDamageRate[star]
    local comboRate = Constants.ComboRate[combo]
    --治疗增幅
    local Treatment = math.max(0, 1 + target:GetAttr(Constants.AttrTypeId.TakeTreatment) + attacker:GetAttr(Constants.AttrTypeId.GiveTreatment)) 

    dmg = math.max( 0, dmg * Treatment )
    
    if BattleInfo:IsPVP() then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting4100, "PVPBuffVo")
        ---@type PVPBuffVo
        local vo = setting:Get(self.initData.pvpSettingId)
        if not isNull(vo) then
            print(string.format("PVPBuff修改前治疗:%f,修改后:%f",dmg, dmg * vo.globalTreatment))
            dmg = dmg * vo.globalTreatment
        end
    end
    
    dmgRec.damage = - dmg
    dmgRec.damageType = dmgType

    dmg = target.buffMgr:HealChange(dmg, dmgRec, attacker)
    dmgRec.finalDamage = - dmg


    local hpChange = target:ChangeNowHp(-dmgRec.finalDamage)
    dmgRec.hpChange = -hpChange
    dmgRec.nowHp = target:GetNowHp()

    -- 战斗统计
    local attackerId = attacker.id
    if attacker.isSummonCreep and attacker.callerId then
        -- 如果攻击者是特殊召唤物，并且有召唤来源，那么这个召唤物的伤害统计归属于召唤者
        attackerId = attacker.callerId
    end
    self.statistics[attackerId] = self.statistics[attackerId] or {}
    self.statistics[attackerId].cure = self.statistics[attackerId].cure or 0
    self.statistics[attackerId].cure = self.statistics[attackerId].cure + hpChange

    if BattleInfo:IsPVE() then
        if attacker.camp == Constants.Camp.One then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.GiveSelfHealNum, nil, hpChange)
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.GiveSpecialIdHealNum, target.typeId, hpChange)
        end
        if attacker.camp == Constants.Camp.Two then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.EnemyGiveHealNum, nil, hpChange)
        end
    end
    local node = RecordMgr:AddRecord(dmgRec)
    self:Trig(target, Constants.TriggerMainType.GetHealed, {damageRec = dmgRec}, attacker)
    self:Trig(attacker, Constants.TriggerMainType.GiveHeal, {damageRec = dmgRec}, target)

    --计算护盾，伤害变化buff等
    return dmgRec, node
end

--@role: [Game.Battle.Entity.Role#Role]
function BattleMgr:OnRoleDead( role )
    --移出进度队伍
    -- Core:RemoveFromQueue(role, self._actionQueue)
    local killer = Core:FindRole(role.killerId)
    -- print("OnRoleDead", role.killerId)
    self:Trig(role, Constants.TriggerMainType.Dead, {}, killer)
    self:TrigAll(Constants.TriggerMainType.OtherDead, {}, role)

    if role:IsBoss() then
        ConditionMgr:UpdateConditionData(Constants.GameOverCondition.KillBoss)
        if role.weakCount > 0 then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.KillBossWithBreak)
        end
    end

    self:OnRoleExit(role)
    
    -- 角色死亡战报
    local rec = RecordMgr.RoleRemoveRecord.New(role.id)
    RecordMgr:AddRecord(rec)
end

function BattleMgr:OnRoleExit( role )
    role.buffMgr:Clear()

    --检测其他所有角色，移除所有该角色施加的自身死亡移除型buff
    local rs = self:GetAliveRoles()
    for i,r in ipairs(rs) do
        r.buffMgr:WalkAllBuff(function ( buff )
            if buff.data.removeWhenOwnerDead and buff.attacker == role then
                r.buffMgr:RemoveBuff(buff)
            end
        end)
        r.buffMgr:AfterChangeBuff()
    end
    
    --移除牌库中的这个角色
    local cardMgr = role:GetCardMgr()
    if cardMgr then
        local recs = cardMgr:RemoveCard(role.id)
        RecordMgr:AddRecords(recs)
    end

    -- 因为有发现技能，能发现别人牌，所以角色死亡时，要把所有人牌库里的这些卡都移除
    for i, player in ipairs(self.players) do
        local cardMgr = player.cardMgr
        if cardMgr then
            local recs = cardMgr:RemoveCard(role.id)
            RecordMgr:AddRecords(recs)
        end
    end

    if BattleInfo:IsPVE() then
        if role.camp ~= Constants.Camp.One then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.KillEnemyNum, nil, 1)
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.KillSomeElementEnemyNum, role.elementType, 1)
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.KillSomeTypeEnemyNum, math.min(role.monsterClass, 2), 1)
        else
            if not role:IsSpecialSummon() then
                ConditionMgr:UpdateConditionData(Constants.GameOverCondition.SelfDeathNum, nil, 1)
            end
        end
    end
end

function BattleMgr:Trig(role, trigMainType, trigData, target, trigRule)
    -- print('trig', trigMainType)
    --根据触发规则排除
    if not Tools.isNullKey(trigRule) then
        local TriggerMainType = Constants.TriggerMainType
        if trigRule == Constants.TriggerRule.NoBeHitTrigger then
            if trigMainType == TriggerMainType.BeAttack
                or trigMainType == TriggerMainType.OtherBeAttack
                or trigMainType == TriggerMainType.OtherBeAttack2
            then
                return
            end
        end

        if trigRule == Constants.TriggerRule.NoneTrigger then
            if trigMainType == TriggerMainType.BeAttack
                or trigMainType == TriggerMainType.OtherBeAttack
                or trigMainType == TriggerMainType.OtherBeAttack2
                or trigMainType == TriggerMainType.Attack
                or trigMainType == TriggerMainType.OtherAttack
                or trigMainType == TriggerMainType.OtherAttack2
                or trigMainType == TriggerMainType.SkillStart
                or trigMainType == TriggerMainType.OtherSkillStart
                or trigMainType == TriggerMainType.OtherSkillStart2
                or trigMainType == TriggerMainType.SkillEnd
                or trigMainType == TriggerMainType.OtherSkillEnd
                or trigMainType == TriggerMainType.OtherSkillEnd2
            then
                return
            end
        end
    end
    role.buffMgr:Trig(trigMainType, trigData or {}, target)
end

function BattleMgr:TrigCamp( camp, trigMainType, trigData, target, trigRule)
    local rs = self:GetAliveRoles(camp)
    for i,v in ipairs(rs) do
        self:Trig(v, trigMainType, trigData or {}, target, trigRule)
    end
    self:Trig(self.agent, trigMainType, trigData or {}, target, trigRule)
    -- 触发猫球buff
    if self:HasSkillCat() then
        for i, roleCat in ipairs(self.skillCats) do
            if roleCat.camp == camp then
                self:Trig(roleCat, trigMainType, trigData or {}, target, trigRule)
            end
        end
    end
end

function BattleMgr:TrigAll( trigMainType, trigData, target, exclude, trigRule )
    local rs = self:GetAliveRoles()
    for i,v in ipairs(rs) do
        if not table.isContain(exclude, v) then
            self:Trig(v, trigMainType, trigData or {}, target, trigRule)
        end
    end
    self:Trig(self.agent, trigMainType, trigData or {}, target, trigRule)
    -- 触发猫球buff
    if self:HasSkillCat() then
        for i, roleCat in ipairs(self.skillCats) do
            self:Trig(roleCat, trigMainType, trigData or {}, target, trigRule)
        end
    end
end

function BattleMgr:RemoveRole(role)
    if role:IsDead() then
        return
    end
    role:ForceSetNowHp(0)
    self:OnRoleExit(role)
    RecordMgr:AddRecord(RecordMgr.RoleExitRecord.New(role.id))
end

function BattleMgr:RemoveSkillCat(skillCat)
    
end

function BattleMgr:SpecialSummon(camp, moudleData, afterCreate, attackerId)
    if not moudleData then
        printError('召唤的模板数据不存在')
        return
    end

    moudleData.summonPriority = moudleData.summonPriority or 999
    --检查对应阵营中的是否存在特殊召唤物
    local ss = self:GetSpecialSummon(camp)
    --查看是否可以顶掉这个角色
    if ss and moudleData.summonPriority <= ss.rawData.summonPriority then
        return
    end

    if ss then
        --清除这个角色
        self:RemoveRole(ss)
    end

    self.summonIndex = self.summonIndex or 100
    --召唤池内下标为num1的召唤兽，召唤时最大生命值百分比为num2，能量为num3点
    local Role = import('Game.Battle.Entity.Role')
    local role = Role.New()
    table.insert( self.roles, role )
    role:InitWithData(moudleData, camp, -1, Constants.RoleType.SpecialSummon)
    role.isSummonCreep = true
    if attackerId then
        role.callerId = attackerId  -- 记录是谁召唤的
    end
    
    --id, 血量，能量
    role.id = role.id * 1000 + self.summonIndex
    role.ultraPoint = 0

    if isNotNull(afterCreate) then
        afterCreate(role)
    end

    self.summonIndex  = self.summonIndex + 1
    RecordMgr:AddRecord(RecordMgr.CreateRoleRecord.New(role))
    role:OnEnter()
end

function BattleMgr:FindRoleByCampAndPos(camp, pos)
    for i,v in ipairs(self.roles) do
        if (camp == nil or v.camp == camp) and not v:IsDead() and v.standPosition == pos then
            return v
        end
    end
end

--@return [Game.Battle.Entity.Role#Role<>]
function BattleMgr:GetAliveRoles( camp )
    if camp == nil or camp == Constants.TargetCamp.All or camp == Constants.TargetCamp.All0 then
        local firstCamp = BattleInfo.isFirstCamp and Constants.Camp.One or Constants.Camp.Two
        local secondCamp = BattleInfo.isFirstCamp and Constants.Camp.Two or Constants.Camp.One
        -- 搜全体
        local roles = {}
        for i,v in ipairs(self.roles) do
            if v.camp == firstCamp and not v:IsDead() then
                table.insert(roles, v)
            end
        end
        for i,v in ipairs(self.roles) do
            if v.camp == secondCamp and not v:IsDead() then
                table.insert(roles, v)
            end
        end
        return roles
    else
        -- 搜阵营
        local roles = {}
        for i,v in ipairs(self.roles) do
            if v.camp == camp and not v:IsDead() then
                table.insert(roles, v)
            end
        end
        return roles
    end
end

function BattleMgr:GetRolesWithoutSpecialSummon( camp )
    local roles = {}
    for i,v in ipairs(self.roles) do
        if (camp == nil or v.camp == camp) and v.roleType ~= Constants.RoleType.SpecialSummon then
            table.insert(roles, v)
        end
    end
    return roles
end

function BattleMgr:GetRoleCamp(roleId)
    for i,v in ipairs(self.roles) do
        if v.id == roleId and v.roleType ~= Constants.RoleType.SpecialSummon then
            return v.camp
        end
    end
    if self:HasSkillCat() then
        for i, roleCat in ipairs(self.skillCats) do
            if roleCat.id == roleId then
                return roleCat.camp
            end
        end
    end
    return nil
end

function BattleMgr:GetRoleCampWithSpecialSummon(roleId)
    for i,v in ipairs(self.roles) do
        if v.id == roleId then
            return v.camp
        end
    end
    if self:HasSkillCat() then
        for i, roleCat in ipairs(self.skillCats) do
            if roleCat.id == roleId then
                return roleCat.camp
            end
        end
    end
    return nil
end

--@return [Game.Battle.Entity.Role#Role<>]
function BattleMgr:GetAliveRolesWithoutSpecialSummon( camp )
    local roles = {}
    for i,v in ipairs(self.roles) do
        if (camp == nil or v.camp == camp) and not v:IsDead() and v.roleType ~= Constants.RoleType.SpecialSummon then
            table.insert(roles, v)
        end
    end
    return roles
end

--@return [Game.Battle.Entity.Role#Role]
function BattleMgr:GetSpecialSummon(camp)
    local rs = self:GetAliveRoles(camp)
    for i,v in ipairs(rs) do
        if v.roleType == Constants.RoleType.SpecialSummon then
            return v
        end
    end
end

function BattleMgr:GetSpecialSummonRole(camp)
    local rs = self:GetAliveRoles(camp)
    for i,v in ipairs(rs) do
        if v.standPosition == Constants.SpecialSummonPosition then
            return v
        end
    end
end

function BattleMgr:IsSpecialSummonRole(id)
    local role = Core:FindRole(id)
    if role then
        return role.roleType == Constants.RoleType.SpecialSummon
    end
end

function BattleMgr:GetWaveMaxNum(  )
    local levelData = Core:GetLevelData(tonumber(self.initData.questId))
    if levelData and levelData[self.nowWave] then
        local waveData = levelData[self.nowWave]
        return waveData.maxNum
    end

    return 0
end

--@return [Game.Setting.Vo.WaveVo#WaveVo]
function BattleMgr:GetWaveData(  )
    local levelData = Core:GetLevelData(tonumber(self.initData.questId))
    if levelData and levelData[self.nowWave] then
        return levelData[self.nowWave]
    end
    return
end

function BattleMgr:IsBossWave()
    local waveData = self:GetWaveData()
    if IsNull(waveData) or isNull(waveData.wave1NpcType) then
        return false
    end
    local npcTypeList =  waveData.wave1NpcType
    for i, v in ipairs(npcTypeList) do
        if checkInt(v) >= Constants.RoleClass.Elite then
            return true
        end
    end
    return false
end

--操作时候记录之前所有角色的buff，
function BattleMgr:HandleRoleBuff( roles, handler )
    for i,role in ipairs(roles) do
        role.buffMgr:AddUseTag()
    end

    for i,role in ipairs(roles) do
        handler(role)
    end

    for i,role in ipairs(roles) do
        role.buffMgr:RemoveUseTag()
    end
end

--- func desc
---@param attacker any
---@param mainTarget any
---@param skillCardId any
---@param star any
---@param triggerNode any
---@param triggerEffectParams table 效果触发技能时的相关参数
function BattleMgr:AddTrigSkillCard(attacker, mainTarget, skillCardId, star , triggerNode, triggerEffectParams )
    if not self.trigSkillCardTree then
        self.trigSkillCardTree = Tree.New( TreeNode.New({}) )
    end
    if not self.nowTrigSkillCardNode then
        self.nowTrigSkillCardNode = self.trigSkillCardTree.root
    end

    local node = TreeNode.New({attacker = attacker, mainTarget = mainTarget, skillCardId = skillCardId, star = star , triggerNode = triggerNode, triggerEffectParams = triggerEffectParams})
    self.nowTrigSkillCardNode:AddChild(node)
end

function BattleMgr:DischargeTrigSkillCards( )
    if not self.trigSkillCardTree then
        return
    end
    if not self.nowTrigSkillCardNode then
        return
    end
    local children = self.nowTrigSkillCardNode.children
    for i,node in ipairs(children) do
        local attacker = node.data.attacker
        local mainTarget = node.data.mainTarget
        local skillCardId = node.data.skillCardId
        local star = node.data.star
        local triggerNode = node.data.triggerNode
        local triggerEffectParams = node.data.triggerEffectParams

        -- local tempNode = self.nowTrigSkillCardNode
        self.nowTrigSkillCardNode = node
        local disChargeSucceed = self:HandleSkillCard(attacker, mainTarget, skillCardId, star , nil , nil , triggerNode, triggerEffectParams )
        node.data = nil
        -- if not disChargeSucceed then
        --     self.nowTrigSkillCardNode = tempNode
        -- end

        -- --检测技能释放者目标是否还可以释放
        -- if skill:CanDischarge() and attacker:CanSkill() and mainTarget:CanBeClicked(attacker) then
        --     --可以释放，就直接释放
        --     self.nowTrigSkillCardNode = node
        --     self:HandleSkill(attacker, mainTarget, skill, 1)
        -- end

    end
end

function BattleMgr:ClearTrigSkills( )
    self.trigSkillCardTree = nil
    self.nowTrigSkillCardNode = nil
end

function BattleMgr:TestCritical()
    local rs1 = self:GetAliveRoles(Constants.Camp.One)
    local rs2 = self:GetAliveRoles(Constants.Camp.Two)
    local DSB = Core.damageScriptBase
    local loopTime = 10000

    for i,attacker in ipairs(rs1) do
        for j,target in ipairs(rs2) do
            local rec = {target = target}
            local critCount = 0
            for index=1,loopTime do
                local isCrit = DSB:IsCrit(attacker, target, nil, rec)
                if isCrit then
                    critCount  = critCount + 1
                end
            end

            print("暴击测试， 攻击者:", attacker.typeId, "暴击率:", attacker:GetAttr(Constants.AttrTypeId.Critical), 
            "受击者:", target.typeId, "抗暴率:", target:GetAttr(Constants.AttrTypeId.CriticalResist), 
            "期望:", attacker:GetAttr(Constants.AttrTypeId.Critical) - target:GetAttr(Constants.AttrTypeId.CriticalResist),
            "结果:", critCount / loopTime)
        end
    end
end

function BattleMgr:TestHit()
    local rs1 = self:GetAliveRoles(Constants.Camp.One)
    local rs2 = self:GetAliveRoles(Constants.Camp.Two)
    local DSB = Core.damageScriptBase
    local loopTime = 10000

    for i,attacker in ipairs(rs1) do
        for j,target in ipairs(rs2) do
            local rec = {target = target}
            local hitCount = 0
            local eHit = Core:GetElementCounteHit(attacker.elementType, target.elementType)
            local eDodge = Core:GetElementCounteDodge(attacker.elementType, target.elementType)
            for index=1,loopTime do
                local isHit = DSB:IsHit(attacker, target, nil, rec)
                if isHit then
                    hitCount  = hitCount + 1
                end
            end

            print("命中测试， 攻击者:", attacker.typeId, "命中率:", attacker:GetAttr(Constants.AttrTypeId.Hit), 
            "受击者:", target.typeId, "闪避率:", target:GetAttr(Constants.AttrTypeId.Dodge), 
            "克制修正:", eHit - eDodge,
            "期望:", (attacker:GetAttr(Constants.AttrTypeId.Hit) + eHit - target:GetAttr(Constants.AttrTypeId.Dodge) - eDodge),
            "结果:", hitCount / loopTime)
        end
    end
end

--防止循环
function BattleMgr:ForestallLoop(roleId, buff, triggerNode)
    --先判断父节点是否终止触发

    if triggerNode == nil or triggerNode.data == nil  then
        return true
    elseif triggerNode.data.isFinal == 1 then
        return false
    end
    return BattleMgr:ForestallLoopRecursion(roleId, buff.buffID, triggerNode)
end

function BattleMgr:ForestallLoopRecursion(roleId, buffId, triggerNode)
    if triggerNode == nil or triggerNode.data.layer == nil  then
        return true
    else
        if triggerNode.data.layer > 9  then
            print( "----------------------到达上限无法触发"..buffId)
            return false
        end
        --是否被触发的技能
        if triggerNode.data.roleId == roleId and buffId == triggerNode.data.buffId and triggerNode.data.needProtect then
            return false
        end
    end
    return BattleMgr:ForestallLoopRecursion(roleId, buffId, triggerNode.parent)
end


--添加触发链 获取当前节点并且添加为子节点 treeNodeParent 为当前节点,或者触发主动技能的节点
function BattleMgr:AddTriggerNode( roleId, buff, trigData, treeNodeParent, isFinal, needProtect)
    if not self.triggerRecordTree then
        self.triggerRecordTree = Tree.New( TreeNode.New({}) )
    end

    if treeNodeParent == nil  then
        --添加起点
        local node = TreeNode.New({roleId = roleId, buffId = buff.buffID, buffUid = buff.id, trigData = trigData, layer = 1 ,isFinal = isFinal, needProtect = needProtect})
        self.triggerRecordTree.root:AddChild(node)
        self.triggerRecordTree.root.data.layer = 0
        self.nowTriggerRecordNode = node
        return self.nowTriggerRecordNode
    else
        --添加普通节点
        local node = TreeNode.New({roleId = roleId, buffId = buff.buffID, buffUid = buff.id, trigData = trigData, layer = treeNodeParent.data.layer + 1, isFinal = isFinal, needProtect = needProtect})
        treeNodeParent:AddChild(node)
        self.nowTriggerRecordNode = node
    end

    return self.nowTriggerRecordNode

end

--回退到上一层
function BattleMgr:RollbackTriggerNode( parentNode)
        self.nowTriggerRecordNode = parentNode
end

--重置触发树状态
function BattleMgr:ResetTriggerRecordTree()
    BattleMgr.nowTriggerRecordNode=nil
    self.triggerRecordTree = Tree.New( TreeNode.New({}) )
end

function BattleMgr:GetNowTriggerBuff()
    if not BattleMgr.nowTriggerRecordNode then
        return
    end
    local uid = BattleMgr.nowTriggerRecordNode.data.buffUid
    local roleId = BattleMgr.nowTriggerRecordNode.data.roleId
    local role = Core:FindRole(roleId)
    if not role then
        return
    end
    local buff = role.buffMgr:GetBuff(uid)
    return buff
end
--技能上下文缓存入栈
function BattleMgr:PushSkillStack(skillRecord)
    table.insert(self.skillStack, skillRecord)
end
--技能上下文缓存出栈
function BattleMgr:PopSkillStack()
    table.remove(self.skillStack)
end
--返回当前激活的技能上下文,可能为空
--@return [Game.Battle.Record.SkillRecord#SkillRecord]
function BattleMgr:GetNowSkillRecord()
    if self.skillStack == nil then
        return
    end
    return self.skillStack[#self.skillStack]
end

function BattleMgr:GetNowSkillDamageRecs()
    local skillRec = self:GetNowSkillRecord()
    if skillRec then
        return skillRec.damageRecs or {}
    end
    return {}
end

--- dot上下文缓存入栈
---@param dotInfo DOTInfo
function BattleMgr:PushDOTStack(dotInfo)
    table.insert(self.DOTStack, dotInfo)
end

--- dot上下文缓存出栈
function BattleMgr:PopDOTStack()
    table.remove(self.DOTStack)
end

---@return DOTInfo
function BattleMgr:GetNowDOTInfo()
    if self.DOTStack == nil then
        return
    end
    return self.DOTStack[#self.DOTStack]
end

---@param info DelayBuffEffectInfo
function BattleMgr:AddDelayBuffEffectInfo(info)
    table.insert(self.delayBuffEffects, info)
end

function BattleMgr:WalkDelayBuffEffectInfo(func)
    for i, v in ipairs(self.delayBuffEffects) do
        local continue = func(v)
        if not continue then
            break
        end
    end
end

--- 触发延迟效果
---@param triggerMainType Constants.TriggerMainType
function BattleMgr:TrigDelayBuffEffectInfo(triggerMainType)
    if self.delayBuffEffects and #self.delayBuffEffects > 0 then
        for i = #self.delayBuffEffects, 1, -1 do
            ---@type DelayBuffEffectInfo
            local effect = self.delayBuffEffects[i]
            if effect.triggerMainType == triggerMainType then
                self:HandleDelayBuffEffect(effect)
                table.remove(self.delayBuffEffects, i)
            end
        end
    end
end

function BattleMgr:RefreshAllBuff()
    local rs = self:GetAliveRoles()
    for i,v in ipairs(rs) do
        v.buffMgr:Refresh()
    end
end

function BattleMgr:ChangeSkillCardQueue(handler)
    local recs = {}
    local selfCampIndex = 0
    local enemyCampIndex = 0
    for i,v in ipairs(self.skillCardQueue) do
        local isChange, result = handler(v)
        local role = Core:FindRole(result.roleId)
        if role then
            if role.camp == Constants.Camp.One then
                selfCampIndex = selfCampIndex + 1
            else
                enemyCampIndex = enemyCampIndex + 1
            end
        end
        if isChange then
            self.skillCardQueue[i] = result
            if role then
                local index = role.camp == Constants.Camp.One and self.usedFriendSkillCardCount + selfCampIndex or self.usedEnemySkillCardCount + enemyCampIndex
                table.insert(recs, RecordMgr.ChangeSkillCardQueueRecord.New(index, result, role.camp))
            end
        end
    end
    return recs
end

function BattleMgr:CheckBattleWithRecord(battleRecord)
    
end

--同步重连游戏
function BattleMgr:SyncGame(initData, inputs)
    local oldAuto = UIBattleSettingMgr.isAutoBattle
    local oldMode = BattleInfo.inputMode
    BattleInfo.inputMode = Constants.InputMode.ReplayNoLag
    self.skipRoundStart = true
    --初始化
    self:Clear()
    self:Init(initData)
    self:InitBattle()

    if isNull(inputs) or table.count(inputs) == 0 then
        BattleInfo.inputMode = Constants.InputMode.Normal
        self.skipRoundStart = false
        UIBattleSettingMgr.isAutoBattle = oldAuto
        return
    end

    --之前没开启快速跳过逻辑，这边需要驱动一下
    for i,oneTurnInputs in ipairs(inputs) do
        self:RoundStart()
        for j,input in ipairs(oneTurnInputs) do
            local player = self:GetPlayer(input.playerId)
            player:HandleInputData(input)
        end
    end
    self.skipRoundStart = false
    BattleInfo.inputMode = Constants.InputMode.Normal
    UIBattleSettingMgr.isAutoBattle = oldAuto
    --同步给表现层
end

function BattleMgr:GetStatusCode()
    local w = {"|"}
    for i,v in ipairs(self.roles) do
        if not v:IsDead() then
            table.insert(w, v.id)
            table.insert(w, "&")
            table.insert(w, v:GetNowHp())
            table.insert(w, "&")
            table.insert(w, v:GetAttr(Constants.AttrTypeId.Attack))
            table.insert(w, "|")
        end
    end

    table.insert(w, "**")
    --牌库信息
    self:CallPlayersFunc(nil, function (player)
        local cardMgr = player:GetCardMgr()
        if cardMgr then
            table.link(w, cardMgr:ToData())
    table.insert(w, "**")
        end
    end)
 
    return table.concat(w)
end

function BattleMgr:GetUserCardMgr()
    return self:GetPlayer(BattleInfo.myPlayerId):GetCardMgrByPlayerId(BattleInfo.myPlayerId)
end

function BattleMgr:CallPlayersFunc(camp, func)
    for i,player in ipairs(self.players) do
        if camp == nil or player.camp == camp then
            func(player)
        end
    end
end

function BattleMgr:SetUnitSkill( unitSkillId )
    self.unitSkillId = unitSkillId
    RecordMgr:AddRecord(RecordMgr.ChangeMergeSkillRecord.New(unitSkillId))
end

function BattleMgr:AgentUseSkill( targetId, skillId, star )
    local role = self.agent
    local target = Core:FindRole(targetId)

    local skill = role:GetSkill(skillId, star, 1)
    if not target or not target:CanBeSelected() then
        --没有目标，则自动选择
        local rs = self:GetAliveRoles( skill.clickType == Constants.TargetCamp.Friend and role.camp or self:GetOppoCamp(role.camp) )
        target = rs[1]
    end
    self:HandleSkill(self.agent, target, skill, 1)
end

function BattleMgr:AgentUseSkillCard( targetId, skillCardId, star )
    local role = self.agent
    local target = Core:FindRole(targetId)
    self:HandleSkillCard(self.agent, target, skillCardId, star)
end


function BattleMgr:UnitSkill( unitCount )
    -- unitCount = 4
    if Tools.isNullKey(self.unitSkillId) then
        return
    end
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting569, "UnitSkillVo")
    --@RefType [Game.Setting.Vo.UnitSkillVo#UnitSkillVo]
    local unitSkillVo = setting:Get(self.unitSkillId)
    assert(unitSkillVo, "找不到对应的合卡技:"..self.unitSkillId)
    --是否达到了初始合卡数
    if unitCount < unitSkillVo.startUnit then
        return
    end

    --达到了之后，找到对应的星级
    local star = math.min(3, unitCount - 1)
    --释放技能
    -- local rs = BattleMgr:GetAliveRoles(self.camp)
    -- BattleMgr:HandleSkill(self.agent, rs[1], self.agent:GetSkill(unitSkillVo.skillId, star, 1), 1)
    -- unitSkillId = 900011

    self:AgentUseSkillCard(0, unitSkillVo.skillId, star)
    -- self:AgentUseSkill(0, unitSkillVo.skillId, star)
    ConditionMgr:UpdateConditionData(Constants.GameOverCondition.DischargeMergeSkill, star)
end

function BattleMgr:GetCampSkillCardMaxUseCount(camp)
    local totalActionNum = 0
    self:CallPlayersFunc(camp, function (player)
        local cardMgr = player:GetCardMgr()
        if cardMgr then
            totalActionNum = totalActionNum + cardMgr:GetSkillCardMaxUseCount()
        end
    end)
    return totalActionNum
end

function BattleMgr:AddBuffTrigSpanNum(num)
    self.buffTriggerSpanNum = self.buffTriggerSpanNum + num
end

function BattleMgr:GetBuffTrigSpan()
    return self.buffTrigSpans[self.buffTriggerSpanNum]
end

return BattleMgr