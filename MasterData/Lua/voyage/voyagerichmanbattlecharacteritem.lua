VoyageRichManBattleCharacterItem = {};

VoyageRichManBattleCharacterItem.__index = VoyageRichManBattleCharacterItem;

local objs = {
    button = { path = "", type = "Button" },
    body = { path = "Group/Body", type = "RawImage" },
    level = { path = "Group/Level", type = "Text" },
    zy = { path = "Group/ZY", type = "Image" },
    selectLight = { path = "Group/Select/Light", type = "GameObject" },
    hpBar = { path = "Group/Hp/Bar", type = "Image" },
    hpText = { path = "Group/Hp/Text", type = "Text" },
}

function VoyageRichManBattleCharacterItem.New()
    local self = {};
    setmetatable(self, VoyageRichManBattleCharacterItem);
    return self;
end

function VoyageRichManBattleCharacterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManBattleCharacter, self);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageRichManBattleCharacterItem:SetData(data)
    self.data = data.data;
    local characterConfig = ConfigMgr.Config.characterTable[self.data.ID];
    if (characterConfig == nil) then
        local actorConfig = ConfigMgr.Config.actor[self.data.ID];
        if (actorConfig ~= nil) then
            local skinId = actorConfig.SkinParam;
            if (IsNullOrEmpty(skinId)) then
                skinId = actorConfig.CharacterId .. "001";
            end
            self.body.texture = self:GetBodyTexture(actorConfig.CharacterId, skinId);
            characterConfig = ConfigMgr.Config.characterTable[actorConfig.CharacterId];
            if (characterConfig ~= nil) then
                self.zy.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
            end
            self.level.text = tostring(actorConfig.Level);
        end
    else
        local skinId = HeroManager.GetCharacterSkin(self.data.ID);
        self.body.texture = self:GetBodyTexture(self.data.ID, skinId);
        self.zy.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
        local characterData = PlayerCharacterMgr.GetCharacter(self.data.ID);
        if (characterData ~= nil) then
            self.level.text = tostring(characterData.level);
        end
    end
    local ratio = self.data.HP / self.data.MaxHP;
    self.hpBar.fillAmount = ratio;
    self.hpText.text = math.floor(ratio * 100) .. "%";
    self:SetSelectLight();
end

function VoyageRichManBattleCharacterItem:GetBodyTexture(characterId, skinId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Cards/%s.png", characterId, skinId));
end

function VoyageRichManBattleCharacterItem:SetSelectLight()
    SetActive(self.selectLight, VoyageRichManMgr.HasBattleMember(self.data.ID));
end

function VoyageRichManBattleCharacterItem:Clear()
    self.data = nil;
    self.body.texture = nil;
    self.zy.sprite = nil;
end

function VoyageRichManBattleCharacterItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end