class = var_0_10000

local var_0_0 = var_0_10000("LanternRiddlesController")

function var_0_0.Ctor(arg_1_0)
	LanternRiddlesModel = var_1_10001
	arg_1_0.model = var_1_10001.New(arg_1_0)
	LanternRiddlesView = var_1
	arg_1_0.view = var_1.New(arg_1_0)

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
	local var_3_0 = arg_3_0.model

	var_2.UpdateData(var_3_0, arg_3_1)

	local var_3_1 = arg_3_0.model
	local var_3_2 = var_2.GetQuestiones(var_3_1)
	local var_3_3 = arg_3_0.view

	var_3.UpdateDay(var_3_3, arg_3_0.model.finishCount)

	local var_3_4 = arg_3_0.view

	var_3.InitLanternRiddles(var_3_4, var_3_2)

	return
end

function var_0_0.SelectAnswer(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = false
	local var_4_1 = arg_4_0.model

	if var_4.IsRight(var_4_1, arg_4_1, arg_4_2) then
		var_4_0 = true

		local var_4_2 = arg_4_0.model

		var_4.UpdateRightAnswerFlag(var_4_2, arg_4_1)

		if arg_4_0.onSuccess then
			arg_4_0.onSuccess()
		end

		local var_4_3 = arg_4_0.view

		var_4.UpdateDay(var_4_3, arg_4_0.model.finishCount)

		if arg_4_0.model.unlockCount <= 0 then
			local var_4_4 = arg_4_0.view

			var_4.RefreshLanterRiddles(var_4_4, arg_4_0.model.questiones)
		end
	else
		local var_4_5 = arg_4_0.model

		var_4.UpdateWrongAnswerFlag(var_4_5, arg_4_1, arg_4_2)
	end

	if arg_4_0.onSaveData then
		arg_4_0.onSaveData()
	end

	local var_4_6 = arg_4_0.model
	local var_4_7 = var_4.GetQuestion(var_4_6, arg_4_1)
	local var_4_8 = arg_4_0.view

	var_5.OnUpdateAnswer(var_4_8, var_4_7, arg_4_2, var_4_0)

	return
end

function var_0_0.GetLockTime(arg_5_0)
	local var_5_0 = arg_5_0.model

	return var_1.GetLockTime(var_5_0)
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
	local var_8_0 = {}

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.model.questiones) do
		table = var_1_10007

		var_1_10007.insert(var_8_0, iter_8_1.nextTime)
	end

	table = var_2

	var_2.insert(var_8_0, arg_8_0.model.lockTime)

	local var_8_1 = arg_8_0.model.finishCount

	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(arg_8_0.model.finishList) do
		if 0 < var_8_1 then
			table = var_8

			var_8.insert(var_8_0, iter_8_3)

			var_8_1 = var_8_1 - 1
		end
	end

	return var_8_0
end

function var_0_0.Dispose(arg_9_0)
	local var_9_0 = arg_9_0.model

	var_1.Dispose(var_9_0)

	local var_9_1 = arg_9_0.view

	var_1.Dispose(var_9_1)

	return
end

return var_0_0
