-------------------------------------------------------------------------------
-- 夜寻迷宫 - 区域数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:40:39
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeAreaDojo : BaseDojo
---@field New fun():PatrolMazeAreaDojo
local PatrolMazeAreaDojo = Class('PatrolMazeAreaDojo', BaseDojo)


function PatrolMazeAreaDojo:__init()
    ---@type integer @ 区域id
    self.areaId = 0

    ---@type integer @ 通关的层数
    self.floorPassed = 0

    ---@type integer @ 总层数
    self.floorLimit = 0

    ---@type integer @ 历史最高层数
    self.historyFloor = 0

    ---@type integer @ 解锁剩余时间
    self.unlockRemainTime = 0

    ---@type boolean @ 是否已时间解锁
    self.isTimeUnlocked = false

    ---@type boolean @ 是否设置了出战队伍
    self.hasAreaTeam = false

    ---@type boolean @ 是否进入过该区域
    self.isEntered = false

    ------------------------------------------------- [area]

    ---@type integer @ 夜巡迷宫货币
    self.mazePoint = 0

    ---@type integer @ 夜巡迷宫积分
    self.mazeScore = 0

    ---@type table<integer, integer> @ 迷宫背包道具map
    self.mazeBackpackMap = {}
    ---@type integer[] @ 背包道具id列表
    self.mazeBackpackList = {}

    ---@type table<integer, PatrolMazeCardDojo> @ 全卡牌数据字典（key：卡牌自增id，value：迷宫卡牌dojo）
    self.mazeCardDojoMap = {}
    ---@type PatrolMazeCardDojo[] @ 全卡牌数据列表
    self.mazeCardDojoList = {}
    ---@type table<integer, boolean> @ 助理卡牌id字典（key：助理id，value：是否拥有）
    self.mazeAssistIdMap = {}

    ---@type TeamMemberDojo[] @ 出站的编队数据
    self.teamMemberDojoList = {}

    ---@type PatrolMazeFloorPathDojo[] @ 层级路线数据列表
    self.floorPathDojoList = {}

    ---@type table<integer, boolean> @ 楼层奖励领取记录
    self.floorRewardDrawMap = {}

    ---@type table<integer, integer> @ 圣物id字典（key：所属分组id，value：圣物id）
    self.mazeRelicIdMap  = {}
    ---@type integer[] @ 圣物id列表
    self.mazeRelicIdList = {}
    
    ---@type integer[] @ 诅咒id列表
    self.mazeCurseIdList = {}

    ---@type table<integer, table> @ 生效道具map（key：道具id，value：道具数据）
    self.effectGoodsMap = {}
    ---@type integer[] @ 生效道具id列表
    self.effectGoodsList = {}

    ---@type integer @ 推荐方案id
    self.recommandPlanId = 0
    ---@type table<integer, boolean> @ 推荐方案圣物id map
    self.recommandRelicMap = {}

    ------------------------------------------------- [temp]

    ---@type integer @ 临时通关层数（某件事执行完成，需要主界面更新层数）
    self.tempFloorPassed = 0

    ---@type integer @ 临时-通关的层位置
    self.tempPassedFloor = 0

    ---@type integer @ 临时-通关的级位置
    self.tempPassedLevel = 0

    ---@type integer @ 临时老的积分（-1无效的积分值，禁止做动画的标识）
    self.tempMazeScore = -1
    
    ---@type integer[] @ 临时选择圣物数据（通关后未选择才有）
    self.tempChooseRelics = {}

    ---@type table @ 临时剧情选择选项结果
    self.tempStoryChoseData = nil

    ---@type integer @ 战斗通关数据
    self.tempPassedQuestData = nil

    ---@type integer @ 选中的路径位置
    self.selectFloorIndex = 0

    ---@type integer @ 选中的楼层位置
    self.selectLevelIndex = 0
end


function PatrolMazeAreaDojo:__delete()
    self.areaId              = nil
    self.floorPassed         = nil
    self.floorLimit          = nil
    self.historyFloor        = nil
    self.unlockRemainTime    = nil
    self.isTimeUnlocked      = nil
    self.hasAreaTeam         = nil
    self.isEntered           = nil
    --                       = area
    self.mazePoint           = nil
    self.mazeScore           = nil
    self.mazeBackpackMap     = nil
    self.mazeBackpackList    = nil
    self.mazeCardDojoMap     = nil
    self.mazeAssistIdMap     = nil
    self.mazeCardDojoList    = nil
    self.teamMemberDojoList  = nil
    self.floorPathDojoList   = nil
    self.floorRewardDrawMap  = nil
    self.mazeRelicIdMap      = nil
    self.mazeRelicIdList     = nil
    self.mazeCurseIdList     = nil
    self.effectGoodsMap      = nil
    self.effectGoodsList     = nil
    self.recommandPlanId     = nil
    self.recommandRelicMap   = nil
    --                       = temp
    self.selectFloorIndex    = nil
    self.selectLevelIndex    = nil
    self.tempFloorPassed     = nil
    self.tempPassedFloor     = nil
    self.tempPassedLevel     = nil
    self.tempMazeScore       = nil
    self.tempChooseRelics    = nil
    self.tempStoryChoseData  = nil
    self.tempPassedQuestData = nil
end


-------------------------------------------------------------------------------
-- home data
-------------------------------------------------------------------------------

---@param jsonData table
---@return PatrolMazeAreaDojo
function PatrolMazeAreaDojo:FillHomeData(jsonData)
    self:RebuildHomeData()
    self.areaId       = checkInt(jsonData.areaId)
    self.floorLimit   = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.FLOOR_ENDED_NUM)
    self.floorPassed  = checkInt(jsonData.passedFloor)
    self.historyFloor = checkInt(jsonData.historyFloor)
    self.hasAreaTeam  = checkInt(jsonData.hasAreaTeam) == 1
    self.isEntered    = checkInt(jsonData.isEntered) == 1
    self:UpdateUnlockRemainTime(jsonData.unlockRemainTime)
    return self
end


function PatrolMazeAreaDojo:RebuildHomeData()
    self.floorPassed = 0      -- 通关层数 重置
    self.hasAreaTeam = false  -- 出战状态 标记为未进入
    -- reset area temp
    self.selectFloorIndex    = 0
    self.selectLevelIndex    = 0
    self.tempFloorPassed     = 0
    self.tempPassedFloor     = 0
    self.tempPassedLevel     = 0
    self.tempMazeScore       = -1
    self.tempStoryChoseData  = nil
    self.tempPassedQuestData = nil
end


---@param remainTime integer
function PatrolMazeAreaDojo:UpdateUnlockRemainTime(remainTime)
    self.unlockRemainTime = checkInt(remainTime)
    
    if self.unlockRemainTime <= 0 then
        self.isTimeUnlocked = true

        if Events.HasListener(Constants.EventNames.PATROL_MAZE_PRIMARY_AREA_UNLOCKED) then
            Events.Broadcast(Constants.EventNames.PATROL_MAZE_PRIMARY_AREA_UNLOCKED, self.areaId)
        end
    end
end


---是否 全部通关
---@return boolean
function PatrolMazeAreaDojo:IsPassedAll()
    return self.floorPassed >= self.floorLimit
end


-------------------------------------------------------------------------------
-- area data
-------------------------------------------------------------------------------

---@param jsonData table
---@return PatrolMazeAreaDojo
function PatrolMazeAreaDojo:FillAreaData(jsonData)

    ------------------------------------------------- [goods]

    -- maze point / score
    self.mazePoint = checkInt(jsonData.point)
    self.mazeScore = checkInt(jsonData.score)

    -- maze goods
    self.mazeBackpackMap  = {}
    self.mazeBackpackList = {}
    for _, goodsData in ipairs(checkTable(jsonData.backpack)) do
        self:AddBackpackGoods(goodsData)
    end

    ------------------------------------------------- [card]

    -- all cards
    self.mazeCardDojoMap  = {}
    self.mazeCardDojoList = {}
    for cardIndex, mazeCardData in ipairs(checkTable(jsonData.cards)) do
        self:AddMazeCard(mazeCardData)
    end

    -- team cards
    self:SetTeamMembers(jsonData.team)

    ------------------------------------------------- [floor]

    -- floor path
    self.floorPathDojoList = {}
    for floorIndex, mazeFloorData in ipairs(checkTable(jsonData.floors)) do
        local mazeFloorDojo = import('Game.Dojo.PatrolMaze.PatrolMazeFloorPathDojo').New()
        self.floorPathDojoList[floorIndex] = mazeFloorDojo:Fill(mazeFloorData)
        if floorIndex > 1 then
            -- set parents
            local parentFloorDojo = self.floorPathDojoList[floorIndex - 1]
            for levelIndex, parentLevelDojo in ipairs(parentFloorDojo.levelDojoList) do
                for childLevel, _ in pairs(parentLevelDojo.childrenMap) do
                    local childLevelNum  = checkInt(childLevel)
                    local childLevelDojo = mazeFloorDojo.levelDojoList[childLevelNum]
                    childLevelDojo:AddParentLevel(parentLevelDojo.floorLevel)
                    -- check relation
                    if not parentLevelDojo:IsInvalidLevel() then
                        self:InvalidFloorPathLevel(levelIndex, floorIndex, childLevelNum)
                    end
                end
            end
        end
        if mazeFloorDojo.selectLevel > 0 then
            self:UpdateFloorSelectLevel(floorIndex, mazeFloorDojo.selectLevel)
        end
    end

    -- floor rewards
    self.floorRewardDrawMap = {}
    for _, floorRewardId in ipairs(checkTable(jsonData.drawnRewards)) do
        self:AddFloorRewardDrawn(floorRewardId)
    end

    ------------------------------------------------- [buff]

    -- relics / curses
    self.mazeRelicIdMap  = {}
    self.mazeRelicIdList = {}
    self.mazeCurseIdList = {}
    self.effectGoodsMap  = {}
    self.effectGoodsList = {}
    for _, relicId in ipairs(checkTable(jsonData.relics)) do
        self:AddMazeRelic(relicId)
    end
    for _, curseId in ipairs(checkTable(jsonData.curses)) do
        self:AddMazeCurse(curseId)
    end
    for _, effectData in ipairs(checkTable(jsonData.useGoods)) do
        self:AddEffectGoods(effectData)
    end


    ------------------------------------------------- [plan]

    self.recommandPlanId   = checkInt(jsonData.planId)
    self.recommandRelicMap = {}
    if self.recommandPlanId == -1 then
        for _, relicId in ipairs(checkTable(jsonData.planRelics)) do
            self.recommandRelicMap[relicId] = true
        end
    elseif self.recommandPlanId > 0 then
        for _, recommendVo in ipairs(PatrolMazeUtils.GetMazeRecommendVoList(self.areaId)) do
            if recommendVo.recommendIndex == self.recommandPlanId then
                for _, relicId in ipairs(checkTable(recommendVo.relicIdList)) do
                    self.recommandRelicMap[relicId] = true
                end
                break
            end
        end
    end


    ------------------------------------------------- [temp]
    
    -- temp chooseRelics
    self.tempChooseRelics = checkTable(jsonData.chooseRelics)
end


--- 更新选中路线的相邻层级关系
---@param floorNum integer
---@param selectLevel integer
function PatrolMazeAreaDojo:UpdateFloorSelectLevel(floorNum, selectLevel)
    local currentPathDojo = self.floorPathDojoList[floorNum]
    local selectLevelDojo = currentPathDojo.levelDojoList[selectLevel]
    for parentLevel, _ in pairs(selectLevelDojo.parentsMap) do
        local parentLevelNum  = checkInt(parentLevel)
        local parentFloorNum  = floorNum - 1
        local parentPathDojo  = self.floorPathDojoList[parentFloorNum]
        local parentLevelDojo = parentPathDojo.levelDojoList[parentLevelNum]
        -- 过滤掉不处理平行的无效路线（有多个父节点时，未选中的那个父节点就是无效点，衍生的都是无效路线）
        if parentLevelDojo:IsInvalidLevel() then
            for brotherLevel, _ in pairs(parentLevelDojo.childrenMap) do
                -- 不等于自己，就是兄弟节点
                local brotherLevelNum = checkInt(brotherLevel)
                if brotherLevelNum ~= selectLevelDojo.floorLevel then
                    self:InvalidFloorPathLevel(parentLevelNum, floorNum, brotherLevelNum)
                end
            end
        end
    end
end


--- 无效化一条路线的所有子路径
---@param floorNum integer
---@param levelNum integer
function PatrolMazeAreaDojo:InvalidFloorPathLevel(parentLevel, floorNum, levelNum)
    -- 递归保护
    if floorNum > #self.floorPathDojoList then return end

    local parentFloorNum  = floorNum - 1
    local parentPathDojo  = self.floorPathDojoList[parentFloorNum]
    local parentLevelDojo = parentPathDojo and parentPathDojo.levelDojoList[parentLevel] or nil
    -- 关闭父节点和子级的关系
    if parentLevelDojo then
        parentLevelDojo:InvalidChildLevel(levelNum)
    end

    -- 关闭子节点和父级的关系
    local currentPathDojo  = self.floorPathDojoList[floorNum]
    local currentLevelDojo = currentPathDojo and currentPathDojo.levelDojoList[levelNum] or nil
    if currentLevelDojo then
        currentLevelDojo:InvalidParentLevel(parentLevel)
    
        -- 当前节点是否已经无效，继续向下传递无效化
        if not currentLevelDojo:IsInvalidLevel() then
            for childLevel, _ in pairs(currentLevelDojo.childrenMap) do
                self:InvalidFloorPathLevel(levelNum, floorNum + 1, checkInt(childLevel))
            end
        end
    end
end


-------------------------------------------------------------------------------
-- card data 
-------------------------------------------------------------------------------

--- 添加一个 迷宫卡牌数据
---@param jsonData table
---@return PatrolMazeAreaDojo
function PatrolMazeAreaDojo:AddMazeCard(jsonData)
    local mazeCardDojo = import('Game.Dojo.PatrolMaze.PatrolMazeCardDojo').New()
    table.insert(self.mazeCardDojoList, mazeCardDojo:Fill(jsonData))
    self.mazeCardDojoMap[tostring(mazeCardDojo.id)] = mazeCardDojo
    if mazeCardDojo.isAssist then
        self.mazeAssistIdMap[mazeCardDojo.assistId] = true
    end
    return self
end


--- 获取 一个指定的 迷宫卡牌数据
---@param mazeCardId integer
---@return PatrolMazeCardDojo
function PatrolMazeAreaDojo:GetMazeCard(mazeCardId)
    return self.mazeCardDojoMap[tostring(mazeCardId)]
end


--- 是否 拥有指定id的助理卡
---@param assistId integer
---@return boolean
function PatrolMazeAreaDojo:HasMazeAssistCard(assistId)
    return checkBool(self.mazeAssistIdMap[assistId])
end


--- 获取 全部存活的卡牌数据
---@return CardDojo[]
function PatrolMazeAreaDojo:GetAliveCardDojoList()
    local cardDojoList = {}
    for _, mazeCardDojo in pairs(self.mazeCardDojoMap) do
        if mazeCardDojo.hpPercent > 0 then
            table.insert(cardDojoList, mazeCardDojo:GetCardDojo())
        end
    end
    return cardDojoList
end


-------------------------------------------------------------------------------
-- team data
-------------------------------------------------------------------------------

--- 设置 编队成员数据
---@param cardIdList string[] | integer[]
function PatrolMazeAreaDojo:SetTeamMembers(cardIdList)
    self.teamMemberDojoList = {}
    for memberIndex, mazeCardId in ipairs(checkTable(cardIdList)) do
        local mazeCardDojo   = self:GetMazeCard(mazeCardId)
        local teamMemberDojo = self:GetTeamMemberDojo(mazeCardDojo.id, mazeCardDojo.cardId)
        table.insert(self.teamMemberDojoList, teamMemberDojo)
    end
end


--- 生成 一个编队数据dojo
---@param refId integer
---@param cardId integer
function PatrolMazeAreaDojo:GetTeamMemberDojo(refId, cardId)
    local teamMemberDojo = CfUtils.GetTeamMemberDojo({
        refId  = checkInt(refId),
        cardId = checkInt(cardId),
        type   = Constants.TeamMemberType.PatrolMazeCard,
    })
    teamMemberDojo.areaId = self.areaId  -- 必要的，teamComponent:GetTeamFightingPower 中使用
    return teamMemberDojo
end


-------------------------------------------------------------------------------
-- floor reward
-------------------------------------------------------------------------------

--- 是否 领取楼层奖励
---@param floorRewardId integer
---@return boolean
function PatrolMazeAreaDojo:HasFloorRewardDrawn(floorRewardId)
    return checkBool(self.floorRewardDrawMap[checkInt(floorRewardId)])
end


--- 记录 领取楼层奖励
---@param floorRewardId integer
---@return boolean
function PatrolMazeAreaDojo:AddFloorRewardDrawn(floorRewardId)
    self.floorRewardDrawMap[checkInt(floorRewardId)] = true
end


-------------------------------------------------------------------------------
-- buff data
-------------------------------------------------------------------------------

--- 添加 圣物id
---@param relicId integer @ 圣物id
---@return boolean
function PatrolMazeAreaDojo:AddMazeRelic(relicId)
    local newMazeRelicId = checkInt(relicId)
    local newMazeRelicVo = PatrolMazeUtils.GetMazeRelicVo(newMazeRelicId)
    -- 是否 已有该分数圣物
    if self.mazeRelicIdMap[newMazeRelicVo.teamId] then
        local oldMazeRelicId = self.mazeRelicIdMap[newMazeRelicVo.teamId]
        local oldMazeRelicVo = PatrolMazeUtils.GetMazeRelicVo(oldMazeRelicId)
        -- 高于已有的圣物品质，则替换；否则无视
        if newMazeRelicVo.quality > oldMazeRelicVo.quality then
            self.mazeRelicIdMap[newMazeRelicVo.teamId] = newMazeRelicId
            table.removebyvalue(self.mazeRelicIdList, oldMazeRelicId)
            table.insert(self.mazeRelicIdList, newMazeRelicId)
            return true
        end
    else
        -- 未拥有的话，直接添加
        self.mazeRelicIdMap[newMazeRelicVo.teamId] = newMazeRelicId
        table.insert(self.mazeRelicIdList, newMazeRelicId)
        return true
    end
    return false
end


--- 添加 诅咒id
---@param curseId integer @ 诅咒id
---@return boolean
function PatrolMazeAreaDojo:AddMazeCurse(curseId)
    -- 诅咒无条件添加，可重复获得
    table.insert(self.mazeCurseIdList, checkInt(curseId))
    return true
end


--- 删除 诅咒id
---@param curseId integer @ 诅咒id
---@return boolean
function PatrolMazeAreaDojo:DelMazeCurse(curseId)
    table.removebyvalue(self.mazeCurseIdList, checkInt(curseId))
    return true
end


--- 是否 拥有指定效果的 诅咒
---@param crseEffectType PatrolMazeUtils.CurseEffectType
---@return boolean
function PatrolMazeAreaDojo:HasMazeCurseByEffect(crseEffectType)
    local hasEffectTypeCurse = false
    for _, mazeCurseId in ipairs(self.mazeCurseIdList) do
        local mazeCurseVo = PatrolMazeUtils.GetMazeCurseVo(mazeCurseId)
        if mazeCurseVo.effectType == crseEffectType then
            hasEffectTypeCurse = true
            break
        end
    end
    return hasEffectTypeCurse
end


--- 添加 道具效果
---@param efffectData table @ 效果数据
function PatrolMazeAreaDojo:AddEffectGoods(efffectData)
    local effectGoodsId = checkInt(efffectData.goodsId)
    if self.effectGoodsMap[effectGoodsId] then
        self.effectGoodsMap[effectGoodsId] = efffectData
    else
        self.effectGoodsMap[effectGoodsId] = efffectData
        table.insert(self.effectGoodsList, effectGoodsId)
    end
end


--- 是否 拥有指定id的道具效果
---@param mazeGoodsId integer
function PatrolMazeAreaDojo:HasEffectGoods(mazeGoodsId)
    local effectGoodsId = checkInt(mazeGoodsId)
    return self.effectGoodsMap[effectGoodsId] ~= nil
end


-------------------------------------------------------------------------------
-- goods data
-------------------------------------------------------------------------------

--- 添加 迷宫货币数量
---@param addPoint integer
function PatrolMazeAreaDojo:AddMazePoint(addPoint)
    self.mazePoint = self.mazePoint + checkInt(addPoint)
    Events.Broadcast(Constants.EventNames.EveryThingChangeEventName)
end


--- 添加 迷宫货积分
---@param addScore integer
function PatrolMazeAreaDojo:AddMazeScore(addScore)
    self.mazeScore = self.mazeScore + checkInt(addScore)
end


--- 添加 背包道具数据
---@param goodsData table
function PatrolMazeAreaDojo:AddBackpackGoods(goodsData)
    local goodsId  = checkInt(goodsData.goodsId)
    local goodsNum = checkInt(goodsData.num)
    if self.mazeBackpackMap[goodsId] then
        self.mazeBackpackMap[goodsId] = self.mazeBackpackMap[goodsId] + goodsNum
    else
        self.mazeBackpackMap[goodsId] = goodsNum
        table.insert(self.mazeBackpackList, goodsId)
    end
end


--- 消耗 背包道具
---@param goodsId integer
function PatrolMazeAreaDojo:ConsumeBackpackGoods(goodsId)
    self.mazeBackpackMap[goodsId] = checkInt(self.mazeBackpackMap[goodsId]) - 1
    if self.mazeBackpackMap[goodsId] <= 0 then
        self.mazeBackpackMap[goodsId] = nil
        table.removebyvalue(self.mazeBackpackList, goodsId)
    end
end


--- 获取 背包道具数量
---@param goodsId integer
---@return integer
function PatrolMazeAreaDojo:GetBackpackGoodsNum(goodsId)
    return checkInt(self.mazeBackpackMap[checkInt(goodsId)])
end


return PatrolMazeAreaDojo
