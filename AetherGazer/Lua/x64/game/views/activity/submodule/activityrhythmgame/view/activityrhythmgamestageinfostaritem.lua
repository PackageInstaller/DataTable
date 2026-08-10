local var_0_0 = class("ActivityRhythmGameStageInfoStarItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controllerStar_ = arg_1_0.ndnum01Controllerexcollection_:GetController("star")
end

function var_0_0.Refresh(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 then
		arg_2_0.controllerStar_:SetSelectedIndex(1)
	else
		arg_2_0.controllerStar_:SetSelectedIndex(0)
	end

	if arg_2_2 then
		arg_2_0.textmeettermsText_.text = BattleInstance.GetStarMissionText(arg_2_2[1], arg_2_2[2], arg_2_2[3])

		SetActive(arg_2_0.gameObject_, true)
	else
		SetActive(arg_2_0.gameObject_, false)
	end
end

return var_0_0
