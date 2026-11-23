






ZXLStarRewardItem = {}
ZXLStarRewardItem.__index = ZXLStarRewardItem

local objs = {
    darkIcon = {path = "DarkIcon", type = UITool.GameObject},
    lightIcon = {path = "LightIcon", type = UITool.GameObject},
    timeText = {path = "Score", type = UITool.Text},
    itemParent = {path = "ItemParent", type = UITool.GameObject}
}


function ZXLStarRewardItem.New(prefab)

    local self = {}
    setmetatable(self, ZXLStarRewardItem)
    self.gameObject = prefab
    UITool.Parse(self.gameObject, self, objs)
    return self
end

function ZXLStarRewardItem:SetData(data)
    self.data = data
    SetActive(self.darkIcon, data.isLight == false)
    SetActive(self.lightIcon, data.isLight == true)
    self.timeText.text = tostring(data.time)
    if self.rewardItem == nil then
        self.rewardItem = CommonRewardItem.New(self.itemParent, true, 0.55)
    end
    local itemData = {}
    local rewardData = data.reward
    itemData.id = rewardData and rewardData.id or nil
    itemData.count = rewardData and rewardData.count or nil
    itemData.status = data.status
    self.rewardItem:SetData1(itemData)
end