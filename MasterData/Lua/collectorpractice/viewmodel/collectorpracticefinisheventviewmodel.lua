local this = {};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local goContent = nil;
local ScrollView = nil;
local btnClose = nil;
local goUICardsAnimator=nil;
local goIntroduceImage=nil;

local nowCard = {}
require("CollectorPractice/Common/UICollectorCardItem")
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goContent = uiLink:Get("goContent");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollView");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    goUICardsAnimator=uiLink:Get("goUICardsAnimator")
    goIntroduceImage=uiLink:Get("goIntroduceImage")
    uiLink:AddClickEvent("btnClose", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeFinishEventViewModel)
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    goContent = nil;
    ScrollView = nil;
    btnClose = nil;
    goUICardsAnimator=nil;

end


local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            local themId = vm.behaviour.Params[0];
            local eventType = vm.behaviour.Params[1];
local isFinishEvent = vm.behaviour.Params[2];
local nowRefrestTime = vm.behaviour.Params[3];
            for key, value in pairs(ConfigMgr.Config.RelicsMap) do
                if DataMgr.Player.relics ~= nil and DataMgr.Player.relics[value.RelicsId] ~= nil and DataMgr.Player.relics[value.RelicsId].Time >= nowRefrestTime then
                    local temp = UICollectorCardItem.New(goContent:GetComponent("RectTransform"), Vector3(1, 1, 1))
                    local data = table.Copy(value);
                    data.Achieve = true;
                    temp:SetData(data);
                    table.insert(nowCard, temp);
                end
            end

            goContent:GetComponent("RectTransform").sizeDelta = Vector2(
                180 * #nowCard + (#nowCard - 1) * 20 < LuaMgr.GetScreenWidth() and LuaMgr.GetScreenWidth() or
                180 * #nowCard + (#nowCard - 1) * 20, 300)
            if isFinishEvent then
local co = coroutine_runner.start(function()
                    SetActive(goContent,false);
                    SetActive(goIntroduceImage,false)
                    SetActive(btnClose.gameObject,false);
                    SetActive(goUICardsAnimator,true);
                    coroutine_runner.wait(2)
                    SetActive(goUICardsAnimator,false);
                    SetActive(goIntroduceImage,true)
                    SetActive(goContent,true);
                    SetActive(btnClose.gameObject,true);
                    root:GetComponent("Animator").enabled = true;
                    for index, value in ipairs(nowCard) do
                        value:ShowGetCardItemAnim();
                    end
                end)
            else
                SetActive(goUICardsAnimator,false);
                SetActive(goIntroduceImage,true)
                SetActive(goContent,true);
                SetActive(btnClose.gameObject,true);
                for index, value in ipairs(nowCard) do
                    value:ShowGetCardItemAnim();
                end
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorRandomRewardRefush);
            for key, value in pairs(nowCard) do
                value:Destroy();
            end
            nowCard = {}
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    hook = hook
})