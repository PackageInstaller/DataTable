VoyageRewardItem = {};

VoyageRewardItem.__index = VoyageRewardItem;

local objs = {
    button = { path = "", type = "Button" },
    status = { path = "Status", type = "GameObject" },
    normal = { path = "Normal", type = "GameObject" },
    light = { path = "Light", type = "GameObject" },
    num = { path = "Num", type = "Text" },
    redDot = { path = "RedDot", type = "GameObject" },
};

function VoyageRewardItem.New(gameObject)
    local self = {};
    setmetatable(self, VoyageRewardItem);
    self.gameObject = gameObject;
    self.transform = gameObject.transform;
    UITool.Parse(gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRewardsClickItem, self);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function VoyageRewardItem:SetData(data)
    self.data = data;
    local questData = PlayerVoyageMgr.GetQuestData(self.data.QuestID);
    if (questData == nil) then return end

    if (questData.Status == 0) then
        SetActive(self.status, false);
        SetActive(self.normal, true);
        SetActive(self.light, false);
        SetActive(self.redDot, false);
    elseif (questData.Status == 1) then
        SetActive(self.status, true);
        SetActive(self.normal, true);
        SetActive(self.light, false);
        SetActive(self.redDot, true);
    else
        SetActive(self.status, false);
        SetActive(self.normal, false);
        SetActive(self.light, true);
        SetActive(self.redDot, false);
    end
    self.num.text = tostring(questData.Target);
end

function VoyageRewardItem:Clear()
    self.data = nil;
end

function VoyageRewardItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end