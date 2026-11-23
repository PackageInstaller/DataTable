DHStoryItem = {};

DHStoryItem.__index = DHStoryItem;

local pos = Vector3(0, 0, 0);

local objs = {
    animator = { path = "", type = "Animator" },
    groupBtn = { path = "Group/Btn", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    avgGO = { path = "Group/Avg", type = "GameObject" },
    avgReplay = { path = "Group/Avg/Replay", type = "GameObject" },
    avgRead = { path = "Group/Avg/Read", type = "GameObject" },
    avgNum = { path = "Group/Avg/Num", type = "Text" },
    avgName = { path = "Group/Avg/Name", type = "Text" },
    avgNew = { path = "Group/Avg/New", type = "GameObject" },
    avgLock = { path = "Group/Avg/Lock", type = "GameObject" },
};

function DHStoryItem.New()
    local self = {};
    setmetatable(self, DHStoryItem);
    return self;
end

function DHStoryItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true
    self.itemList = {};
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.DunHuang) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end

        self:RefreshNew()
        if (self:IsUnlock(DHLevelType.Story)) then
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                LuaMgr.ShowLuaPanel(UIName.DHStoryViewModel);
            end);
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function DHStoryItem:SetData(data)
    self.data = data.data;



    SetActive(self.avgGO, true);
    SetActive(self.avgReplay, false);
    SetActive(self.avgRead, false);
    SetActive(self.avgLock, false);   
    self.avgNum.text = LuaMgr.GetLangText(self.data.config.descriptionlan);
    self.avgName.text = LuaMgr.GetLangText(self.data.config.namelan);
    local eventData = PlayerDHMgr.GetActivityMapEvent(DHLevelType.Story, self.data.config.id);
    if (eventData ~= nil) then
        local isRead=DataHelper.CheckNovelComplete(self.data.config.id);
        if (eventData.complete or isRead) then
            SetActive(self.avgReplay, true);
        else
            SetActive(self.avgRead, true);
        end
    else
        SetActive(self.avgLock, true);
    end
    self:RefreshNew()   
end

function DHStoryItem:RefreshNew()
    if (PlayerDHMgr.CheckStoryRedDot(DHLevelType.Story, self.data.config.id)) then
        SetActive(self.avgNew, true);
    else
        SetActive(self.avgNew, false);
    end
end

function DHStoryItem:IsUnlock(type)
    local eventData = PlayerDHMgr.GetActivityMapEvent(type, self.data.config.id);
    if (eventData == nil) then
        local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.unlockParam];
        local name = ""
        if (dungeonConfig ~= nil) then
            name = LuaMgr.GetLangText(dungeonConfig.NameLan)
        else
            name = ConfigDHMgr.GetUnlockName(self.data.config.unlockParam)
        end
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tipStr, name))
        return false;
    end
    return true;
end

function DHStoryItem:Clear()
    self.data = nil;
end

function DHStoryItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end