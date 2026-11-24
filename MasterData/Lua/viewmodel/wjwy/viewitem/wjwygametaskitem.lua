







WJWYGameTaskItem = {}
WJWYGameTaskItem.__index = WJWYGameTaskItem

local objs = {
    title = {path = "Group/Title", type = UITool.Text},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    canGetBtn = {path = "Group/CanGet", type = UITool.Button},
    noCompleteObj = {path = "Group/NoComplete", type = UITool.GameObject},
    completeObj = {path = "Group/Complete", type = UITool.GameObject}
}

WJWYGameTaskItem.New = function()

    local self = {}
    setmetatable(self, WJWYGameTaskItem)
    self.OnRefreshItem = function(params)
        if params == nil or params.Length < 1 then
            return
        end
        local data = params[0]
        self:RefreshItem(data)
    end
    LuaMgr.AddUIEventListener(UIEventConst.JYCSRefreshTaskItem, self.OnRefreshItem)

    self.goodsItems = {}
    return self
end

function WJWYGameTaskItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickGetBtn = function()
        if self.data.OnClickGotReward ~= nil then
            self.data.OnClickGotReward(self)
        end
    end
    LuaMgr.AddClick(self.canGetBtn, self.OnClickGetBtn)
end

function WJWYGameTaskItem:SetData(data)
    self.data = data.data
    self.title.text = LuaMgr.GetLangText(self.data.Config.remarksLan)
    self:SetReward()
    self:RefreshItem(self.data)
end

function WJWYGameTaskItem:RefreshItem(data)
    SetActive(self.canGetBtn.gameObject, data.Status == CommonRewardItem.Status.CanGet)
    SetActive(self.noCompleteObj, data.Status == CommonRewardItem.Status.None)
    SetActive(self.completeObj, data.Status == CommonRewardItem.Status.Got)
end

function WJWYGameTaskItem:SetReward()
    for i = 1, #self.goodsItems do
        local goodsItem = self.goodsItems[i]
        SetActive(goodsItem.gameObject, false)
    end
    for i = 1, #self.data.Config.showReward do
        local goodsItem = self.goodsItems[i]
        if goodsItem == nil then
            goodsItem = GoodsDataItem.New(self.itemParent)
            table.insert(self.goodsItems, i, goodsItem)
        else
            SetActive(goodsItem.gameObject, true)
        end
        local reward = self.data.Config.showReward[i]
        local itemConfig = ConfigMgr.Config.itemMap[reward.id]
        if itemConfig ~= nil then
            local itemData = table.Copy(itemConfig)
            itemData.count0 = reward.count
            goodsItem:SetData(1, itemData, 1, false, Vector3(0.4, 0.4, 1), false)
            goodsItem:SetCount(nil, Vector2(-10, 10), Vector3.one)
            goodsItem:SetIconBg(false)
        end
    end
end

function WJWYGameTaskItem:ClearItems()
end

function WJWYGameTaskItem:Clear()
    self:ClearItems()
end

function WJWYGameTaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    LuaMgr.RemoveUIEventListener(UIEventConst.JYCSRefreshTaskItem, self.OnRefreshItem)
    LuaMgr.RemoveClick(self.canGetBtn, self.OnClickGetBtn)
    self.gameObject = nil
end