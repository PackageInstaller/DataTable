QinBattleCountryItem = {};

QinBattleCountryItem.__index = QinBattleCountryItem;

local objs = {
    button = { path = "Group", type = "Button" },
    group = { path = "Group", type = "Transform" },
    status1 = { path = "Group/Status1", type = "GameObject" },
    status2 = { path = "Group/Status2", type = "GameObject" },
    status3 = { path = "Group/Status3", type = "GameObject" },
    name = { path = "Group/Name", type = "Image" },
    pass = { path = "Group/Pass", type = "GameObject" },
    perfect = { path = "Group/Perfect", type = "GameObject" },
    lock = { path = "Group/Lock", type = "GameObject" },
};

function QinBattleCountryItem.New()
    local self = {};
    setmetatable(self, QinBattleCountryItem);
    return self;
end

function QinBattleCountryItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.isUnlock = false;
    self.OnClickItem = function()
        if (self.isUnlock) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.QinBattleCountry, self.data.index);
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function QinBattleCountryItem:SetData(data)
    self.data = data.data;
    self.group.localPosition = Vector3(self.data.index %2 == 1 and -44 or 32,0,0);
    self.name.sprite = LuaMgr.GetSprite("Qin", "ui_hd_dq_sp_guo" .. self.data.index);
    local events = ConfigQinMgr.GetMainActivityMapEvents(tostring(self.data.index));
    local bComplete = true
    for i = 1, 2 do
        local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap_main, events[i].id);
        if(eventData == nil or not eventData.complete)then
            bComplete = false
            break
        end
    end   
    if (bComplete) then
        SetActive(self.status1, self.data.select);
        SetActive(self.status2, not self.data.select);
        SetActive(self.status3, false);
        SetActive(self.lock, false);
        self.isUnlock = true;
        local isPass, isPerfect = self:GetEvaluate(events);
        SetActive(self.pass, isPass);
        SetActive(self.perfect, isPerfect);
    else
        SetActive(self.status1, false);
        SetActive(self.status2, true);
        SetActive(self.status3, true);
        SetActive(self.lock, true);
        self.isUnlock = false;        
        SetActive(self.pass, false);
        SetActive(self.perfect, false);
    end   
end

function QinBattleCountryItem:GetEvaluate(events)
    local event;
    local record;
    local evaluates = {};
    local len = #events;
    for i = 1, len do
        event = events[i];
        record = DataMgr.Player.dungeonRecords[event.eventParam];
        if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
            table.insert(evaluates, record.historyRating);
        end
    end
    local perfect = true;
    local elen = #evaluates;
    for i = 1, elen do
        if (evaluates[i] ~= "S") then
            perfect = false;
        end
    end
    return elen > 0, elen == len and perfect;
end

function QinBattleCountryItem:Clear()
    self.data = nil;
    self.name.sprite = nil;
end

function QinBattleCountryItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end