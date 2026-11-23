ActivityRoomVisitorRecordItem = {};

ActivityRoomVisitorRecordItem.__index = ActivityRoomVisitorRecordItem;

local objs = {
    msg = { path = "Group/Msg", type = "Text" },
    date = { path = "Group/Date", type = "Text" },
};

function ActivityRoomVisitorRecordItem.New()
    local self = {};    
    setmetatable(self, ActivityRoomVisitorRecordItem);
    return self;
end

function ActivityRoomVisitorRecordItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function ActivityRoomVisitorRecordItem:SetData(data)
    local type = data.data.Typ;
    if (type == 0) then
        local str = LuaMgr.GetLangText("ActivityRoomVisitorRecordItem_0");
        self.msg.text = string.format(str, data.data.Name);
    elseif (type == 1) then
        local str = LuaMgr.GetLangText("ActivityRoomVisitorRecordItem_1");
        self.msg.text = string.format(str, data.data.Name);
    elseif (type == 2) then
        local str = LuaMgr.GetLangText("ActivityRoomVisitorRecordItem_2");
        local characterConfig = ConfigCharacterMgr.GetCharacter(data.data.Extra);
        if (characterConfig ~= nil) then
            self.msg.text = string.format(str, data.data.Name, LuaMgr.GetLangText(characterConfig.namelan));
        else
            self.msg.text = "";
        end
    elseif (type == 3) then
        local str = LuaMgr.GetLangText("ActivityRoomVisitorRecordItem_3");
        self.msg.text = string.format(str, data.data.Name);
    end
    self.date.text = os.date("%Y-%m-%d", data.data.CrtTime);
end

function ActivityRoomVisitorRecordItem:Clear()
    
end

function ActivityRoomVisitorRecordItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end