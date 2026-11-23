
TurnTableGameResultItem = {};
TurnTableGameResultItem.__index = TurnTableGameResultItem


function TurnTableGameResultItem.New(parentTran) 
	local self = {}
	setmetatable(self, TurnTableGameResultItem)
    self.gameObject = LuaMgr.GetPrefab(
        "Assets/_BundleResources/UI/Home/TeaRoomNewTurnTableGame/TurnTableGameResultItem.prefab");
	self.transform = self.gameObject:GetComponent("RectTransform")
	self.transform:SetParent(parentTran, false);
	self.animator=self.gameObject:GetComponent("Animator");
	self.clickEffectGameObject=self.transform:Find("UI_TurnTable_PointOut").gameObject
	self.clickEffect=self.clickEffectGameObject:GetComponent("ParticleSystem");
	SetActive(self.gameObject,false)
	return self
	end	


	function TurnTableGameResultItem:Appear(openEffect)
		SetActive(self.gameObject,true)

		SetActive(self.clickEffectGameObject,openEffect);
	end
	
	function TurnTableGameResultItem:Destroy() 
		LuaMgr.DestroyImmediateGO(self.gameObject);
	self.gameObject = nil
	self.transform = nil
	self.goPlayerNotFinish = nil;
	self.goPlayerFinish = nil;
	self.goObstacle = nil;
	end