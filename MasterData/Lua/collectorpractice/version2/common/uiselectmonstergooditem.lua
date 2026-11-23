
UISelectMonsterGoodItem = {}
UISelectMonsterGoodItem.__index = UISelectMonsterGoodItem




function UISelectMonsterGoodItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, UISelectMonsterGoodItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.goGoodsItem = uiLink:Get("goGoodsItem"):GetComponent("GoodsViewModel");
		self.goDone = uiLink:Get("goDone");
	return self
	end


	function UISelectMonsterGoodItem:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.goGoodsItem = nil;
		self.goDone = nil;
	end


function UISelectMonsterGoodItem:SetData(goodId,goodCount,isDone)
	SetActive(self.gameObject,true);
    self.goGoodsItem:SetData(tostring(goodId),tonumber(goodCount), 1, 1, true);
    SetActive(self.goDone,isDone)
end


function UISelectMonsterGoodItem:Hide()
    SetActive(self.gameObject, false);
end

