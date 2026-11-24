require("SeasonSLG/EventPopUp/WorldBuffItem")
require("SeasonSLG/EventPopUp/Boss2BuffItem")
local this = {
   worldBuffView=nil;
   worldBuffListItemObj=nil;
   buffItemObj=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2WorldBuffAddInfoViewModel)
    end)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2WorldBuffAddInfoViewModel)
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.worldBuffView=UIScrollView.New(ui.goScrollView);
        this.worldBuffListItemObj=vm.behaviour.transform:Find("template/worldBuffList").gameObject;
        this.buffItemObj=vm.behaviour.transform:Find("template/buffItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.worldBuffView:Clear();
    end,
    before_destroy = function()
       UIScrollView.ClearItem("WorldBuffItem")
        UIListView.ClearItem("Boss2BuffItem")
        this.ClearUI();
    end
}

this.ParseData=function()
    this.worldBuffList={};
    for  i,v in pairs(ConfigMgr.Config.SeasonalGridBOSSHeat) do
        table.insert(this.worldBuffList,v);
    end
    table.sort(this.worldBuffList,function(a, b)
        return tonumber(a.Id)<tonumber(b.Id)
    end)
    this.SetWorldBuffUIList();

end
this.SetWorldBuffUIList=function()
    this.worldBuffView:Clear();
    local list={}
    for i,v in ipairs(this.worldBuffList) do
        local worldBuffItem={
            index=i,
            name=SeasonSLGEventMgr.GetProgressName(v.HeatProgress);
            buffList=v.BuffGroup,
            buffItemObj=this.buffItemObj
        }
        local worldBuffData=UIScrollData.GetData(this.worldBuffListItemObj,"WorldBuffItem",850,150,worldBuffItem);
        table.insert(list,worldBuffData);
    end
    this.worldBuffView:SetParams(850,386)
    this.worldBuffView:SetData(list);
end


return vm({
    data = data,
    command = command,
    hook = hook
})