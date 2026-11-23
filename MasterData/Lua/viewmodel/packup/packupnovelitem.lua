PackUpNovelItem = {};

PackUpNovelItem.__index = PackUpNovelItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    unlock = { path = "Group/Unlock", type = "GameObject" },
    lock = { path = "Group/Lock", type = "GameObject" },
    replay = { path = "Group/Replay", type = "GameObject" },
    num = { path = "Group/Num", type = "Text" },
    name = { path = "Group/Name", type = "Text" },
};

function PackUpNovelItem.New()
    local self = {};    
    setmetatable(self, PackUpNovelItem);
    return self;
end

function PackUpNovelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.PackUp)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
            return;
        end
        local pPass = PackUpMgr.CheckEventIsComplete(self.data.config);   
        if (pPass) then                
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                PackUpMgr.SetShowAni(false);
                LuaMgr.ShowLuaPanel(UIName.PackUpExploreViewModel);
                LuaMgr.ShowLuaPanel(UIName.PackUpNovelViewModel);
            end); 
            LuaMgr.HidePanel(UIName.PackUpNovelViewModel);          
        else
            local eventMap=DataExHelper.GetActivityMapEventMap();
            local unlockEvent=eventMap[self.data.config.eventParam]            
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10001"), LuaMgr.GetLangText(unlockEvent.namelan))); 
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function PackUpNovelItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock, false);
    SetActive(self.lock, false);
    SetActive(self.replay, false);
    local pPass = PackUpMgr.CheckEventIsComplete(self.data.config);        
    if (pPass) then






        self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
        SetActive(self.unlock, true);
        SetActive(self.replay, true);
    else       
        self.name.text = "";
        SetActive(self.lock, true);
    end
end

function PackUpNovelItem:Clear()    
    self.data = nil;
end

function PackUpNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end