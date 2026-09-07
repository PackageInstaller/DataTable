local WorldBossFormationLayer = class("WorldBossFormationLayer", import("..base.BaseUI"))
local FormationUI = import("..ship.FormationUI")

WorldBossFormationLayer.FORM_EDIT = "EDIT"
WorldBossFormationLayer.FORM_PREVIEW = "PREVIEW"

function WorldBossFormationLayer:getUIName()
	return "PreCombatUI"
end

function WorldBossFormationLayer:ResUISettings()
	return {
		anim = true,
		order = 5,
		showType = PlayerResUI.TYPE_ALL
	}
end

function WorldBossFormationLayer:SetBossProxy(arg_3_1, arg_3_2)
	self.boss = arg_3_1:GetBossById(arg_3_2)

	return
end

function WorldBossFormationLayer:init()
	self._startBtn = self.rtAdapt:Find("right/start")
	self._popup = self.rtAdapt:Find("right/start/cost_container/popup")
	self._costText = self.rtAdapt:Find("right/start/cost_container/popup/Text")
	self._backBtn = self._tf:Find("blur_panel/top/back_btn")
	self._moveLayer = self._tf:Find("moveLayer")

	local var_4_0 = self.rtAdapt:Find("middle")

	self._autoToggle = self.rtAdapt:Find("auto_toggle")
	self.subToggle = self.rtAdapt:Find("sub_toggle_container")

	setActive(self.subToggle, false)

	self._buffContainer = self.rtAdapt:Find("BuffContainer")

	setActive(self._buffContainer, false)

	self._fleetInfo = var_4_0:Find("fleet_info")
	self._fleetNameText = var_4_0:Find("fleet_info/fleet_name/Text")
	self._fleetNumText = var_4_0:Find("fleet_info/fleet_number")

	setActive(self._fleetInfo, self.contextData.system ~= SYSTEM_DUEL)

	self._mainGS = var_4_0:Find("gear_score/main/Text")
	self._vanguardGS = var_4_0:Find("gear_score/vanguard/Text")
	self._gridTFs = {
		vanguard = {},
		main = {}
	}
	self._gridFrame = var_4_0:Find("mask/GridFrame")

	for iter_4_0 = 1, 3 do
		self._gridTFs[TeamType.Vanguard][iter_4_0] = self._gridFrame:Find("vanguard_" .. iter_4_0)
		self._gridTFs[TeamType.Main][iter_4_0] = self._gridFrame:Find("main_" .. iter_4_0)
	end

	self._nextPage = self.rtAdapt:Find("middle/nextPage")
	self._prevPage = self.rtAdapt:Find("middle/prevPage")

	self:disableAllStepper()

	self._heroContainer = var_4_0:Find("HeroContainer")
	self._checkBtn = var_4_0:Find("checkBtn")
	self._spoilsContainer = self.rtAdapt:Find("right/infomation/atlasloot/spoils/items/items_container")
	self._item = self:getTpl("right/infomation/atlasloot/spoils/items/item_tpl", self.rtAdapt)
	self._goals = self.rtAdapt:Find("right/infomation/target/goal")
	self._heroInfo = self:getTpl("heroInfo")
	self._starTpl = self:getTpl("star_tpl")
	self._middle = self.rtAdapt:Find("middle")
	self._right = self.rtAdapt:Find("right")
	self.topPanel = self._tf:Find("blur_panel/top")

	setAnchoredPosition(self._middle, {
		x = -840
	})
	setAnchoredPosition(self._right, {
		x = 470
	})

	self.guideDesc = self._middle:Find("guideDesc")

	if self.contextData.stageId then
		self:SetStageID(self.contextData.stageId)
	end

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	self:Register()

	return
end

function WorldBossFormationLayer:Register()
	self._formationLogic:AddLoadComplete(function()
		if self._currentForm ~= WorldBossFormationLayer.FORM_EDIT then
			self._formationLogic:SwitchToPreviewMode()
		end

		return
	end)
	self._formationLogic:AddHeroInfoModify(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_2:SetLocalScale(Vector3(0.65, 0.65, 1))
		SetActive(arg_7_0, true)

		local var_7_0 = arg_7_0:Find("info")
		local var_7_1 = var_7_0:Find("stars")
		local var_7_2 = var_7_0:Find("energy")

		if arg_7_1.energy <= Ship.ENERGY_MID then
			local var_7_3, var_7_4 = arg_7_1:getEnergyPrint()
			local var_7_5 = GetSpriteFromAtlas("energy", var_7_3)

			if not var_7_5 then
				warning("找不到疲劳")
			end

			setImageSprite(var_7_2, var_7_5)
		end

		setActive(var_7_2, false)
		setActive(var_7_0:Find("expbuff"), false)

		for iter_7_0 = 1, arg_7_1:getStar() do
			cloneTplTo(self._starTpl, var_7_1)
		end

		local var_7_6 = GetSpriteFromAtlas("shiptype", shipType2print(arg_7_1:getShipType()))

		if not var_7_6 then
			warning("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite(var_7_0:Find("type"), var_7_6, true)
		setText(var_7_0:Find("frame/lv_contain/lv"), arg_7_1.level)

		return
	end)
	self._formationLogic:AddLongPress(function(arg_8_0, arg_8_1, arg_8_2)
		self:emit(WorldBossFormationMediator.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)
	self._formationLogic:AddClick(function(arg_9_0, arg_9_1, arg_9_2)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)
		self:emit(WorldBossFormationMediator.CHANGE_FLEET_SHIP, arg_9_0, arg_9_2, arg_9_1)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_10_0)
		SetActive(arg_10_0:Find("info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_11_0)
		SetActive(arg_11_0:Find("info"), true)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_12_0)
		self:emit(WorldBossFormationMediator.CHANGE_FLEET_SHIPS_ORDER)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_13_0, arg_13_1)
		self:emit(WorldBossFormationMediator.REMOVE_SHIP, arg_13_0, arg_13_1)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if not arg_14_3:canRemove(arg_14_2) then
			local var_14_0, var_14_1 = arg_14_3:getShipPos(arg_14_2)

			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_14_2:getConfigTable().name, arg_14_3.name, Fleet.C_TEAM_NAME[var_14_1]))
			arg_14_0()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				zIndex = -100,
				content = i18n("battle_preCombatLayer_quest_leaveFleet", arg_14_2:getConfigTable().name),
				onYes = arg_14_1,
				onNo = arg_14_0
			})
		end

		return
	end)
	self._formationLogic:AddSwitchToDisplayMode(function()
		self._currentForm = WorldBossFormationLayer.FORM_EDIT
		self._checkBtn:GetComponent("Button").interactable = true

		setActive(self._checkBtn:Find("save"), true)
		setActive(self._checkBtn:Find("edit"), false)

		return
	end)
	self._formationLogic:AddSwitchToShiftMode(function()
		self:disableAllStepper()

		self._checkBtn:GetComponent("Button").interactable = false

		return
	end)
	self._formationLogic:AddSwitchToPreviewMode(function()
		self._currentForm = WorldBossFormationLayer.FORM_PREVIEW
		self._checkBtn:GetComponent("Button").interactable = true

		setActive(self._checkBtn:Find("save"), false)
		setActive(self._checkBtn:Find("edit"), true)

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_18_0, arg_18_1)
		self:emit(WorldBossFormationMediator.CHANGE_FLEET_SHIP, nil, arg_18_1, arg_18_0)

		return
	end)

	return
end

function WorldBossFormationLayer:SetPlayerInfo(arg_19_1)
	return
end

function WorldBossFormationLayer:SetShips(arg_20_1)
	self._shipVOs = arg_20_1

	self._formationLogic:SetShipVOs(self._shipVOs)

	return
end

function WorldBossFormationLayer:SetStageID(arg_21_1)
	removeAllChildren(self._spoilsContainer)

	self._stageID = arg_21_1

	local var_21_0 = pg.expedition_data_template[arg_21_1]
	local var_21_1 = pg.expedition_data_template[arg_21_1].time_limit

	for iter_21_0, iter_21_1 in ipairs(pg.expedition_data_template[arg_21_1].award_display) do
		updateDrop(cloneTplTo(self._item, self._spoilsContainer), {
			id = iter_21_1[2],
			type = iter_21_1[1]
		})
	end

	local var_21_2 = self._goals:Find("goal_tpl")
	local var_21_3 = self._goals:Find("goal_sink")
	local var_21_4 = self._goals:Find("goal_time")

	if pg.expedition_data_template[arg_21_1].limit_type == 1 then
		local var_21_5 = pg.expedition_data_template[arg_21_1].sink_limit < 2 and i18n("battle_preCombatLayer_undefeated") or i18n("battle_preCombatLayer_sink_limit", pg.expedition_data_template[arg_21_1].sink_limit)

		setWidgetText(var_21_2, i18n("battle_preCombatLayer_victory"))
		setWidgetText(var_21_3, var_21_5)
		setWidgetText(var_21_4, i18n("battle_preCombatLayer_time_limit", var_21_1))
	elseif pg.expedition_data_template[arg_21_1].limit_type == 2 then
		setActive(var_21_3, false)
		setActive(var_21_4, false)
		setWidgetText(var_21_2, i18n("battle_preCombatLayer_time_hold", var_21_1))
	elseif pg.expedition_data_template[arg_21_1].limit_type == 3 then
		setActive(var_21_3, false)
		setActive(var_21_4, false)
		setWidgetText(var_21_2, i18n("battle_result_defeat_all_enemys", var_21_1))
	end

	local var_21_6 = var_21_0.guide_desc and #var_21_0.guide_desc > 0

	setActive(self.guideDesc, var_21_6)

	if var_21_6 then
		setText(self.guideDesc, var_21_0.guide_desc)
	end

	return
end

function WorldBossFormationLayer:SetCurrentFleet(arg_22_1)
	self._currentFleetVO = arg_22_1

	self._formationLogic:SetFleetVO(self._currentFleetVO)

	self._legalFleetIdList = {
		arg_22_1
	}
	self._curFleetIndex = 1

	return
end

function WorldBossFormationLayer:UpdateFleetView(arg_23_1)
	self:displayFleetInfo()
	self._formationLogic:ResetGrid(TeamType.Vanguard, self._currentForm ~= WorldBossFormationLayer.FORM_EDIT)
	self._formationLogic:ResetGrid(TeamType.Main, self._currentForm ~= WorldBossFormationLayer.FORM_EDIT)

	if arg_23_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function WorldBossFormationLayer:uiStartAnimating()
	setAnchoredPosition(self.topPanel, {
		y = 100
	})
	shiftPanel(self._middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self._right, 0, nil, 0.3, 0, true, true)
	shiftPanel(self.topPanel, nil, 0, 0.3, 0, true, true, nil)

	return
end

function WorldBossFormationLayer:uiExitAnimating()
	shiftPanel(self._middle, -840, nil, nil, nil, true, true)
	shiftPanel(self._right, 470, nil, nil, nil, true, true)
	shiftPanel(self.topPanel, nil, self.topPanel.rect.height, nil, nil, true, true, nil)

	return
end

function WorldBossFormationLayer:didEnter()
	onButton(self, self._backBtn, function()
		local var_27_0 = {}

		if self._currentForm == WorldBossFormationLayer.FORM_EDIT then
			table.insert(var_27_0, function(arg_28_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						self:emit(WorldBossFormationMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_28_0()

							return
						end)

						return
					end,
					onNo = arg_28_0
				})

				return
			end)
		end

		seriesAsync(var_27_0, function()
			GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

			self:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				nowWorld():GetBossProxy():UnlockCacheBoss()
				self:emit(WorldBossFormationLayer.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		local var_33_0 = {}

		if self._currentForm == WorldBossFormationLayer.FORM_EDIT then
			table.insert(var_33_0, function(arg_34_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						self:emit(WorldBossFormationMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_34_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_33_0, function()
			self:emit(WorldBossFormationMediator.ON_START, self._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._checkBtn, function()
		if self._currentForm == WorldBossFormationLayer.FORM_EDIT then
			self:emit(WorldBossFormationMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				self._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif self._currentForm == WorldBossFormationLayer.FORM_PREVIEW then
			self._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	self._currentForm = self.contextData.form
	self.contextData.form = nil

	self:UpdateFleetView(true)

	if self._currentForm == WorldBossFormationLayer.FORM_EDIT then
		self._formationLogic:SwitchToDisplayMode()
	else
		self._formationLogic:SwitchToPreviewMode()
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	if self.contextData.system == SYSTEM_DUEL then
		setActive(self._autoToggle, false)
	else
		setActive(self._autoToggle, true)
		onToggle(self, self._autoToggle, function(arg_40_0)
			self:emit(WorldBossFormationMediator.ON_AUTO, {
				isOn = not arg_40_0,
				toggle = self._autoToggle
			})

			return
		end, SFX_PANEL, SFX_PANEL)
		triggerToggle(self._autoToggle, ys.Battle.BattleState.IsAutoBotActive(SYSTEM_WORLD))
	end

	setAnchoredPosition(self.topPanel, {
		y = self.topPanel.rect.height
	})
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	if self._currentForm == WorldBossFormationLayer.FORM_PREVIEW and self._currentFleetVO:isLegalToFight() ~= true then
		triggerButton(self._checkBtn)
	end

	self:UpdateBuffContainer()
	self:TryPlayGuide()

	return
end

function WorldBossFormationLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._backBtn)

	return
end

function WorldBossFormationLayer:displayFleetInfo()
	local var_43_0 = self._currentFleetVO:GetPropertiesSum()
	local var_43_1 = self._currentFleetVO:GetGearScoreSum(TeamType.Vanguard)
	local var_43_2 = self._currentFleetVO:GetGearScoreSum(TeamType.Main)
	local var_43_3 = 0

	if self.boss and self.boss:IsSelf() and self.boss:GetSelfFightCnt() > 0 then
		var_43_3 = self.boss:GetOilConsume()
	end

	setActive(self._popup, self.contextData.system ~= SYSTEM_DUEL)
	FormationUI.tweenNumText(self._costText, var_43_3)
	FormationUI.tweenNumText(self._vanguardGS, var_43_1)
	FormationUI.tweenNumText(self._mainGS, var_43_2)
	setText(self._fleetNameText, FormationUI.defaultFleetName(self._currentFleetVO))
	setText(self._fleetNumText, self._currentFleetVO.id)

	return
end

function WorldBossFormationLayer:disableAllStepper()
	SetActive(self._nextPage, false)
	SetActive(self._prevPage, false)

	return
end

function WorldBossFormationLayer:GetActiveStgs()
	local var_45_0 = {}
	local var_45_1, var_45_2, var_45_3 = WorldBossProxy.GetSupportValue()

	if var_45_1 and self.boss and self.boss:IsSelf() then
		table.insert(var_45_0, var_45_3)
	end

	return var_45_0
end

function WorldBossFormationLayer:UpdateBuffContainer()
	local var_46_0 = self:GetActiveStgs()
	local var_46_1 = #var_46_0 > 0

	setActive(self._buffContainer, #var_46_0 > 0)

	if not var_46_1 then
		return
	end

	UIItemList.StaticAlign(self._buffContainer, self._buffContainer:GetChild(0), #var_46_0, function(arg_47_0, arg_47_1, arg_47_2)
		if arg_47_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_47_0 = pg.strategy_data_template[var_46_0[arg_47_1 + 1]]

		GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_46_0[arg_47_1 + 1]].icon, "", arg_47_2)
		onButton(self, arg_47_2, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_confirm",
				hideNo = true,
				content = "",
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = {
					type = DROP_TYPE_STRATEGY,
					id = var_47_0.id,
					cfg = var_47_0
				}
			})

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function WorldBossFormationLayer:TryPlayGuide()
	if #self:GetActiveStgs() > 0 then
		WorldGuider.GetInstance():PlayGuide("WorldG200")
	end

	return
end

function WorldBossFormationLayer:willExit()
	if self._currentForm == WorldBossFormationLayer.FORM_EDIT then
		self.contextData.editingFleetVO = self._currentFleetVO
	end

	self._formationLogic:Destroy()

	if self.tweens then
		cancelTweens(self.tweens)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return WorldBossFormationLayer
