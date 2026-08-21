local var_0_0 = class("ChallengeRogueTeamBagBuffItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.timeController_ = arg_1_0.controller_:GetController("time")
	arg_1_0.leftTimesController_ = arg_1_0.controller_:GetController("leftTimes")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.data_ = arg_3_2
	arg_3_0.cfg_ = RogueTeamItemCfg[arg_3_2.id]
	arg_3_0.nameText_.text = arg_3_0.cfg_.name
	arg_3_0.descText_.text = ChallengeRogueTeamTools.GetItemEffectDesc(arg_3_2.id)
	arg_3_0.effectData = ChallengeRogueTeamData:GetEffectDataByEffectID(arg_3_0.data_.effectList[1])

	arg_3_0.timeController_:SetSelectedState(tostring(arg_3_0.effectData.triggerCd and arg_3_0.effectData.triggerCd ~= 0))

	arg_3_0.timeText_.text = arg_3_0.effectData.triggerCd

	arg_3_0.leftTimesController_:SetSelectedState(tostring(arg_3_0.effectData.leftTime and arg_3_0.effectData.leftTime ~= 9999))

	arg_3_0.leftTimesText_.text = arg_3_0.effectData.leftTime
	arg_3_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_3_2.id))
end

return var_0_0
