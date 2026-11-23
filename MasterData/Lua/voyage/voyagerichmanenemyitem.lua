VoyageRichManEnemyItem = {};

VoyageRichManEnemyItem.__index = VoyageRichManEnemyItem;

local objs = {
    button = { path = "", type = "Button" },
    select = { path = "Group/Select", type = "GameObject" },
    normal = { path = "Group/Normal", type = "GameObject" },
    headIcon = { path = "Group/Head/Icon", type = "RawImage" },
    headBorder = { path = "Group/Head/Border", type = "Image" },
    headTypeGO = { path = "Group/Head/Type", type = "GameObject" },
    headTypeImg = { path = "Group/Head/Type", type = "Image" },
    name = { path = "Group/Name", type = "Text" },
};

function VoyageRichManEnemyItem.New()
    local self = {};
    setmetatable(self, VoyageRichManEnemyItem);
    return self;
end

function VoyageRichManEnemyItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManEnemy, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageRichManEnemyItem:SetData(data)
    self.data = data.data;
    local monster = self.data.data;
    local nameStr = "";
    if (self.data.select) then
        SetActive(self.select, true);
        SetActive(self.normal, false);
        nameStr = "<color=#EFE5CC>%s</color>";
    else
        SetActive(self.select, false);
        SetActive(self.normal, true);
        nameStr = "<color=#C1C0C0>%s</color>";
    end
    self.name.text = string.format(nameStr, LuaMgr.GetLangText(monster.NameLan));
    self.headIcon.texture = GetCharacterTexture(monster.monsterModel, monster.monsterSkin);
    self.headBorder.sprite = LuaMgr.GetSprite("CommonRes", monster.type == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai");
    SetActive(self.headTypeGO, monster.type ~= 0);
    if (monster.type == 1) then
        self.headTypeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj");
    elseif (monster.type == 2) then
        self.headTypeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss");
    elseif (monster.type == 3) then
        self.headTypeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy");
    end
end

function VoyageRichManEnemyItem:Clear()
    self.data = nil;
    self.headIcon.texture = nil;
    self.headBorder.sprite = nil;
    self.headTypeImg.sprite = nil;
end

function VoyageRichManEnemyItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end