






local this = {vm=nil};
local data={}
local command={}

local distance=100;
local dragCount=0;
local startX=0;
local uiSpine=nil;
local callBack=nil;
local direction=0;
local isOnce=false;
local isComplete=false;
local interCfg=nil;
local curMsgIndex;
local maxMsgCount;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local rawImageBg = nil;
local tranDrag = nil;
local btnNext = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranDrag = uiLink:Get("tranDrag"):GetComponent("RectTransform");
    btnNext = uiLink:Get("btnNext"):GetComponent("Button");
    uiLink:AddClickEvent("btnNext",this.BtnNextCommand)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    rawImageBg = nil;
    tranDrag = nil;
    btnNext = nil;

end

this.BtnNextCommand=function()
    curMsgIndex=curMsgIndex+1;
    NovelInteractMgr.CloseInteractMsg();
    this.SetDialogMsg();
end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        uiSpine=vm.behaviour.transform:Find("root/Middle/NovelBlack001"):GetComponent("UISpineCharacter")

        local dragBehaviour=tranDrag:GetComponent("OnDragBehaviour")
        dragBehaviour.onBeginDrag=this.OnBeginDrag
        dragBehaviour.onDrag=this.OnDrag
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            isComplete=false;
            interCfg=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            dragCount=0;
            uiSpine:PlayAnimation("idle",true,nil);
            SetActive(tranDrag.gameObject,false)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
      
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
    local msgList=NumTool.split(interCfg.Msg,"|")
    curMsgIndex=1;
    maxMsgCount=#msgList;
    SetActive(btnNext.gameObject,true);
    this.SetDialogMsg()
end

this.SetDialogMsg=function()
    local worldPos=curMsgIndex==maxMsgCount and tranDrag:GetChild(1).transform.position or nil;
    if curMsgIndex==maxMsgCount then
        SetActive(btnNext.gameObject,false);
        SetActive(tranDrag.gameObject,true)
    end
    NovelInteractMgr.SetInteractMsg(curMsgIndex,worldPos)
end




this.OnBeginDrag=function(eventData)
    startX=eventData.position.x;
    direction=0;
    isOnce=true;
end



this.OnDrag=function(eventData)
    if isComplete then return end;
    if (direction>0 and eventData.delta.x<0) or (direction<0 and eventData.delta.x>0) then
        startX=eventData.position.x;
        isOnce=true;
    end
    direction=eventData.delta.x;
    if (isOnce and eventData.delta.x>0 and eventData.position.x-startX>distance) or (isOnce and eventData.delta.x<0 and startX-eventData.position.x>distance) then
        isOnce=false;
        dragCount=dragCount+1;
        this.SetTimeScale();
        if dragCount>=2 then
            isComplete=true;
            this.PlayShakeAnimation();
        end
       
    end
    
end

this.SetTimeScale=function()
    coroutine_runner.start(function()
        uiSpine:SetAnimationStateTimeScale(10);
        coroutine_runner.wait(0.3)
        uiSpine:SetAnimationStateTimeScale(1);
    end)
end

this.PlayShakeAnimation=function()
    SetActive(tranDrag.gameObject,false)
    coroutine_runner.start(function()
        coroutine_runner.wait(0.3)
        NovelInteractMgr.CloseInteractMsg();
        uiSpine:PlayAnimation("shake",false,function()
            LuaMgr.HidePanel(UIName.NovelInteractionBlackerViewModel);
            if callBack~=nil then
                callBack();
            end
        end);
        uiSpine:SetAnimationStateTimeScale(1);
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})