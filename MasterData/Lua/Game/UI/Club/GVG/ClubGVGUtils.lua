local import               = import
--region import
local ClubGVGMgr           = import('Game.UI.Club.GVG.ClubGVGMgr')
---@type ClubGVGConstants
local ClubGVGConstants     = import('Game.UI.Club.GVG.ClubGVGConstants')
local PriorityQueue        = import("Game.Utils.PriorityQueue")

local TileFlags = CS.UnityEngine.Tilemaps.TileFlags
--endregion

--region defines
local ClubGVGParamsVo               = "ClubGVG.ClubGVGParamsVo"
local ClubGVGBuildingVo             = "ClubGVG.ClubGVGBuildingVo"
local ClubGVGEnergyVo               = "ClubGVG.ClubGVGEnergyVo"
local ClubGVGPlayerRankRewardVo     = "ClubGVG.ClubGVGPlayerRankRewardVo"
local ClubGVGClubRankRewardVo       = "ClubGVG.ClubGVGClubRankRewardVo"
local ClubGVGTileColorVo            = "ClubGVG.ClubGVGTileColorVo"

local TileFlagsNone = TileFlags.None
--endregion


---@class ClubGVGUtils
local ClubGVGUtils = {}


---@type table<ClubGVGConstants.ParamsId, integer>
ClubGVGUtils.paramValueMap_ = {}


---@type ClubGVGConstants
ClubGVGUtils.Constants = ClubGVGConstants


-------------------------------------------------------------------------------
-- about conf
-------------------------------------------------------------------------------

--- 根据参数id 获取 社团参数表
---@param paramId ClubGVGConstants.ParamsId @ 社团GVG参数表id
---@return ClubGVGParamsVo
function ClubGVGUtils.GetParamVo(paramId)
    return CfUtils.GetCfVo(AutoIds.IdSetting5100, ClubGVGParamsVo, paramId) or {}
end


--- 通过id 获取 社团GVG建筑表
---@param id number 任务id
---@return ClubGVGBuildingVo
function ClubGVGUtils.GetBuildingVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting5101, ClubGVGBuildingVo, id)
end

--- 通过id 获取 社团GVG精力与属性表
---@param id number 
---@return ClubGVGEnergyVo
function ClubGVGUtils.GetEnergyVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting5102, ClubGVGEnergyVo, id)
end

--- 获取 所有的社团GVG精力与属性表
---@return ClubGVGEnergyVo[]
function ClubGVGUtils.GetAllEnergyVos()
    return CfUtils.GetCf(AutoIds.IdSetting5102, ClubGVGEnergyVo, true)
end

--- 获取 所有 社团GVG个人积分排名奖励表
---@return ClubGVGPlayerRankRewardVo[]
function ClubGVGUtils.GetPlayerRankRewardVos()
    return CfUtils.GetCf(AutoIds.IdSetting5103, ClubGVGPlayerRankRewardVo, true)
end

--- 获取 所有 社团GVG排行榜奖励表
---@return ClubGVGClubRankRewardVo[]
function ClubGVGUtils.GetClubRankRewardVos()
    return CfUtils.GetCf(AutoIds.IdSetting5104, ClubGVGClubRankRewardVo, true)
end

-- --- 获取 所有 社团GVG地块颜色表
-- ---@return ClubGVGTileColorVo[]
-- function ClubGVGUtils.GetClubGVGTileColorVos()
--     return CfUtils.GetCf(AutoIds.IdSetting5105, ClubGVGTileColorVo, true)
-- end

--- 获取 社团GVG地块颜色表
---@return ClubGVGTileColorVo
function ClubGVGUtils.GetClubGVGTileColorVo(id)
    -- return CfUtils.GetCf(AutoIds.IdSetting5105, ClubGVGTileColorVo, true)
    return CfUtils.GetCfVo(AutoIds.IdSetting5105, ClubGVGTileColorVo, id)
end


--- 获取 社团GVG参数表 对应id数值
---@param paramsId ClubGVGConstants.ParamsId @ 社团GVG参数表id
---@return number
function ClubGVGUtils.GetParamValue(paramId)
    local paramValue = ClubGVGUtils.paramValueMap_[paramId]
    if not paramValue then
        local paramVo = ClubGVGUtils.GetParamVo(paramId)

        if (paramId == ClubGVGUtils.Constants.ParamsId.ApplyStartSeconds or 
            paramId == ClubGVGUtils.Constants.ParamsId.BattleStartSeconds) then
            local times = string.split2(paramVo.paramNum, ':')
            paramValue  = checkInt(times[1]) * 3600 + checkInt(times[2]) * 60

        elseif paramId == ClubGVGUtils.Constants.ParamsId.OpeningDayNum then
            paramValue = (checkNumber(paramVo.paramNum) - 1) * 86400  -- (1就是活动第一天，也就是活动当天的意思，所以运算的话需要-1用)

        else
            paramValue = checkNumber(paramVo.paramNum)
        end
        ClubGVGUtils.paramValueMap_[paramId] = paramValue
    end
    return paramValue
end


--- 获取 社团GVG参数表 对应id描述
---@param paramId ClubGVGConstants.ParamsId @ 社团GVG参数表id
---@return string
function ClubGVGUtils.GetParamDescr(paramId)
    local paramVo = ClubGVGUtils.GetParamVo(paramId)
    return tostring(paramVo.paramTxt)
end



-------------------------------------------------------------------------------
-- about short
-------------------------------------------------------------------------------

function ClubGVGUtils.CheckIsCanEnterGVG()
    local playerDojo = GameUtils.GetPlayerDojo()
    local forceUpdateUrl = playerDojo.gvgUpdateUrl
    if not string.isEmpty(forceUpdateUrl) then
        GameUtils.SecondConfirm(localize('您的当前游戏版本过低，请前往商店下载最新版本'), function()
            local Application = CS.UnityEngine.Application
            CfUtils.OpenURL(forceUpdateUrl)
        end)
        return false
    end
    return true
end

function ClubGVGUtils.EnterScene()
    local RuntimePlatform = CS.UnityEngine.RuntimePlatform
    local Application = CS.UnityEngine.Application
    local platform = Application.platform
    if RuntimePlatform.WindowsPlayer == platform  then
        local check_binding = check_binding or function (wrap)
            return type(typeof(wrap)) == "userdata"
        end
        local wrap = CS.XLua.CSObjectWrap.UnityEngineTilemapsTilemapWrap
        if not check_binding(wrap) then
            GameUtils.Toast(localize("您的当前游戏版本过低，请前往商店下载最新版本"))
            return
        end
        
    end

    local parameters = {
        luaPath           = "Game.UI.Club.GVG.ClubGVGSceneLaunch",
        isSaveSceneRecord = true,
        
        sceneId   = Constants.IdSceneSetting57
    }
    local UIArgs = UIArgs
    GameUtils.OpenLoadingPanel(
        UIArgs(Constants.UITypeIds.SceneLaunch, parameters),
        { UIArgs(Constants.UITypeIds.ClubGvgGroupMainDialog, parameters) }, Constants.LoadingType.Others, false, true)
        
end

function ClubGVGUtils.CloseScene(extraUIPages)
    local sceneId = Constants.UITypeIds.UISceneHome
    GameUtils.OpenLoadingPanel({ id = sceneId, parameters = {isBackToHomeScene = true, extraUIPages = extraUIPages, isMergeExtraUIPage = true} }, { { id = Constants.UITypeIds.UIHomeView } }, Constants.LoadingType.Others, false, true)
end

function ClubGVGUtils.Initial()
    local accelerateCoolDown         = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.AccelerateCoolDown)
    local battleEnterOffsetSeconds   = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.BattleEnterOffsetSeconds)
    local durationOfProtectionPeriod = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.DurationOfProtectionPeriod)
    local attackBuildingConsume              = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.AttackBuildingConsume)
    local battleCoolDown             = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.BattleCoolDown)
    local buildingCoolDown           = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.BuildingCoolDown)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    mgr:Initial(ClubGVGConstants, battleEnterOffsetSeconds, durationOfProtectionPeriod, attackBuildingConsume, accelerateCoolDown, battleCoolDown, buildingCoolDown)
end

---根据玩家列表获取玩家信息列表
function ClubGVGUtils.GetPlayerInfosByIds(playerIds, battingPlayerIdMap)
    local t = {}
    for index, playerId in ipairs(playerIds) do
        if battingPlayerIdMap == nil or not battingPlayerIdMap[playerId] then
            local data = ClubGVGUtils.GetPlayerInfo(playerId)
            if data then
                table.insert(t, data)
            end
        end
    end
    return t

end

---获取玩家信息
---@return {playerInfo:table, playerStatus:number} | nil
function ClubGVGUtils.GetPlayerInfo(playerId)
    if playerId == nil then return end
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local playerInfo   = mgr:GetPlayerInfoById(playerId)
    if playerInfo == nil then return end
    local playerStatus = ClubGVGUtils.GetPlayerStatusByInfo(playerInfo)
    return {playerInfo = playerInfo, playerStatus = playerStatus}

end

---获取玩家对战信息
function ClubGVGUtils.GetBuildingFightingInfo(info)
    info    = checkTable(info)
    local currentSeconds = GameUtils.GetServerTime()
    local t = {}
    local playerIdMap = {}
    for key, value in pairs(info) do
        local attackPlayerId  = checkNumber(value.attackPlayerId)
        local defensePlayerId = checkNumber(value.defencePlayerId)
        local endTime         = checkNumber(value.questEndTime)
        
        if currentSeconds < endTime then
            table.insert(t, {
                endTime = endTime, 
                attackPlayerInfo = ClubGVGUtils.GetPlayerInfo(attackPlayerId), 
                defensePlayerInfo = ClubGVGUtils.GetPlayerInfo(defensePlayerId)
            })
            playerIdMap[attackPlayerId] = true
            playerIdMap[defensePlayerId] = true
        end
    end

    return t, playerIdMap

end

---GetPlayerStatusByInfo
---根据玩家信息获取玩家状态
---@return ClubGVGConstants.PlayerStatus
function ClubGVGUtils.GetPlayerStatusByInfo(playerInfo)
    local times                  = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.SuccessiveVictoryTimes)
    local successiveVictoryTimes = checkNumber(playerInfo.successiveVictoryTimes)
    if successiveVictoryTimes >= times then
        return ClubGVGConstants.PlayerStatus.SuccessiveVictory
    end

    ---@type ClubGVGMgr
    local mgr                    = ClubGVGUtils.GetMgr()
    local playerId               = checkNumber(playerInfo.playerId)
    local isMarching             = mgr:GetMarchSecondsById(playerId) ~= nil
    if isMarching then
        return ClubGVGConstants.PlayerStatus.Marching
    end

    return ClubGVGConstants.PlayerStatus.Suspend

end

---AnalyzeBuildingState
---分析指定建筑物状态
function ClubGVGUtils.AnalyzeBuildingState(buildingInfo, isSelfClubBuilding)
    ---@type ClubGVGHomeDojo
    local dojo = ClubGVGUtils.GetComp():GetDojo()
    if dojo.clubIsDie == 1 then
        return ClubGVGConstants.BuildingStatus.Non
    end
    local playerPlace = checkNumber(dojo.playerPlace)
    local isInCurrentBuilding = playerPlace > 0 and playerPlace == checkNumber(buildingInfo.buildingId)

    local isMarching, marchInfo = ClubGVGUtils.CheckIsMarchingToSpecifyBuilding(buildingInfo.buildingId)
    if isMarching then
        return isInCurrentBuilding and ClubGVGConstants.BuildingStatus.Marching or ClubGVGConstants.BuildingStatus.Non, marchInfo
    end


--     -- local isCanMarch = ClubGVGUtils.CheckIsCanMarchState(buildingInfo)
--     -- if isCanMarch then
--     local buildingCount, path = ClubGVGUtils.GenerateMarchBuilding(buildingInfo)
--     return buildingCount <= 0 and ClubGVGConstants.BuildingStatus.Non or ClubGVGConstants.BuildingStatus.CanMarch, {buildingCount = buildingCount, path = path}
-- -- end


    -- if isSelfClubBuilding and checkNumber(buildingInfo.type) == ClubGVGConstants.MainBuildingId then
    if isSelfClubBuilding then
        ---@type ClubGVGHomeDojo
        local dojo = ClubGVGUtils.GetComp():GetDojo()
        local playerPlace = checkNumber(dojo.playerPlace)
        if playerPlace == 0 or isInCurrentBuilding then
            return ClubGVGConstants.BuildingStatus.Non
            
        end
    end

    -- if isSelfClubBuilding then
        
    -- end
    -- local isAttackBuildingState = ClubGVGUtils.CheckIsAttackBuildingState(buildingInfo)
    local isAttackState = ClubGVGUtils.CheckIsAttackState(buildingInfo)
    if isAttackState then
        local isCanAttackBuilding = ClubGVGUtils.CheckIsAttackBuildingState(buildingInfo)
        return ClubGVGConstants.BuildingStatus.AttackBuildingOrPlayer, isCanAttackBuilding
    end


--     -- local isCanMarch = ClubGVGUtils.CheckIsCanMarchState(buildingInfo)
--     -- if isCanMarch then
    local buildingCount, path = ClubGVGUtils.GenerateMarchBuilding(buildingInfo)
    return buildingCount <= 0 and ClubGVGConstants.BuildingStatus.Non or ClubGVGConstants.BuildingStatus.CanMarch, {buildingCount = buildingCount, path = path}
-- -- end


    -- -- local isCanMarch = ClubGVGUtils.CheckIsCanMarchState(buildingInfo)
    -- -- if isCanMarch then
    --     local buildingCount, path = ClubGVGUtils.GenerateMarchBuilding(buildingInfo)
    --     return buildingCount <= 0 and ClubGVGConstants.BuildingStatus.Non or ClubGVGConstants.BuildingStatus.CanMarch, {buildingCount = buildingCount, path = path}
    -- -- end

    -- return ClubGVGConstants.BuildingStatus.Non
end

---检查是否行军到该建筑
function ClubGVGUtils.CheckIsMarchingToSpecifyBuilding(buildingId)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local seconds, marchInfo = mgr:GetMarchSeconds()
    if seconds ~= nil then
        return true, marchInfo
    end
    return false
end

---@param buildingInfo {buildingId:number, clubId:number, attackPlayerIds:table}
---@return boolean  是否能行军
---@return table    行军路线
function ClubGVGUtils.CheckIsCanMarchState(buildingInfo)
     -- 行军规则
    -- 玩家只能沿着道路到达：
    -- 1.从本方建筑出发，可以到达本方建筑或者本方建筑相邻的建筑
    -- 2.从非本方建筑出发，只能向本方建筑行军；无法到达其他非本方建筑
    -- 3.若处于非本方建筑，且周围没有相邻的本方建筑，则无法行军

    --- 判断是否是显示前往按钮 根据 要前往的建筑物是不是自己工会所拥有的建筑物

    --- 检查当前建筑物是否是己方工会建筑
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local dojo = mgr:GetHomeDojo()
    local playerPlace = dojo.playerPlace


    return checkNumber(buildingInfo.clubId) ~= mgr:GetClubId()

end

function ClubGVGUtils.GenerateMarchBuilding(buildingInfo)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local playerPlace = mgr:GetHomeDojo().playerPlace
    local buildingId  = checkNumber(buildingInfo.buildingId)
    -- local clubId      = checkNumber(buildingInfo.clubId)
    local clubId      = mgr:GetClubId()
    return ClubGVGUtils.CalcMarchBuildingCount(playerPlace, buildingId, clubId)
end

---@param startBuildingId number 起始建筑物
---@param endBuildingId number 终点建筑物
---@param clubId number 玩家所在工会
---@return number marchBuildingCount 行军经过的建筑数量 0->无格子 -1 要去的地点无效 >0 行军经过的建筑数量
---@return table path 行军路线 
function ClubGVGUtils.CalcMarchBuildingCount(startBuildingId, endBuildingId, clubId)
    --- 检查开始和结束建筑物是否有效
    if startBuildingId == endBuildingId then
        return 0
    end

    if startBuildingId == 0 then
        return - 1
    end

    ---@type ClubGVGMgr
    local mgr              = ClubGVGUtils.GetMgr()
    ---@type {buildingNeighborIds:table}
    local buildId2TileData = mgr:GetBuildId2TileData()

    local startBuildingTileData = buildId2TileData[startBuildingId]
    if startBuildingTileData == nil then
        printError("未知的起点建筑物id", startBuildingId)
        return -1
    end

    local endBuildingTileData = buildId2TileData[endBuildingId]
    if endBuildingTileData == nil then
        printError("未知的终点建筑物id", endBuildingId)
        return -1
    end

    -- 行军规则
    -- 玩家只能沿着道路到达：
    -- 1.从本方建筑出发，可以到达本方建筑或者本方建筑相邻的建筑
    -- 2.从非本方建筑出发，只能向本方建筑行军；无法到达其他非本方建筑
    -- 3.若处于非本方建筑，且周围没有相邻的本方建筑，则无法行军

    --- 检查当前建筑是否是本方建筑
    local startBuildingInfo = mgr:GetBuildInfo(startBuildingId)
    local endBuildingInfo = mgr:GetBuildInfo(endBuildingId)
    if checkNumber(startBuildingInfo.clubId) ~= clubId then
        ---检查规则2和3
        local startBuildingNeighborIds = startBuildingTileData.buildingNeighborIds.container
        -- print("startBuildingNeighborIds", table.toString(startBuildingNeighborIds))
        for index, buildingId in ipairs(startBuildingNeighborIds) do
            if checkNumber(buildingId) == endBuildingId then
                local buildInfo = mgr:GetBuildInfo(buildingId)
                local buildClubId = checkNumber(buildInfo.clubId)
                ---只能前往己方工会的建筑
                local res = buildClubId == clubId
                return res and 1 or -1, {startBuildingId, endBuildingId}
            end

        end
        return -1
    end

    --- 检查规则1
    --- 要去的建筑物 是不是工会所占领的建筑 或 中立建筑
    -- local endBuildingClubId = checkNumber(endBuildingTileData.clubId)
    -- if endBuildingClubId > 0 and endBuildingClubId ~= clubId then
    --     return -1
    
    -- end
    -- mgr:GetBuildId2BuildInfo(startBuildingId)

    local path = ClubGVGUtils.SearchBuilding(startBuildingId, endBuildingId, clubId)
    -- print("HexHeuristicDistance", path)
    return path == nil and -1 or (#path - 1), path

end

local function HexHeuristicDistance(a, b)
    local abs = math.abs
    local dx = checkNumber(b.x) - checkNumber(a.x)
    local dy = checkNumber(b.y) - checkNumber(a.y)
    local dist = (abs (dx) + abs (dy) + abs (dx-dy))
    return dist
end

local function Reverse(tab)
    for i = 1, #tab // 2, 1 do
        tab[i], tab[#tab-i+1] = tab[#tab-i+1], tab[i]
    end
    return tab
end

function ClubGVGUtils.SearchBuilding(startBuildingId, endBuildingId, clubId)

    ---@type PriorityQueue
    local queue = PriorityQueue.New()
    queue:Enqueue(startBuildingId, 0)

    local cameFrom  = {[startBuildingId]  = startBuildingId}
    local costSoFar = {[startBuildingId] = 0}

    ---@type ClubGVGMgr
    local mgr              = ClubGVGUtils.GetMgr()
    ---@type {buildingNeighborIds:table}
    local buildId2TileData = mgr:GetBuildId2TileData()

    local endTileData = buildId2TileData[endBuildingId]
    local endBuildingPosition = endTileData.position

    local current
    while queue:Size() > 0 do
        current = queue:Dequeue()
        if current == endBuildingId then
            break
        end
        local tileData    = buildId2TileData[current]
        local neighborIds = tileData.buildingNeighborIds.container
        for index, neighborId in ipairs(neighborIds) do
            local info = mgr:GetBuildInfo(neighborId)
            --- checkNumber(info.clubId) == clubId 用于检查途径的是否是工会建筑
            --- neighborId == endBuildingId 无视工会检查
            if checkNumber(info.clubId) == clubId or neighborId == endBuildingId then
                local newCost = costSoFar[current] + 1
                local cost = costSoFar[neighborId]
                if cost == nil or newCost < cost then
                    costSoFar[neighborId] = newCost
                    cameFrom[neighborId]  = current

                    local neighborPosition = buildId2TileData[neighborId].position
                    local priority = newCost + HexHeuristicDistance(neighborPosition, endBuildingPosition)
                    queue:Enqueue(neighborId, priority)

                end
                
            end
                
        end

    end

    ---出现这种情况则表示不可达
    if current ~= endBuildingId then
        return nil
    end

    local path = {}
    while current ~= startBuildingId do
        table.insert(path, current)
        current = cameFrom[current]
    end
    table.insert(path, startBuildingId)

    Reverse(path)
    return path
end

---CalcMarchSeconds
---计算行军时间
---@param buildingCount number 间隔有多少个建筑物
function ClubGVGUtils.CalcMarchSeconds(buildingCount)
    return buildingCount * ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.MarchTime)
end

function ClubGVGUtils.CheckIsAttackState(buildingInfo)
    --- 检查是否在该建筑物
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local playerPlace = mgr:GetHomeDojo().playerPlace
    return playerPlace == checkNumber(buildingInfo.buildingId)
end

---@param buildingInfo {clubId:number, attackPlayerIds:table, buildingId: number}
function ClubGVGUtils.CheckIsAttackBuildingState(buildingInfo)
    -- 攻城条件：
    -- 1.已经到达该建筑物内
    -- 2.该建筑物未被自己社团占领
    -- 3.该建筑物内没有其他社团的玩家
    -- 4.精力值不为0 

    --- 检查是否在该建筑物
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()

    local clubId = checkNumber(buildingInfo.clubId)

    --- 检查该建筑是否被己方工会占领
    -- if clubId > 0 and mgr:GetClubId() ~= clubId then
    --     return false
    -- end

    -- local selfId = mgr:GetPlayerId()
    -- local attackPlayerIds = checkTable(buildingInfo.attackPlayerIds)
    --- 如果有 进攻列 则需要检查进攻列的人是不是在行军中
    local isCanAttack  = ClubGVGUtils.IsCanAttackBuilding(buildingInfo)
    
    -- if isCanAttack then
    --     -- local playerId = mgr:GetPlayerId()
    --     -- local clubId = mgr:GetClubId()
    --     -- local playerId2Info = mgr:GetPlayerId2PlayerInfo()
    --     -- --- 当前战斗列有一个不是在行军中 则不能进攻该建筑
    --     -- for index, playerId in ipairs(attackPlayerIds) do
    --     --     local playerInfo = playerId2Info[playerId]
    --     --     isCanAttack = isCanAttack and checkNumber(playerInfo.clubId) == clubId

    --     -- end
    --     isCanAttack = isCanAttack and ClubGVGUtils.IsCanAttack(attackPlayerIds)

    -- end

    return isCanAttack

end

function ClubGVGUtils.IsCanAttackBuilding(buildingInfo)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    return mgr:IsCanAttackBuilding(buildingInfo)
    -- local isCanAttack = true
    -- local clubId = mgr:GetClubId()
    -- local playerId2Info = mgr:GetPlayerId2PlayerInfo()
    -- --- 当前战斗列有一个不是在行军中 则不能进攻该建筑
    -- for index, playerId in ipairs(attackPlayerIds) do
    --     local playerInfo = playerId2Info[playerId]
    --     isCanAttack = isCanAttack and checkNumber(playerInfo.clubId) == clubId

    -- end
    -- return isCanAttack
end

---是否能进攻玩家
---@param playerId number 要进攻的玩家id
function ClubGVGUtils.IsCanAttackPlayer(playerId)
    ---@type ClubGVGMgr
    local mgr        = ClubGVGUtils.GetMgr()
    local playerInfo = mgr:GetPlayerInfoById(playerId)
    local playerId   = checkNumber(playerInfo.playerId)
    local isMarching = mgr:GetMarchSecondsById(playerId) ~= nil

    ---要进攻的玩家不在行军中 自己不在行军中 不是同工会
    if isMarching or mgr:GetMarchSeconds() ~= nil or checkNumber(playerInfo.clubId) == mgr:GetClubId() or playerId == mgr:GetPlayerId() then
       return false 
    end

    if mgr:GetHomeDojo().clubIsDie == 1 then
        return false
    end

    return true

end

---@param buildingInfo {buildingId:number, type:number, clubId:number, playerIds:table, attackPlayerIds:table, defensePlayerIds:table, fightingInfo:table}
function ClubGVGUtils.IsFighting(buildingInfo)
    local fightingInfo = buildingInfo.fightingInfo
    return next(fightingInfo) ~= nil
end

---计算团队战力
function ClubGVGUtils.CalcTeamPower(teams)
    local num = 0
    for i, team in ipairs(teams) do
        num = num + checkNumber(team.combatValue)
    end
    return num
end

---通过玩家id获取玩家阵容信息
function ClubGVGUtils.GetPlayerTeamMembersById(playerId)
    ---@type ClubGVGMgr
    local mgr        = ClubGVGUtils.GetMgr()
    local playerInfo = mgr:GetPlayerInfoById(playerId)
    return playerInfo.team
end

---GetRankingRewardDataList
---@param group number 奖池组（1=高级场，2=中级场，3=低级场）
---@param labelType ClubGVGConstants.RankingLabelType
function ClubGVGUtils.GetRankingRewardDataList(group, labelType, ranking)
    local dataList 
    if labelType == ClubGVGConstants.RankingLabelType.Club then
        dataList = ClubGVGUtils.GetClubRankRewardVos()
    elseif labelType == ClubGVGConstants.RankingLabelType.Player then
        dataList = ClubGVGUtils.GetPlayerRankRewardVos()
    end
    
    if dataList == nil then
        return
    end

    local t = {}
    local popularityReward
    for index, value in ipairs(dataList) do
        if value.group == group then
            table.insert(t, value)
            if popularityReward == nil and ranking > 0 and ranking <= value.lowerLimit then
                popularityReward = value
            end
        end
    end

    return t, popularityReward

end

---@param tileMap UnityEngine.Tilemaps.Tilemap
---@param position UnityEngine.Vector3Int
---@param color UnityEngine.Color
function ClubGVGUtils.SetTileColor(tileMap, position, color, selectTileBase, isOwnClubId)
    if isOwnClubId then
        tileMap:SetTile(position, selectTileBase)
        tileMap:SetTileFlags(position, TileFlagsNone)
        tileMap:SetColor(position, color)
    else
        tileMap:SetTile(position, selectTileBase)
    end
end

---@param buildingVo ClubGVGBuildingVo
---@param buildingId number
function ClubGVGUtils.GetBuildingName(buildingVo, buildingId)
    buildingId = checkNumber(buildingId)
    return string.format("%s%s", buildingVo.name, buildingId % (buildingVo.id * 10000))
end

---@param buildingId number 变更归属的建筑物
---@param newClubId number 变更后工会Id
---@param oldClubId number 变更前工会Id
function ClubGVGUtils.CheckAndShowMessage(buildingId, newClubId, oldClubId)
    local mgr = ClubGVGUtils.GetMgr()
    local buildingInfo = mgr:GetBuildInfo(buildingId)
    
    local clubId = mgr:GetClubId()
    local msg
    --- 当前建筑物被我工会占领
    if newClubId == clubId then
        local buildingType = buildingInfo.type
        ---@type ClubGVGBuildingVo
        local vo = ClubGVGUtils.GetBuildingVoById(buildingType)
        local buildingName = ClubGVGUtils.GetBuildingName(vo, buildingId)
        local clubInfo = mgr:GetClubInfoById(newClubId)
        if oldClubId <= 0 then
            --- 当该建筑没有归属时
            --- [我方社团名]占领了[建筑名]
            -- buildingInfo.
            msg = localize("[<color=#6ACE61>_clubName_</color>]占领了[<color=#6ACE61>_buildingName_</color>]", {_clubName_ = clubInfo.name, _buildingName_ = buildingName})
        else
            local clubInfo2 = mgr:GetClubInfoById(oldClubId)
            --- b：当我方占领了其他社团的建筑时
            --- [我方社团名]占领了[社团B]的[建筑名]
            msg = localize("[<color=#6ACE61>_clubName_</color>]占领了[<color=#D26361>_clubName2_</color>]的[<color=#6ACE61>_buildingName_</color>]", {_clubName_ = clubInfo.name, _clubName2_ = clubInfo2.name, _buildingName_ = buildingName})
        end

    elseif oldClubId == clubId then
        --- 1.我方社团建筑，被占领时的提示
        --- [社团名A]占领了我方[建筑名]
        local buildingType = buildingInfo.type
        ---@type ClubGVGBuildingVo
        local vo = ClubGVGUtils.GetBuildingVoById(buildingType)
        local buildingName = ClubGVGUtils.GetBuildingName(vo, buildingId)
        local clubInfo = mgr:GetClubInfoById(newClubId)
        msg = localize("[<color=#D26361>_clubName_</color>]占领了我方[<color=#D26361>_buildingName_</color>]", {_clubName_ = clubInfo.name, _buildingName_ = buildingName})
    end 

    if msg then
        ---@type MessageTickerUtils
        local MessageTickerUtils = import("Game.UI.MessageTicker.MessageTickerUtils")
        MessageTickerUtils.ShowMessage(msg, 0, -1, 1, 2, 0, 0, Constants.MessageShowType.Global)
    end
end

---显示重生道具兑换界面
function ClubGVGUtils.ShowRebirthGoodsExchange()
    local data = {}
    data.consumeId = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.RebirthGoodsBuyGoodsId)
    data.consumeNum = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.RebirthGoodsBuyGoodsNum)
    data.getId     = ClubGVGUtils.GetParamValue(ClubGVGConstants.ParamsId.RebirthGoodsId)
    data.getNum = 1
    -- data.maxChangeNum = 
    data.interface = Interfaces.overseaCLubGvgBuyRebirthGoods
    data.IsCameraState = false
    data.isPreviewGetId = true
    data.isDisableSecondaryCurrency = true
    data.isDisableLackMaterialTips = true
    
    CfUtils.DialogOpen(Constants.UITypeIds.LadderCompetionExchangeOpals, data)
end

---计算属性减少百分比
function ClubGVGUtils.CalcHpAttrReduction(hp)
    local vos = ClubGVGUtils.GetAllEnergyVos()
    local left = 1
    local right = #vos
    
    hp = checkNumber(hp)
    local func = function (middle)
        local vo = vos[middle]
        local energyMin, energyMax = vo.energyMin, vo.energyMax
        return hp <= energyMin
    end

    local floor = math.floor
    while left <= right do
        local middle = left + floor((right - left) * 0.5)
        if func(middle) then
            right = middle - 1
        else
            left = middle + 1
        end
        
    end

    local vo = ClubGVGUtils.GetEnergyVoById(right)
    return vo.reduction
end


function ClubGVGUtils.GetClubId2Color()
    local mgr = ClubGVGUtils.GetMgr()
    local clubId2Color = mgr:GetClubId2Color()
    if next(clubId2Color) then
        return clubId2Color
    end
    ---@type ClubGVGHomeDojo
    local dojo              = mgr:GetHomeDojo()
    local clubInfo = dojo.clubInfo
    local selfClubId = mgr:GetClubId()

    local enemyColorId = 1
    local GetEnemyColorId = function()
        enemyColorId = enemyColorId + 1
        return enemyColorId
    end
    for clubId, _ in pairs(clubInfo) do
        local colorId = selfClubId == clubId and 1 or GetEnemyColorId()
        local vo = ClubGVGUtils.GetClubGVGTileColorVo(colorId)
        if vo then
            local color = vo:GetColor()
            clubId2Color[clubId] = color
            
        end
    end

    return clubId2Color
end

function ClubGVGUtils.GetClubColor(clubId)
    local clubId2Color = ClubGVGUtils.GetClubId2Color()
    local color = clubId2Color[clubId] or Color.gray
    return color
end

---@return ClubGVGMgr
function ClubGVGUtils.GetMgr()
    return ClubGVGMgr:GetInstance()
end

---@return ClubGVGComponent
function ClubGVGUtils.GetComp()
    return ClubGVGMgr:GetInstance():GetComp()
end


---@return ClubGVGNetworkClient
function ClubGVGUtils.GetClient()
    return ClubGVGUtils.GetMgr():GetClient()
end

function ClubGVGUtils.ClearTable(t)
    for key, value in pairs(t) do
        t[key] = nil
    end
end

---Clear
---退出界面清理数据
function ClubGVGUtils.Clear()
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    mgr:Clear()
    -- ClubGVGUtils.Destroy()
end

function ClubGVGUtils.Destroy()
    ClubGVGUtils.GetMgr():Delete()
end

return ClubGVGUtils
