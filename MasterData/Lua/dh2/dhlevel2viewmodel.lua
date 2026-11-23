require("DH2/DHLevel2Item")
require("DH2/DH2Const")

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
    tapBtn1Text = { path = "root/Middle/Image/tapBtn1/Text", type = "Text" },
    tapBtn2 = { path = "root/Middle/Image/tapBtn2", type = "Button" },
    tapBtn2Text = { path = "root/Middle/Image/tapBtn2/Text", type = "Text" },
    tapBtn3 = { path = "root/Middle/Image/tapBtn3", type = "Button" },
    tapBtn3Text = { path = "root/Middle/Image/tapBtn3/Text", type = "Text" },
    imgSelected = { path = "root/Middle/Image/ImgSelected", type = "GameObject" },
    imgSelectedText = { path = "root/Middle/Image/ImgSelected/Text", type = "Text" },
    fxGlow = { path = "root/Middle/Image/ImgSelected/fx_glow", type = "GameObject" },
};

this.SetData = function()
    local levelType = PlayerDH2Mgr.GetLevelType();

    if (this.levelType == levelType) then
        return
    end

    this.levelType = levelType;
    if (levelType == 1) then
        this.imgSelected.transform.localPosition = Vector3(-180, 5.5, 0);
        this.imgSelectedText.text = this.tapBtn1Text.text
        this.eventList = DataExHelper.EX_GetEventListByArea(DH2LevelType.Repeat);
        this.SetLevelList();
    elseif (levelType == 2) then
        this.imgSelected.transform.localPosition = Vector3(0, 5.5, 0);
        this.imgSelectedText.text = this.tapBtn2Text.text
        this.eventList = DataExHelper.EX_GetEventListByArea(DH2LevelType.Main);
        this.SetLevelList();
    else
        this.imgSelected.transform.localPosition = Vector3(180, 5.5, 0);
        this.imgSelectedText.text = this.tapBtn3Text.text
        this.eventList = DataExHelper.EX_GetEventListByArea(DH2LevelType.Difficult);
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
            eventData = PlayerDH2Mgr.GetActivityMapEvent(DH2LevelType.Repeat, v.id);
        elseif (this.levelType == 2) then
            eventData = PlayerDH2Mgr.GetActivityMapEvent(DH2LevelType.Main, v.id);
        end
        if (eventData ~= nil and not eventData.complete and newIndex == 0) then
            newIndex = i
        end
        scrollData = UIScrollData.GetData(this.levelItem, "DHLevel2Item", 280, 424,
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
        scrollData = UIScrollData.GetData(this.levelItem, "DHLevel2Item", 394, 450,
            { config = v, num = i, playAni = true });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(this.scrollWidth, 450);
    this.levelSV:SetPadding(70, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
    this.contentWidth = this.scrollViewContent.sizeDelta.x;
end

this.OnClickTapBtn1 = function()
    PlayerDH2Mgr.SetLevelType(1);
    this.SetData();
end

this.OnClickTapBtn2 = function()
    PlayerDH2Mgr.SetLevelType(2);
    this.SetData();
end

this.OnClickTapBtn3 = function()
    PlayerDH2Mgr.SetLevelType(3);
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
    PlayerDH2Mgr.SetLevelType(0);
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
        RedMgr.Singleton:RegisterViewModel(UIName.DHLevel2ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if (vm.behaviour.Params.Length > 0) then
            local panelType = vm.behaviour.Params[0]
            PlayerDH2Mgr.SetLevelType(tonumber(panelType));
        end
        this.levelType = nil
        vm.behaviour:UpdateTopBar("", this.OnBack);
        if (RedMgr.Singleton:CheckRedCondition("16132")) then
            RedMgr.Singleton:FrushRedCondition("16132")
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
        UIScrollView.ClearItem("DHLevel2Item");
        RedMgr.Singleton:RemoveViewModel(UIName.DHLevel2ViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})