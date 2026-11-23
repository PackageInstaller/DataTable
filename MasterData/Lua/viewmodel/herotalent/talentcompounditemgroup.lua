TalentCompoundItemGroup = {}
TalentCompoundItemGroup = {}

TalentCompoundItemGroup.__index = TalentCompoundItemGroup

local objs = {
    reward1 = { path = "reward1", type = "GameObject" },
    rewardBox1 = { path = "reward1/Item/RewardBox", type = "Transform" },
    textRatio1 = { path = "reward1/Item/ImgNum/TextRatio", type = "Text" },
    reward2 = { path = "reward2", type = "GameObject" },
    rewardBox2 = { path = "reward2/Item/RewardBox", type = "Transform" },
    textRatio2 = { path = "reward2/Item/ImgNum/TextRatio", type = "Text" },
    reward3 = { path = "reward3", type = "GameObject" },
    rewardBox3 = { path = "reward3/Item/RewardBox", type = "Transform" },
    textRatio3 = { path = "reward3/Item/ImgNum/TextRatio", type = "Text" },
    reward4 = { path = "reward4", type = "GameObject" },
    rewardBox4 = { path = "reward4/Item/RewardBox", type = "Transform" },
    textRatio4 = { path = "reward4/Item/ImgNum/TextRatio", type = "Text" }
}

function TalentCompoundItemGroup.New()
    local self = {}
    setmetatable(self, TalentCompoundItemGroup)
    return self
end

function TalentCompoundItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.itemList = {}
end

function TalentCompoundItemGroup:SetData(data)
    self:HideItemList()
    self.data = data.data
    self.index = self.data.num
    self.requireItem = self.data.config
    for i = 1, 4 do
        SetActive(self["reward" .. i], false)
    end
    for k, v in pairs(self.requireItem) do
        self:InitSingleReward(v, k)
    end
end

function TalentCompoundItemGroup:InitSingleReward(data, index)
    SetActive(self["reward" .. index], true)
    local item = self.itemList[index]
    if (item == nil) then
        item = GoodsDataItem.New(self["rewardBox" .. index])
        self.itemList[index] = item
    end
    local itemData = table.Copy(ConfigMgr.Config.itemMap[data.id])
    local scale = Vector3(0.6, 0.6, 0.6)
    item:SetData(1, itemData, 1, false, scale, nil, true)
    local haveCount = data.hasCount
    if (haveCount ~= nil) then
        if haveCount < data.count then
            haveCount = string.format("<color=#FF0000>%d</color>", LuaMgr.NumFormat(haveCount))
        else
            haveCount = LuaMgr.NumFormat(haveCount)
        end
        self["textRatio" .. index].text = haveCount .. "/" .. LuaMgr.NumFormat(data.count)
    else
        self["textRatio" .. index].text = data.count
    end
end

function TalentCompoundItemGroup:HideItemList()
    for k, v in pairs(self.itemList) do
        v:Hide()
    end
end

function TalentCompoundItemGroup:ClearItemList()
    for k, v in pairs(self.itemList) do
        v:Clear()
    end
    self.itemList = nil
end

function TalentCompoundItemGroup:Clear()
    self.data = nil
end

function TalentCompoundItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end