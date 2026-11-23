MiniBattle4EnemyItem = {};

MiniBattle4EnemyItem.__index = MiniBattle4EnemyItem;

local objs = {
    icon = { path = "Group/Icon", type = "RawImage" },
    border = { path = "Group/Border", type = "Image" },
    typeGO = { path = "Group/Type", type = "GameObject" },
    type = { path = "Group/Type", type = "Image" },
};

function MiniBattle4EnemyItem.New()
    local self = {};    
    setmetatable(self, MiniBattle4EnemyItem);
    return self;
end

function MiniBattle4EnemyItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function MiniBattle4EnemyItem:SetData(data)
    self.data = data.data;
    local path = string.format("Assets/_BundleResources/Character/%s/Avatar/%s.png", self.data.monsterModel, self.data.monsterSkin);
    self.icon.texture = LuaMgr.GetTexture(path);
    local monsterType = self.data.type;
    self.border.sprite = LuaMgr.GetSprite("CommonRes", monsterType == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai");
    if (monsterType == 0) then
        SetActive(self.typeGO, false);
    elseif (monsterType == 1) then
        self.type.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj");
        SetActive(self.typeGO, true);
    elseif (monsterType == 2) then
        self.type.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss");
        SetActive(self.typeGO, true);
    elseif (monsterType == 3) then
        self.type.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy");
        SetActive(self.typeGO, true);
    end
    SetActive(self.gameObject, true);
end

function MiniBattle4EnemyItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.border.sprite = nil;
    self.type.sprite = nil;
end

function MiniBattle4EnemyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end