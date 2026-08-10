local var_0_0 = class("IdolTraineeLevelListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.challengeBtn_, nil, function()
		arg_3_0.timer = Timer.New(handler(arg_3_0, function()
			if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
				JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
					pvpBattle_ = false,
					stageID = arg_3_0.stageID
				})
			end
		end), 0.34, 1):Start()
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.stageID = arg_6_1

	local var_6_0 = IdolTraineePveBattleCfg[arg_6_1]
	local var_6_1 = IdolTraineeTools:GetChapterScoreList(arg_6_3)
	local var_6_2

	if var_6_1 then
		var_6_2 = var_6_1[arg_6_1]
	end

	if not var_6_2 then
		arg_6_0.stateController_:SetSelectedState("lock")
	elseif not var_6_2.pass then
		arg_6_0.stateController_:SetSelectedState("unlock")
	else
		arg_6_0.stateController_:SetSelectedState("complete")

		arg_6_0.score_.text = var_6_2.score
	end

	arg_6_0.levelID_.text = arg_6_3 .. "-" .. arg_6_2
	arg_6_0.levelName_.text = var_6_0.name
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
