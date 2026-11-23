require("ViewModel/AreaMap/AreaMapBuilding")
require("ViewModel/AreaMap/AreaMapBuildingInfo")
require("ViewModel/AreaMap/AreaMapRoad")
require("ViewModel/AreaMap/AreaMapExplore")

AreaMapSceneMgr = {
isExplore = false,
isMapEnter = false,
isEnterShop = false,
isClick = true,
isFlag=false
}

local this = {
    currentArea = "",
    mapId = "",
    mapPath = "",
    sceneGO = nil,
    sceneTF = nil,
    scene = nil,
    buildingDic = nil,
    roadList = nil,
    explorePosList = nil,
    exploreDic = {},
    exploreHS = nil,
    buildingId = "",
    gotoBuildingDic = {},
    saibeiLockFx=nil,
};

AreaMapSceneMgr.Init = function(currentArea, parent, scrollView)
    local id = "AreaMap" .. string.upper(currentArea);
    if (this.mapId ~= id) then
        AreaMapSceneMgr.Destroy();
        this.currentArea = currentArea;
        AreaMapSceneMgr.Clear();
        this.mapId = id;
        this.mapPath = string.format("Assets/_BundleResources/UI/Area/%s.prefab", id);
        this.sceneGO = LuaMgr.GetPrefab(this.mapPath);
        if this.sceneGO==nil then
            this.sceneGO=LuaMgr.GetPrefab("Assets/_BundleResources/UI/Area/AreaMapLAIGU.prefab");
        end
        LuaMgr.AddPrefabRefCount(this.mapPath);
        this.sceneTF = this.sceneGO:GetComponent("RectTransform");
        this.sceneTF:SetParent(parent, false);
        this.scene = this.sceneGO:GetComponent("AreaMapScene");
        this.scene:SetData(scrollView);
        this.InitBuildings();
        this.InitRoads();
        this.InitExplorePos();

        if currentArea=="saibei" then
            this.saibeiLockFx=this.sceneGO.transform:Find("root/Middle/Layer2/DTUnlock").gameObject
        end
    end
end

AreaMapSceneMgr.SetAreaMapLockFXActive_SaiBei=function(area)
    if area=="saibei" and  this.saibeiLockFx~=nil and ConfigMgr.Config.constants.MainOpenTime~=nil then
        local isOn=LuaMgr.Timestamp()>=ConfigMgr.Config.constants.MainOpenTime
        SetActive(this.saibeiLockFx,not isOn);
    end
end


AreaMapSceneMgr.SetInfos = function(infos)
    this.SetBuildings(infos, this.scene.infoOffSet, 1);
    this.SetRoads();
end

AreaMapSceneMgr.Clear = function()
    this.ClearBuildings();
end

AreaMapSceneMgr.Destroy = function()
    this.mapId = "";
    this.RemoveBuildings();
    this.RemoveRoads();
    this.RemoveExplores();
    if (not IsNullOrEmpty(this.mapPath)) then
        LuaMgr.RemovePrefabRefCount(this.mapPath);
        this.mapPath = "";
    end
    if (this.sceneGO ~= nil) then
        this.sceneTF = nil;
        this.scene = nil;
        LuaMgr.DestroyImmediateGO(this.sceneGO);
        this.sceneGO = nil;
    end
end


AreaMapSceneMgr.SetBuildingId = function(id)
    this.buildingId = id;
end


AreaMapSceneMgr.GetBuildingId = function()
    return this.buildingId;
end


this.InitBuildings = function()
    local building;
    this.buildingDic = {};
    local buildings = this.sceneTF:GetComponentsInChildren(typeof(CS.Laigu.ViewModel.Area.AreaMapBuilding), true);
    local len = buildings.Length - 1;
    for i = 0, len do
        building = buildings[i];
        if (not IsNullOrEmpty(building.buildingId)) then
            if (this.buildingDic[building.buildingId] == nil) then
                this.buildingDic[building.buildingId] = AreaMapBuilding.New(building);
            end
        end
    end
end


this.ClearBuildings = function()
    if (this.buildingDic ~= nil) then
        for _, v in pairs(this.buildingDic) do
            v:Clear();
        end
    end
end


this.RemoveBuildings = function()
    if (this.buildingDic ~= nil) then
        for _, v in pairs(this.buildingDic) do
            v:Destroy();
        end
        this.buildingDic = nil;
    end
end


this.SetBuildings = function(infos, infoOffset, infoScale)
    local areaMap = DataMgr.Player.areaMaps[this.currentArea];
    if (areaMap == nil) then return end
    AreaMapSceneMgr.isFlag=false;
    AreaMapSceneMgr.SetAreaMapLockFXActive_SaiBei(this.currentArea)
    local mapGroup;
    local mapGroupData;
    local atlas;
    local areaAtlas = string.format("%sName", string.upper(this.currentArea));
    for k, v in pairs(this.buildingDic) do
        mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(this.currentArea, k);
        local isUnlockMap=false;
        if mapGroup~= nil and mapGroup.unlockmap~=nil and LuaMgr.Timestamp()<mapGroup.unlockmap then
            isUnlockMap=true;
            v:SetMeshAphlaEnable(true)
        end
        if (mapGroup ~= nil and not isUnlockMap) then
            if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
                local key=this.currentArea.."_"..k;
                local isUnLock=PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key]==nil and true or PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key];
                if mapGroup.showType == 1 then

                    isUnLock=false;
                end
                mapGroupData={id=k,lock=not isUnLock,lockForTime=true}
            else
                mapGroupData = areaMap.mapGroups[k];
            end
            if (mapGroupData ~= nil) then
                if v.building.infoPos~=nil and v.building.infoPos~=Vector2.zero then
                    infoOffset=Vector3(v.building.infoPos.x,v.building.infoPos.y,0);
                end
                v:SetInfo(infos[mapGroup.category], infoOffset, infoScale);
                atlas = mapGroup.category == AreaEventCategory.Resource and "AreaMapRes" or areaAtlas;
                if (LuaMgr.IsGuide()) then
                    PlayerAreaMapMgr.ModifyAreaMapBuildingStatus(this.currentArea, k);
                    PlayerAreaMapMgr.ModifyAreaMapBuildingEvents(this.currentArea, k);
                    v:SetData(this.currentArea, atlas, mapGroup.statusIcon, mapGroupData.lock, mapGroup.showType == 0, false);
                else
                    if (not PlayerAreaMapMgr.CheckAreaMapBuildingStatus(this.currentArea, k) or AreaMapSceneMgr.GetBuildingId() == "") then
                        if PlayerAreaMgr.GetAreaModel()==AreaModel.Normal then
                            PlayerAreaMapMgr.CheckMapBuildingUnlock(this.currentArea,mapGroupData);
                        end
                        v:SetData(this.currentArea, atlas, mapGroup.statusIcon, mapGroupData.lock, mapGroup.showType == 0, false);
                    else
                        v:SetData(this.currentArea, atlas, mapGroup.statusIcon, true, mapGroup.showType == 0, false);
                    end
                end
                
            else
                SetActive(v.gameObject, false);
            end
        end
    end
end


AreaMapSceneMgr.SetBuilding = function(building)
    local areaMap = DataMgr.Player.areaMaps[this.currentArea];
    if (areaMap == nil or building==nil) then return end

    local mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(this.currentArea, building.buildingId);
    if (mapGroup == nil) then return end
    local mapGroupData=nil;
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Novel then
        local key=this.currentArea.."_"..building.buildingId;
        local unlock=PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key];
        mapGroupData={id=building.buildingId,lock=not unlock,lockForTime=false}
    else
        mapGroupData = areaMap.mapGroups[building.buildingId];
    end
    if (mapGroupData == nil) then return end

    local atlas = string.format("%sName", string.upper(this.currentArea));
    if (mapGroup.category == AreaEventCategory.Resource) then
        atlas = "AreaMapRes";
    end
    if PlayerAreaMgr.GetAreaModel()==AreaModel.Normal then
        PlayerAreaMapMgr.CheckMapBuildingUnlock(this.currentArea,mapGroupData);
    end
    building:SetData(this.currentArea, atlas, mapGroup.statusIcon, mapGroupData.lock, mapGroup.showType == 0, true);
end


AreaMapSceneMgr.GetBuilding = function(id)
    if this.buildingDic == nil then
        return nil
    end
    return this.buildingDic[id];
end


AreaMapSceneMgr.GetNewBuildings = function(nbList, neList)
    local areaMap = DataMgr.Player.areaMaps[this.currentArea];
    if (areaMap == nil) then return end

    local config;
    local areaEventMap = ConfigMgr.Config.areaEvents;
    for k, v in pairs(this.buildingDic) do
        if (PlayerAreaMapMgr.CheckAreaMapBuildingStatus(this.currentArea, k)) then
            table.insert(nbList, v);
        else
            for ek, _ in pairs(areaMap.areaEvents) do
                config = areaEventMap[ek];
                if (config ~= nil and config.groupId == k) then
                    if (PlayerAreaMapMgr.CheckAreaMapBuildingNewEvent(this.currentArea, k, ek)) then
                        table.insert(neList, v);
                        break;
                    end
                end
            end
        end
    end
end


AreaMapSceneMgr.SetLight = function(id, status)
    if (IsNullOrEmpty(id)) then return end

    local building = AreaMapSceneMgr.GetBuilding(id);
    if (building ~= nil) then
        building:SetLight(status);
    end
end


AreaMapSceneMgr.SetGotoBuilding = function(area, buildingId)
    this.gotoBuildingDic[area] = buildingId;
end


AreaMapSceneMgr.GetGotoBuilding = function(area)
    return this.gotoBuildingDic[area];
end


AreaMapSceneMgr.ClearGotoBuilding = function()
    this.gotoBuildingDic = {};
end


AreaMapSceneMgr.GetObjectPos = function(rectTransform,contentTransform)
    if IsObjectNull(this.sceneGO) or IsObjectNull(this.scene) then
        return
    end
    return this.scene:GetObjectPos(rectTransform,contentTransform);
end


AreaMapSceneMgr.SetMapPos = function()
    this.scene:SetPos();
end


this.InitRoads = function()
    local road;
    this.roadList = {};
    local roads = this.sceneTF:GetComponentsInChildren(typeof(CS.Laigu.ViewModel.Area.AreaMapRoad), true);
    local len = roads.Length - 1;
    for i = 0, len do
        road = roads[i];
        if (not IsNullOrEmpty(road.buildingId)) then
            table.insert(this.roadList, AreaMapRoad.New(road));
        end
    end
end


this.SetRoads = function()
    if (this.roadList ~= nil) then
        local len = #this.roadList;
        for i = 1, len do
            this.roadList[i]:SetData(this.currentArea);
        end
    end
end


this.RemoveRoads = function()
    if (this.roadList ~= nil) then
        local len = #this.roadList;
        for i = 1, len do
            this.roadList[i]:Clear();
        end
        this.roadList = nil;
    end
end


this.InitExplorePos = function()
    local tf;
    this.explorePosList = {};
    local buildingsTF = this.scene.buildingsTransform;
    for i = 1, 100 do
        tf = buildingsTF:Find("Explore_" .. i);
        if (tf == nil) then break end

        table.insert(this.explorePosList, tf);
    end
end


AreaMapSceneMgr.SetExplores = function()
    for _, v in pairs(this.exploreDic) do
        v:Clear();
    end
    this.exploreHS = {};
    local areaExplore = DataMgr.Player.areaExplores[this.currentArea];
    if (areaExplore == nil) then return end
    if (areaExplore.currentExplores == nil) then return end

    local explore;
    for _, v in pairs(areaExplore.currentExplores) do
        explore = this.exploreDic[v.posIndex];
        if (v.status ~= 0 or v.posIndex <= 0) then
            if (explore ~= nil) then
                this.exploreDic[v.posIndex] = nil;
                explore:Destroy();
                explore = nil;
            end
        else
            if (explore == nil) then
                if (v.posIndex <= #this.explorePosList) then
                    explore = AreaMapExplore.New(this.explorePosList[v.posIndex]);
                    this.exploreDic[v.posIndex] = explore;
                end
            end
            explore:SetData(this.currentArea, v);
        end
    end
end

AreaMapSceneMgr.ClearExplores=function()
    for _, v in pairs(this.exploreDic) do
        v:Clear();
    end
end


this.RemoveExplores = function()
    for _, v in pairs(this.exploreDic) do
        v:Destroy();
    end
    this.exploreDic = {};
end


AreaMapSceneMgr.UpdateExplores = function()
    for _, v in pairs(this.exploreDic) do
        v:Update();
    end
end


AreaMapSceneMgr.GetAreaExplore = function(posIndex)
    return this.exploreDic[posIndex];
end


AreaMapSceneMgr.GetAreaExplore = function(exploreId)
    local areaExplore = DataMgr.Player.areaExplores[this.currentArea];
    if (areaExplore == nil) then return nil end
    if (areaExplore.currentExplores == nil) then return nil end

    local explore;
    for _, v in pairs(areaExplore.currentExplores) do
        if (v.exploreId == exploreId) then
            explore = this.exploreDic[v.posIndex];
            if (explore ~= nil) then
                return explore;
            end
        end
    end
    return nil;
end


PlayerAreaMapMgr.GetExploreCount = function()
    local count = 0;
    for _, v in pairs(this.exploreDic) do
        if (v.data ~= nil) then
            count = count + 1;
        end
    end
    return count;
end


PlayerAreaMapMgr.GotoExplore = function()
    local count = 0;
    for _, _ in pairs(this.exploreHS) do
        count = count + 1;
    end
    if (count >= PlayerAreaMapMgr.GetExploreCount()) then
        this.exploreHS = {};
    end
    for k, v in pairs(this.exploreDic) do
        if (v.data ~= nil and this.exploreHS[k] == nil) then
            this.exploreHS[k] = true;
            v:Goto();
            break;
        end
    end
end

AreaMapSceneMgr.ClearExploreParam = function()
    AreaMapSceneMgr.isEnterShop = false;
    AreaMapSceneMgr.isExplore = false;
    AreaMapSceneMgr.isMapEnter = false;
end


AreaMapSceneMgr.GetTimeDHM = function(time)
    local sec = time % 60;
    local min = (time % 3600) / 60;
    local hour = time / 3600;
    local day = hour / 24;
    hour = hour - day * 24;
    local str;
    if (day > 0) then
        str = string.format(LuaMgr.GetLangText("AreaMapManager_0"), day, hour);
    else
        min = sec > 0 and min + 1 or min;
        str = string.format(LuaMgr.GetLangText("AreaMapManager_1"), hour, min);
    end
    return str;
end

AreaMapSceneMgr.CurrentLockArea = function()
    local areas = ConfigMgr.Config.areas;
    local areaMaps = {};
    for _, v in pairs(areas) do
        if v.world=="zhengzhuan" then
            table.insert(areaMaps, v)
        end
    end
    table.sort(areaMaps, this.SortAreaMaps2);

    local unlockMaxIndex = 0;
    local len = #areaMaps;
    for i = 1, len do
        local area = areaMaps[i].area;
        if (not PlayerAreaMgr.CheckAreaUnlock(area)) then
            break;
        end
        if not IsNullOrEmpty(areaMaps[i].unlockParam) and  ConfigMgr.Config.areaEvents[areaMaps[i].unlockParam].type==1 then
            local preEventId=ConfigMgr.Config.areaEvents[areaMaps[i].unlockParam].unlockParam
            if not PlayerAreaMapMgr.CheckDungeonRecords(preEventId) then
                break;
            end
        end
        unlockMaxIndex = unlockMaxIndex + 1;
    end
    return areaMaps[unlockMaxIndex].area;
end

this.SortAreaMaps2 = function(a, b)
    return a.sortNum<b.sortNum;
end

this.SortAreaMaps = function(a, b)
    return a.sortNum > b.sortNum;
end


AreaMapSceneMgr.IsCompleteEvent = function(area, id)
    local events = ConfigAreaMapMgr.GetAreaMapEvents(area);
    if (events == nil) then return false end

    local item;
    local record;
    local completedAreaEvents = DataMgr.Player.completedAreaEvents;
    local dungeonRecords = DataMgr.Player.dungeonRecords;
    local len = #events;
    for i = 1, len do
        item = events[i];
        if (item.groupId == id and item.category ~= AreaEventCategory.Explore) then
            if (item.type == AreaEventType.AVG) then
                if (not completedAreaEvents[item.eventParam]) then
                    return false;
                end
            else
                record = dungeonRecords[item.eventParam];
                if (record == nil or record.historyRating == "") then
                    return false;
                end
            end
        end
    end
    return true;
end


AreaMapSceneMgr.IsCompleteEvent_S = function(area, id)
    local events = ConfigAreaMapMgr.GetAreaMapEvents(area);
    if (events == nil) then return false end

    local item;
    local record;
    local completedAreaEvents = DataMgr.Player.completedAreaEvents;
    local dungeonRecords = DataMgr.Player.dungeonRecords;
    local len = #events;
    for i = 1, len do
        item = events[i];
        if (item.groupId == id and item.category ~= AreaEventCategory.Explore) then
            if (item.type == AreaEventType.AVG) then
                if (not completedAreaEvents[item.eventParam]) then
                    return false;
                end
            else
                record = dungeonRecords[item.eventParam];
                if (record == nil or record.historyRating ~= "S") then
                    return false;
                end
            end
        end
    end
    return true;
end


AreaMapSceneMgr.IsLevelChallenges = function(area, id)
    local events = ConfigAreaMapMgr.GetAreaMapEvents(area);
    if (events == nil) then return false end
    
    local item;
    local len = #events;
    for i = 1, len do
        item = events[i];
        if (item.groupId == id and item.type == AreaEventType.Battle) then
            if (not AreaMapSceneMgr.IsLevelChallengesById(item.eventParam)) then
                return false;
            end
        end
    end
    return true;
end


AreaMapSceneMgr.IsLevelChallengesById = function(id)
    local list = ConfigMgr.Config.levelChallenges[id];
    if (list == nil) then return true end

    local completedTags = DataMgr.Player.completedTags;
    local len = #list;
    for i = 1, len do
        if (completedTags[list[i]] == nil) then
            return false;
        end
    end
    return true;
end


AreaMapSceneMgr.IsClearHideEvent = function(area, id)























    return true;
end


AreaMapSceneMgr.FilterZhengzhuanAndUnLockAreaMap = function()

    local areas = {};

    local isBanned = false
    for _, v in pairs(ConfigMgr.Config.areas) do

        isBanned = FeatureManager.UnifyVerControls("areamap",v.area)
        if (v.world == "zhengzhuan") and isBanned then
            if PlayerAreaMgr.CheckAreaUnlock(v.area) then
                table.insert(areas, v);
            end





        end
    end
    return areas;
end

AreaMapSceneMgr.AreaPass=function (area)
    local events=ConfigAreaMapMgr.GetAreaMapEvents(area)
    if events==nil then
        return false;
    end
    for key, item in pairs(events) do
        if item.category == AreaEventCategory.Main then
            if item.type==AreaEventType.AVG then
                if DataMgr.Player.completedAreaEvents[item.eventParam]==nil then
                    return false
                end
            else
                local record=DataMgr.Player.dungeonRecords[item.eventParam]
                if record==nil then
                    return false;
                end
            end
        end
    end
    return true;
end

AreaMapSceneMgr.AreaPass_S=function (area)
    local events=ConfigAreaMapMgr.GetAreaMapEvents(area)
    for key, eventItem in pairs(events) do
        if eventItem.category == AreaEventCategory.Hide then
            if eventItem.type==AreaEventType.AVG then
                if DataMgr.Player.completedAreaEvents[eventItem.eventParam]==nil then
                    return false
                end
            else
                if DataMgr.Player.dungeonRecords[eventItem.eventParam]==nil then
                    return false;
                end
            end
        else
            if eventItem.type==AreaEventType.AVG then
                if DataMgr.Player.completedAreaEvents[eventItem.eventParam]==nil then
                    return false
                end
            else
                local record=DataMgr.Player.dungeonRecords[eventItem.eventParam]
                if record==nil or record.historyRating ~= "S" or (not AreaMapSceneMgr.IsLevelChallengesById(eventItem.eventParam) )then
                    return false;
                end
            end
        end
    end
    return true;
end

AreaMapSceneMgr.CheckCourseRed = function ()
    local dataMissions = DataMgr.Player.missions;
    local unlockAreas = AreaMapSceneMgr.FilterZhengzhuanAndUnLockAreaMap();
    table.sort(unlockAreas, function(a, b)
       return a.sortNum > b.sortNum
    end)
    local red = 0;
    for key, area in pairs(unlockAreas) do
       if (dataMissions[area.area] == nil) then
           goto continue1
       end
       local areaData = dataMissions[area.area]["202"];
       if areaData ~= nil then
           for key, item in pairs(areaData) do
               if (item.completed) then goto continue2 end
               ;
               if (item.current >= item.target) then
                   red = 1;
                   break;
               end
               ::continue2::
           end
       end
       local areaPhaseData = dataMissions[area.area]["203"];
       if areaPhaseData ~= nil then
           for key, item in pairs(areaPhaseData) do
               if (item.completed) then goto continue3 end
               if (item.current >= item.target) then
                   red = 1;
                   break;
               end
               ::continue3::
           end
       end
       ::continue1::
    end
    return red;
end