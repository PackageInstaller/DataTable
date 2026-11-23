require("CollectorPractice/CollectorCharacter")
require("CollectorPractice/CollectorPracticeBuilding")
require("CollectorPractice/CollectorPracticeEvent")
require("CollectorPractice/CollectorPracticeHelper")
CollectorPracticeMgr = {};

local this = {};
local cortinues

local CurrentMap = ""
local currentMapId = ""




CollectorPracticeMgr.stepChildrenNum = 0







this.OpenNextScene = false

CollectorPracticeMgr.CurrentgalleryType = nil

CollectorPracticeMgr.playerLevelData = nil

CollectorPracticeMgr.ThemeCurrent = nil

CollectorPracticeMgr.HomeGrlleryData = {}

CollectorPracticeMgr.MissionConfigData = {}

CollectorPracticeMgr.MapOrder = {}

CollectorPracticeMgr.NextStepTab = {}

CollectorPracticeMgr.RewardTab = {};
CollectorPracticeMgr.OtherReward = {};
CollectorPracticeMgr.FinishTips = "";
CollectorPracticeMgr.FinishTipsState = 0;
CollectorPracticeMgr.ItemIdToCard = {};
CollectorPracticeMgr.InitMainScene = false;

















CollectorPracticeMgr.StoryData = {};


















CollectorPracticeMgr.GuideData = {};
CollectorPracticeMgr.characterToCompleteNum = {};
CollectorPracticeMgr.gradeToBuffData = {};
CollectorPracticeMgr.buffIdToBuffConfig = {};

CollectorPracticeMgr.isByBattleViewModel = false;

CollectorPracticeMgr.GetShopRecordByGoodsId = function(goodsId, shopId)
    local goodsdata = ComData.CollectorPracticeShop[shopId][goodsId]
    local count = goodsdata.datavalue;
    return count ~= nil and count or 0;
end

CollectorPracticeMgr.InitStoryData = function()
    CollectorPracticeMgr.StoryData = {};
    local tempStroyData = {};
    local storyQuestMap = ConfigMgr.Config.StoryQuestMap;
for key, value in pairs(storyQuestMap) do
        if tempStroyData == {} or tempStroyData[value.MapType] == nil then
            tempStroyData[value.MapType] = {};
            table.insert(tempStroyData[value.MapType], value);
        else
            table.insert(tempStroyData[value.MapType], value);
        end
    end

for mapType, Data in pairs(tempStroyData) do
        local questTypeToQuestionList = {};
        local questTypeToCharaterID = {};
        local questTypeToCompleteNum = {};
for key, value in pairs(Data) do
            local completeBool = false;
            if DataMgr.Player.storyQuest ~= nil and DataMgr.Player.storyQuest ~= {} and DataMgr.Player.storyQuest[value.QuestID] ~= nil then
                completeBool = DataMgr.Player.storyQuest[value.QuestID];
            end
            local quest = {
                questID = value.QuestID,
                optionID = value.OptionID,
                reward = value.Reward,
                storyShow = value.StoryShow,
                optionShow = value.OptionShow,
                complete = completeBool
            };
            if questTypeToQuestionList == {} or questTypeToQuestionList[value.QuestType] == nil then
                questTypeToQuestionList[value.QuestType] = {};
                table.insert(questTypeToQuestionList[value.QuestType], quest);
            else
                table.insert(questTypeToQuestionList[value.QuestType], quest);
            end

            questTypeToCharaterID[value.QuestType] = value.CharacterID;

if questTypeToCompleteNum == {} or questTypeToCompleteNum[value.QuestType] == nil then
                if completeBool then
                    questTypeToCompleteNum[value.QuestType] = 1;
                else
                    questTypeToCompleteNum[value.QuestType] = 0;
                end
            else
                if completeBool then
                    questTypeToCompleteNum[value.QuestType] = questTypeToCompleteNum[value.QuestType] + 1;
                end
            end
        end

        for key, value in pairs(questTypeToQuestionList) do
            table.sort(value, function(a, b)
return a.questID < b.questID;
            end)
        end

        local storyDataValue = {};
        for key, value in pairs(questTypeToQuestionList) do
            local temp = {
                questType = key,
                characterID = questTypeToCharaterID[key],
                completeNum = questTypeToCompleteNum[key],
                questList = value,
            }
            table.insert(storyDataValue, temp);
        end
        table.sort(storyDataValue, function(a, b)
            if a.questType == 4 then
                return false;
            elseif b.questType == 4 then
                return true;
            else
                return a.questType < b.questType;
            end
        end)
        CollectorPracticeMgr.StoryData[mapType] = storyDataValue;
    end
    CollectorPracticeMgr.characterToCompleteNum = {};
    for key, value in pairs(CollectorPracticeMgr.StoryData) do
        CollectorPracticeMgr.characterToCompleteNum[key] = {};
        for _, newValue in pairs(value) do
            CollectorPracticeMgr.characterToCompleteNum[key][newValue.characterID] = newValue.completeNum;
        end
    end
end

CollectorPracticeMgr.GetStoryDataPrecent=function ()
    if TableIsNull(CollectorPracticeMgr.StoryData) then
        CollectorPracticeMgr.InitStoryData();
    end
    local allNum=0;
    local finishNum=0;
    for index, value in ipairs(CollectorPracticeMgr.StoryData["MapA"]) do
        allNum=allNum+#value.questList;
        finishNum=finishNum+value.completeNum;
    end
    return finishNum/allNum;
end

CollectorPracticeMgr.AwakeInitGuideData = function()
    CollectorPracticeMgr.GuideData = {};

    local tempMap={};
    local config=ConfigMgr.Config.InternGuideMap;
    for key, value in pairs(config) do
        if tempMap[value.MapType]==nil then
            tempMap[value.MapType]={}; 
        end
        if tempMap[value.MapType][value.Group]==nil then
            tempMap[value.MapType][value.Group]={}; 
        end
        tempMap[value.MapType][value.Group][value.Order]=value;
    end
    
    for key1, value1 in pairs(tempMap) do
        local firstVector={};
        for key2, value2 in pairs(value1) do
            local secondVector={}
            for key3, value3 in pairs(value2) do
                table.insert(secondVector,value3);
            end            
            table.sort(secondVector,function (a, b)
                return a.Order<b.Order;
            end);
            table.insert(firstVector,secondVector);
        end
        table.sort(firstVector,function (a, b)
            return a[1].Group<b[1].Group;
        end);
        CollectorPracticeMgr.GuideData[key1]=firstVector;
    end

end

CollectorPracticeMgr.RefushStoryData = function(mapID)
    if TableIsNull(CollectorPracticeMgr.StoryData) then
        CollectorPracticeMgr.InitStoryData();
    end
    local vector = CollectorPracticeMgr.StoryData[mapID];
    for index, value in ipairs(vector) do
        for key, quest in pairs(value.questList) do
if (not TableIsNull(DataMgr.Player.storyQuest)) and DataMgr.Player.storyQuest[quest.questID] ~= nil and DataMgr.Player.storyQuest[quest.questID] and (not quest.complete) then
                quest.complete = true;
                value.completeNum = value.completeNum + 1;
            end
        end
    end
end

CollectorPracticeMgr.InitItemIdToCard = function()
    if TableIsNull(CollectorPracticeMgr.HomeGrlleryData) then
        CollectorPracticeMgr.InitGalleryData();
    end
    local collectorGalleryData = CollectorPracticeMgr.HomeGrlleryData;
    for index, _value in pairs(collectorGalleryData) do
        local len = #_value.ActivateParam1;
        for i = 1, len, 1 do
            CollectorPracticeMgr.ItemIdToCard[_value.ActivateParam1[i][1]] = _value;
        end
    end
end

CollectorPracticeMgr.GetPassIndex = function()
    if DataMgr.Player.practicesStage.stages == nil then
        return 0;
    end
    local passIndex = 0;
    local tempIndex = 0;
    for index1, value1 in ipairs(DataMgr.Player.practicesStage.stages) do
for index2, value2 in ipairs(value1) do
            tempIndex = tempIndex + 1;
if value2.status == 1 or value2.status == 2 then
passIndex = tempIndex;
            end
        end
    end
    return passIndex;
end

CollectorPracticeMgr.AwakeInitGradeToBuffData = function()
    CollectorPracticeMgr.gradeToBuffData = {};
    CollectorPracticeMgr.buffIdToBuffConfig = {};
    local config = ConfigMgr.Config.InternBuffMap;
    local mapConfig = ConfigMgr.Config.InternLevel2Map;
CollectorPracticeMgr.gradeToBuffData["A000"]={};
CollectorPracticeMgr.gradeToBuffData["A000"][1]={};
CollectorPracticeMgr.gradeToBuffData["A000"][1]["Error"]={};
CollectorPracticeMgr.gradeToBuffData["A000"][2]={};
CollectorPracticeMgr.gradeToBuffData["A000"][2]["Error"]={};
    for key, value in pairs(mapConfig) do
        CollectorPracticeMgr.gradeToBuffData[key]={};
CollectorPracticeMgr.gradeToBuffData[key][-1] = {};
CollectorPracticeMgr.gradeToBuffData[key][-1]["Init"] = {};
CollectorPracticeMgr.gradeToBuffData[key][1] = {};
CollectorPracticeMgr.gradeToBuffData[key][2] = {};

    end
    for index, value in pairs(config) do
        CollectorPracticeMgr.buffIdToBuffConfig[value.Id] = value;
        if value.BuffFirst == 1 then
            table.insert(CollectorPracticeMgr.gradeToBuffData[value.MapId][-1]["Init"], value);
        end
        if value.MapId=="A000" then
            if value.Type == 1 then
                table.insert(CollectorPracticeMgr.gradeToBuffData["A000"][1]["Error"], value);
            else
                table.insert(CollectorPracticeMgr.gradeToBuffData["A000"][2]["Error"], value);
            end
elseif value.Type == 1 then
            for _, dungeonID in pairs(value.DungeonID) do
                if CollectorPracticeMgr.gradeToBuffData[value.MapId][1][dungeonID]==nil then
                    CollectorPracticeMgr.gradeToBuffData[value.MapId][1][dungeonID]={};
                    CollectorPracticeMgr.gradeToBuffData[value.MapId][1][dungeonID]={};
                end
                table.insert(CollectorPracticeMgr.gradeToBuffData[value.MapId][1][dungeonID], value);
            end
elseif value.Type == 2 then
            for _, dungeonID in pairs(value.DungeonID) do
                if CollectorPracticeMgr.gradeToBuffData[value.MapId][2][dungeonID]==nil then
                    CollectorPracticeMgr.gradeToBuffData[value.MapId][2][dungeonID]={};
                end
                table.insert(CollectorPracticeMgr.gradeToBuffData[value.MapId][2][dungeonID], value);
            end
        end
    end
    for key1, value1 in pairs(CollectorPracticeMgr.gradeToBuffData) do
        for key2, value2 in pairs(value1) do
            for key3, value3 in pairs(value2) do
                table.sort(value3, function(a, b)
                    return a.Id < b.Id;
                end)
            end
        end
    end
end

this.CheckDataGroups = function()
    local result = {};
    local tempIndex = 0;
    local startIndex = CollectorPracticeMgr.GetPassIndex();
    table.insert(result, startIndex);

if DataMgr.Player.practicesStage.stages == nil then
        return result;
    end
    for index1, value1 in ipairs(DataMgr.Player.practicesStage.stages) do
for index2, value2 in ipairs(value1) do
            tempIndex = tempIndex + 1;
if index1 == #DataMgr.Player.practicesStage.stages then
                table.insert(result, tempIndex);
if tempIndex == result[1] then
result = {};
                    return result;
                end
            end
        end
    end
    return result;
end


CollectorPracticeMgr.InitGalleryData = function()
CollectorPracticeMgr.HomeGrlleryData = {}
local Achieve = 0
local Totol = 0
    for key, value in pairs(ConfigMgr.Config.RelicsMap) do
        Totol = Totol + 1
        local types = tostring(value.RelicsType)
        local activityType = value.ActivateType
        local checkPlayerAchieve = false
        local times = 0

        checkPlayerAchieve, times = CollectorPracticeMgr.checkGalleryAchieve(value.RelicsId)
        local data = table.Copy(value)
        data["Achieve"] = checkPlayerAchieve
        data["AchieveTimes"] = times
        table.insert(CollectorPracticeMgr.HomeGrlleryData, data)
        if checkPlayerAchieve then
            Achieve = Achieve + 1
        end
    end
    CollectorPracticeMgr.SortTypeTabData(CollectorPracticeMgr.HomeGrlleryData)
end


CollectorPracticeMgr.RefreshGalleryData=function ()
    if TableIsNull(CollectorPracticeMgr.HomeGrlleryData) then
        CollectorPracticeMgr.InitGalleryData();
    end
    for index, value in ipairs(CollectorPracticeMgr.HomeGrlleryData) do
        local checkPlayerAchieve = false
        local times = 0
        checkPlayerAchieve, times = CollectorPracticeMgr.checkGalleryAchieve(value.RelicsId)
        value.Achieve = checkPlayerAchieve
        value.AchieveTimes = times
    end
    CollectorPracticeMgr.SortTypeTabData(CollectorPracticeMgr.HomeGrlleryData);
end


CollectorPracticeMgr.SortTypeTabData = function(targeTab)
    local sortConfig = ConfigMgr.Config.OriginsTalentMap;
    table.sort(targeTab, function(a, b)
        if a.Achieve and b.Achieve then
            if a.OriginsID ~= b.OriginsID then
return sortConfig[a.OriginsID].OtOrder < sortConfig[b.OriginsID].OtOrder
elseif a.AchieveTimes ~= b.AchieveTimes then
                return a.AchieveTimes < b.AchieveTimes;
else
                return a.RelicsId < b.RelicsId;
            end
        elseif a.Achieve and not b.Achieve then
            return a
        elseif not a.Achieve and not b.Achieve then





            if a.OriginsID ~= b.OriginsID then
return sortConfig[a.OriginsID].OtOrder < sortConfig[b.OriginsID].OtOrder
else
                return a.RelicsId < b.RelicsId;
            end

        end
    end)

end


CollectorPracticeMgr.checkGalleryAchieve = function(ids)
    local times
    local achieve = true
    if DataMgr.Player.relics == nil then
        return false, 0
    end
    if DataMgr.Player.relics[ids] ~= nil then
        times = DataMgr.Player.relics[ids].time
        return true, times
    end
    return false, 0
end


CollectorPracticeMgr.getThemeId = function()
    local mapdata = table.Copy(ConfigMgr.Config.PracticePeriodMaps)
    CollectorPracticeMgr.MissionConfigData = {
        { type = "weekly", typeid = "603" }
    }
    local Playdata = DataMgr.Player.practicesStage
    if CollectorPracticeMgr.ThemData == nil then
        CollectorPracticeMgr.ThemData = mapdata["MapA"]
        CollectorPracticeMgr.ThemeCurrent = nil
    end
end




this.GetThemeLevel = function(themeid, tabledata)
    local RessultTable
    local MapData = ConfigMgr.Config.PracticePeriodMaps[themeid]
    if MapData ~= nil then
        local maxLeve = 0



        local FirstCot = tostring(MapData.relicType)


        local childNum = tabledata[FirstCot] ~= nil and tabledata[FirstCot].achieve or 0
        if childNum == 0 then
            if themeid == CollectorPracticeMgr.ThemData.mapType then
                CollectorPracticeMgr.playerLevelData = 1
                CollectorPracticeMgr.CurrentgalleryType = MapData.relicType
            end
            return 1, tabledata[FirstCot], MapData.relicCounts[1]
        end
        local level = 0;
        for index, value in ipairs(MapData.relicCounts) do
            local leveldata = tostring(MapData.relicType)
            local levelnum = value
            if tabledata[leveldata] ~= nil and tabledata[leveldata].achieve >= levelnum and levelnum >= maxLeve then
                maxLeve = levelnum
                RessultTable = { num = value, level = index }
            end
        end
        if themeid == CollectorPracticeMgr.ThemData.mapType then
            CollectorPracticeMgr.CurrentgalleryType = MapData.relicType
            CollectorPracticeMgr.playerLevelData = RessultTable.level
        end
        local TehemmSliderValue = tabledata[FirstCot]
        return RessultTable.level, TehemmSliderValue, RessultTable.num
    else
        return 0, nil, 0
    end
end

CollectorPracticeMgr.Outside = "CollectorOut";
CollectorPracticeMgr.Inroom = "Collectoroom";

this.OnLoadingScene = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.LoadingScene, this.OnLoadingScene);
end

CollectorPracticeMgr.InitShopCountData = function(currenShopID)
    local tans = {}
    local Ids = DataMgr.Player.randShop[currenShopID].goods
    local count = DataMgr.Player.randShop[currenShopID].buycnt
    for index, value in ipairs(Ids) do
        local countIDs = count[index]
        tans[value] = { key = index, datavalue = countIDs }
    end
    ComData.CollectorPracticeShop[currenShopID] = tans
end





























this.ComPleteClosePanelFunCtion = function()
    if this.CompleteEvent ~= nil then
        this.CompleteEvent()
        this.CompleteEvent = nil
    end
end


CollectorPracticeMgr.WalkToCollectorBuildEvent = function(themeId, columnIndex, funs)

    local matchData = { Index = columnIndex }
    ApiMgr.Request("practice/walk", matchData, true, function(result)

        local re = json.decode(result);
        if re.code == 0 then
            this.CompleteEvent = funs
            local selectIds = DataMgr.Player.practicesStage.stages[#DataMgr.Player.practicesStage.stages]
                [columnIndex + 1]
                .stageid
            local type = ConfigMgr.Config.InternEventKV[selectIds].EventType
            if type ~= nil and type == 21 then
                local callBack = function()
                    LuaMgr.RemoveUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
                    LuaMgr.AddUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
                    CollectorPracticeEvent.SetEvent(selectIds, nil)
                    CollectorPracticeEvent.GMEvent = function()
                        LuaMgr.RemoveUIEventListener(UIEventConst.CollectorEventPanelClose,
                            this.ComPleteClosePanelFunCtion);
                        CollectorPracticeMgr.GMCompleteEvent(themeId, CollectorPracticeMgr.GetPassIndex(), funs)
                    end
                end
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStateViewModel, false, true, callBack, nil)
            else

                LuaMgr.RemoveUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
                LuaMgr.AddUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
                CollectorPracticeEvent.SetEvent(selectIds, nil)
                CollectorPracticeEvent.GMEvent = function()
                    LuaMgr.RemoveUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
                    CollectorPracticeMgr.GMCompleteEvent(themeId, CollectorPracticeMgr.GetPassIndex(), funs)
                end
            end
        end
    end, nil, true)
end

CollectorPracticeMgr.ForceAddEventListener = function()
    this.CompleteEvent = CollectorPracticeMainSceneViewModel.succssfulfun;
    LuaMgr.RemoveUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
    LuaMgr.AddUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
end


CollectorPracticeMgr.GMCompleteEvent = function(themeId, stepNum, funs)
    local matchData = { ThemeId = themeId, Index = stepNum }

    ApiMgr.Request("admin/practice/finished_event", matchData, true, function(result)
        local re = json.decode(result);
        if re.code == 0 then
            if funs ~= nil then
                funs()
            end

        end
    end, nil, true)
end


CollectorPracticeMgr.GMCompleteAllEvent = function()
    local CurrentMap = CollectorPracticeMgr.ThemData.mapType
    if DataMgr.Player.practicesStage == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("CollectorPracticeMgr_0"));
        return
    end
    local length = #DataMgr.Player.practicesStage.stages - 1
    local matchData = { ThemeId = CurrentMap, Index = length }

    ApiMgr.Request("admin/practice/finished_allevent", matchData, true, function(result)
        local re = json.decode(result);
        if re.code == 0 then
            CollectorPracticeMgr.InitMainScene=true;
            this.UnloclThemeNetData(DataMgr.Player.practicesStage.MapId,false, true);
        end
    end, nil, true)
end


CollectorPracticeMgr.GMCompleteAllQuest = function()
    local matchData = { QuestId = "" }

    ApiMgr.Request("admin/practice/unlockStoryQuest", matchData, true, function(result)
    end, nil, true)
end




























































CollectorPracticeMgr.InitThemeLock = function()
    local mapData = DataMgr.Player.practicesStage
if mapData.starttime == 0 then
        this.ThemeLock = true
    else
        this.ThemeLock = false
    end
end

CollectorPracticeMgr.StartNewGame = function(smallMapId)
    CollectorPracticeMgr.InitThemeLock();
    local checkCostData = function()
        local tipStr = this.ThemeLock and LuaMgr.GetLangText("CollectorPracticeMgr_3") or
            LuaMgr.GetLangText("CollectorPracticeMgr_4")
        this.RequestData(smallMapId);
    end
    checkCostData()
    LuaMgr.HidePanel(UIName.CollectorPracticeSelectPathViewModel);
end


this.CheckPlayerBackpack = function(itemID)
    local have = false
    local num = 0
    if DataMgr.Player.items[itemID] ~= nil then
        have = true
        num = DataMgr.Player.items[itemID].count0
    else
        have = false
    end
    return have, num
end

this.RequestData = function(mapId)
    CollectorPracticeMgr.AllAward = {};
    CollectorPracticeMgr.InitThemeLock();
    this.UnloclThemeNetData(mapId,this.ThemeLock,false)

end



this.UnloclThemeNetData = function(mapId,lock, jump)
local matchData = { MapId = mapId }

    local Url = lock and "practice/unlock_theme_v2" or "practice/refresh_theme"



    ApiMgr.Request(Url, matchData, true, function(result)

        local re = json.decode(result);
        if re.code == 0 then
            local Playdata = DataMgr.Player.practicesStage

            CollectorPracticeAllMgr.InitCurrentMapData();

            if jump then
            else
                CollectorPracticeMgr.Open2DMap(true)
            end
        end
    end, nil, true)
end


CollectorPracticeMgr.OnBack = function()
    if cortinues ~= nil then
        coroutine_runner.stop(cortinues)
    end

    LuaMgr.RemoveUIEventListener(UIEventConst.CollectorEventPanelClose, this.ComPleteClosePanelFunCtion);
    CollectorPracticeMgr.selectPoint = nil

    CollectorPracticeMgr.stepNum = nil

    CollectorPracticeMgr.MapData = nil





    LuaMgr.NextFrame(function()
        LuaMgr.GoToHome(UIName.CollectorPracticeHomeViewModel, function()

        end);
    end)

end




CollectorPracticeMgr.Open2DMap = function(isPathPanelOpen)
    CollectorPracticeMgr.InitMapData()
    CollectorPracticeMgr.InitMainScene=isPathPanelOpen;
    LuaMgr.ShowLuaPanel(UIName.CollectorPracticeMainSceneViewModel);
end


CollectorPracticeMgr.CheckPosIndex = function()
    CollectorPracticeMgr.selectPoint = CollectorPracticeMgr.GetPassIndex();
end


CollectorPracticeMgr.WalkToOtherPos = function(succsfulfun, columnIndex)
    if not LuaMgr.IsPanelOpen(UIName.CollectorPracticeMainSceneViewModel) then
        return
    end

    this.CompleteEvent = succsfulfun
    CollectorPracticeMgr.WalkToCollectorBuildEvent("MapA", columnIndex, succsfulfun)
end

CollectorPracticeMgr.GetNextGropIdTab = function()

    CollectorPracticeMgr.NextStepTab = this.CheckDataGroups()
end

CollectorPracticeMgr.CheckHaveReward = function(groupIndex)
    if TableIsNull(CollectorPracticeMgr.GuideData) then
        CollectorPracticeMgr.AwakeInitGuideData();
    end
    local result=false;
if CollectorPracticeMgr.GuideData["MapA"][groupIndex]==nil then

for key1, value1 in pairs(CollectorPracticeMgr.GuideData["MapA"]) do
            for key2, value2 in pairs(value1) do
                if DataMgr.Player.practices.guideRewards[value2.ID]==0 then
                    result=true;
                    break;
                end
            end
        end
    else

for key, value in pairs(CollectorPracticeMgr.GuideData["MapA"][groupIndex]) do
            if DataMgr.Player.practices.guideRewards[value.ID]==0 then
                result=true;
                break;
            end
        end
    end
    return result;
end

CollectorPracticeMgr.GetIsUnlockStage = function()
    local practicestage = 0;
    for index1, value1 in ipairs(DataMgr.Player.practicesStage.stages) do
for index2, value2 in ipairs(value1) do
            practicestage = practicestage + 1;
        end
    end

    return practicestage
end


CollectorPracticeMgr.GetPassIdPanelIndex = function()









    return CollectorPracticeMgr.GetPassIndex()
end


CollectorPracticeMgr.keepDecimal = function(num, n)
    if type(num) ~= "number" then
        return num
    end
    n = n or 2
    return tonumber(string.format("%." .. n .. "f", num))
end


CollectorPracticeMgr.CheckNextStep = function(index)
    local targetIndex = index

    local targeGroup = CollectorPracticeMgr.NextStepTab
    local cango = false

    if targetIndex == targeGroup[1] then
        return false, nil
    end
    for _index, value in ipairs(targeGroup) do
        if value == targetIndex then
            cango = true
            break
        end
    end
    if not cango then
        return false, nil
    end
    CollectorPracticeMgr.stepNum = targetIndex
    return true, targeGroup
end


CollectorPracticeMgr.RefushMapData = function()
    CollectorPracticeMgr.InitMapData()
end


CollectorPracticeMgr.InitMapData = function()

    CollectorPracticeMgr.MapData = table.Copy(DataMgr.Player.practicesStage)









end


CollectorPracticeMgr.GetDataLunch = function()
    local IdData = {}
    for index1, value1 in ipairs(DataMgr.Player.practicesStage.stages) do
        for index2, value2 in ipairs(value1) do
            local data = {}
            data.stageid = value2.stageid;
            data.rowIndex = index1 - 1;
            data.columnIndex = index2 - 1;
            table.insert(IdData, data);
        end
    end
    return IdData
end


CollectorPracticeMgr.GetSimulationItems = function()
    local cfgSimulation = {};
    local HaveNum = 0
    local totolNum = 0
    local dataNum = #CollectorPracticeMgr.HomeGrlleryData;

    for i = 1, dataNum, 1 do
        local data = CollectorPracticeMgr.HomeGrlleryData[i]
        if data.RelicsType == CollectorPracticeMgr.CurrentgalleryType then
            if data.Achieve then
                HaveNum = HaveNum + 1
            end
            totolNum = totolNum + 1
            table.insert(cfgSimulation, data)
        end
    end

    return cfgSimulation, HaveNum, totolNum;
end


CollectorPracticeMgr.HaveThisChip = function(itemId)
if CollectorPracticeMgr.ItemIdToCard[itemId] == nil then
        CollectorPracticeMgr.InitItemIdToCard();
    end
    local haveCard = false;
    if DataMgr.Player.relics ~= nil and DataMgr.Player.relics[CollectorPracticeMgr.ItemIdToCard[itemId].RelicsId] ~= nil then
        haveCard = true;
    end
    local haveChip, num = this.CheckPlayerBackpack(itemId)
    return haveCard or haveChip;
end


CollectorPracticeMgr.HaveThisCard = function(itemId)
if CollectorPracticeMgr.ItemIdToCard[itemId] == nil then
        CollectorPracticeMgr.InitItemIdToCard();
    end
    local haveCard = false;
    if DataMgr.Player.relics ~= nil and DataMgr.Player.relics[CollectorPracticeMgr.ItemIdToCard[itemId].RelicsId] ~= nil then
        haveCard = true;
    end
    return haveCard;
end


CollectorPracticeMgr.GetCardInfoByItemId = function(itemId)
if CollectorPracticeMgr.ItemIdToCard[itemId] == nil then
        CollectorPracticeMgr.InitItemIdToCard();
    end
    return CollectorPracticeMgr.ItemIdToCard[itemId];
end


CollectorPracticeMgr.GetChipTypeByItemId = function(itemId)
if CollectorPracticeMgr.ItemIdToCard[itemId] == nil then
        CollectorPracticeMgr.InitItemIdToCard();
    end
    for i = 1, 3, 1 do
        if itemId == CollectorPracticeMgr.ItemIdToCard[itemId].ActivateParam1[i][1] then
            return i;
        end
    end
    return 0;
end