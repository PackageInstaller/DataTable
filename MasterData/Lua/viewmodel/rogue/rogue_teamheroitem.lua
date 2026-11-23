Rogue_TeamHeroItem = {};

Rogue_TeamHeroItem.__index = Rogue_TeamHeroItem;

local objs = {
    EmptyGo = { path = "Group/Empty", type = "GameObject" },
    ClickBtn = { path = "", type = "Button" },
    CharacterGo = { path = "Group/Character", type = "GameObject" },
    heroPic = { path = "Group/Character/HeroPic", type = "RawImage" },
    heroRare = { path = "Group/Character/HeroRare", type = "Image" },
    heroLevel = { path = "Group/Character/HeroLevel", type = "Text" },
    heroJob = { path = "Group/Character/HeroJob", type = "Image" },
    heroZZ = { path = "Group/Character/HeroZZ", type = "Image" },
    heroZZText = { path = "Group/Character/HeroZZ/Text", type = "Text" },
    heroName = { path = "Group/Character/HeroName", type = "Text" },
    hzActive = { path = "Group/Character/HZActive", type = "GameObject" },
    hzNotActive = { path = "Group/Character/HZNotActive", type = "GameObject" },
};

function Rogue_TeamHeroItem.New()
    local self = {};
    setmetatable(self, Rogue_TeamHeroItem);
    return self;
end

function Rogue_TeamHeroItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.index ~= nil and self.data.onClick ~= nil) then
            self.data.onClick(self.data.index)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
end

function Rogue_TeamHeroItem:SetData(data)
    self.data = data.data;
    local showCharacter = not TableIsNull(self.data.characterData)
    SetActive(self.EmptyGo, not showCharacter)
    SetActive(self.CharacterGo, showCharacter)
    if showCharacter then
        local chaData = self.data.characterData
        self.heroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(chaData.id, chaData.id.."001"))
        self.heroLevel.text = chaData.level
        self.heroJob.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. chaData.job)
        self.heroName.text = chaData.name
        if chaData.rare > 0 then
            SetActive(self.hzActive, chaData.isHZ)
            SetActive(self.hzNotActive, chaData.isNoHZ)
        end
        local imageRare = chaData.rare >= 5 and 4 or chaData.rare
        self.heroRare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. imageRare)
        local zzLevel = chaData.star > 0 and chaData.star or -1;
        local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
        self.heroZZText.text = string.format(zzStr, HeroMgr.GetNumStr(math.abs(zzLevel)))
        self.heroZZ.sprite = LuaMgr.GetSprite("CommonRes", zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
    end
end

function Rogue_TeamHeroItem:Clear()
    self.data = nil;
end

function Rogue_TeamHeroItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end