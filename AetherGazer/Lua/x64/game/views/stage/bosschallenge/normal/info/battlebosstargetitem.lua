local var_0_0 = class("BattleBossTargetItem", SectionTargetItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Refresh(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 then
		SetActive(arg_2_0.activeImage_, true)

		arg_2_0.targetText_.color = Color(0.8392158, 0.8627452, 0.882353)
	else
		SetActive(arg_2_0.activeImage_, false)

		arg_2_0.targetText_.color = Color(0.63, 0.63, 0.63)
	end

	arg_2_0.starCfg = arg_2_2

	if arg_2_0.starCfg then
		arg_2_0.targetText_.text = BattleInstance.GetStarMissionText(arg_2_0.starCfg[1], arg_2_0.starCfg[2], arg_2_0.starCfg[3])

		SetActive(arg_2_0.gameObject_, true)
	else
		SetActive(arg_2_0.gameObject_, false)
	end
end

return var_0_0
