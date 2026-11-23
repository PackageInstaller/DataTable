MiniBattle4LevelItem = {};

MiniBattle4LevelItem.__index = MiniBattle4LevelItem;

local objs = {
    ClickBtn = { path = "", type = "UIButtonClick" },
    AnimatorObj = { path = "Group", type = "GameObject" },
    BgGo_1 = { path = "Group/BG_1", type = "GameObject" },
    BgGo_2 = { path = "Group/BG_2", type = "GameObject" },
    BgGo_3 = { path = "Group/BG_3", type = "GameObject" },
    Text = { path = "Group/Text", type = "Text" },
    RewardContentTr = { path = "Group/RewardContent", type = "RectTransform" },
    RewardItemTemplate = { path = "Group/RewardContent/GoodsDataItem", type = "GameObject" },
    CanGetGo = { path = "Group/CanGet", type = "GameObject" },
    SelectedGo = { path = "Group/Selected", type = "GameObject" },
    LockGo = { path = "Group/Lock", type = "GameObject" },
    LockTips = { path = "Group/Lock/LockTips", type = "Text" },
}

function MiniBattle4LevelItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle4LevelItem);
    self.gameObject = obj
    return self;
end

function MiniBattle4LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.rewardItems = {}
    self.OnClickItem = function()
        if self.LockGo.activeSelf then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.LockTips.text);
            return
        end
        if self.data.isSelected and not self.data.isCanGet then
            return
        end
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.levelId)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
    SetActive(self.RewardItemTemplate, false)
    SetActive(self.AnimatorObj, false)
end

function MiniBattle4LevelItem:SetData(pdata)
    self.data = pdata.data;
    self.Text.text = self.data.descStr
    local rewards = self.data.rewards
    for i = 1, #rewards do
        if #self.rewardItems < i then
            table.insert(self.rewardItems, GoodsDataItem.New(self.RewardContentTr, self.RewardItemTemplate))
        end
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[rewards[i].id])
        itemConfig["count0"] = rewards[i].count
        self.rewardItems[i]:SetData(i, itemConfig, 1, false, Vector3(0.48, 0.48, 0.48), false)
        SetActive(self.rewardItems[i].transform:Find("Finish").gameObject, self.data.isFinished)
    end
    for i = #rewards + 1, #self.rewardItems do
        self.rewardItems[i]:Hide()
    end
    SetActive(self.BgGo_1, self.data.bgResName == "ui_dgxzs_dfbl_01")
    SetActive(self.BgGo_2, self.data.bgResName == "ui_dgxzs_dfbl_02")
    SetActive(self.BgGo_3, self.data.bgResName == "ui_dgxzs_dfbl_03")
    self:Refresh()

    if self.data.animBool then

        SetActive(self.AnimatorObj, true)
    end
end

function MiniBattle4LevelItem:Refresh()
    local status = MiniBattle4Mgr.GetPlotLevelStatus(self.data.levelId)
    if status == 3 then
        local unlockTime = MiniBattle4Mgr.GetLevelUnlockTime(self.data.levelId)
        self.LockTips.text = os.date(LuaMgr.GetLangText("MiniBattle4LevelItem_0"), unlockTime)
        SetActive(self.LockGo, true)
    else
        SetActive(self.LockGo, false)
    end
    SetActive(self.CanGetGo, self.data.isCanGet)
    SetActive(self.SelectedGo, self.data.isSelected)
end

function MiniBattle4LevelItem:Clear()
    self.data = nil;
    SetActive(self.AnimatorObj, false)
end

function MiniBattle4LevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    if self.rewardItems ~= nil then
        for i = 1, #self.rewardItems do
            self.rewardItems[i]:Clear()
        end
        self.rewardItems = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end