









SSYXBuildRewardItem = {}
SSYXBuildRewardItem.__index = SSYXBuildRewardItem

local objs = {
    gotObj = {path = "Group/GotObj", type = UITool.GameObject},
    desc = {path = "Group/Desc", type = UITool.Text},
    rewardParent = {path = "Group/RewardParent", type = UITool.Transform},
    canvasGroup = {path = "Group/RewardParent", type = UITool.CanvasGroup},
    rewardItem = {path = "Group/RewardParent/RewardItem", type = UITool.GameObject},
    noneObj = {path = "Group/NoneObj", type = UITool.GameObject},
    getBtn = {path = "Group/GetBtn", type = UITool.Button}
}

SSYXBuildRewardItem.New = function()

    local self = {}
    setmetatable(self, SSYXBuildRewardItem)
    return self
end

function SSYXBuildRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.rewardItems = {}
    self.rewardItemChache = {}
    self.OnClickGetBtn = function()
        if self.data.OnGetReward ~= nil then
            self.data.OnGetReward(self)
        end
    end
    LuaMgr.AddClick(self.getBtn, self.OnClickGetBtn)
end

function SSYXBuildRewardItem:SetData(data)
    self.data = data.data
    SetActive(self.gotObj, self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.getBtn.gameObject, self.data.Status == CommonRewardItem.Status.CanGet)
    SetActive(self.noneObj, self.data.Status == CommonRewardItem.Status.None)
    self.canvasGroup.alpha = self.data.Status == CommonRewardItem.Status.Got and 1 or 0.5
    self.desc.text = LuaMgr.GetLangText(self.data.Config.remarksLan)
    self.rewarItemScale = 0.55
    local len = #self.data.Config.showReward
    for i = 1, len do
        local tempData = self.data.Config.showReward[i]
        tempData.scale = self.rewarItemScale
        tempData.status = self.data.Status
        local item = self:GetRewardItemByCache()
        item:SetData1(tempData)
        table.insert(self.rewardItems, item)
    end
end

function SSYXBuildRewardItem:GetRewardItemByCache()
    local rewardItem = table.remove(self.rewardItemChache)
    if rewardItem == nil then
        rewardItem = CommonRewardItem.New(self.rewardItem, false, self.rewarItemScale, nil, self.rewardParent)
    end
    SetActive(rewardItem.gameObject, true)
    return rewardItem
end

function SSYXBuildRewardItem:RecycleRewardItem()
    local rewardItemsLen = #self.rewardItems
    for i = 1, rewardItemsLen do
        local rewardItem = table.remove(self.rewardItems)
        if rewardItem then
            table.insert(self.rewardItemChache, rewardItem)
            SetActive(rewardItem.gameObject, false)
        end
    end
end

function SSYXBuildRewardItem:ClearItems()
    self:RecycleRewardItem()
end

function SSYXBuildRewardItem:Clear()
    self:ClearItems()
end

function SSYXBuildRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end