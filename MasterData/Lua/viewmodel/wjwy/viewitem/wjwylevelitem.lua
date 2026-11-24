WJWYLevelItem = {};

WJWYLevelItem.__index = WJWYLevelItem;

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

function WJWYLevelItem.New(obj)
    local self = {};
    setmetatable(self, WJWYLevelItem);
    self.gameObject = obj;
    if obj ~= nil then
        self:Init();
    end
    return self;
end

function WJWYLevelItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.WJWY) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end
        if (self.state ~= 2) then
            return
        end
        local ids = {}
        if (self.totalDataList ~= nil) then
            for k, v in pairs(self.totalDataList) do
                local state = DataExHelper.Check_RewardState(v.id);
                if (state == 2) then
                    table.insert(ids, v.id)
                end
            end
        else
            if self.data ~= nil and self.data.id ~= nil then
                table.insert(ids, self.data.id)
            end
        end
        if #ids > 0 then
            DataExHelper.EX_GetAwards(ids, function(_result)
                if (self.callback ~= nil) then
                    self.callback()
                end
            end)
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function WJWYLevelItem:SetData(data)
    if data == nil then
        return
    end
    local itemData = data.data or data;
    self.data = itemData.config;
    self.totalDataList = itemData.totalList;
    self.callback = itemData.callback;
    if (self.rewardItems ~= nil) then
        for k, v in pairs(self.rewardItems) do
            v:Hide();
        end
    end
    local num = 0
    if self.data ~= nil and self.data.reward ~= nil then
        for key, value in pairs(self.data.reward) do
            num = num + 1
            if (self.rewardItems[num] == nil) then
                self.rewardItems[num] = GoodsDataItem.New(self.rewardBox);
            end
            local rewardObj = self.rewardItems[num]
            if ConfigMgr.Config.itemMap ~= nil and ConfigMgr.Config.itemMap[value.id] ~= nil then
                local itemMapData = table.Copy(ConfigMgr.Config.itemMap[value.id]);
                itemMapData.count0 = value.count
                rewardObj:SetData(1, itemMapData, 1, false, Vector3(0.5, 0.5, 0.5), false);
            end
        end
    end
    self:RefreshData()
end

function WJWYLevelItem:RefreshData()
    if self.data == nil then
        return
    end
    self.state = DataExHelper.Check_RewardState(self.data.id);
    if self.unDone ~= nil and not IsObjectNull(self.unDone) then
        self.unDone:SetActive(self.state == 1 or self.state == 0)
    end
    if self.done ~= nil and not IsObjectNull(self.done) then
        self.done:SetActive(self.state == 3)
    end
    if self.get ~= nil and not IsObjectNull(self.get) then
        self.get:SetActive(self.state == 2)
    end
    if self.itemName ~= nil and not IsObjectNull(self.itemName) then
        self.itemName.text = LuaMgr.GetLangText(self.data.remarksLan)
    end
    if self.group ~= nil and not IsObjectNull(self.group) then
        self.group.alpha = self.state ~= 3 and 1.0 or 0.6
    end
end

function WJWYLevelItem:Clear()
    self.data = nil;
    self.totalDataList = nil;
    self.callback = nil;
end

function WJWYLevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        if self.groupBtn ~= nil and not IsObjectNull(self.groupBtn) then
            LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        end
        self.OnClickItem = nil;
    end
    if self.rewardItems ~= nil then
        for k, v in pairs(self.rewardItems) do
            v:Clear()
        end
        self.rewardItems = nil
    end
    self.data = nil
    self.totalDataList = nil
    self.callback = nil
    if self.gameObject ~= nil and not IsObjectNull(self.gameObject) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
    end
    self.gameObject = nil;
end