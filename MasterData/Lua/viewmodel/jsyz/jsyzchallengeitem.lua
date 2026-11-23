JSYZChallengeItem = {}
JSYZChallengeItem.__index = JSYZChallengeItem

local objs = {
    animator = { path = "", type = UITool.Animator },
    selectBtn = { path = "Group/Group", type = UITool.Button },
    group = { path = "Group/Group", type = UITool.GameObject },
    canvasGroup = { path = "Group/Group", type = UITool.CanvasGroup },
    textTitle = { path = "Group/Group/TextTitle", type = UITool.Text },
    titleImage1 = { path = "Group/Group/TextTitle/TitleImage1", type = UITool.GameObject },
    titleImage2 = { path = "Group/Group/TextTitle/TitleImage2", type = UITool.GameObject },
    finishBg = { path = "Group/Group/FinishBg", type = UITool.GameObject },
    textRating = { path = "Group/Group/FinishBg/TextRating", type = UITool.Text },
    BG_1_1 = { path = "Group/Group/BG_1_1", type = UITool.GameObject },
    LockBG_1_1 = { path = "Group/Group/LockBG_1_1", type = UITool.GameObject },
    BG_2_1 = { path = "Group/Group/BG_2_1", type = UITool.GameObject },
    Content = { path = "Group/Group/ScrollViewReward/Viewport/Content", type = "RectTransform" },
}

function JSYZChallengeItem.New()
    local self = {}
    setmetatable(self, JSYZChallengeItem)
    self.rewardList = {}
    return self
end

function JSYZChallengeItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.onClickCallback = function()


        if self.data.isUnlock == false then
            local tipsContent = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319"),
                self.data.unlockPassName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data and self.data.onClickCallback then
            self.data.onClickCallback(self)
        else
            LuaDebug.error("JSYZChallengeItem onClickCallback is nil")
        end
    end
    LuaMgr.AddClick(self.selectBtn, self.onClickCallback)
end

function JSYZChallengeItem:SetData(data)
    self.data = data.data
    local tempType = 1
    if self.data.config.type ~= 4 then
        tempType = 2
    end
    SetActive(self.BG_2_1, tempType == 2)
    SetActive(self.titleImage1, tempType == 1)
    SetActive(self.titleImage2, tempType == 2)
    local name1 = string.format("BG_1_%d", 1)
    local name2 = string.format("LockBG_1_%d", 1)
    SetActive(self[name1], tempType == 1)
    SetActive(self[name2], self.data.isUnlock == false)
    SetActive(self.textTitle.gameObject, self.data.isUnlock ~= false)
    self.textTitle.text = LuaMgr.GetLangText(self.data.config.namelan)
    self.textRating.text = self:GetRareText()
    SetActive(self.finishBg.gameObject, self.data.isFinish == true)
    local pageIndex = math.floor((data.id - 1) / 3) + 1
    local index = (data.id - 1) % 3 + 1
    if index % 2 == 0 then
        if pageIndex % 2 == 1 then
            self.group.transform.anchoredPosition = Vector2(0, -140)
        else
            self.group.transform.anchoredPosition = Vector2(0, -20)
        end
    else
        if pageIndex % 2 == 1 then
            self.group.transform.anchoredPosition = Vector2(0, -20)
        else
            self.group.transform.anchoredPosition = Vector2(0, -140)
        end
    end
    self:SetReward(self.data.config)


end

function JSYZChallengeItem:GetRareText()
    local rating = DataExHelper.GetDungeonDecordRating(self.data.config.eventParam)
    if (rating == 0) then
        return LuaMgr.GetLangText("YPSChallengeItem_0")
    elseif (rating == 1) then
        return LuaMgr.GetLangText("YPSChallengeItem_1")
    elseif (rating == 2) then
        return LuaMgr.GetLangText("YPSChallengeItem_2")
    elseif (rating == 3) then
        return LuaMgr.GetLangText("YPSChallengeItem_3")
    end
end

function JSYZChallengeItem:SetReward(config)
    local index = 1
    local itemData
    local scaleNum = 0.5
    local scale = Vector3(scaleNum, scaleNum, scaleNum)
    local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam]
    if IsNull(dungeon) then
        return
    end
    local itemDataLis = NumTool.split(dungeon.firstDropShow, ';')
    for k, v in pairs(itemDataLis) do
        local data = self.rewardList[index]
        if (data == nil) then
            local goodsItem = GoodsDataItem.New(self.Content)
            self.rewardList[index] = {
                item = goodsItem,
            }
            data = self.rewardList[index]
        end
        local itemConfig = ConfigMgr.Config.itemMap[v]
        if (itemConfig == nil) then
            return
        end
        itemData = table.Copy(itemConfig)
        data.item:SetData(index, itemData, 1, false, scale, false, true)
        index = index + 1
    end
    local len = #self.rewardList
    for i = index, len do
        self.rewardList[i].item:Hide()
    end
end

function JSYZChallengeItem:Clear()
    self:ClearItems()
end

function JSYZChallengeItem:ClearItems()
    self.data = nil
    if (self.rewardList ~= nil) then
        for k, v in pairs(self.rewardList) do
            v.item:Clear()
        end
        self.rewardList = {}
    end
end

function JSYZChallengeItem:Destroy()
end