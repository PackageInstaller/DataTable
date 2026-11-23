require("CollectorPractice/Common/UICollectorChipItem")

local this = {}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local ScrollView = nil;
local rectContent = nil;
local closefun = nil;
local shipItems = {};

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");

    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");

    uiLink:AddClickEvent("btnClose", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeChipItemsVersion2ViewModel)
    end)
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    ScrollView = nil;
    rectContent = nil;

    for i = 1, #shipItems do
        shipItems[i]:Destroy();
    end

    shipItems = nil;
end

this.OpenChipEffect = function()
    for index, value in ipairs(shipItems) do
        value:SetEffect(true);
    end
end

this.CloseChipEffect = function()
    for index, value in ipairs(shipItems) do
        value:SetEffect(false);
    end
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            local rewardIds=vm.behaviour.Params[0];
            closefun = vm.behaviour.Params[1]
            local allChipCount = #rewardIds;
            local trueChipCount=0;
            local chipIndex = 1;
            for i = 1, allChipCount do
                local itemData = ConfigMgr.Config.itemMap[rewardIds[i].ID]
                    for j = 1, rewardIds[i].Count, 1 do
                        if chipIndex > #shipItems then
                            table.insert(shipItems, UICollectorChipItem.New(rectContent))
                        end
                        SetActive(shipItems[chipIndex].gameObject, true)
                        shipItems[chipIndex]:SetData2(rewardIds[i], true);
                        chipIndex = chipIndex + 1;
                        trueChipCount=trueChipCount+1;
                    end
            end
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedOpenEffect, this.OpenChipEffect);
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedCloseEffect, this.CloseChipEffect);
            LuaMgr.AddUIEventListener(UIEventConst.NeedOpenEffect, this.OpenChipEffect);
            LuaMgr.AddUIEventListener(UIEventConst.NeedCloseEffect, this.CloseChipEffect);
            for i = chipIndex, #shipItems do
                shipItems[i]:Clear();
            end

            ScrollView:GetComponent("RectTransform").sizeDelta = Vector2(
                (100 * trueChipCount + (trueChipCount - 1) * 42.65) > (LuaMgr.GetScreenAddWidth() + 1280) / 1.3
                and (LuaMgr.GetScreenAddWidth() + 1280) / 1.3
                or 100 * trueChipCount + (trueChipCount - 1) * 42.65
                , 200)

            rectContent.sizeDelta = Vector2(
                (100 * trueChipCount + (trueChipCount - 1) * 42.65), 200)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if closefun ~= nil then
                closefun();
                closefun = nil;
            end
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedOpenEffect, this.OpenChipEffect);
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedCloseEffect, this.CloseChipEffect);
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}
return vm({
    hook = hook
})