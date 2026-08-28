--
-- Author:luqucheng
-- Date: 2019-12-09 15:55:21
--
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local RecordInterpreter = CS.RecordInterpreterConsole

local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
local LogEnableKey = "recordInterpreterConsoleLogEnable"

local RecordReader = {}

RecordReader.cardRecordReader = import('Game.BattleView.RecordReader.CardRecordReader')
---@type SkillRecordReader
RecordReader.SkillRecordReader = import('Game.BattleView.RecordReader.SkillRecordReader')
RecordReader.records = {}

RecordReader.recordCo = nil
RecordReader.skillCo = nil
RecordReader.lastRecordIsSkill = nil

function RecordReader:Init(  )
    self.records = {}
    self.recordCo = nil
    self.skillCo = {}
    self.lastRecordIsSkill = false
    self.SkillRecordReader:Init()

    self.recordInterpreterEnabled = PlayerPrefsUtility.GetBool(LogEnableKey, false)
end

function RecordReader:GetRecordTypeName(record)
    for k,v in pairs(Constants.RecordType) do
        if record.r == v then
            return k
        end
    end
end

function RecordReader:GetRecordTypeNames(records)
    local w = {}
    for i,v in ipairs(records) do
        table.insert(w, self:GetRecordTypeName(v))
        table.insert(w, "   ")
    end
    return table.concat( w )
end

function RecordReader:ShowRecords( records )
    -- print(table.toString(records, 'battleRecords'))
    -- print(self.recordCo)
    -- print("ShowRecords", #self.records, #records, self:GetRecordTypeNames(records), self.recordCo)
    -- print("[流程] show records", table.dump(records), debug.traceback())
    table.link(self.records, records)
    if self.recordCo == nil then
        self.recordCo = cs_coroutine.start(self.DoRecord, self)
    end

    if self.recordInterpreterEnabled then
        local json = table.serialize(records)
        RecordInterpreter.Interpret(json)
    end
end

function RecordReader:DoRecord( )
    -- print("RecordReader:DoRecord")
    BattleViewMgr:StopLongIdle()
    while #self.records > 0 do
        local record = table.remove(self.records, 1)
        if record.r ~= Constants.RecordType.Skill and record.r ~= Constants.RecordType.UltraPointChange then
             --等待所有技能动画播放结束
            local frame = self.SkillRecordReader:GetMaxPerformTime()
            if frame > 0 then
                self.SkillRecordReader:ClearPerformTime()
                if BattleInfo:IsUserCamp(self.SkillRecordReader.lastAttackCamp) then
                    coroutine.yield( WaitForSeconds(frame * AnimFrameTime - 1) )
                    BattleViewMgr:ResetCamera()
                    coroutine.yield( WaitForSeconds(1.5) )
                else
                    coroutine.yield( WaitForSeconds(frame * AnimFrameTime) )
                end
            end
        end

        -- local needDelay = false
        -- if record.r == Constants.RecordType.UltraPointChange and self.lastRecordIsSkill then
        --     needDelay = true
        -- end

        -- self.lastRecordIsSkill = (record.r == Constants.RecordType.Skill) or (self.lastRecordIsSkill and record.r == Constants.RecordType.UltraPointChange)

        -- if needDelay then
        --     cs_coroutine.start(function ()
        --         local frame = self.SkillRecordReader:GetLastHitTime() + 1
        --         coroutine.yield( WaitForSeconds(frame * AnimFrameTime) )
        --         self:DoOneRecord(record)
        --     end)
        -- else
        --     self:DoOneRecord(record)
        -- end
        
        self:DoOneRecord(record)
        --gameover保护
        if record.r == Constants.RecordType.GameOver then
            self.recordCo = nil
            break
        end
    end

    self.recordCo = nil
    -- while true do
        -- BattleViewMgr:PlaySFX(1002, BattleViewMgr.roleViews[1])
        -- coroutine.yield( CS.UnityEngine.WaitForSeconds(3000) )
    -- end
end

function RecordReader:DoOneRecord( record )
    -- print("[流程] record: ", Constants.RecordTypeName[record.r], table.dump(record))
    if record.r == Constants.RecordType.Skill then
        --镜头拉近
        local noAction = record.na
        --查看接下来有没有游戏结束消息，有的话最后一击慢动作
        local isFinishSkill = (not self:NeedSkipSkill(record)) and self:IsFinalSkill()

        if noAction then
            --被动技能
            self.SkillRecordReader.DoRecord(self.SkillRecordReader, record, isFinishSkill )
        else
            local waitFrame = self.SkillRecordReader:GetPerformTime(record)
            -- print("rolePerformTime", waitFrame)
            if waitFrame == -1 then
                --直接等待的标志，等待所有技能动画播放结束
                coroutine.yield( WaitForSeconds(self.SkillRecordReader:GetMaxPerformTime() * AnimFrameTime) )
                self.SkillRecordReader:ClearPerformTime()
                coroutine.yield(self.SkillRecordReader.DoRecord( self.SkillRecordReader, record, isFinishSkill ) )
            else
                coroutine.yield( WaitForSeconds(waitFrame * AnimFrameTime) )
                local co
                co = cs_coroutine.start(function (  )
                    self.SkillRecordReader.DoRecord(self.SkillRecordReader, record, isFinishSkill )
                    --从列表里移除
                    table.removebyvalue(self.skillCo, co)
                    co = nil
                end)
                table.insert(self.skillCo, co)
            end
        end
    elseif self.cardRecordReader:IsCardRecord(record.r) then
        self.cardRecordReader:DoRecord(record)
    elseif record.r == Constants.RecordType.RequireInput then
        self:RequireInput(record)
    elseif record.r == Constants.RecordType.TurnStart then
        BattleViewMgr:SwithToUICamera()

        --回合开始回合结束
        coroutine.yield(  self.DoTurnStartRecord( self, record ) )
    elseif record.r == Constants.RecordType.TurnEnd then
        --回合开始回合结束
        BattleViewMgr:SwithToUICamera()

        coroutine.yield( self.DoTurnEndRecord( self, record ) )
    elseif record.r == Constants.RecordType.GameOver then
        coroutine.yield( self.DoGameOverRecord( self, record ) )
    elseif record.r == Constants.RecordType.ChangeWave then
        self.DoChangeWaveRecord( self, record )
    elseif record.r == Constants.RecordType.ChangeWaveEnd then
        coroutine.yield( self.DoChangeWaveEndRecord( self, record ) )
    elseif record.r == Constants.RecordType.ChangeMergeSkillId then
        -- 目前没有合卡技，这里先忽略
        -- coroutine.yield( self.DoChangeMergeSkillId( self, record ) )
    elseif record.r == Constants.RecordType.InputFinished then
        local cat = BattleViewMgr:GetSkillCat(BattleInfo.myCamp, 1)
        if cat then
            cat:PlayActiveExit()
            local time = cat:GetAnimationTime("cat_Departure")
            coroutine.yield(WaitForSeconds(time))
        else
            coroutine.yield(WaitForSeconds(0.5))    -- 最后一张牌出完稍微等一下下，给动画留点时间
        end
        -- if BattleInfo:IsUserCamp(record.c) then
        local t = BattleViewMgr.sceneVo.battleAndUICameraSwitchTime
        local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
        SkillCameraMgr:SwitchBattleCamera(true, t)
            -- coroutine.yield(WaitForSeconds(t))
        -- end
        Events.Broadcast(Constants.EventNames.BattlePlayerInputFinish)
    elseif record.r == Constants.RecordType.AIChooseSkill then
        --敌方设置技能，通知ui
        Events.Broadcast(Constants.EventNames.BattleEnemyChooseSkillShow, record.ss)
    elseif record.r == Constants.RecordType.UltraPointChange then
        local role = BattleViewMgr:FindRoleView(record.ri)
        if role then
            role:ChangeUltraPoint(record.p, record.t)
        end
    elseif record.r == Constants.RecordType.CreateSkillCat then
        BattleViewMgr:OnCreateSkillCat(record)
    elseif record.r == Constants.RecordType.CreateRole then
        coroutine.yield( BattleViewMgr:OnCreateRole( record ) )
    elseif record.r == Constants.RecordType.SyncRole then
        BattleViewMgr:OnSyncRole(record)
    elseif record.r == Constants.RecordType.SyncStatus then
        BattleViewMgr:OnSyncRoleStatus(record)
    elseif record.r == Constants.RecordType.MissionUpdate then
        self:OnMissionUpdated(record)
    elseif record.r == Constants.RecordType.ChangeElement then
        -- print("ChangeElement", record.ri, record.el)
        Events.Broadcast(Constants.EventNames.BattleChangeElement, {roleId = record.ri, element = record.el})
    elseif record.r == Constants.RecordType.ChangeMaxHp then
        self:OnChangeMaxHp(record)
    -- elseif record.r == Constants.RecordType.SyncStatus then
    --     self:OnSyncStatus(record)
    elseif record.r == Constants.RecordType.ChangeQueueCard then
        if BattleInfo:IsUserCamp(record.c)  then
            Events.Broadcast(Constants.EventNames.BattleSkillQueueChangeShow, 
            {index = record.index, skillIndex = record.skillIndex, targetId = record.targetId, roleId = record.roleId, star = record.roleId})
        end
    elseif record.r == Constants.RecordType.SkillFailed then
        Events.Broadcast(Constants.EventNames.BattleSkillFailedShow, 
        {roleId = record.a, skillCardId = record.s, star = record.ss, isInput = record.ip})
    elseif record.r == Constants.RecordType.RoleEnter then
        local skipEnterAnimation = false    -- 默认不跳过
        local skipCampList = {}
        -- 序章2跳过角色入场动画
        local questId = BattleViewMgr.initData.questId
        if questId == Constants.QUEST_OP_LEVEL[2] then
            skipEnterAnimation = true
            if BattleViewMgr.nowWave == 1 then
                -- 第一波跳过双方入场动画
                skipCampList = {1,2}
            else
                -- 后续波次只跳过我方入场动画
                skipCampList = {1}
            end
        end
        coroutine.yield( BattleViewMgr:PlayerRoleEnter(skipEnterAnimation, skipCampList) )
    elseif record.r == Constants.RecordType.UltraPointMaxChange then
        local roleView = BattleViewMgr:FindRoleView(record.ri)
        if roleView then
            roleView:ChangeUltraPointMax(record.f, record.t)
        end
    elseif record.r == Constants.RecordType.SPTypeChange then
        local roleId = record.rId
        local fromType = record.ft
        local toType = record.tt
        local roleView = BattleViewMgr:FindRoleView(roleId)
        if roleView then
            roleView:ChangeUltraPointType(fromType, toType)
        end
    elseif record.r == Constants.RecordType.RegisterValueChange then
        local roleId = record.rId
        local value = record.v
        local roleView = BattleViewMgr:FindRoleView(roleId)
        if roleView then
            roleView:SetRegister1(value)
        end
    else
        local isFinishDamage = record.r == Constants.RecordType.Damage and self:IsFinalSkill() or false
        self.SkillRecordReader:DoSubRecord(record, isFinishDamage)
    end

    if record.r ~= Constants.RecordType.Skill then
        self:DoSubRecord(record)
   end
end

function RecordReader:Test(  )
    cs_coroutine.start(self.Test1, self)
end

function RecordReader:OnMissionUpdated( record )
    -- print("OnMissionUpdated", table.toString(record, "record"))
    Events.Broadcast(Constants.EventNames.BattleMissionUpdated, {type = record.type, value = record.value, usedTo = record.condtionUsedTo, state = record.conditionState})
end

function RecordReader:Test1(  )
    coroutine.yield( WaitForSeconds(10) )
end

function RecordReader:DoTurnStartRecord( record )
    coroutine.yield( BattleViewMgr.TurnStart( BattleViewMgr, record.c) )
    --处理里面附带的数据
    coroutine.yield( self.DoSubRecord( self, record))
    
end

function RecordReader:DoTurnEndRecord( record )
    coroutine.yield( BattleViewMgr:TurnEnd(record.c))
    coroutine.yield( self.DoSubRecord( self, record))
end

function RecordReader:DoGameOverRecord( record )
    -- coroutine.yield( WaitForSeconds(1) )
    -- if BattleInfo:IsOnline() then
    --     coroutine.yield( WaitForSeconds(2) )
    -- end
    BattleViewMgr:GameOver(record.w, record)
    -- Events.Broadcast(Constants.EventNames.BattleGameOverShow, {isWin = record.w})
end

function RecordReader:DoChangeWaveRecord( record )
    if record.waveNum > 1 then
        coroutine.yield( WaitForSeconds(1) )
    end
     BattleViewMgr.ChangeWave( BattleViewMgr, record.waveNum, record.moudleIds, record.camp, record.maxNum)
end

function RecordReader:DoChangeWaveEndRecord( record )
    --需要检查后续是否有技能节点，否则需要等待
    -- local needWait = false
    -- for i,v in ipairs(self.records) do
    --     if v.r == Constants.RecordType.Skill and not record.na then--有动作的技能才会等
    --         needWait = true
    --         break
    --     end
    -- end
    local needWait = true   -- 现在的规则是一定会等待入场动作播完
    BattleViewMgr.ChangeWaveEnd( BattleViewMgr, record.waveNum, record.camp, record.maxNum, needWait)
end

function RecordReader:DoChangeMergeSkillId(record)
    Events.Broadcast(Constants.EventNames.BattleChangeMergeSkillId, {id = record.id})
end

--基本都是不花费时间的子数据
function RecordReader:DoSubRecord( record )
    -- if not record then
    --     return
    -- end
    local rt = Constants.RecordType
    --处理一个日志下的子信息
    local subs = record.subs
    if not subs then
        return
    end
    for k,v in ipairs(subs) do
        self:DoOneRecord( v )
    end

    --跑过之后清除
    record.subs = nil
end


function RecordReader:RequireInput( record )

    if BattleInfo:IsUserCamp(record.c) then
        BattleViewMgr.canInput = true
    end
    -- print("RequireInput", record.n, record.c, record.ap)
    Events.Broadcast(Constants.EventNames.BattleRequireInput, {num = record.n, camp = record.c, playerId = record.pId, actionPoint = record.ap, campActionPoint = record.cap, remainTime = record.remainTime})
    -- Events.Broadcast(Constants.EventNames.BattleInputUse, {pos={1,1}})
    -- Events.Broadcast(Constants.EventNames.BattleInputFinished)
    
    
end

function RecordReader:OnChangeMaxHp( record )
    local roleId = record.roleId
    local nowHp = record.nowHp
    local nowMaxHp = record.nowMaxHp
    local originMaxHp = record.originMaxHp

    local role = BattleViewMgr:FindRoleView(roleId)
    if not role then
        return
    end
    role.attr:SetValue(Constants.AttrTypeId.NowHp, nowHp)
    --表现这边的属性不直接刷新，所以直接设置没问题
    role.attr:SetValue(Constants.AttrTypeId.Hp, nowMaxHp)
    Events.Broadcast(Constants.EventNames.BattleHpChangeShow, 
        {roleId = roleId, per = nowHp / nowMaxHp, maxPer = nowMaxHp / originMaxHp})
end

function RecordReader:OnSyncStatus( record )
    local roleId = record.id
    local status = record.status

    local role = BattleViewMgr:FindRoleView(roleId)
    if not role then
        return
    end

    role.statusAbility = status

    Events.Broadcast(Constants.EventNames.BattleChangeRoleAbilityStatus, 
        {roleId = roleId})
end

function RecordReader:Card( record )
    
end

function RecordReader:Reset( )
    if self.recordCo then
        cs_coroutine.stop(self.recordCo)
        self.recordCo = nil
    end

    for i,co in ipairs(self.skillCo) do
        if co then
            cs_coroutine.stop(co)
        end
    end
    self.skillCo = {}

    self.SkillRecordReader:Reset()
    self.records = {}
end

function RecordReader:IsFinalSkill(origin)
    if isNull(self.records) or table.count(checkTable(self.records)) == 0 then
        return false
    end
    -- 看看是不是gameover前的最后一个skill或者最后一个damage
    for i, record in ipairs(self.records) do
        if record.r == Constants.RecordType.GameOver
        and record.w == true
        and record.oac == 0 then
            return true
        elseif record.r == Constants.RecordType.Skill
        or record.r == Constants.RecordType.Damage then
            return false
        elseif record.r == Constants.RecordType.Trigger then
            if self:IsTriggerSkill(record) then
                return false
            end
        end
    end
    return false
end

function RecordReader:IsTriggerSkill(record)
    local queue = {}
    local subs = record.subs
    if subs then
        for i, sub in ipairs(subs) do
            table.insert(queue, sub)
        end
    end
    while #queue > 0 do
        local subRecord = table.remove(queue, 1)
        if subRecord.r == Constants.RecordType.Skill then
            return true
        end
        subs = subRecord.subs
        if subs then
            for i, sub in ipairs(subs) do
                table.insert(queue, sub)
            end
        end
    end
    return false
end

function RecordReader:NeedSkipSkill( record )
    if record.s == 42165008 then
        return true
    end
    return false
end

return  RecordReader