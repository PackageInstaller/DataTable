UICollectorMainSceneCharacterVersion2Item = {}

UICollectorMainSceneCharacterVersion2Item.__index = UICollectorMainSceneCharacterVersion2Item



function UICollectorMainSceneCharacterVersion2Item.New(prefab, parent) 
	local self = {}
	setmetatable(self, UICollectorMainSceneCharacterVersion2Item)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.rawImageCharacterIcon = uiLink:Get("rawImageCharacterIcon"):GetComponent("RawImage");
		self.goIsDead = uiLink:Get("goIsDead");
		self.imgJobIcon = uiLink:Get("imgJobIcon"):GetComponent("Image");
		self.textCharacterLevel = uiLink:Get("textCharacterLevel"):GetComponent("Text");
	return self
	end


	function UICollectorMainSceneCharacterVersion2Item:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.rawImageCharacterIcon = nil;
		self.goIsDead = nil;
		self.imgJobIcon = nil;
		self.textCharacterLevel = nil;
	end


function UICollectorMainSceneCharacterVersion2Item:SetData(heroId,state)
	SetActive(self.gameObject,true);
    if DataMgr.Player.characters[heroId]~=nil then
        self.imgJobIcon.sprite=LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroId].job)
        self.textCharacterLevel.text=tostring(DataMgr.Player.characters[heroId].level);
        self.rawImageCharacterIcon.texture=LuaMgr.GetTexture(string.format("Character/%s/Avatar/%s.png", heroId,DataMgr.Player.characters[heroId].curSkin));
	end
	if state==1 then
		SetActive(self.goIsDead,true);
	else
		SetActive(self.goIsDead,false);
	end
end


function UICollectorMainSceneCharacterVersion2Item:Hide()
    SetActive(self.gameObject, false);
end