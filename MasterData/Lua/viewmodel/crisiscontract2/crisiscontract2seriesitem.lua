CrisisContract2SeriesItem = {};

CrisisContract2SeriesItem.__index = CrisisContract2SeriesItem;

local objs = {
    Dungeon1ItemGo = { path = "Dungeon1", type = "GameObject" },
    Dungeon2ItemGo = { path = "Dungeon2", type = "GameObject" },
}

function CrisisContract2SeriesItem.New()
    local self = {};
    setmetatable(self, CrisisContract2SeriesItem);
    return self;
end

function CrisisContract2SeriesItem:Init()
    UITool.Parse(self.gameObject, self, objs);

    self.dungeon1Item = CrisisContract2DungeonItem.New(self.Dungeon1ItemGo)
    self.dungeon1Item:Init()
    self.dungeon2Item = CrisisContract2DungeonItem.New(self.Dungeon2ItemGo)
    self.dungeon2Item:Init()
end

function CrisisContract2SeriesItem:SetData(pdata)
    self.data = pdata.data
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:SetData(self.data.dungeon1Data)
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:SetData(self.data.dungeon2Data)
    end
    SetActive(self.gameObject, true)
end
    
function CrisisContract2SeriesItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2SeriesItem:Clear()
    self.data = nil
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:Clear()
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:Clear()
    end
end

function CrisisContract2SeriesItem:Destroy()
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:Destroy()
        self.dungeon1Item = nil
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:Destroy()
        self.dungeon2Item = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.Dungeon1ItemGo = nil
    self.Dungeon2ItemGo = nil
end 