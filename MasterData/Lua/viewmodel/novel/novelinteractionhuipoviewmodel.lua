






local this = {vm=nil};
local data={}
local command={}
local interCfg=nil;
local callBack=nil;
local animator=nil;
local vector=nil;
local isDragEnd=false;
local animator=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goline = nil;
local goBox1 = nil;
local goBox2 = nil;
local goHuiPo = nil;
local goMiaozhui = nil;
local goSuoding = nil;
local Right = nil;
local rawImageBg = nil;
local tranGroup = nil;
local tranDrag = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goline = uiLink:Get("goline");
    goBox1 = uiLink:Get("goBox1");
    goBox2 = uiLink:Get("goBox2");
    goHuiPo = uiLink:Get("goHuiPo");
    goMiaozhui = uiLink:Get("goMiaozhui");
    goSuoding = uiLink:Get("goSuoding");
    Right = uiLink:Get("Right");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    tranGroup = uiLink:Get("tranGroup"):GetComponent("RectTransform");
    tranDrag = uiLink:Get("tranDrag"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goline = nil;
    goBox1 = nil;
    goBox2 = nil;
    goHuiPo = nil;
    goMiaozhui = nil;
    goSuoding = nil;
    Right = nil;
    rawImageBg = nil;
    tranGroup = nil;
    tranDrag = nil;

end





local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
       
        local dragBehaviour=tranDrag:GetComponent("OnDragBehaviour")
        dragBehaviour.onBeginDrag=this.OnBeginDrag
        dragBehaviour.onDrag=this.OnDrag
        dragBehaviour.onPointerUp=this.OnPointerUp
        animator=tranGroup:GetComponent("Animator")
      
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            interCfg=vm.behaviour.Params[0]
            callBack=vm.behaviour.Params[1]
            isDragEnd=false;
            animator:Play("ani_NovelInteractionHuiPo_goline",0,0)
            SetActive(goBox1,true)
            SetActive(goBox2,false);
            SetActive(goline,true)
            tranDrag.anchoredPosition=Vector2(-427,-25);
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
end


this.OnBeginDrag=function(eventData)
    local locPos=RectTransformTool.ScreenToLocal(UnityEngine.Input.mousePosition, tranGroup,LuaMgr.UICamera());
    vector=tranDrag.anchoredPosition-locPos
end

this.OnDrag=function(eventData)
    if isDragEnd then return end;
    local locPos=RectTransformTool.ScreenToLocal(UnityEngine.Input.mousePosition, tranGroup,LuaMgr.UICamera());
    tranDrag.anchoredPosition=locPos+vector;
    if UnityEngine.Vector2.Distance(tranDrag.anchoredPosition,goHuiPo.transform.anchoredPosition)<=200 then
        isDragEnd=true;
        SetActive(goline,false)
        this.SetEndState();
    end
end


this.OnPointerUp=function(eventData)
  
end


this.SetEndState=function()
    animator:Play("ani_NovelInteractionHuiPo_jiaohu",0,0)
    coroutine_runner.start(function()
        coroutine_runner.wait(5)
        if callBack~=nil then
            callBack()
        end
        LuaMgr.HidePanel(UIName.NovelInteractionHuiPoViewModel)
    end)
end




return vm({
    data = data,
    command = command,
    hook = hook
})