ActivityRoomRewardItem = {};

ActivityRoomRewardItem.__index = ActivityRoomRewardItem;

local objs = {
    msg = { path = "Group/Msg", type = "Text" },
    itemsTF = { path = "Group/Items", type = "Transform" },
    getGO = { path = "Group/Get", type = "GameObject" },
    getBtn = { path = "Group/Get", type = "Button" },
    unCompleteGO = { path = "Group/UnComplete", type = "GameObject" },
    receivedGO = { path = "Group/Received", type = "GameObject" },
    maskGO = { path = "Group/Mask", type = "GameObject" },
};

function ActivityRoomRewardItem.New()
    local self = {};    
    setmetatable(self, ActivityRoomRewardItem);
    return self;
end

function ActivityRoomRewardItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.GetAwardResponse = function()
        self:SetState();
    end
    self.OnClickGet = function()
        DataExHelper.EX_GetAward(self.data.id, self.GetAwardResponse);
    end
    LuaMgr.AddClick(self.getBtn, self.OnClickGet);
end

function ActivityRoomRewardItem:SetData(data)
    self.data = data.data;
    self.msg.text = LuaMgr.GetLangText(self.data.remarksLan);
    self:SetState();
    self:SetItems();
end

function ActivityRoomRewardItem:SetState()
    SetActive(self.getGO, false);
    SetActive(self.unCompleteGO, false);
    SetActive(self.receivedGO, false);
    SetActive(self.maskGO, false);
    local questData = DataMgr.Player.quests[self.data.id];
    if (questData ~= nil) then
        if (questData.state == 1) then
            SetActive(self.unCompleteGO, true);
        elseif (questData.state == 2) then
            SetActive(self.getGO, true);
        elseif (questData.state == 3) then
            SetActive(self.receivedGO, true);
            SetActive(self.maskGO, true);
        end
    end
end

function ActivityRoomRewardItem:SetItems()
    local item;
    local itemData;
    local rewardItem;
    local rewardItems = self.data.showReward;
    local len = #rewardItems;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.itemsTF);
            self.itemList[i] = item;
        end
        rewardItem = rewardItems[i];
        itemData = table.Copy(ConfigMgr.Config.itemMap[rewardItem.id]);
        itemData.count0 = rewardItem.count;
        item:SetData(1, itemData, 1, false, Vector3(0.56, 0.56, 1));
        item:SetIconBg(false);
    end
    local rlen = #self.itemList;
    for i = len + 1, rlen do
        self.itemList[i]:Hide();
    end
end

function ActivityRoomRewardItem:Clear()
    self.data = nil;
end

function ActivityRoomRewardItem:Destroy()
    if (self.OnClickGet ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.OnClickGet);
        self.OnClickGet = nil;
    end
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
        self.itemList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end