







require("ViewModel/Dispatch/ListViewItem/DispatchHeroItem")











DispatchDataCell = {}
DispatchDataCell.__index = DispatchDataCell

local objs = {
    titleBGWaitObj = {path = "RightGroup/TitleBGWait", type = UITool.GameObject},
    titleBGEndObj = {path = "RightGroup/TitleBGEnd", type = UITool.GameObject},
    titleBGEndObj1 = {path = "LeftGroup/Name/TitleBGEnd", type = UITool.GameObject},
    rewardParent = {path = "RightGroup/RewardParent", type = UITool.Transform},
    nameText = {path = "LeftGroup/Name", type = UITool.Text},
    titleBGEndTimeText = {path = "LeftGroup/Name/TitleBGEnd/TimeText", type = UITool.Text},
    scoreText = {path = "RightGroup/ScoreText", type = UITool.Text}
}

DispatchDataCell.New = function()

    local self = {}
    setmetatable(self, DispatchDataCell)
    return self
end

function DispatchDataCell:Init()
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        local tempPath = string.format("LeftGroup/SelectHoreParent/%s", heroHeadName)
        objs[heroHeadName] = {path = tempPath, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
    self.heroItemDic = {}
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        self.heroItemDic[heroHeadName] = DispatchHeroItem.New(self[heroHeadName], nil, 0.85, nil, true)
    end
end

function DispatchDataCell:SetData(data)
    if data ~= nil then
        self.data = data.data
    end
    self:SetItem()
end

function DispatchDataCell:SetItem()
    local strongholdData = self.data.strongholdData
    SetActive(self.titleBGWaitObj, strongholdData.status == DispatchData.StrongholdStatus.DispatchWait)
    SetActive(self.titleBGEndObj, strongholdData.status == DispatchData.StrongholdStatus.DispatchEnd)
    SetActive(self.titleBGEndObj1, strongholdData.status == DispatchData.StrongholdStatus.DispatchEnd)
    local reputation = self:GetRealReputation(self.data.reputation)
    self.scoreText.text = string.format("+%d", reputation)
    self.nameText.text = LuaMgr.GetLangText(strongholdData.config.NameLan)
    if strongholdData.status == DispatchData.StrongholdStatus.DispatchEnd then
        self.titleBGEndTimeText.text = string.format("%.0f", strongholdData.needTime / 3600)
    end
    self:SetHeroList()
    self:SetRewardList()
end

function DispatchDataCell:SetHeroList()
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        local heroData = self.data.heroList[i]
        local heroItem = self.heroItemDic[heroHeadName]
        if heroData == nil then
            SetActive(heroItem.gameObject, false)
        else
            SetActive(heroItem.gameObject, true)
            heroItem:SetData1(heroData)
        end
    end
end

function DispatchDataCell:SetRewardList()
    if self.rewardItems == nil then
        self.rewardItems = {}
    end
    for key, value in pairs(self.rewardItems) do
        SetActive(value.gameObject, false)
    end
    local items = self.rewardItems
    local rewardDatas = self.data.strongholdData.rewardDatas
    for i = 1, #rewardDatas do
        local tempData = rewardDatas[i]
        local item = items[i]
        if item == nil then
            item = GoodsDataItem.New(self.rewardParent)
            table.insert(items, item)
        else
            SetActive(item.gameObject, true)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[tempData.id])
        local scale = 0.65
        item:SetData(i, itemData, 1, false, Vector3(scale, scale, scale), false, false)
        item:SetCount(string.format("%d", tempData.count))
        item:SetIconBg(false)
    end
end

function DispatchDataCell:GetRealReputation(baseValue)
    local timeStage = self.data.timeOptionIndex
    local timeConfig = ConfigMgr.Config.DispatchConstants.DispatchTimeOption[timeStage]
    local hourNum = math.floor(timeConfig / 3600)
    return baseValue * hourNum
end

function DispatchDataCell:ClearItems()
end

function DispatchDataCell:Clear()
    self:ClearItems()
end

function DispatchDataCell:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end