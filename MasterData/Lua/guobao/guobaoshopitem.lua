GuoBaoShopItem = {};

GuoBaoShopItem.__index = GuoBaoShopItem;

local objs = {
    button = { path = "Group", type = "Button" },
    normalGO = { path = "Group/Normal", type = "GameObject" },
    lockGO = { path = "Group/Lock", type = "GameObject" },
    name = { path = "Group/Name", type = "Text" },
    itemTF = { path = "Group/Item", type = "RectTransform" },
    num = { path = "Group/Num", type = "Text" },
    priceGO = { path = "Group/Price", type = "GameObject" },
    priceText = { path = "Group/Price", type = "Text" },
    priceIcon = { path = "Group/Price/Icon", type = "RawImage" },
    sellOutGO = { path = "Group/SellOut", type = "GameObject" },
};

function GuoBaoShopItem.New(prefab, parent)
    local self = {};
    setmetatable(self, GuoBaoShopItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
    self.GetAwardResponse = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuoBaoShopRefresh, self.data);
    end
    self.OnActivityBuyTip = function(count)
        DataExHelper.EX_ShopConvert(self.data.id, count, self.GetAwardResponse);
    end
    self.OnClickItem = function() 
        local buyCount = self:GetBuyCount();
        if (buyCount <= 0) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18343"));
            return;
        end
        local count = DataHelper.GetItemCountById(self.data.cost[1].id);
        count = math.floor(count / self.data.cost[1].count);
        if (buyCount > count) then
            buyCount = count;
        end
        if (buyCount <= 0) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10437"));
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel, self.data.showReward[1], self.data.cost, buyCount, self.OnActivityBuyTip);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function GuoBaoShopItem:SetData(data)
    self.data = data;
    local buyCount = self:GetBuyCount();
    SetActive(self.normalGO, buyCount > 0);
    SetActive(self.lockGO, buyCount <= 0);
    SetActive(self.sellOutGO, buyCount <= 0);
    local numStr = LuaMgr.GetLangText("GuoBaoShopItem_0");
    if (buyCount > 0) then
        numStr = numStr .. string.format("%d/%d", buyCount, data.progress);
    else
        numStr = numStr .. string.format("<color=#a5251a>%d</color>/%d", buyCount, data.progress);
    end
    self.num.text = numStr;
    local cost = data.cost;
    if (not IsNull(cost) and #cost > 0 and cost[1].count > 0) then
        self.priceText.text = tostring(cost[1].count);
        self.priceIcon.texture = GetItemHomeIcon(cost[1].id);
        SetActive(self.priceGO, true);
    else
        SetActive(self.priceGO, false);
    end
    self:SetItem();
    SetActive(self.gameObject, true);
end

function GuoBaoShopItem:GetBuyCount()
    local questData = DataMgr.Player.quests[self.data.id];
    if (questData ~= nil) then
        return self.data.progress - questData.progress;
    end
    return 0;
end

function GuoBaoShopItem:SetItem()
    if (not IsNull(self.data.showReward) and #self.data.showReward > 0) then
        if (self.item == nil) then
            self.item = GoodsDataItem.New(self.itemTF);
        end
        local showItem = self.data.showReward[1];
        local itemConfig = ConfigMgr.Config.itemMap[showItem.id];
        if (itemConfig ~= nil) then
            self.name.text = LuaMgr.GetLangText(itemConfig.nameLan);
            local itemData = table.Copy(itemConfig);
            itemData.count0 = showItem.count;
            self.item:SetData(1, itemData, 1, false, Vector3(0.8,0.8,1), false);
            self.item:SetCount(nil, Vector2(-10, 10), Vector3.one);
            self.item:SetIconBg(false);
        end
    else
        if (self.item ~= nil) then
            self.item:Hide();
        end
    end
end

function GuoBaoShopItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end

function GuoBaoShopItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end