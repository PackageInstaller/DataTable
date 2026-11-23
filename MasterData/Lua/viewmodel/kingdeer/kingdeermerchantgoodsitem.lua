

















KingDeerMerchantGoodsItem = {}
KingDeerMerchantGoodsItem.__index = KingDeerMerchantGoodsItem

local objs = {
    clickBtn = {path = "", type = UITool.Button},
    discountObj = {path = "Group/SaleObj", type = UITool.GameObject},
    sellOutObj = {path = "Group/SellOut", type = UITool.GameObject},
    sellOutObjDiscount = {path = "Group/SellOut/SaleObj", type = UITool.GameObject},
    discountNum = {path = "Group/SaleObj/SaleTxt", type = UITool.Text},
    itemParent = {path = "Group/Item", type = UITool.RectTransform},
    priceText = {path = "Group/Price", type = UITool.Text},
    priceIcon = {path = "Group/Price/Icon", type = UITool.RawImage}
}




function KingDeerMerchantGoodsItem.New(prefab, parent, index)

    local self = {}
    setmetatable(self, KingDeerMerchantGoodsItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.index = index
    local buyCallback = function()
        self:OnBuyGoods()
    end
    local onClick = function()
        if self.data.sellout == true then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7331")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        LuaMgr.ShowLuaPanel(UIName.BuyTipViewModel, self.data, 1, buyCallback)
    end
    LuaMgr.RemoveClick(self.clickBtn, onClick)
    LuaMgr.AddClick(self.clickBtn, onClick)
    return self
end

function KingDeerMerchantGoodsItem:OnBuyGoods()
    KingDeerData.BuyRandomShopData(self.data.Id)
    self:SetData()
end

function KingDeerMerchantGoodsItem:SetData(data)
    if data ~= nil then
        self.data = data
    end
    if self.item == nil then
        self.item = GoodsDataItem.New(self.itemParent)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.Item]
    if itemConfig ~= nil then
        local itemData = table.Copy(itemConfig)
        itemData.count0 = self.data.Stack
        self.item:SetData(1, itemData, 1, false, Vector3(0.7, 0.7, 1), false)
        self.item:SetCount(nil, Vector2(-10, 10), Vector3.one)
        self.item:SetIconBg(false)
    end
    if DataHelper.GetItemCountById(self.data.Currency) < self.data.Price then
        self.priceText.text = string.format("<color=#5F151C>%d</color>",self.data.Price)
    else
        self.priceText.text = string.format("<color=#F5EFC5>%d</color>",self.data.Price)
    end
    self.priceIcon.texture = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(self.data.Currency))
    SetActive(self.discountObj, self.data.showDiscount)
    SetActive(self.sellOutObjDiscount, self.data.showDiscount)
    SetActive(self.sellOutObj, self.data.buyCnt >= self.data.limitCount)
    self.discountNum.text = string.format("%.0f%%", self.data.discount * 100)
end