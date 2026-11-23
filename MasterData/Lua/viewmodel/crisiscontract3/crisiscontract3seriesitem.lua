CrisisContract3SeriesItem = {};

CrisisContract3SeriesItem.__index = CrisisContract3SeriesItem;

local objs = {
    Dungeon1ItemGo = { path = "Dungeon1", type = "GameObject" },
    Dungeon2ItemGo = { path = "Dungeon2", type = "GameObject" },
}

function CrisisContract3SeriesItem.New()
    local self = {};
    setmetatable(self, CrisisContract3SeriesItem);
    return self;
end

function CrisisContract3SeriesItem:Init()
    UITool.Parse(self.gameObject, self, objs);

    self.dungeon1Item = CrisisContract3DungeonItem.New(self.Dungeon1ItemGo)
    self.dungeon1Item:Init()
    self.dungeon2Item = CrisisContract3DungeonItem.New(self.Dungeon2ItemGo)
    self.dungeon2Item:Init()
end

function CrisisContract3SeriesItem:SetData(pdata)
    self.data = pdata.data
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:SetData(self.data.dungeon1Data)
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:SetData(self.data.dungeon2Data)
    end
    SetActive(self.gameObject, true)
end
    
function CrisisContract3SeriesItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract3SeriesItem:Clear()
    self.data = nil
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:Clear()
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:Clear()
    end
end

function CrisisContract3SeriesItem:Destroy()
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