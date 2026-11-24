SeasonSLGMainPageTaskItem = {};

SeasonSLGMainPageTaskItem.__index = SeasonSLGMainPageTaskItem;
local objs = {
    root={ path = "root", type = "Transform" },
    rewardedObj={ path = "root/rewarded", type = "GameObject" },
    progressObj={ path = "root/progress", type = "GameObject" },
    rewardBtn={ path = "root/rewarding", type = "Button" },
    desc={ path = "root/Text", type = "Text" },
    progress={ path = "root/progress/Text", type = "Text" },
    transRewardParent={ path = "root/grid", type = "RectTransform" },
};

function SeasonSLGMainPageTaskItem.New()
    local self = {};
    setmetatable(self, SeasonSLGMainPageTaskItem);
    self.onClick = nil
    self.rewardItemList = nil
    return self;
end

function SeasonSLGMainPageTaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject, true);
    if self.rewardItemList == nil then
        self.rewardItemList = {};
    end
    self.onClick = function()
        if self.data ~= nil and self.data.canGet == true and self.data.rewardCallBack ~= nil then
            self.data.rewardCallBack(self.data.id);
        end
    end
    LuaMgr.AddClick(self.rewardBtn, self.onClick)
end

function SeasonSLGMainPageTaskItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    self.progress.text = self.data.current .. "/" .. self.data.target
    SetActive(self.progressObj,not self.data.isDone and not self.data.canGet)
    self:SetDesc(self.data.config);
    self:SetReward(self.data.config);
    SetActive(self.rewardedObj, self.data.isDone == true);
    SetActive(self.rewardBtn.gameObject, self.data.canGet == true);
end

function SeasonSLGMainPageTaskItem:SetDesc(config)
    if self.desc == nil or config == nil then
        return;
    end
    local desc = "";
    if not IsNullOrEmpty(config.DescLan) then
        desc = LuaMgr.GetLangText(config.DescLan);
    end
    if IsNullOrEmpty(desc) then
        desc = config.Desc or "";
    end
    self.desc.text = desc;
end

function SeasonSLGMainPageTaskItem:SetReward(config)
    self:ClearReward();
    if config == nil or IsNull(config.Reward) or self.transRewardParent == nil then
        return;
    end
    for i, v in ipairs(config.Reward) do
        local itemConfig = ConfigMgr.Config.itemMap[v.id];
        if itemConfig ~= nil then
            if self.rewardItemList[i] == nil then
                self.rewardItemList[i] = GoodsDataItem.New(self.transRewardParent);
            end
            local itemData = table.Copy(itemConfig);
            itemData.count0 = v.count;
            SetActive(self.rewardItemList[i].gameObject, true);
            self.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.4, 0.4, 0.4), false);
        end
    end
end

function SeasonSLGMainPageTaskItem:ClearReward()
    if self.rewardItemList == nil then
        return;
    end
    for i, v in ipairs(self.rewardItemList) do
        SetActive(v.gameObject, false);
    end
end

function SeasonSLGMainPageTaskItem:Clear()
    self.data = nil;
    self:ClearReward();
end

function SeasonSLGMainPageTaskItem:Destroy()
    if self.rewardBtn ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.rewardBtn, self.onClick)
    end
    self.onClick = nil;
    if self.rewardItemList ~= nil then
        for i, v in ipairs(self.rewardItemList) do
            v:Clear();
        end
        self.rewardItemList = {};
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end