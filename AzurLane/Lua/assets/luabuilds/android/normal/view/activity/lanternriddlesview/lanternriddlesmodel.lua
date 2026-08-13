class = var_0_10000

local var_0_0 = var_0_10000("LanternRiddlesModel")

pg = var_1

local var_0_1 = var_1.activity_event_question

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.questiones = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(var_0_1.all) do
		local var_2_0 = var_0_1[iter_2_1]
		local var_2_1 = arg_2_0:GetNextTime(iter_2_0)
		local var_2_2 = arg_2_0
		local var_2_3 = arg_2_0.WrapQuestion(var_2_2, var_2_0, var_2_1)

		table = var_2_2

		var_2_2.insert(arg_2_0.questiones, var_2_3)
	end

	return
end

function var_0_0.WrapQuestion(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		{
			arg_3_1.answer_false1,
			false
		},
		{
			arg_3_1.answer_false2,
			false
		},
		{
			arg_3_1.answer_false3,
			false
		}
	}
	local var_3_1 = arg_3_0:GetAnswerFlag(arg_3_1.id, var_3_0)

	shuffle = var_4

	var_4(var_3_1)

	math = var_4

	local var_3_2 = var_4.random(1, 4)

	table = var_5

	var_5.insert(var_3_1, var_3_2, {
		arg_3_1.answer_right,
		false
	})

	local var_3_3 = arg_3_0:IsFinishQuestion(arg_3_1.id)
	local var_3_4 = arg_3_0.unlockCount > 0 or var_3_3

	return {
		id = arg_3_1.id,
		type = arg_3_1.type,
		rightIndex = var_3_2,
		answers = var_3_1,
		text = arg_3_1.question,
		nextTime = arg_3_2 or 0,
		waitTime = arg_3_1.wrong_time,
		isFinish = var_3_3,
		isUnlock = var_3_4
	}
end

function var_0_0.IsFinishQuestion(arg_4_0, arg_4_1)
	table = var_1_10002

	return var_1_10002.contains(arg_4_0.finishList, arg_4_1)
end

function var_0_0.GetNextTime(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.nextTimes[arg_5_1] then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_0.SetNextTime(arg_6_0, arg_6_1)
	local var_6_0 = 0

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.questiones) do
		if iter_6_1.id == arg_6_1 then
			pg = var_8

			local var_6_1 = var_8.TimeMgr.GetInstance()

			iter_6_1.nextTime = var_8.GetServerTime(var_6_1) + iter_6_1.waitTime
			var_6_0 = iter_6_1.waitTime

			break
		end
	end

	pg = var_3

	local var_6_2 = var_3.TimeMgr.GetInstance()

	arg_6_0.lockTime = var_3.GetServerTime(var_6_2) + var_6_0

	return
end

function var_0_0.GetLockTime(arg_7_0)
	return arg_7_0.lockTime
end

function var_0_0.GetAnswerFlag(arg_8_0, arg_8_1, arg_8_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_8_0 = var_1_10003(var_1_10004)
	local var_8_1 = var_3.getRawData(var_8_0).id

	local function var_8_2(arg_9_0, arg_9_1)
		PlayerPrefs = var_2_10002

		return var_2_10002.GetInt(arg_9_0 .. "_" .. arg_9_1 .. "_" .. var_8_1, 0) > 0
	end

	_ = var_1_10005

	return var_1_10005.map(arg_8_2, function(arg_10_0)
		local var_10_0 = var_8_2(arg_8_1, arg_10_0[1])

		return {
			arg_10_0[1],
			var_10_0
		}
	end)
end

function var_0_0.SetAnswerFlag(arg_11_0, arg_11_1, arg_11_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_11_0 = var_1_10003(var_1_10004)
	local var_11_1 = var_3.getRawData(var_11_0).id

	PlayerPrefs = var_11_0

	var_11_0.SetInt(arg_11_1 .. "_" .. arg_11_2 .. "_" .. var_11_1, 1)

	PlayerPrefs = var_4

	var_4.Save()

	ipairs = var_4

	for iter_11_0, iter_11_1 in var_4(arg_11_0.questiones) do
		if iter_11_1.id == arg_11_1 then
			ipairs = var_9

			for iter_11_2, iter_11_3 in var_9(iter_11_1.answers) do
				if iter_11_3[1] == arg_11_2 then
					iter_11_3[2] = true

					break
				end
			end
		end
	end

	return
end

function var_0_0.UpdateWrongAnswerFlag(arg_12_0, arg_12_1, arg_12_2)
	_ = var_1_10003

	local var_12_0 = var_1_10003.detect(arg_12_0.questiones, function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end).answers[arg_12_2]

	arg_12_0:SetAnswerFlag(arg_12_1, var_12_0[1])
	arg_12_0:SetNextTime(arg_12_1)

	return
end

function var_0_0.UpdateRightAnswerFlag(arg_14_0, arg_14_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_14_0.finishList, arg_14_1) then
		table = var_2

		var_2.insert(arg_14_0.finishList, arg_14_1)

		arg_14_0.finishCount = arg_14_0.finishCount + 1
	end

	arg_14_0:GetQuestion(arg_14_1).isFinish = true
	arg_14_0.unlockCount = arg_14_0.unlockCount - 1

	if arg_14_0.unlockCount <= 0 then
		ipairs = var_3

		for iter_14_0, iter_14_1 in var_3(arg_14_0.questiones) do
			if not iter_14_1.isFinish then
				iter_14_1.isUnlock = false
			end
		end
	end

	return
end

function var_0_0.UpdateData(arg_15_0, arg_15_1)
	local var_15_0

	if not arg_15_1.finishCount then
		var_15_0 = 0
	end

	arg_15_0.finishCount = var_15_0

	local var_15_1

	if not arg_15_1.unlockCount then
		var_15_1 = 0
	end

	arg_15_0.unlockCount = var_15_1
	arg_15_0.nextTimes = arg_15_1.nextTimes
	arg_15_0.finishList = arg_15_1.finishList
	arg_15_0.lockTime = arg_15_0.nextTimes[#arg_15_0.nextTimes]

	arg_15_0:Init()

	return
end

function var_0_0.IsRight(arg_16_0, arg_16_1, arg_16_2)
	_ = var_1_10003

	return var_1_10003.any(arg_16_0.questiones, function(arg_17_0)
		return arg_16_1 == arg_17_0.id and arg_17_0.rightIndex == arg_16_2
	end)
end

function var_0_0.GetQuestiones(arg_18_0)
	return arg_18_0.questiones
end

function var_0_0.GetQuestion(arg_19_0, arg_19_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_19_0.questiones, function(arg_20_0)
		return arg_20_0.id == arg_19_1
	end)
end

function var_0_0.Dispose(arg_21_0)
	return
end

return var_0_0
