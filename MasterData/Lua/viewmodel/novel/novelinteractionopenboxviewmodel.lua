






local this = {vm=nil};
local callBack=nil;
local interCfg=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local rawImageBg = nil;
local tranClose = nil;
local tranZipper = nil;
local tranOpen = nil;
local sliderZipper = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranClose = uiLink:Get("tranClose"):GetComponent("RectTransform");
    tranZipper = uiLink:Get("tranZipper"):GetComponent("RectTransform");
    tranOpen = uiLink:Get("tranOpen"):GetComponent("RectTransform");
    sliderZipper = uiLink:Get("sliderZipper"):GetComponent("Slider");

    
    uiLink:AddSliderEvent("sliderZipper",function(value)
        if value>=0.99 then
            SetActive(tranClose.gameObject,false);
            SetActive(tranOpen.gameObject,true);
        end
        NovelInteractMgr.CloseInteractMsg()
    end)
    uiLink:AddClickEvent("tranOpen",function()
        LuaMgr.HidePanel(UIName.NovelInteractionOpenBoxViewModel);
        if callBack~=null then
            callBack();
        end
    end)

end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    rawImageBg = nil;
    tranClose = nil;
    tranZipper = nil;
    tranOpen = nil;
    sliderZipper = nil;

end




local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            interCfg=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            this.ParseData();
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
    if interCfg.BgImg==nil or interCfg.BgImg=="" then
        SetActive(rawImageBg.transform.gameObject,false);
    else
        SetActive(rawImageBg.transform.gameObject,true);
        rawImageBg.texture=LuaMgr.GetTexture(Path.NovelCgPath..interCfg.BgImg..".png");
    end
    sliderZipper.value=0.0;
    SetActive(tranClose.gameObject,true);
    SetActive(tranOpen.gameObject,false);
    coroutine_runner.start(function()
        coroutine_runner.wait(0.3)
        NovelInteractMgr.SetInteractMsg(1,tranZipper.transform.position);
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})