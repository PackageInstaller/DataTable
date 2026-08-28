--
-- Author:luqucheng
-- Date: 2019-12-11 14:05:09
--
local MonsterAI = import("Game.Battle.AI.MonsterAI")
local SkillCardMgr = import('Game.Battle.SkillCard.SkillCardMgr')
local Controller = import('Game.Battle.Entity.Controller')
local cs_coroutine = import('XLua.cs_coroutine')
local gameUtils = CS.GameUtils
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
--@SuperType [Game.Battle.Entity.Controller#Controller]
---@class CardController
local CardController = Class("CardController", Controller)
local Role = import('Game.Battle.Entity.Role')

--@RefType [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
CardController.cardMgr = nil

CardController.inputCallback = nil
CardController.cardAnimFinished = false
CardController.nowTurnPerUnitCount = nil--操作前自动产生的合卡次数
CardController.AISkills = nil
--@RefType [Game.Battle.Entity.Role#Role]
CardController.agent = nil --替代释放技能的角色

CardController.inputSkills = nil
CardController.playerId = nil
CardController.isHosting = false --是否托管

function CardController:__init(camp, playerId, initData)
    Controller.__init(self, camp, playerId)

    self.isPlayer = true
    self.isHosting = false
    local roleDatas = camp == Constants.Camp.One and initData.playerTeam or initData.enemyTeam

    local skillCatDatas
    if camp == Constants.Camp.One then
        if initData.playerCatTeam then
            skillCatDatas = initData.playerCatTeam[1]
        end
    else
        if initData.enemyCatTeam then
            skillCatDatas = initData.enemyCatTeam[1]
        end
    end
    
    self.monsterAi = MonsterAI.New()
    self.monsterAi:LoadBt(roleDatas)
    self.cardMgr = SkillCardMgr.New()
    self.cardMgr:Init(camp, roleDatas, skillCatDatas, playerId)
    
    -- self.__UseReplayInput = Bind(self, self.UseReplayInput)
    -- Events.AddListener(Constants.EventNames.BattleRequireInput, self.__UseReplayInput)
end

function CardController:CreateAgent(camp, initData)
    local role = Role.New()
    self.agent = role
    role:AgentInit(initData.myPartyCat.id, camp)
end

function CardController:InitCat()
    local go = CS.UnityEngine.GameObject.Instantiate(ResMgr.catMoudles[1].loader.ResultObject)
end

function CardController:SetHosting(enable)
    self.isHosting = enable
    if enable and self:IsInputing() then
        self:HostOneTurn()
    end
end

function CardController:__delete(  )
    Controller.__delete(self)
    -- Events.RemoveListener(Constants.EventNames.BattleRequireInput, self.__UseReplayInput)
    self.monsterAi:Delete()
end

function CardController:OnGameStart(  )
    -- self.cardMgr:GameStartRound()
    -- local skills, recs = self.cardMgr:LocalEndRound()
    -- RecordMgr:AddRecords( recs )
    -- self.cardMgr:UpdateMission(skills, recs)
    -- self.cardMgr:AddUltraPoint(recs)

    -- if self.camp == Constants.Camp.One then
    --     --添加我方玩家初始化的buff
    --     local data = BattleMgr.initData.playerTeamSkill
    --     --  print("playerTeamSkill:",data)
    --     if not Tools.isNullKey(data) then
    --         local l = string.slice(data, '&')
    --         for i,v in ipairs(l) do
    --             local d = string.slice(v, '=')
    --             --  print("playerTeamSkill:", d[1], d[2])
    --             self.agent.buffMgr:AddBuff(self.agent, Core:GetBuffData(d[1], tonumber(d[2]), 1))
    --         end
    --     end
    -- end
    --  self.agent.buffMgr:AddBuff(self.agent, Core:GetBuffData(111081, 1, 1))
    --  self.agent.buffMgr:AddBuff(self.agent, Core:GetSkillEffectData(111074, 1, 1))
 
end

function CardController:OnTurnEnd( camp )

end


function CardController:OnRequireInput( callback, refInputSkills )
    --合成一下，然后备份
    --@RefType [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
    local cardMgr = self.cardMgr
    self.inputSkills = refInputSkills

    -- cardMgr:UnitCard()
    cardMgr:Backup()
    -- print("OnRequireInput...")
    self.inputCallback = callback
    RecordMgr:AddRecord(RecordMgr.RequireInputRecord.New(AI:GetChoosableCardNum(self.cardMgr), self.cardMgr))
    if BattleInfo.inputMode == Constants.InputMode.ReplayNoLag then
        if UIBattleSettingMgr then
            UIBattleSettingMgr.isAutoBattle = false
        end
        -- self:OnInputFinished()
    end

    -- 这里请求播放战报的代码先注释掉看看
    -- if BattleInfo:IsViewEnable() then
    --     Events.Broadcast(Constants.EventNames.BattleRecordShow)
    -- end

    --托管中
    if self.isHosting then
        self:HostOneTurn()
    end
    -- self:OnReceveUseInput({pos={1,2}})
    -- self:OnInputFinished()
end

function CardController:AfterOnRequireInput()
    -- if BattleInfo.inputMode == Constants.InputMode.ReplayNoLag then
    --     self:UseReplayInput()
    -- end
end

function CardController:UseReplayInput()
    if BattleInfo.inputMode ~= Constants.InputMode.ReplayNoLag then
        return
    end
    -- print("UseReplayInput")
    cs_coroutine.start(function (  )
    --  coroutine.yield( WaitForSeconds(2) )
        --读取replay里面的操作内容
        local canStart = false
        while true do
            local record = BattleInfo:GetNextInput(function (ip)
                local r = ip.r
                local c = ip.c
                return (r == Constants.RecordType.SyncCard or r == Constants.RecordType.PlayerInput or r == Constants.RecordType.InputFinished) and c == self.camp
            end)
            if record.r == Constants.RecordType.SyncCard and record.c == self.camp then
                canStart = true
            end

            if canStart and record.r == Constants.RecordType.PlayerInput and record.c == self.camp then
                for i,v in ipairs(record.inputData) do
                    if v.inputType == Controller.InputType.UseCard then
                        self:OnReceveUseInput(v.data)
                    elseif v.inputType == Controller.InputType.MoveCard then
                        self:OnReceveExchangeInput(v.data)
                    end
                end
            end

            if canStart and record.c == self.camp then
                if record.r == Constants.RecordType.InputFinished and record.c == self.camp then
                    self:OnInputFinished()
                    return
                end
            end
        end
        -- for i=1,BattleMgr:GetSkillCardMaxUseCount(self.cardMgr) do
        --     self:AutoUseOneCard()
        -- end
        -- BattleInfo.inputMode = Constants.InputMode.Normal
        -- self:OnInputFinished()
    end)
end

function CardController:HandleInputData(inputData)
    if inputData.inputType == Controller.InputType.UseCard then
        self:OnReceveUseInput(inputData.data)
    elseif inputData.inputType == Controller.InputType.MoveCard then
        self:OnReceveExchangeInput(inputData.data)
    elseif inputData.inputType == Controller.InputType.ResetInput then
        self:OnReceveResetInput()
    elseif inputData.inputType == Controller.InputType.Finish then
        if not BattleInfo:IsOnline() then
            self:OnInputFinished()
        end
    elseif inputData.inputType == Controller.InputType.Host then
        self:SetHosting(true)
    elseif inputData.inputType == Controller.InputType.CancelHost then
        self:SetHosting(false)
    end
end

function CardController:OnInputFinished( enterType )
    -- print("OnInputFinished", self.playerId)
    if not self:IsInputing() then
        return
    end

    -- if not BattleViewMgr.canInput and self.camp == Constants.TargetCamp.Friend then
    --     if enterType == nil then
    --         enterType = "nil"
    --     end
    --     printError('重复接收操作结束指令 enterType:'.. enterType)
    --     return
    -- end
    -- BattleViewMgr.canInput = false
    if BattleInfo:NeedSaveInput() then
        if BattleInfo:SaveInputWhenAllCampInputFinished() then
            --如果已经有finish，则不加了
            local hasFinish = table.isContain(self.inputQueue, nil, function (item)
                return item.inputType == Controller.InputType.Finish
            end)
            if not hasFinish then
                if not IsNull(BattleViewMgr) then
                    -- print("[InputFinished]", BattleViewMgr.nowTurn, BattleMgr.totalTurnCount)
                end
                -- self:AddInputQueue(Controller.InputType.Finish,  {camp = self.camp, turn = BattleViewMgr.nowTurn})
                self:AddInputQueue(Controller.InputType.Finish,  {camp = self.camp, turn = BattleMgr.totalTurnCount})
                for i,v in ipairs(self.inputQueue) do
                    RecordMgr:AddRecord(RecordMgr.PlayerInputRecord.New(self.camp, v))
                end
                self:ClearInputQueue()
            end
        else
            -- SaveInputRightNow
            -- 如果没有finish，加一个finish
            local hasFinish = table.isContain(self.inputQueue, nil, function (item)
                return item.inputType == Controller.InputType.Finish
            end)
            if not hasFinish then
                local inputData = self:GenerateInputData(Controller.InputType.Finish, {camp = self.camp, turn = BattleMgr.totalTurnCount})
                RecordMgr:AddRecord(RecordMgr.PlayerInputRecord.New(self.camp, inputData))
            end
        end
        
    end

    local skills, recs, unitCount = self.cardMgr:LocalEndRound()
    RecordMgr:AddRecords( recs )

    --只有玩家操作才需要跳过
    if BattleInfo:IsUserCamp(self.camp) then
        RecordMgr:DropAll()
    end
    self.cardMgr:UpdateMission(skills, recs)
    self.cardMgr:AddUltraPoint(recs)


    -- print(table.toString(skills,'skills'))
    -- print(table.toString(combos,'combos'))

    local _inputSkills = self.inputSkills
    local _inputCallback = self.inputCallback
    self.inputCallback = nil
    self.inputSkills = nil
    -- CS.UnityEngine.Profiling.Profiler.BeginSample("OnInputFinished")
    table.link(_inputSkills, self.AISkills)
    _inputCallback(self, unitCount + self.nowTurnPerUnitCount)
    -- CS.UnityEngine.Profiling.Profiler.EndSample()
    -- RecordMgr:DropAll()
    if BattleInfo:IsViewEnable() then
        Events.Broadcast(Constants.EventNames.BattleRecordShow)
    end
end

function CardController:OnReceveExchangeInput( data )
    -- BattleViewMgr:RestartLongIdle()
    if BattleInfo:NeedSaveInput() then
        if BattleInfo:SaveInputWhenAllCampInputFinished() then
            self:AddInputQueue(Controller.InputType.MoveCard, data)
        else
            -- SaveInputRightNow
            local inputData = self:GenerateInputData(Controller.InputType.MoveCard, data)
            RecordMgr:AddRecord(RecordMgr.PlayerInputRecord.New(self.camp, inputData))
        end
    end
    --交换
    --@RefType [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
    local cardMgr = self.cardMgr
    local recs = cardMgr:MoveCard(data.src, data.dst)

    local records = {}
    for i,v in ipairs(recs) do
        table.insert(records, v:ToData())
    end
    if BattleInfo:IsViewEnable() then
        RecordReader:ShowRecords(records)
    end

    -- --重置一下长待机镜头
    -- BattleViewMgr.ResetCamera(true)
end

function CardController:OnReceveUseInput( data )
    -- print("OnReceveUseInput", table.dump(data))
    local cardMgr = self.cardMgr
    local maxUseCount = cardMgr:GetSkillCardMaxUseCount()
    if cardMgr.usedSkillNum >= maxUseCount then
        return
    end

    if cardMgr:IsCatCard(data.pos)
    and not cardMgr:CanUseCatCard() then
        -- 如果使用的是猫卡，看猫卡是否可用
        return
    end

    if BattleInfo:NeedSaveInput() then
        if BattleInfo:SaveInputWhenAllCampInputFinished() then
            self:AddInputQueue(Controller.InputType.UseCard, data)
        else
            -- SaveInputRightNow
            local inputData = self:GenerateInputData(Controller.InputType.UseCard, data)
            RecordMgr:AddRecord(RecordMgr.PlayerInputRecord.New(self.camp, inputData))
        end
    end
    -- BattleViewMgr.ResetCamera(true)
    self:UseInput(cardMgr, data.pos, data.targetId, data.params)
end

--@cardMgr: [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
function CardController:UseInput(cardMgr, pos, targetId, params)
    local skillCardData, card = cardMgr:GetCardSkillByPos(pos)
    local role = Core:FindRole(card.roleId)

    if not targetId then
        if skillCardData.cardBehavior == Constants.CardBehavior.Choose and params and not Tools.isNullKey(params.skillIndex) then
            skillCardData = role:GetSkillCardDataByIndex(params.skillIndex)
        end
        local target = AI:ChooseSkillTarget(role, skillCardData)
        targetId = target.id
    end
 

    local card = cardMgr:GetCard(pos)
   
    local recs, skillData = cardMgr:UseCard(pos, targetId, params)
    if skillData then
        if self.inputSkills == nil then
            printError(role.typeId.."inputskills nil")
        end
        table.insert(self.inputSkills, skillData)
    end

    local records = {}
    for i,v in ipairs(recs) do
        table.insert(records, v:ToData())
    end
    -- pvp 敌人跳过出牌阶段的表现
    if not BattleInfo:IsPVE() and not BattleInfo:IsUserCamp(self.camp) then
    else
        if BattleInfo:IsViewEnable() then
            Events.Broadcast(Constants.EventNames.BattleRecordShow)     -- 先执行已经在队列里的战报
            RecordReader:ShowRecords(records)
        end
    end
end

function CardController:OnReceveResetInput(  )
    if BattleInfo:NeedSaveInput() then
        if BattleInfo:SaveInputWhenAllCampInputFinished() then
            -- 虽然立刻就会清理，但是这里也要添加输入，让seqId自增，保持和服务器id一致
            self:AddInputQueue(Controller.InputType.ResetInput, {})
            self:ClearInputQueue()
        else
            -- SaveInputRightNow
            -- 注意：目前的设计是，使用SaveInputRightNow的时候，不允许玩家使用reset按钮
        end
    end

    -- local AudioManager = CS.Engine.Wwise.AudioManager
    -- CS.AkSoundEngine.SetCurrentLanguage("Jpanese")
    -- AudioManager.Instance:LoadBank("Story1_0_a")
    -- AudioManager.Instance:PlaySFX("cat_meow_Play")

    -- AudioManager.Instance:UnloadBank("Story1_0_a")
    -- CS.AkSoundEngine.SetCurrentLanguage("Jpanese")


    -- BattleViewMgr:RestartLongIdle()

    --重置
    --@RefType [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
    -- print(table.toString('OnReceveResetInput'))
    local cardMgr = self.cardMgr
    cardMgr:Reset()
    for i,v in fipairs(self.inputSkills) do
        local role = Core:FindRole(v.roleId)
        if role and role.playerId == self.playerId then
            table.remove(self.inputSkills, i)
        end
    end

    -- BattleViewMgr.ResetCamera(true)

    -- cs_coroutine.start(function (  )
    --     BattleViewMgr:OnDestroy()
    --     coroutine.yield( WaitForSeconds(5) )


    --     BattleMgr = import('Game.Battle.Core.BattleMgr')
    --     BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    --     BattleViewMgr:Start()
    -- end)
   
end

function CardController:IsInputing()
    return self.inputCallback
end

function CardController:AutoUseOneCard()
    local pos, target, behaviorParams = AI:AIChooseSkillCard(self.cardMgr)
    if isNull(pos) then
        return
    end
    local targetId = target and target.id or 0
    self:OnReceveUseInput({pos=pos, targetId = targetId, params = behaviorParams})
end

function CardController:HostOneTurn()
    -- print("HostOneTurn", self.playerId)
    local roles = BattleMgr:GetAliveRolesWithoutSpecialSummon(self.camp)
    if #roles > 0 then
        -- 从阵营角色中，选出我自己的角色
        local myRoles = {}
        for i, v in ipairs(roles) do
            if v.playerId == self.playerId then
                table.insert(myRoles, v)
            end
        end
        if #myRoles > 0 then
            for i=self.cardMgr.usedSkillNum, #myRoles do
                self:AutoUseOneCard()
            end
        end
    end
    if not BattleInfo:IsOnline() then
        self:OnInputFinished(Constants.InputFinishType.AutoBattle)
    end
end
    
function CardController:OnTurnStart( camp )
    local isWaveEnd, isGameEnd, winCamp = BattleMgr:IsGameOver()
    if isGameEnd then
        return
    end
    if camp == self.camp then
        self.nowTurnPerUnitCount = 0
        -- print("totalTurnCount", BattleMgr.totalTurnCount)
        if BattleMgr.totalTurnCount == 1 then
            self.cardMgr:GameStartRound()
        else
            self.cardMgr:LocalStartRound()
        end

        local skills, recs, unitCount = self.cardMgr:LocalEndRound()
        RecordMgr:AddRecords( recs )
        -- self.cardMgr:UpdateMission(skills, recs)
        self.cardMgr:AddUltraPoint(recs)
        self.nowTurnPerUnitCount = unitCount


        --特殊召唤物行动决策
        local skills = self.monsterAi:GetAIAction(self.camp, true)
        self.AISkills = skills
        RecordMgr:AddRecord(RecordMgr.AIChooseSkillRecord.New(self.AISkills))
    end
end

function CardController:GetCardMgr(role)
    return self.cardMgr
end

function CardController:GetCardMgrByPlayerId(playerId)
    return self.cardMgr
end

function CardController:OnReceiveAutoUseSkillCat(playerId, auto)
    if self.playerId ~= playerId then
        return
    end
    self.cardMgr.autoUseCatCard = auto
end

return  CardController