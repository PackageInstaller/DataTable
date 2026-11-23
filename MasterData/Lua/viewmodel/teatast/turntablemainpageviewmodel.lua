
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local goJoinGame = nil;
local goLevelItemContent = nil;
local Right = nil;

local ScrollView = nil;
local ScrollbarVertical = nil;
local rectLevelItemContent = nil;
local btnJoinGame = nil;
local goDebugButtonList=nil;
local dropDownLevelList=nil;
local btnDebugTempUnlockLevel=nil;
local btnDebugTempUnlockMoreLevel=nil;

local speceialList = {};
local dropDownIndexToLevel={};
local this = {
    vm = nil,
}
require("ViewModel/TeaTast/TurnTableItemViewModel")
local nowSelectLevelObj = nil;
local First = true;
local normalLevelList = {};
local normalLevelObjMap = {};
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
if (vm.behaviour.Params ~= nil) then
            this.InitSpecialLevel();
            this.InitNormalLevel();
            this.InitDebug();

            vm.behaviour:UpdateTopBar("", this.OnBack)
            ScrollView.verticalNormalizedPosition = 1
            this.RefreshFirstJoinRed(2);
            HeroRedDataHelper.RefreshMiniGameRed();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.CanCelSelect()
            SetActive(goJoinGame, false);
        end
    end,
    before_destroy = function(vm)
        this.Clear();
        
    end,
}

this.OnBack = function()
    LuaMgr.HidePanel(UIName.TurnTableMainPageViewModel);
    LuaMgr.ShowLuaPanel(UIName.TeaTastSipViewModel)
end

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goJoinGame = uiLink:Get("goJoinGame");
    btnJoinGame = uiLink:Get("goJoinGame"):GetComponent("Button");
    goLevelItemContent = uiLink:Get("goLevelItemContent");
    rectLevelItemContent = uiLink:Get("goLevelItemContent"):GetComponent("RectTransform")
    Right = uiLink:Get("Right");

    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    goDebugButtonList = uiLink:Get("goDebugButtonList");
    dropDownLevelList= uiLink:Get("dropDownLevelList"):GetComponent("Dropdown");
    btnDebugTempUnlockLevel= uiLink:Get("btnDebugTempUnlockLevel"):GetComponent("Button");
    btnDebugTempUnlockMoreLevel= uiLink:Get("btnDebugTempUnlockMoreLevel"):GetComponent("Button");
    uiLink:AddClickEvent("goJoinGame", this.JoinGame);
    uiLink:AddClickEvent("btnDebugTempUnlockLevel", this.DebugTempUnlockLevel);
    uiLink:AddClickEvent("btnDebugTempUnlockMoreLevel", this.DebugTempUnlockMoreLevel);


end

this.RefreshFirstJoinRed=function (type)
    local config=ConfigMgr.Config.constants["GamePoint"]
    for index, value in ipairs(config) do
        if value[1]==tostring(type) and value[2]~="nil" then
PlayerPrefs.SetInt(DataMgr.Player.uid .. "#" .. value[1] .. "#" ..value[2],1);
            break;
        end
    end
end

this.DebugTempUnlockLevel=function ()
    if LuaMgr.IsDebug() then
        local index = dropDownLevelList.value + 1;
        local needCheckLevel=ConfigMgr.Config.GameBoardMap[dropDownIndexToLevel[index]].PreLevel;
        local Url = "board/gmopen"
        local data = {}
        data.AppointBoardId=needCheckLevel;
        ApiMgr.Request(Url, data, true,
            function (result)
                local re = json.decode(result)
                if re.code == 0 then
                    if not IsNull(re.result.Items) then
                        local items = {};
                        local reward = re.result.Items
                        for i, v in pairs(reward) do
                            local item = { ID = v.id, Count = v.count }
                            table.insert(items, item);
                        end

                        LuaMgr.ShowItemGetPanel(items);
                    end
                end
            end,
            nil,
            true
        )
    end
end
this.DebugTempUnlockMoreLevel=function ()
    if LuaMgr.IsDebug() then
        local index = dropDownLevelList.value + 1;
        local nowLevel=dropDownIndexToLevel[index];
        local Url = "board/gmopen"
        local data = {}
        data.BoardId=nowLevel;
        ApiMgr.Request(Url, data, true,
        function (result)
            local re = json.decode(result)
            if re.code == 0 then
                if not IsNull(re.result.Items) then
                    local items = {};
                    local reward = re.result.Items
                    for i, v in pairs(reward) do
                        local item = { ID = v.id, Count = v.count }
                        table.insert(items, item);
                    end

                    LuaMgr.ShowItemGetPanel(items);
                end
            end
        end,
            nil,
            true
        )
    end
end

this.InitDebug=function ()
    SetActive(goDebugButtonList, LuaMgr.IsDebug());
    dropDownLevelList:ClearOptions();
    dropDownLevelList.value=0;
    local levelData = ConfigMgr.Config.GameBoardMap;
    local list={};
    dropDownIndexToLevel={};
    for key, value in pairs(levelData) do
        table.insert(dropDownIndexToLevel,value.Level);
    end
    table.sort(dropDownIndexToLevel);
    for index, value in ipairs(dropDownIndexToLevel) do
        if levelData[value].LevelType==1 then
            table.insert(list,LuaMgr.GetLangText(levelData[value].LevelNameLan).."|"..value);
        else
            table.insert(list,LuaMgr.GetLangText("TurnTableMainPageViewModel_0").."|"..value);
        end
    end
    LuaMgr.AddOptionalOnDropDown(dropDownLevelList, list);
end

this.InitSpecialLevel = function()
    if First then
        local obj = TurnTableItem.New(rectLevelItemContent);
        obj.isSpecial = true;
        obj:SetSpecial(true);
        obj.textLevelName.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7062");
        obj.ClickLevelFun = this.ClickLevel;
        obj:SetFinish(false);
    end
end


this.CanCelSelect = function()
    if nowSelectLevelObj ~= nil then
        nowSelectLevelObj:SetSelectThis(false);
        local dotweenObj=nowSelectLevelObj;
        DOTWeen.To(function() return dotweenObj.transform.anchoredPosition end,
            function(vect) dotweenObj.transform.anchoredPosition = vect end,
            Vector2(dotweenObj.transform.anchoredPosition.x, dotweenObj.gameObject.transform.anchoredPosition.y - 8), 0.2)
        nowSelectLevelObj = nil;
SetActive(goJoinGame, false);
    end
end

this.InitNormalLevel = function()
    local levelData = ConfigMgr.Config.GameBoardMap;
    local levelList = {};
    speceialList = {};
    for key, value in pairs(levelData) do
        if value.LevelType == 1 then
            table.insert(levelList, value);
        else
            table.insert(speceialList, value);
        end
    end
table.sort(levelList, function(a, b)
        local aVal = tonumber(a.Level);
        local bVal = tonumber(b.Level);
        if DataMgr.Player.board.finishMainStageId[a.Level]~=nil and DataMgr.Player.board.finishMainStageId[a.Level] then
            aVal = aVal + 100000;
        end
        if DataMgr.Player.board.finishMainStageId[b.Level]~=nil and DataMgr.Player.board.finishMainStageId[b.Level] then
            bVal = bVal + 100000;
        end
        return aVal < bVal;
    end)
    normalLevelList = levelList;
if First then
        for key, value in ipairs(levelList) do
            local isSpecialGood=false;
            if value.RewardShow~=nil and value.RewardShow>0  then
                isSpecialGood=true;
            end
            local rewardItemId=0;
            if isSpecialGood then
                rewardItemId=value.VicReward[1].id
            end
            local obj = TurnTableItem.New(rectLevelItemContent);
            obj:SetData(
                LuaMgr.GetLangText(value.LevelNameLan),
                this.ClickLevel, 
                false,
                value.Level,
                DataMgr.Player.board.finishMainStageId[value.Level],
                isSpecialGood,
                rewardItemId
            );
            normalLevelObjMap[value.Level] = obj;
        end
        First=false;
else
        for key, value in ipairs(levelList) do
            local isSpecialGood=false;
            if value.RewardShow~=nil and value.RewardShow>0  then
                isSpecialGood=true;
            end
            local rewardItemId=0;
            if isSpecialGood then
                rewardItemId=value.VicReward[1].id
            end
            normalLevelObjMap[value.Level]:SetData(
                LuaMgr.GetLangText(value.LevelNameLan),
                this.ClickLevel,
                false,
                value.Level,
                DataMgr.Player.board.finishMainStageId[value.Level],
                isSpecialGood,
                rewardItemId  
            );
                normalLevelObjMap[value.Level].transform:SetSiblingIndex(key);
        end
    end
end

this.ClickLevel = function(selectLevelObj)

    local canJoin=false;
    local needCheckLevel=nil;
if selectLevelObj.isSpecial then
        canJoin=true;
else
        needCheckLevel=ConfigMgr.Config.GameBoardMap[selectLevelObj.levelId].PreLevel;
if needCheckLevel=="" then
            canJoin=true;
        else
canJoin= DataMgr.Player.board.finishMainStageId[needCheckLevel]~=nil and DataMgr.Player.board.finishMainStageId[needCheckLevel];
        end
    end
    if not canJoin then
        print("needCheckLevel"..needCheckLevel)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
        string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7063"),LuaMgr.GetLangText(ConfigMgr.Config.GameBoardMap[needCheckLevel].LevelNameLan)));
        return;
    end
if selectLevelObj == nowSelectLevelObj then
        this.CanCelSelect();
    else
        this.CanCelSelect();
        nowSelectLevelObj = selectLevelObj;
        nowSelectLevelObj:SetSelectThis(true);
        DOTWeen.To(function() return nowSelectLevelObj.transform.anchoredPosition end,
            function(vect) nowSelectLevelObj.transform.anchoredPosition = vect end,
            Vector2(nowSelectLevelObj.transform.anchoredPosition.x,
            nowSelectLevelObj.gameObject.transform.anchoredPosition.y + 8), 0.2)
SetActive(goJoinGame, true);
    end
end

this.JoinGame = function()
    if nowSelectLevelObj.isSpecial then
        local Url = "board/get_rand_id"
        local data = {}
        ApiMgr.Request(Url, data, true,
            function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    LuaMgr.ShowLuaPanel(UIName.TurnTableViewModel, re.result.RandId);
                end
            end,
            function(failCode)
                print("EnterDungeonError,ErrorCode:", failCode)
            end,
            true
        )
    else
        LuaMgr.ShowLuaPanel(UIName.TurnTableViewModel, nowSelectLevelObj.levelId);
    end
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    goJoinGame = nil;
    goLevelItemContent = nil;
    Right = nil;

    ScrollView = nil;
    ScrollbarVertical = nil;
    rectLevelItemContent = nil;
    First = true;
    goDebugButtonList=nil;
    dropDownLevelList=nil;
    btnDebugTempUnlockLevel=nil;
    btnDebugTempUnlockMoreLevel=nil;
    dropDownIndexToLevel=nil;
end

return vm({
    data = data,
    command = command,
    hook = hook
})