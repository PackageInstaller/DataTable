GuoBaoCollectItem = {};

GuoBaoCollectItem.__index = GuoBaoCollectItem;

local objs = {
    button = { path = "", type = "Button" },
    icon = { path = "Icon", type = "Image" },
};

function GuoBaoCollectItem.New()
    local self = {};    
    setmetatable(self, GuoBaoCollectItem);
    return self;
end

function GuoBaoCollectItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.group = nil;
    self.state = 0;
    self.OnClickItem = function()
        if (self.state == 1) then
            LuaMgr.ShowLuaPanel(UIName.GuoBaoCollectDetailsViewModel, self.group);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("GuoBaoCollectItem_0"));
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function GuoBaoCollectItem:SetData(data)
    self.data = data.data;
    local questConfig = ConfigMgr.Config.questEvent[self.data];
    if (questConfig ~= nil) then
        local questData = PlayerGuoBaoMgr.GetQuestEvent(questConfig.id);
        self.state = questData.state == 3 and 1 or 0;
        self.group = string.gsub(questConfig.text, "GuoBaostamp", "");
        self.icon.sprite = LuaMgr.GetSprite("GuoBaoScene", string.format("ui_hd_gb_jy_ss_hj_%s_%d", self.group, self.state));
    end
end

function GuoBaoCollectItem:Clear()
    self.icon.sprite = nil;
end

function GuoBaoCollectItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end