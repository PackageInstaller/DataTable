local NewBattleResultDisplayPaintingsPage = class("NewBattleResultDisplayPaintingsPage", import("view.base.BaseSubView"))
local var_0_1 = 6
local var_0_2 = 295

function NewBattleResultDisplayPaintingsPage:getUIName()
	return "NewBattleResultDisplayPaintingsPages"
end

function NewBattleResultDisplayPaintingsPage:OnLoaded()
	self.slots = {
		self._tf:Find("tpl")
	}
	self.defaultPaintingPosition = self._tf:Find("tpl/mask/painting").anchoredPosition

	return
end

function NewBattleResultDisplayPaintingsPage:StaticGetFinalExpandPosition()
	if self <= var_0_1 then
		return NewBattleResultDisplayPaintingsPage.StaticGetExpandPosition(self, var_0_1 - 1)
	else
		return NewBattleResultDisplayPaintingsPage.StaticGetExpandPosition(self, self - 1) - (self - var_0_1) * Vector2(var_0_2, 0)
	end

	return
end

function NewBattleResultDisplayPaintingsPage:StaticGetExpandPosition(arg_4_1)
	local var_4_1 = arg_4_1 % 2 ~= 0

	return ((self > 6 and self % 2 == 0 or self <= 6) and (var_4_1 and Vector2(-730, 72) or Vector2(-457, -72)) or var_4_1 and Vector2(-751, -72) or Vector2(-437, 72)) + Vector2(590, 0) * (math.ceil(arg_4_1 / 2) - 1)
end

function NewBattleResultDisplayPaintingsPage:GetExpandPosition(arg_5_1, arg_5_2)
	return NewBattleResultDisplayPaintingsPage.StaticGetExpandPosition(arg_5_1, arg_5_2)
end

function NewBattleResultDisplayPaintingsPage:GetShrinkPosition(arg_6_1, arg_6_2)
	local var_6_0 = self:GetExpandPosition(arg_6_1, arg_6_2)
	local var_6_1 = arg_6_2 % 2 ~= 0
	local var_6_2 = Vector2(-125, -936)

	if arg_6_1 > 6 and arg_6_1 % 2 == 0 or arg_6_1 <= 6 then
		return (var_6_1 or nil) and (var_6_0 - var_6_2 or var_6_0 + var_6_2)
	else
		return (var_6_1 or nil) and (var_6_0 + var_6_2 or var_6_0 - var_6_2)
	end

	return
end

function NewBattleResultDisplayPaintingsPage:SetUp(arg_7_1)
	self:Show()

	self.displayShips = self:ReSortFleetShips()

	seriesAsync({
		function(arg_8_0)
			self:InitMainFleetShips(arg_8_0)

			return
		end,
		function(arg_9_0)
			self:DisplayMainFleet(arg_9_0)

			return
		end,
		function(arg_10_0)
			self:MoveMainFleetShips(arg_10_0)

			return
		end,
		function(arg_11_0)
			self:InitSubFleetShips(arg_11_0)

			return
		end,
		function(arg_12_0)
			self:DisplaySubFleet(arg_12_0)

			return
		end,
		function(arg_13_0)
			onDelayTick(arg_13_0, 0.5)

			return
		end
	}, function()
		arg_7_1()

		return
	end)

	return
end

function NewBattleResultDisplayPaintingsPage:ReSortFleetShips()
	local var_15_0, var_15_1, var_15_2, var_15_3 = NewBattleResultUtil.SeparateMvpShip(self.contextData.oldMainShips, self.contextData.statistics.mvpShipID, self.contextData.statistics._flagShipID)
	local var_15_4 = {}

	if var_15_3 ~= nil then
		local var_15_5 = ShipType.GetTeamFromShipType(ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(var_15_3.configId).type)

		if var_15_5 == TeamType.Vanguard then
			NewBattleResultUtil.SpecialInsertItem(var_15_4, var_15_2, var_15_1, var_15_0, var_15_3)
		elseif var_15_5 == TeamType.Main then
			NewBattleResultUtil.SpecialInsertItem(var_15_4, var_15_2, var_15_0, var_15_1, var_15_3)
		elseif var_15_5 == TeamType.Submarine then
			NewBattleResultUtil.SpecialInsertItem(var_15_4, var_15_0, var_15_1, var_15_2, var_15_3)
		end
	else
		var_15_4 = self.contextData.oldMainShips
	end

	return var_15_4
end

function NewBattleResultDisplayPaintingsPage:InitSubFleetShips(arg_16_1)
	if self.exited then
		return
	end

	local var_16_0 = self.displayShips

	if #self.displayShips <= var_0_1 then
		arg_16_1()

		return
	end

	for iter_16_0 = 1, #var_16_0 - var_0_1 do
		if self.slots[iter_16_0] then
			self:RevertPainting(self.slots[iter_16_0])
			retPaintingPrefab(self.slots[iter_16_0]:Find("mask/painting"), var_16_0[iter_16_0]:getPainting())
		end
	end

	local var_16_1 = {}

	for iter_16_1 = var_0_1 + 1, math.max(var_0_1, #var_16_0) do
		local var_16_2 = Object.Instantiate(self.slots[1], self.slots[1].parent)

		table.insert(self.slots, var_16_2)

		local var_16_3 = var_16_0[iter_16_1]

		var_16_2.localPosition = self:GetExpandPosition(#var_16_0, iter_16_1)

		table.insert(var_16_1, function(arg_17_0)
			setPaintingPrefabAsync(var_16_2:Find("mask/painting"), var_16_3:getPainting(), "biandui", arg_17_0)
			self:AdjustPainting(var_16_2, var_16_3)

			return
		end)
	end

	parallelAsync(var_16_1, function()
		onDelayTick(arg_16_1, 0.05)

		return
	end)

	return
end

function NewBattleResultDisplayPaintingsPage:DisplaySubFleet(arg_19_1)
	if self.exited then
		return
	end

	self:EffectSlots(false)

	if #self.displayShips <= var_0_1 then
		arg_19_1()

		return
	end

	local var_19_0 = {}

	for iter_19_0 = var_0_1 + 1, math.max(var_0_1, #self.displayShips) do
		local var_19_1 = self.slots[iter_19_0]
		local var_19_2 = self:GetExpandPosition(#self.displayShips, iter_19_0).x
		local var_19_3 = var_19_2 - (#self.displayShips - var_0_1) * var_0_2

		table.insert(var_19_0, function(arg_20_0)
			if self.exited then
				return
			end

			LeanTween.value(var_19_1.gameObject, var_19_2, var_19_3, 0.3):setOnUpdate(System.Action_float(function(arg_21_0)
				var_19_1.localPosition = Vector3(arg_21_0, var_19_1.localPosition.y, 0)

				return
			end)):setEase(LeanTweenType.easeOutQuad)
			onDelayTick(function()
				if self.exited then
					return
				end

				setActive(var_19_1:Find("mask/blink"), true)

				return
			end, 0.15)
			onDelayTick(function()
				if self.exited then
					return
				end

				setActive(var_19_1:Find("mask/blink"), false)

				return
			end, 0.2)
			onDelayTick(arg_20_0, 0.1)

			return
		end)
	end

	seriesAsync(var_19_0, function()
		self:EffectSlots(true)
		arg_19_1()

		return
	end)

	return
end

function NewBattleResultDisplayPaintingsPage:EffectSlots(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self.slots) do
		if not IsNil(iter_25_1) then
			setActive(iter_25_1:Find("effect"), arg_25_1)
		end
	end

	return
end

function NewBattleResultDisplayPaintingsPage:MoveMainFleetShips(arg_26_1)
	if self.exited then
		return
	end

	local var_26_0 = #self.displayShips

	if #self.displayShips <= var_0_1 then
		arg_26_1()

		return
	end

	local var_26_1 = {}
	local var_26_2 = var_26_0 - var_0_1

	for iter_26_0, iter_26_1 in ipairs(self.slots) do
		table.insert(var_26_1, function(arg_27_0)
			local var_27_0 = self:GetExpandPosition(var_26_0, iter_26_0).x

			LeanTween.value(iter_26_1.gameObject, var_27_0, var_27_0 - var_26_2 * var_0_2, 0.3):setOnUpdate(System.Action_float(function(arg_28_0)
				iter_26_1.localPosition = Vector3(arg_28_0, iter_26_1.localPosition.y, 0)

				return
			end)):setEase(LeanTweenType.easeOutQuad):setOnComplete(System.Action(arg_27_0))

			return
		end)
	end

	parallelAsync(var_26_1, function()
		return
	end)
	onDelayTick(function()
		if self.exited then
			return
		end

		arg_26_1()

		for iter_30_0 = 1, var_26_2 do
			if self.slots[iter_30_0] then
				setActive(self.slots[iter_30_0], false)
			end
		end

		return
	end, 0.05)

	return
end

function NewBattleResultDisplayPaintingsPage:DisplayMainFleet(arg_31_1)
	if self.exited then
		return
	end

	local var_31_0 = {}
	local var_31_1 = var_0_1 - #self.slots
	local var_31_2 = #self.displayShips

	for iter_31_0, iter_31_1 in ipairs(self.slots) do
		table.insert(var_31_0, function(arg_32_0)
			if self.exited then
				return
			end

			LeanTween.value(iter_31_1.gameObject, self:GetShrinkPosition(var_31_2, var_31_1 + iter_31_0), self:GetExpandPosition(var_31_2, var_31_1 + iter_31_0), 0.29):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_33_0)
				iter_31_1.localPosition = arg_33_0

				return
			end))
			onNextTick(arg_32_0)

			return
		end)
	end

	local var_31_3 = 0

	Timer.New(function()
		if self.exited then
			return
		end

		for iter_34_0, iter_34_1 in ipairs(self.slots) do
			setActive(iter_34_1:Find("mask/blink"), var_31_3 % 2 ~= 0 == (iter_34_0 % 2 ~= 0))
		end

		var_31_3 = var_31_3 + 1

		return
	end, 0.059, 5):Start()
	Timer.New(function()
		if self.exited then
			return
		end

		for iter_35_0, iter_35_1 in ipairs(self.slots) do
			setActive(iter_35_1:Find("mask/blink"), false)
		end

		return
	end, 0.3, 1):Start()
	seriesAsync(var_31_0, function()
		self:EffectSlots(true)
		onDelayTick(arg_31_1, 0.5)

		return
	end)

	return
end

function NewBattleResultDisplayPaintingsPage:InitMainFleetShips(arg_37_1)
	local var_37_0 = math.min(var_0_1, #self.displayShips)

	for iter_37_0 = 2, var_37_0 do
		table.insert(self.slots, (Object.Instantiate(self.slots[1], self.slots[1].parent)))
	end

	local var_37_1 = {}

	for iter_37_1 = 1, var_37_0 do
		local var_37_2 = self.displayShips[iter_37_1]
		local var_37_3 = self.slots[iter_37_1]

		self.slots[iter_37_1].localPosition = self:GetShrinkPosition(#self.displayShips, var_0_1 - var_37_0 + iter_37_1)

		table.insert(var_37_1, function(arg_38_0)
			if self.exited then
				return
			end

			setPaintingPrefabAsync(var_37_3:Find("mask/painting"), var_37_2:getPainting(), "biandui", arg_38_0)
			self:AdjustPainting(var_37_3, var_37_2)

			return
		end)
	end

	parallelAsync(var_37_1, arg_37_1)

	return
end

function NewBattleResultDisplayPaintingsPage:AdjustPainting(arg_39_1, arg_39_2)
	local var_39_0 = pg.ship_skin_newmainui_shift[arg_39_2:getSkinId()]

	if var_39_0 then
		local var_39_1 = arg_39_1:Find("mask/painting"):GetComponent(typeof(RectTransform))

		var_39_1.anchoredPosition = Vector2(var_39_0.battle_result_display_shift[1] + self.defaultPaintingPosition.x, var_39_0.battle_result_display_shift[2] + self.defaultPaintingPosition.y)
		var_39_1.localScale = Vector3(var_39_0.battle_result_display_shift[4], var_39_0.battle_result_display_shift[4], 1)
		var_39_1.localEulerAngles = Vector3(var_39_1.localEulerAngles.x, var_39_1.localEulerAngles.y, (var_39_0.battle_result_display_shift[5] or nil) and (var_39_0.battle_result_display_shift[5] or 0))
	end

	return
end

function NewBattleResultDisplayPaintingsPage:RevertPainting(arg_40_1)
	local var_40_0 = arg_40_1:Find("mask/painting"):GetComponent(typeof(RectTransform))

	var_40_0.anchoredPosition = self.defaultPaintingPosition
	var_40_0.localScale = Vector3(1, 1, 1)
	var_40_0.localEulerAngles = Vector3(0, 0, 0)

	return
end

function NewBattleResultDisplayPaintingsPage:OnDestroy()
	self.exited = true

	if self:isShowing() then
		self:Hide()
	end

	local var_41_0 = self.displayShips or {}

	for iter_41_0, iter_41_1 in ipairs(self.slots or {}) do
		if iter_41_1 then
			local var_41_1 = iter_41_1:Find("mask/painting")

			if var_41_1 and var_41_0[iter_41_0] and var_41_1:Find("fitter").childCount > 0 then
				self:RevertPainting(iter_41_1)
				retPaintingPrefab(var_41_1, var_41_0[iter_41_0]:getPainting())
			end
		end

		if iter_41_1 and LeanTween.isTweening(iter_41_1.gameObject) then
			LeanTween.cancel(iter_41_1.gameObject)
		end
	end

	return
end

return NewBattleResultDisplayPaintingsPage
