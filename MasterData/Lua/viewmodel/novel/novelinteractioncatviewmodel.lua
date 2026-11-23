






local this = {vm=nil};
local data={}
local command={}
local uiSpine=nil;
local distance=100;
local start=0
local isPlaying=false
local isComplete=false;
local callBack=nil;
local interCfg=nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local rawImageBg = nil;
local tranDragLeft = nil;
local tranDragTop = nil;
local tranDragRight = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranDragLeft = uiLink:Get("tranDragLeft"):GetComponent("RectTransform");
    tranDragTop = uiLink:Get("tranDragTop"):GetComponent("RectTransform");
    tranDragRight = uiLink:Get("tranDragRight"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    rawImageBg = nil;
    tranDragLeft = nil;
    tranDragTop = nil;
    tranDragRight = nil;

end


this.BtnDoneCommand=function()
    LuaMgr.HidePanel(UIName.NovelInteractionCatViewModel)
    if callBack~=nil then
        callBack();
    end
end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        uiSpine=vm.behaviour.transform:Find("root/Middle/NovelCat001"):GetComponent("UISpineCharacter")

        local leftDragBehaviour=tranDragLeft:GetComponent("OnDragBehaviour")
        leftDragBehaviour.onBeginDrag=this.LeftOnBeginDrag
        leftDragBehaviour.onDrag=this.LeftOnDrag

        local rightDragBehaviour=tranDragRight:GetComponent("OnDragBehaviour")
        rightDragBehaviour.onBeginDrag=this.RightOnBeginDrag
        rightDragBehaviour.onDrag=this.RightOnDrag

        local topDragBehaviour=tranDragTop:GetComponent("OnDragBehaviour")
        topDragBehaviour.onBeginDrag=this.TopOnBeginDrag
        topDragBehaviour.onDrag=this.TopOnDrag
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
    isComplete=false
    if interCfg.BgImg==nil or interCfg.BgImg=="" then
        SetActive(rawImageBg.transform.gameObject,false);
    else
        SetActive(rawImageBg.transform.gameObject,true);
        rawImageBg.texture=LuaMgr.GetTexture(Path.NovelCgPath..interCfg.BgImg..".png");
    end
    uiSpine:PlayAnimation("idle",true,nil);
    this.SetDragAreaByIndex(1)
end


this.SetDialogMsg=function(index)
    local worldPos=nil;
    if index==1 then
        worldPos=tranDragLeft:GetChild(1).transform.position;
    elseif index==2 then
        worldPos=tranDragRight:GetChild(1).transform.position;
    elseif index==3 then
        worldPos=tranDragTop:GetChild(1).transform.position;
    end
    NovelInteractMgr.SetInteractMsg(index,worldPos)
end


this.SetDragAreaByIndex=function(stepIndex)
    if isComplete then return end;
    if stepIndex==-1 then
        isComplete=true;
        LuaMgr.HidePanel(UIName.NovelInteractionCatViewModel)
        if callBack~=nil then
            callBack();
        end
        return
    end
    this.SetDialogMsg(stepIndex)
    SetActive(tranDragLeft.gameObject,stepIndex==1 )
    SetActive(tranDragRight.gameObject,stepIndex==2 )
    SetActive(tranDragTop.gameObject,stepIndex==3 )
end


this.LeftOnBeginDrag=function(eventData)
    start=eventData.position.y
    isPlaying=false
end

this.LeftOnDrag=function(eventData)
    if not isPlaying and eventData.delta.y<=0 and start-eventData.position.y>=distance then
        isPlaying=true
        SetActive(tranDragLeft.gameObject,false)
        NovelInteractMgr.CloseInteractMsg();
        uiSpine:PlayAnimation("3tail",true,function()
            isPlaying=false
            this.SetDragAreaByIndex(2)
        end);
    end
end


this.RightOnBeginDrag=function(eventData)
    start=eventData.position.y
    isPlaying=false
end


this.RightOnDrag=function(eventData)
    if not isPlaying and eventData.delta.y>=0 and eventData.position.y-start>=distance then
        isPlaying=true
        SetActive(tranDragRight.gameObject,false)
        NovelInteractMgr.CloseInteractMsg();
        uiSpine:PlayAnimation("2back",true,function()
            isPlaying=false
            this.SetDragAreaByIndex(3)
        end);
    end
end


this.TopOnBeginDrag=function(eventData)
    start=eventData.position.x
    isPlaying=false
end


this.TopOnDrag=function(eventData)
    if not isPlaying and eventData.delta.x>=0 and eventData.position.x-start>=distance then
        isPlaying=true
        SetActive(tranDragTop.gameObject,false)
        NovelInteractMgr.CloseInteractMsg();
        uiSpine:PlayAnimation("1ear",true,function()
            isPlaying=false
            this.SetDragAreaByIndex(-1)
        end);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})