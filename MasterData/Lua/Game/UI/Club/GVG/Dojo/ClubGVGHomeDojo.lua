--region import
local haskey      = table.haskey
local type        = type
local isSet       = isSet
local checkTable  = checkTable
local checkNumber = checkNumber

-- local PriorityQueue        = import("Game.Utils.PriorityQueue")
--endregion

--region defines

--endregion

---@class ClubGVGHomeDojo
local ClubGVGHomeDojo = Class('ClubGVGHomeDojo')


function ClubGVGHomeDojo:__init()
    --- gvg所属阶段(0:未开启 1:报名 2:战前准备 3: 战斗中 4: 结算)
    self.stage = 0 
    ---开始时间
    self.gvgStartTime = 0
    ---结束时间
    self.gvgEndTime = 0
    --- gvg所属阶段结束时间
    self.stageEndSeconds = 0
    --- 玩家所在位置
    self.playerPlace = 0 
    --- 玩家所在位置
    self.clubPlace = 0
    --- 剩余重生次数
    self.leftRebirthTimes = 0 
    --- 剩余重生秒数
    -- self.leftRebirthSeconds = 0 
    --- 到什么时间重生
    self.rebirthTime = 0
    --- 精力
    self.hp = 0
    --- 工会基地是否死亡
    self.clubIsDie = 0
    --- 社团信息
    self.clubInfo = {}
    ---加速冷却剩余秒数
    self.accelerateCD = 0
    ---攻城冷却剩余秒数
    self.attachBuildingCD = 0
    --- 所有建筑物信息
    ---@type table<number, {buildingId:number, type:number, clubId:number, shield:number, leftHp:number, playerIds:table, defensePlayerIds:table, attackPlayerIds:table, fightingInfo:table<number, {questEndTime:number, attackPlayerId:number, defencePlayerId:number}>}>
    self.buildingInfo = {}
    --- 行军
    ---@type table<number, {playerId:number, endTime:number, startBuilding:number, endBuilding:number}>
    self.marchInfo = {}
    --- 参赛所有玩家基础信息
    ---@type table<number, {place:number, playerId:number, name:string, level:number, avatar:number, avatarFrame:number, successiveVictoryTimes:number, hp:number, clubId:number, team:table}>
    self.playerInfo = {}

    --- 进攻cd结束时间
    self.attackCDEndTime = 0

    --- 玩家所在分组
    self.group = 0

    self.newReportId = 0

    self.taskTips = -1
    
    --- 加速cd结束时间
    self.accelerateCDEndTime = 0

    ---建筑物地点->加速结束时间 玩家自己
    self.place2CDEndTime = {}
    self.autoAttack = false


    -- local clubComp         = ClubUtils.GetClubComp()
    -- self._clubId           = checkInt(clubComp:GetHomeDojo().clubId)
    -- self._playerId         = checkNumber(GameUtils.GetPlayerId())
end


function ClubGVGHomeDojo:__delete()
    
end

local FixTable = function(t)
    t = checkTable(t)
    local newT = {}
    for key, value in pairs(t) do
        newT[checkNumber(key)] = value
    end
    return newT
end


---Fill
---填充数据
---@param jsonData {stage: number, stageLeftSeconds: number, playerPlace: number, leftRebirthTimes: number, accelerateCD: number, playerInfo: table}
function ClubGVGHomeDojo:Fill(jsonData, curSeconds)
    for key, value in pairs(jsonData) do
        if isSet(jsonData,key) and haskey(self,key) then
            local filedType = type(self[key])
            if filedType == "table" then
                self[key] = FixTable(value)
            elseif filedType == "number" then
                self[key] = checkNumber(value)
            else
                self[key] = value
            end
            
        end
    end    

    curSeconds = curSeconds or GameUtils.GetServerTime()
    local ToTimeStamp =  GameUtils.ToTimeStamp
    if haskey(jsonData, "gvgStartTime")then
        self.gvgStartTime = ToTimeStamp(self.gvgStartTime, curSeconds)
    end

    if haskey(jsonData, "gvgEndTime")then
        self.gvgEndTime = ToTimeStamp(self.gvgEndTime, curSeconds)
    end

    if haskey(jsonData, "accelerateCD")then
        self:SetAccelerateCdEndTimeByCD(self.accelerateCD, curSeconds)
    end

    if haskey(jsonData, "attachBuildingCD") then
        self:SetAttackCDEndTimeByCD(self.attachBuildingCD, curSeconds)
    end

    if haskey(jsonData, "buildingInfo")then
        self:GenerateBuildAtkAndDefPlayerIds()
    end

    return self
end

function ClubGVGHomeDojo:SetStage(stage, stageEndSeconds)
    self.stage = stage
    self.stageEndSeconds = stageEndSeconds
end

function ClubGVGHomeDojo:SetAttackCDEndTimeByCD(cd, curSeconds)
    curSeconds = curSeconds or GameUtils.GetServerTime()
    local endTime = checkNumber(cd) + curSeconds
    return self:SetAttackCDEndTime(endTime)
end

function ClubGVGHomeDojo:SetAttackCDEndTime(endTime)
    self.attackCDEndTime = endTime
    return self.attackCDEndTime
end

function ClubGVGHomeDojo:SetAccelerateCdEndTimeByCD(cd, curSeconds)
    curSeconds = curSeconds or GameUtils.GetServerTime()
    self.accelerateCDEndTime = checkNumber(cd) + curSeconds
    return self.accelerateCDEndTime
end

function ClubGVGHomeDojo:ClearAccelerateCdEndTime()
    self.accelerateCDEndTime = 0
end

function ClubGVGHomeDojo:GenerateBuildAtkAndDefPlayerIds()
    local buildingInfo = self.buildingInfo
    local playerId2PlayerInfo = self.playerInfo
    -- print(table.serialize(playerId2PlayerInfo))
    for buildingId, buildingData in pairs(buildingInfo) do
        self:GenerateBuildAtkAndDefPlayerIdsByBuildData(buildingData, playerId2PlayerInfo)
    end

end

----@param buildingData {buildingId:number, type:number, clubId:number, shield:number, leftHp:number, playerIds:table, defensePlayerIds:table, attackPlayerIds:table, fightingInfo:{questEndTime:number, attackPlayerId:number, defencePlayerId:number}
---@param playerId2PlayerInfo table<number, {place:number, playerId:number, name:string, level:number, avatar:number, avatarFrame:number, successiveVictoryTimes:number, hp:number, clubId:number, team:table}>
function ClubGVGHomeDojo:GenerateBuildAtkAndDefPlayerIdsByBuildData(buildingData, playerId2PlayerInfo)
    -- 进攻和防守队列根据该建筑物的归属判断，比如ABC社团同时在属于A社团占领的建筑中，
    -- A社团成员头像显示在【防守队列】，BC社团成员显示在【进攻队列】

    local clubId           = checkNumber(buildingData.clubId)
    local attackPlayerIds  = {}
    local defensePlayerIds = {}
    local playerIds        = checkTable(buildingData.playerIds)
    for key, playerId in pairs(playerIds) do
        local playerId = checkNumber(playerId)
        ---@type {playerId:number, name:string, level:number, avatar:number, avatarFrame:number, successiveVictoryTimes:number, hp:number, clubId:number, team:table}
        local playerInfo = playerId2PlayerInfo[playerId]
        if playerInfo then
            local playerClubId     = checkNumber(playerInfo.clubId)
            if playerClubId == clubId then
                table.insert(defensePlayerIds, playerId)
            else
                table.insert(attackPlayerIds, playerId)
            end
        end

    end
    
    buildingData.defensePlayerIds = defensePlayerIds
    buildingData.attackPlayerIds = attackPlayerIds

end

function ClubGVGHomeDojo:AddPlayerInfo(playerId, playerInfo)
    self.playerInfo[playerId] = playerInfo
end

function ClubGVGHomeDojo:AddMarchData(playerId, marchData)
    self.marchInfo[playerId] = marchData

end

function ClubGVGHomeDojo:UpdatePlayerPlace(buildingId)
    self.playerPlace = buildingId
end

---根据行军数据更新建筑中的玩家位置
---@param marchData {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGHomeDojo:UpdatePlayerPlaceByMarchData(marchData)
    local playerId = marchData.playerId

    self:AddMarchData(playerId, marchData)

    ---将玩家移动到行军完成后的建筑中
    local playerData = self.playerInfo[playerId]
    local oldPlayerPlace
    if playerData then
        oldPlayerPlace = playerData.place
        playerData.place = marchData.endBuilding
    end

    self:RemoveBuildingPlayerPlace(playerId, marchData.startBuilding)

    local endBuildingInfo = self.buildingInfo[marchData.endBuilding]
    local isSelfClub = checkNumber(playerData.clubId) == checkNumber(endBuildingInfo.clubId)
    self:AddBuildingPlayerPlace(endBuildingInfo, playerId, isSelfClub)
    
end

local RemoveId = function(t, id)
    local count = #t
    for i = count, 1, -1 do
        if checkNumber(t[i]) == id then
            table.remove(t, i)
            break
        end
    end
end

function ClubGVGHomeDojo:RemoveBuildingPlayerPlace(playerId, buildingId)
    local buildingInfo = self.buildingInfo[checkNumber(buildingId)]
   if buildingInfo == nil then return end
   
   playerId = checkNumber(playerId)
   RemoveId(buildingInfo.defensePlayerIds, playerId)
   RemoveId(buildingInfo.attackPlayerIds, playerId)
   RemoveId(buildingInfo.playerIds, playerId)


end

function ClubGVGHomeDojo:AddBuildingPlayerPlace(buildingInfo, playerId, isSelfClub)
    if buildingInfo == nil then return end

    local playerIds = isSelfClub and buildingInfo.defensePlayerIds or buildingInfo.attackPlayerIds
    table.insert(playerIds, playerId)
    table.insert(buildingInfo.playerIds, playerId)

end

---@return number
---@return table
function ClubGVGHomeDojo:UpdateMarchEndTime(playerId, marchEndTime)
    local marchData = self.marchInfo[playerId]
    if self.marchInfo[playerId] == nil then return 0 end
    local oldMarchEndTime = marchData.endTime
    marchData.endTime = marchEndTime
    return oldMarchEndTime, marchData
end

---通过攻城数据更新建筑物数据
---@param data {id:number, t:number, pid:number, bid:number, hp:number, et:number}
function ClubGVGHomeDojo:UpdateBuildInfoByAtBuilding(data, attackCDEndTime)
    ---@type {leftHp:number, shield:number, fightingInfo:table}
    local info = self.buildingInfo[checkNumber(data.bid)]
    if info == nil then return end
    info.leftHp = checkNumber(data.hp)
    info.shield = checkNumber(data.sld)

    --- 检查是否存在原有数据
    local pid = checkNumber(data.pid)
    local fightingInfo = checkTable(info.fightingInfo)
    local fightingInfoData
    for index, value in ipairs(fightingInfo) do
        if value.attackPlayerId == pid then
            fightingInfoData = value
            break
        end
    end
    if fightingInfoData and fightingInfoData.defencePlayerId == nil then
        fightingInfoData.questEndTime = attackCDEndTime
    else
        table.insert(fightingInfo, {
            questEndTime = attackCDEndTime,
            attackPlayerId = pid
        })
    end
    
end


---@param data {id:number, t:number, bid:number, cid:number, hp:number}   
function ClubGVGHomeDojo:UpdateBuildInfoByBuildingChange(data, clubId)
    local info = self.buildingInfo[checkNumber(data.bid)]
    if info == nil then return end
    info.clubId = checkNumber(data.cid)
    if data.hp then
        info.leftHp = checkNumber(data.hp)
    end
    info.shield = checkNumber(data.sld)

    --- 重新生成下进攻防守数据 
    self:GenerateBuildAtkAndDefPlayerIdsByBuildData(info, self.playerInfo)

    return info
end

---@param data {id:number, t:number, pid:number, tid:number, bid:number, et:number}
function ClubGVGHomeDojo:UpdateBuildInfoByAtPlayer(data)
    ---@type {leftHp:number, shield:number, fightingInfo:table}
    local info = self.buildingInfo[checkNumber(data.bid)]
    if info == nil then return end
    local playerId     = checkNumber(data.pid)
    local targetId     = checkNumber(data.tid)

    local fightingInfo = checkTable(info.fightingInfo)
    table.insert(fightingInfo, {
        questEndTime    = checkNumber(data.et),
        attackPlayerId  = playerId,
        defencePlayerId = targetId,
    })

end

function ClubGVGHomeDojo:UpdateHP(playerId, hp, isSelf)
    local hp = checkNumber(hp)
    if isSelf then
        self:UpdateSelfHp(hp)
    end
    local playerData = self.playerInfo[checkNumber(playerId)]
    if playerData == nil then
        return
    end
    playerData.hp = hp
    
end

function ClubGVGHomeDojo:UpdateWinningStreak(playerId, times)
    local playerData = self.playerInfo[checkNumber(playerId)]
    if playerData == nil then
        return
    end
    playerData.successiveVictoryTimes = checkNumber(times)

end

function ClubGVGHomeDojo:SetClubIsDie(clubIsDie)
    self.clubIsDie = clubIsDie
    
end

function ClubGVGHomeDojo:ClearPlayerStatus(playerId)
    self:ClearMarchInfo(playerId)
    local place = self:ClearPlayerInfo(playerId)
    self:RemoveBuildingPlayerPlace(playerId, place)
    return place
end

function ClubGVGHomeDojo:ClearMarchInfo(playerId)
    local marchData = self.marchInfo[checkNumber(playerId)]
    if marchData == nil then return end
    self.marchInfo[playerId] = nil
    
end

function ClubGVGHomeDojo:ClearPlayerInfo(playerId)
    local playerData = self.playerInfo[checkNumber(playerId)]
    if playerData == nil then return end
    local oldPlace = playerData.place
    playerData.hp = 0
    playerData.place = nil
    playerData.successiveVictoryTimes = 0
    return oldPlace
end


function ClubGVGHomeDojo:ClearFightInfo(buildingId, playerId)
    local info = self.buildingInfo[checkNumber(buildingId)]
    if info == nil then return end
    playerId = checkNumber(playerId)
    local fightingInfo = info.fightingInfo
    local len = #fightingInfo
    for i = len, 1, -1 do
        local data = fightingInfo[i]
        if data.attackPlayerId == playerId or data.defencePlayerId == playerId then
            table.remove(fightingInfo, i)
        end
    end
        
end

function ClubGVGHomeDojo:UpdateRebirthTime(rebirthTime)
    self.rebirthTime = checkNumber(rebirthTime)
    -- self.hp = 0
    -- self.playerPlace = 0
    
end
function ClubGVGHomeDojo:UpdateSelfDie()
    self:UpdateSelfHp(0)
    self.playerPlace = 0
    
end
function ClubGVGHomeDojo:UpdateSelfHp(hp)
    self.hp = checkNumber(hp)
    
end

function ClubGVGHomeDojo:UpdateRebirthCompleteData(leftRebirthTimes, hp)
    self.leftRebirthTimes = checkNumber(leftRebirthTimes)
    self:UpdateSelfHp(hp)
end

function ClubGVGHomeDojo:UpdateReportUUID(id)
    self.newReportId = id
    
end

return ClubGVGHomeDojo
