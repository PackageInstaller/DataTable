






local this = {vm=nil};
local callBack=nil;
local isMoving=false;
local count=0;


local interCfg=nil;
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local rawImageBg = nil;
local tranLine = nil;
local tranDoor = nil;
local tranHaft = nil;
local tranDragArea = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranLine = uiLink:Get("tranLine"):GetComponent("RectTransform");
    tranDoor = uiLink:Get("tranDoor"):GetComponent("RectTransform");
    tranHaft = uiLink:Get("tranHaft"):GetComponent("RectTransform");
    tranDragArea = uiLink:Get("tranDragArea"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    rawImageBg = nil;
    tranLine = nil;
    tranDoor = nil;
    tranHaft = nil;
    tranDragArea = nil;

end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        print("before_awake");
        local haftDragBehaviour=tranDragArea:GetComponent("OnDragBehaviour")
        haftDragBehaviour.onBeginDrag=this.HaftBeginDrag
        haftDragBehaviour.onDrag=this.HaftOnDrag
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
    isMoving=false;
    count=0;
    if interCfg.BgImg==nil or interCfg.BgImg=="" then
        SetActive(rawImageBg.transform.gameObject,false);
    else
        SetActive(rawImageBg.transform.gameObject,true);
        rawImageBg.texture=LuaMgr.GetTexture(Path.NovelCgPath..interCfg.BgImg..".png");
    end
    tranDoor.anchoredPosition=Vector2(-47.8,0);
    coroutine_runner.start(function()
        coroutine_runner.wait(0.3)
        NovelInteractMgr.SetInteractMsg(1,tranDragArea.transform.position);
    end)
end


this.HaftBeginDrag=function(eventData)
    
end

this.HaftOnDrag=function(eventData)
    if not isMoving and eventData.delta.x<0  then
        LuaMgr.HidePanel(UIName.NovelMsgFingerViewModel)
        isMoving=true;
        local tarX=count==0 and -264 or -675;
        local time=count==0 and 0.7 or 0.5;
        tranDoor:DOLocalMoveX(tarX,time).onComplete=function()
            isMoving=false;
            count=count+1;
            if count>1 then
                coroutine_runner.start(function()
                    coroutine_runner.wait(0.5)
                    if callBack~=nil then
                        callBack();
                    end
                    LuaMgr.HidePanel(UIName.NovelInteractionTranDoorViewModel)
                end)
            end
        end
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})