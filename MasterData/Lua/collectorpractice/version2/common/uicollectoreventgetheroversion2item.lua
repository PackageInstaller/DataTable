UICollectorEventGetHeroVersion2Item = {}

UICollectorEventGetHeroVersion2Item.__index = UICollectorEventGetHeroVersion2Item


function UICollectorEventGetHeroVersion2Item.New(prefab, parent) 
	local self = {}
	setmetatable(self, UICollectorEventGetHeroVersion2Item)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.goNoNowBuff = uiLink:Get("goNoNowBuff");
		self.goHeroCardItem = uiLink:Get("goHeroCardItem");
		self.rawImageHeroPic = uiLink:Get("rawImageHeroPic"):GetComponent("RawImage");
		self.imgHeroRare = uiLink:Get("imgHeroRare"):GetComponent("Image");
		self.imgHeroJob = uiLink:Get("imgHeroJob"):GetComponent("Image");
		self.imgHeroZZ = uiLink:Get("imgHeroZZ"):GetComponent("Image");
		self.textHeroLevel = uiLink:Get("textHeroLevel"):GetComponent("Text");
		self.textHeroZZ = uiLink:Get("textHeroZZ"):GetComponent("Text");
		self.textHeroName = uiLink:Get("textHeroName"):GetComponent("Text");
		self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
		self.goHZActive = uiLink:Get("goHZActive")
		self.goHZNotActive = uiLink:Get("goHZNotActive")
        uiLink:AddClickEvent("btnClick", function()
            if self.fun~=nil then
                self.fun(self);
            end
        end)
	return self
	end


	function UICollectorEventGetHeroVersion2Item:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.goNoNowBuff = nil;
		self.goHeroCardItem = nil;
		self.rawImageHeroPic = nil;
		self.imgHeroRare = nil;
		self.imgHeroJob = nil;
		self.imgHeroZZ = nil;
		self.textHeroLevel = nil;
		self.textHeroZZ = nil;
		self.textHeroName = nil;
		self.btnClick = nil;
		self.goHZActive = nil
		self.goHZNotActive = nil
	end

function UICollectorEventGetHeroVersion2Item:SetData(data)
    SetActive(self.gameObject, true);
    self.data = data;
    local showHeroId=self.data.heroId;
    self.fun=self.data.fun;
    if IsNullOrEmpty(showHeroId) then
        SetActive(self.goHeroCardItem,false);
        SetActive(self.goNoNowBuff,true);
    else
		SetActive(self.goHeroCardItem,true);
        SetActive(self.goNoNowBuff,false);
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
    end
end


function UICollectorEventGetHeroVersion2Item:Hide()
    SetActive(self.gameObject, false);
end