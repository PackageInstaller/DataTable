--[[ 
-----------------------------------------------------
@filename       : EliminateObjManager
@Description    : 消消乐物件管理
@date           : 2020-12-24 16:31:09
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminateObjManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self:resetTimerList()
    self:resetTileDic()
    self:resetThingDic()
    eliminate.EliminateEffectExecutor:reset()

    self.mTileItemGo = nil
    self.mThingItemGo = nil
    self.mTileLayerTrans = nil
    self.mThingLayerTrans = nil
end

function resetTimerList(self)
    if(self.mTimerList)then
        for _, timerSn in pairs(self.mTimerList) do
            LoopManager:removeTimerByIndex(timerSn)
        end
    end
    self.mTimerList = {}
end

function resetTileDic(self)
    if(self.mTileDic)then
        for keyRowCol, tile in pairs(self.mTileDic) do
            LuaPoolMgr:poolRecover(tile)
        end
    end
    self.mTileDic = {}

    if(self.mTileVoDic)then
        for keyRowCol, tileVo in pairs(self.mTileVoDic) do
            LuaPoolMgr:poolRecover(tileVo)
        end
    end
    self.mTileVoDic = {}
end

function resetThingDic(self)
    if(self.mThingDic)then
        for keyRowCol, thing in pairs(self.mThingDic) do
            LuaPoolMgr:poolRecover(thing)
        end
    end
    self.mThingDic = {}

    if(self.mThingVoDic)then
        for keyRowCol, thingVo in pairs(self.mThingVoDic) do
            LuaPoolMgr:poolRecover(thingVo)
        end
    end
    self.mThingVoDic = {}
end

function initConfigMap(self, tileItemGo, thingItemGo, tileLayerTrans, thingLayerTrans, effectLayerTrans)
    self:resetTimerList()
    self:resetTileDic()
    self:resetThingDic()
    eliminate.EliminateEffectExecutor:reset()

    -- 单格子单次移动时间
    local onceMoveTime = 0.07
    -- 填充的最大时间
    local maxMoveTime = 0

    self.mTileItemGo = tileItemGo or self.mTileItemGo
    self.mThingItemGo = thingItemGo or self.mThingItemGo
    self.mTileLayerTrans = tileLayerTrans or self.mTileLayerTrans
    self.mThingLayerTrans = thingLayerTrans or self.mThingLayerTrans
    eliminate.EliminateEffectExecutor:init(effectLayerTrans)

    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    local mapTileConfigDic = eliminate.EliminateManager:getTileConfigDic(stageConfigVo.mapId)
    for keyRowCol, tileConfigVo in pairs(mapTileConfigDic) do
        local tileVo = LuaPoolMgr:poolGet(eliminate.EliminateTileVo)
        tileVo:setConfig(stageConfigVo, tileConfigVo)
        local keyRowCol = eliminate.GetTileIdByRowCol(tileVo.rowIndex, tileVo.colIndex)
        self.mTileVoDic[keyRowCol] = tileVo
        local tileItem = LuaPoolMgr:poolGet(eliminate.EliminateTile)
        self.mTileDic[keyRowCol] = tileItem
        tileItem:create(tileVo, self.mTileItemGo, self.mTileLayerTrans)
        
        if(tileConfigVo.thingType ~= eliminate.ThingType.Empty)then
            local topTileConfigVo = eliminate.EliminateManager:getTopTileConfigVoByCol(stageConfigVo.mapId, tileConfigVo.colIndex)
            local bottomTileConfigVo = eliminate.EliminateManager:getBottomTileConfigVoByCol(stageConfigVo.mapId, tileConfigVo.colIndex)
            local maxRowIndex = topTileConfigVo and topTileConfigVo.rowIndex or stageConfigVo.mapRow
            local minRowIndex = bottomTileConfigVo and bottomTileConfigVo.rowIndex or bottomTileConfigVo.mapRow

            local thingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            thingVo:setConfig(stageConfigVo, tileConfigVo)
            thingVo.rowIndex = thingVo.rowIndex - minRowIndex + maxRowIndex + 1
            local thing = self:addThing(thingVo)

            self.mThingDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)] = nil
            self.mThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)] = nil
            self.mThingDic[eliminate.GetTileIdByRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex)] = thing
            self.mThingVoDic[eliminate.GetTileIdByRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex)] = thingVo

            local moveTime = (thingVo.rowIndex - tileConfigVo.rowIndex) * onceMoveTime
            maxMoveTime = math.max(maxMoveTime, moveTime)
            thingVo.rowIndex = tileConfigVo.rowIndex
            thingVo:setMoveToRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex, nil, moveTime, gs.DT.Ease.Linear, gs.DT.Ease.Linear)
        end
    end
    
    if(maxMoveTime > 0)then
        table.insert(self.mTimerList, LoopManager:addTimer(maxMoveTime, 1, self, function() self:checkAllFillThing() end))
    else
        self:checkAllFillThing()
    end
end

function initRandomMap(self)
    self:resetTimerList()
    self:resetThingDic()
    eliminate.EliminateEffectExecutor:reset()

    -- 单格子单次移动时间
    local onceMoveTime = 0.07
    -- 填充的最大时间
    local maxMoveTime = 0

    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    local mapTileConfigDic = eliminate.EliminateManager:getTileConfigDic(stageConfigVo.mapId)
    for keyRowCol, tileConfigVo in pairs(mapTileConfigDic) do
        local topTileConfigVo = eliminate.EliminateManager:getTopTileConfigVoByCol(stageConfigVo.mapId, tileConfigVo.colIndex)
        local bottomTileConfigVo = eliminate.EliminateManager:getBottomTileConfigVoByCol(stageConfigVo.mapId, tileConfigVo.colIndex)
        local maxRowIndex = topTileConfigVo and topTileConfigVo.rowIndex or stageConfigVo.mapRow
        local minRowIndex = bottomTileConfigVo and bottomTileConfigVo.rowIndex or bottomTileConfigVo.mapRow

        local thingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
        thingVo:setConfig(stageConfigVo, tileConfigVo)
        thingVo.thingType = eliminate.GetRandomThingType()
        thingVo.rowIndex = thingVo.rowIndex - minRowIndex + maxRowIndex + 1
        local thing = self:addThing(thingVo)

        self.mThingDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)] = nil
        self.mThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)] = nil
        self.mThingDic[eliminate.GetTileIdByRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex)] = thing
        self.mThingVoDic[eliminate.GetTileIdByRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex)] = thingVo

        local moveTime = (thingVo.rowIndex - tileConfigVo.rowIndex) * onceMoveTime
        maxMoveTime = math.max(maxMoveTime, moveTime)
        thingVo.rowIndex = tileConfigVo.rowIndex
        thingVo:setMoveToRowCol(tileConfigVo.rowIndex, tileConfigVo.colIndex, nil, moveTime, gs.DT.Ease.Linear, gs.DT.Ease.Linear)
    end
    if(maxMoveTime > 0)then
        table.insert(self.mTimerList, LoopManager:addTimer(maxMoveTime, 1, self, function() self:checkAllFillThing() end))
    else
        self:checkAllFillThing()
    end
end

function addThing(self, thingVo)
    local keyRowCol = eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)
    self.mThingVoDic[keyRowCol] = thingVo
    local thingItem = LuaPoolMgr:poolGet(eliminate.EliminateThing)
    self.mThingDic[keyRowCol] = thingItem
    thingItem:create(thingVo, self.mThingItemGo, self.mThingLayerTrans)
    return thingItem
end

function getThingByRowCol(self, rowIndex, colIndex)
    return self.mThingDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
end

function getThingVoByRowCol(self, rowIndex, colIndex)
    return self.mThingVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
end

function getTileByRowCol(self, rowIndex, colIndex)
    return self.mTileDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
end

function getTileVoByRowCol(self, rowIndex, colIndex)
    return self.mTileVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
end

function getTopTileVoByCol(self, colIndex)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    for rowIndex = stageConfigVo.mapRow, 1, -1 do
        local tileVo = self.mTileVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
        if(tileVo)then
            return tileVo
        end
    end
end

function getBottomTileVoByCol(self, colIndex)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    for rowIndex = 1, stageConfigVo.mapRow do
        local tileVo = self.mTileVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)]
        if(tileVo)then
            return tileVo
        end
    end
end

function removeThing(self, thingVo)
    local keyRowCol = eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)
    local thing = self.mThingDic[keyRowCol]
    LuaPoolMgr:poolRecover(thing)
    self.mThingDic[keyRowCol] = nil
    LuaPoolMgr:poolRecover(thingVo)
    self.mThingVoDic[keyRowCol] = nil
end

function swapThing(self, startThingVo, endThingVo, finishCall)
    if(startThingVo and endThingVo)then
        self:swapThingVo(startThingVo, endThingVo)
        startThingVo:setMoveToRowCol(startThingVo.rowIndex, startThingVo.colIndex, nil, 0.14, gs.DT.Ease.Linear, gs.DT.Ease.Linear)
        endThingVo:setMoveToRowCol(endThingVo.rowIndex, endThingVo.colIndex, finishCall, 0.14, gs.DT.Ease.Linear, gs.DT.Ease.Linear)
    end
end

function swapThingVo(self, startThingVo, endThingVo)
    if(startThingVo and endThingVo)then
        local startRowIndex, startColIndex = startThingVo.rowIndex, startThingVo.colIndex
        local endRowIndex, endColIndex = endThingVo.rowIndex, endThingVo.colIndex
        local startThing, endThing = self:getThingByRowCol(startRowIndex, startColIndex), self:getThingByRowCol(endRowIndex, endColIndex)
        startThingVo.rowIndex, startThingVo.colIndex = endRowIndex, endColIndex
        endThingVo.rowIndex, endThingVo.colIndex = startRowIndex, startColIndex
        self.mThingVoDic[eliminate.GetTileIdByRowCol(startRowIndex, startColIndex)] = endThingVo
        self.mThingVoDic[eliminate.GetTileIdByRowCol(endRowIndex, endColIndex)] = startThingVo
        self.mThingDic[eliminate.GetTileIdByRowCol(startRowIndex, startColIndex)] = endThing
        self.mThingDic[eliminate.GetTileIdByRowCol(endRowIndex, endColIndex)] = startThing
    end
end

-- 获取所有方格的同类型匹配列表
function getAllMatchThingVoDic(self, minRowIndex, minColIndex, maxRowIndex, maxColIndex)
    local allMatchThingVoDic = {}
    for rowIndex = minRowIndex, maxRowIndex do
        for colIndex = minColIndex, maxColIndex do
            local matchThingVoDic = self:getMatchThingVoDic(rowIndex, colIndex, minRowIndex, minColIndex, maxRowIndex, maxColIndex)
            for keyRowCol, thingVo in pairs(matchThingVoDic) do
                if(not allMatchThingVoDic[keyRowCol])then
                    allMatchThingVoDic[keyRowCol] = thingVo
                end
            end
        end
    end
    return allMatchThingVoDic
end

-- 获取指定方格的同类型匹配列表
function getMatchThingVoDic(self, matchRowIndex, macthColIndex, minRowIndex, minColIndex, maxRowIndex, maxColIndex)
    local matchThingVoDic = {}
    local thingVo = self:getThingVoByRowCol(matchRowIndex, macthColIndex)
    local tempVerticalList = {thingVo}
    local tempHorizontalList = {thingVo}
    -- 左匹配
    for leftColIndex = macthColIndex - 1, minColIndex, -1 do
        local leftThingVo = self:getThingVoByRowCol(matchRowIndex, leftColIndex)
        if(thingVo and leftThingVo and eliminate.GetIsCanMatch(thingVo.thingType, leftThingVo.thingType))then
            table.insert(tempVerticalList, leftThingVo)
        else
            break
        end
    end
    -- 右匹配
    for rightColIndex = macthColIndex + 1, maxColIndex do
        local rightThingVo = self:getThingVoByRowCol(matchRowIndex, rightColIndex)
        if(thingVo and rightThingVo and eliminate.GetIsCanMatch(thingVo.thingType, rightThingVo.thingType))then
            table.insert(tempVerticalList, rightThingVo)
        else
            break
        end
    end
    if(#tempVerticalList >= 3)then
        for i = 1, #tempVerticalList do
            local _thingVo = tempVerticalList[i]
            local keyRowCol = eliminate.GetTileIdByRowCol(_thingVo.rowIndex, _thingVo.colIndex)
            matchThingVoDic[keyRowCol] = _thingVo
        end
    end
    -- 下匹配
    for bottomRowIndex = matchRowIndex - 1, minRowIndex, -1 do
        local bottomThingVo = self:getThingVoByRowCol(bottomRowIndex, macthColIndex)
        if(thingVo and bottomThingVo and eliminate.GetIsCanMatch(thingVo.thingType, bottomThingVo.thingType))then
            table.insert(tempHorizontalList, bottomThingVo)
        else
            break
        end
    end
    -- 上匹配
    for topRowIndex = matchRowIndex + 1, maxRowIndex do
        local topThingVo = self:getThingVoByRowCol(topRowIndex, macthColIndex)
        if(thingVo and topThingVo and eliminate.GetIsCanMatch(thingVo.thingType, topThingVo.thingType))then
            table.insert(tempHorizontalList, topThingVo)
        else
            break
        end
    end
    if(#tempHorizontalList >= 3)then
        for i = 1, #tempHorizontalList do
            local _thingVo = tempHorizontalList[i]
            local keyRowCol = eliminate.GetTileIdByRowCol(_thingVo.rowIndex, _thingVo.colIndex)
            matchThingVoDic[keyRowCol] = _thingVo
        end
    end
    return matchThingVoDic
end

-- 获取匹配列表周围的可消除障碍物
function getAdjacentByMatchEffectThingVoDic(self, allMatchThingVoDic)
    local dic = {}
    if(allMatchThingVoDic)then
        for keyRowCol, thingVo in pairs(allMatchThingVoDic) do
            local checkThingVo = nil
            local checkKeyRowCol = nil
            checkThingVo = self:getThingVoByRowCol(thingVo.rowIndex + 1, thingVo.colIndex)
            if(checkThingVo)then
                checkKeyRowCol = eliminate.GetTileIdByRowCol(checkThingVo.rowIndex, checkThingVo.colIndex)
                if(checkThingVo:isCanEliminateByMatch() and not allMatchThingVoDic[checkKeyRowCol])then
                    dic[checkKeyRowCol] = checkThingVo
                end
            end
            checkThingVo = self:getThingVoByRowCol(thingVo.rowIndex - 1, thingVo.colIndex)
            if(checkThingVo)then
                checkKeyRowCol = eliminate.GetTileIdByRowCol(checkThingVo.rowIndex, checkThingVo.colIndex)
                if(checkThingVo:isCanEliminateByMatch() and not allMatchThingVoDic[checkKeyRowCol])then
                    dic[checkKeyRowCol] = checkThingVo
                end
            end
            checkThingVo = self:getThingVoByRowCol(thingVo.rowIndex, thingVo.colIndex + 1)
            if(checkThingVo)then
                checkKeyRowCol = eliminate.GetTileIdByRowCol(checkThingVo.rowIndex, checkThingVo.colIndex)
                if(checkThingVo:isCanEliminateByMatch() and not allMatchThingVoDic[checkKeyRowCol])then
                    dic[checkKeyRowCol] = checkThingVo
                end
            end
            checkThingVo = self:getThingVoByRowCol(thingVo.rowIndex, thingVo.colIndex - 1)
            if(checkThingVo)then
                checkKeyRowCol = eliminate.GetTileIdByRowCol(checkThingVo.rowIndex, checkThingVo.colIndex)
                if(checkThingVo:isCanEliminateByMatch() and not allMatchThingVoDic[checkKeyRowCol])then
                    dic[checkKeyRowCol] = checkThingVo
                end
            end
        end
    end
    return dic
end

-- 判断是否特殊道具以获取 特殊道具影响导致可以消除的字典
function getAllEffectThingVoDic(self, swapThingVo, beSwapThingVo, dic)
    dic = dic or {}
    -- 同色消除
    if(swapThingVo and beSwapThingVo and (swapThingVo.thingType == eliminate.ThingType.ClearSame or beSwapThingVo.thingType == eliminate.ThingType.ClearSame))then
        table.merge(dic, self:checkEffectSameClear(swapThingVo, beSwapThingVo, dic))
    end
    -- 范围消除
    if(swapThingVo and swapThingVo.thingType == eliminate.ThingType.ClearRange)then
        table.merge(dic, self:checkEffectRangeClear(swapThingVo, dic))
    end
    if(beSwapThingVo and beSwapThingVo.thingType == eliminate.ThingType.ClearRange)then
        table.merge(dic, self:checkEffectRangeClear(beSwapThingVo, dic))
    end
    -- 行消除
    if(swapThingVo and swapThingVo.thingType == eliminate.ThingType.ClearRow)then
        table.merge(dic, self:checkEffectRowClear(swapThingVo, dic))
    end
    if(beSwapThingVo and beSwapThingVo.thingType == eliminate.ThingType.ClearRow)then
        table.merge(dic, self:checkEffectRowClear(beSwapThingVo, dic))
    end
    -- 列消除
    if(swapThingVo and swapThingVo.thingType == eliminate.ThingType.ClearCol)then
        table.merge(dic, self:checkEffectColClear(swapThingVo, dic))
    end
    if(beSwapThingVo and beSwapThingVo.thingType == eliminate.ThingType.ClearCol)then
        table.merge(dic, self:checkEffectColClear(beSwapThingVo, dic))
    end
    -- 行列消除
    if(swapThingVo and swapThingVo.thingType == eliminate.ThingType.ClearRowCol)then
        table.merge(dic, self:checkEffectRowColClear(swapThingVo, dic))
    end
    if(beSwapThingVo and beSwapThingVo.thingType == eliminate.ThingType.ClearRowCol)then
        table.merge(dic, self:checkEffectRowColClear(beSwapThingVo, dic))
    end
    return dic
end

-- 同色消除
function checkEffectSameClear(self, swapThingVo, beSwapThingVo, dic)
    dic = dic or {}
    if(swapThingVo.thingType ~= beSwapThingVo.thingType)then
        local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
        for rowIndex = 1, stageConfigVo.mapRow do
            for colIndex = 1, stageConfigVo.mapCol do
                local thingVo = self:getThingVoByRowCol(rowIndex, colIndex)
                local tempThingVo = swapThingVo.thingType == eliminate.ThingType.ClearSame and beSwapThingVo or swapThingVo
                if(thingVo and thingVo:isCanEliminateByEffect() and thingVo.thingType == tempThingVo.thingType)then
                    dic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)] = thingVo
                end
            end
        end
        dic[eliminate.GetTileIdByRowCol(swapThingVo.rowIndex, swapThingVo.colIndex)] = swapThingVo
        dic[eliminate.GetTileIdByRowCol(beSwapThingVo.rowIndex, beSwapThingVo.colIndex)] = beSwapThingVo
    end
    return dic
end

-- 范围消除
function checkEffectRangeClear(self, checkThingVo, dic)
    dic = dic or {}
    local range = eliminate.GetClearRangeCount()
    for rowIndex = checkThingVo.rowIndex - range, checkThingVo.rowIndex + range do
        for colIndex = checkThingVo.colIndex - range, checkThingVo.colIndex + range do
            local thingVo = self:getThingVoByRowCol(rowIndex, colIndex)
            if(thingVo)then
                local keyRowCol = eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)
                if(thingVo == checkThingVo)then
                    dic[keyRowCol] = thingVo
                elseif(thingVo:isCanEliminateByEffect() and not dic[keyRowCol])then
                    dic[keyRowCol] = thingVo
                    self:getAllEffectThingVoDic(thingVo, nil, dic)
                end
            end
        end
    end
    return dic
end

-- 行消除
function checkEffectRowClear(self, checkThingVo, dic)
    dic = dic or {}
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    for colIndex = 1, stageConfigVo.mapCol do
        local thingVo = self:getThingVoByRowCol(checkThingVo.rowIndex, colIndex)
        if(thingVo)then
            local keyRowCol = eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)
            if(thingVo == checkThingVo)then
                dic[keyRowCol] = thingVo
            elseif(thingVo:isCanEliminateByEffect() and not dic[keyRowCol])then
                dic[keyRowCol] = thingVo
                self:getAllEffectThingVoDic(thingVo, nil, dic)
            end
        end
    end
    return dic
end

-- 列消除
function checkEffectColClear(self, checkThingVo, dic)
    dic = dic or {}
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    for rowIndex = 1, stageConfigVo.mapRow do
        local thingVo = self:getThingVoByRowCol(rowIndex, checkThingVo.colIndex)
        if(thingVo)then
            local keyRowCol = eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex)
            if(thingVo == checkThingVo)then
                dic[keyRowCol] = thingVo
            elseif(thingVo:isCanEliminateByEffect() and not dic[keyRowCol])then
                dic[keyRowCol] = thingVo
                self:getAllEffectThingVoDic(thingVo, nil, dic)
            end
        end
    end
    return dic
end

-- 行列消除
function checkEffectRowColClear(self, checkThingVo, dic)
    dic = dic or {}
    self:checkEffectRowClear(checkThingVo, dic)
    self:checkEffectColClear(checkThingVo, dic)
    return dic
end

-- 检查生成，匹配列表内的指定形状生成对应物件
function checkShapeByMatchEffectThingVoDic(self, swapThingVo, beSwapThingVo, allMatchThingVoDic)
    local dic = {}
    if(swapThingVo and beSwapThingVo and allMatchThingVoDic and table.nums(allMatchThingVoDic) >= 4)then
        local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
        local aboveThingVo1 = nil
        local aboveThingVo2 = nil
        local belowThingVo1 = nil
        local belowThingVo2 = nil
        local leftThingVo1 = nil
        local leftThingVo2 = nil
        local rightThingVo1 = nil
        local rightThingVo2 = nil

        local thingVo = swapThingVo
        aboveThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex + 1, thingVo.colIndex)]
        aboveThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex + 2, thingVo.colIndex)]
        belowThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex - 1, thingVo.colIndex)]
        belowThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex - 2, thingVo.colIndex)]
        leftThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex - 1)]
        leftThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex - 2)]
        rightThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex + 1)]
        rightThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex + 2)]
        if(aboveThingVo1 and aboveThingVo1.thingType ~= thingVo.thingType)then aboveThingVo1 = nil end
        if(aboveThingVo2 and aboveThingVo2.thingType ~= thingVo.thingType)then aboveThingVo2 = nil end
        if(belowThingVo1 and belowThingVo1.thingType ~= thingVo.thingType)then belowThingVo1 = nil end
        if(belowThingVo2 and belowThingVo2.thingType ~= thingVo.thingType)then belowThingVo2 = nil end
        if(leftThingVo1 and leftThingVo1.thingType ~= thingVo.thingType)then leftThingVo1 = nil end
        if(leftThingVo2 and leftThingVo2.thingType ~= thingVo.thingType)then leftThingVo2 = nil end
        if(rightThingVo1 and rightThingVo1.thingType ~= thingVo.thingType)then rightThingVo1 = nil end
        if(rightThingVo2 and rightThingVo2.thingType ~= thingVo.thingType)then rightThingVo2 = nil end

        local shapeBigT = eliminate.GetIsShapeBigT(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeMiddleT = eliminate.GetIsShapeMiddleT(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeSmallT = eliminate.GetIsShapeSmallT(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeL = eliminate.GetIsShapeL(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeLine5 = eliminate.GetIsShapeLine5(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeLine4 = eliminate.GetIsShapeLine4(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        if(shapeBigT ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearRowCol
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeMiddleT ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearSame
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeSmallT ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearRange
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeL ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearRange
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeLine5 ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearSame
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeLine4 ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
            if(thingVo.rowIndex == beSwapThingVo.rowIndex)then
                newThingVo.thingType = eliminate.ThingType.ClearRow
            else
                newThingVo.thingType = eliminate.ThingType.ClearCol
            end
        end

        local thingVo = beSwapThingVo
        aboveThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex + 1, thingVo.colIndex)]
        aboveThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex + 2, thingVo.colIndex)]
        belowThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex - 1, thingVo.colIndex)]
        belowThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex - 2, thingVo.colIndex)]
        leftThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex - 1)]
        leftThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex - 2)]
        rightThingVo1 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex + 1)]
        rightThingVo2 = allMatchThingVoDic[eliminate.GetTileIdByRowCol(thingVo.rowIndex, thingVo.colIndex + 2)]
        if(aboveThingVo1 and aboveThingVo1.thingType ~= thingVo.thingType)then aboveThingVo1 = nil end
        if(aboveThingVo2 and aboveThingVo2.thingType ~= thingVo.thingType)then aboveThingVo2 = nil end
        if(belowThingVo1 and belowThingVo1.thingType ~= thingVo.thingType)then belowThingVo1 = nil end
        if(belowThingVo2 and belowThingVo2.thingType ~= thingVo.thingType)then belowThingVo2 = nil end
        if(leftThingVo1 and leftThingVo1.thingType ~= thingVo.thingType)then leftThingVo1 = nil end
        if(leftThingVo2 and leftThingVo2.thingType ~= thingVo.thingType)then leftThingVo2 = nil end
        if(rightThingVo1 and rightThingVo1.thingType ~= thingVo.thingType)then rightThingVo1 = nil end
        if(rightThingVo2 and rightThingVo2.thingType ~= thingVo.thingType)then rightThingVo2 = nil end

        local shapeBigT = eliminate.GetIsShapeBigT(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeMiddleT = eliminate.GetIsShapeMiddleT(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeSmallT = eliminate.GetIsShapeSmallT(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeL = eliminate.GetIsShapeL(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeLine5 = eliminate.GetIsShapeLine5(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        local shapeLine4 = eliminate.GetIsShapeLine4(aboveThingVo1, aboveThingVo2, belowThingVo1, belowThingVo2, leftThingVo1, leftThingVo2, rightThingVo1, rightThingVo2)
        if(shapeBigT ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearRowCol
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeMiddleT ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearSame
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeSmallT ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearRange
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeL ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearRange
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeLine5 ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            newThingVo.thingType = eliminate.ThingType.ClearSame
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
        elseif(shapeLine4 ~= false)then
            local newThingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
            newThingVo.mapRow = stageConfigVo.mapRow
            newThingVo.mapCol = stageConfigVo.mapCol
            newThingVo.rowIndex = thingVo.rowIndex
            newThingVo.colIndex = thingVo.colIndex
            dic[eliminate.GetTileIdByRowCol(newThingVo.rowIndex, newThingVo.colIndex)] = newThingVo
            if(thingVo.rowIndex == swapThingVo.rowIndex)then
                newThingVo.thingType = eliminate.ThingType.ClearRow
            else
                newThingVo.thingType = eliminate.ThingType.ClearCol
            end
        end
    end
    return dic
end

-- 检查消除
function checkPlayList(self, startThingVo, endThingVo, allMatchThingVoDic, allEffectThingVoDic)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    -- 合并所有要消除的
    local allThingVoDic = {}
    if(allMatchThingVoDic)then
        -- 消除匹配颜色物件
        for keyRowCol, thingVo in pairs(allMatchThingVoDic) do
            allThingVoDic[keyRowCol] = thingVo
        end
        
        -- 消除匹配颜色物件的邻一圈可消除障碍物
        local byMatchEffectThingVoDic = self:getAdjacentByMatchEffectThingVoDic(allMatchThingVoDic)
        for keyRowCol, thingVo in pairs(byMatchEffectThingVoDic) do
            allThingVoDic[keyRowCol] = thingVo
        end
    end
    if(allEffectThingVoDic)then
        -- 消除效果带来的物件
        for keyRowCol, thingVo in pairs(allEffectThingVoDic) do
            allThingVoDic[keyRowCol] = thingVo
        end
    end
    
    -- 集中判断
    local deltaTime = 0
    if(table.nums(allThingVoDic) > 0)then
        local isHasPlaySameOnceSound = false
        local isHasPlayNormalOnceSound = false
        local calculateCountDic = {}
        -- 全部要消除的物件
        for keyRowCol, thingVo in pairs(allThingVoDic) do
            calculateCountDic[thingVo] = thingVo.thingType
            -- 检测地板是否有冰块消除
            local tileVo = self:getTileVoByRowCol(thingVo.rowIndex, thingVo.colIndex)
            if(tileVo and tileVo:getIceCount() > 0)then
                calculateCountDic[tileVo] = tileVo.iceType
                tileVo:setIceCount(tileVo:getIceCount() - 1)
            end
            -- 播放消除特效
            if((startThingVo and startThingVo.thingType or nil) == eliminate.ThingType.ClearSame and eliminate.GetIsCandy(endThingVo and endThingVo.thingType or nil))then
                if(startThingVo ~= thingVo)then
                    if(deltaTime == 0)then
                        deltaTime = 0.3
                    end
                    local startLocalPosX, startLocalPosY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, startThingVo.rowIndex, startThingVo.colIndex)
                    local endLocalPosX, endLocalPosY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, thingVo.rowIndex, thingVo.colIndex)
                    eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_03", startLocalPosX, startLocalPosY, endLocalPosX, endLocalPosY, 0, deltaTime, nil)
                    if(not isHasPlaySameOnceSound)then
                        isHasPlaySameOnceSound = true
                        AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_4.prefab"))
                    end
                end
            elseif((endThingVo and endThingVo.thingType or nil) == eliminate.ThingType.ClearSame and eliminate.GetIsCandy(startThingVo and startThingVo.thingType or nil))then
                if(endThingVo ~= thingVo)then
                    if(deltaTime == 0)then
                        deltaTime = 0.3
                    end
                    local startLocalPosX, startLocalPosY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, endThingVo.rowIndex, endThingVo.colIndex)
                    local endLocalPosX, endLocalPosY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, thingVo.rowIndex, thingVo.colIndex)
                    eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_03", startLocalPosX, startLocalPosY, endLocalPosX, endLocalPosY, 0, deltaTime, nil)
                    if(not isHasPlaySameOnceSound)then
                        isHasPlaySameOnceSound = true
                        AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_4.prefab"))
                    end
                end
            end

            local localPosX, localPosY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, thingVo.rowIndex, thingVo.colIndex)
            if(thingVo.thingType == eliminate.ThingType.ClearRange)then
                eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_02", localPosX, localPosY, nil, nil, deltaTime, 0.5, nil)
                AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_2.prefab"))
            elseif(thingVo.thingType == eliminate.ThingType.ClearRow)then
                eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_04", 0, localPosY, nil, nil, deltaTime, 0.5, nil)
                AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_3.prefab"))
            elseif(thingVo.thingType == eliminate.ThingType.ClearCol)then
                eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_05", localPosX, 0, nil, nil, deltaTime, 0.5, nil)
                AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_3.prefab"))
            elseif(thingVo.thingType == eliminate.ThingType.ClearRowCol)then
                eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_04", 0, localPosY, nil, nil, deltaTime, 0.5, nil)
                eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_05", localPosX, 0, nil, nil, deltaTime, 0.5, nil)
                AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_3.prefab"))
            else
                eliminate.EliminateEffectExecutor:createEffect("eliminate/fx_ui_eliminate_01", localPosX, localPosY, nil, nil, deltaTime, 0.5, nil)
                if(not isHasPlayNormalOnceSound)then
                    isHasPlayNormalOnceSound = true
                    AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_xxl_1.prefab"))
                end
            end

            table.insert(self.mTimerList, LoopManager:addTimer(deltaTime, 1, self, function() self:removeThing(thingVo) end))
        end

        table.insert(self.mTimerList, LoopManager:addTimer(deltaTime, 1, self, 
        function()
            -- 玩家主动操作新生成的物件
            if(startThingVo and endThingVo)then
                local newCreateThingVoDic = self:checkShapeByMatchEffectThingVoDic(startThingVo, endThingVo, allMatchThingVoDic)
                for keyRowCol, newThingVo in pairs(newCreateThingVoDic) do
                    local newThing = self:addThing(newThingVo)
                end
            end
        end))
        -- 特效播放完毕检查填充
        table.insert(self.mTimerList, LoopManager:addTimer(deltaTime + 0.1, 1, self, function() self:checkAllFillThing() end))
        eliminate.EliminateManager:addNowThingCountDic(calculateCountDic)
    else
        if(self:checkIsStalemate())then
            self.mShuffCount = (self.mShuffCount or 0) + 1
            if(self.mShuffCount >= 10)then
                self.mShuffCount = 0
                GameDispatcher:dispatchEvent(EventName.REPLAY_ELIMINATE_PANEL)
            else
                local shuffleResult = self:shuffleMap()
                if(shuffleResult)then
                    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
                    self:checkPlayList(nil, nil, self:getAllMatchThingVoDic(1, 1, stageConfigVo.mapRow, stageConfigVo.mapCol))
                else
                    self.mShuffCount = 0
                    GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_RESULT_PANEL, false)
                end
            end
        else
            self.mShuffCount = 0
            GameDispatcher:dispatchEvent(EventName.CHECK_ELIMINATE_FINISH)
        end
    end
end

-- 检测是否死局
function checkIsStalemate(self)
    local matchStartThingVo, matchEndThingVo = self:getOptimalSolution()
    return not matchStartThingVo and not matchEndThingVo
end

-- 获取优解
function getOptimalSolution(self)
    local matchStartThingVo = nil
    local matchEndThingVo = nil
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    for rowIndex = 1, stageConfigVo.mapRow do
        for colIndex = 1, stageConfigVo.mapCol do
            local startThingVo = self:getThingVoByRowCol(rowIndex, colIndex)
            if(startThingVo and eliminate.GetIsProp(startThingVo.thingType) and startThingVo.thingType ~= eliminate.ThingType.ClearSame)then
                matchStartThingVo = startThingVo
                matchEndThingVo = nil
                break
            end

            local endThingVo = self:getThingVoByRowCol(rowIndex, colIndex + 1)
            if(endThingVo and eliminate.GetIsProp(endThingVo.thingType) and endThingVo.thingType ~= eliminate.ThingType.ClearSame)then
                matchStartThingVo = nil
                matchEndThingVo = endThingVo
                break
            end
            if(startThingVo and endThingVo and eliminate.GetIsCanSwap(startThingVo.thingType, endThingVo.thingType))then
                self:swapThingVo(startThingVo, endThingVo)
                local minRowIndex, minColIndex, maxRowIndex, maxColIndex = eliminate.GetAffectRowColArea(startThingVo, endThingVo)
                local allMatchThingVoDic = self:getAllMatchThingVoDic(minRowIndex, minColIndex, maxRowIndex, maxColIndex)
                self:swapThingVo(startThingVo, endThingVo)
                if(table.nums(allMatchThingVoDic) > 0)then
                    matchStartThingVo = startThingVo
                    matchEndThingVo = endThingVo
                    break
                end
            end

            local endThingVo = self:getThingVoByRowCol(rowIndex + 1, colIndex)
            if(endThingVo and eliminate.GetIsProp(endThingVo.thingType) and endThingVo.thingType ~= eliminate.ThingType.ClearSame)then
                matchStartThingVo = nil
                matchEndThingVo = endThingVo
                break
            end
            if(startThingVo and endThingVo and eliminate.GetIsCanSwap(startThingVo.thingType, endThingVo.thingType))then
                self:swapThingVo(startThingVo, endThingVo)
                local minRowIndex, minColIndex, maxRowIndex, maxColIndex = eliminate.GetAffectRowColArea(startThingVo, endThingVo)
                local allMatchThingVoDic = self:getAllMatchThingVoDic(minRowIndex, minColIndex, maxRowIndex, maxColIndex)
                self:swapThingVo(startThingVo, endThingVo)
                if(table.nums(allMatchThingVoDic) > 0)then
                    matchStartThingVo = startThingVo
                    matchEndThingVo = endThingVo
                    break
                end
            end
        end
    end
    return matchStartThingVo, matchEndThingVo
end

-- 检查所有移动填充
function checkAllFillThing(self)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    local maxVerticalMoveTime = self:checkVerticalFillThing()
    if(maxVerticalMoveTime > 0)then
        table.insert(self.mTimerList, LoopManager:addTimer(maxVerticalMoveTime, 1, self, function()
            local maxInclineMoveTime = self:checkInclineFillThing()
            if(maxInclineMoveTime > 0)then
                self:checkVerticalFillThing(true)
                table.insert(self.mTimerList, LoopManager:addTimer(maxInclineMoveTime, 1, self, function() self:checkAllFillThing() end))
            else
                self:checkPlayList(nil, nil, self:getAllMatchThingVoDic(1, 1, stageConfigVo.mapRow, stageConfigVo.mapCol))
            end
        end))
    else
        local maxInclineMoveTime = self:checkInclineFillThing()
        if(maxInclineMoveTime > 0)then
            self:checkVerticalFillThing(true)
            table.insert(self.mTimerList, LoopManager:addTimer(maxInclineMoveTime, 1, self, function() self:checkAllFillThing() end))
        else
            self:checkPlayList(nil, nil, self:getAllMatchThingVoDic(1, 1, stageConfigVo.mapRow, stageConfigVo.mapCol))
        end
    end
end

-- 检查垂直移动填充
function checkVerticalFillThing(self, isForceOnceMove)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    -- 单格子单次移动时间
    local onceMoveTime = eliminate.GetVerticalOnceMoveTime()
    -- 填充的最大时间
    local maxMoveTime = 0
    -- 全部列垂直填充
    for colIndex = 1, stageConfigVo.mapCol do
        local topTileVo = self:getTopTileVoByCol(colIndex)
        -- 当前列垂直填充
        local belowEnableEmptyCount = 0     -- 物件下方可移动的空格子数
        for rowIndex = 1, stageConfigVo.mapRow do
            local tile = self:getTileByRowCol(rowIndex, colIndex)
            local thing = self:getThingByRowCol(rowIndex, colIndex)
            if(not thing)then
                if(tile)then
                    if(isForceOnceMove)then
                        belowEnableEmptyCount = 1
                    else
                        belowEnableEmptyCount = belowEnableEmptyCount + 1
                    end
                else
                    if(not topTileVo or rowIndex < topTileVo.rowIndex)then
                        belowEnableEmptyCount = 0
                    end
                end
            else
                if(belowEnableEmptyCount > 0)then
                    local thingVo = thing:getThingVo()
                    if(thingVo:isCanMove() and not thing:isMoving())then
                        local moveTime = onceMoveTime * belowEnableEmptyCount
                        maxMoveTime = math.max(maxMoveTime, moveTime)
                        
                        self.mThingVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)] = nil
                        self.mThingDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)] = nil
                        self.mThingVoDic[eliminate.GetTileIdByRowCol(rowIndex - belowEnableEmptyCount, colIndex)] = thingVo
                        self.mThingDic[eliminate.GetTileIdByRowCol(rowIndex - belowEnableEmptyCount, colIndex)] = thing
                        thingVo:setMoveToRowCol(rowIndex - belowEnableEmptyCount, colIndex, nil, moveTime, gs.DT.Ease.Linear, gs.DT.Ease.Linear)
                        
                        thing:playDropAction()
                        thing:playCollideAction(nil, moveTime)
                    else
                        belowEnableEmptyCount = 0
                    end
                end
            end
        end
        
        if(belowEnableEmptyCount > 0)then
            -- 当前列上面空白填充
            local index = 0
            for rowIndex = topTileVo.rowIndex - belowEnableEmptyCount + 1, topTileVo.rowIndex do
                local thing = self:getThingByRowCol(rowIndex, colIndex)
                if(not thing)then
                    index = index + 1
                    local moveTime = onceMoveTime * (topTileVo.rowIndex + index - rowIndex)
                    maxMoveTime = math.max(maxMoveTime, moveTime)

                    local thingVo = LuaPoolMgr:poolGet(eliminate.EliminateThingVo)
                    thingVo.mapRow = stageConfigVo.mapRow
                    thingVo.mapCol = stageConfigVo.mapCol
                    thingVo.thingType = eliminate.GetRandomThingType()
                    thingVo.rowIndex = topTileVo.rowIndex + index
                    thingVo.colIndex = colIndex
                    thing = self:addThing(thingVo)
                    self.mThingVoDic[eliminate.GetTileIdByRowCol(topTileVo.rowIndex + index, colIndex)] = nil
                    self.mThingDic[eliminate.GetTileIdByRowCol(topTileVo.rowIndex + index, colIndex)] = nil
                    self.mThingVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)] = thingVo
                    self.mThingDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)] = thing
                    thingVo:setMoveToRowCol(rowIndex, colIndex, nil, moveTime, gs.DT.Ease.Linear, gs.DT.Ease.Linear)

                    thing:playDropAction()
                    thing:playCollideAction(nil, moveTime)
                end
            end
        end
    end
    return maxMoveTime
end

-- 检查45度移动填充
function checkInclineFillThing(self)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    -- 单格子单次移动时间
    local onceMoveTime = eliminate.GetInclineOnceMoveTime()
    -- 填充的最大时间
    local maxMoveTime = 0
    -- 已经检查过的列禁止再被检查（该列已经有某一个物件被用作斜向填充了）
    local forbidCheckCol = {}
    for rowIndex = 1, stageConfigVo.mapRow do
        for colIndex = 1, stageConfigVo.mapCol do
            local thing = self:getThingByRowCol(rowIndex, colIndex)
            local tileThing = self:getTileVoByRowCol(rowIndex, colIndex)
            if(not thing and tileThing)then
                local isHadCheckCol = forbidCheckCol[colIndex]
                if(not isHadCheckCol)then
                    local aboveRowIndex = rowIndex + 1
                    local aboveLeftColIndex = colIndex - 1
                    local aboveRightColIndex = colIndex + 1
                    -- 左上方物件
                    local aboveLeftThing = self:getThingByRowCol(aboveRowIndex, aboveLeftColIndex)
                    -- 右上方物件
                    local aboveRightThing = self:getThingByRowCol(aboveRowIndex, aboveRightColIndex)
                    -- 综合是否可选区左上方
                    local isCanAboveLeft = aboveLeftThing and (aboveLeftThing:getThingVo():isCanMove() and not forbidCheckCol[aboveLeftColIndex]) or false
                    -- 综合是否可选区右上方
                    local isCanAboveRight = aboveRightThing and (aboveRightThing:getThingVo():isCanMove() and not forbidCheckCol[aboveRightColIndex]) or false

                    local selectThing = nil
                    if(isCanAboveLeft == false and isCanAboveRight == false)then
                        selectThing = nil
                    elseif(isCanAboveLeft == true and isCanAboveRight == false)then
                        selectThing = aboveLeftThing
                    elseif(isCanAboveLeft == false and isCanAboveRight == true)then
                        selectThing = aboveRightThing
                    else
                        selectThing = math.random(0, 1) == 1 and aboveLeftThing or aboveRightThing
                    end
                    if(selectThing)then
                        local selectThingVo = selectThing:getThingVo()
                        if(selectThingVo:isCanMove())then
                            maxMoveTime = onceMoveTime
                            -- 上方有物件则该本轮不再被填充
                            local _aboveThingVo = self:getThingVoByRowCol(selectThingVo.rowIndex + 1, selectThingVo.colIndex)
                            if(_aboveThingVo and _aboveThingVo:isCanMove())then
                                forbidCheckCol[selectThingVo.colIndex] = true
                            end
    
                            self.mThingVoDic[eliminate.GetTileIdByRowCol(selectThingVo.rowIndex, selectThingVo.colIndex)] = nil
                            self.mThingDic[eliminate.GetTileIdByRowCol(selectThingVo.rowIndex, selectThingVo.colIndex)] = nil
                            self.mThingVoDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)] = selectThingVo
                            self.mThingDic[eliminate.GetTileIdByRowCol(rowIndex, colIndex)] = selectThing
                            selectThingVo:setMoveToRowCol(rowIndex, colIndex, nil, onceMoveTime, gs.DT.Ease.OutCubic, gs.DT.Ease.OutBounce)

                            selectThing:playDropAction()
                            selectThing:playCollideAction(nil, onceMoveTime)
                        end
                    end
                end
            end
        end
    end
    if(maxMoveTime > 0)then
        return maxMoveTime
    else
        return maxMoveTime
    end
end

function shuffleMap(self)
    local isHasProp = false
    local isHasThreeSame = false
    local tempTypeDic = {}
    local shuffleList = {}
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    for rowIndex = 1, stageConfigVo.mapRow do
        for colIndex = 1, stageConfigVo.mapCol do
            local keyRowCol = eliminate.GetTileIdByRowCol(rowIndex, colIndex)
            local thing = self.mThingDic[keyRowCol]
            local thingVo = self.mThingVoDic[keyRowCol]
            if(thing and thingVo)then
                if(eliminate.GetIsCanShuffle(thingVo.thingType))then
                    if(not isHasProp and not isHasProp)then
                        tempTypeDic[thingVo.thingType] = tempTypeDic[thingVo.thingType] or 0
                        if(eliminate.GetIsProp(thingVo.thingType))then
                            isHasProp = true
                        else
                            tempTypeDic[thingVo.thingType] = tempTypeDic[thingVo.thingType] + 1
                        end
                        if(tempTypeDic[thingVo.thingType] >= 3)then
                            isHasThreeSame = true
                        end
                    end
                    table.insert(shuffleList, {rowIndex = rowIndex, colIndex = colIndex, keyRowCol = keyRowCol, thingVo = self.mThingVoDic[keyRowCol], thing = self.mThingDic[keyRowCol]})
                end
            end
        end
    end
    local count = #shuffleList
    if(not isHasProp and not isHasThreeSame)then
        return false
    end

    for index = count, 2, -1 do
        local randomIndex = math.random(index)             -- 随机选择一个索引
        local thingVo = shuffleList[index].thingVo
        local thing = shuffleList[index].thing
        local randomThingVo = shuffleList[randomIndex].thingVo
        local randomThing = shuffleList[randomIndex].thing

        shuffleList[index].thingVo = randomThingVo
        shuffleList[index].thing = randomThing
        shuffleList[randomIndex].thingVo = thingVo
        shuffleList[randomIndex].thing = thing

        shuffleList[index].thingVo.rowIndex = shuffleList[index].rowIndex
        shuffleList[index].thingVo.colIndex = shuffleList[index].colIndex

        shuffleList[randomIndex].thingVo.rowIndex = shuffleList[index].rowIndex
        shuffleList[randomIndex].thingVo.colIndex = shuffleList[index].colIndex
    end

    for _, data in pairs(shuffleList) do
        self.mThingVoDic[data.keyRowCol] = data.thingVo
        self.mThingDic[data.keyRowCol] = data.thing
        data.thingVo:setRowColToUpdate(data.rowIndex, data.colIndex)
    end

    return true
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
