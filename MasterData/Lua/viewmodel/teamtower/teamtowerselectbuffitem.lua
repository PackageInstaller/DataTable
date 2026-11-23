TeamTowerSelectBuffItem = {};

TeamTowerSelectBuffItem.__index = TeamTowerSelectBuffItem;

TeamTowerSelectBuffItem.color = {UnityEngine.Color(110 / 255, 85 / 255, 100 / 255, 1),
                                 UnityEngine.Color(57 / 255, 70 / 255, 82 / 255, 1),
                                 UnityEngine.Color(66 / 255, 91 / 255, 73 / 255, 1)}

local objs = {
    bg = { path = "obj/BG", type = "Image" },
    btn = { path = "obj/BG", type = "Button" },
    desc = { path = "obj/desc", type = "Text" },
    icon = { path = "obj/icon", type = "Image" },
    name = { path = "obj/name", type = "Text" },
    selectObj = { path = "obj/select", type = "GameObject" },
    obj = { path = "obj", type = "GameObject" },
    nameOutline = {path = "obj/name", type = "OutlineEx"},
}

function TeamTowerSelectBuffItem.New(prefab,parent)
    local self = {};
    setmetatable(self, TeamTowerSelectBuffItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtn = function()
        if self.onClick ~= nil then
            self.onClick(self)
        end
    end
    if self.btn ~= nil then
        LuaMgr.AddClick(self.btn, self.OnClickBtn);
    end
    return self;
end

function TeamTowerSelectBuffItem:SetData(data)
    self.onClick = data.onClick
    self.buffId = data.buffId
    self.floor = data.floor
    local buff = ConfigMgr.Config.TeamTowerBuffPoolMap[self.buffId];
    if not IsNull(buff) then
        local buffConfig = ConfigMgr.Config.TeamTowerBuffDescMap[buff.Key];
        self.bg.sprite = LuaMgr.GetSprite("TeamTowerSprite", "ui_hd_trj_pt_qw_tbd0" .. buffConfig.Param[1])
        self.icon.sprite = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
        self.desc.text = LuaMgr.GetLangText(buffConfig.BuffDesLan)
        self.name.text = LuaMgr.GetLangText(buffConfig.BuffNameLan)
        self.nameOutline.effectColor = self.color[tonumber(buffConfig.Param[1])]
    end
    self:Select(false)
end

function TeamTowerSelectBuffItem:Select(select)
    SetActive(self.selectObj,select);
    self.obj.transform.anchoredPosition = Vector2(0,select and 0 or -30)
end

function TeamTowerSelectBuffItem:Clear()
    self.data = nil;
end

function TeamTowerSelectBuffItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end