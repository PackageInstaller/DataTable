GuoBaoSupperzzleLevelItem = {};

GuoBaoSupperzzleLevelItem.__index = GuoBaoSupperzzleLevelItem;

local objs = {
    button = { path = "", type = "Button" },
    unlock = { path = "Unlock", type = "GameObject" },
    complete = { path = "Complete", type = "GameObject" },
    lock = { path = "Lock", type = "GameObject" },
    select = { path = "Select", type = "GameObject" },
    lockIcon = { path = "LockIcon", type = "GameObject" },
    text = { path = "Text", type = "Text" },
};

function GuoBaoSupperzzleLevelItem.New()
    local self = {};    
    setmetatable(self, GuoBaoSupperzzleLevelItem);
    return self;
end

function GuoBaoSupperzzleLevelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuoBaoSupperzzleLevel, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function GuoBaoSupperzzleLevelItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock, false);
    SetActive(self.complete, false);
    SetActive(self.lock, false);
    SetActive(self.select, self.data.select);
    SetActive(self.lockIcon, false);
    if (LuaMgr.Timestamp() >= self.data.config.StartTime) then
        SetActive(self.unlock, true);
        if (PlayerGuoBaoMgr.GetFinishEvent(self.data.config.ID) ~= nil) then
            SetActive(self.complete, true);
        end
        self.text.text = string.format("<color=#D1B8A4>%d</color>", self.data.id);
    else
        SetActive(self.lock, true);
        SetActive(self.lockIcon, true);
        self.text.text = tostring(self.data.id);
    end
end

function GuoBaoSupperzzleLevelItem:Clear()
    self.data = nil;
end

function GuoBaoSupperzzleLevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end