
RhythmGameMissionItem = {};

RhythmGameMissionItem.__index = RhythmGameMissionItem;

RhythmGameMissionItem.addWidth = 0;


local objs = {
    itemTF = { path = "", type = "RectTransform" },
    receive = { path = "Receive", type = "GameObject" },
    receiveBg = { path = "Receive/Bg", type = "RectTransform" },
    receiveBtn = { path = "Receive/Button", type = "Button" },
    receiveRedDot = { path = "Receive/RedDot", type = "GameObject" },
    progress = { path = "Progress", type = "GameObject" },
    progressBg = { path = "Progress/Bg", type = "RectTransform" },
    progressNum = { path = "Progress/ProgressNum/Text", type = "Text" },
    progressBar = { path = "Progress/ProgressNum/ProgressBar", type = "Image" },
    complete = { path = "Complete", type = "GameObject" },
    completeBg = { path = "Complete/Bg", type = "RectTransform" },
    name = { path = "Name", type = "Text" },
    desc = { path = "Desc", type = "Text" },
    rewardTF = { path = "Reward", type = "Transform" },
    mask = { path = "Mask", type = "GameObject" },
}

function RhythmGameMissionItem.New()
    local self = {};
    setmetatable(self, RhythmGameMissionItem);
    return self;
end

function RhythmGameMissionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemSize = self.itemTF.sizeDelta;

    self.itemList = {};
    self.OnClickReceive = function()
        DataExHelper.EX_GetAward(self.data.id, function(_result)          
            LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameQuestReceive);
        end)
    end
    LuaMgr.AddClick(self.receiveBtn, self.OnClickReceive);
end

function RhythmGameMissionItem:SetData(data)
    local state = DataExHelper.Check_RewardState(data.data.id);
    local quest = PlayerSlgMgr.GetQuestData(data.data.id)
    if (quest == nil) then return end
    self.data = data.data;


    SetActive(self.receive, true);
    self.itemSize.x = data.width;
    self.itemTF.sizeDelta = self.itemSize;

    self.desc.text = LuaMgr.GetLangText(self.data.remarksLan)
    self.progressNum.text = string.format("%s<size=18><color=#c4eede>/%s</color></size>", quest.progress,
        self.data.progress)
    self.progressBar.fillAmount = quest.progress / self.data.progress
    self.receive:SetActive(state == 2)
    self.complete:SetActive(state == 3)
    self.mask:SetActive(state == 3)
    self.progress:SetActive(state == 1)
    self:HideItemList()
    self:SetItemList()
end

function RhythmGameMissionItem:SetItemList()
    local scale = Vector3(0.5, 0.5, 0.5);
    local rewards = self.data.reward;
    local itemMap = ConfigMgr.Config.itemMap;
    local len = #rewards;
    for i = 1, len do
        local item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.rewardTF);
            item.transform.localPosition = Vector3((i - 2) * 70 + 30, -6, 0);
            self.itemList[i] = item;
            item.countText.fontSize = 26 
        end
        local itemData = table.Copy(itemMap[rewards[i].id]);
        itemData.count0 = rewards[i].count;
        item:SetData(i, itemData, 1, false, scale,false);
    end
end

function RhythmGameMissionItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function RhythmGameMissionItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function RhythmGameMissionItem:Clear()
    self.data = nil;
end

function RhythmGameMissionItem:Destroy()
    if (self.OnClickReceive ~= nil) then
        LuaMgr.RemoveClick(self.receiveBtn, self.OnClickReceive);
        self.OnClickReceive = nil;
    end
    self:ClearItemList()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end