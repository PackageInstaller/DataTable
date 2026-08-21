local var_0_0 = class("LanternRiddlesModel")
local var_0_1 = pg.activity_event_question

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.questiones = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1.all) do
		table.insert(arg_2_0.questiones, (arg_2_0:WrapQuestion(var_0_1[iter_2_1], (arg_2_0:GetNextTime(iter_2_0)))))
	end

	return
end

function var_0_0.WrapQuestion(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetAnswerFlag(arg_3_1.id, {
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
	})

	shuffle(var_3_0)

	local var_3_1 = math.random(1, 4)

	table.insert(var_3_0, var_3_1, {
		arg_3_1.answer_right,
		false
	})

	local var_3_2 = arg_3_0:IsFinishQuestion(arg_3_1.id)

	return {
		id = arg_3_1.id,
		type = arg_3_1.type,
		rightIndex = var_3_1,
		answers = var_3_0,
		text = arg_3_1.question,
		nextTime = arg_3_2 or 0,
		waitTime = arg_3_1.wrong_time,
		isFinish = var_3_2,
		isUnlock = arg_3_0.unlockCount > 0 or var_3_2
	}
end

function var_0_0.IsFinishQuestion(arg_4_0, arg_4_1)
	return table.contains(arg_4_0.finishList, arg_4_1)
end

function var_0_0.GetNextTime(arg_5_0, arg_5_1)
	return arg_5_0.nextTimes[arg_5_1] or 0
end

function var_0_0.SetNextTime(arg_6_0, arg_6_1)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.questiones) do
		if iter_6_1.id == arg_6_1 then
			local var_6_1 = pg.TimeMgr.GetInstance()

			iter_6_1.nextTime = var_6_1:GetServerTime() + iter_6_1.waitTime
			var_6_0 = iter_6_1.waitTime

			break
		end
	end

	local var_6_2 = pg.TimeMgr.GetInstance()

	arg_6_0.lockTime = var_6_2:GetServerTime() + var_6_0

	return
end

function var_0_0.GetLockTime(arg_7_0)
	return arg_7_0.lockTime
end

function var_0_0.GetAnswerFlag(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = getProxy(PlayerProxy):getRawData().id

	local function var_8_1(arg_9_0, arg_9_1)
		return PlayerPrefs.GetInt(arg_9_0 .. "_" .. arg_9_1 .. "_" .. var_8_0, 0) > 0
	end

	return _.map(arg_8_2, function(arg_10_0)
		return {
			arg_10_0[1],
			(var_8_1(arg_8_1, arg_10_0[1]))
		}
	end)
end

function var_0_0.SetAnswerFlag(arg_11_0, arg_11_1, arg_11_2)
	PlayerPrefs.SetInt(arg_11_1 .. "_" .. arg_11_2 .. "_" .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.questiones) do
		if iter_11_1.id == arg_11_1 then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.answers) do
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
	arg_12_0:SetAnswerFlag(arg_12_1, _.detect(arg_12_0.questiones, function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end).answers[arg_12_2][1])
	arg_12_0:SetNextTime(arg_12_1)

	return
end

function var_0_0.UpdateRightAnswerFlag(arg_14_0, arg_14_1)
	if not table.contains(arg_14_0.finishList, arg_14_1) then
		table.insert(arg_14_0.finishList, arg_14_1)

		arg_14_0.finishCount = arg_14_0.finishCount + 1
	end

	arg_14_0:GetQuestion(arg_14_1).isFinish = true
	arg_14_0.unlockCount = arg_14_0.unlockCount - 1

	if arg_14_0.unlockCount <= 0 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.questiones) do
			if not iter_14_1.isFinish then
				iter_14_1.isUnlock = false
			end
		end
	end

	return
end

function var_0_0.UpdateData(arg_15_0, arg_15_1)
	arg_15_0.finishCount = arg_15_1.finishCount or 0
	arg_15_0.unlockCount = arg_15_1.unlockCount or 0
	arg_15_0.nextTimes = arg_15_1.nextTimes
	arg_15_0.finishList = arg_15_1.finishList
	arg_15_0.lockTime = arg_15_0.nextTimes[#arg_15_0.nextTimes]

	arg_15_0:Init()

	return
end

function var_0_0.IsRight(arg_16_0, arg_16_1, arg_16_2)
	return _.any(arg_16_0.questiones, function(arg_17_0)
		return arg_16_1 == arg_17_0.id and arg_17_0.rightIndex == arg_16_2
	end)
end

function var_0_0.GetQuestiones(arg_18_0)
	return arg_18_0.questiones
end

function var_0_0.GetQuestion(arg_19_0, arg_19_1)
	return _.detect(arg_19_0.questiones, function(arg_20_0)
		return arg_20_0.id == arg_19_1
	end)
end

function var_0_0.Dispose(arg_21_0)
	return
end

return var_0_0
