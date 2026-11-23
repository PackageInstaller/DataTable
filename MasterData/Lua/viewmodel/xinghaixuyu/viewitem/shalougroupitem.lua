









ShaLouGroupItem = {}
ShaLouGroupItem.__index = ShaLouGroupItem

ShaLouGroupItem.IconCache = {}

local objs = {
    dayNum = {path = "Group/DayNum", type = UITool.Text},
    normalRewardObj = {path = "Group/NormalReward", type = UITool.GameObject},
    heighItemParent = {path = "Group/HeighReward/ItemParent", type = UITool.GameObject},
    heighRewardObj = {path = "Group/HeighReward", type = UITool.GameObject},
    normalItemParent1 = {path = "Group/NormalReward/ItemParent1", type = UITool.GameObject},
    normalItemParent2 = {path = "Group/NormalReward/ItemParent2", type = UITool.GameObject}
}

function ShaLouGroupItem.New()
    local self = {}
    setmetatable(self, ShaLouGroupItem)
    return self
end

function ShaLouGroupItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local flag = CommonRewardItem.ResetStatusSlibing.CanGet | CommonRewardItem.ResetStatusSlibing.Got | CommonRewardItem.ResetStatusSlibing.Lock
    self.heighReward = CommonRewardItem.New(self.heighItemParent, true, 0.8, flag)

    self.normalRewards = {}
    for i = 1, 2 do
        local reward = CommonRewardItem.New(self["normalItemParent" .. i], true, 0.8, flag)
        table.insert(self.normalRewards, reward)
    end
end

function ShaLouGroupItem:SetData(data)
    self.data = data.data
    self:RefreshItem()
end

function ShaLouGroupItem:RefreshItem()
    local rewardData = self.data.rewardData
    self.heighReward:SetData1(rewardData.PayReward[1])
    self.heighReward:SetStatus(self.data.heighStatus)
    for i = 1, 2 do
        local freeReward = rewardData.FreeReward
        local data = freeReward[i]
        local itemUI = self.normalRewards[i]
        if data ~= nil then
            SetActive(itemUI.gameObject, true)
            itemUI:SetData1(data)
            itemUI:SetStatus(self.data.normalStatus)
        else
            SetActive(itemUI.gameObject, false)
        end
    end
    self.dayNum.text = tostring(rewardData.Level)
end

function ShaLouGroupItem:ClearItems()
end

function ShaLouGroupItem:Clear()
    self:ClearItems()
end

function ShaLouGroupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end