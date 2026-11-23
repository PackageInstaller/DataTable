






local this = {vm=nil};
local callBack=nil;
local interCfg=nil;
local camera2D=nil;;
local offPos=nil;

local tarGameObject = nil;
local tarRect = nil;
local root3D = nil;
local Left = nil;
local Middle = nil;
local goFail = nil;
local goSuccess = nil;
local Right = nil;
local root2D = nil;
local goHand = nil;
local rawImageBg = nil;
local textTip = nil;
local tranKey = nil;
local tranMiddle=nil;
local transArea=nil;
local animator_3D=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root3D = uiLink:Get("root3D");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goFail = uiLink:Get("goFail");
    goSuccess = uiLink:Get("goSuccess");
    Right = uiLink:Get("Right");
    root2D = uiLink:Get("root2D");
    goHand = uiLink:Get("goHand");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    textTip = uiLink:Get("textTip"):GetComponent("Text");
    tranKey = uiLink:Get("tranKey"):GetComponent("RectTransform");
    tranMiddle=Middle:GetComponent("RectTransform");
    transArea=uiLink:Get("transArea"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root3D = nil;
    Left = nil;
    Middle = nil;
    goFail = nil;
    goSuccess = nil;
    Right = nil;
    root2D = nil;
    goHand = nil;
    rawImageBg = nil;
    textTip = nil;
    tranKey = nil;
     tranMiddle=nil;
    transArea=nil;

end





local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        print("before_awake");
        local dragBehaviour=tranKey:GetComponent("OnDragBehaviour")
        camera2D=root2D.transform:Find("Camera2D"):GetComponent("Camera")
        dragBehaviour.onBeginDrag=this.BeginDrag
        dragBehaviour.onDrag=this.OnDrag
        dragBehaviour.onPointerUp=this.OnPointerUp
        animator_3D=root3D.transform:Find("Middle/3DObject"):GetComponent("Animator");
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
        if callBack~=nil then
            callBack();
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
    tranKey.anchoredPosition=Vector2(-607,-244);
    SetActive(tranKey.gameObject,true);
    SetActive(goSuccess,false)
    SetActive(goFail,false);
end


this.BeginDrag=function(eventData)
    local locPos=RectTransformTool.ScreenToLocal(UnityEngine.Input.mousePosition, tranMiddle,camera2D);
    offPos=tranKey.anchoredPosition-locPos
end

this.OnDrag=function(eventData)
    local locPos=RectTransformTool.ScreenToLocal(UnityEngine.Input.mousePosition, tranMiddle,camera2D);
    tranKey.anchoredPosition=locPos+offPos;
    local dirVector=tranKey.anchoredPosition-transArea.anchoredPosition;
    local distance=math.sqrt(dirVector.x * dirVector.x + dirVector.y * dirVector.y);
    if distance<200 then

        animator_3D:Play("ani_NovelInteractionUnlock_3DobjectganyingSuccess")
        SetActive(tranKey.gameObject,false);
        coroutine_runner.start(function()
            coroutine_runner.wait(3.2)
            LuaMgr.HidePanel(UIName.NovelInteractionUnlockViewModel);
        end)
    end
end

this.OnPointerUp=function(eventData)
    local dirVector=tranKey.anchoredPosition-transArea.anchoredPosition;
    local distance=math.sqrt(dirVector.x * dirVector.x + dirVector.y * dirVector.y);
    if distance>200 and distance<400 then

        SetActive(tranKey.gameObject,false);
        animator_3D:Play("ani_NovelInteractionUnlock_3Dobjectganyingfail")
        coroutine_runner.start(function()
            coroutine_runner.wait(3.2)
            SetActive(tranKey.gameObject,true);
            tranKey.anchoredPosition=Vector2(-607,-244)
        end)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})