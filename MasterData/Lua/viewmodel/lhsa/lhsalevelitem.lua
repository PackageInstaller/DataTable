LHSALevelItem = {};

LHSALevelItem.__index = LHSALevelItem;

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

function LHSALevelItem.New()
    local self = {};
    setmetatable(self, LHSALevelItem);
    return self;
end

function LHSALevelItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.LHSA) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end
        if (self.state ~= 2) then
            return
        end
        local ids = {}
        for k, v in pairs(self.totalDataList) do
            local state = DataExHelper.Check_RewardState(v.id);
            if (state == 2) then
                table.insert(ids, v.id)
            end
        end
        DataExHelper.EX_GetAwards(ids, function(_result)
            if (self.callback ~= nil) then
                self.callback()
            end
        end)
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function LHSALevelItem:SetData(data)
    self.data = data.data.config;
    self.totalDataList = data.data.totalList
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
        rewardObj:SetData(1, itemData, 1, false, Vector3(0.5, 0.5, 0.5), false);
    end
    self:RefreshData()
end

function LHSALevelItem:RefreshData()
    self.state = DataExHelper.Check_RewardState(self.data.id);
    self.unDone:SetActive(self.state == 1 or self.state == 0)
    self.done:SetActive(self.state == 3)
    self.get:SetActive(self.state == 2)
    self.itemName.text = LuaMgr.GetLangText(self.data.remarksLan)
    self.group.alpha = self.state ~= 3 and 1.0 or 0.6
end

function LHSALevelItem:Clear()
    self.data = nil;
end

function LHSALevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end