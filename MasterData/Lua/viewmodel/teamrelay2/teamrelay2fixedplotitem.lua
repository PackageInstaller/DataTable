





TeamRelay2FixedPlotItem = {};

TeamRelay2FixedPlotItem.__index = TeamRelay2FixedPlotItem;

local objs = {
    clickBtn = { path = "Group/Bg", type = UITool.Button },
    nameImg = { path = "Group/Name", type = UITool.Image },
    highestScoreText = { path = "Group/HighestScore/Text", type = UITool.Text },
    rewardContainer = { path = "Group/RewardPreview/List", type = UITool.Transform },
    maskGo = { path = "Group/Mask", type = UITool.GameObject },
    now = { path = "Group/Now", type = UITool.GameObject },
}

function TeamRelay2FixedPlotItem.New(prefab, parent)
    local self = {}
    setmetatable(self, TeamRelay2FixedPlotItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.rewardItemList = {}
    self.onClickCommand = function()
        if self.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamRelay2PlotItem_0"))
            return
        end
        LuaMgr.ShowLuaPanel(UIName.TeamRelay2LevelViewModel, self.data.plotId)
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand)
    return self
end

function TeamRelay2FixedPlotItem:SetData(pdata)
    self.data = pdata
    self.highestScoreText.text = "Lv."..self.data.level
    self.nameImg.sprite = self.data.nameSprite
    SetActive(self.now,self.data.now)
    local rewardCount = math.min(#self.data.rewards, 3)
    for i = 1, rewardCount do
        local itemData = self.data.rewards[i]
        if not self.rewardItemList[i] then
            table.insert(self.rewardItemList, TeamRelay2RewardItem.New(self.data.rewardTemplate, self.rewardContainer))
        end
        itemData.isClaimed = self.data.isClaimed
        self.rewardItemList[i]:SetData(itemData)
    end
    for i = #self.data.rewards + 1, #self.rewardItemList do
        self.rewardItemList[i]:Hide()
    end
    SetActive(self.maskGo, self.data.isLock)
    SetActive(self.gameObject, true)
end

function TeamRelay2FixedPlotItem:Clear()
    self.data = nil
    for i, v in ipairs(self.rewardItemList) do
        v:Clear()
    end
    self.gameObject:SetActive(false)
end

function TeamRelay2FixedPlotItem:Destroy()
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    for i, v in ipairs(self.rewardItemList) do
        v:Destroy()
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end