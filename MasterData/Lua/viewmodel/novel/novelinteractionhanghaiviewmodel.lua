






local this = {vm=nil};
local data={}
local command={}
local callBack=nil;
local interCfg=nil;
local isPlaying=false;
local animator=nil;
local animator_group=nil;
local cokey=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goTip = nil;
local Right = nil;
local rawImageBg = nil;
local tranDrag = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goTip = uiLink:Get("goTip");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranDrag = uiLink:Get("tranDrag"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goTip = nil;
    Right = nil;
    rawImageBg = nil;
    tranDrag = nil;

end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        local dragBehaviour=tranDrag:GetComponent("OnDragBehaviour")
        dragBehaviour.onBeginDrag=this.LeftOnBeginDrag
        dragBehaviour.onDrag=this.LeftOnDrag
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        animator_group=vm.behaviour.transform:Find("root/Middle/goTip/group"):GetComponent("Animator");
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            interCfg=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            animator:Play("ani_NovelInteractionHangHai_root",0,0)
            animator_group:Play("ani_NovelInteractionHangHai_group_001",0,0)
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
    isPlaying=false;
    if interCfg.BgImg==nil or interCfg.BgImg=="" then
        SetActive(rawImageBg.transform.gameObject,false);
    else
        SetActive(rawImageBg.transform.gameObject,true);
        rawImageBg.texture=LuaMgr.GetTexture(Path.NovelCgPath..interCfg.BgImg..".png");
    end
end


this.LeftOnBeginDrag=function(eventData)
   
end

this.LeftOnDrag=function(eventData)
    local dir=0;
    if eventData.delta.x>0 then
        dir=1;
    elseif eventData.delta.x<0 then
       dir=-1;
    end
    this.PlayAnimation(dir)
end

this.PlayAnimation=function(dir)
    if isPlaying then return end;
    isPlaying=true;
    local aniName=dir>0 and "ani_NovelInteractionHangHai_right" or "ani_NovelInteractionHangHai_left";
    animator:Play(aniName,0,0);
    animator_group:Play("ani_NovelInteractionHangHai_group_002",0,0)
    cokey=coroutine_runner.start(function()
        coroutine_runner.wait(2.5)
        if cokey==nil then return end;
        if callBack~=nil then
            callBack();
        end
        LuaMgr.HidePanel(UIName.NovelInteractionHangHaiViewModel)
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})