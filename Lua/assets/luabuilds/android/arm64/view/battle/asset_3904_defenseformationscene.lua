local DefenseFormationScene = class("DefenseFormationScene", import("..base.BaseUI"))

DefenseFormationScene.RADIUS = 60
DefenseFormationScene.LONGPRESS_Y = 30
DefenseFormationScene.INTERVAL = math.pi / 2 / 6
DefenseFormationScene.MAX_FLEET_NUM = 6
DefenseFormationScene.MAX_SHIPP_NUM = 5
DefenseFormationScene.TOGGLE_DETAIL = "_detailToggle"
DefenseFormationScene.TOGGLE_FORMATION = "_formationToggle"
DefenseFormationScene.BUFF_TYEP = {
	blue = "blue",
	pink = "pink",
	cyan = "cyan"
}

function DefenseFormationScene:getUIName()
	return "ExerciseFormationUI"
end

function DefenseFormationScene:init()
	self.eventTriggers = {}
	self._blurLayer = self._tf:Find("blur_panel")
	self.backBtn = self._blurLayer:Find("top/back_btn")
	self._bottomPanel = self._blurLayer:Find("bottom")
	self._detailToggle = self._bottomPanel:Find("toggle_list/detail_toggle")
	self._formationToggle = self._bottomPanel:Find("toggle_list/formation_toggle")
	self._starTpl = self._tf:Find("star_tpl")
	self._heroInfoTpl = self._tf:Find("heroInfo")
	self._gridTFs = {
		vanguard = {},
		main = {}
	}
	self._gridFrame = self.rtAdapr:Find("GridFrame")

	for iter_2_0 = 1, 3 do
		self._gridTFs[TeamType.Main][iter_2_0] = self._gridFrame:Find("main_" .. iter_2_0)
		self._gridTFs[TeamType.Vanguard][iter_2_0] = self._gridFrame:Find("vanguard_" .. iter_2_0)
	end

	self._heroContainer = self.rtAdapr:Find("HeroContainer")
	self._fleetInfo = self._blurLayer:Find("fleet_info")
	self._fleetNameText = self._fleetInfo:Find("fleet_name/Text")
	self._buffPanel = self.rtAdapr:Find("buff_list")
	self._buffGroup = self._buffPanel:Find("buff_group")
	self._buffModel = self:getTpl("buff_model", self._buffPanel)
	self._propertyFrame = self._blurLayer:Find("property_frame")
	self._cannonPower = self._propertyFrame:Find("cannon/Text")
	self._torpedoPower = self._propertyFrame:Find("torpedo/Text")
	self._AAPower = self._propertyFrame:Find("antiaircraft/Text")
	self._airPower = self._propertyFrame:Find("air/Text")
	self._cost = self._propertyFrame:Find("cost/Text")
	self._mainGS = self.rtAdapr:Find("gear_score/main/Text")
	self._vanguardGS = self.rtAdapr:Find("gear_score/vanguard/Text")
	self._airDominanceFrame = self._propertyFrame:Find("ac")

	if self._airDominanceFrame then
		setActive(self._airDominanceFrame, false)
	end

	self._attrFrame = self._blurLayer:Find("attr_frame")
	self._cardTpl = self._tf:Find("RectShipCardTpl")
	self._cards = {}
	self._cards[TeamType.Main] = {}
	self._cards[TeamType.Vanguard] = {}

	setActive(self._attrFrame, false)
	setActive(self._cardTpl, false)
	setAnchoredPosition(self._bottomPanel, {
		y = -90
	})

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfoTpl, self._gridTFs)

	self:Register()

	return
end

function DefenseFormationScene:Register()
	self._formationLogic:AddHeroInfoModify(function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1:getConfigTable()
		local var_4_2 = arg_4_0:Find("info")
		local var_4_3 = var_4_2:Find("stars")

		for iter_4_0 = 1, arg_4_1:getStar() do
			cloneTplTo(self._starTpl, var_4_3)
		end

		local var_4_4 = GetSpriteFromAtlas("shiptype", shipType2print(arg_4_1:getShipType()))

		if not var_4_4 then
			warning("找不到船形, shipConfigId: " .. arg_4_1.configId)
		end

		setImageSprite(var_4_2:Find("type"), var_4_4, true)
		setText(var_4_2:Find("frame/lv_contain/lv"), arg_4_1.level)

		return
	end)
	self._formationLogic:AddLongPress(function(arg_5_0, arg_5_1, arg_5_2)
		self:emit(DefenseFormationMedator.OPEN_SHIP_INFO, arg_5_1.id, arg_5_2, DefenseFormationScene.TOGGLE_FORMATION)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	self._formationLogic:AddClick(function(arg_6_0, arg_6_1)
		self:emit(DefenseFormationMedator.CHANGE_FLEET_SHIP, arg_6_0, arg_6_1)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_7_0)
		setButtonEnabled(self.backBtn, false)
		setToggleEnabled(self._detailToggle, false)
		SetActive(arg_7_0:Find("info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_8_0)
		setButtonEnabled(self.backBtn, true)
		setToggleEnabled(self._detailToggle, true)
		SetActive(arg_8_0:Find("info"), true)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_9_0)
		self:emit(DefenseFormationMedator.CHANGE_FLEET_SHIPS_ORDER, arg_9_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_10_0, arg_10_1)
		self:emit(DefenseFormationMedator.REMOVE_SHIP, arg_10_0, arg_10_1)

		return
	end)

	local function var_3_0(arg_11_0)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("defense_formation_tip_npc"),
			onYes = arg_11_0,
			onNo = arg_11_0
		})

		return
	end

	self._formationLogic:AddCheckRemove(function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		if not arg_12_3:canRemove(arg_12_2) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_12_2:getName(), "", Fleet.C_TEAM_NAME[arg_12_4]))
			arg_12_0()
		elseif table.getCount(arg_12_3.mainShips) == 1 and arg_12_4 == TeamType.Main or table.getCount(arg_12_3.vanguardShips) == 1 and arg_12_4 == TeamType.Vanguard then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("exercise_clear_fleet_tip"),
				onYes = function()
					if not getProxy(FleetProxy):getFleetById(1):ExistActNpcShip() then
						arg_12_1()
					else
						var_3_0(arg_12_0)
					end

					return
				end,
				onNo = arg_12_0
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				zIndex = -30,
				content = i18n("ship_formationUI_quest_remove", arg_12_2:getName()),
				onYes = arg_12_1,
				onNo = arg_12_0
			})
		end

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_14_0, arg_14_1)
		self:emit(DefenseFormationMedator.CHANGE_FLEET_SHIP, nil, arg_14_0)

		return
	end)

	return
end

function DefenseFormationScene:setShips(arg_15_1)
	self.shipVOs = arg_15_1

	self._formationLogic:SetShipVOs(arg_15_1)

	return
end

function DefenseFormationScene:SetFleet(arg_16_1)
	self._currentFleetVO = arg_16_1

	self._formationLogic:SetFleetVO(arg_16_1)

	return
end

function DefenseFormationScene:UpdateFleetView(arg_17_1)
	self:displayFleetInfo()
	self._formationLogic:ResetGrid(TeamType.Vanguard)
	self._formationLogic:ResetGrid(TeamType.Main)
	self:resetFormationComponent()
	self:updateAttrFrame()

	if arg_17_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function DefenseFormationScene:SetFleetNameLabel()
	setText(self._fleetNameText, i18n("exercise_formation_title"))

	return
end

function DefenseFormationScene:didEnter()
	onButton(self, self.backBtn, function()
		if self._currentDragDelegate then
			LuaHelper.triggerEndDrag(self._currentDragDelegate)
		end

		if self._attrFrame.gameObject.activeSelf then
			triggerToggle(self._formationToggle, true)
		else
			self:emit(DefenseFormationMedator.COMMIT_FLEET, function()
				self:emit(DefenseFormationScene.ON_BACK)

				return
			end)
		end

		return
	end, SOUND_BACK)
	onToggle(self, self._detailToggle, function(arg_22_0)
		if self._currentDragDelegate then
			LuaHelper.triggerEndDrag(self._currentDragDelegate)
		end

		if arg_22_0 then
			self:displayAttrFrame()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._formationToggle, function(arg_23_0)
		if self._currentDragDelegate then
			LuaHelper.triggerEndDrag(self._currentDragDelegate)
		end

		if arg_23_0 then
			self:hideAttrFrame()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._attrFrame, function()
		triggerToggle(self._formationToggle, true)

		return
	end, SFX_PANEL)
	self:UpdateFleetView(true)

	if self.contextData.toggle ~= nil then
		triggerToggle(self[self.contextData.toggle], true)
	end

	shiftPanel(self._bottomPanel, nil, 0, nil, 0.5, true, true)

	return
end

function DefenseFormationScene:resetFormationComponent()
	removeAllChildren(self._buffGroup)

	for iter_25_0, iter_25_1 in ipairs({}) do
		local var_25_0 = cloneTplTo(self._buffModel, self._buffGroup)

		tf(var_25_0):SetAsFirstSibling()
		SetActive(var_25_0:Find("dot_list/" .. iter_25_1.type), true)

		var_25_0:Find("buff_describe"):GetComponent(typeof(Text)).text = iter_25_1.describe
	end

	SetActive(self._gridTFs.main[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)

	return
end

function DefenseFormationScene:shiftCard(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = self._cards[arg_26_3]

	if #self._cards[arg_26_3] > 0 then
		var_26_0[arg_26_1], var_26_0[arg_26_2] = self._cards[arg_26_3][arg_26_2], self._cards[arg_26_3][arg_26_1]
	end

	self._shiftIndex = arg_26_2

	return
end

function DefenseFormationScene:sortCardSiblingIndex()
	if #self._cards[TeamType.Main] > 0 or #self._cards[TeamType.Vanguard] > 0 then
		for iter_27_0 = 1, #self._cards[TeamType.Main] do
			self._cards[TeamType.Main][iter_27_0].tr:SetSiblingIndex(iter_27_0)
		end

		for iter_27_1 = 1, #self._cards[TeamType.Vanguard] do
			self._cards[TeamType.Vanguard][iter_27_1].tr:SetSiblingIndex(iter_27_1)
		end
	end

	return
end

function DefenseFormationScene:displayFleetInfo()
	local var_28_0 = self._currentFleetVO:GetPropertiesSum()

	self.tweenNumText(self._cannonPower, var_28_0.cannon)
	self.tweenNumText(self._torpedoPower, var_28_0.torpedo)
	self.tweenNumText(self._AAPower, var_28_0.antiAir)
	self.tweenNumText(self._airPower, var_28_0.air)
	self.tweenNumText(self._cost, self._currentFleetVO:GetCostSum().oil)
	self.tweenNumText(self._vanguardGS, (self._currentFleetVO:GetGearScoreSum(TeamType.Vanguard)))
	self.tweenNumText(self._mainGS, (self._currentFleetVO:GetGearScoreSum(TeamType.Main)))
	setActive(self.rtAdapr:Find("gear_score"), true)
	self:SetFleetNameLabel()

	return
end

function DefenseFormationScene:hideAttrFrame()
	SetActive(self._attrFrame, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._blurLayer, self._tf)

	return
end

function DefenseFormationScene:displayAttrFrame()
	pg.UIMgr.GetInstance():BlurPanel(self._blurLayer)
	SetActive(self._attrFrame, true)
	self:initAttrFrame()

	return
end

function DefenseFormationScene:initAttrFrame()
	local var_31_0 = {
		[TeamType.Main] = "main",
		[TeamType.Vanguard] = "vanguard"
	}
	local var_31_1 = false

	for iter_31_0, iter_31_1 in pairs({
		[TeamType.Main] = self._currentFleetVO.mainShips,
		[TeamType.Vanguard] = self._currentFleetVO.vanguardShips
	}) do
		if #self._cards[iter_31_0] == 0 then
			local var_31_2 = self._attrFrame:Find(var_31_0[iter_31_0] .. "/list")

			for iter_31_2 = 1, 3 do
				table.insert(self._cards[iter_31_0], FormationCard.New(cloneTplTo(self._cardTpl, var_31_2).gameObject))
			end

			var_31_1 = true
		end
	end

	if var_31_1 then
		self:updateAttrFrame()
	end

	return
end

function DefenseFormationScene:updateAttrFrame()
	for iter_32_0, iter_32_1 in pairs({
		[TeamType.Main] = self._currentFleetVO.mainShips,
		[TeamType.Vanguard] = self._currentFleetVO.vanguardShips
	}) do
		local var_32_0 = self._cards[iter_32_0]

		if #self._cards[iter_32_0] > 0 then
			for iter_32_2 = 1, 3 do
				if iter_32_2 <= #iter_32_1 then
					var_32_0[iter_32_2]:update(self.shipVOs[iter_32_1[iter_32_2]])
					var_32_0[iter_32_2]:updateProps(self:getCardAttrProps(self.shipVOs[iter_32_1[iter_32_2]]))
				else
					var_32_0[iter_32_2]:update(nil)
				end

				self:attachOnCardButton(var_32_0[iter_32_2], iter_32_0)
			end
		end
	end

	self:updateUltimateTitle()
	setActive(self._attrFrame:Find(TeamType.Submarine), false)

	return
end

function DefenseFormationScene:updateUltimateTitle()
	local var_33_0 = self._cards[TeamType.Main]

	if #self._cards[TeamType.Main] > 0 then
		for iter_33_0 = 1, #var_33_0 do
			setActive(var_33_0[iter_33_0].shipState, iter_33_0 == 1)
		end
	end

	local var_33_1 = self._cards[TeamType.Vanguard]

	if #self._cards[TeamType.Vanguard] > 0 then
		for iter_33_1 = 1, #var_33_1 do
			setActive(var_33_1[iter_33_1].shipState, false)
		end
	end

	return
end

function DefenseFormationScene:getCardAttrProps(arg_34_1)
	return {
		{
			i18n("word_attr_durability"),
			tostring(math.floor(arg_34_1:getProperties().durability))
		},
		{
			i18n("word_attr_luck"),
			"" .. tostring(math.floor((arg_34_1:getBattleTotalExpend())))
		},
		{
			i18n("word_synthesize_power"),
			"<color=#ffff00>" .. arg_34_1:getShipCombatPower() .. "</color>"
		}
	}
end

function DefenseFormationScene:attachOnCardButton(arg_35_1, arg_35_2)
	local var_35_0 = GetOrAddComponent(arg_35_1.go, "EventTriggerListener")

	self.eventTriggers[var_35_0] = true

	var_35_0:RemovePointClickFunc()
	var_35_0:RemoveBeginDragFunc()
	var_35_0:RemoveDragFunc()
	var_35_0:RemoveDragEndFunc()
	var_35_0:AddPointClickFunc(function(arg_36_0, arg_36_1)
		if not self.carddrag and arg_36_0 == arg_35_1.go then
			if arg_35_1.shipVO then
				self:emit(DefenseFormationMedator.OPEN_SHIP_INFO, arg_35_1.shipVO.id, self._currentFleetVO, DefenseFormationScene.TOGGLE_DETAIL)
			else
				self:emit(DefenseFormationMedator.CHANGE_FLEET_SHIP, arg_35_1.shipVO, arg_35_2)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
		end

		return
	end)

	if arg_35_1.shipVO then
		local var_35_1 = self._cards[arg_35_2]
		local var_35_2 = arg_35_1.tr.parent:GetComponent("ContentSizeFitter")
		local var_35_3 = arg_35_1.tr.parent:GetComponent("HorizontalLayoutGroup")
		local var_35_4 = arg_35_1.tr.rect.width * 0.5
		local var_35_5
		local var_35_6 = 0
		local var_35_7 = {}

		local function var_35_8()
			for iter_38_0 = 1, #var_35_1 do
				var_35_1[iter_38_0].tr.anchoredPosition = var_35_7[iter_38_0]
			end

			return
		end

		local var_35_9 = Timer.New(function()
			for iter_37_0 = 1, #var_35_1 do
				if var_35_1[iter_37_0] ~= arg_35_1 then
					var_35_1[iter_37_0].tr.anchoredPosition = var_35_1[iter_37_0].tr.anchoredPosition * 0.5 + Vector2(var_35_7[iter_37_0].x, var_35_7[iter_37_0].y) * 0.5
				end
			end

			if var_35_5 and var_35_6 <= Time.realtimeSinceStartup then
				var_35_0:OnDrag(var_35_5)

				var_35_5 = nil
			end

			return
		end, 0.03333333333333333, -1)

		var_35_0:AddBeginDragFunc(function()
			if self.carddrag then
				return
			end

			self._currentDragDelegate = var_35_0
			self.carddrag = arg_35_1
			var_35_2.enabled = false
			var_35_3.enabled = false

			arg_35_1.tr:SetSiblingIndex(#var_35_1)

			for iter_39_0 = 1, #var_35_1 do
				if var_35_1[iter_39_0] == arg_35_1 then
					self._shiftIndex = iter_39_0
				end

				var_35_7[iter_39_0] = var_35_1[iter_39_0].tr.anchoredPosition
			end

			var_35_9:Start()
			LeanTween.scale(arg_35_1.paintingTr, Vector3(1.1, 1.1, 0), 0.3)

			return
		end)
		var_35_0:AddDragFunc(function(arg_40_0, arg_40_1)
			if self.carddrag ~= arg_35_1 then
				return
			end

			local var_40_0 = arg_35_1.tr.localPosition

			var_40_0.x = self:change2ScrPos(arg_35_1.tr.parent, arg_40_1.position).x
			arg_35_1.tr.localPosition = var_40_0

			if var_35_6 > Time.realtimeSinceStartup then
				var_35_5 = arg_40_1

				return
			end

			local var_40_1 = 1

			for iter_40_0 = 1, #var_35_1 do
				if var_35_1[iter_40_0] ~= arg_35_1 and var_35_1[iter_40_0].shipVO and arg_35_1.tr.localPosition.x > var_35_1[iter_40_0].tr.localPosition.x + (var_40_1 < self._shiftIndex and 1.1 or -1.1) * var_35_4 then
					var_40_1 = var_40_1 + 1
				end
			end

			if self._shiftIndex ~= var_40_1 then
				self._formationLogic:Shift(self._shiftIndex, var_40_1, arg_35_2)
				self:shiftCard(self._shiftIndex, var_40_1, arg_35_2)

				var_35_6 = Time.realtimeSinceStartup + 0.15
			end

			return
		end)
		var_35_0:AddDragEndFunc(function(arg_41_0, arg_41_1)
			if self.carddrag ~= arg_35_1 then
				return
			end

			self._currentDragDelegate = nil
			var_35_0.enabled = false

			LeanTween.value(arg_35_1.go, arg_35_1.tr.anchoredPosition.x, var_35_7[self._shiftIndex].x, math.min(math.abs(arg_35_1.tr.anchoredPosition.x - var_35_7[self._shiftIndex].x) / 200, 1) * 0.3):setEase(LeanTweenType.easeOutCubic):setOnUpdate(System.Action_float(function(arg_42_0)
				arg_35_1.tr.anchoredPosition.x = arg_42_0
				arg_35_1.tr.anchoredPosition = arg_35_1.tr.anchoredPosition

				return
			end)):setOnComplete(System.Action(function()
				var_35_8()

				var_35_2.enabled = true
				var_35_3.enabled = true
				self._shiftIndex = nil

				var_35_9:Stop()
				self:updateUltimateTitle()
				self._formationLogic:SortSiblingIndex()
				self:sortCardSiblingIndex()
				self:emit(DefenseFormationMedator.CHANGE_FLEET_SHIPS_ORDER, self._currentFleetVO)
				LeanTween.scale(arg_35_1.paintingTr, Vector3(1, 1, 0), 0.3)

				var_35_0.enabled = true
				self.carddrag = nil

				return
			end))

			return
		end)
	end

	return
end

function DefenseFormationScene:change2ScrPos(arg_44_1, arg_44_2)
	return (LuaHelper.ScreenToLocal(arg_44_1, arg_44_2, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

function DefenseFormationScene:tweenNumText(arg_45_1, arg_45_2)
	LeanTween.value(go(self), 0, math.floor(arg_45_1), arg_45_2 or 0.7):setOnUpdate(System.Action_float(function(arg_46_0)
		setText(self, math.floor(arg_46_0))

		return
	end))

	return
end

function DefenseFormationScene:GetFleetCount()
	return 1
end

function DefenseFormationScene:recyclePainting()
	for iter_48_0, iter_48_1 in pairs(self._cards) do
		for iter_48_2, iter_48_3 in ipairs(iter_48_1) do
			iter_48_3:clear()
		end
	end

	return
end

function DefenseFormationScene:willExit()
	if self.eventTriggers then
		for iter_49_0, iter_49_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_49_0)
		end

		self.eventTriggers = nil
	end

	if self._attrFrame.gameObject.activeSelf then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._blurLayer, self._tf)
	end

	pg.TimeMgr.GetInstance():RemoveTimer(self.ActiveToggletimer1)

	self.ActiveToggletimer1 = nil

	pg.TimeMgr.GetInstance():RemoveTimer(self.ActiveToggletimer)

	self.ActiveToggletimer = nil

	self._formationLogic:Destroy()
	self:recyclePainting()

	return
end

return DefenseFormationScene
