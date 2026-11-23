






local this = {vm=nil};


local animator=nil;
local cokey=nil;
local imgName=nil;

local data={}
local command={}

local callBack=nil;
local interCfg=nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local goPhoto = nil;
local goResult = nil;
local Left = nil;
local Right = nil;
local rawImageBg = nil;
local rawImagePhoto = nil;
local btnPhoto = nil;
local btnMask = nil;
local rectMask = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goPhoto = uiLink:Get("goPhoto");
    goResult = uiLink:Get("goResult");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    rawImagePhoto = uiLink:Get("rawImagePhoto"):GetComponent("RawImage");
    btnPhoto = uiLink:Get("btnPhoto"):GetComponent("Button");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    rectMask = uiLink:Get("rectMask"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnPhoto",this.PlayPhoto)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.NovelInteractionPhotoViewModel)
        if callBack~=nil then
            callBack();
        end
    end)
end

this.PlayPhoto=function()
    animator:Play("ani_NovelInteractionPhoto_root")
    if not IsNullOrEmpty(imgName) then
        rawImagePhoto.texture=LuaMgr.GetTexture(Path.NovelCgPath..imgName..".png");
    end
    cokey=coroutine_runner.start(function()
        coroutine_runner.wait(0.7)
        if cokey==nil then return end;
        SetActive(goPhoto,false)
        SetActive(goResult,true);
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    goPhoto = nil;
    goResult = nil;
    Left = nil;
    Right = nil;
    rawImageBg = nil;
    rawImagePhoto = nil;
    btnPhoto = nil;
    btnMask = nil;
    rectMask = nil;

end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            interCfg=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            if vm.behaviour.Params.Length>2 then
                imgName=vm.behaviour.Params[2]
            end
            SetActive(goResult,false)
            SetActive(goPhoto,true);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params ~= nil) then
            if cokey~=nil then
                coroutine_runner.stop(cokey);
                cokey=nil;
            end
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
    data = data,
    command = command,
    hook = hook
})