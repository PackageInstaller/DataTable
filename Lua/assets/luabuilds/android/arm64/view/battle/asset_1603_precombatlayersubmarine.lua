local PreCombatLayerSubmarine = class("PreCombatLayerSubmarine", import(".PreCombatLayer"))
local FormationUI = import("..ship.FormationUI")

function PreCombatLayerSubmarine:init()
	self:CommonInit()

	local var_1_0 = self._tf:Find("adapt/middle")

	SetActive(var_1_0:Find("gear_score/main"), false)
	SetActive(var_1_0:Find("gear_score/vanguard"), false)
	SetActive(var_1_0:Find("gear_score/submarine"), true)
	setActive(self._bgFleet, false)
	setActive(self._bgSub, true)

	self._formationLogic = BaseFormation.New(self._tf, self._heroContainer, self._heroInfo, self._gridTFs)

	self:Register()

	return
end

function PreCombatLayerSubmarine:SetFleets(arg_2_1)
	local var_2_0 = _.filter(_.values(arg_2_1), function(arg_3_0)
		return arg_3_0:getFleetType() == FleetType.Submarine
	end)

	self._fleetVOs = {}
	self._fleetIDList = {}

	local var_2_1 = 0

	_.each(var_2_0, function(arg_4_0)
		self._fleetVOs[arg_4_0.id] = arg_4_0

		if #arg_4_0.ships > 0 then
			table.insert(self._fleetIDList, arg_4_0.id)

			var_2_1 = var_2_1 + 1
		end

		return
	end)

	if 0 == 0 then
		table.insert(self._fleetIDList, var_2_0[1].id)
	end

	table.sort(self._fleetIDList, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	return
end

function PreCombatLayerSubmarine:SetCurrentFleet(arg_6_1)
	arg_6_1 = arg_6_1 or self._fleetIDList[1]
	self._currentFleetVO = self._fleetVOs[arg_6_1]

	self._formationLogic:SetFleetVO(self._currentFleetVO)

	return
end

function PreCombatLayerSubmarine:UpdateFleetView(arg_7_1)
	self:displayFleetInfo()
	self._formationLogic:UpdateGridVisibility()
	self._formationLogic:ResetGrid(TeamType.Submarine, self._currentForm ~= PreCombatLayerSubmarine.FORM_EDIT)

	if arg_7_1 then
		self._formationLogic:LoadAllCharacter()
	else
		self._formationLogic:SetAllCharacterPos()
	end

	return
end

function PreCombatLayerSubmarine:didEnter()
	onButton(self, self._backBtn, function()
		local var_9_0 = {}

		if self._currentForm == PreCombatLayerSubmarine.FORM_EDIT then
			table.insert(var_9_0, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_confirm"),
					onYes = function()
						self:emit(PreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_10_0()

							return
						end)

						return
					end,
					onNo = function()
						self:emit(PreCombatMediator.ON_ABORT_EDIT)
						arg_10_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_9_0, function()
			GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

			self:uiExitAnimating()
			LeanTween.delayedCall(0.3, System.Action(function()
				self:emit(PreCombatLayerSubmarine.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self._startBtn, function()
		local var_16_0 = {}

		if self._currentForm == PreCombatLayerSubmarine.FORM_EDIT then
			table.insert(var_16_0, function(arg_17_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = false,
					zIndex = -100,
					content = i18n("battle_preCombatLayer_save_march"),
					onYes = function()
						self:emit(PreCombatMediator.ON_COMMIT_EDIT, function()
							pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
							arg_17_0()

							return
						end)

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_16_0, function()
			self:emit(PreCombatMediator.ON_START, self._currentFleetVO.id)

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self._nextPage, function()
		local var_21_0 = self:getNextFleetID()

		if var_21_0 then
			self:emit(PreCombatMediator.ON_CHANGE_FLEET, var_21_0, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, self._prevPage, function()
		local var_22_0 = self:getPrevFleetID()

		if var_22_0 then
			self:emit(PreCombatMediator.ON_CHANGE_FLEET, var_22_0, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, self._checkBtn, function()
		if self._currentForm == PreCombatLayerSubmarine.FORM_EDIT then
			self:emit(PreCombatMediator.ON_COMMIT_EDIT, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_preCombatLayer_save_success"))
				self._formationLogic:SwitchToPreviewMode()

				return
			end)
		elseif self._currentForm == PreCombatLayerSubmarine.FORM_PREVIEW then
			self._formationLogic:SwitchToDisplayMode()
		else
			assert("currentForm error")
		end

		return
	end, SFX_PANEL)

	self._currentForm = self.contextData.form
	self.contextData.form = nil

	self:UpdateFleetView(true)

	if self._currentForm == PreCombatLayerSubmarine.FORM_EDIT then
		self._formationLogic:SwitchToDisplayMode()
	else
		self._formationLogic:SwitchToPreviewMode()
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._autoToggle, false)
	setActive(self._autoSubToggle, false)
	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	return
end

function PreCombatLayerSubmarine:getNextFleetID()
	local var_26_0

	for iter_26_0, iter_26_1 in ipairs(self._fleetIDList) do
		if iter_26_1 == self._currentFleetVO.id then
			var_26_0 = iter_26_0

			break
		end
	end

	return self._fleetIDList[var_26_0 + 1]
end

function PreCombatLayerSubmarine:getPrevFleetID()
	local var_27_0

	for iter_27_0, iter_27_1 in ipairs(self._fleetIDList) do
		if iter_27_1 == self._currentFleetVO.id then
			var_27_0 = iter_27_0

			break
		end
	end

	return self._fleetIDList[var_27_0 - 1]
end

function PreCombatLayerSubmarine:displayFleetInfo()
	setActive(self._popup, true)
	FormationUI.tweenNumText(self._costText, self._currentFleetVO:GetCostSum().oil)
	FormationUI.tweenNumText(self._subGS, (math.floor(self._currentFleetVO:GetGearScoreSum(TeamType.Submarine))))
	setText(self._fleetNameText, FormationUI.defaultFleetName(self._currentFleetVO))
	setText(self._fleetNumText, self._currentFleetVO.id - 10)

	return
end

function PreCombatLayerSubmarine:SetFleetStepper()
	if self._currentForm == PreCombatLayerSubmarine.FORM_EDIT then
		SetActive(self._nextPage, false)
		SetActive(self._prevPage, false)
	else
		setActive(self._nextPage, self:getNextFleetID() ~= nil)
		setActive(self._prevPage, self:getPrevFleetID() ~= nil)
	end

	return
end

return PreCombatLayerSubmarine
