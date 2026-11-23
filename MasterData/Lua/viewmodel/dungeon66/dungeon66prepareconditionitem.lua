Dungeon66PrepareConditionItem = {};

Dungeon66PrepareConditionItem.__index = Dungeon66PrepareConditionItem;

local objs = {
    winBg = { path = "WinBg", type = "GameObject" },
    loseBg = { path = "LoseBg", type = "GameObject" },
    content = { path = "Content", type = "Text" },
};

function Dungeon66PrepareConditionItem.New()
    local self = {};    
    setmetatable(self, Dungeon66PrepareConditionItem);
    return self;
end

function Dungeon66PrepareConditionItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function Dungeon66PrepareConditionItem:SetData(data)
    SetActive(self.winBg, data.data.type == "0");
    SetActive(self.loseBg, data.data.type == "1");
    self.content.text = data.data.content;
end

function Dungeon66PrepareConditionItem:Clear()
end

function Dungeon66PrepareConditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end