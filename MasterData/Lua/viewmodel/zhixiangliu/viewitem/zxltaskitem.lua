








ZXLTaskItem = {}
ZXLTaskItem.__index = ZXLTaskItem

local objs = {
    getRewardBtn = {path = "Group/NormalBG/GetRewardBtn", type = UITool.Button},
    getRewardObj = {path = "Group/NormalBG", type = UITool.GameObject},
    gotoTaskBtn = {path = "Group/NoCompleteBG/GotoBtn", type = UITool.Button},
    nocompleteObj = {path = "Group/NoCompleteBG", type = UITool.GameObject},
    descText = {path = "Group/DescText", type = UITool.Text},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    gotObj = {path = "Group/GotBG", type = UITool.GameObject},
    gotDescText = {path = "Group/GotBG/DescText", type = UITool.Text}
}

ZXLTaskItem.New = function()

    local self = {}
    setmetatable(self, ZXLTaskItem)
    return self
end

function ZXLTaskItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs)
    self.GetAwardResponse = function()
        self:SetStatus()
    end
    self.OnClickGet = function()
        local callBack = function()
            if self.data.callbackGetReward ~= nil then
                self.data.callbackGetReward(self)
            end
        end
        DataExHelper.EX_GetAward(self.data.config.id, callBack)
    end
    self.OnClickGotoTask = function()
        if self.data.callbackGotoTask ~= nil then
            self.data.callbackGotoTask(self)
        end
    end
    LuaMgr.AddClick(self.getRewardBtn, self.OnClickGet)
    LuaMgr.AddClick(self.gotoTaskBtn, self.OnClickGotoTask)
end

function ZXLTaskItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function ZXLTaskItem:SetItem()
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

function ZXLTaskItem:SetStatus()
    SetActive(self.gotObj, false)
    SetActive(self.getRewardObj, false)
    SetActive(self.nocompleteObj, false)
    local questData = DataMgr.Player.quests[self.data.config.id]
    local status = questData and questData.state or 1
    local remarksLan = LuaMgr.GetLangText(self.data.config.remarksLan)
    if status == 1 then
        SetActive(self.nocompleteObj, true)
        self.descText.text = string.format("<color=#F0F2F7>%s</color>", remarksLan)
    elseif status == 2 then
        SetActive(self.getRewardObj, true)
        self.descText.text = string.format("<color=#687291>%s</color>", remarksLan)
    elseif status == 3 then
        self.gotDescText.text = string.format("<color=#F0F2F7>%s</color>", remarksLan)
        SetActive(self.gotObj, true)
    end
end

function ZXLTaskItem:ClearItems()
end

function ZXLTaskItem:Clear()
    self:ClearItems()
end

function ZXLTaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end