GuoBaoNovelItem = {};

GuoBaoNovelItem.__index = GuoBaoNovelItem;

local pos = Vector2(0, 0);
local color = UnityEngine.Color(1,1,1,1);

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    groupTF = { path = "Group", type = "Transform" },
    normal = { path = "Group/Normal", type = "GameObject" },
    lock = { path = "Group/Lock", type = "GameObject" },
    iconGO = { path = "Group/Icon", type = "GameObject" },
    icon = { path = "Group/Icon", type = "Image" },
    name = { path = "Group/Name", type = "Image" },
    replay = { path = "Group/Replay", type = "GameObject" },
    new = { path = "Group/New", type = "GameObject" },
};

function GuoBaoNovelItem.New()
    local self = {};    
    setmetatable(self, GuoBaoNovelItem);
    return self;
end

function GuoBaoNovelItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.itemList = {};
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.GuoBao)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
            return;
        end
        if (self:IsUnlock()) then
            PlayerGuoBaoMgr.SetNovelIndex(self.data.num);
            LuaMgr.PlayNovel(self.data.config.eventParam, function()
                LuaMgr.ShowLuaPanel(UIName.GuoBaoNovelViewModel);
            end);
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function GuoBaoNovelItem:SetData(data)   
    self.data = data.data;   
    pos.y = (self.data.num % 2 == 0) and -77 or 138;
    self.groupTF.anchoredPosition = pos;
    self.icon.sprite = LuaMgr.GetSprite("GuoBaoNovel", self.data.config.statusIcon);
    self.name.sprite = LuaMgr.GetSprite("GuoBaoNovel", self.data.config.statusIcon .. "_1");
    SetActive(self.normal, false);
    SetActive(self.lock, false);
    SetActive(self.iconGO, false);
    SetActive(self.replay, false);
    SetActive(self.new, false);
    local eventData = PlayerGuoBaoMgr.GetActivityMapEvent(GuoBaoActivity.Novel, self.data.config.id);
    if (eventData ~= nil) then
        if (eventData.complete) then
            SetActive(self.replay, true);
        else
            SetActive(self.new, true);
        end
        SetActive(self.iconGO, true);
        SetActive(self.normal, true);
        color.a = 1;
    else
        color.a = 0.7;
        SetActive(self.lock, true);
    end
    self.name.color = color;
end

function GuoBaoNovelItem:IsUnlock()
    local eventData = PlayerGuoBaoMgr.GetActivityMapEvent(GuoBaoActivity.Novel, self.data.config.id);
    if (eventData == nil) then      
        local unlockName = ConfigSlgMgr.GetUnlockName(self.data.config.unlockParam);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10001"), unlockName));
        return false;
    end
    return true;
end

function GuoBaoNovelItem:Clear()    
    self.data = nil;
    self.icon.sprite = nil;
    self.name.sprite = nil;
end

function GuoBaoNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
        self.itemList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end