ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleConfig
local BattleDuelDamageRateView = class("BattleDuelDamageRateView")

ys.Battle.BattleDuelDamageRateView = BattleDuelDamageRateView
BattleDuelDamageRateView.__name = "BattleDuelDamageRateView"

function BattleDuelDamageRateView:Ctor(arg_1_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._progressList = {}
	self._rateBarList = {}
	self._fleetList = {}
	self._rateBarList[var_0_2.FRIENDLY_CODE] = self._tf:Find("leftDamageBar")
	self._rateBarList[var_0_2.FOE_CODE] = self._tf:Find("rightDamageBar")

	return
end

function BattleDuelDamageRateView:SetActive(arg_2_1)
	setActive(self._go, arg_2_1)

	return
end

function BattleDuelDamageRateView:SetFleetVO(arg_3_1, arg_3_2)
	self._fleetList[arg_3_1] = true

	local var_3_0 = self._rateBarList[arg_3_1:GetIFF()]

	var_3_0:Find("nameText"):GetComponent(typeof(Text)).text = arg_3_2.name
	var_3_0:Find("LVText"):GetComponent(typeof(Text)).text = "Lv." .. arg_3_2.level
	self._progressList[arg_3_1:GetIFF()] = var_3_0:Find("bar/progress"):GetComponent(typeof(Image))

	arg_3_1:RegisterEventListener(self, var_0_1.FLEET_DMG_CHANGE, self.onDMGChange)

	return
end

function BattleDuelDamageRateView:onDMGChange(arg_4_1)
	self._progressList[arg_4_1.Dispatcher:GetIFF()].fillAmount = arg_4_1.Dispatcher:GetDamageRatio()

	return
end

function BattleDuelDamageRateView:Dispose()
	for iter_5_0, iter_5_1 in pairs(self._fleetList) do
		iter_5_0:UnregisterEventListener(self, var_0_1.FLEET_DMG_CHANGE)
	end

	self._rateBarList = nil
	self._progressList = nil

	return
end

return
