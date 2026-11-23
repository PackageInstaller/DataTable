ZGCXRewardItem = {};

ZGCXRewardItem.__index = ZGCXRewardItem;

local objs = {
    animator = { path = "", type = "Animator" },
    group = { path = "Group", type = "CanvasGroup" },
    groupBtn = { path = "Group/Btn", type = "Button" },
    unDone = { path = "Group/ImgUnDone", type = "GameObject" },
    done = { path = "Group/ImgDone", type = "GameObject" },
    get = { path = "Group/ImgGet", type = "GameObject" },
    itemName = { path = "Group/Name", type = "Text" },
    rewardBox = { path = "Group/RewardBox", type = "Transform" },
};

function ZGCXRewardItem.New()
    local self = {};
    setmetatable(self, ZGCXRewardItem);
    return self;
end

function ZGCXRewardItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.LightEvent) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end
        if (self.state ~= 2) then
            return
        end
        DataExHelper.EX_GetAward(self.data.id, function(_result)
            if (self.callback ~= nil) then
                self.callback()
                LuaMgr.InvokeUIEventListeners(UIEventConst.ZGCXMsgShow);
            end
        end)
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function ZGCXRewardItem:SetData(data)
    self.data = data.data.config;
    self.callback = data.data.callback
    if (self.rewardItems ~= nil) then
        for k, v in pairs(self.rewardItems) do
            v:Hide();
        end
    end
    local num = 0
    for key, value in pairs(self.data.reward) do
        num = num + 1
        if (self.rewardItems[num] == nil) then
            self.rewardItems[num] = GoodsDataItem.New(self.rewardBox);
        end
        local rewardObj = self.rewardItems[num]
        local itemData = table.Copy(ConfigMgr.Config.itemMap[value.id]);
        itemData.count0 = value.count
        rewardObj:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 0.6), false);
    end
    self:RefreshData()
end

function ZGCXRewardItem:RefreshData()
    self.state = DataExHelper.Check_RewardState(self.data.id);
    self.unDone:SetActive(self.state == 1 or self.state == 0)
    self.done:SetActive(self.state == 3)
    self.get:SetActive(self.state == 2)
    local color = nil
    if (self.state == 2 or self.state == 3) then
        color = "727555"
    else
        color = "737486"
    end
    local str = LuaMgr.GetLangText(self.data.remarksLan)
    self.itemName.text = string.format("<color=#%s>%s</color>", color, str)
    self.group.alpha = self.state ~= 3 and 1.0 or 0.6
end

function ZGCXRewardItem:Clear()
    self.data = nil;
end

function ZGCXRewardItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end