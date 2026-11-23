




local this = {vm=nil};
local data={}
local command={}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local tranWin = nil;
local tranLoser = nil;
local animator = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    tranWin = uiLink:Get("tranWin"):GetComponent("RectTransform");
    tranLoser = uiLink:Get("tranLoser"):GetComponent("RectTransform");
    animator = root:GetComponent("UIAnimator");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    tranWin = nil;
    tranLoser = nil;
    animator = nil;
end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            local result=vm.behaviour.Params[0];
            this.ParseData(result);
        end
    end,
    before_deactive = function(vm)
    end,
    before_destroy=function()
        this.Clear()
    end
}

this.ParseData=function(isWin)
    SetActive(tranWin.gameObject,isWin)
    SetActive(tranLoser.gameObject,not isWin);
    if (isWin) then
        animator.AnimationName = "ani_BattleDelegateResult_root";
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})