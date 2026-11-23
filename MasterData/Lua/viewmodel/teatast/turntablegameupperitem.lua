
TurnTableGameUpperItem = {};
TurnTableGameUpperItem.__index = TurnTableGameUpperItem

TurnTableGameUpperItemType={
	player=1,
	obstacle=2,
}

function TurnTableGameUpperItem.New(parentTran) 
	local self = {}
	setmetatable(self, TurnTableGameUpperItem)
    self.gameObject = LuaMgr.GetPrefab(
        "Assets/_BundleResources/UI/Home/TeaRoomNewTurnTableGame/TurnTableGameUpperItem.prefab");
	self.transform = self.gameObject:GetComponent("RectTransform")
	self.transform:SetParent(parentTran, false);
	local uiLink = self.gameObject:GetComponent("UILink");
	self.goPlayerNotFinish = uiLink:Get("goPlayerNotFinish");
	self.goPlayerFinish = uiLink:Get("goPlayerFinish");
	self.goObstacle = uiLink:Get("goObstacle");
	self.animator=self.gameObject:GetComponent("Animator");
        self.x=0;
        self.y=0;
		self.isObstacle=false;
		self.isPlayer=false;
		self.isFinish=false;
	return self
	end



	function TurnTableGameUpperItem:SetFinish(finish)
		self.isFinish=finish
		SetActive(self.goPlayerNotFinish,not self.isFinish)
		SetActive(self.goPlayerFinish,self.isFinish)
        end	
		
	function TurnTableGameUpperItem:Appear()
		SetActive(self.gameObject,true);
		if self.isObstacle then
			self.animator:Play("UI_TurnTableGameUpperItem_obtanchu",0,0)
		elseif self.isFinish then
			self.animator:Play("UI_TurnTableGameUpperItem_lvseanchu",0,0)
		else
			self.animator:Play("UI_TurnTableGameUpperItem_heiseanchu",0,0)
		end
	end

	function TurnTableGameUpperItem:SetData(posX,posY,type)
        self.x=posX;
        self.y=posY;
if type==TurnTableGameUpperItemType.player then
			self.isPlayer=true;
			SetActive(self.goObstacle,false);
		elseif type==TurnTableGameUpperItemType.obstacle then
			self.isObstacle=true;
			SetActive(self.goPlayerNotFinish,false);
			SetActive(self.goPlayerFinish,false);
		end
		SetActive(self.gameObject,false);
        end

	function TurnTableGameUpperItem:Destroy() 
		LuaMgr.DestroyImmediateGO(self.gameObject);
	self.gameObject = nil
	self.transform = nil
	self.goPlayerNotFinish = nil;
	self.goPlayerFinish = nil;
	self.goObstacle = nil;
	end