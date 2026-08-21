local var_0_0 = class("LanternRiddlesController")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.model = LanternRiddlesModel.New(arg_1_0)
	arg_1_0.view = LanternRiddlesView.New(arg_1_0)

	return
end

function var_0_0.SetCallBack(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.exitCallback = arg_2_1
	arg_2_0.onHome = arg_2_2
	arg_2_0.onSuccess = arg_2_3
	arg_2_0.onSaveData = arg_2_4

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	arg_3_0.model:UpdateData(arg_3_1)
	arg_3_0.view:UpdateDay(arg_3_0.model.finishCount)
	arg_3_0.view:InitLanternRiddles((arg_3_0.model:GetQuestiones()))

	return
end

function var_0_0.SelectAnswer(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = false

	if arg_4_0.model:IsRight(arg_4_1, arg_4_2) then
		var_4_0 = true

		arg_4_0.model:UpdateRightAnswerFlag(arg_4_1)

		if arg_4_0.onSuccess then
			arg_4_0.onSuccess()
		end

		arg_4_0.view:UpdateDay(arg_4_0.model.finishCount)

		if arg_4_0.model.unlockCount <= 0 then
			arg_4_0.view:RefreshLanterRiddles(arg_4_0.model.questiones)
		end
	else
		arg_4_0.model:UpdateWrongAnswerFlag(arg_4_1, arg_4_2)
	end

	if arg_4_0.onSaveData then
		arg_4_0.onSaveData()
	end

	arg_4_0.view:OnUpdateAnswer(arg_4_0.model:GetQuestion(arg_4_1), arg_4_2, var_4_0)

	return
end

function var_0_0.GetLockTime(arg_5_0)
	return arg_5_0.model:GetLockTime()
end

function var_0_0.ExitGame(arg_6_0)
	if arg_6_0.exitCallback then
		arg_6_0.exitCallback()
	end

	return
end

function var_0_0.ExitGameAndGoHome(arg_7_0)
	if arg_7_0.onHome then
		arg_7_0.onHome()
	end

	return
end

function var_0_0.GetSaveData(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.model.questiones) do
		table.insert({}, iter_8_1.nextTime)
	end

	table.insert({}, arg_8_0.model.lockTime)

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.model.finishList) do
		local var_8_0

		if arg_8_0.model.finishCount > 0 then
			table.insert({}, iter_8_3)

			var_8_0 = arg_8_0.model.finishCount - 1
		end
	end

	return {}
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.model:Dispose()
	arg_9_0.view:Dispose()

	return
end

return var_0_0
