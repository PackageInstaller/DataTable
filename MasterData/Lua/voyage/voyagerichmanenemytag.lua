VoyageRichManEnemyTag = {};

VoyageRichManEnemyTag.__index = VoyageRichManEnemyTag;

local objs = {
    blue = { path = "Blue", type = "GameObject" },
    gray = { path = "Gray", type = "GameObject" },
    text = { path = "Text", type = "Text" },
};

function VoyageRichManEnemyTag.New()
    local self = {};
    setmetatable(self, VoyageRichManEnemyTag);
    return self;
end

function VoyageRichManEnemyTag:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageRichManEnemyTag:SetData(data)
    local status = data.data.status;
    SetActive(self.blue, status);
    SetActive(self.gray, not status);
    self.text.text = string.format("<color=%s>%s</color>", status and "#262429" or "#A4997E", LuaMgr.GetLangText(data.data.id));
end

function VoyageRichManEnemyTag:Clear()
    
end

function VoyageRichManEnemyTag:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end