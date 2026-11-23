VoyageSelectCharacterJobItem = {};

VoyageSelectCharacterJobItem.__index = VoyageSelectCharacterJobItem;

local objs = {
    icon = { path = "Icon", type = "Image" },
};

function VoyageSelectCharacterJobItem.New()
    local self = {};
    setmetatable(self, VoyageSelectCharacterJobItem);
    return self;
end

function VoyageSelectCharacterJobItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageSelectCharacterJobItem:SetData(data)
    self.icon.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. data.data);
end

function VoyageSelectCharacterJobItem:Clear()
    self.icon.sprite = nil;
end

function VoyageSelectCharacterJobItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end