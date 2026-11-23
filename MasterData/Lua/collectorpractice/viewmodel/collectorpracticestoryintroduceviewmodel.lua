

local this = {};
require("CollectorPractice/Common/UICollectorEventOptionItem")
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local UICollectorEventOptionItemPrefab = nil;
local textTitle = nil;
local textIntroduce = nil;
local ScrollView = nil;
local rectContent=nil;

local textList = {};
local optionList = {};

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    UICollectorEventOptionItemPrefab = uiLink:Get("UICollectorEventOptionItem");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    textIntroduce = uiLink:Get("textIntroduce"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("goContent"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnBGMask", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeStoryIntroduceViewModel)
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    UICollectorEventOptionItemPrefab = nil;
    textTitle = nil;
    textIntroduce = nil;
    ScrollView = nil;
    rectContent = nil;
    textList = {};
    optionList = {};
end









local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local data = vm.behaviour.Params[0];
        local eventStoryMap = ConfigMgr.Config.EventStoryMap;
        local eventOptionMap = ConfigMgr.Config.EventOptionMap;
        textTitle.text = LuaMgr.GetLangText(eventStoryMap[data.storyShow[1]].EventTitleLan)
        textIntroduce.text = LuaMgr.GetLangText(eventStoryMap[data.storyShow[1]].EventDesLan)
        for i = 1, #data.optionShow, 1 do
            if i > #optionList then
                local tempOption = UICollectorEventOptionItem.New(UICollectorEventOptionItemPrefab, rectContent);
                table.insert(optionList, tempOption);
                local tempText = LuaMgr.InstantiateGO(textIntroduce.gameObject, rectContent, false)
                table.insert(textList, tempText:GetComponent("Text"));
            end

            optionList[i]:SetData(data.questID,
                false,
                eventOptionMap[data.optionShow[i]].OptionRoll ~= "",
                LuaMgr.GetLangText(eventOptionMap[data.optionShow[i]].OptionDesLan),
                LuaMgr.GetLangText(eventOptionMap[data.optionShow[i]].OptionDes2Lan),
                nil
            );
            SetActive(textList[i].gameObject, true)
            textList[i].text = LuaMgr.GetLangText(eventStoryMap[data.storyShow[i + 1]].EventDesLan)
        end
        for i = #data.optionShow + 1, #optionList, 1 do
            SetActive(textList[i].gameObject, false);
            optionList[i]:Hide();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
        end
    end,
    before_destroy = function(vm)
        for i = 1, #optionList, 1 do
            optionList[i]:Destroy();
            LuaMgr.DestroyImmediateGO(textList[i].gameObject);
        end
        this.Clear();
    end,
}

return vm({
    hook = hook
})