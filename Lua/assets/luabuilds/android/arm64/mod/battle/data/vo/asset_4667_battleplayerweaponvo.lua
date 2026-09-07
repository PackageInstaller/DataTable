ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattlePlayerWeaponVO = class("BattlePlayerWeaponVO")
ys.Battle.BattlePlayerWeaponVO.__name = "BattlePlayerWeaponVO"

function ys.Battle.BattlePlayerWeaponVO:Ctor(arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._GCD = arg_1_1

	self:Reset()

	return
end

function ys.Battle.BattlePlayerWeaponVO:Reset()
	self._isOverLoad = false
	self._current = self._GCD
	self._max = self._GCD
	self._count = 0
	self._total = 0
	self._weaponList = {}
	self._overHeatList = {}
	self._readyList = {}
	self._chargingList = {}

	return
end

function ys.Battle.BattlePlayerWeaponVO:Update(arg_3_1)
	if self._current < self._max then
		if arg_3_1 - self._reloadStartTime >= self._max then
			self._current = self._max
			self._reloadStartTime = nil

			for iter_3_0, iter_3_1 in ipairs(self._chargingList) do
				iter_3_1:UpdateReload()
			end

			self:DispatchOverLoadChange()
		else
			self._current = arg_3_1 - self._reloadStartTime
		end
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO:PlayFocus(arg_4_1, arg_4_2)
	var_0_0.Battle.BattleCameraUtil.GetInstance():FocusCharacter(arg_4_1, var_0_1.CAST_CAM_ZOOM_IN_DURATION)
	var_0_0.Battle.BattleCameraUtil.GetInstance():ZoomCamara(nil, var_0_1.CAST_CAM_ZOOM_SIZE, var_0_1.CAST_CAM_ZOOM_IN_DURATION, true)
	var_0_0.Battle.BattleCameraUtil.GetInstance():BulletTime(var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, var_0_1.FOCUS_MAP_RATE, arg_4_1)

	self._focus = true

	if self._focusTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._focusTimer)
	end

	self._focusTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, var_0_1.CAST_CAM_ZOOM_IN_DURATION, function()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._focusTimer)

		self._focusTimer = nil

		arg_4_2()

		return
	end, true)

	return
end

function ys.Battle.BattlePlayerWeaponVO.PlayCutIn(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.Battle.BattleCameraUtil.GetInstance():CutInPainting(arg_6_1, arg_6_2)

	return
end

function ys.Battle.BattlePlayerWeaponVO.ResetFocus(arg_7_0)
	return
end

function ys.Battle.BattlePlayerWeaponVO:CancelFocus()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._focusTimer)

	self._focusTimer = nil

	return
end

function ys.Battle.BattlePlayerWeaponVO:GetWeaponList()
	return self._weaponList
end

function ys.Battle.BattlePlayerWeaponVO:AppendWeapon(arg_10_1)
	self._weaponList[#self._weaponList + 1] = arg_10_1

	if arg_10_1:GetCurrentState() == arg_10_1.STATE_READY then
		self._count = self._count + 1
	end

	self._total = self._total + 1

	self:DispatchTotalChange()

	self._current = self._max

	self:DispatchOverLoadChange()

	self._readyList[#self._readyList + 1] = arg_10_1

	return
end

function ys.Battle.BattlePlayerWeaponVO:AppendFreezeWeapon(arg_11_1)
	self._weaponList[#self._weaponList + 1] = arg_11_1
	self._total = self._total + 1

	self:DispatchTotalChange()

	if arg_11_1:GetCurrentState() == arg_11_1.STATE_READY then
		self._count = self._count + 1

		table.insert(self._readyList, arg_11_1)
	elseif arg_11_1:GetCDStartTimeStamp() then
		table.insert(self._chargingList, arg_11_1)
	else
		table.insert(self._overHeatList, arg_11_1)
	end

	self:resetCurrent()
	self:refreshCD()
	self:RefreshReloadingBar()
	self:DispatchOverLoadChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO:RemoveWeapon(arg_12_1)
	local var_12_0 = self.deleteElementFromArray(arg_12_1, self._weaponList)

	self._total = self._total - 1

	if arg_12_1:GetCurrentState() ~= arg_12_1.STATE_OVER_HEAT then
		self._count = self._count - 1

		if self._count < 0 then
			self._count = 0
		end

		local var_12_1 = self.deleteElementFromArray(arg_12_1, self._readyList)

		self:DispatchOverLoadChange()
		self:DispatchTotalChange(var_12_1)
	else
		if self.deleteElementFromArray(arg_12_1, self._chargingList) == -1 then
			self.deleteElementFromArray(arg_12_1, self._overHeatList)
		end

		self:DispatchOverLoadChange()
		self:DispatchTotalChange()
	end

	self:refreshCD()

	return var_12_0
end

function ys.Battle.BattlePlayerWeaponVO:refreshCD()
	if #self._readyList ~= 0 then
		self._current = 1
		self._max = 1
	elseif #self._readyList + #self._chargingList == 0 then
		self._current = 1
		self._max = 1
	else
		local var_13_0 = self:GetNextTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime()

		self._max = self._current >= self._GCD and var_13_0 or math.max(math.max(self._max, self._GCD) - self._current, var_13_0)

		self:resetCurrent()
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO:RefreshReloadingBar()
	if not self._reloadStartTime or #self._readyList ~= 0 or self._max == self._GCD then
		return
	end

	self._max = self:GetNextTimeStamp() - self._reloadStartTime
	self._current = self._current / self._max * self._max

	return
end

function ys.Battle.BattlePlayerWeaponVO:resetCurrent()
	self._current = 0
	self._reloadStartTime = self._jammingStarTime or pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function ys.Battle.BattlePlayerWeaponVO.SetMax(arg_16_0, arg_16_1)
	arg_16_0._max = arg_16_1

	return
end

function ys.Battle.BattlePlayerWeaponVO:GetMax()
	return self._max
end

function ys.Battle.BattlePlayerWeaponVO:GetCurrent()
	return self._current
end

function ys.Battle.BattlePlayerWeaponVO:IsOverLoad()
	return self._current < self._max or self._count < 1
end

function ys.Battle.BattlePlayerWeaponVO.SetTotal(arg_20_0, arg_20_1)
	arg_20_0._total = arg_20_1

	return
end

function ys.Battle.BattlePlayerWeaponVO:GetTotal()
	return self._total
end

function ys.Battle.BattlePlayerWeaponVO.SetCount(arg_22_0, arg_22_1)
	arg_22_0._count = arg_22_1

	return
end

function ys.Battle.BattlePlayerWeaponVO:GetCount()
	return self._count
end

function ys.Battle.BattlePlayerWeaponVO:GetNextTimeStamp()
	local var_24_0

	if #self._chargingList > 0 then
		var_24_0 = self._chargingList[1]
		tiemStampB = self._chargingList[1]:GetReloadFinishTimeStamp()

		for iter_24_0, iter_24_1 in ipairs(self._chargingList) do
			local var_24_1 = iter_24_1:GetReloadFinishTimeStamp()

			tiemStampB = var_24_0:GetReloadFinishTimeStamp()

			if var_24_1 < tiemStampB then
				var_24_0 = iter_24_1
				tiemStampB = var_24_1
			end
		end
	end

	return tiemStampB, var_24_0
end

function ys.Battle.BattlePlayerWeaponVO:GetCurrentWeapon()
	return self._readyList[1]
end

function ys.Battle.BattlePlayerWeaponVO:GetHeadWeapon()
	return self:GetCurrentWeapon() or self._chargingList[1] or self._overHeatList[1]
end

function ys.Battle.BattlePlayerWeaponVO.GetCurrentWeaponIconIndex(arg_27_0)
	return 0
end

function ys.Battle.BattlePlayerWeaponVO:Plus(arg_28_1)
	self._count = self._count + 1

	self:DispatchCountChange()
	self.deleteElementFromArray(arg_28_1, self._chargingList)

	self._readyList[#self._readyList + 1] = arg_28_1

	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)))
	self:DispatchOverLoadChange(self._count)

	return
end

function ys.Battle.BattlePlayerWeaponVO:Deduct(arg_29_1)
	self:readyToOverheat(arg_29_1)

	if #self._readyList ~= 0 then
		self._max = self._GCD

		self:resetCurrent()
	elseif #self._chargingList ~= 0 then
		self._max = math.max(self._GCD, self:GetNextTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime())

		self:resetCurrent()
	elseif arg_29_1:GetType() == var_0_0.Battle.BattleConst.EquipmentType.DISPOSABLE_TORPEDO then
		-- block empty
	else
		self._current = 0
	end

	self:DispatchOverLoadChange(nil, true)

	return
end

function ys.Battle.BattlePlayerWeaponVO:InitialDeduct(arg_30_1)
	self:readyToOverheat(arg_30_1)
	self:DispatchOverLoadChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO:Charge(arg_31_1)
	self.deleteElementFromArray(arg_31_1, self._overHeatList)

	self._chargingList[#self._chargingList + 1] = arg_31_1

	table.sort(self._chargingList, function(arg_32_0, arg_32_1)
		return arg_32_0:GetReloadFinishTimeStamp() < arg_32_1:GetReloadFinishTimeStamp()
	end)

	if #self._readyList == 0 then
		self._max = math.max(self._GCD, self:GetNextTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime())

		self:resetCurrent()
	end

	self:DispatchCountChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO:ReloadBoost(arg_33_1, arg_33_2)
	local var_33_0, var_33_1 = self:GetNextTimeStamp()

	arg_33_1:ReloadBoost(arg_33_2)

	local var_33_2, var_33_3 = self:GetNextTimeStamp()

	if var_33_1 ~= arg_33_1 and var_33_3 ~= arg_33_1 then
		-- block empty
	elseif var_33_1 == arg_33_1 and var_33_3 == arg_33_1 then
		self:RefreshReloadingBar()
	elseif var_33_1 ~= var_33_3 then
		self:RefreshReloadingBar()
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO:InstantCoolDown(arg_34_1)
	self.deleteElementFromArray(arg_34_1, self._overHeatList)

	if self._current >= self._GCD then
		self._current = self._max
		self._reloadStartTime = nil
	else
		self._max = self._GCD - self._current

		self:resetCurrent()
	end

	self:Plus(arg_34_1)

	return
end

function ys.Battle.BattlePlayerWeaponVO:DispatchBlink(arg_35_1)
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.WEAPON_BUTTON_BLINK, {
		value = arg_35_1
	})))

	return
end

function ys.Battle.BattlePlayerWeaponVO:DispatchTotalChange(arg_36_1)
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE, {
		index = arg_36_1
	})))

	return
end

function ys.Battle.BattlePlayerWeaponVO:DispatchOverLoadChange(arg_37_1, arg_37_2)
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.OVER_LOAD_CHANGE, {
		preCast = arg_37_1,
		postCast = arg_37_2
	})))

	return
end

function ys.Battle.BattlePlayerWeaponVO:DispatchCountChange()
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.COUNT_CHANGE)))

	return
end

function ys.Battle.BattlePlayerWeaponVO:DispatchInitSubIcon()
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.INIT_SUB_ICON)))

	return
end

function ys.Battle.BattlePlayerWeaponVO:StartJamming()
	self._jammingStarTime = pg.TimeMgr.GetInstance():GetCombatTime()

	for iter_40_0, iter_40_1 in ipairs(self._chargingList) do
		iter_40_1:StartJamming()
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO:JammingEliminate()
	for iter_41_0, iter_41_1 in ipairs(self._chargingList) do
		iter_41_1:JammingEliminate()
	end

	if self._reloadStartTime then
		local var_41_0 = pg.TimeMgr.GetInstance():GetCombatTime()

		self._max = #self._readyList ~= 0 and self._GCD or self:GetNextTimeStamp() - var_41_0 + self._current
		self._reloadStartTime = self._reloadStartTime + (var_41_0 - self._jammingStarTime)
	end

	self._jammingStarTime = nil

	return
end

function ys.Battle.BattlePlayerWeaponVO:Dispose()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._focusTimer)

	self._focusTimer = nil

	var_0_0.EventDispatcher.DetachEventDispatcher(self)

	return
end

function ys.Battle.BattlePlayerWeaponVO:readyToOverheat(arg_43_1)
	self.deleteElementFromArray(arg_43_1, self._readyList)

	self._overHeatList[#self._overHeatList + 1] = arg_43_1
	self._count = self._count - 1

	if self._count < 0 then
		self._count = 0
	end

	self:DispatchCountChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO.deleteElementFromArray(arg_44_0, arg_44_1)
	local var_44_0

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		if arg_44_0 == iter_44_1 then
			var_44_0 = iter_44_0

			break
		end
	end

	if var_44_0 == nil then
		return -1
	end

	for iter_44_2 = var_44_0, #arg_44_1 do
		arg_44_1[iter_44_2] = arg_44_1[iter_44_2 + 1] ~= nil and arg_44_1[iter_44_2 + 1] or nil
	end

	return var_44_0
end

return
