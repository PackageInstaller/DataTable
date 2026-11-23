Dungeon66RewardItem = {};

Dungeon66RewardItem.__index = Dungeon66RewardItem;

local objs = {
    grayGO = { path = "Group/Gray", type = "GameObject" },
    lightGO = { path = "Group/Light", type = "GameObject" },
    msg1Text = { path = "Group/Gray/Msg", type = "Text" },
    msg2Text = { path = "Group/Light/Msg", type = "Text" },
    itemsTF = { path = "Group/Items", type = "Transform" },
    getGO = { path = "Group/Get", type = "GameObject" },
    getBtn = { path = "Group/Get", type = "Button" },
    receivedGO = { path = "Group/Received", type = "GameObject" },
    gotoGO = { path = "Group/Goto", type = "GameObject" },
    gotoBtn = { path = "Group/Goto", type = "Button" },
    gotoText = { path = "Group/Goto/Text", type = "Text" },
    gotoProgress = { path = "Group/Goto/Progress/Bar", type = "Image" },
};

function Dungeon66RewardItem.New()
    local self = {};    
    setmetatable(self, Dungeon66RewardItem);
    return self;
end

function Dungeon66RewardItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.OnClickGet = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.Dungeon66RewardGet, self.data.config.ID);
    end
    self.OnClickGoto = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.Dungeon66RewardGoto, self.data.config.ID);
    end
    LuaMgr.AddClick(self.getBtn, self.OnClickGet);
    LuaMgr.AddClick(self.gotoBtn, self.OnClickGoto);
end

function Dungeon66RewardItem:SetData(data)
    self.data = data.data;
    SetActive(self.grayGO, false);
    SetActive(self.lightGO, false);
    SetActive(self.getGO, false);
    SetActive(self.receivedGO, false);
    SetActive(self.gotoGO, false);
    local config = self.data.config;
    self.msg1Text.text = LuaMgr.GetLangText(config.DescLan);
    self.msg2Text.text = LuaMgr.GetLangText(config.DescLan);
    self:SetItems();
    if (TrainingCampMgr.IsReceiveReward(config.ID)) then
        SetActive(self.grayGO, true);
        SetActive(self.receivedGO, true);
    else
        SetActive(self.lightGO, true);
        local star = self.data.star;
        if (star >= config.Parameter) then
            SetActive(self.getGO, true);
        else
            self.gotoText.text = string.format("<size=30><color=#f5efe5>%d</color></size>/%d", star, config.Parameter);
            self.gotoProgress.fillAmount = star / config.Parameter;
            SetActive(self.gotoGO, true);
        end
    end
end

function Dungeon66RewardItem:SetItems()
    local item;
    local itemData;
    local rewardItem;
    local rewardItems = self.data.config.Award;
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

function Dungeon66RewardItem:Clear()
    self.data = nil;
end

function Dungeon66RewardItem:Destroy()
    if (self.OnClickGet ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.OnClickGet);
        self.OnClickGet = nil;
    end
    if (self.OnClickGoto ~= nil) then
        LuaMgr.RemoveClick(self.gotoBtn, self.OnClickGoto);
        self.OnClickGoto = nil;
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