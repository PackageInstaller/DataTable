---@class PVPArenaVirtualData
local PVPArenaVirtualData = {}

local GetParamsRowNum = function (id)
    print("id------->>>>>", id)
    local row = CfUtils.GetCfLine(AutoIds.IdSetting1040, id)
    return parse_number(row, "num")
end

local Avatars      = {}
local AvatarFrame  = {}
local InitAvatarAndFrame = function()
    ---@type TableML.TableFile
    local tb = CfUtils.GetCfTable(AutoIds.IdSetting952)
    local rows = tb:GetAll()
    for i, row in pairs(rows) do
        local id = parse_number(row, "id")
        local kind = parse_number(row, "kind")
        if kind == 1 then
            table.insert(Avatars, id)
        elseif kind == 2 then
            table.insert(AvatarFrame, id)
        end 
    end
    
end
local RandomAvatarAndFrame = function()
    local avatar = math.random(1, #Avatars)
    local frame  = math.random(1, #AvatarFrame)
    return Avatars[avatar], AvatarFrame[frame]
end
local RandomName = function (len)
    local rt = ""
    for i = 1, len, 1 do
        rt = rt .. string.char(math.random(97,122))
    end
    return rt
end

local CreatePlayer = function(playerId)
    local avatar, frame = RandomAvatarAndFrame()
    return {
        playerId    = playerId,              --- 玩家名称
        name        = RandomName(7),         --- 玩家名称
        avatar      = avatar,                --- 玩家头像
        avatarFrame = frame,                --- 玩家头像框
        level       = math.random(1, 120),   --- 玩家等级
        quizzedNum  = 0,                     --- 被竞猜数量
    }
end

local SeasonStatus = Constants.PVPArenaSeasonStatus
local BattleStatus = Constants.PVPArenaBattleStatus
local Identity     = Constants.PVPArenaIdentity
local ParamsIds    = Constants.PVPArenaParamsIds
local paramsId2Params = {}
for i, paramsId in pairs(ParamsIds) do
    paramsId2Params[paramsId] = GetParamsRowNum(paramsId)
end

local BattleStatus2Seconds = {
    [BattleStatus.Wait]     = 10,
    [BattleStatus.Prepare]  = 10,
    [BattleStatus.InBattle] = 64,
    [BattleStatus.Result]   = 10,
}

local BattleStatus2Seconds = {
    [BattleStatus.Wait]     = 100000,
    [BattleStatus.Prepare]  = 100000,
    [BattleStatus.InBattle] = 640000,
    [BattleStatus.Result]   = 100000,
}

local oneWheelBattleSeconds = 0
for i, v in pairs(BattleStatus2Seconds) do
    oneWheelBattleSeconds = v + oneWheelBattleSeconds
end
local SeasonStatus2Seconds = {
    [SeasonStatus.Quiz]   = 300000,
    [SeasonStatus.Notice] = 20,
    [SeasonStatus.Battle] = 7 * oneWheelBattleSeconds,
    [SeasonStatus.Closed] = 10000,
}

-- local GroupCount    = 8  --- 共八个小组

local MaxWheel = 0
---参赛人数
local Numbers = paramsId2Params[ParamsIds.Numbers]
local wheel2Num = {Numbers}
local CalcTotalNumbers = function(numbers)
    local totalNumbers = numbers
    local temp = numbers
    while temp ~= 1 do
        temp = checkInt(temp * 0.5)
        table.insert(wheel2Num, temp)
        totalNumbers = totalNumbers + temp
        MaxWheel = MaxWheel + 1
    end
    return totalNumbers
end
local ThirdPlacMatch = 2
local TotalNumbers   = CalcTotalNumbers(Numbers)

local BattleRounds = paramsId2Params[ParamsIds.BattleRounds]
local WinRound = math.ceil(BattleRounds * 0.5)

local pvpArenaData = {
    seasonId                   = 0,   --- 赛季ID
    seasonStatus               = 0,   --- 赛季状态 1:等待下一期开启 2:竞猜期 3:公示期 4:比赛期
    nextStageLeftSeconds       = 0,   --- 当前阶段结束剩余秒数
    battleStatus               = 0,   --- 比赛期状态 1:等待开始 2:战前准备 3:战斗中 4:结算 (只有比赛期返回数据)
    battleNextStageLeftSeconds = 0,   --- 当前比赛期阶段结束剩余秒数 (只有比赛期返回数据)
    isEnd                      = 0,   --- 是否结束
    identity                   = 0,   --- 身份 1:参选选手 2:观众
    isFirst                    = 0,   --- 是否第一次进来 0:不是 1:是
    quizTicketNum              = 3,   --- 竞猜票数量
    leftQuizTicketBuyTimes     = 2,   --- 竞猜票剩余购买次数
    map                        = {},  --- 对战表 key:位置ID
    matcherInfo                = {},  --- 比赛选手数据 key:玩家ID
    quizzed                    = {},  --- 已竞猜的玩家列表
    actionOrder                = 0,   --- [第一场顺序，第二场顺序]，1先0后
    battleRound                = 0,   --- 当前第几轮

    battleRound2Complete       = {},  --- 当前第几轮->对阵图数据生成完成
    -- playerId                   = math.random(1, Numbers),

}

local ClearSeasonData = function()
    pvpArenaData.battleStatus               = 0  --- 比赛期状态 1:等待开始 2:战前准备 3:战斗中 4:结算 (只有比赛期返回数据)
    pvpArenaData.actionOrder                = 0  --- [第一场顺序，第二场顺序]，1先0后
    pvpArenaData.battleRound                = 0  --- 当前第几轮
    pvpArenaData.battleNextStageLeftSeconds = 0

    pvpArenaData.battleRound2Complete       = {}
end

local InitMatcherInfo = function(numbers)
    for playerId = 1, numbers, 1 do
        pvpArenaData.matcherInfo[tostring(playerId)] = CreatePlayer(playerId)
    end

end

local InitMap = function(seasonStatus, isPlayer, playerId)
    local numbers = Numbers
    if next(pvpArenaData.matcherInfo) == nil then
        InitMatcherInfo(numbers)
    end
    
    local map = {}
    if seasonStatus == SeasonStatus.Closed then
        --- 需要展示所有对阵图结果
        local totalWheel = #wheel2Num
        local offset = 0
        for i = 1, totalWheel - 1, 1 do
            local num = wheel2Num[i]
            local idx = 1
            for index = 1 + offset, num + offset, 2 do
                local res   = math.random(0, 1)
                local isWin = res == 1
                if not map[tostring(index)] and index <= 128 then
                    map[tostring(index)] = {playerId = index}
                end
                local score    = isWin and WinRound or res
                map[tostring(index)].score    = score

                if not map[tostring(index + 1)] and index <= 128 then
                    map[tostring(index + 1)] = {playerId = index + 1}
                end
                score    = isWin and res or WinRound
                map[tostring(index + 1)].score    = score
                
                ------------------------------
                --- 填充下一轮数据
                map[tostring(idx + num + offset)] = {
                    playerId = isWin and map[tostring(index)].playerId or map[tostring(index + 1)].playerId,
                    score    = 0,
                }

                map[tostring(idx + num + offset + 1)] = {
                    playerId = isWin and map[tostring(index + 1)].playerId or map[tostring(index)].playerId,
                    score    = 0,
                }

                --- 4 进 2
                if i == totalWheel - 2 then
                    local lowerId = isWin and map[tostring(index + 1)].playerId or map[tostring(index)].playerId

                    if idx == 1 then
                        --- 随机分数   
                        res   = math.random(0, 1)
                        isWin = res == 1
                        --- 左侧季军
                        map[tostring(1 + TotalNumbers)] = {
                            playerId = lowerId,
                            score    = isWin and WinRound or res,
                        }
                        --- 右侧季军
                        map[tostring(2 + TotalNumbers)] = {
                            playerId = 0,
                            score    = isWin and res or WinRound,
                        }
                    elseif idx == 2 then
                        map[tostring(2 + TotalNumbers)].playerId = lowerId
                    end
                end
                idx = idx + 1
            end
            offset = offset + num
        end
    elseif seasonStatus == SeasonStatus.Quiz or seasonStatus == SeasonStatus.Notice or seasonStatus == SeasonStatus.Battle then
        local num = wheel2Num[1]
        local isNotice = seasonStatus == SeasonStatus.Notice
        for playerId = 1, num, 1 do
            map[tostring(playerId)] = {playerId = playerId, score = 0}
            
            if isNotice then
                pvpArenaData.matcherInfo[playerId].quizzedNum = math.random(1, 10000000)
            end
        end

        if seasonStatus == SeasonStatus.Battle then
            local battleStatus = pvpArenaData.battleStatus
            local battleRound  = pvpArenaData.battleRound
            if battleStatus == BattleStatus.InBattle or battleStatus == BattleStatus.Result then
                local startPosition = 1
                for i = 1, battleRound, 1 do
                    local wheelNum = wheel2Num[i]
                    for position = startPosition, (startPosition - 1) + wheelNum, 2 do
                        num = num + 1
                        -- if num % 2 == 0 then
                            local res         = math.random(0, 1)
                            local isWin       = res == 1
                            local leftPlayer  = map[tostring(position)]
                            local rightPlayer = map[tostring(position + 1)]
                            leftPlayer.score  = isWin and WinRound or res
                            rightPlayer.score = isWin and res or WinRound
                            local playerId = isWin and leftPlayer.playerId or rightPlayer.playerId
                            map[tostring(num)] = {playerId = playerId, score = 0}
                            
                        -- end
                    end
                    startPosition = startPosition + wheelNum
                    pvpArenaData.battleRound2Complete[i] = true
                end

            end
        end
    end
    
    pvpArenaData.map = map
end

--- TestQuizzedPopUp
--- 测试投票结果打脸
local function TestQuizzedPopUp()
    pvpArenaData.seasonStatus = SeasonStatus.Battle
    pvpArenaData.seasonId     = 200
    pvpArenaData.identity     = Identity.Audience
    pvpArenaData.battleStatus = BattleStatus.InBattle
    pvpArenaData.battleRound  = 2
    pvpArenaData.quizTicketNum = 0
    pvpArenaData.quizzed = {"2", "1"}
end

local InitPVPArenaData = function ()
    -- pvpArenaData.seasonStatus = SeasonStatus.Closed
    TestQuizzedPopUp()

    pvpArenaData.battleNextStageLeftSeconds = BattleStatus2Seconds[pvpArenaData.battleStatus]
    pvpArenaData.nextStageLeftSeconds       = SeasonStatus2Seconds[pvpArenaData.seasonStatus]
    
    local isPlayer = pvpArenaData.identity == Identity.Player
    pvpArenaData.playerId     = isPlayer and math.random(1, paramsId2Params[ParamsIds.Numbers]) or 9999999
    local seasonId = pvpArenaData.seasonId
    if seasonId > 0 then
        InitMap(pvpArenaData.seasonStatus, isPlayer, pvpArenaData.playerId)
    end

end


local timeDown
PVPArenaVirtualData.Start = function()
    if timeDown then
        return
    end

    InitAvatarAndFrame()
    InitPVPArenaData()

    local CDTimerModule = CS.Engine.Modules.CDTimerModule
    timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id, elapsed)
        pvpArenaData.nextStageLeftSeconds = pvpArenaData.nextStageLeftSeconds - 1
       if pvpArenaData.nextStageLeftSeconds <= 0 then
            if pvpArenaData.seasonStatus == SeasonStatus.Battle then
                pvpArenaData.seasonStatus = SeasonStatus.Closed

                ClearSeasonData()
            else
                pvpArenaData.seasonStatus = pvpArenaData.seasonStatus + 1
                -- if pvpArenaData.seasonStatus == BattleStatus.InBattle then
                --     pvpArenaData.battleRound  = 1
                -- end
            end

            pvpArenaData.nextStageLeftSeconds = SeasonStatus2Seconds[pvpArenaData.seasonStatus]

       end

       local seasonStatus = pvpArenaData.seasonStatus
       if seasonStatus == SeasonStatus.Battle then
            pvpArenaData.battleNextStageLeftSeconds = pvpArenaData.battleNextStageLeftSeconds - 1
            if pvpArenaData.battleNextStageLeftSeconds <= 0 then
                pvpArenaData.battleNextStageLeftSeconds = BattleStatus2Seconds[pvpArenaData.battleStatus]

                if pvpArenaData.battleStatus == BattleStatus.Result then
                    pvpArenaData.battleStatus = BattleStatus.Wait
                    
                else
                    pvpArenaData.battleStatus = pvpArenaData.battleStatus + 1
                    if pvpArenaData.battleStatus == BattleStatus.Prepare then
                        pvpArenaData.battleRound  = pvpArenaData.battleRound + 1
    
                    end
    
                end
                
            end

            if pvpArenaData.battleStatus == BattleStatus.InBattle then
                --- 计算这轮会打多少次
                local CalcCurWheelMaxNum = function(battleRound)
                    local maxNum = 0
                    for i = 1, battleRound, 1 do
                        maxNum = maxNum + wheel2Num[i]
                    end
                    return maxNum
                end

                local battleRound         = pvpArenaData.battleRound
                if pvpArenaData.battleRound2Complete[battleRound] then
                   return 
                end

                if battleRound == MaxWheel then
                    local map     = pvpArenaData.map
                    if map[tostring(TotalNumbers)] == nil then
                        ---------------------------------------
                        --- 生成冠军数据
                        local leftPlayer  = map[tostring(TotalNumbers - 2)]
                        local rightPlayer = map[tostring(TotalNumbers - 1)]
    
                        local res   = math.random(0, 1)
                        local isWin = res == 1
                        ---------------------------------------
                        --- 更新冠亚两个玩家的数据
                        leftPlayer.score  = isWin and WinRound or res 
                        rightPlayer.score = isWin and res or WinRound
    
                        map[tostring(TotalNumbers)]  = {
                            playerId = isWin and leftPlayer.playerId or rightPlayer.playerId,
                            score    = 0
                        }
    
                        ---------------------------------------
                        --- 生成季军数据
                        leftPlayer  = map[tostring(TotalNumbers + 1)]
                        rightPlayer = map[tostring(TotalNumbers + 2)]
    
                        res   = math.random(0, 1)
                        isWin = res == 1
                        ---------------------------------------
                        --- 更新季军两个玩家的数据
                        leftPlayer.score  = isWin and WinRound or res 
                        rightPlayer.score = isWin and res or WinRound
                    end
                    pvpArenaData.battleRound2Complete[battleRound] = true
                else
                    local inBattleSeconds = BattleStatus2Seconds[pvpArenaData.battleStatus]
                    local curWheelNum     = wheel2Num[battleRound]
                    --- 当前轮数最大数量  
                    local battleNextStageLeftSeconds = pvpArenaData.battleNextStageLeftSeconds
                    local leftScope, rightScope, idx
                    if battleNextStageLeftSeconds == inBattleSeconds * 0.75 then
                        leftScope  = CalcCurWheelMaxNum(battleRound - 1)
                        rightScope = leftScope + checkInt((curWheelNum * 0.5))
                        idx        = 0     
                    elseif battleNextStageLeftSeconds == inBattleSeconds * 0.25 then
                        local temp = CalcCurWheelMaxNum(battleRound - 1)
                        leftScope  = temp + checkInt(curWheelNum * 0.5)
                        rightScope = temp + curWheelNum
                        idx        = checkInt(wheel2Num[battleRound + 1] * 0.5)

                        pvpArenaData.battleRound2Complete[battleRound] = true
                    end
                    if leftScope and rightScope then
                        local map = pvpArenaData.map
                        local realRightScope = CalcCurWheelMaxNum(battleRound)
                        local lowerId 
                        for position = 1 + leftScope, rightScope, 2 do
                            idx = idx + 1
                            local leftPlayer  = map[tostring(position)]
                            local rightPlayer = map[tostring(position + 1)]
                            
                            local res   = math.random(0, 1)
                            local isWin = res == 1
                
                            ---------------------------------------
                            --- 更新当前两个玩家的数据
                            leftPlayer.score  = isWin and WinRound or res 
                            rightPlayer.score = isWin and res or WinRound
                
                            ---------------------------------------
                            --- 插入晋级玩家的数据
                            map[tostring(realRightScope + idx)] = {
                                playerId = isWin and leftPlayer.playerId or rightPlayer.playerId,
                                score    = 0
                            }
                            
                            lowerId = isWin and rightPlayer.playerId or leftPlayer.playerId
                        end
                
                        ---------------------------------------
                        --- 如果是4->2 插入失败玩家数据
                        if battleRound == MaxWheel - 1 then
                            map[tostring(TotalNumbers + idx)] = {
                                playerId = lowerId,
                                score    = 0
                            }
                        end
                        
                    end
                end

            end

       end 

    end, 259200, false, true)
end

--- 竞技场入口
PVPArenaVirtualData.ArenaEntry = function() 
    local data = {
        seasonId                   = pvpArenaData.seasonId,                     --- 赛季ID
        seasonStatus               = pvpArenaData.seasonStatus,                 --- 赛季状态 1:等待下一期开启 2:竞猜期 3:公示期 4:比赛期
        nextStageLeftSeconds       = pvpArenaData.nextStageLeftSeconds,         --- 当前阶段结束剩余秒数
        battleStatus               = pvpArenaData.battleStatus,                 --- 比赛期状态 1:等待开始 2:战前准备 3:战斗中 4:结算 (只有比赛期返回数据)
        battleNextStageLeftSeconds = pvpArenaData.battleNextStageLeftSeconds,   --- 当前比赛期阶段结束剩余秒数 (只有比赛期返回数据)
        isEnd                      = pvpArenaData.isEnd,                        --- 是否结束
        identity                   = pvpArenaData.identity,                     --- 身份 1:参选选手 2:观众
   }
   return clone(data)
end

--- 竞技场首页
PVPArenaVirtualData.ArenaHome = function() 
    local data = {
        seasonId                   = pvpArenaData.seasonId,                     --- 赛季ID
        seasonStatus               = pvpArenaData.seasonStatus,                 --- 赛季状态 1:等待下一期开启 2:竞猜期 3:公示期 4:比赛期
        nextStageLeftSeconds       = pvpArenaData.nextStageLeftSeconds,         --- 当前阶段结束剩余秒数
        battleStatus               = pvpArenaData.battleStatus,                 --- 比赛期状态 1:等待开始 2:战前准备 3:战斗中 4:结算 (只有比赛期返回数据)
        battleNextStageLeftSeconds = pvpArenaData.battleNextStageLeftSeconds,   --- 当前比赛期阶段结束剩余秒数 (只有比赛期返回数据)
        isFirst                    = pvpArenaData.isFirst,                      --- 是否第一次进来 0:不是 1:是
       --  isEnd                      = pvpArenaData.isEnd,                        --- 是否结束
        identity                   = pvpArenaData.identity,                     --- 身份 1:参选选手 2:观众
        quizTicketNum              = pvpArenaData.quizTicketNum,                --- 竞猜票数量
        leftQuizTicketBuyTimes     = pvpArenaData.leftQuizTicketBuyTimes,       --- 竞猜票剩余购买次数
        map                        = pvpArenaData.map,                          --- 对战表 key:位置ID
        matcherInfo                = pvpArenaData.matcherInfo,                  --- 比赛选手数据 key:玩家ID
        quizzed                    = pvpArenaData.quizzed,                      --- 已竞猜的玩家列表
        actionOrder                = pvpArenaData.actionOrder,                  ---[第一场顺序，第二场顺序]，1先0后 
        battleRound                = pvpArenaData.battleRound,                  --- 当前第几轮
    }
    print(table.serialize(data))

    return clone(data)
 end

 --- 竞猜
PVPArenaVirtualData.ArenaQuiz = function(req) 
    local matcherId            = req.matcherId
    pvpArenaData.quizTicketNum = pvpArenaData.quizTicketNum - 1
    table.insert(pvpArenaData.quizzed, matcherId)
    local quizzedNum = pvpArenaData.matcherInfo[tostring(matcherId)].quizzedNum
    pvpArenaData.matcherInfo[tostring(matcherId)].quizzedNum = quizzedNum + 1
    return {

    }
end

--- 赛季排名
PVPArenaVirtualData.ArenaSeasonRank = function(req) 
    local seasonId = pvpArenaData.seasonId
    local t = {rank = {}}
    -- if seasonId > 1 or (seasonId == 1 and pvpArenaData.seasonStatus == SeasonStatus.Closed) then
    local temp = 2
    for i = 1, Numbers, 1 do
        local playerInfo = CreatePlayer(i)
        
        if i < 4 then
            playerInfo.rank = i
        elseif i <= 2^temp then
            local r = 2^temp
            playerInfo.rank = r
            if i == r then
                temp = temp + 1
            end
        end
        table.insert(t.rank, playerInfo)
    end
    
    -- end
    return t
end

--- Arena/matcher (参赛者信息)
PVPArenaVirtualData.ArenaMatcher = function(req)
    local seasonId = pvpArenaData.seasonId
    local t = {rank = {}}
    if seasonId > 1 or (seasonId == 1 and pvpArenaData.seasonStatus == SeasonStatus.Closed) then
        local num = math.random(1, 10)
        local tt = {1, 2, 3, 4, 8, 16, 32, 64, 128}
        for i = 1, num, 1 do
            table.insert(t.rank, {
                rank = tt[math.random(1, #tt)],
                num = math.random(1, 10) 
            })
        end

    end
    return t
end
 

--- Arena/historySeason (往届第一名)
PVPArenaVirtualData.ArenaHistorySeason = function(req)
    local seasonId = pvpArenaData.seasonId
    local t = {history = {}}
    -- if seasonId > 1 or (seasonId == 1 and pvpArenaData.seasonStatus == SeasonStatus.Closed) then
        for year = 2020, 2025, 1 do
            local num = math.random(1, 10)
            for i = 1, num, 1 do
                local avatar, frame = RandomAvatarAndFrame()
                table.insert(t.history, {
                    seasonId    = i,                           --- int 第几届
                    year        = year,                        --- int 年份
                    playerId    = math.random(10000, 2000000), --- int 玩家ID
                    name        = RandomName(10),              --- string 玩家名称
                    level       = math.random(1, 200),         --- int 玩家等级
                    avatar      = avatar,                      --- 玩家头像
                    avatarFrame = frame,                       --- 玩家头像框
                })
            end
            
        end


    -- end
    return t
end

--- Arena/record （看录像）
PVPArenaVirtualData.ArenaRecord = function(req)
    local position    = pvpArenaData.position
    local cardConfMgr = CardConfMgr:GetInstance()
    local RandomCard = function()
        ---@type CardVo[]
        local cardVos = CfUtils.GetCf(AutoIds.IdSetting28, "CardVo", true)
        local cardVo = cardVos[math.random(1, #cardVos)]
        local cardSkinIds = CardConfMgr:GetInstance():GetCardSkinsByCardId(cardVo.roleId)
        local cardSkinId = cardSkinIds[math.random(1, #cardSkinIds)]
        return cardVo.roleId, cardSkinId
    end
    

    local CreateCard = function()
        local cardId, skinId = RandomCard()
        local star           = math.random(1, Constants.CardMaxStar)
        ---@type CardStarVo
        local starInfo  = cardConfMgr:GetCardStarInfo(cardId, star)
        local maxLevel  = starInfo.maxLevel
        return {
            cardId    = cardId,
            skinId    = skinId,
            cardLevel = math.random(1, maxLevel),
            star      = star,
        }
    end
    
    local winCards  = {
        {}, {}, {}
    }
    local loseCards = {
        {}, {}, {}
    }
    for i = 1, 3, 1 do
        local winCard = winCards[i]
        local loseCard = loseCards[i]
        for cardIndex = 1, 4, 1 do
            table.insert(winCard,  CreateCard())
            table.insert(loseCard, CreateCard())
        end
    end

    local teamInfo = {
        winPlayerId  = math.random(10000, 2000000), --- int 玩家ID
        winCombat    = math.random(100000, 2000000), --- int 玩家ID
        winCards     = winCards,
        losePlayerId = math.random(10000, 2000000), --- int 玩家ID
        loseCombat   = math.random(100000, 2000000), --- int 玩家ID
        loseCards    = loseCards
    }
   
    return {
        teamInfo = teamInfo,
        records  = {}
    }
end
 


return PVPArenaVirtualData