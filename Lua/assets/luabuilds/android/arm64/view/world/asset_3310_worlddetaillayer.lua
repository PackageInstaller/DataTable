local WorldDetailLayer = class("WorldDetailLayer", import("..base.BaseUI"))
local FormationUI = import("..ship.FormationUI")

function WorldDetailLayer:getUIName()
	return "WorldDetailUI"
end

WorldDetailLayer.TOGGLE_DETAIL = "detailToggle"
WorldDetailLayer.TOGGLE_FORMATION = "formationToggle"

function WorldDetailLayer:init()
	self.eventTriggers = {}
	self.rtMain = self._tf:Find("main")
	self.bgFleet = self.rtMain:Find("bg_fleet")
	self.bgSub = self.rtMain:Find("bg_sub")
	self.vanguardGS = self.rtMain:Find("gear_score/vanguard")
	self.vanguardUpGS = self.vanguardGS:Find("up")
	self.vanguardDownGS = self.vanguardGS:Find("down")
	self.mainGS = self.rtMain:Find("gear_score/main")
	self.mainUpGS = self.mainGS:Find("up")
	self.mainDownGS = self.mainGS:Find("down")
	self.subGS = self.rtMain:Find("gear_score/submarine")
	self.subUpGS = self.subGS:Find("up")
	self.subDownGS = self.subGS:Find("down")

	setText(self.mainGS:Find("Text"), self.contextData.mainGS or 0)
	setText(self.vanguardGS:Find("Text"), self.contextData.vanGS or 0)
	setText(self.subGS:Find("Text"), self.contextData.subGS or 0)

	self.gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	self.gridFrame = self.rtMain:Find("GridFrame")

	for iter_2_0 = 1, 3 do
		self.gridTFs[TeamType.Vanguard][iter_2_0] = self.gridFrame:Find("vanguard_" .. iter_2_0)
		self.gridTFs[TeamType.Main][iter_2_0] = self.gridFrame:Find("main_" .. iter_2_0)
		self.gridTFs[TeamType.Submarine][iter_2_0] = self.gridFrame:Find("submarine_" .. iter_2_0)
	end

	self.nextPage = self.rtMain:Find("nextPage")
	self.prevPage = self.rtMain:Find("prevPage")
	self.heroContainer = self.rtMain:Find("HeroContainer")
	self.blurLayer = self._tf:Find("blur_container")
	self.top = self.blurLayer:Find("top")
	self.backBtn = self.top:Find("back_btn")
	self.playerResOb = self.top:Find("res")
	self.resPanel = WorldResource.New()

	tf(self.resPanel._go):SetParent(tf(self.playerResOb), false)

	self.fleetToggleList = self.blurLayer:Find("bottom/fleet_select/panel")
	self.detailToggle = self.blurLayer:Find("bottom/toggle_list/detail_toggle")
	self.formationToggle = self.blurLayer:Find("bottom/toggle_list/formation_toggle")
	self.attrFrame = self.blurLayer:Find("attr_frame")
	self.cardTpl = self._tf:Find("RectShipCardTpl")
	self.cards = {}
	self.cards[TeamType.Main] = {}
	self.cards[TeamType.Vanguard] = {}
	self.cards[TeamType.Submarine] = {}

	setActive(self.attrFrame, false)
	setActive(self.cardTpl, false)

	self.heroInfo = self._tf:Find("heroInfo")
	self.starTpl = self._tf:Find("star_tpl")
	self.commanderFormationPanel = WorldCommanderFormationPage.New(self._tf, self.event, self.contextData)
	self.fleetIndex = 1
	self.formationLogic = BaseFormation.New(self._tf, self.heroContainer, self.heroInfo, self.gridTFs)

	self.formationLogic:DisableTip()
	self:Register()

	return
end

function WorldDetailLayer:Register()
	local var_3_0 = getProxy(ActivityProxy):getBuffShipList()

	self.formationLogic:AddLoadComplete(function()
		self:displayFleetInfo()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)
	self.formationLogic:AddHeroInfoModify(function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = WorldConst.FetchWorldShip(arg_5_1.id)
		local var_5_1 = arg_5_1:getConfigTable()
		local var_5_3 = findTF(arg_5_0, "info")
		local var_5_4 = findTF(var_5_3, "stars")
		local var_5_5 = findTF(var_5_3, "energy")

		for iter_5_0 = 1, arg_5_1:getStar() do
			cloneTplTo(self.starTpl, var_5_4)
		end

		local var_5_6 = arg_5_1:getEnergy() <= Ship.ENERGY_MID
		local var_5_7 = findTF(var_5_3, "energy")

		if var_5_6 then
			local var_5_8, var_5_9 = arg_5_1:getEnergyPrint()
			local var_5_10 = GetSpriteFromAtlas("energy", var_5_8)

			if not var_5_10 then
				warning("找不到疲劳")
			end

			setImageSprite(var_5_7, var_5_10)
		end

		setActive(var_5_7, var_5_6)

		local var_5_11 = var_3_0[arg_5_1:getGroupId()]
		local var_5_12 = var_5_3:Find("expbuff")

		setActive(var_5_12, var_5_11 ~= nil)

		if var_5_11 then
			local var_5_13 = tostring(var_5_11 / 100)

			if var_5_11 % 100 > 0 then
				var_5_13 = var_5_13 .. "." .. tostring(var_5_11 % 100)
			end

			setText(var_5_12:Find("text"), string.format("EXP +%s%%", var_5_13))
		end

		local var_5_14 = GetSpriteFromAtlas("shiptype", shipType2print(arg_5_1:getShipType()))

		if not var_5_14 then
			warning("找不到船形, shipConfigId: " .. arg_5_1.configId)
		end

		setImageSprite(findTF(var_5_3, "type"), var_5_14, true)
		setText(findTF(var_5_3, "frame/lv_contain/lv"), arg_5_1.level)

		local var_5_15 = var_5_0:IsHpSafe()
		local var_5_16 = findTF(var_5_3, "blood")
		local var_5_17 = findTF(var_5_16, "fillarea/green")
		local var_5_18 = findTF(var_5_16, "fillarea/red")

		setActive(var_5_17, var_5_15)
		setActive(var_5_18, not var_5_15)

		var_5_16:GetComponent(typeof(Slider)).fillRect = var_5_15 and var_5_17 or var_5_18

		setSlider(var_5_16, 0, 10000, var_5_0.hpRant)
		setActive(var_5_16:Find("broken"), var_5_0:IsBroken())

		return
	end)
	self.formationLogic:AddCheckRemove(function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_6_0()

		return
	end)
	self.formationLogic:AddLongPress(function(arg_7_0, arg_7_1, arg_7_2)
		self:emit(WorldDetailMediator.OnShipInfo, arg_7_1.id)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	self.formationLogic:AddBeginDrag(function(arg_8_0)
		SetActive(findTF(arg_8_0, "info"), false)

		return
	end)
	self.formationLogic:AddEndDrag(function(arg_9_0)
		SetActive(findTF(arg_9_0, "info"), true)

		return
	end)

	return
end

function WorldDetailLayer:didEnter()
	self:OverlayPanel(self._tf)
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onToggle(self, self.detailToggle, function(arg_12_0)
		if arg_12_0 and not isActive(self.attrFrame) then
			self:displayAttrFrame()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.formationToggle, function(arg_13_0)
		if arg_13_0 and isActive(self.attrFrame) then
			self:hideAttrFrame()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.attrFrame, function()
		triggerToggle(self.formationToggle, true)

		return
	end, SFX_PANEL)
	onButton(self, self.prevPage, function()
		local var_15_0 = self:SelectFleetByStep(-1)

		if not var_15_0 then
			return
		end

		triggerToggle(self.fleetToggleList:GetChild(var_15_0 - 1), true)

		return
	end, SFX_PANEL)
	onButton(self, self.nextPage, function()
		local var_16_0 = self:SelectFleetByStep(1)

		if not var_16_0 then
			return
		end

		triggerToggle(self.fleetToggleList:GetChild(var_16_0 - 1), true)

		return
	end, SFX_PANEL)
	self:updateFleetIndex(self.fleetIndex)
	self:updateToggleList()
	self.commanderFormationPanel:ActionInvoke("Show")
	triggerToggle(self[self.contextData.toggle or WorldDetailLayer.TOGGLE_FORMATION], true)

	return
end

function WorldDetailLayer:SelectFleetByStep(arg_17_1)
	local var_17_0 = self.fleetIndex + arg_17_1

	return self.fleetIndex + arg_17_1 >= 1 and var_17_0 <= #self.fleets and self.fleets[var_17_0].id
end

function WorldDetailLayer:onBackPressed()
	if isActive(self.attrFrame) then
		triggerToggle(self.formationToggle, true)

		return
	end

	self:closeView()

	return
end

function WorldDetailLayer:updateFleetBg()
	local var_19_0 = self:getCurrentFleet():GetFleetType()

	setActive(self.bgFleet, var_19_0 == FleetType.Normal)
	setActive(self.bgSub, var_19_0 == FleetType.Submarine)

	return
end

function WorldDetailLayer:updateToggleList()
	local var_20_0

	for iter_20_0 = 1, self.fleetToggleList.childCount do
		local var_20_1 = self.fleetToggleList:GetChild(iter_20_0 - 1)
		local var_20_2, var_20_3, var_20_4 = nowWorld():BuildFormationIds()

		setActive(var_20_1, iter_20_0 <= var_20_4)

		local var_20_5

		if iter_20_0 == self.fleetToggleList.childCount then
			var_20_5 = self.fleets[#self.fleets]

			if self.fleets[#self.fleets] and var_20_5:GetFleetType() ~= FleetType.Submarine then
				var_20_5 = nil
			end
		else
			var_20_5 = self.fleets[iter_20_0]

			if self.fleets[iter_20_0] and var_20_5:GetFleetType() ~= FleetType.Normal then
				var_20_5 = nil
			end
		end

		local var_20_6 = tobool(var_20_5)

		setToggleEnabled(var_20_1, var_20_6)
		setActive(var_20_1:Find("lock"), not var_20_6)

		if var_20_6 then
			onToggle(self, var_20_1, function(arg_21_0)
				if arg_21_0 and var_20_5.id ~= self.fleetIndex then
					self:updateFleetIndex(var_20_5.id)
				end

				return
			end, SFX_UI_TAG)

			if var_20_5.id == self.fleetIndex then
				var_20_0 = var_20_1
			end
		else
			onButton(self, var_20_1:Find("lock"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_redeploy_tip"))

				return
			end)
		end
	end

	triggerToggle(var_20_0, true)

	return
end

function WorldDetailLayer:setPlayerInfo(arg_23_1)
	self.resPanel:setPlayer(arg_23_1)
	setActive(self.resPanel._tf, nowWorld():IsSystemOpen(WorldConst.SystemResource))

	return
end

function WorldDetailLayer:setFleets(arg_24_1)
	self.fleets = arg_24_1

	for iter_24_0, iter_24_1 in ipairs(self.fleets) do
		if iter_24_1.id == self.contextData.fleetId then
			self.fleetIndex = iter_24_0
		end
	end

	return
end

function WorldDetailLayer:getCurrentFleet()
	return self.fleets[self.fleetIndex]
end

function WorldDetailLayer:updateFleetIndex(arg_26_1)
	self.fleetIndex = arg_26_1

	self:updateFormationData()
	self:updateFleetBg()
	self:updateCharacters()
	self:updatePageBtn()
	self:updateCommanderFormation()

	return
end

function WorldDetailLayer:updateFormationData()
	self.formationLogic:SetShipVOs(self:getCurrentFleet():getShipVOsDic())
	self.formationLogic:SetFleetVO(self:getCurrentFleet())

	return
end

function WorldDetailLayer:updateCommanderFormation()
	self.commanderFormationPanel:Load()
	self.commanderFormationPanel:ActionInvoke("Update", self:getCurrentFleet())

	return
end

function WorldDetailLayer:updateCharacters()
	pg.UIMgr.GetInstance():LoadingOn()
	self.formationLogic:ResetGrid(TeamType.Vanguard, true)
	self.formationLogic:ResetGrid(TeamType.Main, true)
	self.formationLogic:ResetGrid(TeamType.Submarine, true)
	self:updateAttrFrame()
	self.formationLogic:LoadAllCharacter()

	return
end

function WorldDetailLayer:updatePageBtn()
	setActive(self.prevPage, self:SelectFleetByStep(-1))
	setActive(self.nextPage, self:SelectFleetByStep(1))

	return
end

function WorldDetailLayer:shiftCard(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = self.cards[arg_31_3]

	if #self.cards[arg_31_3] > 0 then
		var_31_0[arg_31_1], var_31_0[arg_31_2] = self.cards[arg_31_3][arg_31_2], self.cards[arg_31_3][arg_31_1]
	end

	self.shiftIndex = arg_31_2

	self:sortCardSiblingIndex()

	return
end

function WorldDetailLayer:sortCardSiblingIndex()
	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_33_0)
		if #self.cards[arg_33_0] > 0 then
			for iter_33_0 = 1, #self.cards[arg_33_0] do
				self.cards[arg_33_0][iter_33_0].tr:SetSiblingIndex(iter_33_0 - 1)
			end
		end

		return
	end)

	return
end

function WorldDetailLayer:displayFleetInfo()
	local var_34_0 = self:getCurrentFleet()

	setActive(self.vanguardGS, false)
	setActive(self.mainGS, false)
	setActive(self.subGS, false)

	local var_34_1 = var_34_0:GetFleetType()
	local var_34_2 = _.reduce(var_34_0:GetTeamShipVOs(TeamType.Vanguard, false), 0, function(arg_35_0, arg_35_1)
		return arg_35_0 + arg_35_1:getShipCombatPower()
	end)
	local var_34_3 = _.reduce(var_34_0:GetTeamShipVOs(TeamType.Main, false), 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_36_1:getShipCombatPower()
	end)
	local var_34_4 = _.reduce(var_34_0:GetTeamShipVOs(TeamType.Submarine, false), 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1:getShipCombatPower()
	end)

	if var_34_1 == FleetType.Normal then
		setActive(self.vanguardGS, true)
		setActive(self.vanguardUpGS, false)
		setActive(self.vanguardDownGS, false)
		setActive(self.mainGS, true)
		setActive(self.mainUpGS, false)
		setActive(self.mainDownGS, false)

		if self.contextData.vanGS then
			setActive(self.vanguardUpGS, var_34_2 > self.contextData.vanGS)
			setActive(self.vanguardDownGS, var_34_2 < self.contextData.vanGS)
		end

		FormationUI.tweenNumText(self.vanguardGS:Find("Text"), var_34_2)

		if self.contextData.mainGS then
			setActive(self.mainUpGS, var_34_3 > self.contextData.mainGS)
			setActive(self.mainDownGS, var_34_3 < self.contextData.mainGS)
		end

		FormationUI.tweenNumText(self.mainGS:Find("Text"), var_34_3)

		self.contextData.vanGS = var_34_2
		self.contextData.mainGS = var_34_3
	elseif var_34_1 == FleetType.Submarine then
		setActive(self.subGS, true)
		setActive(self.subUpGS, false)
		setActive(self.subDownGS, false)

		if self.contextData.subGS then
			setActive(self.subUpGS, var_34_4 > self.contextData.subGS)
			setActive(self.subDownGS, var_34_4 < self.contextData.subGS)
		end

		FormationUI.tweenNumText(self.subGS:Find("Text"), var_34_4)

		self.contextData.subGS = var_34_4
	end

	return
end

function WorldDetailLayer:displayAttrFrame()
	pg.UIMgr.GetInstance():BlurPanel(self.blurLayer, {
		staticBlur = true
	})
	SetActive(self.attrFrame, true)
	self:initAttrFrame()

	return
end

function WorldDetailLayer:hideAttrFrame()
	SetActive(self.attrFrame, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.blurLayer, self._tf)

	return
end

function WorldDetailLayer:initAttrFrame()
	local var_40_0 = {}
	local var_40_1 = self:getCurrentFleet()

	var_40_0[TeamType.Main] = var_40_1[TeamType.Main]
	var_40_0[TeamType.Vanguard] = var_40_1[TeamType.Vanguard]
	var_40_0[TeamType.Submarine] = var_40_1[TeamType.Submarine]

	local var_40_2 = false

	for iter_40_0, iter_40_1 in pairs(var_40_0) do
		if #self.cards[iter_40_0] == 0 then
			local var_40_3 = self.attrFrame:Find(iter_40_0 .. "/list")

			for iter_40_2 = 1, 3 do
				table.insert(self.cards[iter_40_0], FormationDetailCard.New(cloneTplTo(self.cardTpl, var_40_3).gameObject))
			end

			var_40_2 = true
		end
	end

	if var_40_2 then
		self:updateAttrFrame()
	end

	return
end

function WorldDetailLayer:updateAttrFrame()
	local var_41_0 = {}
	local var_41_1 = self:getCurrentFleet()

	var_41_0[TeamType.Main] = var_41_1[TeamType.Main]
	var_41_0[TeamType.Vanguard] = var_41_1[TeamType.Vanguard]
	var_41_0[TeamType.Submarine] = var_41_1[TeamType.Submarine]

	local var_41_2 = var_41_1:GetFleetType()

	for iter_41_0, iter_41_1 in pairs(var_41_0) do
		local var_41_3 = self.cards[iter_41_0]

		if #self.cards[iter_41_0] > 0 then
			local var_41_4 = var_41_2 == FleetType.Submarine and iter_41_0 == TeamType.Vanguard

			for iter_41_2 = 1, 3 do
				if iter_41_2 <= #iter_41_1 then
					local var_41_5 = WorldConst.FetchShipVO(iter_41_1[iter_41_2].id)

					var_41_3[iter_41_2]:update(var_41_5, var_41_4)
					var_41_3[iter_41_2]:updateProps(self:getCardAttrProps(var_41_5))
				else
					var_41_3[iter_41_2]:update(nil, var_41_4)
				end

				self:detachOnCardButton(var_41_3[iter_41_2])

				if not var_41_4 then
					self:attachOnCardButton(var_41_3[iter_41_2], iter_41_0)
				end
			end
		end
	end

	setActive(self.attrFrame:Find(TeamType.Main), var_41_2 == FleetType.Normal)
	setActive(self.attrFrame:Find(TeamType.Submarine), var_41_2 == FleetType.Submarine)
	setActive(self.attrFrame:Find(TeamType.Vanguard .. "/vanguard"), var_41_2 ~= FleetType.Submarine)
	self:updateUltimateTitle()

	return
end

function WorldDetailLayer:updateUltimateTitle()
	local var_42_0 = self.cards[TeamType.Main]

	if #self.cards[TeamType.Main] > 0 then
		for iter_42_0 = 1, #var_42_0 do
			go(var_42_0[iter_42_0].shipState):SetActive(iter_42_0 == 1)
		end
	end

	return
end

function WorldDetailLayer:getCardAttrProps(arg_43_1)
	return {
		{
			i18n("word_attr_durability"),
			tostring(math.floor(arg_43_1:getProperties().durability))
		},
		{
			i18n("word_attr_luck"),
			"" .. tostring(math.floor((arg_43_1:getBattleTotalExpend())))
		},
		{
			i18n("word_synthesize_power"),
			"<color=#ffff00>" .. math.floor((arg_43_1:getShipCombatPower())) .. "</color>"
		}
	}
end

function WorldDetailLayer:detachOnCardButton(arg_44_1)
	local var_44_0 = GetOrAddComponent(arg_44_1.go, "EventTriggerListener")

	var_44_0:RemovePointDownFunc()
	var_44_0:RemovePointUpFunc()
	var_44_0:RemoveBeginDragFunc()
	var_44_0:RemoveDragFunc()
	var_44_0:RemoveDragEndFunc()

	return
end

function WorldDetailLayer:attachOnCardButton(arg_45_1, arg_45_2)
	local var_45_0 = GetOrAddComponent(arg_45_1.go, "EventTriggerListener")

	self.eventTriggers[var_45_0] = true

	var_45_0:AddPointClickFunc(function(arg_46_0, arg_46_1)
		if not self.carddrag and arg_46_0 == arg_45_1.go then
			if arg_45_1.shipVO then
				self:emit(WorldDetailMediator.OnShipInfo, arg_45_1.shipVO.id, WorldDetailLayer.TOGGLE_DETAIL)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
		end

		return
	end)

	if arg_45_1.shipVO then
		local var_45_1 = self.cards[arg_45_2]
		local var_45_2 = arg_45_1.tr.parent:GetComponent("ContentSizeFitter")
		local var_45_3 = arg_45_1.tr.parent:GetComponent("HorizontalLayoutGroup")
		local var_45_4 = arg_45_1.tr.rect.width * 0.5
		local var_45_5 = {}

		var_45_0:AddBeginDragFunc(function()
			if self.carddrag then
				return
			end

			self.carddrag = arg_45_1
			var_45_2.enabled = false
			var_45_3.enabled = false

			arg_45_1.tr:SetSiblingIndex(#var_45_1)

			for iter_47_0 = 1, #var_45_1 do
				if var_45_1[iter_47_0] == arg_45_1 then
					self.shiftIndex = iter_47_0
				end

				var_45_5[iter_47_0] = var_45_1[iter_47_0].tr.anchoredPosition
			end

			LeanTween.scale(arg_45_1.paintingTr, Vector3(1.1, 1.1, 0), 0.3)

			return
		end)
		var_45_0:AddDragFunc(function(arg_48_0, arg_48_1)
			if self.carddrag ~= arg_45_1 then
				return
			end

			local var_48_0 = arg_45_1.tr.localPosition

			var_48_0.x = self:change2ScrPos(arg_45_1.tr.parent, arg_48_1.position).x
			arg_45_1.tr.localPosition = var_48_0

			local var_48_1 = 1

			for iter_48_0 = 1, #var_45_1 do
				if var_45_1[iter_48_0] ~= arg_45_1 and var_45_1[iter_48_0].shipVO and arg_45_1.tr.localPosition.x > var_45_1[iter_48_0].tr.localPosition.x + (var_48_1 < self.shiftIndex and 1.1 or -1.1) * var_45_4 then
					var_48_1 = var_48_1 + 1
				end
			end

			if self.shiftIndex ~= var_48_1 then
				self.formationLogic:Shift(self.shiftIndex, var_48_1, arg_45_2)
				self:shiftCard(self.shiftIndex, var_48_1, arg_45_2)

				for iter_48_1 = 1, #var_45_1 do
					if var_45_1[iter_48_1] and var_45_1[iter_48_1] ~= arg_45_1 then
						var_45_1[iter_48_1].tr.anchoredPosition = var_45_5[iter_48_1]
					end
				end
			end

			return
		end)
		var_45_0:AddDragEndFunc(function(arg_49_0, arg_49_1)
			if self.carddrag ~= arg_45_1 then
				return
			end

			LeanTween.value(arg_45_1.go, arg_45_1.tr.anchoredPosition.x, var_45_5[self.shiftIndex].x, math.min(math.abs(arg_45_1.tr.anchoredPosition.x - var_45_5[self.shiftIndex].x) / 200, 1) * 0.3):setEase(LeanTweenType.easeOutCubic):setOnUpdate(System.Action_float(function(arg_50_0)
				arg_45_1.tr.anchoredPosition.x = arg_50_0
				arg_45_1.tr.anchoredPosition = arg_45_1.tr.anchoredPosition

				return
			end)):setOnComplete(System.Action(function()
				var_45_2.enabled = true
				var_45_3.enabled = true
				self.shiftIndex = nil

				self:updateUltimateTitle()
				self.formationLogic:SwitchToDisplayMode()
				self.formationLogic:SortSiblingIndex()
				self:sortCardSiblingIndex()

				self.carddrag = nil

				LeanTween.scale(arg_45_1.paintingTr, Vector3(1, 1, 0), 0.3)

				return
			end))

			return
		end)
	end

	return
end

function WorldDetailLayer:change2ScrPos(arg_52_1, arg_52_2)
	return (LuaHelper.ScreenToLocal(arg_52_1, arg_52_2, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

function WorldDetailLayer:recyclePainting()
	for iter_53_0, iter_53_1 in pairs(self.cards) do
		for iter_53_2, iter_53_3 in ipairs(iter_53_1) do
			iter_53_3:clear()
		end
	end

	return
end

function WorldDetailLayer:willExit()
	self.commanderFormationPanel:Destroy()

	if isActive(self.attrFrame) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.blurLayer, self._tf)
	end

	self:UnOverlayPanel(self._tf)

	if self.resPanel then
		self.resPanel:exit()

		self.resPanel = nil
	end

	if self.eventTriggers then
		for iter_54_0, iter_54_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_54_0)
		end

		self.eventTriggers = nil
	end

	local var_54_0 = self:getCurrentFleet()

	self.formationLogic:Destroy()
	self:recyclePainting()

	return
end

return WorldDetailLayer
