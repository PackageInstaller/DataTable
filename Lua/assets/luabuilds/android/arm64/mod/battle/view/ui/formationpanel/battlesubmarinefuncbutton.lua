ys = ys or {}

local var_0_0 = class("BattleSubmarineFuncButton", ys.Battle.BattleWeaponButton)

ys.Battle.BattleSubmarineFuncButton = var_0_0
var_0_0.__name = "BattleSubmarineFuncButton"

function var_0_0.Ctor(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0.eventTriggers = {}

	return
end

function var_0_0.OnfilledEffect(arg_2_0)
	SetActive(arg_2_0._filledEffect, true)

	return
end

function var_0_0.SetProgressInfo(arg_3_0, arg_3_1)
	arg_3_0._progressInfo = arg_3_1

	arg_3_0._progressInfo:RegisterEventListener(arg_3_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS, arg_3_0.OnfilledEffect)
	arg_3_0._progressInfo:RegisterEventListener(arg_3_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE, arg_3_0.OnOverLoadChange)
	arg_3_0:OnOverLoadChange()
	arg_3_0:SetControllerActive(true)

	return
end

function var_0_0.Update(arg_4_0)
	if arg_4_0._progressInfo:GetCurrent() < arg_4_0._progressInfo:GetMax() then
		arg_4_0:updateProgressBar()
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.eventTriggers then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.eventTriggers) do
			ClearEventTrigger(iter_5_0)
		end

		arg_5_0.eventTriggers = nil
	end

	arg_5_0._progress = nil
	arg_5_0._progressBar = nil

	arg_5_0._progressInfo:UnregisterEventListener(arg_5_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE)
	arg_5_0._progressInfo:UnregisterEventListener(arg_5_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)
	var_0.EventListener.DetachEventListener(arg_5_0)

	return
end

return
