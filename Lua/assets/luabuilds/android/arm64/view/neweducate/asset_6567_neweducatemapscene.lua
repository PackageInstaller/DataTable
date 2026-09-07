local NewEducateMapScene = class("NewEducateMapScene", import("view.newEducate.base.NewEducateBaseUI"))

NewEducateMapScene.DEFAULT_SCALE = 1
NewEducateMapScene.SCALE = 1.15
NewEducateMapScene.SPEED = 65
NewEducateMapScene.ALPHA_TIME = 0.25

function NewEducateMapScene:getUIName()
	return "NewEducateMapUI"
end

function NewEducateMapScene:SetData()
	self.shopSiteId = self.contextData.char:GetSiteId(NewEducateConst.SITE_TYPE.SHOP)
	self.workSiteId = self.contextData.char:GetSiteId(NewEducateConst.SITE_TYPE.WORK)
	self.travelSiteId = self.contextData.char:GetSiteId(NewEducateConst.SITE_TYPE.TRAVEL)

	return
end

function NewEducateMapScene:init()
	self.uiTF = self._tf:Find("ui")
	self.mapTF = self._tf:Find("map")

	setLocalScale(self.mapTF, {
		x = NewEducateMapScene.DEFAULT_SCALE,
		y = NewEducateMapScene.DEFAULT_SCALE,
		z = NewEducateMapScene.DEFAULT_SCALE
	})

	self.travelTF = self.mapTF:Find("content/travel")
	self.workTF = self.mapTF:Find("content/work")
	self.shopTF = self.mapTF:Find("content/shop")

	local var_3_0 = self.mapTF:Find("content/events")

	self.eventUIList = UIItemList.New(var_3_0, var_3_0:Find("tpl"))

	local var_3_1 = self.mapTF:Find("content/ships")

	self.shipUIList = UIItemList.New(var_3_1, var_3_1:Find("tpl"))
	self.personalityTipPanel = NewEducatePersonalityTipPanel.New(self.adaptTF, self.event, self.contextData)

	self.personalityTipPanel:RegisterView(self)

	self.topPanel = NewEducateTopPanel.New(self.uiTF, self.event, setmetatable({
		showBack = true
	}, {
		__index = self.contextData
	}))

	self.topPanel:RegisterView(self)

	self.infoPanel = NewEducateInfoPanel.New(self.uiTF, self.event, setmetatable({
		hide = true
	}, {
		__index = self.contextData
	}))

	self.infoPanel:RegisterView(self)

	self.detailPanel = NewEducateSiteDetailPanel.New(self.uiTF, self.event, setmetatable({
		onHide = function()
			self:OnDetailHide()

			return
		end,
		onClickUpEntryGood = function(arg_5_0)
			self:onClickUpEntryGood(arg_5_0)

			return
		end
	}, {
		__index = self.contextData
	}))

	self.detailPanel:RegisterView(self)

	self.nodePanel = NewEducateNodePanel.New(self.adaptTF, self.event, setmetatable({
		onHide = function()
			self:OnDetailHide()
			self:FlushView()

			return
		end,
		onSiteEnd = function()
			self:ShowInfoUI(true)

			return
		end,
		onNormal = function()
			self.infoPanel:ExecuteAction("HidePanel", true)
			self.topPanel:ExecuteAction("Hide")

			return
		end,
		view = self
	}, {
		__index = self.contextData
	}))

	self.nodePanel:RegisterView(self)

	self.extendLimit = Vector2(self.mapTF.rect.width - self._tf.rect.width, self.mapTF.rect.height - self._tf.rect.height) / 2
	self.duration = 0.5
	self.curSiteId = 0
	self.playerID = getProxy(PlayerProxy):getRawData().id

	return
end

function NewEducateMapScene:didEnter()
	self:SetData()
	self.topPanel:Load()
	self.infoPanel:Load()
	onButton(self, self.travelTF, function()
		self:FocusTF(self.travelTF)

		self.curSiteId = self.travelSiteId

		self.detailPanel:ExecuteAction("Show", self.travelSiteId)
		self:ShowInfoUI()

		return
	end, SFX_PANEL)
	onButton(self, self.workTF, function()
		self:FocusTF(self.workTF)

		self.curSiteId = self.workSiteId

		self.detailPanel:ExecuteAction("Show", self.workSiteId)
		self:ShowInfoUI()

		return
	end, SFX_PANEL)
	onButton(self, self.shopTF, function()
		self:FocusTF(self.shopTF)

		self.curSiteId = self.shopSiteId

		self.detailPanel:ExecuteAction("Show", self.shopSiteId)
		self:ShowInfoUI()
		self.infoPanel:ExecuteAction("SetShopOpen", true)

		return
	end, SFX_PANEL)
	self.eventUIList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = self.eventSiteIds[arg_13_1 + 1]

			arg_13_2.name = self.eventSiteIds[arg_13_1 + 1]

			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_site_display[self.eventSiteIds[arg_13_1 + 1]].event_icon, arg_13_2, true)
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_site_display[self.eventSiteIds[arg_13_1 + 1]].event_title, arg_13_2:Find("name"), true)
			setAnchoredPosition(arg_13_2, {
				x = pg.child2_site_display[self.eventSiteIds[arg_13_1 + 1]].position[1],
				y = pg.child2_site_display[self.eventSiteIds[arg_13_1 + 1]].position[2]
			})
			onButton(self, arg_13_2, function()
				self:FocusTF(arg_13_2)

				self.curSiteId = var_13_0

				self.detailPanel:ExecuteAction("Show", var_13_0)
				self:ShowInfoUI()

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.shipUIList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			self:UpdateShipSite(arg_15_1, arg_15_2)
		end

		return
	end)
	self:FlushView()

	if self.contextData.char:GetFSM():GetCurNode() ~= 0 then
		self.curSiteId = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP):GetCurSiteId()

		self:ShowInfoUI()
		self:OnNodeStart(self.contextData.char:GetFSM():GetCurNode())
	else
		self:CheckEventPerformance()

		if self.contextData.openShop then
			triggerButton(self.shopTF)
		end
	end

	return
end

function NewEducateMapScene:CheckEventPerformance()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.eventSiteIds) do
		local var_16_1 = pg.child2_site_display[iter_16_1].param
		local var_16_2 = pg.child2_site_event_group[pg.child2_site_display[iter_16_1].param].performance

		if #pg.child2_site_event_group[pg.child2_site_display[iter_16_1].param].performance > 0 and PlayerPrefs.GetInt(self:GetEventLocalKey(pg.child2_site_display[iter_16_1].param)) ~= 1 then
			table.insert(var_16_0, function(arg_17_0)
				self.nodePanel:ExecuteAction("PlayWordIds", var_16_2, arg_17_0)
				PlayerPrefs.SetInt(self:GetEventLocalKey(var_16_1), 1)

				return
			end)
		end
	end

	seriesAsync(var_16_0, function()
		return
	end)

	return
end

function NewEducateMapScene:GetEventLocalKey(arg_19_1)
	return NewEducateConst.NEW_EDUCATE_EVENT_TIP .. "_" .. self.playerID .. "_" .. self.contextData.char.id .. "_" .. self.contextData.char:GetGameCnt() .. "_" .. arg_19_1
end

function NewEducateMapScene:ShowInfoUI(arg_20_1)
	self.infoPanel:ExecuteAction("ShowPanel")
	self.topPanel:ExecuteAction("Flush")

	if arg_20_1 then
		return
	end

	self.hideTFList = {}

	if pg.child2_site_display[self.curSiteId].type ~= NewEducateConst.SITE_TYPE.WORK then
		table.insert(self.hideTFList, self.workTF)
	end

	if pg.child2_site_display[self.curSiteId].type ~= NewEducateConst.SITE_TYPE.TRAVEL then
		table.insert(self.hideTFList, self.travelTF)
	end

	if pg.child2_site_display[self.curSiteId].type ~= NewEducateConst.SITE_TYPE.SHOP then
		table.insert(self.hideTFList, self.shopTF)
	end

	eachChild(self.eventUIList.container, function(arg_21_0)
		if self.curSiteId ~= tonumber(arg_21_0.name) then
			table.insert(self.hideTFList, arg_21_0)
		end

		return
	end)
	eachChild(self.shipUIList.container, function(arg_22_0)
		if self.curSiteId ~= tonumber(arg_22_0.name) then
			table.insert(self.hideTFList, arg_22_0)
		end

		return
	end)

	for iter_20_0, iter_20_1 in ipairs(self.hideTFList) do
		self:managedTween(LeanTween.value, nil, go(iter_20_1), 1, 0, NewEducateMapScene.ALPHA_TIME):setOnUpdate(System.Action_float(function(arg_23_0)
			GetOrAddComponent(iter_20_1, "CanvasGroup").alpha = arg_23_0

			return
		end))
	end

	return
end

function NewEducateMapScene:OnDetailHide()
	self.infoPanel:ExecuteAction("HidePanel")
	self.infoPanel:ExecuteAction("SetShopOpen", false)
	self.topPanel:ExecuteAction("Flush")
	self.topPanel:ExecuteAction("Show")
	self:managedTween(LeanTween.value, nil, go(self.mapTF), NewEducateMapScene.SCALE, NewEducateMapScene.DEFAULT_SCALE, self.duration):setOnUpdate(System.Action_float(function(arg_25_0)
		setLocalScale(self.mapTF, {
			x = arg_25_0,
			y = arg_25_0,
			z = arg_25_0
		})

		return
	end))
	SetCompomentEnabled(self.mapTF, typeof(ScrollRect), false)

	self.twFocusId = LeanTween.move(self.mapTF, Vector3(0, 0, 0), self.duration):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		setSizeDelta(self.mapTF, Vector2(2400, 1478))
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), true)

		return
	end)).uniqueId

	for iter_24_0, iter_24_1 in ipairs(self.hideTFList or {}) do
		self:managedTween(LeanTween.value, nil, go(iter_24_1), 0, 1, NewEducateMapScene.ALPHA_TIME):setOnUpdate(System.Action_float(function(arg_27_0)
			GetOrAddComponent(iter_24_1, "CanvasGroup").alpha = arg_27_0

			return
		end))
	end

	return
end

function NewEducateMapScene:onClickUpEntryGood(arg_28_1)
	self:emit(NewEducateMapScene.GO_SUBLAYER, Context.New({
		mediator = NewEducateTarotEntryMediator,
		viewComponent = NewEducateTarotEntryLayer,
		data = {
			goodId = arg_28_1.id,
			type = NewEducateTarotEntryLayer.TYPE.SHOP,
			cost = arg_28_1:getConfig("resource_num")
		}
	}))

	return
end

function NewEducateMapScene:FlushView()
	local var_29_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP)

	self.eventSiteIds = underscore.map(var_29_0:GetEvents(), function(arg_30_0)
		return self.contextData.char:GetSiteId(NewEducateConst.SITE_TYPE.EVENT, arg_30_0)
	end)

	table.sort(self.eventSiteIds, CompareFuncs({
		function(arg_31_0)
			return pg.child2_site_display[arg_31_0].position[1]
		end
	}))

	self.shipSiteIds = underscore.map(underscore.select(self.contextData.char:GetShipIds(), function(arg_32_0)
		return not self:IsMaxShip(arg_32_0) and not var_29_0:IsSelectedShip(arg_32_0)
	end), function(arg_33_0)
		return self.contextData.char:GetSiteId(NewEducateConst.SITE_TYPE.SHIP, arg_33_0)
	end)

	self.eventUIList:align(#self.eventSiteIds)
	self.shipUIList:align(#self.shipSiteIds)
	self:InitPermanentNodes()
	setActive(self.shopTF, self.contextData.char:IsUnlock("shop"))
	self:CheckUpgradeNormalSite()

	return
end

function NewEducateMapScene:InitPermanentNodes()
	if self.travelSiteId then
		self:InitPermanent(self.travelSiteId, self.travelTF)
	end

	if self.workSiteId then
		self:InitPermanent(self.workSiteId, self.workTF)
	end

	if self.shopSiteId then
		self:InitPermanent(self.shopSiteId, self.shopTF)
	end

	return
end

function NewEducateMapScene:InitPermanent(arg_35_1, arg_35_2)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_site_display[arg_35_1].event_icon, arg_35_2, true)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_site_display[arg_35_1].event_title, arg_35_2:Find("name"), true)
	setAnchoredPosition(arg_35_2, {
		x = pg.child2_site_display[arg_35_1].position[1],
		y = pg.child2_site_display[arg_35_1].position[2]
	})

	return
end

function NewEducateMapScene:IsMaxShip(arg_36_1)
	local var_36_0 = pg.child2_site_character[arg_36_1]

	return not underscore.detect(pg.child2_site_character.get_id_list_by_group[pg.child2_site_character[arg_36_1].group], function(arg_37_0)
		return pg.child2_site_character[arg_37_0].level == var_36_0.level + 1
	end)
end

function NewEducateMapScene:IsMaxNormal(arg_38_1)
	local var_38_0 = pg.child2_site_normal[arg_38_1]

	return not underscore.detect(pg.child2_site_normal.get_id_list_by_character[self.contextData.char.id], function(arg_39_0)
		return pg.child2_site_normal[arg_39_0].type == var_38_0.type and pg.child2_site_normal[arg_39_0].site_lv == var_38_0.site_lv + 1
	end)
end

function NewEducateMapScene:CheckUpgradeNormalSite()
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(NewEducateConst.SITE_NORMAL_TYPE) do
		local var_40_1 = self.contextData.char:GetNormalIdByType(iter_40_1)

		if not self:IsMaxNormal(var_40_1) and self.contextData.char:IsMatchComplex(pg.child2_site_normal[var_40_1].special_args) then
			table.insert(var_40_0, var_40_1)
		end
	end

	if #var_40_0 > 0 then
		local var_40_2 = {}

		for iter_40_2, iter_40_3 in ipairs(var_40_0) do
			table.insert(var_40_2, function(arg_41_0)
				self:emit(NewEducateMapMediator.ON_UPGRADE_NORMAL, iter_40_3, arg_41_0)

				return
			end)
		end

		seriesAsync(var_40_2, function()
			if self.detailPanel:isShowing() then
				self.detailPanel:ExecuteAction("Flush")
			end

			return
		end)
	end

	return
end

function NewEducateMapScene:UpdateShipSite(arg_43_1, arg_43_2)
	local var_43_0 = self.shipSiteIds[arg_43_1 + 1]

	arg_43_2.name = self.shipSiteIds[arg_43_1 + 1]

	local var_43_1 = pg.child2_site_display[self.shipSiteIds[arg_43_1 + 1]]

	setScrollText(arg_43_2:Find("bottom/name_mask/name"), pg.child2_site_display[self.shipSiteIds[arg_43_1 + 1]].name)
	setAnchoredPosition(arg_43_2, {
		x = var_43_1.position[1],
		y = var_43_1.position[2]
	})
	LoadImageSpriteAsync("squareicon/" .. var_43_1.icon, arg_43_2:Find("top/mask/icon"), true)

	local var_43_2 = pg.child2_site_character[var_43_1.param].level

	eachChild(arg_43_2:Find("top/lv"), function(arg_44_0)
		setActive(arg_44_0, tonumber(arg_44_0.name) <= var_43_2)

		return
	end)
	setActive(arg_43_2:Find("top/red"), var_43_1.bg == "red")
	setActive(arg_43_2:Find("top/blue"), var_43_1.bg == "blue")
	setActive(arg_43_2:Find("bottom/red"), var_43_1.bg == "red")
	setActive(arg_43_2:Find("bottom/blue"), var_43_1.bg == "blue")
	setActive(arg_43_2:Find("bottom/grey"), false)
	onButton(self, arg_43_2, function()
		if self.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		self:FocusTF(arg_43_2)

		self.curSiteId = var_43_0

		self.detailPanel:ExecuteAction("Show", var_43_0)
		self:ShowInfoUI()

		return
	end, SFX_PANEL)

	return
end

function NewEducateMapScene:UpdateShipLv()
	eachChild(self.shipUIList.container, function(arg_47_0)
		if tonumber(arg_47_0.name) == self.curSiteId then
			local var_47_0 = pg.child2_site_character[pg.child2_site_display[self.curSiteId].param].level + 1

			eachChild(arg_47_0:Find("top/lv"), function(arg_48_0)
				setActive(arg_48_0, tonumber(arg_48_0.name) <= var_47_0)

				return
			end)
		end

		return
	end)

	return
end

function NewEducateMapScene:OnShoppingDone()
	self.detailPanel:ExecuteAction("FlushShop")
	self:emit(NewEducateMapScene.ON_PRIORITY_STATE)

	return
end

function NewEducateMapScene:OnRefreshShopDone()
	self.detailPanel:ExecuteAction("FlushShop")

	return
end

function NewEducateMapScene:OnResUpdate()
	self.topPanel:ExecuteAction("FlushRes")

	return
end

function NewEducateMapScene:OnAttrUpdate()
	self.infoPanel:ExecuteAction("FlushAttrs")
	self.topPanel:ExecuteAction("FlushProgress")

	return
end

function NewEducateMapScene:OnPersonalityUpdate(arg_53_1, arg_53_2)
	self.personalityTipPanel:ExecuteAction("FlushPersonality", arg_53_1, arg_53_2)

	return
end

function NewEducateMapScene:OnTalentUpdate()
	self.infoPanel:ExecuteAction("FlushTalents")

	return
end

function NewEducateMapScene:OnStatusUpdate()
	self.infoPanel:ExecuteAction("FlushStatus")

	return
end

function NewEducateMapScene:OnTarotUpdate()
	self.infoPanel:ExecuteAction("FlushTarot")

	return
end

function NewEducateMapScene:OnNodeStart(arg_57_1)
	self.nodePanel:ExecuteAction("StartNode", arg_57_1)

	return
end

function NewEducateMapScene:OnNextNode(arg_58_1)
	self.nodePanel:ExecuteAction("ProceedNode", arg_58_1.node, arg_58_1.drop, arg_58_1.noNextCb)

	return
end

function NewEducateMapScene:FocusTF(arg_59_1, arg_59_2)
	setSizeDelta(self.mapTF, Vector2(3280, 2038))

	self.extendLimit = Vector2(self.mapTF.rect.width * NewEducateMapScene.SCALE - self._tf.rect.width, self.mapTF.rect.height * NewEducateMapScene.SCALE - self._tf.rect.height) / 2

	local var_59_0 = arg_59_1.anchoredPosition * -1

	;(arg_59_1.anchoredPosition * -1).x = math.clamp((arg_59_1.anchoredPosition * -1).x, -self.extendLimit.x, self.extendLimit.x) * NewEducateMapScene.SCALE
	;(arg_59_1.anchoredPosition * -1).y = math.clamp((arg_59_1.anchoredPosition * -1).y, -self.extendLimit.y, self.extendLimit.y) * NewEducateMapScene.SCALE

	if self.twFocusId then
		LeanTween.cancel(self.twFocusId)

		self.twFocusId = nil
	end

	local var_59_1 = {}

	table.insert(var_59_1, function(arg_60_0)
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), false)

		self.duration = (self.mapTF.anchoredPosition - var_59_0).magnitude > 0 and (self.mapTF.anchoredPosition - var_59_0).magnitude / (NewEducateMapScene.SPEED * math.sqrt((self.mapTF.anchoredPosition - var_59_0).magnitude)) or 0

		self:managedTween(LeanTween.value, nil, go(self.mapTF), NewEducateMapScene.DEFAULT_SCALE, NewEducateMapScene.SCALE, self.duration):setOnUpdate(System.Action_float(function(arg_61_0)
			setLocalScale(self.mapTF, {
				x = arg_61_0,
				y = arg_61_0,
				z = arg_61_0
			})

			return
		end))

		self.twFocusId = LeanTween.move(self.mapTF, Vector3(var_59_0.x, var_59_0.y, 0), self.duration):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_60_0)).uniqueId

		return
	end)
	seriesAsync(var_59_1, function()
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), true)

		if arg_59_2 then
			arg_59_2()
		end

		return
	end)

	return
end

function NewEducateMapScene:onBackPressed()
	if self.nodePanel:isShowing() then
		return
	end

	if self.detailPanel:isShowing() then
		self.detailPanel:Hide()
	else
		self.super.onBackPressed(self)
	end

	return
end

function NewEducateMapScene:willExit()
	if self.topPanel then
		self.topPanel:Destroy()

		self.topPanel = nil
	end

	if self.infoPanel then
		self.infoPanel:Destroy()

		self.infoPanel = nil
	end

	if self.detailPanel then
		self.detailPanel:Destroy()

		self.detailPanel = nil
	end

	if self.personalityTipPanel then
		self.personalityTipPanel:Destroy()

		self.personalityTipPanel = nil
	end

	if self.nodePanel then
		self.nodePanel:Destroy()

		self.nodePanel = nil
	end

	return
end

return NewEducateMapScene
