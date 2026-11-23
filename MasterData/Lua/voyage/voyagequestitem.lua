VoyageQuestItem = {};

VoyageQuestItem.__index = VoyageQuestItem;

local objs = {
    canvasGroup = { path = "", type = "CanvasGroup" },
    complete = { path = "Complete", type = "GameObject" },
    text = { path = "Text", type = "Text" },
    rewards = { path = "Rewards", type = "RectTransform" },
    receive = { path = "Receive", type = "GameObject" },
    receiveBtn = { path = "Receive", type = "Button" },
    received = { path = "Received", type = "GameObject" },
    gotoGO = { path = "Goto", type = "GameObject" },
    gotoBtn = { path = "Goto", type = "Button" },
    gotoText = { path = "Goto/Text", type = "Text" },
    gotoProgress = { path = "Goto/Progress/Bar", type = "Image" },
}

function VoyageQuestItem.New()
    local self = {};
    setmetatable(self, VoyageQuestItem);
    return self;
end

function VoyageQuestItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.rewardList = {};
    self.OnClickReceive = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageQuestReceive, self.data.QuestID);
    end
    self.OnClickGoto = function()
        LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
    end
    LuaMgr.AddClick(self.receiveBtn, self.OnClickReceive);
    LuaMgr.AddClick(self.gotoBtn, self.OnClickGoto);
end

function VoyageQuestItem:SetData(data)
    self.data = data.data;
    local questData = PlayerVoyageMgr.GetQuestData(self.data.QuestID);
    if (questData == nil) then return end
    
    SetActive(self.complete, false);
    SetActive(self.receive, false);
    SetActive(self.received, false);
    SetActive(self.gotoGO, false);
    local desStr;
    if (questData.Status == 1) then
        SetActive(self.complete, true);
        SetActive(self.receive, true);
        desStr = "%s";
    else
        desStr = "<color=#3a3545>%s</color>";
    end
    SetActive(self.received, questData.Status ~= 0 and questData.Status ~= 1);
    SetActive(self.gotoGO, questData.Status == 0);
    self.text.text = string.format(desStr, LuaMgr.GetLangText(self.data.QuestDesLan));
    self:SetRewards();
    if (questData.Current > 0) then
        self.gotoText.text = string.format("<size=30><color=#1357ed>%d</color></size>/%d", questData.Current, questData.Target);
    else
        self.gotoText.text = string.format("<size=30>%d</size>/%d", questData.Current, questData.Target);
    end
    if (questData.Target > 0) then
        self.gotoProgress.fillAmount = questData.Current / questData.Target;
    else
        self.gotoProgress.fillAmount = 0;
    end
    if (questData.Status == 0 or questData.Status == 1) then
        self.canvasGroup.alpha = 1;
    else
        self.canvasGroup.alpha = 0.6;
    end
end

function VoyageQuestItem:SetRewards()
    local item;
    local itemData;
    local rewardItem;
    local rewardItems = self.data.RewardItems;
    local len = #rewardItems;
    for i = 1, len do
        item = self.rewardList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.rewards);
            item.transform.anchoredPosition = Vector2((i - 1) * 70 - 34, 0);
            self.rewardList[i] = item;
        end
        rewardItem = rewardItems[i];
        itemData = table.Copy(ConfigMgr.Config.itemMap[rewardItem.id]);
        itemData.count0 = rewardItem.count;
        item:SetData(1, itemData, 1, false, Vector3(0.56, 0.56, 1));
        item:SetIconBg(false);
    end
    local rlen = #self.rewardList;
    for i = len + 1, rlen do
        self.rewardList[i]:Hide();
    end
end

function VoyageQuestItem:Clear()
    self.data = nil;
    local len = #self.rewardList;
    for i = 1, len do
        self.rewardList[i]:Hide();
    end
end

function VoyageQuestItem:Destroy()
    if (self.OnClickReceive ~= nil) then
        LuaMgr.RemoveClick(self.receiveBtn, self.OnClickReceive);
        self.OnClickReceive = nil;
    end
    if (self.OnClickGoto ~= nil) then
        LuaMgr.RemoveClick(self.gotoBtn, self.OnClickGoto);
        self.OnClickGoto = nil;
    end
    if (self.rewardList ~= nil) then
        local len = #self.rewardList;
        for i = 1, len do
            self.rewardList[i]:Clear();
        end
        self.rewardList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end