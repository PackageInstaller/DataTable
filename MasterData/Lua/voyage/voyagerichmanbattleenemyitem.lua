VoyageRichManBattleEnemyItem = {};

VoyageRichManBattleEnemyItem.__index = VoyageRichManBattleEnemyItem;

local objs = {
    icon = { path = "Icon", type = "RawImage" },
    border = { path = "Border", type = "Image" },
    typeGO = { path = "Type", type = "GameObject" },
    typeImg = { path = "Type", type = "Image" },
};

function VoyageRichManBattleEnemyItem.New()
    local self = {};
    setmetatable(self, VoyageRichManBattleEnemyItem);
    return self;
end

function VoyageRichManBattleEnemyItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageRichManBattleEnemyItem:SetData(data)
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

function VoyageRichManBattleEnemyItem:Clear()
    self.icon.texture = nil;
    self.border.sprite = nil;
    self.typeImg.sprite = nil;
end

function VoyageRichManBattleEnemyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end