ParkourLevelItem = {};

ParkourLevelItem.__index = ParkourLevelItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    lockGO = { path = "Group/Lock", type = "GameObject" },
    lockText = { path = "Group/Lock/Text", type = "Text" },
    icon = { path = "Group/Icon", type = "Image" },
    num = { path = "Group/Num", type = "Image" },
    scoreGO = { path = "Group/Score", type = "GameObject" },
    scoreText = { path = "Group/Score/Text", type = "Text" },
    scoreEffect = { path = "Group/Score/Effect_saoguang", type = "GameObject" },
    targetGO = { path = "Group/Target", type = "GameObject" },
    targetText = { path = "Group/Target/Text", type = "Text" },
    rewardsListTF = { path = "Group/Rewards/List", type = "Transform" },
    rewardsListCG = { path = "Group/Rewards/List", type = "CanvasGroup" },
    rewardsItem1 = { path = "Group/Rewards/Item1", type = "GameObject" },
    rewardsItem2 = { path = "Group/Rewards/Item2", type = "GameObject" },
    rewardsItem3 = { path = "Group/Rewards/Item3", type = "GameObject" },
    new = { path = "Group/New", type = "GameObject" },
};

function ParkourLevelItem.New()
    local self = {};    
    setmetatable(self, ParkourLevelItem);
    return self;
end

function ParkourLevelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.ParkourEnterResponse = function()
        LuaMgr.ShowLuaPanel(UIName.ParkourViewModel, self.data.config);
    end
    self.OnClickItem = function()
        if (self:IsUnlock(self.data.config)) then
            ApiMgr.Request("dunhuang/parkourEnter", {LevelId=self.data.config.LevelID}, true, self.ParkourEnterResponse, nil, true, true);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ParkourLevelItem_0"));
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function ParkourLevelItem:SetData(data)
    self.data = data.data;
    self.icon.sprite = LuaMgr.GetSprite("Parkour", "ui_hd_dh_pk_gk_hw0" .. self.data.num);
    self.num.sprite = LuaMgr.GetSprite("Parkour", "ui_hd_dh_pk_gk_z0" .. self.data.num);
    SetActive(self.lockGO, false);
    SetActive(self.scoreGO, false);
    SetActive(self.scoreEffect, false);
    SetActive(self.targetGO, false);
    SetActive(self.rewardsItem1, false);
    SetActive(self.rewardsItem2, false);
    SetActive(self.rewardsItem3, false);
    SetActive(self.new, false);
    if (self:IsUnlock(self.data.config)) then
        local score = self:GetScore(self.data.config.LevelID);
        if (score <= 0) then
            self.scoreText.text = LuaMgr.GetLangText("ParkourLevelItem_1");
            SetActive(self.new, true);
        else
            self.scoreText.text = LuaMgr.GetLangText("ParkourLevelItem_2") .. score;
            SetActive(self.scoreEffect, true);
        end
        self.targetText.text = LuaMgr.GetLangText("ParkourLevelItem_3") .. self.data.config.Score;
        SetActive(self.scoreGO, true);
        SetActive(self.targetGO, true);
        self:SetItemList(true);
        if (score >= self.data.config.Score) then
            SetActive(self.rewardsItem1, true);
            SetActive(self.rewardsItem2, true);
            SetActive(self.rewardsItem3, true);
            self.rewardsListCG.alpha = 0.5;
        else
            self.rewardsListCG.alpha = 1.0;
        end
    else
        self:SetItemList(false);
        local unlockType = self.data.config.UnlockType;
        if (unlockType == 1) then
            local unlockLevel = ConfigMgr.Config.DHParkourLevelMap[self.data.config.Unlock_1];
            if (unlockLevel ~= nil) then
                self.lockText.text = string.format(LuaMgr.GetLangText("ParkourLevelItem_4"), LuaMgr.GetLangText(unlockLevel.Unlock_1));
                SetActive(self.lockGO, true);
            end
        elseif (unlockType == 2) then
            local time = self.data.config.Unlock_2 - LuaMgr.Timestamp();
            self.lockText.text = string.format(LuaMgr.GetLangText("ParkourLevelItem_5"), self:GetUnlockTime(time));
            SetActive(self.lockGO, true);
        end
    end
end

function ParkourLevelItem:IsUnlock(level)
    if (level.UnlockType == 1) then
        if (IsNullOrEmpty(level.Unlock_1)) then return true end

        local levelConfig = ConfigMgr.Config.DHParkourLevelMap[level.Unlock_1];
        if (levelConfig ~= nil) then
            if (self:GetScore(level.Unlock_1) >= levelConfig.Score) then
                return true;
            end
        end
        return false;
    elseif (level.UnlockType == 2) then
        return LuaMgr.Timestamp() > level.Unlock_2;
    end
    return true;
end

function ParkourLevelItem:GetScore(levelId)
    local score = DataMgr.Player.DunHuang.ParkourMap[levelId];
    if (score ~= nil) then
        return score;
    end
    return 0;
end

function ParkourLevelItem:SetItemList(status)
    if (status) then
        local item;
        local itemData;
        local itemMap = ConfigMgr.Config.itemMap;
        local scale = Vector3(0.6, 0.6, 0.6);
        local rewards = self.data.config.Reward;
        local len = #rewards;
        for i = 1, len do
            item = self.itemList[i];
            if (item == nil) then
                item = GoodsDataItem.New(self.rewardsListTF);
                self.itemList[i] = item;
            end
            itemData = table.Copy(itemMap[rewards[i].id]);
            itemData.count0 = rewards[i].count;
            item:SetData(i, itemData, 1, false, scale, false);
        end
    else
        self:HideItemList();
    end
end

function ParkourLevelItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function ParkourLevelItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function ParkourLevelItem:GetUnlockTime(time)
    local d,h,m = GetTimeDHM(time);
    local timeStr = "";
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    else
        if (not IsNullOrEmpty(h)) then
            timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
        end
        if (not IsNullOrEmpty(m)) then
            timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
        end
    end
    return timeStr;
end

function ParkourLevelItem:Clear()
    self.data = nil;
    self.num.sprite = nil;
    self:HideItemList();
end

function ParkourLevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    self:ClearItemList();
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end