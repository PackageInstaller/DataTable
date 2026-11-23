










CeHuiRewardItem = {}
CeHuiRewardItem.__index = CeHuiRewardItem

CeHuiRewardItem.IconCache = {}

local objs = {
    canvasGroup = {path = "Group", type = UITool.CanvasGroup},
    exchangeBtn = {path = "Group/PriceBG", type = UITool.Button},
    exchangeNum = {path = "Group/TextBG/Text", type = UITool.Text},
    priceText = {path = "Group/PriceBG/PriceText", type = UITool.Text},
    priceIcon = {path = "Group/PriceBG/PriceText/Icon", type = UITool.RawImage},
    rewardPrent = {path = "Group/Reward", type = UITool.Transform},
    rewardPrentCanvas = {path = "Group/Reward", type = UITool.CanvasGroup},
    selloutFlag = {path = "SellOut", type = UITool.GameObject}
}

function CeHuiRewardItem.New(item, index)
    local self = {}
    setmetatable(self, CeHuiRewardItem)
    self.gameObject = item
    self.index = index
    self.rewardParent = self.gameObject.transform:Find("Group/Reward")
    UITool.Parse(self.gameObject, self, objs)
    self:Init()
    return self
end

function CeHuiRewardItem:Init()
    local callback = function()
        if self.data.exchangeCallback ~= nil then
            self.data.exchangeCallback(self)
        end
    end
    self.goodsItem = GoodsDataItem.New(self.rewardPrent)
    LuaMgr.AddClick(self.exchangeBtn, callback)
end

function CeHuiRewardItem:SetData(data)
    self.data = data
    self.rewardPrentCanvas.alpha = self.data.rewardIsHide == true and 0 or 1
    if self.data.exchangeCount >= self.data.totalCount then
        self.canvasGroup.alpha = 0.5
        SetActive(self.selloutFlag, true)
    else
        self.canvasGroup.alpha = 1
        SetActive(self.selloutFlag, false)
    end
    local exchangeLang = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26505")
    self.exchangeNum.text = string.format(exchangeLang, self.data.exchangeCount, self.data.totalCount)
    self.priceIcon.texture = GetItemHomeIcon(self.data.cost.id)
    self.priceText.text = tostring(self.data.cost.count)
    local itemConfig = ConfigMgr.Config.itemMap[self.data.reward.id]
    if itemConfig ~= nil then
        local itemData = table.Copy(itemConfig)
        itemData.count0 = self.data.reward.count
        local scale = Vector3.one
        if self.data.rewardIsHide == true then
            scale = Vector3(2.2, 1.17, 0)
        else
            scale = Vector3(0.65, 0.65, 0.65)
        end
        self.goodsItem:SetData(1, itemData, 1, false, scale, false)
        self.goodsItem:SetCount(nil, nil, Vector3.one)
        self.goodsItem:SetIconBg(false)
    end
end