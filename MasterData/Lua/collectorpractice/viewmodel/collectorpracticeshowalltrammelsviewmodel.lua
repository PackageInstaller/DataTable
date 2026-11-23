require("CollectorPractice/Common/UITrammelsItem")
require("CollectorPractice/Common/UITrammelsGroupItem")
local this = {
    vm = nil,
    trammelsDataList = {},
    UISV=nil;
    needShowMap=nil,
}

local tarGameObject = nil;
local tarRect = nil;
local UITrammelsItemPrefab = nil;
local UITrammelsGroupItemPrefab = nil;
local root = nil;
local Middle = nil;
local ScrollView = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UITrammelsItemPrefab = uiLink:Get("UITrammelsItem");
    UITrammelsGroupItemPrefab = uiLink:Get("UITrammelsGroupItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    uiLink:AddClickEvent("btnMask", function()
        LuaMgr.Back();
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UITrammelsItemPrefab = nil;
    root = nil;
    Middle = nil;
    ScrollView = nil;
    this=nil;
end


this.InitData = function()
    this.trammelsDataList={};
    local config=ConfigMgr.Config.OriginsTalentMap;
    local playeData = DataMgr.Player.originsTalent
    for key, value in pairs(config) do
        if value.Map==this.needShowMap then
            local data={};
            data.OriginsData=value;
            data.isLock=playeData[value.OriginsID] == nil
            data.prefab=UITrammelsItemPrefab;
            table.insert(this.trammelsDataList,data)
        end
    end
    table.sort(this.trammelsDataList,function (a, b)
        return a.OriginsData.OtOrder<b.OriginsData.OtOrder;
    end)
end

this.InitTrammelsSlot = function()
    local scrollDatas = {}
    local scrollData=nil;
    for i = 1, #this.trammelsDataList, 2 do
        local temp={};
        table.insert(temp,this.trammelsDataList[i]);
        table.insert(temp,this.trammelsDataList[i+1]);
        scrollData = UIScrollData.GetData(UITrammelsGroupItemPrefab, "UITrammelsGroupItem", 599.3561, 80, temp)
        table.insert(scrollDatas, scrollData)
    end
    this.UISV:SetParams(600,377.6354)
    this.UISV:SetData(scrollDatas, false);
    this.UISV:Refresh();
end


local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if (this.vm.behaviour.Params == nil) then return end
        this.needShowMap=this.vm.behaviour.Params[0];
        this.UISV = UIScrollView.New(ScrollView.gameObject);
        this.InitData();
        this.InitTrammelsSlot();
    end,
    before_deactive = function(vm)
        if (this.vm.behaviour.Params == nil) then return end
        this.UISV:Clear(true);
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("UITrammelsGroupItem")
        this.Clear();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})