






BossTaskNormalItem = {}
BossTaskNormalItem.__index = BossTaskNormalItem

local objs = {
    desc = {path = "Group/Desc", type = UITool.Text},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    getRewardBtn = {path = "Group/GetRewardBtn", type = UITool.Button},
    noCompleteObj = {path = "Group/NoCompleteObj", type = UITool.GameObject},
    gotObj = {path = "Group/GotObj", type = UITool.GameObject}
}

BossTaskNormalItem.New = function()

    local self = {}
    setmetatable(self, BossTaskNormalItem)
    self.goodsItems = {}
    return self
end

function BossTaskNormalItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickHelp = function()
        if self.data.callbackGetReward ~= nil then
            self.data.callbackGetReward(self.data.Id)
        end
    end
    LuaMgr.AddClick(self.getRewardBtn, self.OnClickHelp)
end

function BossTaskNormalItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function BossTaskNormalItem:SetItem()
    self.desc.text = self.data.Desc

    SetActive(self.getRewardBtn.gameObject, self.data.Status == CommonRewardItem.Status.CanGet)
    SetActive(self.noCompleteObj, self.data.Status == CommonRewardItem.Status.None)
    SetActive(self.gotObj, self.data.Status == CommonRewardItem.Status.Got)
    for i = 1, #self.goodsItems do
        local goodsItem = self.goodsItems[i]
        SetActive(goodsItem.gameObject, false)
    end
    for i = 1, #self.data.Rewards do
        local goodsItem = self.goodsItems[i]
        if goodsItem == nil then
            goodsItem = GoodsDataItem.New(self.itemParent)
            table.insert(self.goodsItems, i, goodsItem)
        else
            SetActive(goodsItem.gameObject, true)
        end
        local reward = self.data.Rewards[i]
        local itemConfig = ConfigMgr.Config.itemMap[reward.id]
        if itemConfig ~= nil then
            local itemData = table.Copy(itemConfig)
            itemData.count0 = reward.count
            goodsItem:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 1), false)
            goodsItem:SetCount(nil, Vector2(-10, 10), Vector3.one)
            goodsItem:SetIconBg(false)
        end
    end
end

function BossTaskNormalItem:ClearItems()
end

function BossTaskNormalItem:Clear()
    self:ClearItems()
end

function BossTaskNormalItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end