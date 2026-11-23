Dungeon66PrepareChallengeItem = {};

Dungeon66PrepareChallengeItem.__index = Dungeon66PrepareChallengeItem;

local objs = {
    getIcon = { path = "Get/Icon", type = "GameObject" },
    content = { path = "Content", type = "Text" },
    finishGO = { path = "Finish", type = "GameObject" },
};

function Dungeon66PrepareChallengeItem.New()
    local self = {};    
    setmetatable(self, Dungeon66PrepareChallengeItem);
    return self;
end

function Dungeon66PrepareChallengeItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function Dungeon66PrepareChallengeItem:SetData(data)
    self.data = data.data;
    SetActive(self.getIcon, self.data.isComplete);
    self.content.text = self.data.content;
    SetActive(self.finishGO, self.data.isComplete);
end

function Dungeon66PrepareChallengeItem:Clear()
    self.data = nil;
end

function Dungeon66PrepareChallengeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end