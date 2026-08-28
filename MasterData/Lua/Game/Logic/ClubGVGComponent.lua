local import           = import

--region import
local ECSComponent    = import("Frame.ECS.ECSComponent")
local ClubGVGHomeDojo = import("Game.UI.Club.GVG.Dojo.ClubGVGHomeDojo")
local ClubGVGBuildingInfoDojo = import("Game.UI.Club.GVG.Dojo.ClubGVGBuildingInfoDojo")

--endregion

--region defines
local checkNumber = checkNumber
--endregion

---@class ClubGVGComponent : ECSComponent
local ClubGVGComponent = Class("ClubGVGComponent", ECSComponent)


function ClubGVGComponent:__init()
    ---@type ClubGVGHomeDojo
    self._dojo = ClubGVGHomeDojo.New()
    -- ---@type ClubGVGBuildingInfoDojo
    -- self._buildInfoDojo = ClubGVGBuildingInfoDojo.New()

    local playerId = checkNumber(GameUtils.GetPlayerId())
    self._playerId = playerId

    local clubComp         = ClubUtils.GetClubComp()
    ---@type ClubHomeDojo
    local homeDojo = clubComp:GetHomeDojo()
    -- self._gvgHost =  homeDojo.gvgHost
    self._clubId           = checkInt(homeDojo.clubId)

    ---@type table<number,  {id:number, t:number, pid:number, tid:number, bid:number, w:number, wHp:number}>
    self._playerId2AtkOverData = {}
    ---@type table<number, boolean>
    self._playerId2Die = {}

end


function ClubGVGComponent:__delete()

end

function ClubGVGComponent:Initial(accelerateCoolDown, battleCoolDown, buildingCoolDown)
    self._accelerateCoolDown = accelerateCoolDown
    self._battleCoolDown     = battleCoolDown
    self._buildingCoolDown   = buildingCoolDown

end

---@return ClubGVGHomeDojo
function ClubGVGComponent:GetDojo()
    return self._dojo
end

function ClubGVGComponent:InitialHome(data, curSeconds)
    self._dojo:Fill(data, curSeconds)
    
end

---更新玩家信息
---@param data {id:number, t:number, pid:number, playerInfo:table, r:number, rts:number}
function ClubGVGComponent:UpdatePlayerInfo(data)
    local playerId = checkNumber(data.pid)
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    local playerInfo = data.playerInfo
    dojo:AddPlayerInfo(playerId, playerInfo)
    local place = checkNumber(playerInfo.place)

    local buildingInfo = dojo.buildingInfo[place]
    local isSelfClub = checkNumber(buildingInfo.clubId) == self._clubId
    dojo:AddBuildingPlayerPlace(buildingInfo, playerId, isSelfClub)
    
    ---是玩家自己的话 将玩家位置设置成工会初始位置
    local isSelf = playerId == self._playerId
    if isSelf then
        dojo:UpdatePlayerPlace(place)
        dojo:UpdateRebirthCompleteData(data.rts, playerInfo.hp)
    end
    return isSelf
end

---UpdateMarch
---更新新军数据
---@param data {id:number, t:number, pid:number, pa:string, mt:number, tmt:number}
function ClubGVGComponent:UpdateMarch(data)
    local playerId = checkNumber(data.pid)
    local path     = data.pa
    ---添加玩家行军数据
    local endBuilding   = checkNumber(path[#path])
    local marchData = {
        playerId      = playerId,
        endTime       = checkNumber(data.mt),
        startBuilding = checkNumber(path[1]),
        endBuilding   = endBuilding,
        totalMarchingTime            = checkNumber(data.tmt),
    }

    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    dojo:UpdatePlayerPlaceByMarchData(marchData)

    local isSelf = playerId == self._playerId
    ---是玩家自己的话 将玩家位置更新到结束点 
    if isSelf then
        dojo:UpdatePlayerPlace(endBuilding)
        self:UpdateAutoAttack(false)
    end

    return marchData, isSelf
end

---@param marchData {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGComponent:UpdateMarchComplete(marchData)
    local dojo = self:GetDojo()
    dojo:ClearMarchInfo(marchData.playerId)
    return marchData.playerId == self._playerId
end

---UpdateMarchAccelerate
---更新行军加速
---@param data        {id:number, t:number, pid:number, cd:number, mt:number}
---@return number | nil
---@return table
---@return number
function ClubGVGComponent:UpdateMarchAccelerate(data)
    local playerId     = checkNumber(data.pid)    
    local marchEndTime = checkNumber(data.mt)    
    ---加速会出现小数点 这里向上取整
    marchEndTime = math.ceil(marchEndTime)

    ---更新行军结束时间
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    local oldMarchEndTime, marchData = dojo:UpdateMarchEndTime(playerId, marchEndTime)

    local accelerateCdEndTime
    ---添加加速限制结束时间
    if playerId == self._playerId then
        accelerateCdEndTime = dojo:SetAccelerateCdEndTimeByCD(data.cd)
    end

    return oldMarchEndTime, marchData, accelerateCdEndTime
end

---更新行军加速完成数据
function ClubGVGComponent:UpdateAccelerateCompleteData()
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    dojo:ClearAccelerateCdEndTime()

end

--- 更新进攻建筑相关数据
---@param data {id:number, t:number, pid:number, bid:number, hp:number, et:number, wHp:number}
function ClubGVGComponent:UpdateBuildingAtkData(data)
    local playerId        = checkNumber(data.pid)   
    ---@type ClubGVGHomeDojo
    local dojo   = self:GetDojo()
    local attackCDEndTime        = checkNumber(data.et)
    -- if attackCDEndTime == 0 then
    --     attackCDEndTime = os.time() + self._buildingCoolDown
    -- end
    local isSelf         = playerId == self._playerId
    if isSelf then
        dojo:SetAttackCDEndTime(attackCDEndTime)
        
    end
    dojo:UpdateHP(playerId, data.wHp, isSelf)

    dojo:UpdateBuildInfoByAtBuilding(data, attackCDEndTime)

    return attackCDEndTime, isSelf
end

--- 更新进攻建筑完成相关数据
---@param data {id:number, t:number, pid:number, bid:number, hp:number, et:number, wHp:number}
function ClubGVGComponent:UpdateBuildingAtkCompleteData(data)
    local playerId        = checkNumber(data.pid)   
    ---@type ClubGVGHomeDojo
    local dojo   = self:GetDojo()
    local attackCDEndTime        = checkNumber(data.et)
    local isSelf         = playerId == self._playerId
    if isSelf then
        dojo:SetAttackCDEndTime(0)
        
    end
    ---清理建筑物战斗信息
    dojo:ClearFightInfo(data.bid, playerId)

    -- dojo:UpdateHP(playerId, data.wHp)

    ---处理玩家死亡
    local place = self:HandlePlayerDie(playerId)
    return place
end

---@param data {id:number, t:number, bid:number, cid:number, hp:number}   
function ClubGVGComponent:UpdateBuildingChange(data)
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    dojo:UpdateBuildInfoByBuildingChange(data, self._clubId)

end

---@param data {id:number, t:number, pid:number, tid:number, bid:number, et:number}
function ClubGVGComponent:UpdatePlayerAtkData(data)
    local playerId     = checkNumber(data.pid)
    local targetId     = checkNumber(data.tid)

    local isFindSelf   = playerId == self._playerId or targetId == self._playerId

    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    dojo:UpdateBuildInfoByAtPlayer(data)

    local attackCDEndTime = checkNumber(data.et)
    local bannerData
    if isFindSelf then
        -- attackCDEndTime = checkNumber(data.et)
        dojo:SetAttackCDEndTime(attackCDEndTime)
        
        bannerData = {playerId = playerId, loseId = targetId}
    end

    return attackCDEndTime, bannerData

end

---@param data {id:number, t:number, pid:number, tid:number, bid:number, w:number, wHp:number}
function ClubGVGComponent:UpdatePlayerAtkOver(data)
    self._playerId2AtkOverData[checkNumber(data.pid)] = data

end

---@param data {id:number, t:number, pid:number, tid:number, bid:number, et:number}
function ClubGVGComponent:UpdatePlayerAtkCompleteData(data)
    -- print("UpdatePlayerAtkCompleteData")
    local playerId     = checkNumber(data.pid)
    local targetId     = checkNumber(data.tid)
    local isFindSelf   = playerId == self._playerId or targetId == self._playerId

    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    -- local attackCDEndTime = checkNumber(data.et)
    if isFindSelf then
        dojo:SetAttackCDEndTime(0)
        
    end

    local isSelfDie = false
    local buildingId = checkNumber(data.bid)

    dojo:ClearFightInfo(buildingId, playerId)
    dojo:ClearFightInfo(buildingId, targetId)

    local bannerData

    local atkOverData = self._playerId2AtkOverData[playerId] or self._playerId2AtkOverData[targetId]
    if atkOverData then
        local atkRes = checkNumber(atkOverData.w)
        local winnerPlayerId = atkRes == 1 and playerId or targetId
        dojo:UpdateHP(winnerPlayerId, atkOverData.wHp, winnerPlayerId == self._playerId)
        local losePlayerId = atkRes == 0 and playerId or targetId
        dojo:UpdateHP(losePlayerId, 0, losePlayerId == self._playerId)

        isSelfDie = isFindSelf and losePlayerId == self._playerId
        if isSelfDie then
            dojo:UpdateSelfDie()
        -- else
        --     dojo:RemoveBuildingPlayerPlace(losePlayerId, buildingId)
        end

        if isFindSelf then
            bannerData = {playerId = winnerPlayerId, loseId = losePlayerId}
        end
    end

    -- print("self._playerId2Die", table.toString(self._playerId2Die))
    ---两个人可能都会死亡 胜利者hp可能会到0
    local place1 = self:HandlePlayerDie(playerId)
    local place2 = self:HandlePlayerDie(targetId)

    self._playerId2AtkOverData[playerId] = nil
    self._playerId2AtkOverData[targetId] = nil

    return isSelfDie, bannerData, {place1, place2}
end

---更新玩家死亡状态
---@param isClubDie boolean 是否工会死亡
---@param playerId number 玩家id
---@param rebirthTime number 到什么时间能够复活
function ClubGVGComponent:UpdatePlayerDie(isClubDie, playerId, rebirthTime, isCommitSuicide)

    -- if self._playerId2AtkOverData[playerId] then
    --     self._playerId2Die[checkNumber(playerId)] = true
    --     return
    -- end

    local dojo = self:GetDojo()
    local isSelf = playerId == self._playerId
    local place
    if isClubDie or isCommitSuicide then
        if isSelf then
            if isClubDie then
                dojo:SetClubIsDie(1)
            else
                dojo:UpdateRebirthTime(rebirthTime)
            end
            dojo:UpdateSelfDie()
        end
        place = dojo:ClearPlayerStatus(playerId)

    else
        isSelf = playerId == self._playerId

        local isBatting = self:CheckPlayerIsBattling(playerId)
        if isSelf then
            -- print()
            dojo:UpdateRebirthTime(rebirthTime)
        end
        if isBatting then
            self._playerId2Die[checkNumber(playerId)] = true
            
        else
            if isSelf then
                dojo:UpdateSelfDie()
            end
            place = dojo:ClearPlayerStatus(playerId)

        end

    end
    return isSelf, place


end

---处理玩家死亡
function ClubGVGComponent:HandlePlayerDie(playerId)
    if not self._playerId2Die[playerId] then
        return
    end
    local dojo = self:GetDojo()
    local place = dojo:ClearPlayerStatus(playerId)
    self._playerId2Die[playerId] = nil
    return place
end

---@param data {buildingId:number, attackPlayerId:number, defencePlayerId:number}
function ClubGVGComponent:UpdateAtkCompleteData(data)
    local buildingId = data.buildingId
    local attackPlayerId, defencePlayerId = checkNumber(data.attackPlayerId), checkNumber(data.defencePlayerId)
    local isBuilding = defencePlayerId == 0

    ---清理建筑物内的战斗信息
    local dojo = self:GetDojo()
    dojo:ClearFightInfo(buildingId, attackPlayerId)
    self:CheckDieAndAddBuildingAtkOrDefInfo(attackPlayerId)

    if not isBuilding then
        dojo:ClearFightInfo(buildingId, defencePlayerId)
        self:CheckDieAndAddBuildingAtkOrDefInfo(defencePlayerId)
    end

    
end

function ClubGVGComponent:UpdateRebirthCompleteData()
    local dojo = self:GetDojo()
    
end

function ClubGVGComponent:CheckDieAndAddBuildingAtkOrDefInfo(playerId, buildingId)
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    local playerInfo = dojo.playerInfo
    local playerData = playerInfo[playerId]
    if checkNumber(playerData.hp) <= 0 then 
        dojo:RemoveBuildingPlayerPlace(playerId, buildingId)
        
    end
end

---检查玩家是否在战斗中
---@param playerId number
---@return boolean 是否在战斗中
function ClubGVGComponent:CheckPlayerIsBattling(playerId)
    local dojo = self:GetDojo()
    ---获取玩家数据
    local playerData = dojo.playerInfo[playerId]
    if playerData == nil then
        return false
    end
    
    ---获取玩家所在建筑数据
    local place = checkNumber(playerData.place)
    local buildingData  = dojo.buildingInfo[place]
    if buildingData == nil then
        return false
    end

    ---通过战斗队列判断当前玩家是否在战斗中
    local fightingInfo = buildingData.fightingInfo
    for key, value in pairs(fightingInfo) do
        local isFindSelf = playerId == checkNumber(value.attackPlayerId) or playerId == checkNumber(value.defencePlayerId)
        if isFindSelf then
            return true
        end
    end
    return false
end

function ClubGVGComponent:SetRebirthTimes(times)
    self._dojo.leftRebirthTimes = checkNumber(times)
end

---更新玩家连胜次数
function ClubGVGComponent:UpdatePlayerWinningStreak(playerId, times)
    self._dojo:UpdateWinningStreak(playerId, times)
    
end

-- ---UpdateRebirth
-- ---更新复活后的数据
-- ---@param data { hp: number }
-- function ClubGVGComponent:UpdateRebirth(data)
--     ---@type ClubGVGHomeDojo
--     local dojo              = self._dojo
--     dojo.leftRebirthTimes   = dojo.leftRebirthTimes - 1
--     -- dojo.leftRebirthSeconds = 0
--     dojo.hp                 = checkNumber(data.hp, 0)

-- end

---UpdateAutoAttack
---更新自动战斗
---@param isOpen boolean
function ClubGVGComponent:UpdateAutoAttack(isOpen)
    ---@type ClubGVGHomeDojo
    local dojo = self._dojo
    dojo.autoAttack = isOpen
    return isOpen
end

---@param taskTips number 服务器-1为不显示  0为显示  大于0为秒数之后显示
function ClubGVGComponent:UpdateTaskTips(taskTips)
    ---@type ClubGVGHomeDojo
    local dojo            = self._dojo
    dojo.taskTips = taskTips
    
end


-- function ClubGVGComponent:InitialBuildingInfo(data)
--     self._buildInfoDojo:Fill(data)
-- end


---@param stage ClubGVGConstants.Stage
function ClubGVGComponent:UpdateStage(stage, stageEndSeconds)
    ---@type ClubGVGHomeDojo
    local dojo            = self._dojo
    dojo.stage            = stage
    dojo.stageEndSeconds  = stageEndSeconds
end

function ClubGVGComponent:GetMarchInfoById(playerId)
    ---@type ClubGVGHomeDojo
    local dojo            = self._dojo
    return dojo.marchInfo[playerId]
end

function ClubGVGComponent:GetMarchSecondsById(playerId)
    local marchInfo = self:GetMarchInfoById(playerId)
    if marchInfo == nil then return end
    return checkNumber(marchInfo.endTime)
end

function ClubGVGComponent:Clear()
    self:UpdateAutoAttack(false)
end


return ClubGVGComponent
