VoyageRichManBattleJobItem = {};

VoyageRichManBattleJobItem.__index = VoyageRichManBattleJobItem;

local objs = {
    icon = { path = "Icon", type = "Image" },
};

function VoyageRichManBattleJobItem.New()
    local self = {};
    setmetatable(self, VoyageRichManBattleJobItem);
    return self;
end

function VoyageRichManBattleJobItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageRichManBattleJobItem:SetData(data)
    self.icon.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. data.data);
end

function VoyageRichManBattleJobItem:Clear()
    self.icon.sprite = nil;
end

function VoyageRichManBattleJobItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end