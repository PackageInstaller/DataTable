require("Qin/QinConst")
require("Qin/QinStoryLevelItem")

local this = {
    levelSV = nil,
    scrollWidth = 0,
    mapPath = "",
    mapItemGO = nil,
    mapItemTF = nil,
    bgWidth = 0,
    bgPos = Vector2.zero,
    contentWidth = 0,
    contentPosX = 0,
    screenWidth = 0,
    eventList = nil,
};

local objs = {

    mapTF = { path = "root/Map", type = "RectTransform" },
    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollView = { path = "root/Middle/ScrollView", type = "GameObject" },
    scrollViewContent = { path = "root/Middle/ScrollView/Viewport/Content", type = "RectTransform" },
    fastBattleGO = { path = "root/Left/FastBattle", type = "GameObject" },
    fastBattleBtn = { path = "root/Left/FastBattle", type = "Button" },
    fastBattleSelect = { path = "root/Left/FastBattle/Select", type = "GameObject" },
    battle1GO = { path = "root/Left/Battle1", type = "GameObject" },
    battle1Btn = { path = "root/Left/Battle1", type = "Button" },
    battle1Select = { path = "root/Left/Battle1/Select", type = "GameObject" },
    battle1Count = { path = "root/Left/Battle1/Count", type = "Text" },
    battle1New = { path = "root/Left/Battle1/New", type = "GameObject" },
    battle2GO = { path = "root/Left/Battle2", type = "GameObject" },
    battle2Btn = { path = "root/Left/Battle2", type = "Button" },
    battle2Select = { path = "root/Left/Battle2/Select", type = "GameObject" },
    battle2Count = { path = "root/Left/Battle2/Count", type = "Text" },
    battle2New = { path = "root/Left/Battle2/New", type = "GameObject" },
    drawGO = { path = "root/Right/Draw", type = "GameObject" },
    drawBtn = { path = "root/Right/Draw", type = "Button" },
};


this.SetData = function()
    local levelType = PlayerQinMgr.GetLevelType();
    if (levelType == 1) then
        this.eventList = DataExHelper.EX_GetEventListByArea("daqinMap");
        SetActive(this.fastBattleGO, false);
        SetActive(this.battle1GO, false);
        SetActive(this.battle2GO, false);
        SetActive(this.drawGO, false);
    elseif (levelType == 2) then
        this.eventList = DataExHelper.EX_GetEventListByArea("daqinMap_normal");
        this.SetCompleteCount();
        this.SetFastBattle();
        SetActive(this.fastBattleGO, true);
        SetActive(this.battle1GO, true);
        SetActive(this.battle2GO, true);
        SetActive(this.drawGO, true);
        SetActive(this.battle1Select, true);
        SetActive(this.battle2Select, false);
    elseif (levelType == 3) then
        this.eventList = DataExHelper.EX_GetEventListByArea("daqinMap_hard");
        this.SetCompleteCount();
        SetActive(this.fastBattleGO, false);
        SetActive(this.battle1GO, true);
        SetActive(this.battle2GO, true);
        SetActive(this.drawGO, true);
        SetActive(this.battle1Select, false);
        SetActive(this.battle2Select, true);
    end
    ConfigQinMgr.InitActivityMapEvent(this.eventList);
    this.SetMap();
    this.SetLevelList();
end


this.SetMap = function()
    local levelType = PlayerQinMgr.GetLevelType();
    local mapPath = string.format("Assets/_BundleResources/UI/Qin/QINMAP%d.prefab", levelType);
    if (this.mapPath == mapPath) then return end
    
    this.ClearMap();
    this.mapPath = mapPath;
    this.mapItemGO = LuaMgr.GetPrefab(this.mapPath);
    this.mapItemTF = this.mapItemGO:GetComponent("RectTransform");
    LuaMgr.AddPrefabRefCount(this.mapPath);
    this.mapItemTF:SetParent(this.mapTF, false);
    this.screenWidth = LuaMgr.ScreenWidth();
    local scale = #this.eventList * 0.1;
    scale = scale > 1 and 1 or scale;
    local mapWidth = this.mapItemTF.sizeDelta.x;
    this.bgWidth = mapWidth * scale;
    if (this.bgWidth < this.screenWidth) then
        this.bgWidth = this.screenWidth;
    end
    this.contentPosX = 0;
end


this.ClearMap = function()
    if (this.mapPath == "") then return end
    
    LuaMgr.RemovePrefabRefCount(this.mapPath);
    this.mapPath = "";
    LuaMgr.DestroyImmediateGO(this.mapItemGO);
    this.mapItemGO = nil;
    this.mapItemTF = nil;
end


this.SetLevelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local levelType = PlayerQinMgr.GetLevelType();
    local len = #this.eventList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItem, "QinStoryLevelItem", 250, 400, {type=levelType, config=this.eventList[i], num=i});
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(this.scrollWidth, 400);
    this.levelSV:SetPadding(100, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
    this.contentWidth = this.scrollViewContent.sizeDelta.x;
end


this.OnUpdate = function()
    local px = math.floor(this.scrollViewContent.anchoredPosition.x);
    if (px == this.contentPosX) then return end

    this.contentPosX = px;
    if (px >= 0) then
        this.bgPos.x = 0;
    else
        local rate = px / (this.contentWidth - this.scrollWidth);
        local width = this.bgWidth - this.screenWidth;
        local bx = math.floor(width * rate);
        if (bx <= -width) then
            bx = -width;
        end
        this.bgPos.x = bx;
    end
    this.mapItemTF.anchoredPosition = this.bgPos;
end


this.SetCompleteCount = function()
    local eventList = DataExHelper.EX_GetEventListByArea("daqinMap_normal");
    local count, isNew = this.GetEventCompleteCount("daqinMap_normal", eventList);
    this.battle1Count.text = string.format("%d<color=#a1906a>/%d</color>", count, #eventList);
    SetActive(this.battle1New, isNew);
    
    eventList = DataExHelper.EX_GetEventListByArea("daqinMap_hard");
    count, isNew = this.GetEventCompleteCount("daqinMap_hard", eventList);
    this.battle2Count.text = string.format("%d<color=#a1906a>/%d</color>", count, #eventList);
    SetActive(this.battle2New, isNew);
end


this.GetEventCompleteCount = function(type, eventList)
    local eventData;
    local count = 0;
    local isNew = false;
    local len = #eventList;
    for i = 1, len do
        eventData = PlayerQinMgr.GetActivityMapEvent(type, eventList[i].id);       
        if (eventData ~= nil) then
            if (eventData.complete) then
                count = count + 1;           
            end
        end
        if(PlayerSlgMgr.CheckChapterNewDotDataById(type, eventList[i].id))then
            isNew = true
        end        
    end
    return count, isNew;
end


this.SetFastBattle = function()
    local isFastBattle = PlayerQinMgr.IsFastBattle();
    SetActive(this.fastBattleSelect, isFastBattle);
end


this.OnClickFastBattle = function()
    local isFastBattle = PlayerQinMgr.IsFastBattle();
    PlayerQinMgr.SetFastBattle(not isFastBattle);
    this.SetFastBattle();
end


this.OnClickBattle1 = function()
    PlayerQinMgr.SetLevelType(2);
    this.SetData();
end


this.OnClickBattle2 = function()
    PlayerQinMgr.SetLevelType(3);
    this.SetData();
end


this.OnClickDraw = function()  
    LuaMgr.ShowLuaPanel(UIName.QinDrawViewModel);
end

this.OnBack = function()
    PlayerQinMgr.SetLevelType(0);
    
    LuaMgr.Back();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.levelSV = UIScrollView.New(this.scrollView);
        LuaMgr.AddClick(this.fastBattleBtn, this.OnClickFastBattle);
        LuaMgr.AddClick(this.battle1Btn, this.OnClickBattle1);
        LuaMgr.AddClick(this.battle2Btn, this.OnClickBattle2);
        LuaMgr.AddClick(this.drawBtn, this.OnClickDraw);
        RedMgr.Singleton:RegisterViewModel(UIName.QinLevelStoryViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
            PlayerSlgMgr.CheckChapterEntranceNewDot()
            RedMgr.Singleton:Refresh()
            vm.behaviour:UpdateTopBar("1", this.OnBack);

        local lvType = PlayerQinMgr.GetLevelType()
        if (not vm.behaviour.IsPop and lvType <= 0) then
            PlayerQinMgr.SetLevelType(vm.behaviour.Params[0]);
        end
        this.SetData();      
        LuaMgr.AddUpdate(this.OnUpdate);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate);
        this.levelSV:Clear(true);
        PlayerQinMgr.ClearPlayQinLevelItemAnimationId()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.fastBattleBtn, this.OnClickFastBattle);
        LuaMgr.RemoveClick(this.battle1Btn, this.OnClickBattle1);
        LuaMgr.RemoveClick(this.battle2Btn, this.OnClickBattle2);
        LuaMgr.RemoveClick(this.drawBtn, this.OnClickDraw);
        UIScrollView.ClearItem("QinStoryLevelItem");
        RedMgr.Singleton:RemoveViewModel(UIName.QinLevelStoryViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})