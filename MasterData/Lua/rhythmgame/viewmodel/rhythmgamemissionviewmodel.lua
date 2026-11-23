
require("RhythmGame/ViewModel/RhythmGameMissionItem")

local this = {
    scrollView = nil,
    scrollWidth = 800,
    scrollViewPos = nil,
    rightBgSize = nil,
type = 0,
    totalConfig = nil,
};

local objs = {
    missionBtn = { path = "root/Left/Bg/Mission", type = "Button" },
    missionSelect = { path = "root/Left/Bg/Mission/Select", type = "GameObject" },
    achieveBtn = { path = "root/Left/Bg/Achieve", type = "Button" },
    achieveSelect = { path = "root/Left/Bg/Achieve/Select", type = "GameObject" },
    rightBg = { path = "root/Right/Bg", type = "RectTransform" },
    missionItem = { path = "template/MissionItem", type = "GameObject" },
    scrollViewGO = { path = "root/Right/ScrollView", type = "GameObject" },
    scrollViewTF = { path = "root/Right/ScrollView", type = "RectTransform" },
    oneKeyGetBtn = { path = "root/Right/ScrollView/BtnOneKeyGet", type = "Button" },
};


this.SetData = function()
    this.totalConfig = DataExHelper.Check_ConfigQuestEventByGroupId(233);
    this.SetType(1);
    this.SetList();
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    RhythmGameMissionItem.addWidth = addWidth;
    this.scrollWidth = 800 + addWidth;
    this.rightBg.sizeDelta = Vector2(this.rightBgSize.x + addWidth, this.rightBgSize.y);
    local halfWidth = addWidth / 2;
    this.scrollViewTF.anchoredPosition = Vector2(this.scrollViewPos.x - halfWidth, this.scrollViewPos.y);
end


this.SetList = function()
    local scrollData;
    this.scrollView:Clear(false);
    local scrollDatas = {};
    local questEvents = this.totalConfig

    table.sort(questEvents, function(a, b)
        local state1 = DataExHelper.Check_RewardState(a.id) % 3;
        local state2 = DataExHelper.Check_RewardState(b.id) % 3;
        if (state1 == state2) then
            return a.id < b.id;
        elseif state1 < state2 then
            return false
        else
            return true
        end
    end)
    this.canAchieveIds = {}
    local len = #questEvents;
    for i = 1, len do
        local quest = questEvents[i];
        if (this.type == 1 and quest.text == "missionA") then
            local state = DataExHelper.Check_RewardState(quest.id)
            if(state == 2)then
                table.insert(this.canAchieveIds,quest.id)
            end
            scrollData = UIScrollData.GetData(this.missionItem, "RhythmGameMissionItem", this.scrollWidth, 80, quest);
            table.insert(scrollDatas, scrollData);
        end
        if (this.type == 2 and quest.text == "missionB") then
            local state = DataExHelper.Check_RewardState(quest.id)
            if(state == 2)then
                table.insert(this.canAchieveIds,quest.id)
            end
            scrollData = UIScrollData.GetData(this.missionItem, "RhythmGameMissionItem", this.scrollWidth, 80, quest);
            table.insert(scrollDatas, scrollData);
        end
    end      
    SetActive(this.oneKeyGetBtn.gameObject,#this.canAchieveIds > 1)
    this.scrollView:SetParams(this.scrollWidth, 600);
    this.scrollView:SetData(scrollDatas, true);
    PlayerRhythmGameMgr.CheckTaskRedDot()
    RedMgr.Singleton:Refresh()
end


this.SetType = function(type)
    if (this.type == type) then return end

    this.type = type;
    SetActive(this.missionSelect, type == 1);
    SetActive(this.achieveSelect, type == 2);
    this.SetList();
end


this.OnClickMission = function()
    this.SetType(1);
end


this.OnClickAchieve = function()
    this.SetType(2);
end


this.OnClickOneKeyGet = function()
    DataExHelper.EX_GetAwards(this.canAchieveIds, function(_result)          
        this.SetList()
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.rightBgSize = this.rightBg.sizeDelta;
        this.scrollViewPos = this.scrollViewTF.anchoredPosition;
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameMissionViewModel)
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.achieveBtn, this.OnClickAchieve);
        LuaMgr.AddClick(this.oneKeyGetBtn, this.OnClickOneKeyGet);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameQuestReceive, this.SetList);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.ViewAdaptive();
        this.SetData();        
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
        this.type = 0;
    end,
    before_destroy = function(vm)
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameMissionViewModel)
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission);
        LuaMgr.RemoveClick(this.achieveBtn, this.OnClickAchieve);
        LuaMgr.RemoveClick(this.oneKeyGetBtn, this.OnClickOneKeyGet);
        UIScrollView.ClearItem("RhythmGameMissionItem");
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameQuestReceive, this.SetList);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})