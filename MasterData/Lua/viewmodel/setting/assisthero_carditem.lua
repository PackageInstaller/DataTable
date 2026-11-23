AssistHero_CardItem = {};

AssistHero_CardItem.__index = AssistHero_CardItem;
local objs = {
    picHeroIcon={path="root/HeroPic",type="RawImage"},
    imgHeroRare={path="root/HeroRare",type="Image"},
    txtLevel={path="root/HeroLevel",type="Text"},
    imgJob={path="root/HeroJob",type="Image"},
    imgZZType={path="root/HeroZZ",type="Image"},
    txtZZ={path="root/HeroZZ/Text",type="Text"},
    txtName={path="root/HeroName",type="Text"},
    hzActive = {path="root/HZActive",type="GameObject"},
    hzNotActive = {path="root/HZNotActive",type="GameObject"},
}

   

function AssistHero_CardItem.New()
    local self = {};
    setmetatable(self, AssistHero_CardItem);
    return self;
end

function AssistHero_CardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end











function AssistHero_CardItem:SetData(pdata)
    self.data=pdata.data
    self.txtName.text=self.data.name;
    self.txtLevel.text=self.data.level;
    self.picHeroIcon.texture=LuaMgr.GetTexture(HeroMgr.GetCharacterCard(self.data.id))
    local tempRare = HeroMgr.GetHeroNowRare(self.data.id)
    local imageRare = tempRare >= 5 and 4 or tempRare
    self.imgHeroRare.sprite=LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..imageRare)
    self.imgJob.sprite=LuaMgr.GetSprite("JobIcon","job_"..self.data.job)
    local zzStr = self.data.star > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    self.txtZZ.text = string.format(zzStr,HeroMgr.GetNumStr(math.abs(self.data.star)))
    self.imgZZType.sprite = LuaMgr.GetSprite("CommonRes",self.data.star > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
    local curRare = HeroMgr.GetHeroNowRare(self.data.id)
    if curRare > 0 then
        local brilliantKey = self.data.id..self.data.rare
        local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
        SetActive(self.hzActive,not TableIsNull(brilliant) and curRare > 4)
        SetActive(self.hzNotActive,not TableIsNull(brilliant) and curRare <= 4)
    end
end

function AssistHero_CardItem:Clear()
 
    self.data=nil
end

function AssistHero_CardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

