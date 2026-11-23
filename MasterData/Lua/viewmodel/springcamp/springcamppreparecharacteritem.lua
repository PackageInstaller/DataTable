SpringCampPrepareCharacterItem = {};

SpringCampPrepareCharacterItem.__index = SpringCampPrepareCharacterItem;

local objs = {
    group = { path = "Group", type = "GameObject" },
    body = { path = "Group/Body", type = "RawImage" },
    level = { path = "Group/Level", type = "Text" },
    rare = { path = "Group/Rare", type = "Image" },
    name = { path = "Group/Name", type = "Text" },
    zyImg = { path = "Group/ZY", type = "Image" },
    zzImg = { path = "Group/ZZ", type = "Image" },
    zzText = { path = "Group/ZZ/Text", type = "Text" },
    assistGO = { path = "Group/Assist", type = "GameObject" },
    hzActive = {path = "Group/HZActive", type = "GameObject"},
    hzNotActive = {path = "Group/HZNotActive", type = "GameObject"},
};

function SpringCampPrepareCharacterItem.New()
    local self = {};    
    setmetatable(self, SpringCampPrepareCharacterItem);
    return self;
end

function SpringCampPrepareCharacterItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function SpringCampPrepareCharacterItem:SetData(data)
    self.data = data.data;
    local characterData;
    local skinId;
    local characterConfig = ConfigCharacterMgr.GetCharacter(self.data.id);
    if characterConfig==nil then return end;
    local nowRare = 0
    if  (PlayerAssistMgr.IsAssistMember(characterConfig.id)) then
        local uid = PlayerAssistMgr.GetAssistMemberUid(characterConfig.id);
        characterData = PlayerAssistMgr.GetAssist_Character(uid, characterConfig.id);
        skinId = characterData.curSkin;
        SetActive(self.assistGO, true);
        nowRare = HeroMgr.GetHeroNowRare(self.data.id,uid)
    else
        characterData = PlayerCharacterMgr.GetCharacter(characterConfig.id);
        skinId = HeroManager.GetCharacterSkin(characterConfig.id);
        SetActive(self.assistGO, false);
        nowRare = HeroMgr.GetHeroNowRare(self.data.id)
    end
    if nowRare > 0 then
        local brilliantKey = self.data.id..CharacterRare.SSR
        local brilliantIsBool = ConfigMgr.Config.BrilliantMap[brilliantKey] ~= nil
        SetActive(self.hzActive,brilliantIsBool and nowRare > 4)
        SetActive(self.hzNotActive,brilliantIsBool and nowRare <= 4)
    end
    self.body.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Cards/%s.png", characterConfig.id, skinId));
    local imageRare = nowRare >= 5 and 4 or nowRare
    self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..imageRare);
    self.name.text = LuaMgr.GetLangText(characterConfig.namelan);
    self.zyImg.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
    if (characterData ~= nil) then
        self.level.text = tostring(characterData.level);
        if (characterData.star > 0) then
            self.zzImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1");
            self.zzText.text = HeroMgr.GetNumStr(characterData.star);
            self.zzText.color = UnityEngine.Color(0.2,0.2,0.2,1);
        else
            self.zzImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz2");
            self.zzText.text = HeroMgr.GetNumStr(1);
            self.zzText.color = UnityEngine.Color(172/255,169/255,163/255,1);
        end
    end
    SetActive(self.group, self.data.isShow);
end

function SpringCampPrepareCharacterItem:Clear()
    self.data = nil;
    self.body.texture = nil;
    self.rare.sprite = nil;
    self.zyImg.sprite = nil;
    self.zzImg.sprite = nil;
end

function SpringCampPrepareCharacterItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end