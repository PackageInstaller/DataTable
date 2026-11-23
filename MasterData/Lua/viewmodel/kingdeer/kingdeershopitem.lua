


















KingDeerShopItem = {}

KingDeerShopItem.__index = KingDeerShopItem

local objs = {
    button = {path = "Group", type = UITool.Button},
    normalObj = {path = "Group/Normal", type = UITool.GameObject},
    lockObj = {path = "Group/Lock", type = UITool.GameObject},
    priceObj = {path = "Group/Price", type = UITool.GameObject},
    sellOutObj = {path = "Group/SellOut", type = UITool.GameObject},
    itemParent = {path = "Group/Item", type = UITool.RectTransform},
    name = {path = "Group/Name", type = UITool.Text},
    num = {path = "Group/Num", type = UITool.Text},
    priceText = {path = "Group/Price", type = UITool.Text},
    priceIcon = {path = "Group/Price/Icon", type = UITool.RawImage}
}

function KingDeerShopItem.New(prefab, parent)

    local self = {}
    setmetatable(self, KingDeerShopItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.GetAwardResponse = function()
        if self:GetBuyCount() <= 0 then
            LuaMgr.InvokeUIEventListeners(UIEventConst.KingDeerShopRefresh)
        else
            self:SetData()
        end
    end
    self.OnActivityBuyTip = function(count)
        DataExHelper.EX_ShopConvert(self.data.id, count, self.GetAwardResponse)
    end
    self.OnClickItem = function()
        local buyCount = self:GetBuyCount()
        if (buyCount <= 0) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18343"))
            return
        end
        local costItem = self.data.cost[1]
        local count = DataHelper.GetItemCountById(costItem.id)
        count = math.floor(count / costItem.count)
        if (buyCount > count) then
            buyCount = count
        end
        if (buyCount <= 0) then
            local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_10353")
            local name = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[costItem.id].nameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(content, name))
            return
        end
        LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel, self.data.showReward[1], self.data.cost, buyCount, self.OnActivityBuyTip)
    end
    LuaMgr.AddClick(self.button, self.OnClickItem)
    self.progress = 0
    return self
end

function KingDeerShopItem:SetData(data)
    if data ~= nil then
        self.data = data.questConfig
    end
    local buyCount = self:GetBuyCount()
    SetActive(self.normalObj, buyCount > 0)
    SetActive(self.lockObj, buyCount <= 0)
    SetActive(self.sellOutObj, buyCount <= 0)
    local numStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7301")
    if buyCount > 0 then
        numStr = string.format("%s%d/%d", numStr, buyCount, self.data.progress)
    else
        numStr = string.format("%s<color=#d34329>%d</color>/%d", numStr, buyCount, self.progress)
    end
    self.num.text = numStr
    local cost = self.data.cost
    if not IsNull(cost) and #cost > 0 and cost[1].count > 0 then
        self.priceText.text = tostring(cost[1].count)
        self.priceIcon.texture = GetItemHomeIcon(cost[1].id)
        SetActive(self.priceObj, true)
    else
        SetActive(self.priceObj, false)
    end
    self:SetItem()
    SetActive(self.gameObject, true)
end

function KingDeerShopItem:GetBuyCount()
    local questData = DataMgr.Player.quests[self.data.id]
    if questData ~= nil then
        self.progress = questData.progress
    end
    return self.data.progress - self.progress
end

function KingDeerShopItem:SetItem()
    if not IsNull(self.data.showReward) and #self.data.showReward > 0 then
        if self.item == nil then
            self.item = GoodsDataItem.New(self.itemParent)
        end
        local showItem = self.data.showReward[1]
        local itemConfig = ConfigMgr.Config.itemMap[showItem.id]
        if itemConfig ~= nil then
            self.name.text = LuaMgr.GetLangText(itemConfig.nameLan)
            local itemData = table.Copy(itemConfig)
            itemData.count0 = showItem.count
            self.item:SetData(1, itemData, 1, false, Vector3(0.8, 0.8, 1), false)
            self.item:SetCount(nil, Vector2(-10, 10), Vector3.one)
            self.item:SetIconBg(false)
        end
    end
end

function KingDeerShopItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function KingDeerShopItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear()
        self.item = nil
    end
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end