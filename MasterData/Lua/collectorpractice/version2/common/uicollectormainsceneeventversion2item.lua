UICollectorMainSceneEventVersion2Item = {}

UICollectorMainSceneEventVersion2Item.__index = UICollectorMainSceneEventVersion2Item


function UICollectorMainSceneEventVersion2Item.New(prefab, parent)
	local self = {}
	setmetatable(self, UICollectorMainSceneEventVersion2Item)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
	self.imgEventIcon = uiLink:Get("imgEventIcon"):GetComponent("Image");
	self.root = uiLink:Get("root");
	self.animator = uiLink:Get("root"):GetComponent("Animator");
	self.goNextEventIcon = uiLink:Get("goNextEventIcon");
	self.eventId = nil;
	self.curNo = nil;
	self.isNextEvent = nil;
	self.btnClickEvent = uiLink:Get("btnClickEvent"):GetComponent("Button");
	uiLink:AddClickEvent("btnClickEvent", function()
		if self.isNextEvent then
			local data = {};
			data.nowEventId = self.eventId;
			data.nowEventNo = self.curNo;
			data.needShowFirstStage = DataMgr.Player.practiceStage2.stages[DataMgr.Player.practiceStage2.crtEventNo + 1]
			.State ~= 1;
			LuaMgr.ShowLuaPanel(UIName.CollectorPracticeEventVersion2ViewModel, data);
		end
	end)
	return self
end

function UICollectorMainSceneEventVersion2Item:Destroy()
	self.gameObject = nil
	self.transform = nil
	self.imgEventIcon = nil;
	self.goNextEventIcon = nil;
	self.btnClickEvent = nil;
	self.eventId = nil;
	self.isNextEvent = nil;
	self.curNo = nil;
	self.animator = nil;
end

function UICollectorMainSceneEventVersion2Item:SetData(curNo, eventId)
	self.animator.enabled = false;
	self.root:GetComponent("CanvasGroup").alpha = 1.0;

self.curNo = curNo;
	self.eventId = eventId;
	if IsNullOrEmpty(eventId) then
		SetActive(self.gameObject, false);
	else
		SetActive(self.gameObject, true);

		if eventId == "start" then
			self.imgEventIcon.sprite = LuaMgr.GetSprite("CollectorMainSceneVersion2", "ui_sx_jy_cs");
			self.imgEventIcon:SetNativeSize();
		else
			local eventType = ConfigMgr.Config.YX2EventMap[self.eventId].EventParam[1];
			self.imgEventIcon.sprite = LuaMgr.GetSprite("CollectorMainSceneVersion2", eventType);
			self.imgEventIcon:SetNativeSize();
		end
		self.imgEventIcon:SetNativeSize();
	end
end

function UICollectorMainSceneEventVersion2Item:SetNextIsEvent(isNextEvent, showIcon)
	self.isNextEvent = isNextEvent;
	SetActive(self.goNextEventIcon, isNextEvent and showIcon);
end

function UICollectorMainSceneEventVersion2Item:Hide()
	SetActive(self.gameObject, false);
end

function UICollectorMainSceneEventVersion2Item:ReadyToShowFirstAnimation()
	self.animator.enabled = false;
	self.root:GetComponent("CanvasGroup").alpha = 0.0;
end

function UICollectorMainSceneEventVersion2Item:ShowFirstAnimation()
	self.animator.enabled = true;
	self.animator:Play("ani_UICollectorMainSceneEventVersion2Item_enter", 0, 0);
end