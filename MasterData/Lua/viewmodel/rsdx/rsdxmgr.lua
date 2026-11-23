require("ViewModel/RSDX/Data/RSDXElementItemData")
require("ViewModel/RSDX/Data/RSDXConst")

RSDXMgr = {
  areaList={};
groupMapList={};
eventMapList={};
  buildTaskList={};
  typeIndex=nil;
  redEventMap={};
}

local this = {
    eventCompleteTag={"kfs","khg","tg","zhong","liang","you"},
    levelDatas = {},
    levelDataDic = {}
}

RSDXMgr.Init=function()
    if #RSDXMgr.areaList==0 then
        RSDXMgr.areaList={};
        for i,v in ipairs(ConfigMgr.Config.activityMapList) do
            if string.starts(v.area,"RSDX") then
                table.insert(RSDXMgr.areaList,v);
            end
        end
        table.sort(RSDXMgr.areaList,function(a, b) return a.sortNum<b.sortNum end)
    end
    if NumTool.GetLen(RSDXMgr.groupMapList)==0 then
        RSDXMgr.groupMapList={}
        for i,v in ipairs(ConfigMgr.Config.activityMapGroupList) do
            if string.starts(v.area,"RSDX") then
                if RSDXMgr.groupMapList[v.area]==nil then
                    RSDXMgr.groupMapList[v.area]={};
                end
                table.insert(RSDXMgr.groupMapList[v.area],v);
            end
        end
    end
    if NumTool.GetLen(RSDXMgr.eventMapList)==0 then
        RSDXMgr.eventMapList={};
        for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if string.starts(v.area,"RSDX") then
                if RSDXMgr.eventMapList[v.groupId]==nil then
                    RSDXMgr.eventMapList[v.groupId]={};
                end
                table.insert(RSDXMgr.eventMapList[v.groupId],v);
            end
        end
    end
    if #RSDXMgr.buildTaskList==0 then
        RSDXMgr.buildTaskList=DataExHelper.Check_ConfigQuestEventByText("RSDXBuildTASK")
    end

    RSDXMgr.InitGameData()
end

RSDXMgr.CheckActiveIsRunning=function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.RSDX) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
        return false;
    end
    return true;
end


RSDXMgr.GetBuildTaskStateAndProgress=function()
    local state=0;
    local pro,max=0,#RSDXMgr.buildTaskList-1
    local cfgBuild=RSDXMgr.buildTaskList[1];
    local dataBuild=DataMgr.Player.quests[cfgBuild.id]
    if dataBuild~=nil then
        state=dataBuild.state;
    end
    for i=2,#RSDXMgr.buildTaskList do
        local id=RSDXMgr.buildTaskList[i].id;
        if DataMgr.Player.quests[id]~=nil and DataMgr.Player.quests[id].state>=2 then
            pro=pro+1;
        end
    end
    return state,pro,max;
end


RSDXMgr.CheckAreaIsUnlock=function(curAreaCfg)
    local isUnlock=false;
    if LuaMgr.Timestamp()>curAreaCfg.openDate and LuaMgr.Timestamp()<curAreaCfg.closeDate then
        if curAreaCfg.unlockType==0 or IsNullOrEmpty(curAreaCfg.unlockParam) then
            isUnlock=true;
        else
            isUnlock=DataHelper.CheckDungeonComplete(curAreaCfg.unlockParam)
        end
    end
    return isUnlock
end


RSDXMgr.CheckGroupIsUnlock=function(curGroupCfg)
    local isUnlock=false;
    if LuaMgr.Timestamp()>curGroupCfg.openDate and LuaMgr.Timestamp()<curGroupCfg.closeDate then
        if curGroupCfg.unlockType==0 or IsNullOrEmpty(curGroupCfg.unlockParam) then
            isUnlock=true;
        else
            isUnlock=DataHelper.CheckDungeonComplete(curGroupCfg.unlockParam)
        end
    end
    return isUnlock
end



RSDXMgr.CheckEventIsComplete=function(curEventCfg)
    if curEventCfg.type==1 then
        return DataHelper.CheckNovelComplete(curEventCfg.eventParam)
    elseif curEventCfg.type==2 then
        return DataHelper.CheckDungeonComplete(curEventCfg.eventParam)
    elseif curEventCfg.type==3 then

        return RSDXMgr.CheckGameIsUnlock(curEventCfg.eventParam);
    end
end
    
    


RSDXMgr.CheckEventIsUnLock=function(curEventCfg)

    if curEventCfg.openDate>0 and curEventCfg.closeDate>0 then
        if LuaMgr.Timestamp()<curEventCfg.openDate  then
            local lockInfo=os.date("%Y/%m/%d %H:%M", curEventCfg.openDate)
            return false,string.format(ConfigMgr.LangGlobal("31158"),lockInfo);
        end
    end

    if curEventCfg.unlockType==0 then
       return true;
    elseif curEventCfg.unlockType==1 then
        if curEventCfg.type==1 then
            return DataHelper.CheckNovelComplete(curEventCfg.unlockParam)
        elseif curEventCfg.type==2 then
            return DataHelper.CheckDungeonComplete(curEventCfg.unlockParam)
        elseif curEventCfg.type==3 then

            return RSDXMgr.CheckGameIsUnlock(curEventCfg.unlockParam);
        end
    end
    
end
RSDXMgr.GetEventCompleteTag=function(curEventCfg)
    if curEventCfg.type==1 then
        if DataHelper.CheckNovelComplete(curEventCfg.eventParam) then
            return this.eventCompleteTag[2]
        end
    elseif curEventCfg.type==2 then
        local dungeon=DataMgr.Player.dungeonRecords[curEventCfg.eventParam];
        if dungeon~=nil and dungeon.completeCount>0 then
            if curEventCfg.area=="RSDX1" then

                return this.eventCompleteTag[1]
            elseif curEventCfg.area=="RSDX4" then

                return this.eventCompleteTag[3]
            elseif curEventCfg.area=="RSDX5" then

                if dungeon.historyRating=="S" then
                    return this.eventCompleteTag[6]
                elseif dungeon.historyRating=="A" then
                    return this.eventCompleteTag[5]
                elseif dungeon.historyRating=="B" then
                    return this.eventCompleteTag[4]
                end
            end
        end
    elseif curEventCfg.type==3 then

        if RSDXMgr.CheckGameIsComplete(curEventCfg.eventParam) then
            return this.eventCompleteTag[3]
        end
    end
    return nil;
    
end


RSDXMgr.CheckGameIsUnlock=function(unlockParam)
    return RSDXMgr.CheckGameIsComplete(unlockParam);
end


RSDXMgr.CheckGameIsComplete=function(eventId)
    if type(DataMgr.Player.ColorGame) ~= "table" or type(DataMgr.Player.ColorGame.LevelMap) ~= "table" then
        return false
    end
    return DataMgr.Player.ColorGame.LevelMap[eventId] ~= nil
end


RSDXMgr.InitGameData = function()
    local colorGameConfigs = ConfigMgr.Config.ColorGameMap
    local elementConfigs = ConfigMgr.Config.ColorGameElementMap

    local colorGameConfigData = {}
    local colorGameConfigColRowData = {}
    for i = 1, 1000 do
        local id = tostring(i)
        local config = colorGameConfigs[id]
        if config == nil then
            break
        end
        local levelID = config.LevelId
        if colorGameConfigData[levelID] == nil then
            colorGameConfigData[levelID] = {}
        end
        if colorGameConfigColRowData[levelID] == nil then
            colorGameConfigColRowData[levelID] = {}
        end
        local gridPosY = config.Rows
        for j = 1, 100 do
            local colName = string.format("Columns%d", j)
            local elementID = config[colName]
            if type(elementID) ~= "number" then
                break
            end
            if elementID ~= 0 then
                local data = RSDXElementItemData.New()
                data.GridPos = GridPosition.New(j, gridPosY)
                data.GridPosKey = data.GridPos:ToString()
                data.OrigeonElementID = elementID
                data.ElementConfig = elementConfigs[elementID]
                data:RefreshElement(data.OrigeonElementID)
                table.insert(colorGameConfigData[levelID], data)
                if colorGameConfigColRowData[levelID][j] == nil then
                    colorGameConfigColRowData[levelID][j] = {}
                end
                colorGameConfigColRowData[levelID][j][gridPosY] = data
            end
        end
    end
    local levelMapConfigs = ConfigMgr.Config.ColorGameLevelMap
    this.levelDatas = {}
    this.levelDataDic = {}
    for i = 1, 1000 do
        local id = string.format("RSDX%d", i + 1000)
        local config = levelMapConfigs[id]
        if config == nil then
            break
        end
        local data = table.CopyNoMeta(config)
        local id = config.Id

        data.GridDatas = colorGameConfigData[id]
        data.GridColRowData = colorGameConfigColRowData[id]
        data.MaxRow = RSDXConst.LevelMaxRow
        data.MaxCol = RSDXConst.LevelMaxCol
        table.insert(this.levelDatas, data)
        this.levelDataDic[id] = data
    end
end

RSDXMgr.GetAllGameData = function ()
    return this.levelDatas
end

RSDXMgr.GetCurPassData = function(passID)
    if passID == nil then
        passID = RSDXConst.DefaultLevelID
    end
    return this.levelDataDic[passID]
end

RSDXMgr.GetEventDataByPassID = function(passID)
    local area=RSDXMgr.areaList[3].area
    local groupId=RSDXMgr.groupMapList[area][1].id
    local eventList=RSDXMgr.eventMapList[groupId]
    for i,v in ipairs(eventList) do
        if v.eventParam == passID then
            return v
        end
    end
    return nil
end 




RSDXMgr.GetGridDataByPos = function(passID, gridPos)
    local passData = RSDXMgr.GetCurPassData(passID)
    if gridPos.X <= 0 or gridPos.Y <= 0 or gridPos.X > passData.MaxCol or gridPos.Y > passData.MaxRow then
        return nil
    end
    local gridDatas = passData.GridColRowData
    return gridDatas[gridPos.X][gridPos.Y]
end


function RSDXMgr.GetAllEliminateDatas(passID, choosedElement)
    local closeSet = {}
    local openSet = {}
    openSet[choosedElement.GridPosKey] = choosedElement
    while next(openSet) do
        local elementItemData = nil
        for key, value in pairs(openSet) do
            elementItemData = value
            break
        end
        if elementItemData then
            openSet[elementItemData.GridPosKey] = nil
            closeSet[elementItemData.GridPosKey] = elementItemData
            for i = 1, #RSDXConst.ForNeighborData do
                local neighbor = RSDXConst.ForNeighborData[i]
                local pos = elementItemData.GridPos:AddRef(neighbor.x, neighbor.y)
                local neighborElement = RSDXMgr.GetGridDataByPos(passID, pos)
                if neighborElement ~= nil and closeSet[neighborElement.GridPosKey] == nil and neighborElement.CurElementID == choosedElement.CurElementID then
                    openSet[neighborElement.GridPosKey] = neighborElement
                end
            end
        end
    end
    return closeSet
end




RSDXMgr.SetEventRed=function()
    local redList={0,0,0,0,0}
    RSDXMgr.redEventMap={}

    for i=1,5,1 do
        local area=RSDXMgr.areaList[i].area;

        local groupId=RSDXMgr.groupMapList[area][1].id;
        local eventList=RSDXMgr.eventMapList[groupId];
        for p,v in ipairs(eventList) do
            local key=DataMgr.Player.uid.."RSDX_"..v.id;
            if not RSDXMgr.CheckEventIsComplete(v) and  RSDXMgr.CheckEventIsUnLock(v) and PlayerPrefs.GetInt(key)==0 then
                redList[i]=1;
                RSDXMgr.redEventMap[v.id]=1;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17902",redList[1]);
    RedMgr.Singleton:UpdateClientRedData("17903",redList[2]);
    RedMgr.Singleton:UpdateClientRedData("17904",redList[3]);
    RedMgr.Singleton:UpdateClientRedData("17905",redList[4]);
    RedMgr.Singleton:UpdateClientRedData("17906",redList[5]);
    return redList[1]+redList[2]+redList[3]+redList[4]+redList[5];
end


return RSDXMgr