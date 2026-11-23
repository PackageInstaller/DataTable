TeamRelay2LevelItem = {}

TeamRelay2LevelItem.__index = TeamRelay2LevelItem

local objs = {
    animGo = { path = "Group", type = UITool.GameObject },
    clickBtn = { path = "Group/Bg_1", type = UITool.Button },
    levelName = { path = "Group/Name", type = UITool.Text },
    recommendLevel = { path = "Group/RecommendLevel", type = UITool.Text },
    rewardContainer = { path = "Group/RewardContent", type = UITool.Transform },
    selectedGo = { path = "Group/Bg_2", type = UITool.GameObject },
    maskGo = { path = "Group/Mask", type = UITool.GameObject },
}

function TeamRelay2LevelItem.New(obj)
    local self = {}
    setmetatable(self, TeamRelay2LevelItem)
    if obj then
        self.gameObject = obj
        self:Init()
    end
    return self
end

function TeamRelay2LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.rewardItemList = {}
    self.OnClickItem = function()
        if self.data.onClickCallBack ~= nil then
            self.data.onClickCallBack(self.data.levelId)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickItem)
    SetActive(self.animGo, false)
end

function TeamRelay2LevelItem:SetData(pdata)
    self.data = pdata.data
    self.levelName.text = self.data.desc
    self.recommendLevel.text = string.format(LuaMgr.GetLangText("TeamRelay2LevelItem_0"), self.data.recommendLevel)
    for i, itemData in ipairs(self.data.rewards) do
        if not self.rewardItemList[i] then
            table.insert(self.rewardItemList, TeamRelay2RewardItem.New(self.data.rewardTemplate, self.rewardContainer))
        end
        itemData.isClaimed = false
        self.rewardItemList[i]:SetData(itemData)
    end
    for i = #self.data.rewards + 1, #self.rewardItemList do
        self.rewardItemList[i]:Hide()
    end

    SetActive(self.maskGo, self.data.status == TeamRelay2Mgr.LevelStatus.Claimed or self.data.status == TeamRelay2Mgr.LevelStatus.Locked)
    SetActive(self.selectedGo, self.data.isSelected)
    SetActive(self.animGo, self.data.animBool)
end

function TeamRelay2LevelItem:RefreshSelectStatus()
    SetActive(self.selectedGo, self.data.isSelected)
end

function TeamRelay2LevelItem:Clear()
    SetActive(self.animGo, false)
    for i, v in ipairs(self.rewardItemList) do
        v:Clear()
    end
    self.data = nil
end

function TeamRelay2LevelItem:Destroy()
    for i, v in ipairs(self.rewardItemList) do
        v:Destroy()
    end
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end