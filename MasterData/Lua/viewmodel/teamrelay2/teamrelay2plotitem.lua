require("ViewModel/TeamRelay2/TeamRelay2RewardItem")
TeamRelay2PlotItem = {};

TeamRelay2PlotItem.__index = TeamRelay2PlotItem;

local objs = {
    clickBtn = { path = "Group/Bg", type = UITool.Button },
    indexImg = { path = "Group/Index", type = UITool.Image },
    nameImg = { path = "Group/Name", type = UITool.Image },
    highestScoreText = { path = "Group/HighestScore/Text", type = UITool.Text },
    rewardContainer = { path = "Group/RewardPreview/List", type = UITool.Transform },
    maskGo = { path = "Group/Mask", type = UITool.GameObject },
}

function TeamRelay2PlotItem.New(obj)
    local self = {};
    setmetatable(self, TeamRelay2PlotItem);
    self.gameObject = obj
    self:Init()
    return self;
end

function TeamRelay2PlotItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.rewardItemList = {}
    self.onClickCommand = function()
        if self.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamRelay2PlotItem_0"))
            return
        end
        LuaMgr.ShowLuaPanel(UIName.TeamRelay2LevelViewModel, self.data.plotId);
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
end

function TeamRelay2PlotItem:SetData(pdata)
    self.data = pdata
    self.highestScoreText.text = self.data.highestScoreStr
    self.indexImg.sprite = self.data.indexSprite
    self.nameImg.sprite = self.data.nameSprite
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

function TeamRelay2PlotItem:Hide()
    SetActive(self.gameObject, false)
end

function TeamRelay2PlotItem:Clear()
    self.data = nil
    for i, v in ipairs(self.rewardItemList) do
        v:Clear()
    end
end

function TeamRelay2PlotItem:Destroy()
    for i, v in ipairs(self.rewardItemList) do
        v:Destroy()
    end
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
end 