function FinishCook(arg_1_0, arg_1_1)
	if arg_1_0 == SummerPubConst.COOK_LAST_STAGE then
		SummerPubAction.FinishCook(arg_1_0, SummerPubConst.COOK_STATE.VIEW_CG)
	else
		SummerPubAction.FinishCook(arg_1_0, arg_1_1)
	end
end

function GetCookCfg(arg_2_0)
	return SummerPubCookCfg[arg_2_0]
end

function SetCookingWindowBar(arg_3_0)
	if arg_3_0 then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({})
	end
end
