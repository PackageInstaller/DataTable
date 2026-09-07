local ExercisePreCombatLayer = class("ExercisePreCombatLayer", import("view.battle.PreCombatLayer"))
local FormationUI = import("..ship.FormationUI")

function ExercisePreCombatLayer:getUIName()
	return "PreCombatUI"
end

function ExercisePreCombatLayer:ResUISettings()
	return {
		anim = true,
		order = 5,
		showType = PlayerResUI.TYPE_ALL
	}
end

function ExercisePreCombatLayer:CommonInit()
	ExercisePreCombatLayer.super.CommonInit(self)

	self._ticket = self._costContainer:Find("ticket")

	return
end

function ExercisePreCombatLayer:Register()
	self._formationLogic:AddLoadComplete(function()
		if self._currentForm ~= ExercisePreCombatLayer.FORM_EDIT then
			self._formationLogic:SwitchToPreviewMode()
		end

		return
	end)
	self._formationLogic:AddHeroInfoModify(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_2:SetLocalScale(Vector3(0.65, 0.65, 1))
		SetActive(arg_6_0, true)

		local var_6_0 = findTF(arg_6_0, "info")
		local var_6_1 = findTF(var_6_0, "stars")
		local var_6_2 = arg_6_1.energy <= Ship.ENERGY_MID
		local var_6_3 = findTF(var_6_0, "energy")

		if arg_6_1.energy <= Ship.ENERGY_MID then
			local var_6_4, var_6_5 = arg_6_1:getEnergyPrint()
			local var_6_6 = GetSpriteFromAtlas("energy", var_6_4)

			if not var_6_6 then
				warning("找不到疲劳")
			end

			setImageSprite(var_6_3, var_6_6)
		end

		setActive(var_6_3, var_6_2 and self.contextData.system ~= SYSTEM_DUEL)

		for iter_6_0 = 1, arg_6_1:getStar() do
			cloneTplTo(self._starTpl, var_6_1)
		end

		local var_6_7 = GetSpriteFromAtlas("shiptype", shipType2print(arg_6_1:getShipType()))

		if not var_6_7 then
			warning("找不到船形, shipConfigId: " .. arg_6_1.configId)
		end

		setImageSprite(findTF(var_6_0, "type"), var_6_7, true)
		setText(findTF(var_6_0, "frame/lv_contain/lv"), arg_6_1.level)
		setActive(var_6_0:Find("expbuff"), false)

		return
	end)
	self._formationLogic:AddLongPress(function(arg_7_0, arg_7_1, arg_7_2)
		self:emit(ExercisePreCombatMediator.OPEN_SHIP_INFO, arg_7_1.id, arg_7_2)

		return
	end)
	self._formationLogic:AddClick(function(arg_8_0, arg_8_1, arg_8_2)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)
		self:emit(ExercisePreCombatMediator.CHANGE_FLEET_SHIP, arg_8_0, arg_8_2, arg_8_1)

		return
	end)
	self._formationLogic:AddBeginDrag(function(arg_9_0)
		SetActive(findTF(arg_9_0, "info"), false)

		return
	end)
	self._formationLogic:AddEndDrag(function(arg_10_0)
		SetActive(findTF(arg_10_0, "info"), true)

		return
	end)
	self._formationLogic:AddShiftOnly(function(arg_11_0)
		self:emit(ExercisePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, arg_11_0)

		return
	end)
	self._formationLogic:AddRemoveShip(function(arg_12_0, arg_12_1)
		self:emit(ExercisePreCombatMediator.REMOVE_SHIP, arg_12_0, arg_12_1)

		return
	end)
	self._formationLogic:AddCheckRemove(function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			zIndex = -100,
			content = i18n("battle_preCombatLayer_quest_leaveFleet", arg_13_2:getConfigTable().name),
			onYes = arg_13_1,
			onNo = arg_13_0
		})

		return
	end)
	self._formationLogic:AddSwitchToDisplayMode(function()
		self._currentForm = ExercisePreCombatLayer.FORM_EDIT
		self._checkBtn:GetComponent("Button").interactable = true

		setActive(self._checkBtn:Find("save"), true)
		setActive(self._checkBtn:Find("edit"), false)

		return
	end)
	self._formationLogic:AddSwitchToShiftMode(function()
		self._checkBtn:GetComponent("Button").interactable = false

		return
	end)
	self._formationLogic:AddSwitchToPreviewMode(function()
		self._currentForm = ExercisePreCombatLayer.FORM_PREVIEW
		self._checkBtn:GetComponent("Button").interactable = true

		setActive(self._checkBtn:Find("save"), false)
		setActive(self._checkBtn:Find("edit"), true)

		return
	end)
	self._formationLogic:AddGridTipClick(function(arg_17_0, arg_17_1)
		self:emit(ExercisePreCombatMediator.CHANGE_FLEET_SHIP, nil, arg_17_1, arg_17_0)

		return
	end)

	return
end

function ExercisePreCombatLayer:didEnter()
	self:disableAllStepper()
	onButton(self, self._backBtn, function()
		local var_19_0 = {}

		if self._currentForm == ExercisePreCombatLayer.FORM_EDIT then
			table.insert(var_19_0, function(arg_20_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						self:emit(ExercisePreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_20_0()

							return
						end)

						return
					end,
					onNo = arg_20_0
				})

				return
			end)
		end

		seriesAsync(var_19_0, function()
			GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

			self:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				self:emit(ExercisePreCombatLayer.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		local var_25_0 = {}

		if self._currentForm == ExercisePreCombatLayer.FORM_EDIT then
			table.insert(var_25_0, function(arg_26_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						self:emit(ExercisePreCombatMediator.ON_COMMIT_EDIT, function()
							self._formationLogic:SwitchToPreviewMode()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_26_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_25_0, function()
			self:emit(ExercisePreCombatMediator.ON_START, self._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._nextPage, function()
		self:emit(ExercisePreCombatMediator.ON_CHANGE_FLEET, self._legalFleetIdList[self._curFleetIndex + 1])

		return
	end, SFX_PANEL)
	onButton(self, self._prevPage, function()
		self:emit(ExercisePreCombatMediator.ON_CHANGE_FLEET, self._legalFleetIdList[self._curFleetIndex - 1])

		return
	end, SFX_PANEL)
	onButton(self, self._checkBtn, function()
		if self._currentForm == ExercisePreCombatLayer.FORM_EDIT then
			self:emit(ExercisePreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				self._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif self._currentForm == ExercisePreCombatLayer.FORM_PREVIEW then
			self._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	self._currentForm = self.contextData.form
	self.contextData.form = nil

	self:UpdateFleetView(true)

	if self._currentForm == ExercisePreCombatLayer.FORM_EDIT then
		self._formationLogic:SwitchToDisplayMode()
	else
		self._formationLogic:SwitchToPreviewMode()
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	if self.contextData.system == SYSTEM_DUEL then
		setActive(self._autoToggle, false)
		setActive(self._autoSubToggle, false)
	else
		setActive(self._autoToggle, true)
		onToggle(self, self._autoToggle, function(arg_34_0)
			self:emit(ExercisePreCombatMediator.ON_AUTO, {
				isOn = not arg_34_0,
				toggle = self._autoToggle
			})

			if arg_34_0 and self._subUseable == true then
				setActive(self._autoSubToggle, true)
				onToggle(self, self._autoSubToggle, function(arg_35_0)
					self:emit(ExercisePreCombatMediator.ON_SUB_AUTO, {
						isOn = not arg_35_0,
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
	end

	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	if self._currentForm == ExercisePreCombatLayer.FORM_PREVIEW and self.contextData.system == SYSTEM_DUEL and #self._currentFleetVO.mainShips <= 0 then
		triggerButton(self._checkBtn)
	end

	return
end

function ExercisePreCombatLayer:disableAllStepper()
	SetActive(self._nextPage, false)
	SetActive(self._prevPage, false)

	return
end

function ExercisePreCombatLayer:willExit()
	if self._currentForm == ExercisePreCombatLayer.FORM_EDIT then
		local var_38_0 = getProxy(FleetProxy)

		self.contextData.EdittingFleet = var_38_0.EdittingFleet

		var_38_0:abortEditting()
	end

	ExercisePreCombatLayer.super.willExit(self)

	if self.tweens then
		cancelTweens(self.tweens)
	end

	return
end

return ExercisePreCombatLayer
