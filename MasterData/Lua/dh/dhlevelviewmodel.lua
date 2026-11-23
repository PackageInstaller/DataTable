require("DH/DHLevelItem")
require("DH/DHConst")

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

    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollView = { path = "root/Middle/ScrollView", type = "GameObject" },
    scrollViewContent = { path = "root/Middle/ScrollView/Viewport/Content", type = "RectTransform" },
    tapBtn1 = { path = "root/Middle/Image/tapBtn1", type = "Button" },
    tapBtn2 = { path = "root/Middle/Image/tapBtn2", type = "Button" },
    tapBtn3 = { path = "root/Middle/Image/tapBtn3", type = "Button" },
    imgSelected = { path = "root/Middle/Image/ImgSelected", type = "GameObject" },
    fxGlow = { path = "root/Middle/Image/ImgSelected/fx_glow", type = "GameObject" },
};

this.SetData = function()
    local levelType = PlayerDHMgr.GetLevelType();
    SetActive(this.fxGlow, false)
    if (this.levelType == levelType) then
        return
    end
    SetActive(this.fxGlow, true)
    this.levelType = levelType;
    if (levelType == 1) then
        this.imgSelected.transform.localPosition = Vector3(-168, 24, 0);
        this.eventList = DataExHelper.EX_GetEventListByArea(DHLevelType.Repeat);
        this.SetLevelList();
    elseif (levelType == 2) then
        this.imgSelected.transform.localPosition = Vector3(0, 24, 0);
        this.eventList = DataExHelper.EX_GetEventListByArea(DHLevelType.Main);
        this.SetLevelList();
    else
        this.imgSelected.transform.localPosition = Vector3(168, 24, 0);
        this.eventList = DataExHelper.EX_GetEventListByArea(DHLevelType.Difficult);
        this.SetBigLevelList();
    end
end


this.SetLevelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};

    local newIndex = 0
    for i, v in ipairs(this.eventList) do
        local eventData = nil
        if (this.levelType == 1) then
            eventData = PlayerDHMgr.GetActivityMapEvent(DHLevelType.Repeat, v.id);
        elseif (this.levelType == 2) then
            eventData = PlayerDHMgr.GetActivityMapEvent(DHLevelType.Main, v.id);
        end
        if (eventData ~= nil and not eventData.complete and newIndex == 0) then
            newIndex = i
        end
        scrollData = UIScrollData.GetData(this.levelItem, "DHLevelItem", 323, 424,
            { config = v, num = i, playAni = true });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(this.scrollWidth, 424);
    this.levelSV:SetPadding(20, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
    newIndex = newIndex > 0 and newIndex or 1
    this.levelSV:MoveToIndex(newIndex);
    this.contentWidth = this.scrollViewContent.sizeDelta.x;
end


this.SetBigLevelList = function()

    this.scrollWidth = 1182;
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    for i, v in ipairs(this.eventList) do
        scrollData = UIScrollData.GetData(this.levelItem, "DHLevelItem", 394, 450,
            { config = v, num = i, playAni = true });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(this.scrollWidth, 450);
    this.levelSV:SetPadding(70, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
    this.contentWidth = this.scrollViewContent.sizeDelta.x;
end

this.OnClickTapBtn1 = function()
    PlayerDHMgr.SetLevelType(1);
    this.SetData();
end

this.OnClickTapBtn2 = function()
    PlayerDHMgr.SetLevelType(2);
    this.SetData();
end

this.OnClickTapBtn3 = function()
    PlayerDHMgr.SetLevelType(3);
    this.SetData();
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
end

this.OnBack = function()
    PlayerDHMgr.SetLevelType(0);
    LuaMgr.Back();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.tapBtn1, this.OnClickTapBtn1);
        LuaMgr.AddClick(this.tapBtn2, this.OnClickTapBtn2);
        LuaMgr.AddClick(this.tapBtn3, this.OnClickTapBtn3);
        this.levelSV = UIScrollView.New(this.scrollView);
        RedMgr.Singleton:RegisterViewModel(UIName.DHLevelViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.levelType = nil      
        vm.behaviour:UpdateTopBar("", this.OnBack);
        if (RedMgr.Singleton:CheckRedCondition("16055")) then       
            RedMgr.Singleton:FrushRedCondition("16055")
        end

        this.SetData();

    end,
    before_deactive = function(vm)

        this.levelSV:Clear(true);
        this.levelType = nil
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.tapBtn1, this.OnClickTapBtn1);
        LuaMgr.RemoveClick(this.tapBtn2, this.OnClickTapBtn2);
        LuaMgr.RemoveClick(this.tapBtn3, this.OnClickTapBtn3);
        UIScrollView.ClearItem("DHLevelItem");
        RedMgr.Singleton:RemoveViewModel(UIName.DHLevelViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})