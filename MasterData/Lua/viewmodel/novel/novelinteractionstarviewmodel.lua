local this = { vm = nil };
local callBack = nil;
local interCfg = nil;


local tarGameObject = nil;
local tarRect = nil;
local animatorRun = nil;
local goXingxing01 = nil;
local goXingxing02 = nil;
local goXingxing03 = nil;
local goXingxingClick01 = nil;
local goXingxingClick02 = nil;
local goXingxingClick03 = nil;
local btnPoint01 = nil;
local btnPoint02 = nil;
local btnPoint03 = nil;
local gofirst = nil;
local gobg = nil;
local coKey = nil;



this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    animatorRun = uiLink:Get("animatorRun"):GetComponent("Animator");
    goXingxing01 = uiLink:Get("goXingxing01");
    goXingxing02 = uiLink:Get("goXingxing02");
    goXingxing03 = uiLink:Get("goXingxing03");
    goXingxingClick01 = uiLink:Get("goxingxingClick01");
    goXingxingClick02 = uiLink:Get("goxingxingClick02");
    goXingxingClick03 = uiLink:Get("goxingxingClick03");
    gofirst = uiLink:Get("gofirst");
    gobg = uiLink:Get("gobg");
    btnPoint01 = uiLink:Get("btnPoint1"):GetComponent("Button");
    btnPoint02 = uiLink:Get("btnPoint2"):GetComponent("Button");
    btnPoint03 = uiLink:Get("btnPoint3"):GetComponent("Button");
    uiLink:AddClickEvent("btnPoint1", this.BtnClick_Excute01)
    uiLink:AddClickEvent("btnPoint2", this.BtnClick_Excute02)
    uiLink:AddClickEvent("btnPoint3", this.BtnClick_Excute03)
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    animatorRun = nil;
    goXingxing01 = nil;
    goXingxing02 = nil;
    goXingxing03 = nil;
    goXingxingClick01 = nil;
    goXingxingClick02 = nil;
    goXingxingClick03 = nil;
    btnPoint01 = nil;
    btnPoint02 = nil;
    btnPoint03 = nil;
end

this.BtnClick_Excute01 = function()
    btnPoint01.enabled = false
    SetActive(gofirst, true);
    SetActive(gobg, true);
    SetActive(goXingxingClick01, true);
    if coKey ~= nil then
        coroutine_runner.stop(coKey);
    end
    coKey = coroutine_runner.start(function()
        coroutine_runner.wait(0.02)
        animatorRun.enabled = false
        animatorRun.enabled = true
        animatorRun:Rebind();
        animatorRun:Play("ani_NovelInteractionStar_001")
        coroutine_runner.wait(1)
        btnPoint02.enabled = true
        SetActive(goXingxing02, true);
    end)
end

this.BtnClick_Excute02 = function()
    btnPoint02.enabled = false
    animatorRun:Play("ani_NovelInteractionStar_002")
    SetActive(goXingxingClick02, true);
    if coKey ~= nil then
        coroutine_runner.stop(coKey);
    end
    coKey = coroutine_runner.start(function()
        coroutine_runner.wait(1)
        btnPoint03.enabled = true
        SetActive(goXingxing03, true);
    end)
end

this.BtnClick_Excute03 = function()
    btnPoint03.enabled = false
    animatorRun:Play("ani_NovelInteractionStar_003")
    SetActive(goXingxingClick03, true);
    if coKey ~= nil then
        coroutine_runner.stop(coKey);
    end
    coKey = coroutine_runner.start(function()
        coroutine_runner.wait(3)
        LuaMgr.HidePanel(UIName.NovelInteractionStarViewModel)
    end)
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            interCfg = vm.behaviour.Params[0]
            callBack = vm.behaviour.Params[1]
            btnPoint01.enabled = true;
            btnPoint02.enabled = false;
            btnPoint03.enabled = false;
            SetActive(gofirst, false);
            SetActive(gobg, false);
            SetActive(goXingxing01, true);
            SetActive(goXingxing02, false);
            SetActive(goXingxing03, false);
            SetActive(goXingxingClick01, false);
            SetActive(goXingxingClick02, false);
            SetActive(goXingxingClick03, false);
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        if callBack ~= nil then
            callBack();
        end
        if coKey ~= nil then
            coroutine_runner.stop(coKey);
        end
    end,
    before_destroy = function()
        this.Clear()
    end
}


return vm({
    data = nil,
    command = nil,
    hook = hook
})