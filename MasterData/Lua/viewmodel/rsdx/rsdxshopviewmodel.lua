





require("ViewModel/RSDX/RSDXShop_GoodItem")

local this = {
    vm = nil,
    shopUIList = {},
    shopItemObj = nil,
    cfgQin2Shop = {},
    dataQuests = {},
    activityKey = nil,
    activityShopText = nil,
};
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local good = nil;
local Middle = nil;
local Right = nil;
local Left = nil;
local canvasGroup = nil;
local tranCharacter = nil;
local tranMsg = nil;
local tranContent = nil;
local btnClick = nil;
local txtContent = nil;
local ScrollView = nil;
local ScrollbarVertical = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    good = uiLink:Get("good");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    canvasGroup = uiLink:Get("canvasGroup"):GetComponent("Canvas");
    tranCharacter = uiLink:Get("tranCharacter"):GetComponent("RectTransform");
    tranMsg = uiLink:Get("tranMsg"):GetComponent("RectTransform");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    txtContent = uiLink:Get("txtContent"):GetComponent("Text");
    txtContent = uiLink:Get("txtContent"):GetComponent("UIText");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    uiLink:AddClickEvent("btnClick", function()
                this.OnClickCharacter()
            end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    good = nil;
    Middle = nil;
    Right = nil;
    Left = nil;
    canvasGroup = nil;
    tranCharacter = nil;
    tranMsg = nil;
    tranContent = nil;
    btnClick = nil;
    txtContent = nil;
    txtContent = nil;
    ScrollView = nil;
    ScrollbarVertical = nil;

end




local data = {
    bodyPath = "",
}
local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour)
        this.shopItemObj = vm.behaviour.transform:Find("template/shopItem").gameObject;
        this.shopUIList = UIListView.New(tranContent);
        this.spineCharacter = vm.behaviour.transform:Find("root/Right/tranCharacter/box/Body"):GetComponent(
            "UISpineCharacter");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            this.ParseCfg();
            this.ParseData();
        end
        LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.shopUIList:Clear();
        LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime);
    end,
    before_destroy = function()
        this.Clear()
        if this.spineCharacter ~= nil then
            this.spineCharacter:Clear();
        end
        UIListView.ClearItem("RSDXShop_GoodItem")
    end
}

this.ParseCfg = function()
    this.activityShop = DataExHelper.Check_ConfigQuestEventByText("RSDXShop")
    this.characterId = "V0171";
    math.randomseed(LuaMgr.Timestamp());
end

this.OnClickCharacter = function()
    this.SetMsg();
    LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime);
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true);
end


this.SetMsg = function()
    local langNum = math.random(31101, 31105);
    txtContent.text = ConfigHelper.MsgReplacePlayerByName(ConfigMgr.LangGlobal(tostring(langNum)));
    local high=txtContent.preferredHeight+30
    high=high<130 and 130 or high;
    tranMsg.sizeDelta=Vector2(330,high);
end

this.ParseData = function()
    this.dataQuests = DataMgr.Player.quests;
    this.SetCharacter();
    this.SetShopList();
    tranContent.anchoredPosition = Vector2(0, 0);
    local rate = LuaMgr.ScreenWidth() / LuaMgr.ScreenHeight();
    if rate - (1280 / 720) <= 0.2 then
        ScrollView.transform.anchoredPosition = Vector2(28, -68);
        tranCharacter.anchoredPosition = Vector2(0, 8)
    else
        ScrollView.transform.anchoredPosition = Vector2(50, -68);
        tranCharacter.anchoredPosition = Vector2(-50, 8)
    end
end

this.SetCharacter = function()
    local skinId = "V0171001";
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, this.characterId, skinId);
    if path ~= "" then
        this.vm.data.bodyPath = path;
    end
end

this.SetShopList = function()
    local list = {}
    for i, v in ipairs(this.activityShop) do
        local shopItem = {
            id = v.id,
            sort = v.sort,
            award = v.showReward,
limitCount = v.progress < 9999 and v.progress - this.GetHasBuyCount(v.id) or v.progress,
            cost = v.cost,
            callBack = this.ShopCallBack,
        }
        shopItem.isSellOut = shopItem.limitCount == 0;
        local shopData = UIListData.GetData(this.shopItemObj, "RSDXShop_GoodItem", shopItem);
        table.insert(list, shopData);
    end
    table.sort(list, function(a, b)
        if not a.data.isSellOut and not b.data.isSellOut then
            return a.data.sort < b.data.sort;
        else
            return not a.data.isSellOut and b.data.isSellOut;
        end
    end)
    this.shopUIList:SetData(list);
end


this.GetHasBuyCount = function(id)
    if this.dataQuests[id] ~= nil then
        return this.dataQuests[id].progress
    end
    return 0;
end

this.ShopCallBack = function(questId)
    local curQuest = ConfigMgr.Config.questEvent[questId]
    if not DataExHelper.CommonActivityCheck(ActivityKey.RSDX) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return
    end

    local maxCount = curQuest.progress < 9999 and curQuest.progress - this.GetHasBuyCount(questId) or curQuest.progress;
    local myCount = DataHelper.GetItemCountById(curQuest.cost[1].id);
    local buyCount = math.floor(myCount / curQuest.cost[1].count);
    if curQuest.cost[1].count > 0 then
        maxCount = maxCount > buyCount and buyCount or maxCount;
    end
    LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel, curQuest.showReward[1], curQuest.cost, maxCount, function(count)
        DataExHelper.EX_ShopConvert(questId, count, function()
            this.dataQuests = DataMgr.Player.quests;
            this.SetShopList();
        end)
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})