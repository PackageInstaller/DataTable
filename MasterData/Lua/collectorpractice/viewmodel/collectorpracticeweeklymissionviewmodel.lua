require("CollectorPractice/Common/UIWeeklyRewardSLotItem")
local tarGameObject = nil;
local tarRect = nil;
local UIWeeklyRewardSLotItemPrefab = nil;
local root = nil;
local Middle = nil;
local Left = nil;
local rectTipsBG = nil;
local rectBGFlower = nil;
local rectShadow = nil;
local rectScheduleImage = nil;
local rectTextButton = nil;
local textTime = nil;
local textFlower1 = nil;
local textFlower2 = nil;
local textFlower3 = nil;
local textFlower4 = nil;
local textSchedule = nil;
local ScrollView = nil;
local ScrollbarHorizontal = nil;
local btnClickRule = nil;
local rectContent=nil;
local this = {
    vm = nil,
    rewardDataList = {},
    rewardItemList={};
}

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UIWeeklyRewardSLotItemPrefab = uiLink:Get("UIWeeklyRewardSLotItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    Left = uiLink:Get("Left");
    rectTipsBG = uiLink:Get("rectTipsBG"):GetComponent("RectTransform");
    rectBGFlower = uiLink:Get("rectBGFlower"):GetComponent("RectTransform");
    rectShadow = uiLink:Get("rectShadow"):GetComponent("RectTransform");
    rectScheduleImage = uiLink:Get("rectScheduleImage"):GetComponent("RectTransform");
    rectTextButton = uiLink:Get("rectTextButton"):GetComponent("RectTransform");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    textFlower1 = uiLink:Get("textFlower1"):GetComponent("Text");
    textFlower2 = uiLink:Get("textFlower2"):GetComponent("Text");
    textFlower3 = uiLink:Get("textFlower3"):GetComponent("Text");
    textFlower4 = uiLink:Get("textFlower4"):GetComponent("Text");
    textSchedule = uiLink:Get("textSchedule"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ScrollbarHorizontal = uiLink:Get("ScrollbarHorizontal"):GetComponent("ScrollRect");
    btnClickRule = uiLink:Get("btnClickRule"):GetComponent("Button");
    rectContent= uiLink:Get("rectContent"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnMask", function()
        LuaMgr.Back();
    end);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UIWeeklyRewardSLotItemPrefab = nil;
    root = nil;
    Middle = nil;
    Left = nil;
    rectTipsBG = nil;
    rectBGFlower = nil;
    rectShadow = nil;
    rectScheduleImage = nil;
    rectTextButton = nil;
    textTime = nil;
    textFlower1 = nil;
    textFlower2 = nil;
    textFlower3 = nil;
    textFlower4 = nil;
    textSchedule = nil;
    ScrollView = nil;
    ScrollbarHorizontal = nil;
    btnClickRule = nil;
    rectContent=nil;
    this={};
end


this.InitData = function()
    this.rewardDataList={};
    local dataTable = DataMgr.Player.missions["weekly"]["604"];
    for key, value in pairs(dataTable) do
        table.insert(this.rewardDataList, value);
    end
    table.sort(this.rewardDataList, function(a, b)
        return a.target < b.target;
    end)
end

this.InitPanel = function()
    local textTimeString = ConfigMgr.LangGlobal("7124");
    local time = this.rewardDataList[1].expiredTime - LuaMgr.Timestamp();
textTime.text = string.format(textTimeString,math.floor(time/86400),math.ceil((time%86400)/3600))
    local textScheduleString = ConfigMgr.LangGlobal("7125");
    local missionsData = this.rewardDataList[#this.rewardDataList];
    textSchedule.text = string.format(textScheduleString, missionsData.current, missionsData.target);
    local textTemp = ConfigMgr.LangGlobal("7128");
    textFlower1.text = CNSub(textTemp, 1, 3);
    textFlower2.text = CNSub(textTemp, 3, 5);
    textFlower3.text = CNSub(textTemp, 5, 7);
    textFlower4.text = CNSub(textTemp, 7, 9);

    local nowPrecent = (LuaMgr.GetScreenWidth()+LuaMgr.ScreenOffSet() - 1280) / (1680 - 1280)

    rectTipsBG.anchoredPosition = Vector2(this.GetNumberByPercent(118.7, 0, nowPrecent), rectTipsBG.anchoredPosition.y);

    rectBGFlower.anchoredPosition = Vector2(this.GetNumberByPercent(212.7, 93, nowPrecent),
        rectBGFlower.anchoredPosition.y);

    rectScheduleImage.anchoredPosition = Vector2(this.GetNumberByPercent(199.2999, 82.5, nowPrecent),
        rectScheduleImage.anchoredPosition.y);

    rectTextButton.anchoredPosition = Vector2(this.GetNumberByPercent(-220.55, -77.742, nowPrecent),rectTextButton.anchoredPosition.y)

    local rectScrollView=ScrollView:GetComponent("RectTransform");
    rectScrollView.anchoredPosition = Vector2(this.GetNumberByPercent(399.2999, 290.77, nowPrecent),rectScrollView.anchoredPosition.y);

    rectScrollView.sizeDelta = Vector2(this.GetNumberByPercent(1060.147,1311.488, nowPrecent),rectScrollView.sizeDelta.y);

    rectShadow.anchoredPosition = Vector2(this.GetNumberByPercent(399.2999, 290.77, nowPrecent),rectShadow.anchoredPosition.y);
end

this.InitRewardSlot = function()

    local scrollDatas = {}
    local scrollData=nil;
    for i = 1, #this.rewardDataList, 1 do
        local tempData={};
        local missionId=this.rewardDataList[i].id
        local missionData=ConfigMgr.Config.missionMap[missionId];
        tempData.itemId=missionData.rewards[1].itemId;
        tempData.count=missionData.rewards[1].count;
        tempData.targetCount=this.rewardDataList[i].target;
        tempData.isReceived=this.rewardDataList[i].completed;
        tempData.isLock=(this.rewardDataList[i].current<this.rewardDataList[i].target);
        tempData.fun=this.ClickFun;
        scrollData = UIScrollData.GetData(UIWeeklyRewardSLotItemPrefab, "UIWeeklyRewardSLotItem", 160, 218, tempData)
        table.insert(scrollDatas, scrollData)
    end
    local nowPrecent = (LuaMgr.GetScreenWidth()+LuaMgr.ScreenOffSet() - 1280) / (1680 - 1280)
    this.UISV:SetParams(this.GetNumberByPercent(1060.147,1311.488, nowPrecent), 218)
    this.UISV:SetData(scrollDatas, true);
    this.UISV:Refresh();
end

this.ClickFun=function ()
    local dataTable = DataMgr.Player.missions["weekly"]["604"];
    local missionIDs={};
    for key, value in pairs(dataTable) do
        if (not value.completed) and(value.current>=value.target) then
            table.insert(missionIDs,value.id);
        end
    end
    local tempData = {}
    tempData.Tab = "weekly"
    tempData.MissionIDs = missionIDs;
    ApiMgr.Request("complete_mission",tempData,true,function(result)
        local re = json.decode(result)
        local resultData = json.encode(re.result)
        HeroRedDataHelper.RefreshCollectorPracticeWeeklyRed();
        LuaMgr.ShowItemRewared(resultData, function()
            if next(this) == nil then
                return
            end
            this.InitData();
            this.InitRewardSlot();
        end)
    end,nil,true)
end

this.GetNumberByPercent = function(startValue, endValue, percent)
    return startValue + ((endValue - startValue) * percent);
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        this.UISV = UIScrollView.New(ScrollView.gameObject);
        print("before_active")
        this.InitData();
        this.InitPanel();
        this.InitRewardSlot();
    end,
    before_deactive = function(vm)
        this.UISV:Clear(true);
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("UIWeeklyRewardSLotItem")
        this.Clear();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})