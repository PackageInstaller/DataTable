
TurnTableGameBottomItem = {};
TurnTableGameBottomItem.__index = TurnTableGameBottomItem

function TurnTableGameBottomItem.New(parentTran) 
	local self = {}
	setmetatable(self, TurnTableGameBottomItem)
    self.gameObject = LuaMgr.GetPrefab(
        "Assets/_BundleResources/UI/Home/TeaRoomNewTurnTableGame/TurnTableGameBottomItem.prefab");
	self.transform = self.gameObject:GetComponent("RectTransform")
	self.transform:SetParent(parentTran, false);

	local uiLink = self.gameObject:GetComponent("UILink");
        self.ClickFun=nil;
        self.x=0;
        self.y=0;
        uiLink:AddClickEvent("goClickBtn", function()
            self.ClickFun(self);
        end)
	self.clickEffect=uiLink:Get("UITurnTableselect"):GetComponent("ParticleSystem");
	self.dissolveStepController=uiLink:Get("goClickBtn"):GetComponent(typeof(CS.Laigu.Art.UIDissolveController));
	self.animator=self.gameObject:GetComponent("Animator");

	return self
	end
	function TurnTableGameBottomItem:PlayEffect()
		self.clickEffect:Play();
	end
	function TurnTableGameBottomItem:ForeverStopEffect()
		SetActive(self.clickEffect.gameObject,false)
	end
	function TurnTableGameBottomItem:Appear()
		SetActive(self.gameObject,true);
		self.clickEffect:Stop();
		 self.animator:Play("UI_TurnTableGameBottomItem_chuxian",0,0);
	end

	function TurnTableGameBottomItem:SetData(Fun,posX,posY) 
        self.ClickFun = Fun;
        self.x=posX;
        self.y=posY;
		self.clickEffect:Stop();
		SetActive(self.gameObject,false);
        end

	function TurnTableGameBottomItem:Destroy()
		LuaMgr.DestroyImmediateGO(self.gameObject);
	self.gameObject = nil
	self.transform = nil
		self.goClickBtn = nil;
	end