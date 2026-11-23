
UIRewardResultBuffItem = {}
UIRewardResultBuffItem.__index = UIRewardResultBuffItem





function UIRewardResultBuffItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, UIRewardResultBuffItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");
		self.imgBuffTipsIcon = uiLink:Get("imgBuffTipsIcon"):GetComponent("Image");
		self.textBuffIcon = uiLink:Get("textBuffIcon"):GetComponent("Text");
	return self
	end


	function UIRewardResultBuffItem:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.imgBuffIcon = nil;
		self.imgBuffTipsIcon = nil;
		self.textBuffIcon = nil;
	end

function UIRewardResultBuffItem:SetData(showBuffId,buffCount)
	SetActive(self.gameObject,true);
	print("showBuffId"..showBuffId)
    self.imgBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon",CollectorPracticeMgrVersion2.GetBuffValueById(showBuffId).BuffIcon)
	self.imgBuffTipsIcon.sprite=CollectorPracticeMgrVersion2.GetBuffTipsIconSprite(buffCount)
	self.textBuffIcon.text=tostring(buffCount);
	
end


function UIRewardResultBuffItem:Hide()
    SetActive(self.gameObject, false);
end

