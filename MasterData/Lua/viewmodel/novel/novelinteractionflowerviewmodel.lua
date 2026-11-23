






local this = {vm=nil};
local callBack=nil;
local interCfg=nil;
local isClick=false;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local rawImageBg = nil;
local animatorFlower = nil;
local btnClick=nil;
local coKey=nil;



this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    animatorFlower = uiLink:Get("animatorFlower"):GetComponent("Animator");
    btnClick=uiLink:Get("btnClick"):GetComponent("Button");
    uiLink:AddClickEvent("btnClick",this.BtnClick_Excute)
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    rawImageBg = nil;
    animatorFlower = nil;
    btnClick=nil;
end

this.BtnClick_Excute=function()
    if isClick then return end;
    isClick=true;
    animatorFlower:Play("ani_UI_Flowers_Effect_enter")
    if coKey~=nil then
        coroutine_runner.stop(coKey);
    end
    coKey=coroutine_runner.start(function()
        coroutine_runner.wait(3)
        LuaMgr.HidePanel(UIName.NovelInteractionFlowerViewModel)
    end)
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
            isClick=false;
            animatorFlower:Play("ani_UI_Flowers_Effect_shine")
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end;
        if callBack~=nil then
            callBack();
        end
        if coKey~=nil then
            coroutine_runner.stop(coKey);
        end
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
end

return vm({
    data = nil,
    command = nil,
    hook = hook
})