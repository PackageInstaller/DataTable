module("maze.MazeSceneManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)

    self:__initConfigData()
    self:__initClientData()
    self:__initMsgData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)

    self:__initConfigData()
    self:__initClientData()
    self:__initMsgData()
end

---------------------------------------------------------------start 配置数据相关---------------------------------------------------------------
function __initConfigData(self)
    self.mEventConfigDic = nil
    self.mMazeConfigList = nil
    self.mMazeConfigDic = nil
    self.mTileConfigDic = nil
    self.mTileIdConfigDic = nil
end

-- 迷宫地图格子配置
function parseMazeConfig(self)
    self.mMazeConfigList = {}
    self.mMazeConfigDic = {}
    self.mTileConfigDic = {}
    self.mTileIdConfigDic = {}
    local baseData = RefMgr:getData("maze_data")
    for mazeId, mazeData in pairs(baseData) do
        local mazeConfigVo = maze.MazeConfigVo.new()
        mazeConfigVo:setData(mazeId, mazeData)
        table.insert(self.mMazeConfigList, mazeConfigVo)
        self.mMazeConfigDic[mazeConfigVo:getMazeId()] = mazeConfigVo
        if (not self.mTileConfigDic[mazeId]) then
            self.mTileConfigDic[mazeId] = {}
        end
        if (not self.mTileIdConfigDic[mazeId]) then
            self.mTileIdConfigDic[mazeId] = {}
        end
        for tileId, tileData in pairs(mazeData.maze_event_cfg) do
            local tileConfigVo = maze.MazeTileConfigVo.new()
            tileConfigVo:setData(mazeId, tileId, tileData)
            local key = self:getRowColKey(tileConfigVo:getRow(), tileConfigVo:getCol())
            self.mTileConfigDic[mazeId][key] = tileConfigVo
            self.mTileIdConfigDic[mazeId][tileId] = tileConfigVo

            -- 初始化玩家出生点的行列
            if (mazeConfigVo:getBirthTileId() == tileConfigVo:getTileId()) then
                mazeConfigVo:setBirthRow(tileConfigVo:getRow())
                mazeConfigVo:setBirthCol(tileConfigVo:getCol())
            end
        end
    end

    table.sort(self.mMazeConfigList, function(MazeConfigVo_1, MazeConfigVo_2)
        return MazeConfigVo_1:getMazeId() < MazeConfigVo_2:getMazeId()
    end)
end

-- 迷宫事件配置
function parseMazeEventConfig(self)
    self.mEventConfigDic = {}
    local baseData = RefMgr:getData("maze_event_data")
    for eventId, eventData in pairs(baseData) do
        local eventConfigVo = maze.MazeEventConfigVo.new()
        eventConfigVo:setData(eventId, eventData)
        self.mEventConfigDic[eventId] = eventConfigVo
    end
end

function getRowColKey(self, cusRow, cusCol)
    return cusRow * 100000 + cusCol
end

function getMazeConfigList(self)
    if (not self.mMazeConfigList) then
        self:parseMazeConfig()
    end
    return self.mMazeConfigList or {}
end

function getMazeConfigVo(self, cusMazeId)
    if (not self.mMazeConfigDic) then
        self:parseMazeConfig()
    end
    return self.mMazeConfigDic[cusMazeId]
end

function getTileConfigVo(self, cusMazeId, cusRow, cusCol)
    if (not self.mTileConfigDic) then
        self:parseMazeConfig()
    end
    local data = self.mTileConfigDic[cusMazeId]
    if (data) then
        local key = self:getRowColKey(cusRow, cusCol)
        local tileConfigVo = data[key]
        if (tileConfigVo) then
            return tileConfigVo
        else
            Debug:log_error("MazeSceneManager", string.format("迷宫id为%s的找不到第%s行第%s列格子的配置数据", cusMazeId, cusRow, cusCol))
        end
    end
    return nil
end

function getTileIdByRowCol(self, cusMazeId, cusRow, cusCol)
    local configVo = self:getTileConfigVo(cusMazeId, cusRow, cusCol)
    if (configVo) then
        return configVo:getTileId()
    else
        return 0, 0
    end
end

function getTileConfigVoById(self, cusMazeId, cusTileId)
    if (not self.mTileIdConfigDic) then
        self:parseMazeConfig()
    end
    local data = self.mTileIdConfigDic[cusMazeId]
    if (data) then
        return data[cusTileId]
    end
    return nil
end

function getRowColByTileId(self, cusMazeId, cusTileId)
    local configVo = self:getTileConfigVoById(cusMazeId, cusTileId)
    if (configVo) then
        return configVo:getRow(), configVo:getCol()
    else
        return 0, 0
    end
end

function getEventConfigVo(self, cusEventId)
    if (not self.mEventConfigDic) then
        self:parseMazeEventConfig()
    end
    local eventConfigVo = self.mEventConfigDic[cusEventId]
    if (eventConfigVo) then
        return eventConfigVo
    else
        Debug:log_error("MazeSceneManager", string.format("找不到事件id为%s的事件配置数据", cusEventId))
    end
end

--获取迷宫宝箱的进度
function getAllMazePro(self)
    local allPro = 0
	local list = maze.MazeManager:getMazeList()
    for k, mazeVo in pairs(list) do
        allPro = allPro + mazeVo:getBoxPro()
    end
    return allPro / #list
end

-- 随便给返回一个正确的迷宫id
function getLegalMazeId(self)
    if self.mMazeConfigDic == nil then
        self:parseMazeConfig()
    end
    for k, v in pairs(self.mMazeConfigDic) do
        return k
    end
end
---------------------------------------------------------------end 配置数据相关---------------------------------------------------------------

---------------------------------------------------------------start 本地数据---------------------------------------------------------------
function __initClientData(self)
    self.mThingVoDic = nil
end

-- 物件数据相关
function addThingVo(self, thingVo, isAddThing, finishCall)
    if (not self.mThingVoDic) then
        self.mThingVoDic = {}
    end
    if (not self.mThingVoDic[thingVo:getType()]) then
        self.mThingVoDic[thingVo:getType()] = {}
    end
    table.insert(self.mThingVoDic[thingVo:getType()], thingVo)

    if (isAddThing) then
        maze.MazeSceneThingManager:addThing(thingVo, finishCall)
    end
end
function removeThingVo(self, type, row, col, isRemoveThing)
    local dic = self.mThingVoDic
    if (dic) then
        local list = dic[type]
        if (list) then
            local searchThingVo, searchIndex = nil, nil
            for i = 1, #list do
                local vo = list[i]
                if (vo:getRow() == row and vo:getCol() == col) then
                    searchIndex = i
                    searchThingVo = vo
                    break
                end
            end
            if (searchThingVo and searchIndex) then
                if (isRemoveThing) then
                    if (maze.MazeSceneThingManager:removeThing(type, row, col)) then
                        table.remove(list, searchIndex)
                        LuaPoolMgr:poolRecover(searchThingVo)
                        return true
                    end
                else
                    table.remove(list, searchIndex)
                    LuaPoolMgr:poolRecover(searchThingVo)
                    return true
                end
            end
        end
    end
    return false
end
function getThingVo(self, type, row, col)
    local dic = self.mThingVoDic
    if (dic) then
        local list = dic[type]
        if (list) then
            for i = 1, #list do
                local vo = list[i]
                if (vo:getRow() == row and vo:getCol() == col) then
                    return vo
                end
            end
        end
    end
end
function resetMazeData(self, isResetThing)
    if (isResetThing) then
        maze.MazeSceneThingManager:resetMazeData()
    end
    if (self.mThingVoDic) then
        for thingType, thingVoList in pairs(self.mThingVoDic) do
            for _, thing in pairs(thingVoList) do
                LuaPoolMgr:poolRecover(thing)
            end
        end
    end
    self.mThingVoDic = {}
    self:setMazeId(nil)
end

--获取格子的事件
function getTileEventTypeByRowCol(self, mazeId, row, col)
    local tileConfigVo = self:getTileConfigVo(mazeId, row, col)
    if(tileConfigVo)then
        local eventVo = self:getMazeEventVo(tileConfigVo:getTileId())
        if(eventVo)then
            local eventConfigVo = self:getEventConfigVo(eventVo:getEventId()) 
            if eventConfigVo then 
                return eventConfigVo:getEventType()
            end
        end
    end
end
---------------------------------------------------------------end 本地数据---------------------------------------------------------------

---------------------------------------------------------------start 服务器数据相关---------------------------------------------------------------
function __initMsgData(self)
    -- 当前迷宫id
    self.mCurMazeId = nil
    -- 当前玩家位置id
    self.mCurPlayerTileId = nil

    -- 迷宫格子更新列表
    self.mCurTileDic = nil
    -- 迷宫事件列表
    self.mCurEventDic = nil
end

--- *s2c* 进入迷宫的详细信息 19164
function parseEnterMazeInfo(self, msg)
    self:setMazeId(msg.maze_id)
    local playerVo = self:getPlayerThingVo(self:getMazeId())
    self:setPlayerTileId(msg.pos_id)
    if (playerVo) then
        playerVo:resetMovePos()
        playerVo:setTileId(self:getPlayerTileId())
        playerVo:refreshPos()
    end
    -- 格子更新列表
    self.mCurTileDic = {}
    for i = 1, #msg.update_grid_info do
        self:addMazeTileVo(msg.update_grid_info[i])
    end
    -- 事件列表
    self.mCurEventDic = {}
    for i = 1, #msg.event_list do
        self:addMazeEventVo(msg.event_list[i])
    end
    -- 物资列表
    maze.MazeManager:setGoodsList(msg.maze_id, msg.had_gain_matrix)
    -- 通知更新
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_SCENE_DATA, {mazeId = msg.maze_id})
end

--- *s2c* 迷宫是否可以移动返回 19166
function parseCheckMazeMove(self, msg)
    if (msg.maze_id == self:getMazeId()) then
        local playerVo = self:getPlayerThingVo(self:getMazeId())
        if (msg.result == 1) then
            local tileConfigVo = self:getTileConfigVoById(msg.maze_id, msg.target_pos)
            if (playerVo:checkFirstPathGrid(tileConfigVo:getRow(), tileConfigVo:getCol())) then -- 只允许最新的路径列表
                self:setPlayerTileId(msg.target_pos)
                playerVo:setTileId(self:getPlayerTileId())
                maze.MazeEventExecutor:checkMovePreResult(self:getMazeId())

            else -- 可能网络延迟，堆积了很多个旧的响应
                maze.MazeEventExecutor:__print("过滤无用的延迟响应")
            end
        else
            maze.MazeEventExecutor:__print("后端通知不可移动")
            playerVo:resetMovePos()
        end
    end
end

--- *s2c* 迷宫移动返回 19168
function parseMazeMove(self, msg)
    if (msg.maze_id == self:getMazeId()) then
        local playerVo = self:getPlayerThingVo(self:getMazeId())
        if (msg.result == 1) then
            local autoEventList = {}
            for i = 1, #msg.auto_event_pos_list do
                local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
                eventVo:setData(msg.auto_event_pos_list[i])
                table.insert(autoEventList, eventVo)
            end
            local activeEventList = {}
            for i = 1, #msg.active_event_pos_list do
                local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
                eventVo:setData(msg.active_event_pos_list[i])
                table.insert(activeEventList, eventVo)
            end
            -- self:setPlayerTileId(msg.new_pos)
            -- playerVo:setTileId(self:getPlayerTileId())
            maze.MazeEventExecutor:checkTriggerEventList(self:getMazeId(), autoEventList, activeEventList, nil)
        else
            maze.MazeEventExecutor:__print("后端通知移动失败")

            -- local waitPathList = playerVo:getWaitPathList()
            -- local endAStarGrid = nil
            -- if (waitPathList and #waitPathList > 0) then -- 如果失败尝试本地校正玩家位置
            --     endAStarGrid = waitPathList[#waitPathList]
            -- end

            -- maze.MazeEventExecutor:setNowTileEventId(nil, nil)
            -- playerVo:resetMovePos()
            -- if (endAStarGrid) then
            --     self:setPlayerTileId(msg.new_pos)
            --     playerVo:setTileId(self:getPlayerTileId())

            --     -- 如果失败尝试本地校正玩家位置
            --     local rePathList = playerVo:getPathList(endAStarGrid.row, endAStarGrid.col, 0)
            --     if (rePathList) then
            --         maze.MazeEventExecutor:__print("客户端自身校正重新设置目标点")
            --         playerVo:moveByPathList(rePathList)
            --         return
            --     end
            -- end

            -- local row, col = self:getRowColByTileId(self:getMazeId(), msg.new_pos)
            -- local rePathList = playerVo:getPathList(row, col, 0)
            -- if (rePathList) then
            --     maze.MazeEventExecutor:__print("客户端尝试校正为服务器坐标")
            --     playerVo:moveByPathList(rePathList)
            --     return
            -- end

            -- 全部校正都失败的直接设置玩家位置为服务器位置
        --     maze.MazeEventExecutor:__print("后端通知移动失败以后端为准设置坐标")

            playerVo:resetMovePos()
            self:setPlayerTileId(msg.new_pos)
            playerVo:setTileId(self:getPlayerTileId())
            playerVo:refreshPos()
        end
    end
end

--- *c2s* 可触发的事件列表 19185
function parseTriggerEventList(self, list)
    self.mTriggerEventList = list
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TRIGGER_EVENT_LIST)
end

-- 判断当前事件id是否触发
function isEventCanTrigger(self, eventId)
    if (self.mTriggerEventList and eventId) then
        return table.indexof(self.mTriggerEventList, eventId) ~= false
    else
        return false
    end
end

-- 设置迷宫通过的格子列表
function setPassTileIdList(self, msg)
    if (maze.MazeSceneManager:getMazeId() == msg.maze_id) then
        if (msg.is_update == 1 and self.mPassGridList) then
            for i = 1, #msg.grid_list do
                table.insert(self.mPassGridList, msg.grid_list[i])
            end
        else
            self.mPassGridList = msg.grid_list
        end
    end
end
-- -- 设置迷宫通过的格子列表
-- function setPassTileIdList(self, msg)
--     if(maze.MazeSceneManager:getMazeId() == msg.maze_id)then
--         if(not self.mPassTileList or msg.is_update ~= 1)then
--             self.mPassTileList = {}
--             self.mPassRangeTileList = {}
--         end
--         for i = 1, #msg.grid_list do
--             self:addPassTileId(msg.maze_id, msg.grid_list[i])
--         end
--     end
-- end
-- -- 添加迷宫通过的格子
-- function addPassTileId(self, mazeId, tileId)
--     if(self.mPassTileList)then
--         local mazeConfigVo = self:getMazeConfigVo(mazeId)
--         if(table.indexof(self.mPassTileList, tileId) == false)then
--             table.insert(self.mPassTileList, tileId)
--             table.insert(self.mPassRangeTileList, tileId)
--             local range = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_FOG_LIGHT_RANGE)
--             local checkRow, checkCol = self:getRowColByTileId(mazeConfigVo:getMazeId(), tileId)
--             local nearList = maze.getNearRangeList(mazeConfigVo:getLayoutType(), mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), checkRow, checkCol, range)
--             for _, nearData in pairs(nearList) do
--                 local nearTileId = self:getTileIdByRowCol(mazeConfigVo:getMazeId(), nearData.row, nearData.col)
--                 if(table.indexof(self.mPassRangeTileList, nearTileId) == false)then
--                     table.insert(self.mPassRangeTileList, nearTileId)
--                 end
--             end
--             -- 检查更新变化的需要比视野范围多一圈
--             local updateTileList = {tileId}
--             local moreNearList = maze.getNearRangeList(mazeConfigVo:getLayoutType(), mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), checkRow, checkCol, range + 1)
--             for _, moreNearData in pairs(moreNearList) do
--                 local nearTileId = self:getTileIdByRowCol(mazeConfigVo:getMazeId(), moreNearData.row, moreNearData.col)
--                 if(table.indexof(updateTileList, nearTileId) == false)then
--                     table.insert(updateTileList, nearTileId)
--                 end
--             end
--             GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_PASS_VIEWPORT, {mazeId = mazeId, updateTileList = updateTileList})
--         end
--     end
-- end
-- 获取迷宫通过的格子列表
function getPassTileIdList(self)
    return self.mPassGridList or {}
end

-- 判断迷宫通过的格子列表对应的点亮区域是否可走
function isTileInPassArea(self, mazeId, checkRow, checkCol)
    local mazeConfigVo = self:getMazeConfigVo(mazeId)
    local checkTileId = self:getTileIdByRowCol(mazeId, checkRow, checkCol)
    local lightRange = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_FOG_LIGHT_RANGE)
    local passTileIdList = self:getPassTileIdList()
    for _, tileId in pairs(passTileIdList) do
        if (tileId == checkTileId) then
            return true
        end
        local row, col = self:getRowColByTileId(mazeId, tileId)
        local nearList = maze.getNearRangeList(mazeConfigVo:getLayoutType(), mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), row, col, lightRange * 3)
        for _, tileData in pairs(nearList) do
            if (tileData.row == checkRow and tileData.col == checkCol) then
                return true
            end
        end
    end
    return false
end

-- 设置迷宫已通关的怪物格子id列表
function setPassMonsterTileIdList(self, msg)
    if (maze.MazeSceneManager:getMazeId() == msg.maze_id) then
        self.mPassMonsterGridList = msg.grid_list
    end
end
-- 获取迷宫已通关的怪物格子id列表
function getPassMonsterTileIdList(self)
    return self.mPassMonsterGridList or {}
end

-- 设置当前迷宫地图id
function setMazeId(self, mazeId)
    self.mCurMazeId = mazeId
end
-- 获取当前迷宫地图id
function getMazeId(self)
    return self.mCurMazeId
end

-- 设置当前玩家所在格子id
function setPlayerTileId(self, tileId)
    if (self.mCurPlayerTileId ~= tileId) then
        self.mCurPlayerTileId = tileId
        -- logAll(tileId,"设置玩家id：")
    end
end
-- 获取当前玩家所在格子id
function getPlayerTileId(self)
    return self.mCurPlayerTileId
end
-- 获取玩家实体数据
function getPlayerThingVo(self, mazeId)
    local tileConfigVo = self:getTileConfigVoById(mazeId, self:getPlayerTileId())
    if (tileConfigVo) then
        return self:getThingVo(maze.THING_TYPE_PLAYER, tileConfigVo:getRow(), tileConfigVo:getCol())
    end
end

-- 增加服务器格子更新数据
function addMazeTileVo(self, msgVo)
    if (not self.mCurTileDic) then
        self.mCurTileDic = {}
    end
    self:delMazeTileVo(msgVo.id)
    local tileVo = LuaPoolMgr:poolGet(maze.MazeTileVo)
    tileVo:setData(msgVo)
    self.mCurTileDic[tileVo:getTileId()] = tileVo
    return tileVo
end

-- 删除服务器格子更新数据
function delMazeTileVo(self, tileId)
    if (self.mCurTileDic) then
        if (self.mCurTileDic[tileId]) then
            LuaPoolMgr:poolRecover(self.mCurTileDic[tileId])
        end
        self.mCurTileDic[tileId] = nil
    end
end

-- 获取服务器格子更新数据
function getMazeTileVo(self, tileId)
    if (self.mCurTileDic) then
        return self.mCurTileDic[tileId]
    end
    return nil
end

-- 增加服务器格子的对应事件数据
function addMazeEventVo(self, msgVo)
    if (not self.mCurEventDic) then
        self.mCurEventDic = {}
    end
    self:delMazeEventVo(msgVo.id)
    local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
    eventVo:setData(msgVo)
    self.mCurEventDic[eventVo:getTileId()] = eventVo
    return eventVo
end

-- 删除服务器格子的对应事件数据
function delMazeEventVo(self, tileId)
    if (self.mCurEventDic) then
        if (self.mCurEventDic[tileId]) then
            LuaPoolMgr:poolRecover(self.mCurEventDic[tileId])
        end
        self.mCurEventDic[tileId] = nil
    end
end

-- 获取服务器格子的对应事件数据
function getMazeEventVo(self, tileId)
    if (self.mCurEventDic) then
        return self.mCurEventDic[tileId]
    end
    return nil
end

-- 判断格子是否存在
function checkTileIsExist(self, mazeId, row, col)
    local tileConfigVo = self:getTileConfigVo(mazeId, row, col)
    local eventVo = self:getMazeEventVo(tileConfigVo:getTileId())
    if (eventVo) then -- 服务器存在事件
        return true
    else -- 服务器不存在事件，则干掉本地的
        if (self.mCurTileDic) then
            local tileVo = self.mCurTileDic[tileConfigVo:getTileId()]
            if (tileVo) then
                if (tileVo:isDel()) then
                    return false
                elseif (tileVo:isAdd()) then
                    return true
                else
                    Debug:log_error("MazeSceneManager", "含有格子新状态未处理：" .. tileVo:getState())
                end
            else
                if (tileConfigVo:getBaseEventId() ~= 0) then
                    return true
                end
            end
        else
            return true
        end
    end
    return false
end

-- 判断格子是否可以通过
function checkTileIsCanPass(self, mazeId, row, col)
    local tileConfigVo = self:getTileConfigVo(mazeId, row, col)
    local eventVo = self:getMazeEventVo(tileConfigVo:getTileId())
    if (eventVo) then -- 服务器存在事件
        local eventConfigVo = self:getEventConfigVo(eventVo:getEventId())
        if (eventConfigVo) then
            if (eventConfigVo:isCanPass()) then
                return true
            end
        else
            Debug:log_error("MazeSceneManager", string.format("服务器的事件id%s在事件配置中找不到", eventVo:getEventId()))
        end
    else -- 服务器不存在事件，则干掉本地的
        if (self.mCurTileDic) then
            local tileVo = self.mCurTileDic[tileConfigVo:getTileId()]
            if (tileVo) then
                if (tileVo:isDel()) then
                    return false
                elseif (tileVo:isAdd()) then
                    return true
                else
                    Debug:log_error("MazeSceneManager", "含有格子新状态未处理：" .. tileVo:getState())
                end
            else
                if (tileConfigVo:getBaseEventId() ~= 0) then
                    return true
                end
            end
        else
            return true
        end
    end
    return false
end

-- 获取移动代价
function getMoveCostMultiplier(self, mazeId, row, col)
    local tileConfigVo = self:getTileConfigVo(mazeId, row, col)
    local eventVo = self:getMazeEventVo(tileConfigVo:getTileId())
    if (eventVo) then
        local eventConfigVo = self:getEventConfigVo(eventVo:getEventId())
        return eventConfigVo:getCostMultiplier()
    else
        return 1
    end
end
---------------------------------------------------------------end 服务器数据相关---------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
