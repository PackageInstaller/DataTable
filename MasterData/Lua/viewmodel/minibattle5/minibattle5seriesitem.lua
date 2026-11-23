MiniBattle5SeriesItem = {};

MiniBattle5SeriesItem.__index = MiniBattle5SeriesItem;

local objs = {
    Dungeon1ItemGo = { path = "Group/Dungeon1", type = "GameObject" },
    Dungeon2ItemGo = { path = "Group/Dungeon2", type = "GameObject" },
    ConnectGo = { path = "Group/Connect", type = "GameObject" },
}

function MiniBattle5SeriesItem.New()
    local self = {};
    setmetatable(self, MiniBattle5SeriesItem);
    return self;
end

function MiniBattle5SeriesItem:Init()
    UITool.Parse(self.gameObject, self, objs);

    self.dungeon1Item = MiniBattle5DungeonItem.New(self.Dungeon1ItemGo)
    self.dungeon1Item:Init()
    self.dungeon2Item = MiniBattle5DungeonItem.New(self.Dungeon2ItemGo)
    self.dungeon2Item:Init()
    SetActive(self.ConnectGo, false)
end

function MiniBattle5SeriesItem:SetData(pdata)
    self.data = pdata.data
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:SetData(self.data.dungeon1Data)
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:SetData(self.data.dungeon2Data)
    end
    SetActive(self.ConnectGo, false)
    SetActive(self.gameObject, true)
end
    
function MiniBattle5SeriesItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle5SeriesItem:Clear()
    self.data = nil
    if self.dungeon1Item ~= nil then
        self.dungeon1Item:Clear()
    end
    if self.dungeon2Item ~= nil then
        self.dungeon2Item:Clear()
    end
end

function MiniBattle5SeriesItem:Destroy()
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