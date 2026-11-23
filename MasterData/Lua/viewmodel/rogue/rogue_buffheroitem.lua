Rogue_BuffHeroItem = {};

Rogue_BuffHeroItem.__index = Rogue_BuffHeroItem;

local objs = {
    rootTF={path = "AnimRoot",type = "Transform"},
    bgBtn = {path = "AnimRoot",type = "Button"},
    heroPic = {path = "AnimRoot/HeroPic",type = "RawImage"},
    heroRare = {path = "AnimRoot/HeroRare",type = "Image"},
    heroLevel = {path = "AnimRoot/HeroLevel",type = "Text"},
    heroJob = {path = "AnimRoot/HeroJob",type = "Image"},
    heroZZ = {path = "AnimRoot/HeroZZ",type = "Image"},
    heroZZText = {path = "AnimRoot/HeroZZ/Text",type = "Text"},
    heroName = {path = "AnimRoot/HeroName",type = "Text"},
    hzActive = {path="AnimRoot/HZActive",type="GameObject"},
    hzNotActive = {path="AnimRoot/HZNotActive",type="GameObject"},
    choice = {path = "AnimRoot/Choice",type = "GameObject"},
    exploreLevel={path = "AnimRoot/ExploreLevel",type = "Image"},
};

function Rogue_BuffHeroItem.New()
    local self = {};
    setmetatable(self, Rogue_BuffHeroItem);
    return self;
end

function Rogue_BuffHeroItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.index~=nil  and self.data.callback ~= nil) then
            self.data.callback(self.data.index)
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.OnClickItem);
end

function Rogue_BuffHeroItem:SetData(data)
    self.data = data.data;
    self.rootTF.localScale=Vector3.one*self.data.scale;
    self.heroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(self.data.data.id,self.data.data.curSkin))
    self.heroLevel.text = self.data.data.level
    self.heroJob.sprite = LuaMgr.GetSprite("JobIcon","job_"..self.data.data.job)
    self.heroName.text = self.data.data.name
    self.choice:SetActive(self.data.isChoice)
    if self.data.data.rare > 0 then
        SetActive(self.hzActive,self.data.data.isHZ )
        SetActive(self.hzNotActive,self.data.data.isNoHZ)
    end
    local imageRare = self.data.data.rare >= 5 and 4 or self.data.data.rare
    self.heroRare.sprite = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..imageRare)
    local zzLevel=self.data.data.star > 0 and self.data.data.star or -1;
    local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    self.heroZZText.text = string.format(zzStr,HeroMgr.GetNumStr(math.abs(zzLevel)))
    self.heroZZ.sprite = LuaMgr.GetSprite("CommonRes",zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
    SetActive(self.exploreLevel.gameObject,self.data.exploreLevel>0)
    if self.data.exploreLevel>0 then
        self.exploreLevel.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_glxz_tsdj0"..self.data.exploreLevel)
    end
end

function Rogue_BuffHeroItem:SetSelect(isOn)
    self.choice:SetActive(isOn)
end

function Rogue_BuffHeroItem:Clear()
    self.data = nil;
end

function Rogue_BuffHeroItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.bgBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end