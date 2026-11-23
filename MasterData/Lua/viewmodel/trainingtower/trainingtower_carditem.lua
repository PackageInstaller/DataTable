TrainingTower_CardItem = {};

TrainingTower_CardItem.__index = TrainingTower_CardItem;

local objs = {
    addObj = { path = "root/add", type = "GameObject" },
    suoObj = { path = "root/suo", type = "GameObject" },
    cardObj = { path = "root/card", type = "GameObject" },
    cardRaw = { path = "root/card/HeroPic", type = "RawImage" },
    rareSprite = { path = "root/card/HeroRare", type = "Image" },
    levelText = { path = "root/card/HeroLevel", type = "Text" },
    jobSprite = { path = "root/card/HeroJob", type = "Image" },
    zzSprite = { path = "root/card/HeroZZ", type = "Image" },
    zzText = { path = "root/card/HeroZZ/Text", type = "Text" },
    nameText={path = "root/card/HeroName", type = "Text"},
    btnClick={path="root",type="Button"},
    hzActive = {path="root/card/HZActive",type="GameObject"},
    hzNotActive = {path="root/card/HZNotActive",type="GameObject"},
}
function TrainingTower_CardItem.New()
    local self = {};
    setmetatable(self, TrainingTower_CardItem);
    return self;
end

function TrainingTower_CardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClick=function()
        if  self.data~=nil and self.data.callBack~=nil  and not self.data.isLock then
            self.data.callBack(self.data.index);
        end
    end
    LuaMgr.AddClick(self.btnClick,self.OnClick)
end

function TrainingTower_CardItem:SetData(pdata)
    self.data=pdata.data;
    SetActive(self.addObj,self.data.isAdd)
    SetActive(self.suoObj,self.data.isLock)
    SetActive(self.cardObj,self.data.isCard)
    if self.data.heroData==nil then return end;
    self.cardRaw.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(self.data.heroData.id))
    local tempRare = HeroMgr.GetHeroNowRare(self.data.heroData.id)
    local imageRare = tempRare >= 5 and 4 or tempRare
    self.rareSprite.sprite = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..imageRare)
    self.levelText.text = self.data.heroData.level
    self.jobSprite.sprite =LuaMgr.GetSprite("JobIcon","job_"..self.data.heroData.job)
    local zzLevel=HeroMgr.GetCharacterZZ(self.data.heroData.id);
    self.zzSprite.sprite =  LuaMgr.GetSprite("CommonRes",zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
    local zzStr= zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    self.zzText.text = string.format(zzStr,HeroMgr.GetNumStr(math.abs(zzLevel)))
    self.nameText.text=self.data.heroData.name;
    local curRare = HeroMgr.GetHeroNowRare(self.data.heroData.id)
    if curRare > 0 then
        local brilliantKey = self.data.heroData.id..self.data.heroData.rare
        local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
        SetActive(self.hzActive,not TableIsNull(brilliant) and curRare > 4)
        SetActive(self.hzNotActive,not TableIsNull(brilliant) and curRare <= 4)
    end
end
    

function TrainingTower_CardItem:Clear()
   self.data=nil
end
function TrainingTower_CardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.addObj = nil;
    self.suoObj =nil;
    self.cardObj =nil;
    self.cardRaw = nil;
    self.rareSprite =nil;
    self.levelText =nil;
    self.jobSprite =nil;
    self.zzSprite = nil;
    self.zzText = nil;
    self.nameText=nil;
end

