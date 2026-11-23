WMFCNovelItem = {};

WMFCNovelItem.__index = WMFCNovelItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    unlock = { path = "Group/Unlock", type = "GameObject" },
    lock = { path = "Group/Lock", type = "GameObject" },
    replay = { path = "Group/Replay", type = "GameObject" },
    num = { path = "Group/Num", type = "Text" },
    name = { path = "Group/Name", type = "Text" },
};

function WMFCNovelItem.New()
    local self = {};
    setmetatable(self, WMFCNovelItem);
    return self;
end

function WMFCNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.WMFC)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
            return;
        end
        if (self.isUnLock) then
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                WMFCMgr.SetShowAni(false);
                LuaMgr.ShowLuaPanel(UIName.WMFCHomeViewModel);
                LuaMgr.ShowLuaPanel(UIName.WMFCNovelViewModel);
            end);
            LuaMgr.HidePanel(UIName.WMFCNovelViewModel);
        else
            local eventMap = DataExHelper.GetActivityMapEventMap();
            local unlockEvent = eventMap[self.data.config.unlockParam]
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                string.format(ConfigMgr.LangGlobal("15006"), LuaMgr.GetLangText(unlockEvent.namelan)));
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function WMFCNovelItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock, false);
    SetActive(self.lock, false);
    SetActive(self.replay, false);
    self.isUnLock = WMFCMgr.CheckEventIsUnLock(self.data.config)
    if (self.isUnLock) then
        SetActive(self.unlock, true);
        self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
        local pPass = WMFCMgr.CheckEventIsComplete(self.data.config);
        SetActive(self.replay, pPass);
    else
        SetActive(self.lock, true);
        self.name.text = LuaMgr.GetLangText("WMFCNovelItem_0");
    end
end

function WMFCNovelItem:Clear()
    self.data = nil;
end

function WMFCNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end