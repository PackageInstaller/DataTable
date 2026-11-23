






local this = {vm=nil};
local data={}
local command={}

local confrimCallBack=nil;
local cancelCallBack=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local txtTitle = nil;
local text = nil;
local txtDes = nil;
local ScrollView = nil;
local btnConfrim = nil;
local btnCancel = nil;
local uiLink=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    text = uiLink:Get("text"):GetComponent("Text");
    txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    txtTitle = nil;
    text = nil;
    txtDes = nil;
    ScrollView = nil;
    btnConfrim = nil;
    btnCancel = nil;

end


this.RegisterEvent=function()
    uiLink:AddClickEvent("btnConfrim",function()
        if confrimCallBack~=nil then
            confrimCallBack();
        end
        LuaMgr.HidePanel(UIName.NovelSkipViewModel)
    end)
    uiLink:AddClickEvent("btnCancel",function()
        if cancelCallBack~=nil then
            cancelCallBack();
        end
        LuaMgr.HidePanel(UIName.NovelSkipViewModel)
    end)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.RegisterEvent();
       
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil and vm.behaviour.Params.Length>2) then
            local novelId=vm.behaviour.Params[0];
            confrimCallBack=vm.behaviour.Params[1]
            cancelCallBack=vm.behaviour.Params[2];
            if ConfigMgr.Config.narrativeMap[novelId]~=nil then
                local narrative=ConfigMgr.Config.narrativeMap[novelId];
                txtTitle.text=LuaMgr.GetLangText(narrative.nameLan)
                txtDes.text=LuaMgr.GetLangText(narrative.narraSkipDesLan) 
            end

        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
    before_destroy=function()
        this.Clear()
    end
}
this.ParseData=function()
 
end

return vm({
    data = data,
    command = command,
    hook = hook
})