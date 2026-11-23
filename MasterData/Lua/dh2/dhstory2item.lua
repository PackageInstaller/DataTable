DHStory2Item = {};

DHStory2Item.__index = DHStory2Item;

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

function DHStory2Item.New()
    local self = {};
    setmetatable(self, DHStory2Item);
    return self;
end

function DHStory2Item:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playAnimator = true
    self.itemList = {};
    self.OnClickItem = function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.RoomShare) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
            return;
        end

        self:RefreshNew()
        if (self:IsUnlock(DH2LevelType.Story)) then
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                LuaMgr.ShowLuaPanel(UIName.DHStory2ViewModel);
            end);
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function DHStory2Item:SetData(data)
    self.data = data.data;



    SetActive(self.avgGO, true);
    SetActive(self.avgReplay, false);
    SetActive(self.avgRead, false);
    SetActive(self.avgLock, false);   
    self.avgNum.text = LuaMgr.GetLangText(self.data.config.descriptionlan);
    self.avgName.text = LuaMgr.GetLangText(self.data.config.namelan);
    local eventData = PlayerDH2Mgr.GetActivityMapEvent(DH2LevelType.Story, self.data.config.id);
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

function DHStory2Item:RefreshNew()
    if (PlayerDH2Mgr.CheckStoryRedDot(DH2LevelType.Story, self.data.config.id)) then
        SetActive(self.avgNew, true);
    else
        SetActive(self.avgNew, false);
    end
end

function DHStory2Item:IsUnlock(type)
    local eventData = PlayerDH2Mgr.GetActivityMapEvent(type, self.data.config.id);
    if (eventData == nil) then
        local dungeonConfig = ConfigMgr.Config.dungeonMap[self.data.config.unlockParam];
        local name = ""
        if (dungeonConfig ~= nil) then
            name = LuaMgr.GetLangText(dungeonConfig.NameLan)
        else
            name = ConfigDH2Mgr.GetUnlockName(self.data.config.unlockParam)
        end
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tipStr, name))
        return false;
    end
    return true;
end

function DHStory2Item:Clear()
    self.data = nil;
end

function DHStory2Item:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end