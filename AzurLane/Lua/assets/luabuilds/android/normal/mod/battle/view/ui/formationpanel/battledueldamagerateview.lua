ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleDuelDamageRateView")

var_0.Battle.BattleDuelDamageRateView = var_0_3
var_0_3.__name = "BattleDuelDamageRateView"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._progressList = {}
	arg_1_0._rateBarList = {}
	arg_1_0._fleetList = {}

	local var_1_0 = arg_1_0._rateBarList
	local var_1_1 = var_0_2.FRIENDLY_CODE
	local var_1_2 = arg_1_0._tf

	var_1_0[var_1_1] = var_4.Find(var_1_2, "leftDamageBar")

	local var_1_3 = arg_1_0._rateBarList
	local var_1_4 = var_0_2.FOE_CODE
	local var_1_5 = arg_1_0._tf

	var_1_3[var_1_4] = var_4.Find(var_1_5, "rightDamageBar")

	return
end

function var_0_3.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._go, arg_2_1)

	return
end

function var_0_3.SetFleetVO(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._fleetList[arg_3_1] = true

	local var_3_0 = arg_3_0._rateBarList[arg_3_1:GetIFF()]
	local var_3_1 = var_3.Find(var_3_0, "nameText")
	local var_3_2 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	var_3_2(var_3_1, var_6(var_1_10007)).text = arg_3_2.name

	local var_3_3 = var_3:Find("LVText")
	local var_3_4 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	var_3_4(var_3_3, var_6(var_1_10007)).text = "Lv." .. arg_3_2.level

	local var_3_5 = var_3:Find("bar/progress")
	local var_3_6 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_3_7 = var_3_6(var_3_5, var_6(var_1_10007))

	arg_3_0._progressList[arg_3_1:GetIFF()] = var_3_7

	arg_3_1:RegisterEventListener(arg_3_0, var_0_1.FLEET_DMG_CHANGE, arg_3_0.onDMGChange)

	return
end

function var_0_3.onDMGChange(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.Dispatcher
	local var_4_1 = var_2.GetIFF(var_4_0)

	arg_4_0._progressList[var_4_1].fillAmount = var_2:GetDamageRatio()

	return
end

function var_0_3.Dispose(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0._fleetList) do
		iter_5_0:UnregisterEventListener(arg_5_0, var_0_1.FLEET_DMG_CHANGE)
	end

	arg_5_0._rateBarList = nil
	arg_5_0._progressList = nil

	return
end

return
