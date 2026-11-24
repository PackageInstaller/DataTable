require("SeasonSLG/SeasonSLGResourceItem")
local this = {
   resourceScrollView = nil;
   resourcesItemObj = nil;
   specialResource = nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.UIResourcePrefab = uiLink:Get("UIResourcePrefab");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goUIResourcePrefab = uiLink:Get("goUIResourcePrefab");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.rawImage = uiLink:Get("rawImage"):GetComponent("RawImage");
    ui.textNum = uiLink:Get("textNum"):GetComponent("Text");
    ui.txtTotal = uiLink:Get("txtTotal"):GetComponent("Text");
    ui.txtAddHour = uiLink:Get("txtAddHour"):GetComponent("Text");
    ui.ScrollViewResource = uiLink:Get("ScrollViewResource"):GetComponent("ScrollRect");
    ui.tranTips = uiLink:Get("tranTips"):GetComponent("RectTransform");
    ui.tranBg = uiLink:Get("tranBg"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(ui.tranTips.gameObject,false);
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.InitUI(vm.behaviour)
        this.resourceScrollView = UIScrollView.New(ui.ScrollViewResource.transform.gameObject);
        this.resourcesItemObj = vm.behaviour.transform:Find("template/UIResourcePrefab").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RefreshResources();
        this.RefreshStamina()
        SetActive(ui.tranTips.gameObject,false);
        LuaMgr.AddUIEventListener(UIEventConst.FatigueReply,this.RefreshStamina);
        LuaMgr.RemoveDataEventListener(this.RefreshResources);
        LuaMgr.AddDataEventListener(this.RefreshResources);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply,this.RefreshStamina);
        LuaMgr.RemoveDataEventListener(this.RefreshResources);
        this.resourceScrollView:Clear()
    end,
    before_destroy = function()
        this.resourceScrollView:Clear()
        UIScrollView.ClearItem("SeasonSLGResourceItem")
        this.specialResource = nil;
        this.ClearUI();
    end
}

this.RefreshResources = function()
    local resources = {}
    this.resourceScrollView:Clear()
    local config = SeasonSLGMapMgr.Constants().SeasonalResource1
    for i, v in pairs(config) do
        local item = {itemId = v,callBack=this.ResCallBack}
        local itemData=UIScrollData.GetData(this.resourcesItemObj,"SeasonSLGResourceItem",155,70,item);
        table.insert(resources,itemData);
    end
    local specialConfig = SeasonSLGMapMgr.Constants().SeasonalResource2S1
    local specialId = SeasonSLGTimeEventMgr.CheckIsSecondActivity() and specialConfig[2] or specialConfig[1]
    local item = {itemId = specialId,callBack=this.ResCallBack}
    local itemData=UIScrollData.GetData(this.resourcesItemObj,"SeasonSLGResourceItem",155,70,item);
    table.insert(resources,itemData);
    this.resourceScrollView:SetParams(640,75);
    this.resourceScrollView:SetData(resources);
    this.RefreshStamina();
end

this.ResCallBack=function(data)
    SetActive(ui.tranTips.gameObject,true)
    ui.txtTotal.text=string.format(LuaMgr.GetLangText("SeasonSLGResourcesFixViewModel_0"),LuaMgr.GetLangText(ConfigHelper.GetItemNamelan(data.itemId))
    ,data.count);
    ui.txtAddHour.text=string.format(LuaMgr.GetLangText("SeasonSLGResourcesFixViewModel_1"),data.addCount==nil and 0 or data.addCount);
    local width=ui.txtTotal.preferredWidth>ui.txtAddHour.preferredWidth and ui.txtTotal.preferredWidth or ui.txtAddHour.preferredWidth
    ui.tranBg.sizeDelta=Vector2(width+70,104)
    ui.tranTips.anchoredPosition=data.pos+Vector2(35,-70)+ui.ScrollViewResource.content.anchoredPosition;
    if this.timerId~=nil then
        NumTool.RemoveDelayHandler(this.timerId);
    end
    this.timerId=NumTool.DelayHandler(function()
        if ui~=nil then
            SetActive(ui.tranTips.gameObject,false);
        end
    end,5);
end

this.RefreshStamina = function()
    local staminaConfig = SeasonSLGMapMgr.Constants().SeasonalStaminaItem
    if this.specialResource == nil then
        this.specialResource = SeasonSLGResourceItem.New(ui.goUIResourcePrefab)
        this.specialResource:Init()
    end
    this.specialResource:SetData({data = {itemId = staminaConfig}})
end

return vm({
    data = data,
    command = command,
    hook = hook
})