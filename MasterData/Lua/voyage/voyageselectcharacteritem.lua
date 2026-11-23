VoyageSelectCharacterItem = {};

VoyageSelectCharacterItem.__index = VoyageSelectCharacterItem;

local objs = {
    button = { path = "", type = "Button" },
    add = { path = "Add", type = "GameObject" },
    group = { path = "Group", type = "GameObject" },
    body = { path = "Group/Body", type = "RawImage" },
    level = { path = "Group/Level", type = "Text" },
    rare = { path = "Group/Rare", type = "Image" },
    name = { path = "Group/Name", type = "Text" },
    zy = { path = "Group/ZY", type = "Image" },
    zzGO = { path = "Group/ZZ", type = "GameObject" },
    zz = { path = "Group/ZZ", type = "Image" },
    zzText = { path = "Group/ZZ/Text", type = "Text" },
}

function VoyageSelectCharacterItem.New()
    local self = {};
    setmetatable(self, VoyageSelectCharacterItem);
    return self;
end

function VoyageSelectCharacterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageSelectCharacterClick, self.id);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageSelectCharacterItem:SetData(data)
    self.id = data.data;
    if (IsNullOrEmpty(self.id)) then
        SetActive(self.add, true);
        SetActive(self.group, false);
        return;
    end
    local characterConfig = ConfigMgr.Config.characterTable[self.id];
    if (characterConfig == nil) then
        local actorConfig = ConfigMgr.Config.actor[self.id];
        if (actorConfig ~= nil) then
            local skinId = actorConfig.SkinParam;
            if (IsNullOrEmpty(skinId)) then
                skinId = actorConfig.CharacterId .. "001";
            end
            self.body.texture = self:GetBodyTexture(actorConfig.CharacterId, skinId);
            characterConfig = ConfigMgr.Config.characterTable[actorConfig.CharacterId];
            if (characterConfig ~= nil) then
                self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..characterConfig.rare);
                self.name.text = LuaMgr.GetLangText(characterConfig.namelan);
                self.zy.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
            end
            self.level.text = tostring(actorConfig.Level);
        end
        SetActive(self.zzGO, false);
    else
        local skinId = HeroManager.GetCharacterSkin(self.id);
        self.body.texture = self:GetBodyTexture(self.id, skinId);
        self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..characterConfig.rare);
        self.name.text = LuaMgr.GetLangText(characterConfig.namelan);
        self.zy.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
        local characterData = PlayerCharacterMgr.GetCharacter(self.id);
        if (characterData ~= nil) then
            self.level.text = tostring(characterData.level);
            if (characterData.star > 0) then
                self.zz.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1");
                self.zzText.text = HeroMgr.GetNumStr(characterData.star);
                self.zzText.color = UnityEngine.Color(0.2,0.2,0.2,1);
            else
                self.zz.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz2");
                self.zzText.text = HeroMgr.GetNumStr(1);
                self.zzText.color = UnityEngine.Color(172/255,169/255,163/255,1);
            end
        end
        SetActive(self.zzGO, true);
    end
    SetActive(self.add, false);
    SetActive(self.group, true);
end

function VoyageSelectCharacterItem:GetBodyTexture(characterId, skinId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Cards/%s.png", characterId, skinId));
end

function VoyageSelectCharacterItem:Clear()
    self.body.texture = nil;
    self.rare.sprite = nil;
    self.zy.sprite = nil;
    self.zz.sprite = nil;
end

function VoyageSelectCharacterItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end