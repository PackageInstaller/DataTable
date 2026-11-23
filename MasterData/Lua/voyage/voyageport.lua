VoyagePort = {};

VoyagePort.__index = VoyagePort;

local objs = {
    iconBtn = { path = "Icon", type = "Button" },
    icon = { path = "Icon", type = "Image" },
    lockGO = { path = "Lock", type = "GameObject" },
    lockText = { path = "Lock/Text", type = "Text" },
    todayDelegateTF = { path = "TodayDelegate", type = "Transform" },
    currentPosTF = { path = "CurrentPos", type = "Transform" },
    infoPosTF = { path = "InfoPos", type = "RectTransform" },
    newPortTF = { path = "NewPort", type = "RectTransform" },
};

VoyagePort.New = function(port, todayDelegateItem, currentPosItem, newPortItem)
    local self = {};
    setmetatable(self, VoyagePort);
    UITool.Parse(port.gameObject, self, objs);
    self.todayDelegate = LuaMgr.InstantiateGO(todayDelegateItem, self.todayDelegateTF, false);
    self.todayDelegateBtn = self.todayDelegate.transform:Find("Bg"):GetComponent("Button");
    self.currentPos = LuaMgr.InstantiateGO(currentPosItem, self.currentPosTF, false);
    self.newPort = LuaMgr.InstantiateGO(newPortItem, self.newPortTF, false);
    self.OnClickPort = function()
        if (ConfigVoyageMgr.IsPortTimeout(self.data.HarborID)) then return end
        
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyagePortInfo, self.data);
    end
    self.OnClickTodayDelegate = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageTodayDelegate);
    end
    LuaMgr.AddClick(self.iconBtn, self.OnClickPort);
    LuaMgr.AddClick(self.todayDelegateBtn, self.OnClickTodayDelegate);
    return self;
end

function VoyagePort:SetData(data)
    self.data = data;
    local time = self:GetOpenTime();
    if (time > 0) then
        self.icon.sprite = LuaMgr.GetSprite(data.ResID, data.HarborEntryLockIcon);
        local day = GetTimeDay(time);
        self.lockText.text = string.format(ConfigMgr.LangGlobal("10454"), day);
        SetActive(self.lockGO, true);
    else
        if (PlayerVoyageMgr.IsPortLock(data.HarborID)) then
            self.icon.sprite = LuaMgr.GetSprite(data.ResID, data.HarborEntryLockIcon);
        else
            self.icon.sprite = LuaMgr.GetSprite(data.ResID, data.HarborEntryUnlockIcon);
        end
        SetActive(self.lockGO, false);
    end
    self.icon:SetNativeSize();
end

function VoyagePort:GetOpenTime()
    local time = LuaMgr.Timestamp()
    if (time >= self.data.OpenTime) then
        return 0;
    end
    return self.data.OpenTime - time;
end

function VoyagePort:SetTodayDelegate()
    local questData = PlayerVoyageMgr.GetTodayDelegateQuest();
    if (questData ~= nil and questData.Status ~= 2) then
        local questConfig = ConfigVoyageMgr.GetQuestById(questData.ID);
        if (questConfig ~= nil) then
            if (questConfig.HarborID == self.data.HarborID) then
                SetActive(self.todayDelegate, true);
            end
            return;
        end
    end
    SetActive(self.todayDelegate, false);
end

function VoyagePort:SetCurrentPos()
    SetActive(self.currentPos, PlayerVoyageMgr.IsCurrentPos(self.data.HarborID));
end

function VoyagePort:SetNewPort()
    if (self:GetOpenTime() > 0 
            or PlayerVoyageMgr.IsPortLock(self.data.HarborID) 
            or PlayerVoyageMgr.IsPortPass(self.data.HarborID)) then
        SetActive(self.newPort, false);
    else
        SetActive(self.newPort, true);
    end
end

function VoyagePort:Clear()
    self.data = nil;
    self.icon.sprite = nil;
    SetActive(self.todayDelegate, false);
    SetActive(self.currentPos, false);
    SetActive(self.newPort, false);
end

function VoyagePort:Destroy()
    if (self.OnClickPort ~= nil) then
        LuaMgr.RemoveClick(self.iconBtn, self.OnClickPort);
        self.OnClickPort = nil;
    end
    if (self.OnClickTodayDelegate ~= nil) then
        LuaMgr.RemoveClick(self.todayDelegateBtn, self.OnClickTodayDelegate);
        self.OnClickTodayDelegate = nil;
    end
    if (self.todayDelegate ~= nil) then
        LuaMgr.DestroyImmediateGO(self.todayDelegate);
        self.todayDelegate = nil;
    end
    if (self.currentPos ~= nil) then
        LuaMgr.DestroyImmediateGO(self.currentPos);
        self.currentPos = nil;
    end
    if (self.newPort ~= nil) then
        LuaMgr.DestroyImmediateGO(self.newPort);
        self.newPort = nil;
    end
end