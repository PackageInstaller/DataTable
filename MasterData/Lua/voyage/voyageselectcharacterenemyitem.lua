VoyageSelectCharacterEnemyItem = {};

VoyageSelectCharacterEnemyItem.__index = VoyageSelectCharacterEnemyItem;

local objs = {
    icon = { path = "Icon", type = "RawImage" },
    border = { path = "Border", type = "Image" },
    typeGO = { path = "Type", type = "GameObject" },
    typeImg = { path = "Type", type = "Image" },
};

function VoyageSelectCharacterEnemyItem.New()
    local self = {};
    setmetatable(self, VoyageSelectCharacterEnemyItem);
    return self;
end

function VoyageSelectCharacterEnemyItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageSelectCharacterEnemyItem:SetData(data)
    local monster = data.data;
    self.icon.texture = GetCharacterTexture(monster.monsterModel, monster.monsterSkin);
    self.border.sprite = LuaMgr.GetSprite("CommonRes", monster.type == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai");
    SetActive(self.typeGO, monster.type ~= 0);
    if (monster.type == 1) then
        self.typeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj");
    elseif (monster.type == 2) then
        self.typeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss");
    elseif (monster.type == 3) then
        self.typeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy");
    end
end

function VoyageSelectCharacterEnemyItem:Clear()
    self.icon.texture = nil;
    self.border.sprite = nil;
    self.typeImg.sprite = nil;
end

function VoyageSelectCharacterEnemyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end