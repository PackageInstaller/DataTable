FoodComposeMissionItem = {};

FoodComposeMissionItem.__index = FoodComposeMissionItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    name = { path = "Group/Name", type = "Text" },
    icon = { path = "Group/Icon", type = "RawImage" },
    msgText = { path = "Group/Msg/Text", type = "Text" },
    itemsListTF = { path = "Group/Items/List", type = "Transform" },
    complete = { path = "Group/Complete", type = "GameObject" },
    light = { path = "Group/Light", type = "GameObject" },
    complete2 = { path = "Group/Complete2", type = "GameObject" },
    mask = { path = "Group/Mask", type = "GameObject" },
};

function FoodComposeMissionItem.New()
    local self = {};    
    setmetatable(self, FoodComposeMissionItem);
    return self;
end

function FoodComposeMissionItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.OnClickItem = function()
        local questData = DataMgr.Player.quests[self.data.config.id];
        if (questData ~= nil and questData.state == 2) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.FoodComposeMissionGetReward, questData.id);
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function FoodComposeMissionItem:SetData(data)
    self.data = data.data;
    SetActive(self.complete, false);
    SetActive(self.light, false);
    SetActive(self.complete2, false);
    SetActive(self.mask, false);
    self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
    self.icon.texture = FoodComposeMgr.GetTexture(self.data.config.parameter);
    self.msgText.text = LuaMgr.GetLangText(self.data.config.remarksLan);
    if (self.data.complete) then
        SetActive(self.complete2, true);
        SetActive(self.mask, true);
    else
        local questData = DataMgr.Player.quests[self.data.config.id];
        if (questData ~= nil) then
            if (questData.state == 2) then
                SetActive(self.complete, true);
                SetActive(self.light, true);
            elseif (questData.state == 3) then
                SetActive(self.complete2, true);
                SetActive(self.mask, true);
            end
        end
    end
    self:SetItemList();
end

function FoodComposeMissionItem:SetItemList()
    local item;
    local itemData;
    local itemMap = ConfigMgr.Config.itemMap;
    local scale = Vector3(0.6, 0.6, 0.6);
    local rewards = self.data.config.reward;
    local len = #rewards;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.itemsListTF);
            self.itemList[i] = item;
        end
        itemData = table.Copy(itemMap[rewards[i].id]);
        itemData.count0 = rewards[i].count;
        item:SetData(i, itemData, 1, false, scale, false);
    end
end

function FoodComposeMissionItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function FoodComposeMissionItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function FoodComposeMissionItem:Clear()
    self.data = nil;
    self:HideItemList();
end

function FoodComposeMissionItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    self:ClearItemList();
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end