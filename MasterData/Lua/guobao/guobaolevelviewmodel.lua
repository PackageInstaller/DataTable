require("GuoBao/GuoBaoLevelItem")

local this = {
    scrollView = nil,
    scrollWidth = 0,
    screenWidth = 0,
    eventList = nil,
};

local objs = {

    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    bxczBtn = { path = "root/Middle/BXCZ", type = "Button" },
    bxczNormal = { path = "root/Middle/BXCZ/Normal", type = "GameObject" },
    bxczSelect = { path = "root/Middle/BXCZ/Select", type = "GameObject" },
    zcyxBtn = { path = "root/Middle/ZCYX", type = "Button" },
    zcyxNormal = { path = "root/Middle/ZCYX/Normal", type = "GameObject" },
    zcyxSelect = { path = "root/Middle/ZCYX/Select", type = "GameObject" },
};


this.SetData = function()
    local eventType = PlayerGuoBaoMgr.GetLevelType();
    if (eventType == nil) then
        eventType = GuoBaoActivity.Main;
        PlayerGuoBaoMgr.SetLevelType(eventType);
    end
    if (eventType == GuoBaoActivity.Main) then
        SetActive(this.bxczNormal, false);
        SetActive(this.bxczSelect, true);
        SetActive(this.zcyxNormal, true);
        SetActive(this.zcyxSelect, false);
    elseif (eventType == GuoBaoActivity.Battle) then
        SetActive(this.bxczNormal, true);
        SetActive(this.bxczSelect, false);
        SetActive(this.zcyxNormal, false);
        SetActive(this.zcyxSelect, true);
    end
    this.eventList = DataExHelper.EX_GetEventListByArea(eventType);
    ConfigGuoBaoMgr.InitActivityMapEvent(this.eventList);
    this.SetLevelList(eventType);
end


this.SetLevelList = function(eventType)
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.eventList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItem, "GuoBaoLevelItem", 333, 270, {config=this.eventList[i], num=i});
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(this.scrollWidth, 520);
    this.scrollView:SetPadding(43, 0, 0, 0);
    local index = 1;
    if (eventType == GuoBaoActivity.Main) then
        index = PlayerGuoBaoMgr.GetLevelMainIndex();    
    elseif (eventType == GuoBaoActivity.Battle) then
        index = PlayerGuoBaoMgr.GetLevelBattleIndex();
    end
    this.scrollView:SetData(scrollDatas, true, index);
end


this.OnClickBXCZ = function()
    PlayerGuoBaoMgr.SetLevelType(GuoBaoActivity.Main);
    this.SetData();
end


this.OnClickZCYX = function()
    PlayerGuoBaoMgr.SetLevelType(GuoBaoActivity.Battle);
    this.SetData();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.bxczBtn, this.OnClickBXCZ);
        LuaMgr.AddClick(this.zcyxBtn, this.OnClickZCYX);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.bxczBtn, this.OnClickBXCZ);
        LuaMgr.RemoveClick(this.zcyxBtn, this.OnClickZCYX);
        UIScrollView.ClearItem("GuoBaoLevelItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})