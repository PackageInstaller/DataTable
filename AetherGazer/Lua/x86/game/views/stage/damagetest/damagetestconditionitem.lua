local var_0_0 = class("DamageTestConditionItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.chooseConditionHandler_ = handler(arg_1_0, arg_1_0.ChooseCondition)

	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_CONDITION, arg_1_0.chooseConditionHandler_)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_CONDITION, arg_2_0.chooseConditionHandler_)

	arg_2_0.chooseConditionHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		DamageTestData:SetSelectAffix(arg_3_0.damageTestId_, arg_3_0.itemType_, arg_3_0.id_)
		manager.notify:Invoke(BOSS_CHALLENGE_CHOOSE_CONDITION, {
			itemType = arg_3_0.itemType_,
			id = arg_3_0.id_
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.damageTestId_ = arg_5_1
	arg_5_0.itemType_ = arg_5_2
	arg_5_0.id_ = arg_5_3

	if arg_5_0.itemType_ == BossConst.TYPE_STAGE then
		local var_5_0 = StageChallengeConditionPoolCfg[arg_5_3]

		arg_5_0.descText_.text = BattleInstance.GetStarMissionText(var_5_0.condition[1], var_5_0.condition[2], var_5_0.condition[3])
		arg_5_0.pointText_.text = var_5_0.point
	else
		local var_5_1 = ActivityAffixPoolCfg[arg_5_3]

		arg_5_0.descText_.text = getAffixDesc(var_5_1.affix)
		arg_5_0.pointText_.text = var_5_1.point
	end

	arg_5_0:ChooseCondition({
		itemType = arg_5_2,
		id = arg_5_3
	})
end

function var_0_0.ChooseCondition(arg_6_0, arg_6_1)
	arg_6_0:RefreshMutex(arg_6_1)
end

function var_0_0.RefreshMutex(arg_7_0, arg_7_1)
	if arg_7_0.itemType_ == arg_7_1.itemType then
		if arg_7_0.itemType_ == BossConst.TYPE_STAGE then
			arg_7_0:RefreshMutexStage()
		else
			arg_7_0:RefreshMutexAffix()
		end
	end
end

function var_0_0.RefreshMutexStage(arg_8_0)
	local var_8_0 = StageChallengeConditionPoolCfg[arg_8_0.id_]
	local var_8_1 = DamageTestData:GetAffixList(arg_8_0.damageTestId_, arg_8_0.itemType_)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if arg_8_0.id_ ~= iter_8_1 and var_8_0 and var_8_0.condition[1] == StageChallengeConditionPoolCfg[iter_8_1].condition[1] then
			arg_8_0.controller_:SetSelectedState("not")

			return
		elseif arg_8_0.id_ == iter_8_1 then
			arg_8_0.controller_:SetSelectedState("true")

			return
		end
	end

	arg_8_0.controller_:SetSelectedState("false")
end

function var_0_0.RefreshMutexAffix(arg_9_0)
	local var_9_0 = ActivityAffixPoolCfg[arg_9_0.id_]
	local var_9_1 = DamageTestData:GetAffixList(arg_9_0.damageTestId_, arg_9_0.itemType_)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if arg_9_0.id_ ~= iter_9_1 and var_9_0 and var_9_0.affix[1] == ActivityAffixPoolCfg[iter_9_1].affix[1] then
			arg_9_0.controller_:SetSelectedState("not")

			return
		elseif arg_9_0.id_ == iter_9_1 then
			arg_9_0.controller_:SetSelectedState("true")

			return
		end
	end

	arg_9_0.controller_:SetSelectedState("false")
end

return var_0_0
