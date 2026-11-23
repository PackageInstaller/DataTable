require("RhythmGame/ViewModel/RhythmGameShopTitleItem")
require("RhythmGame/ViewModel/RhythmGameShopItem")
require("RhythmGame/ViewModel/RhythmGameShopItemGroup")

local this = {
    titleList = nil,
    scrollViewRight = nil,
    scrollWidth = 820,
    scrollViewPos = nil,
    rightBgSize = nil,
    totalConfig = nil,
    alphaList = {0.5,0.2,0.1}
};

local objs = {
    rightBg = { path = "root/Right1/Bg", type = "RectTransform" },
    titleItem = { path = "template/TitleItem", type = "GameObject" },
    shopItem = { path = "template/ShopItem", type = "GameObject" },
    shopItemGroup = { path = "template/ShopItemGroup", type = "GameObject" },
    scrollViewRightGO = { path = "root/Right1/ScrollViewRight", type = "GameObject" },
    scrollViewRightTF = { path = "root/Right1/ScrollViewRight", type = "RectTransform" },
    scrollViewLeftGO = { path = "root/Left1/Bg/ScrollViewLeft", type = "GameObject" },
    scrollViewLeftTF = { path = "root/Left1/Bg/ScrollViewLeft", type = "RectTransform" },
};


this.SetData = function()
    PlayerRhythmGameMgr.SetShopTap(1)
    this.totalConfig = DataExHelper.Check_ConfigQuestEventByGroupId(235);   
    this.SetTitleList();
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    addWidth = addWidth > 0 and addWidth or 0;
    this.scrollWidth = 820 + addWidth;
    this.rightBg.sizeDelta = Vector2(this.rightBgSize.x + addWidth, this.rightBgSize.y);
    local halfWidth = addWidth / 2;
    this.scrollViewRightTF.anchoredPosition = Vector2(this.scrollViewPos.x - halfWidth, this.scrollViewPos.y);
end


this.SetTitleList = function()
    this.dataQuests = DataMgr.Player.quests;
    this.scrollViewLeft:Clear();
    local listData;
    local listDatas = {};
    local num = 0
    local curLockLv = 0
    for i, v in ipairs(this.totalConfig) do
        if (v.text == "shopLock") then
            local data = {}
            num = num + 1
            data.index = num
            data.config = v
            data.isLock = this.dataQuests[v.id] ~= nil and this.dataQuests[v.id].state == 1 and num ~= 1
            data.lockAlpha = 1
            if(data.isLock)then
                curLockLv = curLockLv + 1
                data.lockAlpha = this.alphaList[curLockLv]                
            end
            listData = UIScrollData.GetData(this.titleItem, "RhythmGameShopTitleItem", 266, 98, data);
            table.insert(listDatas, listData);
        end
    end
    this.scrollViewLeft:SetParams(280, 460);
    this.scrollViewLeft:SetData(listDatas);
    this.SetShopList()
    PlayerRhythmGameMgr.CheckShopTapNewDot()
    RedMgr.Singleton:Refresh()
end

this.SetShopGoods = function(configList)
    local list = {};
    for i, v in ipairs(configList) do
        local item = ConfigHelper.GetItemById(v.reward[1].id);
        if(item == nil)then
            LuaDebug.error(v.id)
            LuaDebug.error(v.reward[1].id)
        end
        if this.dataQuests[v.id] ~= nil then          
            local shopItem = {
                id = item.id,
                quesId = v.id,
                rare = item.rare,
                icon = ConfigHelper.GetItemIconPath(v.reward[1].id),
                count = "x" .. LuaMgr.NumFormat(v.reward[1].count),
                isSellOut = this.dataQuests[v.id].state == 3,
                priceIcon = ConfigHelper.GetItemHomeIconPath(v.cost[1].id),
                price = LuaMgr.NumFormat(v.cost[1].count),
                limitNum = string.format(LuaMgr.GetLangText("RhythmGameShopViewModel_0"), this.dataQuests[v.id].progress, v.progress),             
                limitTextBool = true,
                goods = v.reward[1],
                maxBuyCount = v.progress - this.dataQuests[v.id].progress,
                cost = v.cost,
                sortNum = v.sort,
            }
            if v.progress > 99999 then
                shopItem.limitNum = LuaMgr.GetLangText("ChanganShopViewModel_3")
                shopItem.limitTextBool = false
            end

shopItem.name = LuaMgr.GetLangText(item.nameLan)
            table.insert(list, shopItem);
        else
            LuaDebug.error("SetShopGoods没有读取到服务器数据的id = " .. v.id)
        end
    end
    table.sort(list, function(a, b)
        if not a.isSellOut and not b.isSellOut then
            return a.sortNum < b.sortNum
        else
            return not a.isSellOut and b.isSellOut;
        end
    end)
    return list;
end



this.SetShopList = function()
    local scrollData;
    this.scrollViewRight:Clear(false);
    local scrollDatas = {};
    local type = PlayerRhythmGameMgr.GetShopTap()
    local num = 0
    local groupConfig = {}
    local cacheList = {}
    for i, v in ipairs(this.totalConfig) do
        if (v.text == "shop0" .. type) then
            table.insert(cacheList, v)
        end
    end
    cacheList = this.SetShopGoods(cacheList)
    for i, v in ipairs(cacheList) do
        local index = (num // 4) + 1
        num = num + 1
        if (groupConfig[index] == nil) then
            groupConfig[index] = {}
        end
        table.insert(groupConfig[index], v)
    end
    for i, v in ipairs(groupConfig) do
        local group = {}
        group.item = this.shopItem;
        group.config = v
        scrollData = UIScrollData.GetData(this.shopItemGroup, "RhythmGameShopItemGroup", 830, 300, group);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollViewRight:SetParams(this.scrollWidth, 662);
    this.scrollViewRight:SetData(scrollDatas, true);
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);


        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameShopViewModel)
        this.scrollViewRight = UIScrollView.New(this.scrollViewRightGO);
        this.scrollViewLeft = UIScrollView.New(this.scrollViewLeftGO);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end        

        this.SetData();
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameShopTitle, this.SetTitleList);
    end,
    before_deactive = function(vm)
        this.scrollViewRight:Clear(true);
        this.scrollViewLeft:Clear(true);
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("RhythmGameShopTitleItem");
        UIScrollView.ClearItem("RhythmGameShopItemGroup");
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameShopViewModel)
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameShopTitle, this.SetTitleList);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})