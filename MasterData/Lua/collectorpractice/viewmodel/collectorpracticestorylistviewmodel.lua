

local this = {};

local tarGameObject = nil;
local tarRect = nil;
local UICollectorStoryOptionItemPrefab = nil;
local root = nil;
local Middle = nil;
local ScrollView = nil;
local rectContent=nil;
require("CollectorPractice/Common/UICollectorStoryOptionItem")
local storyOptionList={};
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorStoryOptionItemPrefab = uiLink:Get("UICollectorStoryOptionItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent=uiLink:Get("rectContent"):GetComponent("RectTransform")
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UICollectorStoryOptionItemPrefab = nil;
    root = nil;
    Middle = nil;
    ScrollView = nil;
    rectContent=nil;
end


local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeStoryListViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
ScrollView.gameObject:GetComponent("RectTransform").sizeDelta=Vector2(LuaMgr.GetScreenAddWidth()+1280,508);
local mapType="MapA";
        local data=CollectorPracticeMgr.StoryData[mapType];
        for i = 1, #data, 1 do
            if i<=#storyOptionList then
                storyOptionList[i]:SetData(data[i],mapType)
            else
                local temp=UICollectorStoryOptionItem.New(UICollectorStoryOptionItemPrefab,rectContent);
                table.insert(storyOptionList,temp);
                storyOptionList[i]:SetData(data[i],mapType)
            end
        end

for i = 1, #storyOptionList, 1 do
            storyOptionList[i]:Hide();
        end
local co = coroutine_runner.start(function()
for i = 1, #data, 1 do
                coroutine_runner.wait(0.05)
                storyOptionList[i]:ShowAnimation();
            end
        end)

        HeroRedDataHelper.RefreshCollectorPracticeStoryRed();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            
        end
    end,
    before_destroy = function(vm)
        this.Clear();
        for i = 1, #storyOptionList, 1 do
            storyOptionList[i]:Destroy();
        end
    end,
}

return vm({
    hook = hook
})