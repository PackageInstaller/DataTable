-------------------------------------------------------------------------------
-- 夜巡迷宫模块
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-29 15:25:15
-------------------------------------------------------------------------------

local GachaponUtils   = import('Game.Gachapon.GachaponUtils')
local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local ECSComponent    = import('Frame.ECS.ECSComponent')

---@class PatrolMazeComponent : ECSComponent
local PatrolMazeComponent = Class('PatrolMazeComponent', ECSComponent)


function PatrolMazeComponent:__init()
    self.name = 'PatrolMazeComponent'

    ---@type Engine.Modules.CDTimerModule
    self.endedTimer_ = nil

    ---@type PatrolMazeHomeDojo
    self.mazeHomeDojo_ = import('Game.Dojo.PatrolMaze.PatrolMazeHomeDojo').New()

    ---@type integer @ 当前所处的区域id
    self.currentAreaId_ = 0

    ---@type table<integer, PatrolMazeChapterVo[]> @ 剧情配表字典（key：剧情id，value：剧情vo列表）
    self.chapterVoMap_ = {}

    self.eventMazeStoryEnd_ = Events.AddListener(PatrolMazeUtils.EventsName.MAZE_CHAPTER_END, Bind(self, self.OnMazeStoryEndCallback_))
end


function PatrolMazeComponent:__delete()
    Events.RemoveListener(PatrolMazeUtils.EventsName.MAZE_CHAPTER_END, self.eventMazeStoryEnd_)
    self:EndedCountdownClean_()
    self.mazeHomeDojo_ = nil
    self.chapterVoMap_ = nil
end


-------------------------------------------------
-- get / set

---@return PatrolMazeHomeDojo
function PatrolMazeComponent:GetHomeDojo()
    return self.mazeHomeDojo_
end


---@return integer
function PatrolMazeComponent:GetCurrentAreaId()
    return self.currentAreaId_
end


---@return PatrolMazeAreaDojo
function PatrolMazeComponent:GetCurrentAreaDojo()
    return self:GetHomeDojo():GetAreaDojo(self:GetCurrentAreaId())
end


-------------------------------------------------------------------------------
-- home data
-------------------------------------------------------------------------------

--- 请求最新 夜巡迷宫入口数据
---@param callback fun():void
function PatrolMazeComponent:SyncMazeHomeData(callback)
    GameUtils.Request(Interfaces.OverseaMazeHome, {}, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- update homeDojo
            local responseData = checkTable(response.data)
            self:GetHomeDojo():Fill(responseData)

            -- check countdown
            if not self:GetHomeDojo().isEnded then
                self:EndedCountdownStart_()
            end

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


function PatrolMazeComponent:EndedCountdownClean_()
    if self.endedTimer_ then
        CfUtils.CDTimerRemove(self.endedTimer_)
        self.endedTimer_ = nil
    end
end


function PatrolMazeComponent:EndedCountdownStart_()
    self:EndedCountdownClean_()
    
    local countdownTime = math.max(checkInt(self:GetHomeDojo().remainTime), 1)
    self.endedTimer_ = CfUtils.CDTimerAppend(1, countdownTime, false, true, function(count, id, elapsed)

        -- update leftTime
        self:GetHomeDojo():UpdateRemainTime(self:GetHomeDojo().remainTime - elapsed)
        
        -- update areas
        for areaId, areaDojo in pairs(self:GetHomeDojo().areaDojoMap) do
            if not areaDojo.isTimeUnlocked then
                areaDojo:UpdateUnlockRemainTime(areaDojo.unlockRemainTime - elapsed)
            end
        end

        if Events.HasListener(Constants.EventNames.PATROL_MAZE_REMAIN_TIME_CHANGE) then
            Events.Broadcast(Constants.EventNames.PATROL_MAZE_REMAIN_TIME_CHANGE)
        end

        -- check timeover
        if count == 0 then
            -- 活动结束
        end
    end)
end


-------------------------------------------------------------------------------
-- area data
-------------------------------------------------------------------------------

--- 迷宫数据 指定区域最新数据
---@param mapAreaId integer
---@param callback fun():void
function PatrolMazeComponent:SyncMazeAreaData(mapAreaId, callback)
    local requestData = {areaId = checkInt(mapAreaId)}
    GameUtils.Request(Interfaces.OverseaMazeAreaHome, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update areaDojo
            local areaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            areaDojo:FillAreaData(responseData)

            -- update currentAreaId
            self.currentAreaId_ = checkInt(mapAreaId)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


--- 迷宫重置 指定区域重置
---@param mapAreaId integer
---@param callback fun():void
function PatrolMazeComponent:ResetMazeAreaData(mapAreaId, callback)
    local requestData = {areaId = checkInt(mapAreaId)}
    GameUtils.Request(Interfaces.OverseaMazeAreaReset, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- reset areaDojo
            local areaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            areaDojo:RebuildHomeData()

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


--- 迷宫保存 选定的楼层位置
---@param mapAreaId integer
---@param floorNum integer
---@param levelNum integer
---@param callback fun():void
function PatrolMazeComponent:SaveMazeAreaSelect(mapAreaId, floorNum, levelNum, callback)
    local requestData = {areaId = checkInt(mapAreaId), floor = floorNum, level = levelNum}
    GameUtils.Request(Interfaces.OverseaMazeAreaSafeFloor, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- reset areaDojo
            local areaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            local pathDojo = areaDojo.floorPathDojoList[floorNum]
            pathDojo.selectLevel = checkInt(levelNum)

            -- update relation
            areaDojo:UpdateFloorSelectLevel(floorNum, pathDojo.selectLevel)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


--- 迷宫移动 选择战斗结束圣物
---@param mapAreaId integer
---@param relicId integer
---@param callback fun(nextBuffList:integer[]):void
function PatrolMazeComponent:MoveMazeByQuestRelic(mapAreaId, relicId, callback)
    local chooseRelicId = checkInt(relicId)
    local mazeAreaDojo  = self:GetHomeDojo():GetAreaDojo(mapAreaId)
    local currentFloor  = mazeAreaDojo.floorPassed + 1
    local floorPathDojo = mazeAreaDojo.floorPathDojoList[currentFloor]
    local currentLevel  = floorPathDojo.selectLevel
    local requestData   = {areaId = mapAreaId, floor = currentFloor, level = currentLevel, relicId = chooseRelicId}
    GameUtils.Request(Interfaces.OverseaMazeQuestRelic, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local nextBuffList = checkTable(responseData.relicList)

            -- 添加选中的圣物
            mazeAreaDojo:AddMazeRelic(chooseRelicId)

            -- 如果不可继续选
            if #nextBuffList == 0 then
                -- 清空临时圣物数据
                mazeAreaDojo.tempChooseRelics = {}

                -- 完成当前层，向下走一层
                mazeAreaDojo.tempFloorPassed = mazeAreaDojo.floorPassed + 1
                mazeAreaDojo.tempPassedFloor = currentFloor
                mazeAreaDojo.tempPassedLevel = currentLevel
    
                -- 同步最新分数，记录老的分数
                mazeAreaDojo.tempMazeScore = mazeAreaDojo.mazeScore
                mazeAreaDojo.mazeScore     = checkInt(responseData.areaScore)
            end

            -- done callback
            if callback then
                callback(nextBuffList)
            end
        end
    end)
end


--- 迷宫移动 选择助战角色
---@param mapAreaId integer
---@param floorNum integer
---@param levelNum integer
---@param assistId integer
---@param callback fun():void
function PatrolMazeComponent:MoveMazeByAssistSelect(mapAreaId, floorNum, levelNum, assistId, callback)
    local requestData  = {areaId = mapAreaId, floor = floorNum, level = levelNum, assistId = assistId}
    GameUtils.Request(Interfaces.OverseaMazeAssistSelect, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- 获得一张新卡
            local mazeAreaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            mazeAreaDojo:AddMazeCard(responseData.cardData)

            -- 完成当前层，向下走一层
            mazeAreaDojo.tempFloorPassed = mazeAreaDojo.floorPassed + 1
            mazeAreaDojo.tempPassedFloor = floorNum
            mazeAreaDojo.tempPassedLevel = levelNum

            -- 同步最新分数，记录老的分数
            mazeAreaDojo.tempMazeScore = mazeAreaDojo.mazeScore
            mazeAreaDojo.mazeScore     = checkInt(responseData.areaScore)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


--- 迷宫移动 选择剧情选项
---@param mapAreaId integer
---@param addRelicCb fun(relicId:integer):void
---@param addCurseCb fun(curseId:integer):void
---@param addPointCb fun(addPoint:integer):void
---@param addGoodsCb fun(goodsList:table):void
---@param cureCardsCb fun(cureDatas:table):void
function PatrolMazeComponent:MoveMazeByStoryOption(mapAreaId, addRelicCb, addCurseCb, addPointCb, addGoodsCb, cureCardsCb)
    local mazeAreaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
    local choseData    = mazeAreaDojo.tempStoryChoseData
    local floorNum     = checkInt(choseData.floorNum)
    local levelNum     = checkInt(choseData.levelNum)
    local storyId      = checkInt(choseData.storyId)
    local choiceId     = checkInt(choseData.choice.choiceIndex)
    -- 剧情类型（1-迷宫专属道具 2-回血 3-圣物 4-诅咒 5-夜巡货币）	
    local requestData  = {areaId = mapAreaId, floor = floorNum, level = levelNum, optionId = choiceId}
    GameUtils.Request(Interfaces.OverseaMazeStoryOption, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            -- 清空剧情选择数据
            mazeAreaDojo.tempStoryChoseData = nil

            -- 完成当前层，向下走一层
            mazeAreaDojo.tempFloorPassed = mazeAreaDojo.floorPassed + 1
            mazeAreaDojo.tempPassedFloor = floorNum
            mazeAreaDojo.tempPassedLevel = levelNum

            -- 同步最新分数，记录老的分数
            mazeAreaDojo.tempMazeScore = mazeAreaDojo.mazeScore
            mazeAreaDojo.mazeScore     = checkInt(responseData.areaScore)

            local relicId   = checkInt(responseData.relicId)
            local curseId   = checkInt(responseData.curseId)
            local addPoint  = checkInt(responseData.point)
            local goodsList = checkTable(responseData.mazeGoods)
            local cureRoles = checkTable(responseData.cureRoles)
            if relicId > 0 then
                mazeAreaDojo:AddMazeRelic(relicId)

                -- done callback
                if addRelicCb then
                    addRelicCb(relicId)
                end

            elseif curseId > 0 then
                mazeAreaDojo:AddMazeCurse(curseId)

                -- done callback
                if addCurseCb then
                    addCurseCb(curseId)
                end

            elseif addPoint > 0 then
                mazeAreaDojo:AddMazePoint(addPoint)

                -- done callback
                if addPointCb then
                    addPointCb(addPoint)
                end

            elseif #goodsList > 0 then
                for _, goodsData in ipairs(goodsList) do
                    mazeAreaDojo:AddBackpackGoods(goodsData)
                end

                -- done callback
                if addGoodsCb then
                    addGoodsCb(goodsList)
                end

            else
                local cureDatas = {}
                for cureIndex, cureData in ipairs(cureRoles) do
                    local mazeCardId   = checkInt(cureData.id)
                    local hpPercent    = checkNumber(cureData.hpPercent)
                    local mazeCardDojo = mazeAreaDojo:GetMazeCard(mazeCardId)
                    cureDatas[cureIndex] = {
                        mazeCardId   = mazeCardId,
                        oldHpPercent = mazeCardDojo.hpPercent,
                        newHpPercent = hpPercent,
                    }
                    mazeCardDojo.hpPercent = hpPercent
                end

                -- done callback
                if cureCardsCb then
                    cureCardsCb(cureDatas)
                end
            end

        end
    end)
end


--- 迷宫移动 离开迷宫商店
---@param mapAreaId integer
---@param floorNum integer
---@param levelNum integer
---@param callback fun():void
function PatrolMazeComponent:MoveMazeByStoreOver(mapAreaId, floorNum, levelNum, callback)
    local requestData = {areaId = mapAreaId, floor = floorNum, level = levelNum}
    GameUtils.Request(Interfaces.OverseaMazeMallOver, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- 完成当前层，向下走一层
            local mazeAreaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            mazeAreaDojo.tempFloorPassed = mazeAreaDojo.floorPassed + 1
            mazeAreaDojo.tempPassedFloor = floorNum
            mazeAreaDojo.tempPassedLevel = levelNum

            -- 同步最新分数，记录老的分数
            mazeAreaDojo.tempMazeScore = mazeAreaDojo.mazeScore
            mazeAreaDojo.mazeScore     = checkInt(responseData.areaScore)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


-------------------------------------------------------------------------------
-- about cards
-------------------------------------------------------------------------------

--- 更新战斗编队
---@param mapAreaId integer
---@param teamMembers TeamMemberDojo[]
---@param callback fun():void
function PatrolMazeComponent:SyncMazeAreaTeam(mapAreaId, teamMembers, callback)
    local cardIdList = {}
    for _, member in ipairs(teamMembers) do
        local cardId = checkInt(member.refId)
        if cardId > 0 then
            table.insert(cardIdList, cardId)
        end
    end
    local requestData = {areaId = mapAreaId, cards = table.concat(cardIdList, ',')}
    GameUtils.Request(Interfaces.OverseaMazeAreaTeam, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update areaDojo
            local areaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            areaDojo:SetTeamMembers(cardIdList)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


-------------------------------------------------------------------------------
-- about goods
-------------------------------------------------------------------------------

--- 使用道具
---@param mapAreaId integer
---@param mazeGoodsId integer
---@param targetId integer | nil
---@param removeCursesCb fun(removeCurses:integer[]):void
---@param addEffectCb fun(mazeGoodsId:integer):void
---@param updateCardCb fun(cardData:table[]):void
---@param emptySucceedCb fun():void
function PatrolMazeComponent:UseMazeGoods(mapAreaId, mazeGoodsId, targetId, removeCursesCb, addEffectCb, updateCardCb, emptySucceedCb)
    local requestData = {areaId = mapAreaId, goodsId = mazeGoodsId, targetId = targetId}
    GameUtils.Request(Interfaces.OverseaMazeAreaUseGoods, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData   = checkTable(response.data)
            local usedCardList   = checkTable(responseData.cards)    -- 受影响的卡牌列表
            local removeCurses   = checkTable(responseData.curses)   -- 驱散的诅咒列表
            local newEffectGoods = checkTable(responseData.useGoods) -- 最新的道具效果（全量返回）

            -- consume goods
            local areaDojo = self:GetHomeDojo():GetAreaDojo(mapAreaId)
            areaDojo:ConsumeBackpackGoods(mazeGoodsId)

            local sendEventFunc = function()
                Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_GOODS_USED, {mapAreaId = mapAreaId, mazeGoodsId = mazeGoodsId})
            end

            if #removeCurses > 0 then
                for _, curseId in ipairs(removeCurses) do
                    areaDojo:DelMazeCurse(curseId)
                end

                -- done callback
                sendEventFunc()
                if removeCursesCb then
                    removeCursesCb(removeCurses)
                end

            elseif #newEffectGoods > 0 then
                for _, effectData in ipairs(newEffectGoods) do
                    areaDojo:AddEffectGoods(effectData)
                end

                -- done callback
                sendEventFunc()
                if addEffectCb then
                    addEffectCb()
                end

            elseif #usedCardList > 0 then
                local cardDataList = {}
                for _, cardData in ipairs(usedCardList) do
                    local cardDataId   = checkInt(cardData.id)
                    local mazeCardDojo = areaDojo:GetMazeCard(cardData.id)
                    local oldHpPercent = mazeCardDojo.hpPercent
                    local oldCardStar  = mazeCardDojo.cardDojo.star
                    mazeCardDojo:SetAddStar(cardData.addStar)
                    mazeCardDojo:SetHpPercent(cardData.hpPercent)
                    table.insert(cardDataList, {
                        mazeCardId   = cardDataId,
                        oldHpPercent = oldHpPercent,
                        oldCardStar  = oldCardStar,
                        newHpPercent = mazeCardDojo.hpPercent,
                        newCardStar  = mazeCardDojo.cardDojo.star,
                    })
                end
                -- done callback
                sendEventFunc()
                if updateCardCb then
                    updateCardCb(cardDataList)
                end

            else
                -- done callback
                sendEventFunc()
                if emptySucceedCb then
                    emptySucceedCb()
                end
            end

        end
    end)
end


-------------------------------------------------------------------------------
-- about story
-------------------------------------------------------------------------------

--- 初始化迷宫剧情数据
function PatrolMazeComponent:InitMazeChapterVos()
    ---@param chapterVo PatrolMazeChapterVo
    for _, chapterVo in ipairs(CfUtils.GetCf(AutoIds.IdSetting6133, 'PatrolMaze.PatrolMazeChapterVo', true)) do
        if not self.chapterVoMap_[chapterVo.storyId] then
            self.chapterVoMap_[chapterVo.storyId] = {}
        end
        table.insert(self.chapterVoMap_[chapterVo.storyId], chapterVo)
    end
end


--- 获取迷宫剧情数据
---@param storyId integer @ 剧情Id
---@return PatrolMazeChapterVo[]
function PatrolMazeComponent:GetMazeChapterData(storyId)
    if next(self.chapterVoMap_) == nil then
        self:InitMazeChapterVos()
    end

    if self.chapterVoMap_[storyId] then
        return self.chapterVoMap_[storyId]
    else
        printError("夜巡剧情表中 不存在对应的 storyId == %s 请检查 夜巡剧情表中为什么会配置这个storyId", storyId)
    end
    return nil
end


function PatrolMazeComponent:OnMazeStoryEndCallback_(event)
    local mazeAreaId   = checkInt(event.areaId)
    local mazeAreaDojo = self:GetHomeDojo():GetAreaDojo(mazeAreaId)
    mazeAreaDojo.tempStoryChoseData = event
end


return PatrolMazeComponent
