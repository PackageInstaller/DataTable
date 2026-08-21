local var_0_0 = class("BilliardGameSkillTipModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.typeController_ = arg_2_0.tipsCon_:GetController("type")
	arg_2_0.combineController_ = arg_2_0.tipsCon_:GetController("combine")
	arg_2_0.buffItem1 = BilliardGameBigBuffItemView.New(arg_2_0.skill_1)
	arg_2_0.buffItem2 = BilliardGameBigBuffItemView.New(arg_2_0.skill_2)
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.isCombine_ = arg_4_1.isCombine_
	arg_4_0.mainSkillId = arg_4_1.mainBuffId

	arg_4_0.combineController_:SetSelectedState(arg_4_0.isCombine_ and "show" or "hide")

	if arg_4_0.isCombine_ then
		local var_4_0 = arg_4_1.buffIdList[2]

		arg_4_0.typeController_:SetSelectedState("ActiveBuff")

		local var_4_1 = MergeBallBuffCfg[arg_4_0.mainSkillId]
		local var_4_2 = MergeBallBuffCfg[var_4_0]

		arg_4_0.buffNameText_.text = string.format("%s X %s", var_4_1.name, var_4_2.name)

		if var_4_1.merge_weight == var_4_2.merge_weight or var_4_1.merge_weight == 0 or var_4_2.merge_weight == 0 then
			arg_4_0.combinationText_.text = GetTips("MERGE_BALL_COMBINE_TIP_BLANK")
		else
			arg_4_0.combinationText_.text = string.format(GetTips("MERGE_BALL_COMBINE_TIP"), var_4_1.combine_text1, var_4_2.combine_text2)
		end

		arg_4_0.labelText_1.text = GetTips("MERGE_BALL_TAG_" .. var_4_1.tag[1])
		arg_4_0.labelText_2.text = GetTips("MERGE_BALL_TAG_" .. var_4_2.tag[1])

		arg_4_0.buffItem1:IsShowName(true)
		arg_4_0.buffItem2:IsShowName(true)
		arg_4_0.buffItem1:SetData(arg_4_0.mainSkillId, arg_4_1.level, true)
		arg_4_0.buffItem2:SetData(var_4_0, arg_4_1.level, true)
	else
		arg_4_0:SetOneBuffData(arg_4_0.mainSkillId, arg_4_1.level)
	end
end

function var_0_0.SetOneBuffData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.mainSkillId = arg_5_1

	local var_5_0 = MergeBallBuffCfg[arg_5_0.mainSkillId]

	arg_5_0.typeController_:SetSelectedState(var_5_0.type == BilliardGameConst.MergeBallBuffType.PASSIVE and "PassiveBuff" or "ActiveBuff")

	local var_5_1 = VehicleBallData:IsBuffUnlocked(arg_5_1)

	arg_5_0.buffNameText_.text = var_5_1 and var_5_0.name or "???"
	arg_5_0.labelText_1.text = var_5_1 and GetTips("MERGE_BALL_TAG_" .. var_5_0.tag[1]) or "???"

	arg_5_0.buffItem1:IsShowName(false)
	arg_5_0.buffItem1:SetData(arg_5_0.mainSkillId, arg_5_2)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.buffItem1:Dispose()
	arg_6_0.buffItem2:Dispose()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
