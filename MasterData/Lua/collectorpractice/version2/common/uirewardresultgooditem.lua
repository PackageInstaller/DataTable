
UIRewardResultGoodItem = {}
UIRewardResultGoodItem.__index = UIRewardResultGoodItem





function UIRewardResultGoodItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, UIRewardResultGoodItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.textItemCount = uiLink:Get("textItemCount"):GetComponent("Text");
		self.rawImageItemIcon = uiLink:Get("rawImageItemIcon"):GetComponent("RawImage");
	return self
	end


	function UIRewardResultGoodItem:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.textItemCount = nil;
		self.rawImageItemIcon = nil;
	end


function UIRewardResultGoodItem:SetData(goodId,goodCount)
    SetActive(self.gameObject, true);
	self.textItemCount.text=tostring(goodCount);
	self.rawImageItemIcon.texture=GetItemTexture(goodId)
end


function UIRewardResultGoodItem:Hide()
    SetActive(self.gameObject, false);
end

