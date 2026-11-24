






BossTaskSpecialItem = {}
BossTaskSpecialItem.__index = BossTaskSpecialItem

local objs = {
    linObj = {path = "Group/Line", type = UITool.GameObject},
    canGetObj = {path = "Group/CanGet", type = UITool.GameObject},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    progress = {path = "Group/Progress", type = UITool.Text},
    gotObj = {path = "Group/GotObj", type = UITool.GameObject},
    getRewardBtn = {path = "Group", type = UITool.Button}
}

function BossTaskSpecialItem.New(prefab, parent)

    local self = {}
    setmetatable(self, BossTaskSpecialItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    LuaMgr.AddClick(self.getRewardBtn, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.colIndex);
        end
      end)
    return self
end










function BossTaskSpecialItem:SetData(data)
    self.data = data
    SetActive(self.gotObj, self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.canGetObj, self.data.Status == CommonRewardItem.Status.CanGet)
    self.progress.text=SeasonSLGEventMgr.GetProgressName(self.data.Condition.Count)
    if self.data.isLast == true then
        self.linObj.gameObject:SetActive(false)
    else
        self.linObj.gameObject:SetActive(true)
    end
    self:SetItem()
end

function BossTaskSpecialItem:SetItem()
    if not IsNull(self.data.Reward) then
        if (self.item == nil) then
            self.item = GoodsDataItem.New(self.itemParent)
        end
        local reward = self.data.Reward[1]
        local itemConfig = ConfigMgr.Config.itemMap[reward.id]
        if itemConfig ~= nil then
            local itemData = table.Copy(itemConfig)
            itemData.count0 = reward.count
            self.item:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 1), false)
            self.item:SetCount(nil, Vector2(-10, 10), Vector3.one)
            self.item:SetIconBg(false)
        end
    else
        if (self.item ~= nil) then
            self.item:Hide()
        end
    end
end

function BossTaskSpecialItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function BossTaskSpecialItem:Destroy()
    if self.OnClickItem ~= nil then
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end