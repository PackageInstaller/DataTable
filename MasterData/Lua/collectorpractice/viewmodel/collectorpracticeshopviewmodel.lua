require("CollectorPractice/Common/UIShopTagPropItem")
require("CollectorPractice/Common/UIPracticeShopItem")
require("CollectorPractice/Common/UIPracticeShopGroupItem")
require("CollectorPractice/Common/UIShopSmallTagPropItem")
local tarGameObject = nil;
local tarRect = nil;
local UIShopTagPropItemPrefab = nil;
local UIPracticeShopItemPrefab = nil;
local UIPracticeShopGroupItemPrefab = nil;
local UIShopSmallTagPropItemPrefab = nil;
local root = nil;
local root = nil;
local Middle = nil;
local ScrollView = nil;
local rectConstant = nil;
local rectTagConstant = nil;
local rectSmallTagList = nil;
local rawImageBody = nil;
local goCharacterMsgItem = nil;
local textContent = nil;
local goBgsRight = nil;
local this = {
shopIdToMapId = {
        ["internShop1"] = "MapA",
        ["internShop2"] = "MapB",
    },
MapIdToshopId = {
        ["MapA"] = "internShop1",
        ["MapB"] = "internShop2",
    },
    rtItem = nil,
    modelGo = nil,
    nowRandomIndex = 0,
    globalLanIdList = {
        "7163", "7164", "7165"
    },
    globalLanIdToTragger = {
        ["7161"] = "happy2",
        ["7162"] = "happy2",
        ["7163"] = "happy",
        ["7164"] = "normal",
        ["7165"] = "nervous",
    },
    idleTime=nil,
    isShowText = false,





















    shopData = {},
    tabList = {},
    smallTabList = {},
    UISV = nil,
groupToIndex = {}
}
local groupToIndex = {}
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UIShopTagPropItemPrefab = uiLink:Get("UIShopTagPropItem");
    UIPracticeShopItemPrefab = uiLink:Get("UIPracticeShopItem");
    UIPracticeShopGroupItemPrefab = uiLink:Get("UIPracticeShopGroupItem");
    UIShopSmallTagPropItemPrefab = uiLink:Get("UIShopSmallTagPropItem");
    root = uiLink:Get("root"):GetComponent("UIAnimator");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectConstant = uiLink:Get("rectConstant"):GetComponent("RectTransform");
    rectTagConstant = uiLink:Get("rectTagConstant"):GetComponent("RectTransform");
    rectSmallTagList = uiLink:Get("rectSmallTagList"):GetComponent("RectTransform");
    rawImageBody = uiLink:Get("rawImageBody"):GetComponent("UISpineCharacter");
    goCharacterMsgItem = uiLink:Get("goCharacterMsgItem");
    textContent = uiLink:Get("textContent"):GetComponent("Text");
    goBgsRight = uiLink:Get("goBgsRight");



    uiLink:AddClickEvent("btnClickRect", function()
        if this.nowRandomIndex == 0 then
            math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)));
            this.nowRandomIndex = math.random(3);
            local globalId = this.globalLanIdList[this.nowRandomIndex]
            this.ShowMsgText(this.globalLanIdToTragger[globalId], ConfigMgr.LangGlobal(globalId));
        else
            math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)));
            this.nowRandomIndex = ((this.nowRandomIndex - 1 + math.random(2)) % 3 + 1);
            local globalId = this.globalLanIdList[this.nowRandomIndex]
            this.ShowMsgText(this.globalLanIdToTragger[globalId], ConfigMgr.LangGlobal(globalId));
        end
    end)
end


this.Clear = function()
    if this.modelGo ~= nil then
        LuaMgr.DestroyImmediateGO(this.modelGo);
    end
    LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
    this.modelGo = nil
    tarGameObject = nil
    tarRect = nil
    UIShopTagPropItemPrefab = nil;
    goBgsRight = nil;
    UIPracticeShopItemPrefab = nil;
    UIPracticeShopGroupItemPrefab = nil;
    rawImageBody = nil;
    goCharacterMsgItem = nil;
    textContent = nil;
    root = nil;
    root = nil;
    Middle = nil;
    ScrollView = nil;
    rectConstant = nil;
    rectTagConstant = nil;
    this = nil;
end

this.InitData = function()
    for key, value in pairs(ConfigMgr.Config.RandShopMap) do
if value.Type == 1 then
            local mapId = this.shopIdToMapId[value.Id];
if CollectorPracticeAllMgr.IsMapOpen(mapId) then
                this.shopData[value.Id] = {};
                for originsTalentMapKey, originsTalentMapValue in pairs(ConfigMgr.Config.OriginsTalentMap) do
                    if originsTalentMapValue.Map == mapId then
                        this.shopData[value.Id][originsTalentMapKey] = {};
                    end
                end
            end
        end
    end
    for key, value in pairs(this.shopData) do
        local orderId = ConfigMgr.Config.RandShopMap[key].OrderId;
for i = 1, #orderId, 1 do
local id = tostring(orderId[i]) .. "001";
            local allBuyed = false;
            local randItem = ConfigMgr.Config.RandGoodsMap[id];
if randItem.ItemLocation == 1 and CollectorPracticeMgr.HaveThisChip(randItem.Item[1].id) then
                allBuyed = true;
            end
            local OriginsID = CollectorPracticeMgr.GetCardInfoByItemId(randItem.Item[1].id).OriginsID;
            local temp = {
                fun = this.CallBack,
                allBuyed = allBuyed,
                currency = randItem.Currency,
                discount = randItem.Discount,
                group = randItem.Group,
                item = randItem.Item,
                itemLocation = randItem.ItemLocation,
                limitCount = randItem.LimitCount,
                originalPrice = randItem.OriginalPrice,
                price = randItem.Price,
                relicsId = randItem.RelicsId,
                tabId = key,
                smallTabId = OriginsID,
                prefab = UIPracticeShopItemPrefab,
            }
            table.insert(this.shopData[key][OriginsID], temp);
        end
    end

    ComData.CollectorPracticeShop = {}
    for key, value in pairs(DataMgr.Player.randShop) do
        local shopMessage = ConfigMgr.Config.RandShopMap[key];
        if shopMessage~=nil and shopMessage.Type == 1 and CollectorPracticeAllMgr.IsMapOpen(this.shopIdToMapId[shopMessage.Id]) then
            CollectorPracticeMgr.InitShopCountData(shopMessage.Id)
        end
    end
end

this.InitGroupIndex = function()
    for key, value in pairs(this.shopData) do
        this.groupToIndex[key] = {};
        for index, group in ipairs(ConfigMgr.Config.RandShopMap[key].OrderId) do
            this.groupToIndex[key][group] = index;
        end
    end
end

this.CallBack = function(tabId, OriginsID)
for key, value in pairs(this.shopData[tabId][OriginsID]) do
if value.itemLocation == 1 and CollectorPracticeMgr.HaveThisChip(value.item[1].id) then
            value.allBuyed = true;
        end
    end
    this.SortGood(tabId, OriginsID);
    local scrollDatas = {}
    local scrollData = nil;
    for i = 1, #this.shopData[tabId][OriginsID], 4 do
        local temp = {};
        table.insert(temp, this.shopData[tabId][OriginsID][i]);
        table.insert(temp, this.shopData[tabId][OriginsID][i + 1]);
        table.insert(temp, this.shopData[tabId][OriginsID][i + 2]);
        table.insert(temp, this.shopData[tabId][OriginsID][i + 3]);
        scrollData = UIScrollData.GetData(UIPracticeShopGroupItemPrefab, "UIPracticeShopGroupItem", 826.9961, 235.2, temp)
        table.insert(scrollDatas, scrollData)
    end
    this.UISV:SetParams(826.9961, 460)
    this.UISV:SetData(scrollDatas, false);
    this.UISV:Refresh();
    this.ShowMsgText(this.globalLanIdToTragger["7162"], ConfigMgr.LangGlobal("7162"));
end

this.SortGood = function(tabId, OriginsID)
    table.sort(this.shopData[tabId][OriginsID], function(a, b)
        if a.allBuyed and (not b.allBuyed) then
            return false;
        elseif (not a.allBuyed) and b.allBuyed then
            return true;
        else
            return this.groupToIndex[tabId][a.group] < this.groupToIndex[tabId][b.group]
        end
    end)
end

this.ClickTab = function(tabId)
this.InitSmallTab(tabId);
for i = 1, #this.tabList, 1 do
        this.tabList[i]:SetSelect(this.tabList[i].tabId == tabId);
    end
    this.ClickSmallTab(tabId, this.smallTabList[1].OriginsID, true);
end

this.InitTab = function()
    local tabId = {}
    for key, value in pairs(this.shopData) do
        table.insert(tabId, key);
    end
    local randShopMap = ConfigMgr.Config.RandShopMap;
    table.sort(tabId, function(a, b)
        return randShopMap[a].Order < randShopMap[b].Order;
    end)
    for i = 1, #tabId, 1 do
        if i > #this.tabList then
            local temp = UIShopTagPropItem.New(UIShopTagPropItemPrefab, rectTagConstant);
            table.insert(this.tabList, temp);
        end
        this.tabList[i]:SetData(tabId[i], this.ClickTab);
    end
    for i = #tabId + 1, #this.tabList, 1 do
        this.tabList[i]:Hide();
    end
end

this.InitSmallTab = function(shopId)
    local mapId = this.shopIdToMapId[shopId];
    local smallTabId = {}
    for key, value in pairs(this.shopData[shopId]) do
        table.insert(smallTabId, key);
    end
    local originsTalentConfig = ConfigMgr.Config.OriginsTalentMap;
    table.sort(smallTabId, function(a, b)
        return originsTalentConfig[a].OtOrder < originsTalentConfig[b].OtOrder;
    end)
    for i = 1, #smallTabId, 1 do
        if i > #this.smallTabList then
            local temp = UIShopSmallTagPropItem.New(UIShopSmallTagPropItemPrefab, rectSmallTagList);
            table.insert(this.smallTabList, temp);
        end
        this.smallTabList[i]:SetData(shopId, smallTabId[i], this.ClickSmallTab);
    end
    for i = #smallTabId + 1, #this.smallTabList, 1 do
        this.smallTabList[i]:Hide();
    end
end

this.InitSpine = function()

    local isOn = LuaMgr.GetRenderLevelEnable("SpineEnable")
    if isOn then
        SetActive(goBgsRight, false);
        SetActive(rawImageBody.gameObject, true);
        rawImageBody:SetDrawingFace("JQ003", "JQ003A01", 10, 11, 0.3)
        rawImageBody:Play("happy2","idle_1");
    else
        SetActive(goBgsRight, true);
        SetActive(rawImageBody.gameObject, false);
goBgsRight:GetComponent("CanvasGroup").alpha = 1.0;
    end
end

this.ShowMsgText = function(animation, textValue)
    rawImageBody:Play(animation,"idle_1");
    textContent.text = textValue;
    SetActive(goCharacterMsgItem, true);
    LuaMgr.RemoveTimer(TimerConst.MsgCloseCountDow);
    LuaMgr.AddTimer(TimerConst.MsgCloseCountDow, this.CloseMsgText, 3, 1, false)
end
this.CloseMsgText = function()
    LuaMgr.RemoveTimer(TimerConst.MsgCloseCountDow);
    SetActive(goCharacterMsgItem, false);
end
this.ClickSmallTab = function(tabId, OriginsID, isRefresh)
for i = 1, #this.smallTabList, 1 do
        this.smallTabList[i]:SetSelect(this.smallTabList[i].OriginsID == OriginsID);
    end

    this.SortGood(tabId, OriginsID);

    local scrollDatas = {}
    local scrollData = nil;
    for i = 1, #this.shopData[tabId][OriginsID], 4 do
        local temp = {};
        table.insert(temp, this.shopData[tabId][OriginsID][i]);
        table.insert(temp, this.shopData[tabId][OriginsID][i + 1]);
        table.insert(temp, this.shopData[tabId][OriginsID][i + 2]);
        table.insert(temp, this.shopData[tabId][OriginsID][i + 3]);
        scrollData = UIScrollData.GetData(UIPracticeShopGroupItemPrefab, "UIPracticeShopGroupItem", 826.9961, 235.2, temp)
        table.insert(scrollDatas, scrollData)
    end
    this.UISV:SetParams(826.9961, 460)
    this.UISV:SetData(scrollDatas, isRefresh)
    for index, value in ipairs(this.UISV.screenList) do
        value:ShowAnimation();
    end
end
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.InitData()
            this.InitTab();
            this.InitGroupIndex();
            this.InitSpine();
            this.ShowMsgText(this.globalLanIdToTragger["7161"], ConfigMgr.LangGlobal("7161"));
            this.UISV = UIScrollView.New(ScrollView.gameObject);
            this.ClickTab(this.MapIdToshopId[CollectorPracticeAllMgr.currentSelectMap]);
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.UISV:Clear(true);
            rawImageBody:Clear();
goBgsRight:GetComponent("CanvasGroup").alpha = 0.0;
            ComData.CollectorPracticeShop = nil;
        end
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("UIPracticeShopGroupItem")
        for key, value in pairs(this.tabList) do
            value:Destroy();
        end
        this.Clear();
        this = {};
    end
}
return vm({
    data = data,
    command = command,
    hook = hook
})