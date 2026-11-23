VoyagePortInfoDungeonItem = {};

VoyagePortInfoDungeonItem.__index = VoyagePortInfoDungeonItem;

local objs = {
    select = { path = "Select", type = "GameObject" },
};

function VoyagePortInfoDungeonItem.New()
    local self = {};
    setmetatable(self, VoyagePortInfoDungeonItem);
    return self;
end

function VoyagePortInfoDungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyagePortInfoDungeonItem:SetData(data)
    self.data = data.data;
    local record = DataMgr.Player.SailingEventRecords[self.data.EventID];
    SetActive(self.select, record ~= nil);
end

function VoyagePortInfoDungeonItem:Clear()
    self.data = nil;
end

function VoyagePortInfoDungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end