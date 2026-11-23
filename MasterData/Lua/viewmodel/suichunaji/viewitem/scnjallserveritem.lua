






SCNJAllServerItem = {}
SCNJAllServerItem.__index = SCNJAllServerItem

local objs = {
    linObj = {path = "Group/Line", type = UITool.GameObject},
    canGetObj = {path = "Group/CanGet", type = UITool.GameObject},
    itemParent = {path = "Group/ItemParent", type = UITool.Transform},
    progress = {path = "Group/Progress", type = UITool.Text},
    gotObj = {path = "Group/GotObj", type = UITool.GameObject},
    getRewardBtn = {path = "Group", type = UITool.Button}
}

function SCNJAllServerItem.New(prefab, parent)

    local self = {}
    setmetatable(self, SCNJAllServerItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickGet = function()
        if SCNJData.CheckActivityRunning() == false then
            return
        end
        if self.data.Status ~= CommonRewardItem.Status.CanGet then
            return
        end
        local callBack = function(result)
            local res = json.decode(result)
            if res.code ~= nil and res.code ~= 0 then
                return
            end
            local resultData = res.result
            if type(resultData) == "table" and type(resultData.Reward) == "table" and type(resultData.Reward.Items) == "table" then
                local rewardDatas = {}
                for i, v in pairs(resultData.Reward.Items) do
                    local item = {ID = v.id, Count = v.count}
                    table.insert(rewardDatas, item)
                end
                LuaMgr.ShowItemGetPanel(rewardDatas)
            end
            if self.data.callbackGetReward ~= nil then
                self.data.callbackGetReward(self)
            end
        end
        local data = {}
        ApiMgr.Request("bossRelay/hotReward", data, true, callBack, nil, true)
    end
    LuaMgr.AddClick(self.getRewardBtn, self.OnClickGet)
    return self
end

function SCNJAllServerItem:SetData(data)
    self.data = data
    SetActive(self.gotObj, self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.canGetObj, self.data.Status == CommonRewardItem.Status.CanGet)
    local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29624")
    self.progress.text = string.format(lanStr .. " %.0f%%", self.data.Config.Level, self.data.Config.Progress / SCNJConst.HotExpPercentBase * 100)
    if self.data.isLast == true then
        self.linObj.gameObject:SetActive(false)
    else
        self.linObj.gameObject:SetActive(true)
    end
    self:SetItem()
end

function SCNJAllServerItem:SetItem()
    if not IsNull(self.data.Reward) then
        if (self.item == nil) then
            self.item = GoodsDataItem.New(self.itemParent)
        end
        local reward = self.data.Reward
        local itemConfig = ConfigMgr.Config.itemMap[reward.id]
        if itemConfig ~= nil then
            local itemData = table.Copy(itemConfig)
            itemData.count0 = reward.count
            self.item:SetData(1, itemData, 1, false, Vector3(reward.scale, reward.scale, 1), false)
            self.item:SetCount(nil, Vector2(-10, 10), Vector3.one)
            self.item:SetIconBg(false)
        end
    else
        if (self.item ~= nil) then
            self.item:Hide()
        end
    end
end

function SCNJAllServerItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function SCNJAllServerItem:Destroy()
    if self.OnClickItem ~= nil then
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end