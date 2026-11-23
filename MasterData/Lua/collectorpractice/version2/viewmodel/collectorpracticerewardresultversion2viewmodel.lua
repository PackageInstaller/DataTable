require("CollectorPractice/Version2/Common/UIRewardResultGoodItem")
require("CollectorPractice/Version2/Common/UIRewardResultCharacterItem")
require("CollectorPractice/Version2/Common/UIRewardResultBuffItem")
local tarGameObject = nil;
local tarRect = nil;
local UIRewardResultGoodItemPrefab = nil;
local UIRewardResultCharacterItemPrefab = nil;
local UIRewardResultBuffItemPrefab = nil;
local root = nil;
local Middle = nil;
local LeftGroup = nil;
local goVictorTitleImage = nil;
local goFailTitleImage = nil;
local rawImageSCJ = nil;
local ScrollViewReward = nil;
local ScrollViewCharacter = nil;
local ScrollViewBuff = nil;
local rectRewardContent = nil;
local rectCharacterContent = nil;
local rectBuffContent = nil;
local textScore = nil;
local btnFinish = nil;
local animator=nil;
local this = {
    data=nil,
    goodsItemList={},
    characterItemList={},
    buffItemList={},
};




this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UIRewardResultGoodItemPrefab = uiLink:Get("UIRewardResultGoodItem");
    UIRewardResultCharacterItemPrefab = uiLink:Get("UIRewardResultCharacterItem");
    UIRewardResultBuffItemPrefab = uiLink:Get("UIRewardResultBuffItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    LeftGroup = uiLink:Get("LeftGroup");
    goVictorTitleImage = uiLink:Get("goVictorTitleImage");
    goFailTitleImage = uiLink:Get("goFailTitleImage");
    rawImageSCJ = uiLink:Get("rawImageSCJ"):GetComponent("RawImage");
    ScrollViewReward = uiLink:Get("ScrollViewReward"):GetComponent("ScrollRect");
    ScrollViewCharacter = uiLink:Get("ScrollViewCharacter"):GetComponent("ScrollRect");
    ScrollViewBuff = uiLink:Get("ScrollViewBuff"):GetComponent("ScrollRect");
    rectRewardContent = uiLink:Get("rectRewardContent"):GetComponent("RectTransform");
    rectCharacterContent = uiLink:Get("rectCharacterContent"):GetComponent("RectTransform");
    rectBuffContent = uiLink:Get("rectBuffContent"):GetComponent("RectTransform");
    textScore = uiLink:Get("textScore"):GetComponent("Text");
    btnFinish = uiLink:Get("btnFinish"):GetComponent("Button");
    animator=root:GetComponent("Animator");
    uiLink:AddClickEvent("btnFinish", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeRewardResultVersion2ViewModel);
        LuaMgr.Back();
    end);
end


this.Clear = function()
    for index, value in ipairs(this.buffItemList) do
        value:Destroy();
    end
    for index, value in ipairs(this.goodsItemList) do
        value:Destroy();
    end
    for index, value in ipairs(this.characterItemList) do
        value:Destroy();
    end
    tarGameObject = nil
    tarRect = nil
    UIRewardResultGoodItemPrefab = nil;
    UIRewardResultCharacterItemPrefab = nil;
    UIRewardResultBuffItemPrefab = nil;
    root = nil;
    Middle = nil;
    LeftGroup = nil;
    goVictorTitleImage = nil;
    goFailTitleImage = nil;
    rawImageSCJ = nil;
    ScrollViewReward = nil;
    ScrollViewCharacter = nil;
    ScrollViewBuff = nil;
    rectRewardContent = nil;
    rectCharacterContent = nil;
    rectBuffContent = nil;
    textScore = nil;
    btnFinish = nil;
    animator=nil;
    this=nil;
end

this.InitData=function (data)
    this.data=data;
end

this.InitPanel=function ()
    if this.data.isWin then
        SetActive(goVictorTitleImage,true);
        SetActive(goFailTitleImage,false);
        animator:Play("UI_CollectorPracticeRewardResultVersion2Panel_success",0,0);
    else
        SetActive(goVictorTitleImage,false);
        SetActive(goFailTitleImage,true);
        animator:Play("UI_CollectorPracticeRewardResultVersion2Panel_fail",0,0);
    end
    textScore.text=tostring(this.data.score);
    if DataMgr.Player.sex == 1 then
        rawImageSCJ.texture=LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Drawing/%s.png", "SCJ201", "SCJ201001"));
    else
        rawImageSCJ.texture=LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Drawing/%s.png", "SCJ202", "SCJ202001"));
    end
    this.RefreshRewardGoodsItem();
    this.RefreshCharacterItem();
    this.RefreshBuffItem();


end
this.RefreshRewardGoodsItem=function ()
    local showData=this.data.tools;
    local itemConfig=ConfigMgr.Config.itemMap
    local itemCount={};

    if not IsNull(showData) then 
        for key, value in pairs(showData) do
            if itemCount[key]==nil then
                itemCount[key]=0;
            end
            itemCount[key]=itemCount[key]+value;
        end
    end

local showItemId={"27"}
    for i = 1, 1, 1 do
        if i > #this.goodsItemList then
            local temp = UIRewardResultGoodItem.New(UIRewardResultGoodItemPrefab,rectRewardContent);
            table.insert(this.goodsItemList, temp);
        end
        this.goodsItemList[i]:SetData(showItemId[i],itemCount[showItemId[i]]==nil and 0 or itemCount[showItemId[i]]);
    end
    for i = 5, #this.goodsItemList, 1 do
        this.goodsItemList[i]:Hide();
    end
end

this.RefreshCharacterItem=function ()
    local showData=this.data.heroIdList;
    for i = 1, #showData, 1 do
        if i > #this.characterItemList then
            local temp = UIRewardResultCharacterItem.New(UIRewardResultCharacterItemPrefab,rectCharacterContent);
            table.insert(this.characterItemList, temp);
        end
        this.characterItemList[i]:SetData(showData[i]);
    end
    for i = #showData + 1, #this.characterItemList, 1 do
        this.characterItemList[i]:Hide();
    end
end

this.RefreshBuffItem=function ()
    local showData=this.data.showBuffIdList;
    for i = 1, #showData, 1 do
        if i > #this.buffItemList then
            local temp = UIRewardResultBuffItem.New(UIRewardResultBuffItemPrefab,rectBuffContent);
            table.insert(this.buffItemList, temp);
        end
        this.buffItemList[i]:SetData(showData[i].showBuffId,showData[i].showbuffCount);
    end
    for i = #showData + 1, #this.buffItemList, 1 do
        this.buffItemList[i]:Hide();
    end
end

this.ShowOtherReward=function ()
    local showData=this.data.goodsItem;
    local items={};
	if IsNull(showData) then
		return;
	end
    for i, v in pairs(showData) do
        local item = { ID = v.id, Count = v.count }
        table.insert(items, item);
    end
    LuaMgr.ShowItemGetPanel(items);
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitData(vm.behaviour.Params[0]);
        this.InitPanel();
        this.ShowOtherReward();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
        end
    end,
    before_destroy = function(vm)

    end,
}

return vm({
    hook = hook
})