



















DispatchRewardItem = {}
DispatchRewardItem.__index = DispatchRewardItem

local objs = {
    bgNormal = {path = "Group/BGNormal", type = UITool.GameObject},
    bgGot1 = {path = "Group/BGGot1", type = UITool.GameObject},
    bgGot2 = {path = "Group/BGGot2", type = UITool.GameObject},
    noneObj = {path = "Group/NoneObj", type = UITool.GameObject},
    gotObj = {path = "Group/GotObj", type = UITool.GameObject},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    name = {path = "Group/Name", type = UITool.Text},
    getRewardBtn = {path = "Group/GetRewardBtn", type = UITool.Button},
    redIconListener = {path = "Group", type = UITool.RedIconListener}
}

DispatchRewardItem.New = function()

    local self = {}
    setmetatable(self, DispatchRewardItem)
    return self
end

function DispatchRewardItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs)
    self.getRewardCallback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local reward = json.encode(res.result)
        LuaMgr.ShowItemRewared(reward)
        DispatchData.RefreshDispatchData(self.data.config.Group)
        DispatchData.CheckRedPoint()
        self:SetData()
    end
    local clickBtn = function()
        local data = {}
        if self.data.zoneRewardStatus == DispatchData.GetRewardStatus.CanGet then
            data.ID = self.data.id
            ApiMgr.Request("dispatch/reward", data, true, self.getRewardCallback, nil, true)
        else
            local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22314")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        end
    end
    LuaMgr.AddClick(self.getRewardBtn, clickBtn)
end

function DispatchRewardItem:SetData(data)
    if data ~= nil then
        self.data = data.data
    end
    self.redIconListener.RedId = "16101_" .. self.data.id
    local num = 0
    if self.data.zoneRewardStatus == DispatchData.GetRewardStatus.CanGet then
        num = 1
    end
    RedMgr.Singleton:UpdateClientRedData(self.redIconListener.RedId, num)
    self:SetItem()
end

function DispatchRewardItem:SetItem()
    local txt1 = LuaMgr.GetLangText(self.data.config.NameLan)
    local txt2 = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22105")
    local str = string.format(txt2, txt1)
    SetActive(self.bgGot1, self.data.zoneRewardStatus == DispatchData.GetRewardStatus.Got)
    SetActive(self.bgGot2, self.data.zoneRewardStatus == DispatchData.GetRewardStatus.Got)
    SetActive(self.noneObj, self.data.zoneRewardStatus == DispatchData.GetRewardStatus.None)
    SetActive(self.getRewardBtn.gameObject, self.data.zoneRewardStatus == DispatchData.GetRewardStatus.CanGet)
    if self.data.zoneRewardStatus == DispatchData.GetRewardStatus.Got then
        self.name.text = BalatroUtil.ColorText("#FFF6DD", str)
    else
        self.name.text = BalatroUtil.ColorText("#593E23", str)
    end
    for key, value in pairs(self.rewardItems) do
        SetActive(value.gameObject, false)
    end
    for i = 1, #self.data.config.Reward do
        local item = self.rewardItems[i]
        if item ~= nil then
            SetActive(item.gameObject, true)
        else
            local goodsData = GoodsDataItem.New(self.itemParent)
            table.insert(self.rewardItems, goodsData)
        end
        local itemConfig = self.data.config.Reward[i]
        item = self.rewardItems[i]
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemConfig.id])
        item:SetData(i, itemData, 1, false, Vector3(0.5, 0.5, 0.5), false, false)
        item:SetCount(string.format("%d", itemConfig.count))
        item:SetIconBg(false)
    end
end

function DispatchRewardItem:ClearItems()
end

function DispatchRewardItem:Clear()
    self:ClearItems()
end

function DispatchRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end