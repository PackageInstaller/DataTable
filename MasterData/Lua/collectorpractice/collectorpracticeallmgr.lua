require("CollectorPractice/CollectorPracticeMgr")
require("CollectorPractice/CollectorPracticeMgrVersion2")
CollectorPracticeAllMgr = {};

CollectorPracticeAllMgr.currentMap=nil;
CollectorPracticeAllMgr.currentMapId=nil;
CollectorPracticeAllMgr.currentSelectMap=nil;

CollectorPracticeAllMgr.InitCurrentMapData=function ()
    CollectorPracticeAllMgr.currentMap=nil;
if DataMgr.Player.practicePosition=="PRACTICE_1" then
        CollectorPracticeAllMgr.currentMap="MapA";
    elseif DataMgr.Player.practicePosition=="PRACTICE_2" then
        CollectorPracticeAllMgr.currentMap="MapB";
    elseif DataMgr.Player.practicePosition=="PRACTICE_3" then
        CollectorPracticeAllMgr.currentMap="MapC";
    end
end

CollectorPracticeAllMgr.CheckFirstState=function ()
    local mapData = DataMgr.Player.practicesStage
if mapData.refreshTime==0 then
        return false;
    else

        if mapData.stages[#mapData.stages][1].stageid ~= "A10001" or(mapData.stages[#mapData.stages][1].stageid == "A10001" and mapData.stages[#mapData.stages][1].status ~= 2) then
            return true;
        else
            return false;
        end
    end
end


CollectorPracticeAllMgr.SelectMap=function (map)
    CollectorPracticeAllMgr.currentSelectMap=map;
end

CollectorPracticeAllMgr.IsCanJoinMapAndOnGame=function (map)
    local canJoinMapNameHashSet={};
    local isOnGame=false;
    if DataMgr.Player.practicePosition=="PRACTICE_1" then
       canJoinMapNameHashSet["MapA"]=false;
       isOnGame=true;
    elseif DataMgr.Player.practicePosition=="PRACTICE_2" then
        canJoinMapNameHashSet["MapB"]=false;
        isOnGame=true;
    end
    if TableIsNull(canJoinMapNameHashSet) then
        return true,isOnGame;
    else
        return canJoinMapNameHashSet[map]~=nil,isOnGame;
    end
end

CollectorPracticeAllMgr.IsMapOpen=function (map)
    local config=ConfigMgr.Config.PracticePeriodMaps;
    local currenTime = LuaMgr.Timestamp()
    if config[map]==nil then
        return false;
    else
        return ((config[map].closeTime>currenTime) and (config[map].openTime<currenTime));
    end
end