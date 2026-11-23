DHRewardItem = {};

DHRewardItem.__index = DHRewardItem;

local objs = {
    button = { path = "Group", type = "Button" },
    itemTF = { path = "Group/Item", type = "RectTransform" },
    lockGO = { path = "Group/Lock", type = "GameObject" },
    num = { path = "Group/Num", type = "Text" },
    freeGO = { path = "Group/Free", type = "GameObject" },
    redDot = { path = "Group/Free/ImageRed", type = "GameObject" },
    priceGO = { path = "Group/Price", type = "GameObject" },
    priceText = { path = "Group/Price", type = "Text" },
    priceIcon = { path = "Group/Price/Icon", type = "RawImage" },
};

function DHRewardItem.New(prefab, parent)
    local self = {};
    setmetatable(self, DHRewardItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
    self.GetAwardResponse = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.QinRewardRefresh, self.data);
    end
    self.OnActivityBuyTip = function(count)
        DataExHelper.EX_ShopConvert(self.data.id, count, self.GetAwardResponse);
    end
    self.OnClickItem = function() 
        local buyCount = self:GetBuyCount();
        local myCount=DataHelper.GetItemCountById(self.data.cost[1].id)
        myCount=math.floor(myCount/self.data.cost[1].count)
        if buyCount>myCount then
            buyCount=myCount
        end
        if buyCount<=0 and not self.isFree then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10437"))
            return
        end
        LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel, self.data.showReward[1], self.data.cost, buyCount, self.OnActivityBuyTip);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function DHRewardItem:SetData(data)
    self.data = data;
    local buyCount = self:GetBuyCount();
    self.button.enabled = buyCount > 0    
    SetActive(self.lockGO, buyCount <= 0);
    SetActive(self.redDot,buyCount > 0)
    if (self.data.progress <= 9999) then
        self.num.text = LuaMgr.GetLangText("QinRewardItem_0") .. string.format("<color=#3f7a66>%d</color>", buyCount);
    else
        self.num.text = "";
    end
    local cost = data.cost;
    self.isFree = false
    if (cost ~= nil and #cost > 0 and cost[1].count > 0) then
        self.priceText.text = tostring(cost[1].count);
        self.priceIcon.texture = GetItemHomeIcon(cost[1].id);
        SetActive(self.freeGO, false);
        SetActive(self.priceGO, true);
    else
        self.isFree = true
        SetActive(self.freeGO, true);
        SetActive(self.priceGO, false);
    end
    self:SetItem();
    SetActive(self.gameObject, true);
end

function DHRewardItem:GetBuyCount()
    local questData = DataMgr.Player.quests[self.data.id];
    if (questData ~= nil) then
        return self.data.progress - questData.progress;
    end
    return 0;
end

function DHRewardItem:SetItem()
    if (#self.data.showReward > 0) then
        if (self.item == nil) then
            self.item = GoodsDataItem.New(self.itemTF);
        end
        local showItem = self.data.showReward[1];
        local itemData = table.Copy(ConfigMgr.Config.itemMap[showItem.id]);
        itemData.count0 = showItem.count;
        self.item:SetData(1, itemData, 1, false, Vector3(0.8,0.8,1), false);
        self.item:SetCount(nil, Vector2(-17, 17), Vector3.one);
        self.item:SetIconBg(false);
        self.item:SetRareBg(false);
    else
        if (self.item ~= nil) then
            self.item:Hide();
        end
    end
end

function DHRewardItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end

function DHRewardItem:Destroy()
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