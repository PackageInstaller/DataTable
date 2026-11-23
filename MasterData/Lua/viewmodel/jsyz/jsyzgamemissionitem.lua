JSYZGameMissionItem = {};

JSYZGameMissionItem.__index = JSYZGameMissionItem;

local objs = {
    groupBtn = { path = "Group/Group", type = "Button" },
    group = { path = "Group/Group", type = "GameObject" },
    name = { path = "Group/Group/Name", type = "Text" },
    msgText = { path = "Group/Group/Msg/Text", type = "Text" },
    itemsBgListTF = { path = "Group/Group/Items/BgList", type = "Transform" },
    itemsListTF = { path = "Group/Group/Items/List", type = "Transform" },
    complete = { path = "Group/Group/Items/CompleteList", type = "Transform" },
    light = { path = "Group/Group/Light", type = "GameObject" },
    mask = { path = "Group/Group/Mask", type = "GameObject" },
};

function JSYZGameMissionItem.New()
    local self = {};
    setmetatable(self, JSYZGameMissionItem);
    return self;
end

function JSYZGameMissionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.OnClickItem = function()
        local questData = DataMgr.Player.quests[self.data.config.id];
        if (questData ~= nil and questData.state == 2) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.YPSGameMissionGetReward, questData.id);
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function JSYZGameMissionItem:SetData(data)
    self.data = data.data;
    SetActive(self.complete.gameObject, false);
    SetActive(self.light, false);
    SetActive(self.mask, false);
    self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
    self.msgText.text = LuaMgr.GetLangText(self.data.config.remarksLan);
    if (self.data.complete) then
        SetActive(self.mask, true);
        SetActive(self.complete.gameObject, true);
    else
        local questData = DataMgr.Player.quests[self.data.config.id];
        if (questData ~= nil) then
            if (questData.state == 2) then
                SetActive(self.light, true);
            elseif (questData.state == 3) then
                SetActive(self.mask, true);
                SetActive(self.complete.gameObject, true);
            end
        end
    end
    if self.data.num % 2 == 1 then
        self.group.transform.anchoredPosition = Vector2(0, -60)
    else
        self.group.transform.anchoredPosition = Vector2(0, 20)
    end
    self:SetItemList();
end

function JSYZGameMissionItem:SetItemList()
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
    for i = 0, self.itemsBgListTF.childCount - 1 do
        self.itemsBgListTF:GetChild(i).gameObject:SetActive(i < len);
    end
    for i = 0, self.complete.childCount - 1 do
        self.complete:GetChild(i).gameObject:SetActive(i < len);
    end
end

function JSYZGameMissionItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function JSYZGameMissionItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function JSYZGameMissionItem:Clear()
    self.data = nil;
    self:HideItemList();
end

function JSYZGameMissionItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    self:ClearItemList();
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end