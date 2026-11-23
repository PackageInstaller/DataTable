local this = {
    UISV = nil,
    nowSelectTagItem = nil,
    nowSelectTagIndex=nil,
    rewardItemList = {},
    selectNum = 0,
    nowPageRewardId = nil,
};

require("CollectorPractice/Common/UICollectorGuideTagItem")
require("CollectorPractice/Common/UICollectorGuideGoodsItem")
local tarGameObject = nil;
local tarRect = nil;
local UICollectorGuideGoodsItemPrefab = nil;
local UICollectorGuideTagItemPrefab = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goReward = nil;
local goStart1 = nil;
local goStart2 = nil;
local goStart3 = nil;
local Right = nil;
local btnArrowLeft = nil;
local btnArrowRight = nil;
local ScrollView = nil;
local rectContent = nil;
local rawImagePageLeft = nil;
local rawImagePageRight = nil;
local rectReward = nil;
local goViewport=nil;
local goBtnReward = nil;
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorGuideGoodsItemPrefab = uiLink:Get("UICollectorGuideGoodsItem");
    UICollectorGuideTagItemPrefab = uiLink:Get("UICollectorGuideTagItem");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goReward = uiLink:Get("goReward");
    rectReward = uiLink:Get("goReward"):GetComponent("RectTransform");
    goStart1 = uiLink:Get("goStart1");
    goStart2 = uiLink:Get("goStart2");
    goStart3 = uiLink:Get("goStart3");
    Right = uiLink:Get("Right");
    btnArrowLeft = uiLink:Get("btnArrowLeft"):GetComponent("Button");
    btnArrowRight = uiLink:Get("btnArrowRight"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    rawImagePageLeft = uiLink:Get("rawImagePageLeft"):GetComponent("RawImage");
    rawImagePageRight = uiLink:Get("rawImagePageRight"):GetComponent("RawImage");
    goBtnReward = uiLink:Get("btnGetReward");
    goViewport=uiLink:Get("goViewport");
    uiLink:AddClickEvent("btnClose", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeGuideViewModel);
    end)
    uiLink:AddClickEvent("btnArrowLeft", function()
        this.ChangePage(this.selectNum-1);
    end)
    uiLink:AddClickEvent("btnArrowRight", function()
        this.ChangePage(this.selectNum+1);
    end)
    uiLink:AddClickEvent("btnGetReward", function()
        this.GetReward();
    end)
end


this.Clear = function()
    goBtnReward=nil;
    tarGameObject = nil
    goViewport=nil;
    tarRect = nil
    rectReward = nil;
    UICollectorGuideGoodsItemPrefab = nil;
    UICollectorGuideTagItemPrefab = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goReward = nil;
    goStart1 = nil;
    goStart2 = nil;
    goStart3 = nil;
    Right = nil;
    btnArrowLeft = nil;
    btnArrowRight = nil;
    ScrollView = nil;
    rectContent = nil;
    rawImagePageLeft = nil;
    rawImagePageRight = nil;
end


this.InitData = function()
end

this.InitPanel = function()
    this.InitTag();

    for index, value in ipairs(this.UISV.screenList) do
        if value.data.groupIndex==1 then
            this.nowSelectTagItem=value;
            this.nowSelectTagIndex=1;
            break;
        end
    end

    this.SelectTagHelper(this.nowSelectTagItem);

end
this.InitTag = function()
    local scrollDatas = {}
    local scrollData = nil;
local mapType = "MapA";
    local data = CollectorPracticeMgr.GuideData[mapType];
    for i = 1, #data, 1 do
        local temp = {};








        temp.isSelect = false;
        temp.groupIndex = i;
        temp.groupNameLan = data[i][1].GroupNameLan;
        temp.haveReward = CollectorPracticeMgr.CheckHaveReward(i);
        temp.fun = this.SelectTagHelper;
        scrollData = UIScrollData.GetData(UICollectorGuideTagItemPrefab, "UICollectorGuideTagItem", 288, 96, temp)
        table.insert(scrollDatas, scrollData)
    end
    this.UISV:SetParams(288, 563.1577)
    this.UISV:SetData(scrollDatas, false);
    this.UISV:Refresh();
    goViewport:GetComponent("UiParticleRectMask"):Refresh();
end

this.SelectTagHelper = function(item)
    if this.nowSelectTagItem~=nil then
        this.nowSelectTagItem:SetSelect(false);
this.UISV.dataList[this.nowSelectTagIndex].data.isSelect=false;
    end
    this.nowSelectTagIndex=item.data.groupIndex;
    this.nowSelectTagItem = item;
    this.nowSelectTagItem:SetSelect(true);
    this.SelectTag(this.nowSelectTagItem.data.groupIndex)
end

this.ChangePage=function (pageNum)
    this.selectNum=pageNum;
    this.InitPage(this.nowSelectTagItem.data.groupIndex,this.selectNum)
end

this.SelectTag = function(groupIndex)
    this.selectNum = 1;
    this.InitPage(groupIndex,this.selectNum);
end

this.RefreshRewardTips = function()
    this.nowSelectTagItem:SetHaveReward(CollectorPracticeMgr.CheckHaveReward(this.nowSelectTagItem.data.groupIndex))
    this.InitReward(this.nowSelectTagItem.data.groupIndex,this.selectNum);
end


this.InitPage = function(groupIndex, pageNum)
    local leftPage = pageNum * 2 - 1;
    local rightPage = pageNum * 2;
local mapType = "MapA";
    local data = CollectorPracticeMgr.GuideData[mapType];
    rawImagePageLeft.texture = LuaMgr.GetTexture(string.format("Images/CollectorGuide/%s.png",
    data[groupIndex][leftPage].PicId));
    if data[groupIndex][rightPage] ~= nil then
        SetActive(rawImagePageRight.gameObject, true);
        rawImagePageRight.texture = LuaMgr.GetTexture(string.format("Images/CollectorGuide/%s.png",
        data[groupIndex][rightPage].PicId));
    else
        SetActive(rawImagePageRight.gameObject, false);
    end
    local allPage = (#data[groupIndex] + 1) // 2;
    SetActive(btnArrowLeft.gameObject, not (pageNum <= 1))
    SetActive(btnArrowRight.gameObject, not (pageNum >= allPage))
    this.InitReward(groupIndex,pageNum)
end

this.InitReward = function(groupIndex, pageNum)
    local rewardItemDataList = {};
    local leftPage = pageNum * 2 - 1;
    local rightPage = pageNum * 2;
local rightPageData = CollectorPracticeMgr.GuideData["MapA"][groupIndex][rightPage];
local leftPageData = CollectorPracticeMgr.GuideData["MapA"][groupIndex][leftPage];
    if not IsNull(leftPageData.Reward) then
        for index, value in ipairs(leftPageData.Reward) do
            table.insert(rewardItemDataList, value);
        end
this.nowPageRewardId = leftPageData.ID;
    end
    if rightPageData ~= nil and(not IsNull(rightPageData.Reward)) then
        for index, value in ipairs(rightPageData.Reward) do
            table.insert(rewardItemDataList, value);
        end
this.nowPageRewardId = rightPageData.ID;
    end
if TableIsNull(rewardItemDataList) then
        SetActive(goReward, false);
        return;
else

if DataMgr.Player.practices.guideRewards[this.nowPageRewardId] == nil then
            SetActive(goReward, true);
            SetActive(goStart1, false);
            SetActive(goStart2, false);
            SetActive(goStart3, false);
            SetActive(goBtnReward,false);
elseif DataMgr.Player.practices.guideRewards[this.nowPageRewardId] == 0 then
            SetActive(goReward, true);
            SetActive(goStart1, true);
            SetActive(goStart2, true);
            SetActive(goStart3, true);
            SetActive(goBtnReward,true);
elseif DataMgr.Player.practices.guideRewards[this.nowPageRewardId] == 1 then
            SetActive(goReward, false);
        end

        for i = 1, #rewardItemDataList, 1 do
            if i <= #this.rewardItemList then
                this.rewardItemList[i]:SetData(rewardItemDataList[i].id, rewardItemDataList[i].count)
            else
                local temp = UICollectorGuideGoodsItem.New(UICollectorGuideGoodsItemPrefab, rectReward);
                table.insert(this.rewardItemList, temp);
                this.rewardItemList[i]:SetData(rewardItemDataList[i].id, rewardItemDataList[i].count)
            end
        end
for i = #rewardItemDataList + 1, #this.rewardItemList, 1 do
            this.rewardItemList[i]:Hide();
        end

    end
    goBtnReward:GetComponent("RectTransform"):SetAsLastSibling();
end

this.GetReward=function ()
local data = { Id = this.nowPageRewardId, ThemeId ="MapA" }
    local Url = "practice/guide_get_reward"
    ApiMgr.Request(Url, data, true,
    function(result)
        local resultData = json.decode(result)
        if not IsNull(resultData.result.Items) then
            local items = {};
            local reward = resultData.result.Items
            for i, v in pairs(reward) do
                local item = { ID = v.id, Count = v.count }
                table.insert(items, item);
            end

            LuaMgr.ShowItemGetPanel(items);
            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshGuideState);
            this.RefreshRewardTips();
           
        end
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        this.InitData();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.UISV = UIScrollView.New(ScrollView.gameObject);
        this.InitPanel();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.UISV:Clear(true);
        end
    end,
    before_destroy = function(vm)
        for i = 1, #this.rewardItemList, 1 do
            this.rewardItemList[i]:Destroy();
        end
        UIScrollView.ClearItem("UICollectorGuideTagItem")
        this.Clear();
    end,
}

return vm({
    hook = hook
})