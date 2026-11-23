VoyageRichManEnemyAttribute = {};

VoyageRichManEnemyAttribute.__index = VoyageRichManEnemyAttribute;

local objs = {
    name = { path = "Name", type = "Text" },
    evaluate = { path = "Evaluate", type = "Text" },
};

function VoyageRichManEnemyAttribute.New()
    local self = {};
    setmetatable(self, VoyageRichManEnemyAttribute);
    return self;
end

function VoyageRichManEnemyAttribute:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageRichManEnemyAttribute:SetData(data)
    self.name.text = data.data.name;
    self.evaluate.text = data.data.evaluate;
end

function VoyageRichManEnemyAttribute:Clear()

end

function VoyageRichManEnemyAttribute:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end