FirstPayExtendHeadItem = {};

FirstPayExtendHeadItem.__index = FirstPayExtendHeadItem;

local objs = {
    icon = { path = "Icon", type = "RawImage" },
    job = { path = "Job", type = "Image" },
    rare = { path = "Rare", type = "Image" },
};

function FirstPayExtendHeadItem.New()
    local self = {};
    setmetatable(self, FirstPayExtendHeadItem);
    return self;
end

function FirstPayExtendHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function FirstPayExtendHeadItem:SetData(data)
    self.data = data.data;
    self.icon.texture = GetCharacterTexture(self.data.id, self.data.id .. "001");
    self.job.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. self.data.job);
    self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_home_kbn_tx" .. self.data.rare);
end

function FirstPayExtendHeadItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.job.sprite = nil;
    self.rare.sprite = nil;
end

function FirstPayExtendHeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end