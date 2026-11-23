MiniBattle4CharacterItem = {};

MiniBattle4CharacterItem.__index = MiniBattle4CharacterItem;

local objs = {
    ClickBtn = { path = "Group", type = "UIButtonClick" },
    group = { path = "Group", type = "GameObject" },
    body = { path = "Group/Body", type = "RawImage" },
    level = { path = "Group/Level", type = "Text" },
    rare = { path = "Group/Rare", type = "Image" },
    name = { path = "Group/Name", type = "Text" },
    zyImg = { path = "Group/ZY", type = "Image" },
    zzImg = { path = "Group/ZZ", type = "Image" },
    zzText = { path = "Group/ZZ/Text", type = "Text" },
    assistGO = { path = "Group/Assist", type = "GameObject" },
    hzActive = { path = "Group/HZActive", type = "GameObject" },
    hzNotActive = { path = "Group/HZNotActive", type = "GameObject" },
    lockGo = { path = "Group/Lock", type = "GameObject" },
    selectedGo = { path = "Group/Selected", type = "GameObject" },
};

function MiniBattle4CharacterItem.New()
    local self = {};
    setmetatable(self, MiniBattle4CharacterItem);
    return self;
end

function MiniBattle4CharacterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local monsterId = ""
        if self.data.isLocked then
            return
        end
        if not self.data.isSelected then
            monsterId = self.data.monsterId
        end
        if self.data.onClick ~= nil then
            self.data.onClick(monsterId)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
end

function MiniBattle4CharacterItem:SetData(data)
    self.data = data.data;

    local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(self.data.monsterId)
    local characterConfig = ConfigCharacterMgr.GetCharacter(monsterInfo.charecterId);
    local nowRare = characterConfig.rare + monsterInfo.dualBattleCfg.RareLevel
    SetActive(self.assistGO, false);
    if nowRare > 0 then
        local brilliantKey = monsterInfo.charecterId .. CharacterRare.SSR
        local brilliantIsBool = ConfigMgr.Config.BrilliantMap[brilliantKey] ~= nil
        SetActive(self.hzActive, brilliantIsBool and nowRare > 4)
        SetActive(self.hzNotActive, brilliantIsBool and nowRare <= 4)
    end
    self.body.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Cards/%s.png", characterConfig.id, monsterInfo.skinId));
    local imageRare = nowRare >= 5 and 4 or nowRare
    self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. imageRare);
    self.name.text = LuaMgr.GetLangText(characterConfig.namelan);
    self.zyImg.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
    self.level.text = tostring(monsterInfo.level);
    if (monsterInfo.star > 0) then
        self.zzImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1");
        self.zzText.text = HeroMgr.GetNumStr(monsterInfo.star);
        self.zzText.color = UnityEngine.Color(0.2, 0.2, 0.2, 1);
    else
        self.zzImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz2");
        self.zzText.text = HeroMgr.GetNumStr(1);
        self.zzText.color = UnityEngine.Color(172 / 255, 169 / 255, 163 / 255, 1);
    end
    SetActive(self.lockGo, self.data.isLocked);
    self:Refresh()
end

function MiniBattle4CharacterItem:Refresh()
    SetActive(self.selectedGo, self.data.isSelected);
    SetActive(self.group, self.data.isShow);
end

function MiniBattle4CharacterItem:Clear()
    self.data = nil;
    self.body.texture = nil;
    self.rare.sprite = nil;
    self.zyImg.sprite = nil;
    self.zzImg.sprite = nil;
end

function MiniBattle4CharacterItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end