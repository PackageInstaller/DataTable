JSYZNovelItem = {};

JSYZNovelItem.__index = JSYZNovelItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    unlock = { path = "Group/Unlock", type = "GameObject" },
    lock = { path = "Group/Lock", type = "GameObject" },
    replay = { path = "Group/Replay", type = "GameObject" },
    num = { path = "Group/Num", type = "Text" },
    name = { path = "Group/Name", type = "Text" },
};

function JSYZNovelItem.New()
    local self = {};
    setmetatable(self, JSYZNovelItem);
    return self;
end

function JSYZNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.JSYZ)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
            return;
        end
        if (self.isUnLock) then
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                JSYZMgr.SetShowAni(false);
                LuaMgr.ShowLuaPanel(UIName.JSYZHomeViewModel);
                LuaMgr.ShowLuaPanel(UIName.JSYZNovelViewModel);
            end);
            LuaMgr.HidePanel(UIName.JSYZNovelViewModel);
        else
            local eventMap = DataExHelper.GetActivityMapEventMap();
            local unlockEvent = eventMap[self.data.config.unlockParam]
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                string.format(ConfigMgr.LangGlobal("15006"), LuaMgr.GetLangText(unlockEvent.namelan)));
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function JSYZNovelItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock, false);
    SetActive(self.lock, false);
    SetActive(self.replay, false);
    self.isUnLock = JSYZMgr.CheckEventIsUnLock(self.data.config)
    if (self.isUnLock) then
        SetActive(self.unlock, true);
        self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
        local pPass = JSYZMgr.CheckEventIsComplete(self.data.config);
        SetActive(self.replay, pPass);
    else
        SetActive(self.lock, true);
        self.name.text = LuaMgr.GetLangText("JSYZNovelItem_0");
    end
end

function JSYZNovelItem:Clear()
    self.data = nil;
end

function JSYZNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end