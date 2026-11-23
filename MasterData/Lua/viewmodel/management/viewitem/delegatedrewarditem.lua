






DelegatedRewardItem = {}
DelegatedRewardItem.__index = DelegatedRewardItem

local objs = {
    descText = {path = "Group/DescText", type = UITool.Text},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    getRewardBtn = {path = "Group/GetRewardBtn", type = UITool.Button},
    gotFlag = {path = "Group/GotFlag", type = UITool.GameObject},
    noCompleteFlag = {path = "Group/NoCompleteFlag", type = UITool.GameObject}
}

DelegatedRewardItem.New = function()

    local self = {}
    setmetatable(self, DelegatedRewardItem)
    return self
end

function DelegatedRewardItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs)
    self.GetAwardResponse = function()
        self:SetStatus()
    end
    self.OnClickGet = function()
        local callBack = function()
            if self.data.callback ~= nil then
                self.data.callback()
            end
        end
        DataExHelper.EX_GetAward(self.data.config.id, callBack)
    end
    LuaMgr.AddClick(self.getRewardBtn, self.OnClickGet)
end

function DelegatedRewardItem:SetData(data)
    if data ~= nil then
        self.data = data.data
    end
    self:SetItem()
end

function DelegatedRewardItem:SetItem()
    self.descText.text = LuaMgr.GetLangText(self.data.config.remarksLan)
    for key, value in pairs(self.rewardItems) do
        SetActive(value.gameObject, false)
    end
    local scale = 0.55
    local rewards = self.data.config.showReward
    for i = 1, #rewards do
        local item = self.rewardItems[i]
        if item ~= nil then
            SetActive(item.gameObject, true)
        else
            local goodsData = GoodsDataItem.New(self.itemParent)
            table.insert(self.rewardItems, goodsData)
        end
        local itemConfig = rewards[i]
        item = self.rewardItems[i]
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemConfig.id])

        item:SetData(i, itemData, 1, false, Vector3(scale, scale, scale), false, false)
        item:SetCount(string.format("%d", itemConfig.count))
        item:SetIconBg(false)
    end
    self:SetStatus()
end

function DelegatedRewardItem:SetStatus()
    SetActive(self.gotFlag, false)
    SetActive(self.getRewardBtn.gameObject, false)
    SetActive(self.noCompleteFlag, false)
    local questData = DataMgr.Player.quests[self.data.config.id]
    local status = questData and questData.state or 1
    if status == 1 then
        SetActive(self.noCompleteFlag, true)
    elseif status == 2 then
        SetActive(self.getRewardBtn.gameObject, true)
    elseif status == 3 then
        SetActive(self.gotFlag, true)
    end
end

function DelegatedRewardItem:ClearItems()
end

function DelegatedRewardItem:Clear()
    self:ClearItems()
end

function DelegatedRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end