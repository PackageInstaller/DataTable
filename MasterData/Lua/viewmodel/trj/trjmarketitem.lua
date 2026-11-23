
TRJMarketItem = {}
TRJMarketItem.__index = TRJMarketItem

TRJMarketItem.IconCache = {}

local objs = {
    normalObj = {path = "Group/NormalObj", type = UITool.GameObject},
    canGetObj = {path = "Group/CanGetObj", type = UITool.GameObject},
    getBtn = {path = "Group/CanGetObj/GetBtn", type = UITool.Button},
    scoreTextLight = {path = "Group/LightScore", type = UITool.Text},
    scoreTextDark = {path = "Group/DarkScore", type = UITool.Text},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    doneObj= {path = "Group/done", type = UITool.GameObject},
    gotObj = {path = "Group/GotObj", type = UITool.GameObject},
    gotObjItemParent = {path = "Group/GotObj/ItemParent", type = UITool.Transform}
}

function TRJMarketItem.New()
    local self = {}
    setmetatable(self, TRJMarketItem)
    return self
end

function TRJMarketItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.rewardItems = {}
    self.gotObjs = {}
    for i = 1, 2 do
        local goosItemName = "GoodsItem" .. i
        local goosItem = self.itemParent:Find(goosItemName).gameObject
        local rewardItem = CommonRewardItem.New(goosItem, true, 0.8, 0)
        table.insert(self.rewardItems, rewardItem)
    end

    for i = 1, 2 do
        local goosItemName = "GotObj" .. i
        local goosItem = self.gotObjItemParent:Find(goosItemName).gameObject
        table.insert(self.gotObjs, goosItem)
    end
    local func = function()
        if self.data.onGetCallback then
            self.data.onGetCallback(self)
        end
    end
    LuaMgr.AddClick(self.getBtn, func)
end

function TRJMarketItem:SetData(data)
    self.data = data.data
    self:RefreshItem()
end

function TRJMarketItem:RefreshItem()
    local scoreText = tostring(self.data.goalProgress)
    self.scoreTextLight.text = scoreText
    self.scoreTextDark.text = scoreText
    local status = self.data.status and self.data.status - 1 or CommonRewardItem.Status.None
    SetActive(self.scoreTextLight.gameObject, status ~= CommonRewardItem.Status.None)
    SetActive(self.scoreTextDark.gameObject, status == CommonRewardItem.Status.None)
    SetActive(self.normalObj, status == CommonRewardItem.Status.None)
    SetActive(self.canGetObj, status == CommonRewardItem.Status.CanGet)
    SetActive(self.gotObj, status == CommonRewardItem.Status.Got)
    SetActive(self.doneObj,status == CommonRewardItem.Status.Got)
    for i = 1, 2 do
        local rewardItem = self.rewardItems[i]
        local gotObj = self.gotObjs[i]
        local goodsData = self.data.rewards[i]
        SetActive(rewardItem.gameObject, goodsData ~= nil)
        SetActive(gotObj.gameObject, goodsData ~= nil)
        if goodsData ~= nil then
            rewardItem:SetData1(goodsData)
            rewardItem:SetStatus(status)
            SetActive(rewardItem.normalTrans.gameObject, status == CommonRewardItem.Status.None)
        end
    end
end

function TRJMarketItem:ClearItems()
end

function TRJMarketItem:Clear()
    self:ClearItems()
end

function TRJMarketItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end