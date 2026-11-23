
UIRewardResultCharacterItem = {}
UIRewardResultCharacterItem.__index = UIRewardResultCharacterItem






function UIRewardResultCharacterItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, UIRewardResultCharacterItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.rawImageCharacterIcon = uiLink:Get("rawImageCharacterIcon"):GetComponent("RawImage");
		self.imgJobIcon = uiLink:Get("imgJobIcon"):GetComponent("Image");
		self.textHeroLevel = uiLink:Get("textHeroLevel"):GetComponent("Text");
	return self
	end


	function UIRewardResultCharacterItem:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.rawImageCharacterIcon = nil;
		self.imgJobIcon = nil;
		self.textHeroLevel = nil;
	end


function UIRewardResultCharacterItem:SetData(heroId)
	SetActive(self.gameObject,true);
    if DataMgr.Player.characters[heroId]~=nil then
        self.imgJobIcon.sprite=LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroId].job)
        self.textHeroLevel.text=tostring(DataMgr.Player.characters[heroId].level);
        self.rawImageCharacterIcon.texture=LuaMgr.GetTexture(string.format("Character/%s/Avatar/%s.png", heroId,DataMgr.Player.characters[heroId].curSkin));
    end
end


function UIRewardResultCharacterItem:Hide()
    SetActive(self.gameObject, false);
end

