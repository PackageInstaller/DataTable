

local this = {};
require("CollectorPractice/Common/UICollectorStoryPaperItem")
require("CollectorPractice/Common/UICollectorStoryPaperGroupItem")
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local UICollectorStoryPaperGroupItemPrefab = nil;
local rectContent = nil;
local ScrollView = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    UICollectorStoryPaperGroupItemPrefab = uiLink:Get("UICollectorStoryPaperGroupItem");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    UICollectorStoryPaperGroupItemPrefab = nil;
    rectContent = nil;
    ScrollView = nil;
end

this.RefreshComplete=function (index,groupIndex)
    CollectorPracticeMgr.RefushStoryData("MapA");
    if groupIndex==1 then
        this.SV.dataList[index].data.data.paper1.complete=true;
    elseif groupIndex==2 then
        this.SV.dataList[index].data.data.paper2.complete=true;
    end
    this.SV:Refresh()
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        this.SV = UIScrollView.New(ScrollView.gameObject);
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeStorySpecialListViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local data = vm.behaviour.Params[0];

































        local finishData = {};
        local index = 1;
        for i = 1, #data.questList, 2 do
            local temp = {};
            temp.index = index
            temp.questType=data.questType;
            temp.paper1 = data.questList[i];
            temp.paper2 = data.questList[i + 1];
            table.insert(finishData, temp);
            index=index+1;
        end
        this.SVdata = {};
        for i = 1, #finishData do
            this.SVdata[i] = { type = 0, data = finishData[i], callback = this.RefreshComplete, onClick = nil, select = false };
        end
        this.SV:Clear(false);
        local scrollData;
        local scrollDatas = {};
        local addWidth = LuaMgr.GetScreenAddWidth();
        this.scrollWidth = 1280 + addWidth;
        local len = #this.SVdata;
        for i = 1, len do
            scrollData = UIScrollData.GetData(UICollectorStoryPaperGroupItemPrefab, "UICollectorStoryPaperGroupItem", 270,
                610, this.SVdata[i]);
            table.insert(scrollDatas, scrollData);
        end
        this.SV:SetParams(this.scrollWidth, 610);
        this.SV:SetData(scrollDatas);
        HeroRedDataHelper.RefreshCollectorPracticeStoryRed();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.SV:Clear(true);
        end
    end,
    before_destroy = function(vm)
        this.Clear();
        UIScrollView.ClearItem("UICollectorStoryPaperGroupItem");
    end,
}

return vm({
    hook = hook
})