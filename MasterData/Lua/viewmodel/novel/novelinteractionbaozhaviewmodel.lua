






local this = {vm=nil};
local data={}
local command={}
local interCfg=nil;
local callBack=nil;
local animator=nil;
local tweerRotate=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goZhadan1 = nil;
local goState1 = nil;
local goState2 = nil;
local goZhadan2 = nil;
local Right = nil;
local rawImageBg = nil;
local tranPointer = nil;
local tranDrag = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goZhadan1 = uiLink:Get("goZhadan1");
    goState1 = uiLink:Get("goState1");
    goState2 = uiLink:Get("goState2");
    goZhadan2 = uiLink:Get("goZhadan2");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranPointer = uiLink:Get("tranPointer"):GetComponent("RectTransform");
    tranDrag = uiLink:Get("tranDrag"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goZhadan1 = nil;
    goState1 = nil;
    goState2 = nil;
    goZhadan2 = nil;
    Right = nil;
    rawImageBg = nil;
    tranPointer = nil;
    tranDrag = nil;

end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
       
        local dragBehaviour=tranDrag:GetComponent("OnDragBehaviour")
        dragBehaviour.onBeginDrag=this.OnBeginDrag
        dragBehaviour.onDrag=this.OnDrag
        dragBehaviour.onEndDrag=this.OnEndDrag
        dragBehaviour.onPointerUp=this.OnPointerUp
        animator=goZhadan1:GetComponent("Animator");
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            interCfg=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            animator:Play("ani_NovelInteractionBaoZha_Enter")
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        tranPointer.localEulerAngles=Vector3.zero
    end,
    before_destroy=function()
        this.Clear()
    end
}
this.ParseData=function()
    tranPointer.localEulerAngles=Vector3.zero
    this.DORotate()
    SetActive(goZhadan1,true); 
    SetActive(goState1,true);
    SetActive(goZhadan2,false);
end

this.DORotate=function()
    tweerRotate=DOTWeen.To(function() return 0  end,function(z)
        tranPointer.localEulerAngles=Vector3(0,0,z);
    end,-5,1);
tweerRotate:SetEase(Ease.OutCirc)
    tweerRotate:SetLoops(-1)
end


this.OnBeginDrag=function(eventData)
   print(eventData.delta.x)
    if tweerRotate~=nil then
        tweerRotate:Kill();
    end
end

this.OnDrag=function(eventData)
    print(tranPointer.localEulerAngles.z)
    if tranPointer.localEulerAngles.z>150 and tranPointer.localEulerAngles.z<210 then
        this.SetStateOpening();
        return
    end
    if eventData.delta.x>0 then
        local offX=eventData.delta.x
        if offX>60 then
            offX=60;
        elseif offX<-60 then
            offX=-60;
        end
        tranPointer.localEulerAngles=tranPointer.localEulerAngles+Vector3(0,0,-offX*0.3)
        
    end
    
end

this.OnEndDrag=function(eventData)
    
end


this.OnPointerUp=function(eventData)
    local tarPos=tranPointer.localEulerAngles.z>180 and 360 or 0
    DOTWeen.To(function() return tranPointer.localEulerAngles.z  end,function(z)
        tranPointer.localEulerAngles=Vector3(0,0,z);
    end,tarPos,0.2)
end


this.SetStateOpening=function()
    animator:Play("ani_NovelInteractionBaoZha_explosion")
    coroutine_runner.start(function()
        coroutine_runner.wait(2.2)
        if callBack~=nil then
            callBack();
        end
        LuaMgr.HidePanel(UIName.NovelInteractionBaoZhaViewModel)
    end)
    
end




return vm({
    data = data,
    command = command,
    hook = hook
})