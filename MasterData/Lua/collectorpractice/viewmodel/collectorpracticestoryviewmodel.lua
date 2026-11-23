

local this = {};
require("CollectorPractice/Common/UICollectorStoryPaperItem")
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local rectUIPaper1 = nil;
local rectUIPaper2 = nil;
local rectUIPaper3 = nil;
local rectUIPaper4 = nil;
local rectUIPaper5 = nil;
local rawImageCharacter = nil;
local CHARACTERPATH="Assets/_BundleResources/Character/%s/Drawing/%s.png";
local paperList={};
local rectPaperList={};
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    rectUIPaper1 = uiLink:Get("rectUIPaper1"):GetComponent("RectTransform");
    rectUIPaper2 = uiLink:Get("rectUIPaper2"):GetComponent("RectTransform");
    rectUIPaper3 = uiLink:Get("rectUIPaper3"):GetComponent("RectTransform");
    rectUIPaper4 = uiLink:Get("rectUIPaper4"):GetComponent("RectTransform");
    rectUIPaper5 = uiLink:Get("rectUIPaper5"):GetComponent("RectTransform");
    rawImageCharacter = uiLink:Get("rawImageCharacter"):GetComponent("RawImage");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    rectUIPaper1 = nil;
    rectUIPaper2 = nil;
    rectUIPaper3 = nil;
    rectUIPaper4 = nil;
    rectUIPaper5 = nil;
    rawImageCharacter = nil;
end
















local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeStoryViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local data=vm.behaviour.Params[0];
        rawImageCharacter.texture=LuaMgr.GetTexture(string.format(CHARACTERPATH,string.sub(data.characterID,1,5),tostring(data.characterID)));
        table.insert(rectPaperList,rectUIPaper1);
        table.insert(rectPaperList,rectUIPaper2);
        table.insert(rectPaperList,rectUIPaper3);
        table.insert(rectPaperList,rectUIPaper4);
        table.insert(rectPaperList,rectUIPaper5);
        local typeList={};
        table.insert(typeList,1)
        table.insert(typeList,1)
        table.insert(typeList,2)
        table.insert(typeList,1)
        table.insert(typeList,3)



        for i = 1, #data.questList, 1 do
            if i<=#paperList then
                paperList[i]:SetData(data.questList[i],typeList[i])
            else
                local temp=UICollectorStoryPaperItem.New(rectPaperList[i]);
                table.insert(paperList,temp);
                paperList[i]:SetData(data.questList[i],typeList[i],data.questType)
            end
        end
        for i = #data.questList+1, #paperList, 1 do
            paperList[i]:Hide();
        end

    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then

        end
    end,
    before_destroy = function(vm)
        this.Clear();
        for i = 1, #paperList, 1 do
            paperList[i]:Destroy();
        end
    end,
}

return vm({
    hook = hook
})