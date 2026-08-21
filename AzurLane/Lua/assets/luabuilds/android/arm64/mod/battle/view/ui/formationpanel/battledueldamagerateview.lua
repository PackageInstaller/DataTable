ys = ys or {}

local var_0_0 = ys.Battle.BattleEvent
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = class("BattleDuelDamageRateView")

ys.Battle.BattleDuelDamageRateView = var_0_2
var_0_2.__name = "BattleDuelDamageRateView"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._progressList = {}
	arg_1_0._rateBarList = {}
	arg_1_0._fleetList = {}
	arg_1_0._rateBarList[var_0_1.FRIENDLY_CODE] = arg_1_0._tf:Find("leftDamageBar")
	arg_1_0._rateBarList[var_0_1.FOE_CODE] = arg_1_0._tf:Find("rightDamageBar")

	return
end

function var_0_2.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0._go, arg_2_1)

	return
end

function var_0_2.SetFleetVO(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._fleetList[arg_3_1] = true

	local var_3_0 = arg_3_0._rateBarList[arg_3_1:GetIFF()]

	var_3_0:Find("nameText"):GetComponent(typeof(Text)).text = arg_3_2.name
	var_3_0:Find("LVText"):GetComponent(typeof(Text)).text = "Lv." .. arg_3_2.level
	arg_3_0._progressList[arg_3_1:GetIFF()] = var_3_0:Find("bar/progress"):GetComponent(typeof(Image))

	arg_3_1:RegisterEventListener(arg_3_0, var_0_0.FLEET_DMG_CHANGE, arg_3_0.onDMGChange)

	return
end

function var_0_2.onDMGChange(arg_4_0, arg_4_1)
	arg_4_0._progressList[arg_4_1.Dispatcher:GetIFF()].fillAmount = arg_4_1.Dispatcher:GetDamageRatio()

	return
end

function var_0_2.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._fleetList) do
		iter_5_0:UnregisterEventListener(arg_5_0, var_0_0.FLEET_DMG_CHANGE)
	end

	arg_5_0._rateBarList = nil
	arg_5_0._progressList = nil

	return
end

return
