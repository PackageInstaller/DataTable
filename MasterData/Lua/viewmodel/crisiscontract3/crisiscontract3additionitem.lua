CrisisContract3AdditionItem = {};

CrisisContract3AdditionItem.__index = CrisisContract3AdditionItem;

local objs = {
    text = { path = "Text", type = "Text" },
}

function CrisisContract3AdditionItem.New()
    local self = {};
    setmetatable(self, CrisisContract3AdditionItem);
    return self;
end

function CrisisContract3AdditionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function CrisisContract3AdditionItem:SetData(desc)
    self.text.text = desc
    SetActive(self.gameObject, true)
end

function CrisisContract3AdditionItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract3AdditionItem:Clear()
end

function CrisisContract3AdditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end