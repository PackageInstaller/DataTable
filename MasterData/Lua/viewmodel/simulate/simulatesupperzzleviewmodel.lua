require("ViewModel/Simulate/SimulateSupperzzleItem")
require("ViewModel/Simulate/SimulateSupperzzleLevelItem")

local this = {
    levelSV = nil,
    supperzzleList = nil,
    rewardItem = nil,
    characterId = "S0174",
    characterSkin = "S0174001",
    eventList = nil,
    eventData = nil,
    itemList = nil,
    selectItem = nil,
    selectLevel = nil,
    startTime = 0,
    endTime = 0,
    errorCount = 0,
    errorMaxCount = 0,
};

local objs = {
    closeBtn = { path = "root/Middle/Supperzzle/Close", type = "Button" },
    levelItem = { path = "template/LevelItem", type = "GameObject" },
    levelGO = { path = "root/Middle/Supperzzle/Level", type = "GameObject" },
    levelSVGO = { path = "root/Middle/Supperzzle/Level/ScrollView", type = "GameObject" },
    supperzzleItem = { path = "template/SupperzzleItem", type = "GameObject" },
    supperzzleGrids = { path = "root/Middle/Supperzzle/Maps/Grids", type = "Transform" },
    mapsTitle = { path = "root/Middle/Supperzzle/Maps/Title", type = "Text" },
    mapsLock = { path = "root/Middle/Supperzzle/Maps/Lock", type = "GameObject" },
    startGameGO = { path = "root/Middle/Supperzzle/Maps/StartGame", type = "GameObject" },
    startGameBtn = { path = "root/Middle/Supperzzle/Maps/StartGame", type = "Button" },
    rewardGO = { path = "root/Middle/Supperzzle/Reward", type = "GameObject" },
    rewardLight = { path = "root/Middle/Supperzzle/Reward/Light", type = "GameObject" },
    rewardReceived = { path = "root/Middle/Supperzzle/Reward/Received", type = "GameObject" },
    rewardItemTF = { path = "root/Middle/Supperzzle/Reward/Item", type = "Transform" },
    rewardErrorCount = { path = "root/Middle/Supperzzle/Reward/ErrorCount", type = "Text" },
    timeGO = { path = "root/Middle/Supperzzle/Time", type = "GameObject" },
    timeNum = { path = "root/Middle/Supperzzle/Time/Num", type = "Text" },
    spineCharacter = { path = "root/Middle/Supperzzle/Character", type = "UISpineCharacter" },
    resultGO = { path = "root/Middle/Supperzzle/Result", type = "GameObject" },
    resultWinGO = { path = "root/Middle/Supperzzle/Result/Win", type = "GameObject" },
    resultLoseGO = { path = "root/Middle/Supperzzle/Result/Lose", type = "GameObject" },
};


this.SetData = function()
    SetActive(this.resultGO, false);
    this.SetGameStatus(false);
    this.eventList = SimulateRoomMgr.GetEventList(3);
    this.FindEvent();
    this.SetLevels();
    this.SetItems();
    this.SetCharacter();
end


this.FindEvent = function()
    local event;
    this.eventData = this.eventList[1];
    local time = LuaMgr.Timestamp();
    local len = #this.eventList;
    for i = 1, len do
        event = this.eventList[i];
        if (time > event.StartTime and not SimulateRoomMgr.CheckFinishEvent(event.Id)) then
            this.eventData = event;
            break;
        end
    end
end


this.SetLevels = function()
    this.levelSV:Clear(false);
    local event;
    local pos = 0;
    local levelData;
    local scrollData;
    local scrollDatas = {};
    local len = #this.eventList;
    for i = 1, len do
        event = this.eventList[i];
        levelData = {id=i,config=event,select=false};
        if (event == this.eventData) then
            pos = i;
            levelData.select = true;
            this.selectLevel = levelData;
        end
        scrollData = UIScrollData.GetData(this.levelItem, "SimulateSupperzzleLevelItem", 86, 76, levelData);
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(320, 90);
    this.levelSV:SetData(scrollDatas, true, pos > 0 and pos or nil);
    SetActive(this.levelGO, true);
end


this.GenItems = function()
    local itemId;
    this.itemList = {};
    for i = 1, 6 do
        itemId = this.eventData.GameParameters[i];
        table.insert(this.itemList, {id=itemId, status=false});
        table.insert(this.itemList, {id=itemId, status=false});
    end
    this.ShuffleItems();
end


this.ShuffleItems = function()
    local index;
    local item;
    local len = #this.itemList;
    for i = 1, 50 do
        index = math.random(1, len);
        item = this.itemList[index];
        this.itemList[index] = this.itemList[1];
        this.itemList[1] = item;
    end
end


this.SetItems = function()
    this.supperzzleList:Clear();
    this.GenItems();
    local listDatas = {};
    local len = #this.itemList;
    for i = 1, len do
        local listData = UIListData.GetData(this.supperzzleItem, "SimulateSupperzzleItem", this.itemList[i]);
        table.insert(listDatas, listData);
    end
    this.supperzzleList:SetData(listDatas);
    local time = this.eventData.StartTime - LuaMgr.Timestamp();
    if (time <= 0) then
        this.mapsTitle.text = LuaMgr.GetLangText("GuoBaoSupperzzleViewModel_0");
        SetActive(this.mapsLock, false);
    else
        local d,h,m = GetTimeDHM(time);
        local timeStr = "";
        if (not IsNullOrEmpty(d)) then
            timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
        end
        if (not IsNullOrEmpty(h)) then
            timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
        end
        if (not IsNullOrEmpty(m)) then
            timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
        end
        this.mapsTitle.text = timeStr .. LuaMgr.GetLangText("GuoBaoSupperzzleViewModel_1");
        SetActive(this.mapsLock, true);
    end
    this.errorCount = 0;
    local count = this.eventData.GameParameters[8];
    this.errorMaxCount = tonumber(count);
    this.SetReward();
    this.SetErrorCount();
end


this.SetReward = function()
    if (this.rewardItem == nil) then
        this.rewardItem = GoodsDataItem.New(this.rewardItemTF);
    end
    local showItem = this.eventData.Reward[1];
    local itemConfig = ConfigMgr.Config.itemMap[showItem.id];
    if (itemConfig ~= nil) then
        local itemData = table.Copy(itemConfig);
        itemData.count0 = showItem.count;
        this.rewardItem:SetData(1, itemData, 1, false, Vector3(0.7,0.7,1), false);
        if (SimulateRoomMgr.CheckFinishEvent(this.eventData.Id)) then
            SetActive(this.rewardLight, false);
            SetActive(this.rewardReceived, true);
        else
            SetActive(this.rewardLight, true);
            SetActive(this.rewardReceived, false);
        end
    end
end


this.SetErrorCount = function()
    local errorCount = this.eventData.GameParameters[8];
    if (errorCount == "0") then
        this.rewardErrorCount.text = "";
        return;
    end
    this.rewardErrorCount.text = string.format(LuaMgr.GetLangText("GuoBaoSupperzzleViewModel_2"), this.errorCount, this.errorMaxCount);
end


this.SetCharacter = function()
    local characterConfig = ConfigMgr.Config.characterTable[this.characterId];
    if (characterConfig == nil) then return end

    this.spineCharacter:SetBattle(this.characterId, this.characterSkin, "", characterConfig.job);
end


this.OnSupperzzleSelect = function(args)
    if (this.startTime <= 0) then return end
    
    local item = args[0];
    if (item.data.status) then return end

    if (this.selectItem == nil) then
        this.selectItem = item;
        this.selectItem:Show(true);
        return;
    end
    if (this.selectItem == item) then return end

    if (this.selectItem.data.id == item.data.id) then
        item:Show(true);
        if (this.IsWin()) then
            LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleTime);
            LuaMgr.AddTimer(TimerConst.GuoBaoSupperzzleResult, this.GameOver, 0.5, 1, false);
        end
    else
        this.selectItem:Hide(0.5);
        item:Show(false);
        this.errorCount = this.errorCount + 1;
        this.SetErrorCount();
        if (this.errorMaxCount > 0 and this.errorCount > this.errorMaxCount) then
            LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleTime);
            LuaMgr.AddTimer(TimerConst.GuoBaoSupperzzleResult, this.GameOver, 0.5, 1, false);
        end
    end
    this.selectItem = nil;
end


this.OnClickClose = function()
    LuaMgr.NextFrame(function() LuaMgr.HidePanel(UIName.SimulateSupperzzleViewModel) end);
end


this.OnClickStartGame = function()
    if (LuaMgr.Timestamp() < this.eventData.StartTime) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("GuoBaoSupperzzleViewModel_3"));
        return;
    end
    this.SetItems();
    SetActive(this.resultGO, false);
    this.SetGameStatus(true);
    this.startTime = os.time();
    this.endTime = this.startTime + tonumber(this.eventData.GameParameters[7]);
    this.timeNum.text = this.eventData[7];
    LuaMgr.AddTimer(TimerConst.GuoBaoSupperzzleTime, this.OnSupperzzleTime, 1, -1, true);
end


this.SetGameStatus = function(status)
    if (status) then
        SetActive(this.levelGO, false);
        SetActive(this.rewardGO, true);
        SetActive(this.timeGO, true);
        SetActive(this.startGameGO, false);
    else
        SetActive(this.levelGO, true);
        SetActive(this.rewardGO, false);
        SetActive(this.timeGO, false);
        SetActive(this.startGameGO, true);
        this.startTime = 0;
    end
end


this.IsWin = function()
    local item;
    local len = #this.itemList;
    for i = 1, len do
        item = this.itemList[i];
        if (not item.status) then
            return false;
        end
    end
    return true;
end


this.GameOver = function()
    LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleResult);
    this.startTime = 0;
    local isWin = this.IsWin();
    if (isWin) then
        SetActive(this.resultWinGO, true);
        SetActive(this.resultLoseGO, false);
        SetActive(this.resultGO, true);
        if (not SimulateRoomMgr.CheckFinishEvent(this.eventData.Id)) then
            SimulateRoomMgr.OnAskFinishEvent(this.eventData.Id, this.FinishEventResponse);
        else
            this.SetGameStatus(false);
        end
    else
        SetActive(this.resultWinGO, false);
        SetActive(this.resultLoseGO, true);
        SetActive(this.resultGO, true);
        LuaMgr.AddTimer(TimerConst.GuoBaoSupperzzleResultError, this.OnResultError, 3, 1, false);
    end
end


this.OnResultError = function()
    LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleResultError);
    this.SetGameStatus(false);
    SetActive(this.resultGO, false);
    this.SetItems();
end


this.FinishEventResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result);
        LuaMgr.ShowItemRewared(reward);
    end
    this.SetGameStatus(false);
    this.levelSV:Refresh();
    this.SetReward();
end


this.OnSupperzzleTime = function()
    if (this.eventData == nil) then return end
    
    local time = os.time();
    if (time >= this.endTime) then
        this.timeNum.text = "0";
        LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleTime);
        LuaMgr.AddTimer(TimerConst.GuoBaoSupperzzleResult, this.GameOver, 0.5, 1, false);
        return;
    end
    local num = math.floor(this.endTime - time);
    this.timeNum.text = tostring(num);
end


this.OnSupperzzleLevel = function(args)
    if (this.selectLevel ~= nil) then
        this.selectLevel.select = false;
        this.selectLevel = nil;
    end
    this.selectLevel = args[0];
    this.selectLevel.select = true;
    this.levelSV:Refresh();
    this.eventData = this.eventList[this.selectLevel.id];
    SetActive(this.resultGO, false);
    this.SetGameStatus(false);
    this.SetItems();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.levelSV = UIScrollView.New(this.levelSVGO);
        this.supperzzleList = UIListView.New(this.supperzzleGrids);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.startGameBtn, this.OnClickStartGame);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.GuoBaoSupperzzleSelect, this.OnSupperzzleSelect);
        LuaMgr.AddUIEventListener(UIEventConst.GuoBaoSupperzzleLevel, this.OnSupperzzleLevel);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleTime);
        LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleResult);
        LuaMgr.RemoveTimer(TimerConst.GuoBaoSupperzzleResultError);
        LuaMgr.RemoveUIEventListener(UIEventConst.GuoBaoSupperzzleSelect, this.OnSupperzzleSelect);
        LuaMgr.RemoveUIEventListener(UIEventConst.GuoBaoSupperzzleLevel, this.OnSupperzzleLevel);
        this.eventData = nil;
        this.selectItem = nil;
        this.selectLevel = nil;
        this.levelSV:Clear(true);
        this.supperzzleList:Clear();
        this.spineCharacter:Clear();
        if (this.rewardItem ~= nil) then
            this.rewardItem:Clear();
            this.rewardItem = nil;
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickStartGame);
        UIScrollView.ClearItem("SimulateSupperzzleLevelItem");
        UIListView.ClearItem("SimulateSupperzzleItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})