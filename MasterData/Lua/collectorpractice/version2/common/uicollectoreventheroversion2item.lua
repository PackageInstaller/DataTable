UICollectorEventHeroVersion2Item = {}

UICollectorEventHeroVersion2Item.__index = UICollectorEventHeroVersion2Item

function UICollectorEventHeroVersion2Item.New()
    local self = {}
    setmetatable(self, UICollectorEventHeroVersion2Item)
    return self
end

function UICollectorEventHeroVersion2Item:Init()
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
    self.rawImageHeroPic = uiLink:Get("rawImageHeroPic"):GetComponent("RawImage");
    self.imgHeroRare = uiLink:Get("imgHeroRare"):GetComponent("Image");
    self.imgHeroJob = uiLink:Get("imgHeroJob"):GetComponent("Image");
    self.imgHeroZZ = uiLink:Get("imgHeroZZ"):GetComponent("Image");
    self.textHeroLevel = uiLink:Get("textHeroLevel"):GetComponent("Text");
    self.textHeroZZ = uiLink:Get("textHeroZZ"):GetComponent("Text");
    self.textHeroName = uiLink:Get("textHeroName"):GetComponent("Text");
    self.goHZActive = uiLink:Get("goHZActive")
    self.goHZNotActive = uiLink:Get("goHZNotActive")
    self.goIsSelected = uiLink:Get("goIsSelected");
        self.isChoose=false;
        self.groupIndex=0;
        self.data = nil;
    uiLink:AddClickEvent("btnClick", function()
        if self.data.fun~=nil then
self.data.fun(self);
        end
    end)
end


function UICollectorEventHeroVersion2Item:SetData(data)
    SetActive(self.gameObject, true);
    self.data = data.data
    self.groupIndex=self.data.groupIndex;
    local showHeroId=self.data.heroId;
    local tempCharacter = ConfigMgr.Config.characterTable[showHeroId]
    if TableIsNull(tempCharacter) then
        return
    end
    self.rawImageHeroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(showHeroId,DataMgr.Player.characters[showHeroId].curSkin))
    local tempRare = HeroMgr.GetHeroNowRare(showHeroId)
    local imageRare = tempRare >= 5 and 4 or tempRare
    self.imgHeroRare.sprite = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..imageRare)
    self.textHeroLevel.text = DataMgr.Player.characters[showHeroId].level
    self.imgHeroJob.sprite = LuaMgr.GetSprite("JobIcon","job_"..tempCharacter.job)
    self.textHeroName.text = LuaMgr.GetLangText(tempCharacter.namelan);

    local zzLevel = HeroMgr.GetCharacterZZ(showHeroId);
    local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    self.textHeroZZ.text = string.format(zzStr,HeroMgr.GetNumStr(math.abs(zzLevel)))
    self.imgHeroZZ.sprite = LuaMgr.GetSprite("CommonRes",zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")

    local curRare = HeroMgr.GetHeroNowRare(showHeroId)
    if curRare > 0 then
        local brilliantKey = showHeroId..tempCharacter.rare
        local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
        SetActive(self.goHZActive,not TableIsNull(brilliant) and curRare > 4)
        SetActive(self.goHZNotActive,not TableIsNull(brilliant) and curRare <= 4)
    end

    self.isChoose=self.data.isChoose;
    self:SetChooseState(self.isChoose);
end

function UICollectorEventHeroVersion2Item:SetChooseState(state)
    self.isChoose=state;
    SetActive(self.goIsSelected,state)
end

function UICollectorEventHeroVersion2Item:Hide()
    SetActive(self.gameObject, false);
end

function UICollectorEventHeroVersion2Item:Clear()
    self.isChoose=nil;
    self.data = nil;

    SetActive(self.gameObject, false);
end

function UICollectorEventHeroVersion2Item:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.groupIndex=nil;
	self.transform = nil
		self.rawImageHeroPic = nil;
		self.imgHeroRare = nil;
		self.imgHeroJob = nil;
		self.imgHeroZZ = nil;
		self.textHeroLevel = nil;
		self.textHeroZZ = nil;
		self.textHeroName = nil;
		self.goIsSelected = nil;
    self.goHZActive = nil
    self.goHZNotActive = nil
end