ActivityBattlePrepareHeroItem = {};

ActivityBattlePrepareHeroItem.__index = ActivityBattlePrepareHeroItem;

local objs = {
    icon = { path = "Group/Icon", type = "RawImage" },
    job = { path = "Group/Job", type = "Image" },
    rare = { path = "Group/Rare", type = "Image" },
};

function ActivityBattlePrepareHeroItem.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareHeroItem);
    return self;
end

function ActivityBattlePrepareHeroItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function ActivityBattlePrepareHeroItem:SetData(data)
    self.data = data.data;
    local path = ConfigHelper.GetCharacterAvatarPath(self.data.id);
    self.icon.texture = LuaMgr.GetTexture(path);

    self.job.sprite = LuaMgr.GetSprite("JobIcon", "jobtips_" .. self.data.job);

    self.rare.sprite = LuaMgr.GetSprite("AssistRare", "ui_sz_qzyz_tx0" .. self.data.rare);

    SetActive(self.gameObject, true);
end

function ActivityBattlePrepareHeroItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.job.sprite = nil;
    self.rare.sprite = nil;
end

function ActivityBattlePrepareHeroItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end