
















DispatchStoryItem = {}
DispatchStoryItem.__index = DispatchStoryItem
local imagePath = "Assets/_BundleResources/Images/LongTermDispatch/"
local objs = {
    storyName = {path = "StoryName", type = UITool.Text},
    storyImage = {path = "StoryImage", type = UITool.RawImage},
    storyDesc = {path = "ScrollView/Viewport/StoryDesc", type = UITool.Text},
    itemParent = {path = "RewardGroup/ItemParent", type = UITool.Transform},
    gotGroupObj = {path = "RewardGroup/GotGroup", type = UITool.GameObject},
    canGetTextObj = {path = "RewardGroup/_TitleText", type = UITool.GameObject},
    getRewardBtn = {path = "RewardGroup", type = UITool.Button}
}

DispatchStoryItem.New = function(prefab, clickCallback)

    local self = {}
    setmetatable(self, DispatchStoryItem)
    self.gameObject = prefab
    UITool.Parse(self.gameObject, self, objs)
    self.clickCallback = clickCallback
    local callback = function()
        self.clickCallback(self)
    end
    LuaMgr.AddClick(self.getRewardBtn, callback)
    return self
end

function DispatchStoryItem:SetData(data)
    self.data = data
    self.storyName.text = LuaMgr.GetLangText(data.config.NameLan)
    local imagePath = string.format("%s%s.png", imagePath, data.config.Icon)
    self.storyImage.texture = LuaMgr.GetTexture(imagePath)
    self.storyDesc.text = LuaMgr.GetLangText(data.config.PlotLan)
    self:Refresh()
    local item = self.rewardItem
    if item == nil then
        self.rewardItem = GoodsDataItem.New(self.itemParent)
        item = self.rewardItem
    end
    local itemConfig = data.config.Reward[1]
    local itemData = table.Copy(ConfigMgr.Config.itemMap[itemConfig.id])
    item:SetData(i, itemData, 1, false, Vector3(0.5, 0.5, 0.5), false, false)
    item:SetCount(string.format("%d", itemConfig.count))
    item:SetIconBg(false)
end

function DispatchStoryItem:Refresh()
    SetActive(self.gotGroupObj, self.data.status == DispatchData.GetRewardStatus.Got)
    SetActive(self.canGetTextObj, self.data.status == DispatchData.GetRewardStatus.CanGet)
end