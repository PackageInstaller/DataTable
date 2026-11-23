


















BalatroLaunchRewardItem = {}
BalatroLaunchRewardItem.__index = BalatroLaunchRewardItem

local objs = {
    getBtnObj = {path = "btnGet", type = BalatroUtil.GameObject},
    getBtn = {path = "btnGet", type = BalatroUtil.Button},
    redPoint = {path = "btnGet", type = BalatroUtil.RedIconListener},
    objGoodsParent = {path = "objGoodsParent", type = BalatroUtil.Transform},
    objGoodsItem = {path = "objGoodsItem", type = BalatroUtil.GameObject},
    objGotFlag = {path = "objGotFlag", type = BalatroUtil.GameObject},
    objCanGet = {path = "objCanGet", type = BalatroUtil.GameObject},
    txtGoalScore = {path = "txtGoalScore", type = BalatroUtil.Text}
}

function BalatroLaunchRewardItem.New(obj, parent)

    local self = {}
    setmetatable(self, BalatroLaunchRewardItem)
    self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    self.gameObject.transform.localPosition = Vector3.zero
    SetActive(self.gameObject, true)
    UITool.Parse(self.gameObject, self, objs)
    self.clickItemBtn = function()
        if self.clickItemCallback then
            self.clickItemCallback(self)
        end
    end
    LuaMgr.AddClick(self.getBtn, self.clickItemBtn)
    self.goodsItem = GoodsDataItem.New(self.objGoodsParent, self.objGoodsItem)
    return self
end



function BalatroLaunchRewardItem:SetClickItemCallback(callback)
    self.clickItemCallback = callback
end

function BalatroLaunchRewardItem:SetData(data, index)
    self.data = data
    if self.gameObject == nil then
        return
    end
    self:RefreshGetStatus()
    self.txtGoalScore.text = tostring(data.condition)
    local goodsData = data.goodsData
    if goodsData ~= nil then
        local itemData = table.Copy(ConfigMgr.Config.itemMap[goodsData.id])
        local scale = Vector3(1, 1, 1)
        self.goodsItem:SetData(index, itemData, 1, false, scale, false, false)
        self.goodsItem:SetCount(string.format("%d", goodsData.count))
        self.goodsItem:SetIconBg(false)
        self.redPointID = "15054_" .. index
        self.redPoint.RedId = self.redPointID
    end
    self:SetGetStatus(self.data.getStatus)
end

function BalatroLaunchRewardItem:SetGetStatus(status)
    self.data.getStatus = status
    self:RefreshGetStatus()
    local count = 0
    if self.data.getStatus == BalatroUtil.RewardStatus.CanGet then
        count = 1
    end
    RedMgr.Singleton:UpdateClientRedData(self.redPointID, count)
    RedMgr.Singleton:RefreshOtherViewModel(UIName.BalatroLaunchPanel)
    RedMgr.Singleton:Refresh()
    SetActive(self.getBtnObj, self.data.getStatus == BalatroUtil.RewardStatus.CanGet)
end

function BalatroLaunchRewardItem:RefreshGetStatus()
    SetActive(self.objGotFlag, self.data.getStatus == BalatroUtil.RewardStatus.Got)
    SetActive(self.objCanGet, self.data.getStatus == BalatroUtil.RewardStatus.CanGet or self.data.getStatus == BalatroUtil.RewardStatus.Got)
end

function BalatroLaunchRewardItem:GetGotStatus()
    return self.data.getStatus
end

function BalatroLaunchRewardItem:Destroy()
    LuaMgr.RemoveClick(self.getBtn, self.clickItemBtn)
end