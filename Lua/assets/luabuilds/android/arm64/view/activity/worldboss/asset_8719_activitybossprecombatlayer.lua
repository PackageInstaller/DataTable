local ActivityBossPreCombatLayer = class("ActivityBossPreCombatLayer", import("view.battle.PreCombatLayer"))
local FormationUI = import("view.ship.FormationUI")
local var_0_2 = {
	[99] = true
}

function ActivityBossPreCombatLayer:getUIName()
	return "ActivityBossPrecombatUI"
end

function ActivityBossPreCombatLayer:init()
	self:CommonInit()
	setActive(self._fleetInfo, true)

	self._ticket = self._startBtn:Find("ticket")
	self._bonus = self._startBtn:Find("bonus")
	self._costTip = self._startBtn:Find("cost_container/popup/tip")
	self._continuousBtn = self.rtAdapt:Find("right/multiple")

	setText(self._continuousBtn:Find("text"), i18n("multiple_sorties_title"))
	setText(self._continuousBtn:Find("text_en"), i18n("multiple_sorties_title_eng"))
	setText(self._ticket:Find("title"), i18n("ex_pass_use"))
	setText(self._bonus:Find("title"), i18n("expedition_extra_drop_tip"))

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	self:Register()

	return
end

function ActivityBossPreCombatLayer:Register()
	self._formationLogic:AddLoadComplete(function()
		if self._currentForm ~= PreCombatLayer.FORM_EDIT then
			self._formationLogic:SwitchToPreviewMode()
		end

		return
	end)
	self._formationLogic:AddHeroInfoModify(function(arg_5_0, arg_5_1)
		setAnchoredPosition(arg_5_0, {
			x = 0,
			y = 0
		})
		SetActive(arg_5_0, true)

		arg_5_0.name = "info"

		local var_5_0 = findTF(arg_5_0, "info")
		local var_5_1 = findTF(var_5_0, "stars")
		local var_5_2 = arg_5_1.energy <= Ship.ENERGY_MID
		local var_5_3 = findTF(var_5_0, "energy")

		if arg_5_1.energy <= Ship.ENERGY_MID then
			local var_5_4, var_5_5 = arg_5_1:getEnergyPrint()
			local var_5_6 = GetSpriteFromAtlas("energy", var_5_4)

			if not var_5_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_5_3, var_5_6)
		end

		local var_5_7 = pg.battle_cost_template[self.contextData.system]

		setActive(var_5_3, var_5_2 and var_5_7.enter_energy_cost > 0)

		for iter_5_0 = 1, arg_5_1:getStar() do
			cloneTplTo(self._starTpl, var_5_1)
		end

		local var_5_8 = GetSpriteFromAtlas("shiptype", shipType2print(arg_5_1:getShipType()))

		if not var_5_8 then
			warning("找不到船形, shipConfigId: " .. arg_5_1.configId)
		end

		setImageSprite(findTF(var_5_0, "type"), var_5_8, true)
		setText(findTF(var_5_0, "frame/lv_contain/lv"), arg_5_1.level)

		if var_5_7.ship_exp_award > 0 then
			local var_5_9 = getProxy(ActivityProxy):getBuffShipList()[arg_5_1:getGroupId()]
			local var_5_10 = var_5_0:Find("expbuff")

			setActive(var_5_10, var_5_9 ~= nil)

			if var_5_9 then
				local var_5_11 = tostring(var_5_9 / 100)

				if var_5_9 % 100 > 0 then
					var_5_11 = var_5_11 .. "." .. tostring(var_5_9 % 100)
				end

				setText(var_5_10:Find("text"), string.format("EXP +%s%%", var_5_11))
			end
		else
			setActive(var_5_0:Find("expbuff"), false)
		end

		return
	end)
	self._formationLogic:AddLongPress(function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		self:emit(ActivityBossPreCombatMediator.OPEN_SHIP_INFO, arg_6_1.id, arg_6_2)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_7_0)
		SetActive(findTF(arg_7_0, "info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_8_0)
		SetActive(findTF(arg_8_0, "info"), true)

		return
	end)
	self._formationLogic:AddClick(function(arg_9_0, arg_9_1, arg_9_2)
		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_10_0)
		self:emit(ActivityBossPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_10_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_11_0, arg_11_1)
		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		arg_12_0()

		return
	end)
	self._formationLogic:AddSwitchToDisplayMode(function()
		self._currentForm = PreCombatLayer.FORM_EDIT
		self._checkBtn:GetComponent("Button").interactable = true

		self:SetFleetStepper()
		setActive(self._checkBtn:Find("save"), true)
		setActive(self._checkBtn:Find("edit"), false)

		return
	end)
	self._formationLogic:AddSwitchToShiftMode(function()
		self:SetFleetStepper()

		self._checkBtn:GetComponent("Button").interactable = false

		return
	end)
	self._formationLogic:AddSwitchToPreviewMode(function()
		self._currentForm = PreCombatLayer.FORM_PREVIEW
		self._checkBtn:GetComponent("Button").interactable = true

		self:SetFleetStepper()
		setActive(self._checkBtn:Find("save"), false)
		setActive(self._checkBtn:Find("edit"), true)

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_16_0, arg_16_1)
		return
	end)

	if self.contextData.system == SYSTEM_ACT_BOSS then
		self._formationLogic:DisableTip()
	end

	return
end

function ActivityBossPreCombatLayer:SetPlayerInfo(arg_17_1)
	return
end

function ActivityBossPreCombatLayer:SetSubFlag(arg_18_1)
	self._subUseable = arg_18_1 or false

	return
end

function ActivityBossPreCombatLayer:SetShips(arg_19_1)
	self._shipVOs = arg_19_1

	self._formationLogic:SetShipVOs(self._shipVOs)

	return
end

function ActivityBossPreCombatLayer:SetStageID(arg_20_1)
	removeAllChildren(self._spoilsContainer)

	self._stageID = arg_20_1

	local var_20_0 = Clone(pg.expedition_data_template[arg_20_1].award_display)
	local var_20_1 = checkExist(pg.expedition_activity_template[arg_20_1], {
		"pt_drop_display"
	})

	if var_20_1 and type(var_20_1) == "table" then
		local var_20_2 = getProxy(ActivityProxy)

		for iter_20_0 = #var_20_1, 1, -1 do
			local var_20_3 = var_20_2:getActivityById(var_20_1[iter_20_0][1])

			if var_20_3 and not var_20_3:isEnd() then
				table.insert(var_20_0, 1, {
					2,
					id2ItemId(var_20_1[iter_20_0][2])
				})
			end
		end
	end

	if self.contextData.system ~= SYSTEM_BOSS_EXPERIMENT then
		for iter_20_1, iter_20_2 in ipairs(var_20_0) do
			local var_20_4 = cloneTplTo(self._item, self._spoilsContainer)
			local var_20_5 = {
				id = iter_20_2[2],
				type = iter_20_2[1]
			}

			updateDrop(var_20_4, var_20_5)
			onButton(self, var_20_4, function()
				local var_21_0 = Item.getConfigData(iter_20_2[2])

				if var_21_0 and var_0_2[var_21_0.type] then
					local var_21_1 = {}

					for iter_21_0, iter_21_1 in ipairs(var_21_0.display_icon) do
						var_21_1[#var_21_1 + 1] = {
							hideName = true,
							type = iter_21_1[1],
							id = iter_21_1[2]
						}
					end

					self:emit(ActivityBossPreCombatLayer.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_21_1,
						content = var_21_0.display
					})
				else
					self:emit(ActivityBossPreCombatLayer.ON_DROP, var_20_5)
				end

				return
			end, SFX_PANEL)
		end
	end

	local function var_20_6(arg_22_0, arg_22_1)
		if type(arg_22_0) == "table" then
			setActive(arg_22_1, true)
			setWidgetText(arg_22_1, (i18n(PreCombatLayer.ObjectiveList[arg_22_0[1]], arg_22_0[2])))
		else
			setActive(arg_22_1, false)
		end

		return
	end

	local var_20_7 = {
		findTF(self._goals, "goal_tpl"),
		findTF(self._goals, "goal_sink"),
		findTF(self._goals, "goal_time")
	}
	local var_20_8 = 1

	for iter_20_3, iter_20_4 in ipairs({
		pg.expedition_data_template[arg_20_1].objective_1,
		pg.expedition_data_template[arg_20_1].objective_2,
		pg.expedition_data_template[arg_20_1].objective_3
	}) do
		if type(iter_20_4) ~= "string" then
			var_20_6(iter_20_4, var_20_7[var_20_8])

			var_20_8 = var_20_8 + 1
		end
	end

	for iter_20_5 = var_20_8, #var_20_7 do
		var_20_6("", var_20_7[iter_20_5])
	end

	local var_20_9 = pg.expedition_data_template[arg_20_1].guide_desc and #pg.expedition_data_template[arg_20_1].guide_desc > 0

	setActive(self.guideDesc, var_20_9)

	if var_20_9 then
		setText(self.guideDesc, pg.expedition_data_template[arg_20_1].guide_desc)
	end

	return
end

function ActivityBossPreCombatLayer:SetFleets(arg_23_1)
	self._fleetVOs = {}

	_.each(_.filter(_.values(arg_23_1), function(arg_24_0)
		return arg_24_0:getFleetType() == FleetType.Normal
	end), function(arg_25_0)
		self._fleetVOs[arg_25_0.id] = arg_25_0

		return
	end)
	self:CheckLegalFleet()

	return
end

function ActivityBossPreCombatLayer:SetCurrentFleet(arg_26_1)
	self._currentFleetVO = self._fleetVOs[arg_26_1]

	self._formationLogic:SetFleetVO(self._currentFleetVO)
	self:CheckLegalFleet()

	for iter_26_0, iter_26_1 in ipairs(self._legalFleetIdList) do
		if self._currentFleetVO.id == iter_26_1 then
			self._curFleetIndex = iter_26_0

			break
		end
	end

	return
end

function ActivityBossPreCombatLayer:SetTicketItemID(arg_27_1)
	self._ticketItemID = arg_27_1

	return
end

function ActivityBossPreCombatLayer:CheckLegalFleet()
	self._legalFleetIdList = {}

	for iter_28_0, iter_28_1 in pairs(self._fleetVOs) do
		if #iter_28_1.ships > 0 and iter_28_1.id ~= FleetProxy.PVP_FLEET_ID then
			table.insert(self._legalFleetIdList, iter_28_1.id)
		end
	end

	table.sort(self._legalFleetIdList)

	return
end

function ActivityBossPreCombatLayer:UpdateFleetView(arg_29_1)
	self:displayFleetInfo()
	self:updateFleetBg()
	self._formationLogic:UpdateGridVisibility()
	self._formationLogic:ResetGrid(TeamType.Vanguard, self._currentForm ~= PreCombatLayer.FORM_EDIT)
	self._formationLogic:ResetGrid(TeamType.Main, self._currentForm ~= PreCombatLayer.FORM_EDIT)
	self._formationLogic:ResetGrid(TeamType.Submarine, self._currentForm ~= PreCombatLayer.FORM_EDIT)
	self:resetFormationComponent()

	if arg_29_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function ActivityBossPreCombatLayer:updateFleetBg()
	local var_30_0 = self._currentFleetVO:getFleetType()

	setActive(self._bgFleet, var_30_0 == FleetType.Normal)
	setActive(self._bgSub, var_30_0 == FleetType.Submarine)

	return
end

function ActivityBossPreCombatLayer:resetFormationComponent()
	SetActive(self._gridTFs.main[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Main) ~= 0)
	SetActive(self._gridTFs.submarine[1]:Find("flag"), #self._currentFleetVO:getTeamByName(TeamType.Submarine) ~= 0)

	return
end

function ActivityBossPreCombatLayer:uiStartAnimating()
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true)

	return
end

function ActivityBossPreCombatLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, nil, nil, true, true)
	shiftPanel(self._right, 470, nil, nil, nil, true, true)

	return
end

function ActivityBossPreCombatLayer:quickExitFunc()
	if self._currentForm == PreCombatLayer.FORM_EDIT then
		self:emit(ActivityBossPreCombatMediator.ON_ABORT_EDIT)
	end

	ActivityBossPreCombatLayer.super.quickExitFunc(self)

	return
end

function ActivityBossPreCombatLayer:didEnter()
	onButton(self, self._backBtn, function()
		local var_36_0 = {}

		if self._currentForm == PreCombatLayer.FORM_EDIT then
			table.insert(var_36_0, function(arg_37_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						self:emit(ActivityBossPreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_37_0()

							return
						end)

						return
					end,
					onNo = function()
						self:emit(ActivityBossPreCombatMediator.ON_ABORT_EDIT)
						arg_37_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_36_0, function()
			GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

			self:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				self:emit(ActivityBossPreCombatLayer.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		local var_43_0 = {}

		if self._currentForm == PreCombatLayer.FORM_EDIT then
			table.insert(var_43_0, function(arg_44_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						self:emit(ActivityBossPreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_44_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_43_0, function()
			self:emit(ActivityBossPreCombatMediator.ON_START, self._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._checkBtn, function()
		if self._currentForm == PreCombatLayer.FORM_EDIT then
			self:emit(ActivityBossPreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				self._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif self._currentForm == PreCombatLayer.FORM_PREVIEW then
			self._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	self._currentForm = self.contextData.form
	self.contextData.form = nil

	self:UpdateFleetView(true)

	if self._currentForm == PreCombatLayer.FORM_EDIT then
		self._formationLogic:SwitchToDisplayMode()
	else
		self._formationLogic:SwitchToPreviewMode()
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._autoToggle, true)
	onToggle(self, self._autoToggle, function(arg_50_0)
		self:emit(ActivityBossPreCombatMediator.ON_AUTO, {
			isOn = not arg_50_0,
			toggle = self._autoToggle
		})

		if arg_50_0 and self._subUseable == true then
			setActive(self._autoSubToggle, true)
			onToggle(self, self._autoSubToggle, function(arg_51_0)
				self:emit(ActivityBossPreCombatMediator.ON_SUB_AUTO, {
					isOn = not arg_51_0,
					toggle = self._autoSubToggle
				})

				return
			end, SFX_PANEL, SFX_PANEL)
			triggerToggle(self._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive())
		else
			setActive(self._autoSubToggle, false)
		end

		return
	end, SFX_PANEL, SFX_PANEL)
	triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive())
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	local var_35_0 = self.contextData.stageId
	local var_35_1 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)

	setActive(self._continuousBtn, self.contextData.system == SYSTEM_ACT_BOSS)

	local var_35_2 = var_35_1 and var_35_1:IsOilLimit(var_35_0)

	setActive(self._continuousBtn:Find("lock"), not var_35_2)

	local var_35_3

	if var_35_2 then
		var_35_3 = Color.white or Color.New(0.2980392156862745, 0.2980392156862745, 0.2980392156862745)
	end

	setImageColor(self._continuousBtn, var_35_3)
	setTextColor(self._continuousBtn:Find("text"), var_35_3)
	setTextColor(self._continuousBtn:Find("text_en"), var_35_3)
	onButton(self, self._continuousBtn, function()
		if var_35_2 then
			self:emit(ActivityBossPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, self._currentFleetVO.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_locked_tip"))
		end

		return
	end, SFX_PANEL)

	return
end

function ActivityBossPreCombatLayer:displayFleetInfo()
	ActivityBossPreCombatLayer.super.displayFleetInfo(self)

	local var_54_0 = self.contextData.system

	setActive(self._costContainer, true)

	local var_54_1 = getProxy(ActivityProxy):getActivityById(self.contextData.actId):GetStageBonus(self.contextData.stageId)

	setActive(self._bonus, var_54_1 > 0)
	setActive(self._ticket, var_54_1 <= 0)
	setText(self._bonus:Find("Text"), var_54_1)

	if var_54_1 <= 0 then
		setImageSprite(self._ticket:Find("icon"), (LoadSprite(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = self._ticketItemID
		}):getIcon(), "")))

		local var_54_2 = getProxy(PlayerProxy):getRawData():getResource(self._ticketItemID)
		local var_54_3 = 1
		local var_54_4 = self._ticket:Find("checkbox")

		if var_54_0 == SYSTEM_BOSS_EXPERIMENT then
			var_54_3 = 0

			triggerToggle(var_54_4, false)
			setToggleEnabled(var_54_4, false)
		elseif var_54_0 == SYSTEM_HP_SHARE_ACT_BOSS then
			triggerToggle(var_54_4, true)
			setToggleEnabled(var_54_4, false)
		elseif var_54_0 == SYSTEM_ACT_BOSS_SP then
			setActive(self._ticket, false)
		elseif var_54_0 == SYSTEM_ACT_BOSS then
			local var_54_5 = var_54_2 > 0
			local var_54_6 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1

			setToggleEnabled(var_54_4, var_54_2 > 0)
			triggerToggle(var_54_4, var_54_5 and var_54_6)
		end

		var_54_2 = var_54_2 < var_54_3 and setColorStr(var_54_2, COLOR_RED) or var_54_2

		setText(self._ticket:Find("Text"), var_54_3 .. "/" .. var_54_2)
		onToggle(self, var_54_4, function(arg_55_0)
			getProxy(SettingsProxy):setActBossExchangeTicketTip(arg_55_0 and 1 or 0)

			return
		end, SFX_PANEL, SFX_CANCEL)
	end

	local var_54_7 = pg.battle_cost_template[var_54_0].oil_cost > 0
	local var_54_8 = 0
	local var_54_9 = 0
	local var_54_10 = false

	for iter_54_0, iter_54_1 in ipairs({
		self.contextData.fleets[1]
	}) do
		local var_54_11 = iter_54_1:GetCostSum().oil

		if not var_54_7 then
			var_54_11 = 0
		end

		var_54_9 = var_54_9 + var_54_11

		local var_54_12 = self.contextData.costLimit[iter_54_0 == 1 and 1 or 2]

		if self.contextData.costLimit[iter_54_0 == 1 and 1 or 2] > 0 then
			var_54_10 = var_54_10 or var_54_12 < var_54_11
			var_54_11 = math.min(var_54_11, var_54_12)
		end

		var_54_8 = var_54_8 + var_54_11
	end

	setTextColor(self._costText, var_54_10 and Color(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) or Color.white)
	FormationUI.tweenNumText(self._costText, var_54_8)
	setActive(self._costTip, var_54_10)

	if var_54_10 then
		onButton(self, self._costTip, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("use_oil_limit_help", var_54_9, var_54_8)
			})

			return
		end)
	end

	setText(self._fleetNameText, Fleet.DEFAULT_NAME_BOSS_ACT[self._currentFleetVO.id])

	return
end

function ActivityBossPreCombatLayer:SetFleetStepper()
	SetActive(self._nextPage, false)
	SetActive(self._prevPage, false)

	return
end

function ActivityBossPreCombatLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._backBtn)

	return
end

function ActivityBossPreCombatLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self._formationLogic:Destroy()

	self._formationLogic = nil

	return
end

return ActivityBossPreCombatLayer
