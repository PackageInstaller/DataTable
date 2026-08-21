local var_0_0 = class("SPHeroChallengeBossStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = arg_3_0.controller:GetController("state")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = BattleVerthandiExclusiveCfg[arg_4_1]

	arg_4_0.stageID = arg_4_1

	arg_4_0.stateController:SetSelectedState("unlock")

	if arg_4_2 == arg_4_0.stageID then
		arg_4_0.stateController:SetSelectedState("selected")
	end

	if var_4_0 then
		local var_4_1, var_4_2 = SPHeroChallengeTools:CheckStageIsOpen(arg_4_1)

		arg_4_0.bossnameText_.text = var_4_0.name

		if var_4_1 then
			arg_4_0.stateController:SetSelectedState("lock")

			arg_4_0.conditiontextText_.text = var_4_2 or ""
		else
			local var_4_3 = SPHeroChallengeData:GetCurActivityInfo():GetBossScoreInfo(arg_4_1)

			if var_4_3 > 0 then
				arg_4_0.recordText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_RECORD"), var_4_3)
			else
				arg_4_0.recordText_.text = GetTips("NO_RECORD")
			end
		end
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bossitemBtn_, nil, function()
		if arg_5_0.stateController:GetSelectedState() == "lock" then
			return
		end

		if arg_5_0.clickFunc then
			arg_5_0.clickFunc(arg_5_0.stageID)
		end
	end)
end

function var_0_0.RegisterClickCallBack(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.clickFunc = arg_7_1
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
