ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSubmarineFuncButton", var_0.Battle.BattleWeaponButton)

var_0.Battle.BattleSubmarineFuncButton = var_0_1
var_0_1.__name = "BattleSubmarineFuncButton"

function var_0_1.Ctor(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0.eventTriggers = {}

	return
end

function var_0_1.OnfilledEffect(arg_2_0)
	SetActive = var_1_10001

	var_1_10001(arg_2_0._filledEffect, true)

	return
end

function var_0_1.SetProgressInfo(arg_3_0, arg_3_1)
	arg_3_0._progressInfo = arg_3_1

	local var_3_0 = arg_3_0._progressInfo

	var_2.RegisterEventListener(var_3_0, arg_3_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS, arg_3_0.OnfilledEffect)

	local var_3_1 = arg_3_0._progressInfo

	var_2.RegisterEventListener(var_3_1, arg_3_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE, arg_3_0.OnOverLoadChange)
	arg_3_0:OnOverLoadChange()
	arg_3_0:SetControllerActive(true)

	return
end

function var_0_1.Update(arg_4_0)
	local var_4_0 = arg_4_0._progressInfo
	local var_4_1 = var_1.GetCurrent(var_4_0)
	local var_4_2 = arg_4_0._progressInfo

	if var_4_1 < var_2.GetMax(var_4_2) then
		arg_4_0:updateProgressBar()
	end

	return
end

function var_0_1.Dispose(arg_5_0)
	if arg_5_0.eventTriggers then
		pairs = var_1

		for iter_5_0, iter_5_1 in var_1(arg_5_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_5_0)
		end

		arg_5_0.eventTriggers = nil
	end

	arg_5_0._progress = nil
	arg_5_0._progressBar = nil

	local var_5_0 = arg_5_0._progressInfo

	var_1.UnregisterEventListener(var_5_0, arg_5_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE)

	local var_5_1 = arg_5_0._progressInfo

	var_1.UnregisterEventListener(var_5_1, arg_5_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)
	var_0.EventListener.DetachEventListener(arg_5_0)

	return
end

return
