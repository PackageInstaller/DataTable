ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.CardPuzzleCommonHPBar = var_0_10003("CardPuzzleCommonHPBar")

local var_0_3 = var_0.Battle.CardPuzzleCommonHPBar

var_0_3.__name = "CardPuzzleCommonHPBar"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._hpTF = var_2.Find(var_1_0, "fleetBlood/blood")

	local var_1_1 = arg_1_0._hpTF
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0._hpProgress = var_1_2(var_1_1, var_4(var_1_10005))

	return
end

function var_0_3.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1

	return
end

function var_0_3.Update(arg_3_0)
	arg_3_0:updateHPBar()

	return
end

function var_0_3.updateHPBar(arg_4_0)
	local var_4_0 = arg_4_0._info
	local var_4_1 = var_1.GetCurrentCommonHP(var_4_0)
	local var_4_2 = arg_4_0._info
	local var_4_3 = var_4_1 / var_2.GetTotalCommonHP(var_4_2)

	arg_4_0._hpProgress.fillAmount = var_4_3

	return
end

function var_0_3.Dispose(arg_5_0)
	arg_5_0._hpProgress = nil
	arg_5_0._hpTF = nil
	arg_5_0._tf = nil
	arg_5_0._go = nil

	return
end

function var_0_3.updateResource(arg_6_0)
	return
end

return
