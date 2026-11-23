ParkourMissionItem = {};

ParkourMissionItem.__index = ParkourMissionItem;

local objs = {
    item1 = { path = "Item1", type = "GameObject" },
    item1Text = { path = "Item1/Text", type = "Text" },
    item2 = { path = "Item2", type = "GameObject" },
    item2Text = { path = "Item2/Text", type = "Text" },
};

function ParkourMissionItem.New()
    local self = {};    
    setmetatable(self, ParkourMissionItem);
    return self;
end

function ParkourMissionItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function ParkourMissionItem:SetData(data)
    self.data = data.data;
    SetActive(self.item1, false);
    SetActive(self.item2, false);
    if (self.data == 1) then
        self.item1Text.text = LuaMgr.GetLangText("ParkourMissionItem_0");
        SetActive(self.item1, true);
    else
        self.item2Text.text = LuaMgr.GetLangText("ParkourMissionItem_1");
        SetActive(self.item2, true);
    end
end

function ParkourMissionItem:Clear()
end

function ParkourMissionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end