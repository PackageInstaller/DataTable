CollectorPracticeMgrVersion2 = {};

CollectorPracticeMgrVersion2.ReawrdBuffMap = {};
CollectorPracticeMgrVersion2.NormalBuffMap = {};
CollectorPracticeMgrVersion2.ReawrdTypeBuffMap = {};
CollectorPracticeMgrVersion2.EventPoolIdToEventNumberValue = {};
CollectorPracticeMgrVersion2.InitData=function ()
    CollectorPracticeMgrVersion2.InitBuffData();
    CollectorPracticeMgrVersion2.InitEventData();
end

CollectorPracticeMgrVersion2.InitEventData=function ()
    local Config=ConfigMgr.Config.YX2EventPool;
    for index, value in ipairs(Config) do
        if CollectorPracticeMgrVersion2.EventPoolIdToEventNumberValue[value.EventPool]==nil then
            CollectorPracticeMgrVersion2.EventPoolIdToEventNumberValue[value.EventPool]={};
        end
        CollectorPracticeMgrVersion2.EventPoolIdToEventNumberValue[value.EventPool][value.EventNumber]=value;
    end
end

CollectorPracticeMgrVersion2.InitBuffData = function()
    CollectorPracticeMgrVersion2.ReawrdBuffMap = {};
    CollectorPracticeMgrVersion2.NormalBuffMap = {};
    CollectorPracticeMgrVersion2.ReawrdTypeBuffMap = {};
    local data = ConfigMgr.Config.YX2Buffs;
    for key, value in pairs(data) do
        if value.Type[1] == 1 then
            CollectorPracticeMgrVersion2.NormalBuffMap[value.Id] = value;
        else
            CollectorPracticeMgrVersion2.ReawrdBuffMap[value.Id] = value;
            if CollectorPracticeMgrVersion2.ReawrdTypeBuffMap[value.Type[2]] == nil then
                CollectorPracticeMgrVersion2.ReawrdTypeBuffMap[value.Type[2]] = {};
            end
            table.insert(CollectorPracticeMgrVersion2.ReawrdTypeBuffMap[value.Type[2]], value);
        end
    end
    for key, value in pairs(CollectorPracticeMgrVersion2.ReawrdTypeBuffMap) do
        table.sort(value, function(a, b)
            return a.Type[3] < b.Type[3];
        end);
    end
end

CollectorPracticeMgrVersion2.HaveRewardBuff = {};
CollectorPracticeMgrVersion2.HaveAllRewardBuff = {};

CollectorPracticeMgrVersion2.InitMainSceneBuffData = function()
    local buffs = DataMgr.Player.practiceStage2.buffs;
    CollectorPracticeMgrVersion2.HaveRewardBuff = {};
    CollectorPracticeMgrVersion2.HaveAllRewardBuff={};
    if IsNull(buffs) or TableIsNull(buffs) then
        return;
    end
    for key, value in pairs(CollectorPracticeMgrVersion2.ReawrdTypeBuffMap) do
        CollectorPracticeMgrVersion2.HaveRewardBuff[key] = {};
        CollectorPracticeMgrVersion2.HaveAllRewardBuff[key]=0;
    end
    for index, value in ipairs(buffs) do
        local buffData=CollectorPracticeMgrVersion2.GetBuffValueById(value);
        if buffData.Type[1] == 1 then
            table.insert(CollectorPracticeMgrVersion2.HaveRewardBuff[buffData.Type[2]], value);
        end
        CollectorPracticeMgrVersion2.HaveAllRewardBuff[buffData.Type[2]]=CollectorPracticeMgrVersion2.HaveAllRewardBuff[buffData.Type[2]]+1;
    end
end




CollectorPracticeMgrVersion2.GetBuffTipsIconSprite = function(value)
    if value <= 3 then
        return LuaMgr.GetSprite("CollectorMainSceneVersion2", "ui_sx_jy_dj1");
    elseif value <= 6 then
        return LuaMgr.GetSprite("CollectorMainSceneVersion2", "ui_sx_jy_dj2");
    else
        return LuaMgr.GetSprite("CollectorMainSceneVersion2", "ui_sx_jy_dj3");
    end
end

CollectorPracticeMgrVersion2.GetBuffValueById = function(Id)
    if CollectorPracticeMgrVersion2.ReawrdBuffMap[Id]~=nil then
        return CollectorPracticeMgrVersion2.ReawrdBuffMap[Id];
    elseif CollectorPracticeMgrVersion2.NormalBuffMap[Id]~=nil then
        return CollectorPracticeMgrVersion2.NormalBuffMap[Id];
    end
end

CollectorPracticeMgrVersion2.GetNotFinishStage = function()
    local data=DataMgr.Player.practiceStage2.stages[DataMgr.Player.practiceStage2.crtEventNo+1].Stage;
    if not IsNull(data) then
        
        for index, value in ipairs(data) do
            if value~=nil and value.Finish==false then
                return index-1;
            end
        end
    end
    return 0;
end

CollectorPracticeMgrVersion2.CalculateCollect = function()
    local count,allCount = 0,0
    local tempData = nil

    tempData = DataMgr.Player.missions["YX2BUFF"]["701"]
    if not TableIsNull(tempData) then
        for key,value in pairs(tempData) do
            allCount = allCount + 1
            if value.completed then
                count = count + 1
            end
        end
    end

    tempData = DataMgr.Player.missions["YX2Event"]["701"]
    if not TableIsNull(tempData) then
        for key,value in pairs(tempData) do
            allCount = allCount + 1
            if value.completed then
                count = count + 1
            end
        end
    end

    local lock = true
    for key,value in pairs(ConfigMgr.Config.YX2NarrativeMap) do
        allCount = allCount + 1
        lock = CollectorPracticeMgrVersion2.NovelIsLock(value.NarrativesID)
        if not lock then
            count = count + 1
        end
    end
    return count / allCount
end
CollectorPracticeMgrVersion2.NovelIsLock = function(novelId)
    local len = #DataMgr.Player.completedChapters
    for i = 1, len do
        if (DataMgr.Player.completedChapters[i] == novelId) then
            return false
        end
    end
    return true
end

CollectorPracticeMgrVersion2.GetBuffType = function(Id)
    if CollectorPracticeMgrVersion2.ReawrdBuffMap[Id]~=nil then
        return 2;
    elseif CollectorPracticeMgrVersion2.NormalBuffMap[Id]~=nil then
        return 1;
    end
end


CollectorPracticeMgrVersion2.SelectMonsterSerializeData={};


CollectorPracticeMgrVersion2.IsOpenBattlePanel=false;
CollectorPracticeMgrVersion2.IsFirstOpenPanel=false;
CollectorPracticeMgrVersion2.DeemNotLevelMainScene=false;
CollectorPracticeMgrVersion2.OpenEventBeforeScrollViewContentPos=nil;
CollectorPracticeMgrVersion2.FirstOpenMainScene=false;
CollectorPracticeMgrVersion2.FirstOpenSelectMonster=false;

