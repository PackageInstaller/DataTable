
SeasonSLGSmallMapMgr = {
    filterAreaID = "",
    filterGridType = "0",

    areaList = nil
}

local this = SeasonSLGSmallMapMgr

SeasonSLGSmallMapMgr.mapConfig={
    CenterPos ={x=10,y=1000},
    GridW = 13.86,
    GridH = 11.5,
    offsetX = 0,
    offsetY = 0,


    startX = 28.5,
    startY = -44.5,
    rowOffsetX = 7,
}
SeasonSLGSmallMapMgr.mapConfig.mapSize={
        x=SeasonSLGMapMgr.mapConfig.col*SeasonSLGSmallMapMgr.mapConfig.GridW,
        y=SeasonSLGMapMgr.mapConfig.row*SeasonSLGSmallMapMgr.mapConfig.GridH,
    }
SeasonSLGSmallMapMgr.scalex = SeasonSLGSmallMapMgr.mapConfig.mapSize.x / SeasonSLGMapMgr.mapConfig.mapSize.x
SeasonSLGSmallMapMgr.scaley = SeasonSLGSmallMapMgr.mapConfig.mapSize.y / SeasonSLGMapMgr.mapConfig.mapSize.y

SeasonSLGSmallMapMgr.SetMapSize = function(width, height)
    if width == nil or height == nil or width <= 0 or height <= 0 then
        return
    end

    SeasonSLGSmallMapMgr.mapConfig.mapSize.x = width
    SeasonSLGSmallMapMgr.mapConfig.mapSize.y = height
    SeasonSLGSmallMapMgr.scalex = width / SeasonSLGMapMgr.mapConfig.mapSize.x
    SeasonSLGSmallMapMgr.scaley = height / SeasonSLGMapMgr.mapConfig.mapSize.y
end


SeasonSLGSmallMapMgr.GetTopDownPositionByIndex = function(index)
    local row0, col0 = SeasonSLGMapMgr.GetBlockLocByIndex(tonumber(index))
    if not row0 or not col0 then
        return Vector2(0, 0), 0, 0
    end
    local row = row0
    local col = col0
    local cfg = SeasonSLGSmallMapMgr.mapConfig

    local halfOffset = (row % 2 == 0) and cfg.rowOffsetX or 0
    local x = cfg.startX + (col - 1) * cfg.GridW + halfOffset
    local y = cfg.startY - (row - 1) * cfg.GridH
    return Vector2(x + cfg.offsetX, y + cfg.offsetY), row, col
end

SeasonSLGSmallMapMgr.GetTopDownIndexByPosition = function(pos)
    if pos == nil then
        return nil, nil
    end

    local cfg = SeasonSLGSmallMapMgr.mapConfig
    if cfg.GridW <= 0 or cfg.GridH <= 0 then
        return nil, nil
    end

    local nx = pos.x - cfg.offsetX - cfg.startX
    local ny = pos.y - cfg.offsetY - cfg.startY


    local row = math.floor(-ny / cfg.GridH + 0.5) + 1
    if row < 1 then
        row = 1
    end

    local halfOffset = (row % 2 == 0) and cfg.rowOffsetX or 0
    local col = math.floor((nx - halfOffset) / cfg.GridW + 0.5) + 1
    if col < 1 then
        col = 1
    end

    return row, col
end



SeasonSLGSmallMapMgr.InitCurAreaList=function()












    this.bossGridMap = {}
    local gridMap = SeasonSLGMapMgr.GetCurSeasonMapCfgData()
    local bossData = SeasonSLGMapMgr.GetCurSeasonBOSSData();
    for i, v in ipairs(bossData) do
        this.bossGridMap[v.GridIndex] = gridMap[v.GridIndex]
    end
end









SeasonSLGSmallMapMgr.GetBossGridMap=function()
    if not this.bossGridMap then
        SeasonSLGSmallMapMgr.InitCurAreaList()
    end

    return this.bossGridMap
end





















SeasonSLGSmallMapMgr.GetCurAreaGridList=function()
    if this.showGridList then
        return this.showGridList
    end

    local gridMap = SeasonSLGMapMgr.GetCurSeasonMapCfgData()
    this.showGridList={}
    this.gridGroupPositionMap={}
    this.gridMainMap={}
    this.timedEventMainGridMap={}

    local groupMap={}
    for gridID, cfgGrid in pairs(gridMap) do
        local mainGridID=IsNullOrEmpty(cfgGrid.Connect) and tostring(gridID) or tostring(cfgGrid.Connect)
        this.gridMainMap[tostring(gridID)]=mainGridID
        if groupMap[mainGridID]==nil then
            groupMap[mainGridID]={}
        end
        table.insert(groupMap[mainGridID], tonumber(gridID))
    end

    for mainGridID, gridList in pairs(groupMap) do
        local cfgGrid=gridMap[mainGridID]
        local hasTimedEvent=false
        local timedEventProgress=SeasonSLGMapMgr.MapStateData.TimedEventProgress
        if timedEventProgress~=nil then
            for _,gridID in ipairs(gridList) do
                local progressData=timedEventProgress[tostring(gridID)]
                if progressData==nil then
                    progressData=timedEventProgress[gridID]
                end
                if progressData~=nil then
                    local attackConfig=ConfigMgr.Config.SeasonalGridWorldAttackMap[progressData.TimeEventID]
                    if attackConfig==nil then
                        attackConfig=ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(progressData.TimeEventID)]
                    end
                    if attackConfig~=nil and progressData.Progress < attackConfig.SeasonalMonsterHP then
                        hasTimedEvent=true
                        this.timedEventMainGridMap[mainGridID]=attackConfig.ShowIcon==1 and 2 or 1
                        break
                    end
                end
            end
        end
        if cfgGrid.GridMiniMap==1 or hasTimedEvent then
            local center=Vector2(0,0)
            for _, gridID in ipairs(gridList) do
                local topDownPosition = SeasonSLGSmallMapMgr.GetTopDownPositionByIndex(gridID)
                center=center+topDownPosition
            end
            center=center/#gridList
            this.showGridList[mainGridID]=cfgGrid
            this.gridGroupPositionMap[mainGridID]=center
            if not hasTimedEvent then
                this.timedEventMainGridMap[mainGridID]=0
            end
        end
    end

    return this.showGridList
end

SeasonSLGSmallMapMgr.GetGridGroupPosition=function(index)
    SeasonSLGSmallMapMgr.GetCurAreaGridList()
    return this.gridGroupPositionMap[tostring(index)]
end

SeasonSLGSmallMapMgr.GetMainGridID=function(index)
    SeasonSLGSmallMapMgr.GetCurAreaGridList()
    return this.gridMainMap[tostring(index)]
end

SeasonSLGSmallMapMgr.SmallMapBlockItem = function(pos)
    local ret, x, y = SeasonSLGSmallMapMgr.WorldToGrid(pos)
    if ret then
        local index = SeasonSLGMapMgr.GetBlockIndexByLoc(y,x)
        SeasonSLGSmallMapMgr.SmallMapBlockItemCallBack({index=index})
        return index
    end
end

SeasonSLGSmallMapMgr.JumpToGrid = function(x,y)
    local index = SeasonSLGMapMgr.GetBlockIndexByLoc(y,x)
    SeasonSLGMapMgr.JumpToMapGrid(tostring(index))

end

SeasonSLGSmallMapMgr.SmallMapBlockItemCallBack = function(data1)
    local gridID = tostring(data1.index)
    local gridMap = SeasonSLGMapMgr.GetCurSeasonMapCfgData()
    local grid = gridMap[gridID]
    local title = data1.name


    local locY,locX = SeasonSLGMapMgr.GetBlockLocByIndex(data1.index)
    if IsNullOrEmpty(title) then
        title = LuaMgr.GetLangText("SeasonSLGSmallMapMgr_0")
    end

    local cfgGrid=SeasonSLGMapMgr.gridMap[tostring(data1.index)]
    if SeasonSLGMapMgr.CheckBlockIsLockByArea(cfgGrid.Area) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGSmallMapMgr_1"))
        return;
    end


    local des=LuaMgr.GetLangText("SeasonSLGSmallMapMgr_2") .. "(" .. (locX) .. "," .. (locY) .. ")"
    LuaMgr.ShowLuaPanel(UIName.SeasonSLGSmallMapJumpViewModel,title,des,function()
        SeasonSLGMapMgr.JumpToMapGrid(tostring(data1.index))
    end)

end



SeasonSLGSmallMapMgr.GetCurGridCfg=function(index)
    local gridMap = SeasonSLGMapMgr.GetCurSeasonMapCfgData()
    return gridMap[index]






end


SeasonSLGSmallMapMgr.GetCurMapID=function()
    local seasonal=SeasonSLGMapMgr.GetCurSeasonCfgData();
    if seasonal==nil then return end;
    return seasonal.Map[1]
end

SeasonSLGSmallMapMgr.GetCurMapImages=function()
    local mapID = SeasonSLGSmallMapMgr.GetCurMapID()







    return {"LG1_0_0", "LG1_1_0", "LG1_1_1","LG1_8_8"}
end

SeasonSLGSmallMapMgr.GetBlockLocByIndex=function(index)
    local index = tonumber(index)-1
    local colIndex=index%SeasonSLGMapMgr.mapConfig.col;
    local rowIndex=math.floor(index/SeasonSLGMapMgr.mapConfig.col);

    return colIndex,rowIndex;
end

SeasonSLGSmallMapMgr.GetSmallMapBlockPositionByIndexEx = function(index)
    local blockPos, row, col = SeasonSLGSmallMapMgr.GetTopDownPositionByIndex(index)
    local pos = { x = blockPos.x, y = blockPos.y }
    return pos, row, col
end

SeasonSLGSmallMapMgr.WorldToGrid = function(pos)
    if pos == nil then
        return false
    end


    local row, col = SeasonSLGSmallMapMgr.GetTopDownIndexByPosition(pos)
    if row == nil or col == nil then
        return false
    end
    if SeasonSLGSmallMapMgr.CheckGridLimit(col, row) then
        return true, col, row
    end
    return false
end

SeasonSLGSmallMapMgr.CheckGridLimit = function(locX,locY)
    if locX <= 0 or locX > SeasonSLGMapMgr.mapConfig.col then
        return false
    end
    if locY <= 0 or locY > SeasonSLGMapMgr.mapConfig.row then
        return false
    end

    return true
end


SeasonSLGSmallMapMgr.GetAreaIndexByAreaID=function(areaID)
    local areaList = SeasonSLGSmallMapMgr.GetCurAreaList()
    local found = nil
    for i,v in pairs(areaList) do
        if i==areaID then
            found = v
            break
        end
    end

    if found==nil then return end

    return SeasonSLGSmallMapMgr.GetPositionToIndex({x=found.Position[1],y=found.Position[2]})
end


function SeasonSLGSmallMapMgr.GetPositionToRowCol(position)

    local relX = position.x
    local relY = position.y
    local w = 220 * SeasonSLGSmallMapMgr.scalex
    local h = 220 * SeasonSLGSmallMapMgr.scaley

    local colIndex = math.floor(relX / w)
    local rowIndex = math.floor(relY / h)

    return rowIndex, colIndex
end


function SeasonSLGSmallMapMgr.GetRowColToIndex(rowIndex, colIndex)
    return rowIndex * SeasonSLGMapMgr.mapConfig.col + colIndex
end


function SeasonSLGSmallMapMgr.GetPositionToIndex(position)
    local rowIndex, colIndex = SeasonSLGSmallMapMgr.GetPositionToRowCol(position)
    return SeasonSLGSmallMapMgr.GetRowColToIndex(rowIndex, colIndex)
end

function SeasonSLGSmallMapMgr.GetBlockName(gridID)
    local timedEventDatas = SeasonSLGMapMgr.MapStateData.TimedEventProgress
    if timedEventDatas ~= nil then

        local timedEventData = timedEventDatas[tostring(gridID)]
        if timedEventData ~= nil and timedEventData.EventType == SeasonSLGConst.GridFuncType.Misinter
                and timedEventData.Config ~= nil then
            return string.format("Lv.%d", timedEventData.Config.EventLevel or 0), SeasonSLGConst.TextType.Text
        end
    end
    return SeasonSLGMapMgr.GetGridName(tonumber(gridID))
end