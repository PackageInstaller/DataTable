






local this = {vm=nil};

local interCfg=nil;
local callBack=nil;
local ani_isPlaying=false
local proIndex=0;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local rawImageBg = nil;
local animatorRock = nil;
local btnRock1 = nil;
local btnRock2 = nil;
local btnRock3 = nil;
local coKey1=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    animatorRock = uiLink:Get("animatorRock"):GetComponent("Animator");
    btnRock1 = uiLink:Get("btnRock1"):GetComponent("Button");
    btnRock2 = uiLink:Get("btnRock2"):GetComponent("Button");
    btnRock3 = uiLink:Get("btnRock3"):GetComponent("Button");
    
    uiLink:AddClickEvent("btnRock1",this.OnClickRock1Command)
    uiLink:AddClickEvent("btnRock2",this.OnClickRock2Command)
    uiLink:AddClickEvent("btnRock3",this.OnClickRock3Command)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    rawImageBg = nil;
    animatorRock = nil;
    btnRock1 = nil;
    btnRock2 = nil;
    btnRock3 = nil;

end



this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnRock1 = nil;
    btnRock2 = nil;
    btnRock3 = nil;

end


this.OnClickRock1Command=function()
    if ani_isPlaying or proIndex~=1 then return end;
    ani_isPlaying=true
    NovelInteractMgr.CloseInteractMsg()
    if coKey1~=nil then
        coroutine_runner.stop(coKey1);
    end
    coKey1=coroutine_runner.start(function()
        animatorRock:Play("rock1_disappear",0,0)
        coroutine_runner.WaitUntil(function()

            if animatorRock~=nil then
                local stateInfo=animatorRock:GetCurrentAnimatorStateInfo(0)
                return  stateInfo:IsName("rock1_disappear") and stateInfo.normalizedTime>=1.0
            end
        end);
        SetActive(btnRock1.gameObject,false)
        this.SetDialogMsg(2)
        end)
end
this.OnClickRock2Command=function()
    if ani_isPlaying or proIndex~=2 then return end;
    ani_isPlaying=true
    NovelInteractMgr.CloseInteractMsg()
    coroutine_runner.start(function()
        animatorRock:Play("rock2_disappear")
        coroutine_runner.WaitUntil(function()
            local stateInfo=animatorRock:GetCurrentAnimatorStateInfo(0)
            return stateInfo:IsName("rock2_disappear") and stateInfo.normalizedTime>=1.0
        end);
        SetActive(btnRock2.gameObject,false)
        this.SetDialogMsg(3)
    end)
end
this.OnClickRock3Command=function()
    if ani_isPlaying or proIndex~=3 then return end;
    ani_isPlaying=true
    animatorRock:Play("rock3_select")
    NovelInteractMgr.CloseInteractMsg()
    coroutine_runner.start(function()
        animatorRock:Play("rock3_disappear",0,0)
        coroutine_runner.WaitUntil(function()
            local stateInfo=animatorRock:GetCurrentAnimatorStateInfo(0)
            return stateInfo:IsName("rock3_disappear") and stateInfo.normalizedTime>=1.0
        end);
        SetActive(btnRock3.gameObject,false)
        LuaMgr.HidePanel(UIName.NovelInteractionRockViewModel)
        if callBack~=nil then
            callBack();
        end
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
            SetActive(btnRock1.gameObject,true)
            SetActive(btnRock2.gameObject,true)
            SetActive(btnRock3.gameObject,true);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if coKey1~=nil then
            coroutine_runner.stop(coKey1);
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
    coroutine_runner.start(function()
        coroutine_runner.WaitUntil(function()
            if animatorRock~=nil then
                local stateInfo=animatorRock:GetCurrentAnimatorStateInfo(0)
                return stateInfo:IsName("rock_appear") and stateInfo.normalizedTime>=1.0
            end
        end);
        this.SetDialogMsg(1)
    end)
end


this.SetDialogMsg=function(index)
    proIndex=index;
    ani_isPlaying=false
    local worldPos=nil;
    if index==1 then
        animatorRock:Play("rock1_select")
        worldPos=animatorRock.transform:GetChild(0).transform.position;
    elseif index==2 then
        animatorRock:Play("rock2_select")
        worldPos=animatorRock.transform:GetChild(1).transform.position;
    elseif index==3 then
        animatorRock:Play("rock3_select")
        worldPos=animatorRock.transform:GetChild(2).transform.position;
    end
    NovelInteractMgr.SetInteractMsg(index,worldPos)
end

return vm({
    data = data,
    command = command,
    hook = hook
})