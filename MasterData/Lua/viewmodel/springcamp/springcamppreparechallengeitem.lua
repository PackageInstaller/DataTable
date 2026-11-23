SpringCampPrepareChallengeItem = {};

SpringCampPrepareChallengeItem.__index = SpringCampPrepareChallengeItem;

local objs = {
    getIcon = { path = "Get/Icon", type = "GameObject" },
    content = { path = "Content", type = "Text" },
    finishGO = { path = "Finish", type = "GameObject" },
};

function SpringCampPrepareChallengeItem.New()
    local self = {};    
    setmetatable(self, SpringCampPrepareChallengeItem);
    return self;
end

function SpringCampPrepareChallengeItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function SpringCampPrepareChallengeItem:SetData(data)
    self.data = data.data;
    SetActive(self.getIcon, self.data.isComplete);
    self.content.text = self.data.content;
    SetActive(self.finishGO, self.data.isComplete);
end

function SpringCampPrepareChallengeItem:Clear()
    self.data = nil;
end

function SpringCampPrepareChallengeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end