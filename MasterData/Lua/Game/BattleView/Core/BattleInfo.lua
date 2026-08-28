
local BattleConfig = import("Game.Battle.Core.BattleConfig")
---@class BattleInfo
local BattleInfo = {}
BattleInfo = Class("BattleInfo")

BattleInfo.inputMode = nil
BattleInfo.playMode = nil
BattleInfo.gameMode = nil
--@RefType [Game.Setting.Vo.BattleRuleVo#BattleRuleVo]
BattleInfo.gameRule = nil
BattleInfo.isFirstCamp = nil
BattleInfo.firstCampNoBoss = nil    -- PVE模式下，先后手规则为高战力先手，但是没有boss的波次可以默认先手
BattleInfo.pvpMode = nil

BattleInfo.recordData = nil
BattleInfo.initData = nil
BattleInfo.isSimulator = false

BattleInfo.inputs = nil

BattleInfo.myCamp = nil
BattleInfo.otherCamp = nil

BattleInfo.campOnePlayerIds = nil
BattleInfo.campTwoPlayerIds = nil

function BattleInfo:__init(gameMode, playMode, pvpMode, inputMode, initData, recordData, firstCampNoBoss)
    self.inputMode = inputMode
    self.playMode = playMode
    self.gameMode = gameMode
    self.initData = initData
    self.recordData = recordData
    self.pvpMode = pvpMode
    self.firstCampNoBoss = firstCampNoBoss == nil and 1 or firstCampNoBoss

    print(table.toString(self.initData, "initData"))

  

    self:Refresh(initData)
    -- self.gameRule = {
    --     campPriority = Constants.CampPriority.UserFirst,
    --     skillCardSlotType = Constants.SkillCardSlotType.Camp,
    --     enemyAIType = Constants.AIType.Monster
    -- }

end

function BattleInfo:IsViewEnable()
    return self.inputMode ~= Constants.InputMode.ReplayNoLag and self.inputMode ~= Constants.InputMode.AutoNoLag
end

function BattleInfo:NeedSaveInput()
    return true
end

--- 需要保存输入数据进入战报时，在输入发生时立刻保存进战报
function BattleInfo:SaveInputRightNow()
    return self.gameMode == Constants.GameMode.OnlinePVE
end

--- 需要保存输入数据进入战报时，在双方输入都完成以后再保存进战报
function BattleInfo:SaveInputWhenAllCampInputFinished()
    return self.gameMode ~= Constants.GameMode.OnlinePVE
end

function BattleInfo:IsPVE()
    return self.gameMode == Constants.GameMode.PVE or self.gameMode == Constants.GameMode.OnlinePVE
end

function BattleInfo:IsOnline()
    return 
    BattleInfo.IsGameModeOnline(self.gameMode)
    and (self.inputMode ~= Constants.InputMode.ReplayNoLag 
        and self.inputMode ~= Constants.InputMode.AutoNoLag)
end

function BattleInfo.IsGameModeOnline(gameMode)
    return gameMode == Constants.GameMode.PVP or gameMode == Constants.GameMode.OnlinePVE
end

function BattleInfo:IsPVP()
    return self.gameMode == Constants.GameMode.PVP
end

function BattleInfo:IsUserCamp(camp)
    return camp == self.myCamp
end

function BattleInfo:IsMyPlayerId(playerId)
    return self.myPlayerId == playerId
end

--- 组队模式下，player是否是被邀请的（0：不是，1：是）(现在服务器会把房客的卡牌放在房主的卡牌前面)
function BattleInfo:IsInvited(playerId)
    if IsNull(self.campOnePlayerIds) 
    or (#self.campOnePlayerIds == 0)
    or (#self.campOnePlayerIds == 1) then
        return 0
    end
    if isNotNull(playerId) then
        return playerId == self.campOnePlayerIds[1] and 1 or 0
    else
        return self.myPlayerId == self.campOnePlayerIds[1] and 1 or 0
    end
end

--- 和玩家队伍对战
---@param questId any
---@param systemId any
function BattleInfo.BattleWithPlayerTeam(questId, systemId)
    questId = checkNumber(questId)
    systemId = checkNumber(systemId)
    
    if systemId == Constants.SystemToggleIds.Id2008 then
        return true
    end
    if questId == Constants.SpecialQuestId.LadderId
    or questId == Constants.SpecialQuestId.LadderStruggleId
    or questId == Constants.SpecialQuestId.LadderStruggleSingleId
    or questId == Constants.SpecialQuestId.Mirror then
        return true
    end
    return false
end

function BattleInfo:Refresh(initData)
    self.isSimulator = initData.isSimulator
    self.isFirstCamp = initData.first ~= 2

    local ruleId = initData.settingId or 1
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting577, "BattleRuleVo")
    self.gameRule = setting:Get(ruleId)

    if self.inputMode == Constants.InputMode.ReplayNoLag and self.recordData then
        local inputs = BattleInfo.GetInputFromRecord(self.recordData)
        self:ValidateInput(inputs, initData)
        self:SetInputs(inputs)
    end

    --找到所有playerId
    self.campOnePlayerIds = {}
    self.campTwoPlayerIds = {}

    for i,wave in ipairs(initData.playerTeam) do
        for j,roleData in ipairs(wave) do
            if roleData.playerId and not table.isContain(self.campOnePlayerIds, roleData.playerId) then
                table.insert(self.campOnePlayerIds, roleData.playerId)
            end
        end
    end
    for i,wave in ipairs(initData.enemyTeam) do
        for j,roleData in ipairs(wave) do
            if roleData.playerId and not table.isContain(self.campTwoPlayerIds, roleData.playerId) then
                table.insert(self.campTwoPlayerIds, roleData.playerId)
            end
        end
    end

    if #self.campOnePlayerIds <= 0 then
        self.campOnePlayerIds = {-1}
    end
    if #self.campTwoPlayerIds <= 0 then
        self.campTwoPlayerIds = {-2}
    end
    self.myPlayerId = initData.selfId or self.campOnePlayerIds[1]
    self.myPlayerId = checkInt(self.myPlayerId)
    self.myCamp = Constants.Camp.One
    self.otherCamp = Constants.Camp.Two
    for i,v in ipairs(self.campTwoPlayerIds) do
        if self.myPlayerId == v then
            self.myCamp = Constants.Camp.Two
            self.otherCamp = Constants.Camp.One
        end
    end
end

function BattleInfo:GetDefaultPlayerId(camp)
    return camp == Constants.Camp.One and self.campOnePlayerIds[1] or self.campTwoPlayerIds[1]
end

function BattleInfo:GetMyCampPlayerIds()
    return self.myCamp == Constants.Camp.One and self.campOnePlayerIds or self.campTwoPlayerIds
end

function BattleInfo.GetInitData(gameMode, outData)
    local d = nil
    local recData = nil
    local inputMode = Constants.InputMode.Normal
    local playMode = Constants.PlayMode.Battle
    local isSimulator = false

    if BattleInfo.IsGameModeOnline(gameMode) then
        local r = {}
        coroutine.yield( BattleViewMgr:GetOnlineBattleData(r) ) 
        d = r.data
        outData.onlineError = r.error
    else
        if FightPreWarMgr and FightPreWarMgr:GetInstance():GetFightData() then
            local json = FightPreWarMgr:GetInstance():GetFightData()
            d = json.battleData
        else
            local recordData = CS.Engine.Tools.PlayerPrefsUtility.GetEncryptedString("RecordData", '')
            local recordType = CS.Engine.Tools.PlayerPrefsUtility.GetEncryptedString("RecordType", '')
            local testData = CS.Engine.Tools.PlayerPrefsUtility.GetEncryptedString("TestData", '')
            if not string.isEmpty(testData) then
                -- print("TestData", testData)
                d = table.deserialize(testData)
                CS.Engine.Tools.PlayerPrefsUtility.SetEncryptedString("TestData", '')
            elseif not string.isEmpty(recordData) then
                local data = table.deserialize(recordData)
                d = data.initData
                recData = data.recordData
                -- print("recData", table.toString(recData, "recData"))
                if recordType == "InputOnly" then
                    inputMode = Constants.InputMode.Replay
                elseif recordType == "InputOnlyNoLag" then
                    inputMode = Constants.InputMode.ReplayNoLag
                else
                    playMode = Constants.PlayMode.Replay
                end
                CS.Engine.Tools.PlayerPrefsUtility.SetEncryptedString("RecordType", '')
                CS.Engine.Tools.PlayerPrefsUtility.SetEncryptedString("RecordData", '')
            else
                local json = '{"randomSeed":"5de9cdd7978db","playerTeam":[{"id":1,"cardId":101002,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"41101002=1","skill2":"42101002=1","skill3":"43101002=1","passiveLevel":"100004=1&100005=1"},{"id":10,"cardId":102004,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"41102004=1","skill2":"42102004=1","skill3":"43102004=1","passiveLevel":"100004=1&100005=1"},{"id":2,"cardId":102008,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"41102008=1","skill2":"42102008=1","skill3":"43102008=1","passiveLevel":"100004=1&100005=1"},{"id":3,"cardId":103008,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"41103008=1","skill2":"42103008=1","skill3":"43103008=1","passiveLevel":"100004=1&100005=1"}],"enemyTeam":[{"id":5,"enemyId":80011,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"51080011=1","skill2":"52080011=1","skill3":"53080011=1","passiveLevel":"100004=1&100005=1"},{"id":6,"enemyId":80011,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"51080011=1","skill2":"52080011=1","skill3":"53080011=1","passiveLevel":"100004=1&100005=1"}]}'
                d = table.deserialize(json)
            end
            isSimulator = true
        end
    end
    if not isNull(d) then
        d.isSimulator = isSimulator
    end
    BattleInfo.HandleInitData(d)
    outData.playMode = playMode
    outData.inputMode = inputMode
    outData.initData = d or {}
    outData.recordData = recData
end

function BattleInfo:ResetInitData(initData)
    self.HandleInitData(initData)
    self.initData = initData
    self:Refresh(initData)
end


function BattleInfo.HandleInitData(d)
    if isNull(d) then
        return 
    end
    -- d.mergeSkillId[1] = 0
    --去除已经死亡的怪
    d.enemyTeam.waveOriginNums = {}
    for p, wave in ipairs(d.enemyTeam) do
        d.enemyTeam.waveOriginNums[p] = #wave
        for i,data in fipairs(wave) do
            data.pos = i
            if data.currentHp and data.currentHp <= 0 then
                table.remove(wave, i)
            end
        end
    end
    for p, wave in ipairs(d.playerTeam) do
        --随机找一个人播放语音
        local num = math.random(#wave)
        if wave[num] then
            wave[num].enterVoice = true
        end
    end

    local treasures = {}
    if d.treasures then
        for i,v in ipairs(d.treasures) do
            for i=1,v.num do
                table.insert(treasures, v.quality)
            end
        end
    end
    local popMostValueableTreasure = function ()
        if #treasures > 0 then
            return table.remove(treasures)
        end
        return 0
    end

    --随机宝箱掉落
    local roleDatas = {}
    local findFinalBoss = false
    for p, wave in fipairs(d.enemyTeam) do
        for i,data in fipairs(wave) do
            if data.type == Constants.RoleClass.Boss and not findFinalBoss then
                data.treasureType = popMostValueableTreasure()
            else
                data.treasureType = 0
                table.insert(roleDatas, data)
            end
        end
    end

    while #roleDatas > 0 and #treasures > 0 do
        local index = math.random(1, #roleDatas)
        roleDatas[index].treasureType = popMostValueableTreasure()
        table.remove(roleDatas, index)
    end
end


function BattleInfo:Dispose()
    
end

function BattleInfo.GetInputFromRecord(records)
    local canStart = false
    local inputs = {}
    local oneTurnInputs = nil
    for i,record in ipairs(records) do
        if record.r == Constants.RecordType.TurnStart and record.c == Constants.Camp.One then
            oneTurnInputs = {}
        end
        if record.r == Constants.RecordType.PlayerInput then
            table.insert(oneTurnInputs, record.inputData)
        end
        if record.r == Constants.RecordType.InputFinished then
            table.insert(inputs, oneTurnInputs)
            oneTurnInputs = nil
        end
    end
    if oneTurnInputs then
        table.insert(inputs, oneTurnInputs)
    end
    return inputs
end

function BattleInfo:SetInputs(inputs)
    self.inputs = inputs
    if self.inputs and checkTable(self.inputs) then
        for i, input in ipairs(self.inputs) do
            input.used = false
        end
    end
end

function BattleInfo:GetNextInput(selectFunc)
    if self.inputs and checkTable(self.inputs) then
        for i, input in ipairs(self.inputs) do
            if not input.used and selectFunc(input) then
                input.used = true
                return input
            end
        end
    end
    return nil
end

function BattleInfo:ValidateInput(inputs, initData)
    local roleCountMap = self:GetRoleCount(initData)
    for i,oneTurnInputs in ipairs(inputs) do
        local turn = i
        local inputCountMap = {}
        for j,input in ipairs(oneTurnInputs) do
            if input.inputType == 1 then
                if isNull(inputCountMap[input.playerId]) then
                    inputCountMap[input.playerId] = 0
                end
                inputCountMap[input.playerId] = inputCountMap[input.playerId] + 1
            elseif input.inputType == 100 then
                
            end
        end
        for playerId, inputCount in pairs(inputCountMap) do
            local roleNum = roleCountMap[playerId]
            if inputCount > roleNum then
                print("[输入验证错误]", turn, playerId, table.dump(roleCountMap, nil, 3), table.dump(inputCountMap, nil, 3))
                printError(string.format("[输入验证错误] 输入数量大于角色数量  %d  %d", turn, playerId))
            end
        end
    end
end

function BattleInfo:GetRoleCount(initData, targetWave)
    if isNull(targetWave) then
        targetWave = 1
    end
    local roleCountMap = {}
    for i,wave in ipairs(initData.playerTeam) do
        if i == targetWave then
            for j,roleData in ipairs(wave) do
                if roleData.playerId then
                    if isNull(roleCountMap[roleData.playerId]) then
                        roleCountMap[roleData.playerId] = 0
                    end
                    roleCountMap[roleData.playerId] = roleCountMap[roleData.playerId] + 1
                end
            end
        end
    end
    for i,wave in ipairs(initData.enemyTeam) do
        if i == targetWave then
            for j,roleData in ipairs(wave) do
                if roleData.playerId then
                    if isNull(roleCountMap[roleData.playerId]) then
                        roleCountMap[roleData.playerId] = 0
                    end
                    roleCountMap[roleData.playerId] = roleCountMap[roleData.playerId] + 1
                end
            end
        end
    end
    return roleCountMap
end

return BattleInfo