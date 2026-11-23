require("CollectorPractice/Common/UIPathSLotItem")

local this = {
    vm = nil,
    rewardDataList = {},
    mapId = nil,
    startTime = nil,
    showPathData = {},
    pathItemList = {},
}

local tarGameObject = nil;
local tarRect = nil;
local UIPathSLotItemPrefab = nil;
local root = nil;
local Middle = nil;
local ScrollView = nil;
local rectContent = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UIPathSLotItemPrefab = uiLink:Get("UIPathSLotItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnMask", function()
        LuaMgr.Back();
    end);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UIPathSLotItemPrefab = nil;
    root = nil;
    Middle = nil;
    ScrollView = nil;
    rectContent = nil;
end



this.InitData = function()
this.mapId = "MapA";
    this.showPathData = {};
    this.startTime = ConfigMgr.Config.PracticePeriodMaps[this.mapId].openTime;
    local config = ConfigMgr.Config.InternLevel2Map;
    for key, value in pairs(config) do
        if value.MapType == this.mapId then
            table.insert(this.showPathData, value);
        end
    end
    table.sort(this.showPathData, function(a, b)
        return a.MapId < b.MapId;
    end)
end

this.InitPathItem = function()
    for i = 1, #this.showPathData, 1 do
        if i > #this.pathItemList then
            local temp = UIPathSLotItem.New(UIPathSLotItemPrefab, rectContent);
            table.insert(this.pathItemList, temp);
        end
        this.pathItemList[i]:SetData(this.startTime, this.showPathData[i]);
    end
    for i = #this.showPathData + 1, #this.pathItemList, 1 do
        this.pathItemList[i]:Hide();
    end
end

this.ShowAnimation=function ()
    for i = 1, #this.showPathData, 1 do
        this.pathItemList[i]:ShowFirstAnimation();
    end
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        print("before_active")
        this.InitData();
        this.InitPathItem();
        this.ShowAnimation();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})