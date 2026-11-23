KZRYNovelItem = {};

KZRYNovelItem.__index = KZRYNovelItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    unlock = { path = "Group/Unlock", type = "GameObject" },
    lock = { path = "Group/Lock", type = "GameObject" },
    replay = { path = "Group/Replay", type = "GameObject" },
    num = { path = "Group/Num", type = "Text" },
    name = { path = "Group/Name", type = "Text" },
};

function KZRYNovelItem.New()
    local self = {};    
    setmetatable(self, KZRYNovelItem);
    return self;
end

function KZRYNovelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.KZRY)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
            return;
        end
        local pPass = KZRYMgr.CheckEventIsComplete(self.data.config);   
        if (pPass) then                
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                KZRYMgr.SetShowAni(false);
                LuaMgr.ShowLuaPanel(UIName.KZRYExploreViewModel);
                LuaMgr.ShowLuaPanel(UIName.KZRYNovelViewModel);
            end); 
            LuaMgr.HidePanel(UIName.KZRYNovelViewModel);          
        else
            local eventMap=DataExHelper.GetActivityMapEventMap();
            local unlockEvent=eventMap[self.data.config.eventParam]            
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10001"), LuaMgr.GetLangText(unlockEvent.namelan))); 
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function KZRYNovelItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock, false);
    SetActive(self.lock, false);
    SetActive(self.replay, false);
    local pPass = KZRYMgr.CheckEventIsComplete(self.data.config);   
    if (pPass) then






        KZRYMgr.SetNovelIndex(self.data.num);       
        self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
        SetActive(self.unlock, true);
        SetActive(self.replay, true);
    else       
        self.name.text = "";
        SetActive(self.lock, true);
    end
end

function KZRYNovelItem:Clear()    
    self.data = nil;
end

function KZRYNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end