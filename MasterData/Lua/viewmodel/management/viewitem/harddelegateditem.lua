








HardDelegatedItem = {}
HardDelegatedItem.__index = HardDelegatedItem

local objs = {
    unlockBtn = {path = "Unlock", type = UITool.Button},
    lockBtn = {path = "Lock", type = UITool.Button},
    rewardParent = {path = "Unlock/RewardParent", type = UITool.ScrollRect},
    desc = {path = "Unlock/Desc", type = UITool.Text}
}


function HardDelegatedItem.New(gameObjct, clickCallback, rewardItem)

    local self = {}
    setmetatable(self, HardDelegatedItem)
    self.clickCallback = clickCallback
    self:Init(gameObjct)
    self.rewardItemPrefab = rewardItem
    self.rewardItems = {}
    self.isUnlock = false
    return self
end

function HardDelegatedItem:Init(gameObjct)
    for i = 1, 3 do
        local name = "scoreLevel" .. i
        local data = {}
        data.path = "Unlock/ScoreLevel" .. i
        data.type = UITool.GameObject
        objs[name] = data
    end
    UITool.Parse(gameObjct, self, objs)
    local callBack = function()
        if self.clickCallback then
            self.clickCallback(self)
        end
    end
    LuaMgr.AddClick(self.unlockBtn, callBack)

    local tipsCallback = function ()
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27115")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
    end
    LuaMgr.AddClick(self.lockBtn, tipsCallback)
    self.scrollViewUI = UIScrollView.New(self.rewardParent)
end

function HardDelegatedItem:SetData(data)
    self.data = data
    local isFinish = ManagementData.CheckFinish(data)
    self.isUnlock = ManagementData.CheckUnlock(data)
    local isUnlock = self.isUnlock
    SetActive(self.unlockBtn.gameObject, true)
    SetActive(self.lockBtn.gameObject, false)
    if isUnlock == true and isFinish == true then
        local raring = DataExHelper.GetDungeonDecordRating(data.eventParam)
        for i = 1, 3 do
            local name = "scoreLevel" .. i
            local obj = self[name]
            SetActive(obj, i == raring)
        end
    elseif isUnlock == true then
        for i = 1, 3 do
            local name = "scoreLevel" .. i
            local obj = self[name]
            SetActive(obj, false)
        end
    else
        SetActive(self.unlockBtn.gameObject, false)
        SetActive(self.lockBtn.gameObject, true)
    end
    self.desc.text = LuaMgr.GetLangText(data.descriptionlan)
    self:SetReward(data)
end

function HardDelegatedItem:SetReward(config)
    local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam]
    local rewardMap = {}
    if IsNull(dungeon) then
        return
    end
    for i, v in ipairs(dungeon.firstDrop) do
        local items = ConfigMgr.Config.dropMap[v.id].items
        for p, m in ipairs(items) do
            if rewardMap[m.id] == nil then
                rewardMap[m.id] = m.count
            else
                rewardMap[m.id] = rewardMap[m.id] + m.count
            end
        end
    end
    local raring = DataExHelper.GetDungeonDecordRating(config.eventParam)
    local allDatas = {}
    for id, v in pairs(rewardMap) do
        local itemConfig = ConfigMgr.Config.itemMap[id]
        if (itemConfig == nil) then
            return
        end
        local tempData = {}
        tempData.id = id
        tempData.count = v
        tempData.status = raring > 0 and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
        tempData.scale = 0.6
        table.insert(allDatas, tempData)
    end

    local scrollDatas = {}
    local datasLen = #allDatas
    for i = 1, datasLen do
        local data = allDatas[i]
        local tempData = UIScrollData.GetData(self.rewardItemPrefab, "CommonRewardItem", 80, 80, data)
        table.insert(scrollDatas, tempData)
    end
    self.scrollViewUI:SetParams(239, 80)
    self.scrollViewUI:SetData(scrollDatas, true)
end

function HardDelegatedItem:Clear()
    self.data = nil
end

function HardDelegatedItem:Destroy()
    LuaMgr.Destroy(self.gameObject)
    UIScrollView.ClearItem("CommonRewardItem")
    self.gameObject = nil
    self.scrollViewUI = nil
end