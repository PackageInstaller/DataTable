VoyageRichManEnemySkill = {};

VoyageRichManEnemySkill.__index = VoyageRichManEnemySkill;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    icon = { path = "Group/Icon", type = "RawImage" },
    ex = { path = "Group/Ex", type = "GameObject" },
    type = { path = "Group/Type", type = "Image" },
    level = { path = "Group/Level/Text", type = "Text" },
    name = { path = "Name/Text", type = "Text" },
};

function VoyageRichManEnemySkill.New()
    local self = {};
    setmetatable(self, VoyageRichManEnemySkill);
    return self;
end

function VoyageRichManEnemySkill:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 1, self.data.monster, self.data.skill[1], self.transform, 2, 0);
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function VoyageRichManEnemySkill:SetData(data)
    self.data = data.data;
    local id = self.data.skill[1];
    local level = self.data.skill[2];
    self.icon.texture = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(id, 'ex', '')));
    SetActive(self.ex, string.match(id, "%a%a", -2) == "ex");
    self.level.text = level;
    if (self.data.type == 1) then
        local skill = ConfigSkillMgr.GetCharacterSkill(id .. level)
        if (skill ~= nil) then
            self.type.sprite = LuaMgr.GetSprite("HeroRes", "skillType_" .. skill.Type);
            self.name.text = LuaMgr.GetLangText(skill.NameLan);
        end
    elseif (self.data.type == 2) then
        local skill = ConfigSkillMgr.GetCharacterPassiveSkill(id .. level)
        if skill ~= nil then
            self.type.sprite = LuaMgr.GetSprite("HeroRes", "skillType_" .. skill.Type)
            self.name.text = LuaMgr.GetLangText(skill.NameLan);
        end
    end
end

function VoyageRichManEnemySkill:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.type.sprite = nil;
end

function VoyageRichManEnemySkill:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end