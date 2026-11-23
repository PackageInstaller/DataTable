
UICollectorSelectCharacterItem = {}
UICollectorSelectCharacterItem.__index = UICollectorSelectCharacterItem



function UICollectorSelectCharacterItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, UICollectorSelectCharacterItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.goIsNotSelectedCharacter = uiLink:Get("goIsNotSelectedCharacter");
		self.goIsSelectedCharacter = uiLink:Get("goIsSelectedCharacter");
		self.rawImageCharacterAvatar = uiLink:Get("rawImageCharacterAvatar"):GetComponent("RawImage");
		self.imgJobIcon = uiLink:Get("imgJobIcon"):GetComponent("Image");
		self.textLevel = uiLink:Get("textLevel"):GetComponent("Text");
        self.nowCharacter=nil;
        self.btnClickCharacter= uiLink:Get("btnClickCharacter"):GetComponent("Button");
        self.fun=nil;
        uiLink:AddClickEvent("btnClickCharacter", function()
            if self.fun~=nil then
                self.fun(self.parent,self);
            end
        end)
	return self
	end


	function UICollectorSelectCharacterItem:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.goIsNotSelectedCharacter = nil;
		self.goIsSelectedCharacter = nil;
		self.rawImageCharacterAvatar = nil;
		self.imgJobIcon = nil;
		self.textLevel = nil;
        self.nowCharacter=nil;
        self.btnClickCharacter=nil;
        self.fun=nil;
	end

function UICollectorSelectCharacterItem:SetData(fun,parent)
    SetActive(self.gameObject,true);
    self.fun=fun;
    self.parent=parent
end

function UICollectorSelectCharacterItem:SetCharacter(heroId)
    if heroId~=nil and DataMgr.Player.characters[heroId]~=nil then
        SetActive(self.goIsNotSelectedCharacter,false);
        SetActive(self.goIsSelectedCharacter,true);
        self.imgJobIcon.sprite=LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroId].job)
        self.textLevel.text=tostring(DataMgr.Player.characters[heroId].level);
        self.rawImageCharacterAvatar.texture=LuaMgr.GetTexture(string.format("Character/%s/Avatar/%s.png", heroId,DataMgr.Player.characters[heroId].curSkin));
        self.nowCharacter=heroId;
    else
        SetActive(self.goIsNotSelectedCharacter,true);
        SetActive(self.goIsSelectedCharacter,false);
        self.nowCharacter=nil;
    end
end

function UICollectorSelectCharacterItem:Hide()
    SetActive(self.gameObject, false);
end

