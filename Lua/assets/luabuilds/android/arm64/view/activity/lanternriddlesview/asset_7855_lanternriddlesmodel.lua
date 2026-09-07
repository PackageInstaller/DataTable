local LanternRiddlesModel = class("LanternRiddlesModel")
local var_0_1 = pg.activity_event_question

function LanternRiddlesModel:Ctor(arg_1_1)
	self.controller = arg_1_1

	return
end

function LanternRiddlesModel:Init()
	self.questiones = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1.all) do
		table.insert(self.questiones, (self:WrapQuestion(var_0_1[iter_2_1], (self:GetNextTime(iter_2_0)))))
	end

	return
end

function LanternRiddlesModel:WrapQuestion(arg_3_1, arg_3_2)
	local var_3_0 = self:GetAnswerFlag(arg_3_1.id, {
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

	local var_3_2 = self:IsFinishQuestion(arg_3_1.id)

	return {
		id = arg_3_1.id,
		type = arg_3_1.type,
		rightIndex = var_3_1,
		answers = var_3_0,
		text = arg_3_1.question,
		nextTime = arg_3_2 or 0,
		waitTime = arg_3_1.wrong_time,
		isFinish = var_3_2,
		isUnlock = self.unlockCount > 0 or var_3_2
	}
end

function LanternRiddlesModel:IsFinishQuestion(arg_4_1)
	return table.contains(self.finishList, arg_4_1)
end

function LanternRiddlesModel:GetNextTime(arg_5_1)
	return self.nextTimes[arg_5_1] or 0
end

function LanternRiddlesModel:SetNextTime(arg_6_1)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(self.questiones) do
		if iter_6_1.id == arg_6_1 then
			iter_6_1.nextTime = pg.TimeMgr.GetInstance():GetServerTime() + iter_6_1.waitTime
			var_6_0 = iter_6_1.waitTime

			break
		end
	end

	self.lockTime = pg.TimeMgr.GetInstance():GetServerTime() + var_6_0

	return
end

function LanternRiddlesModel:GetLockTime()
	return self.lockTime
end

function LanternRiddlesModel:GetAnswerFlag(arg_8_1, arg_8_2)
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

function LanternRiddlesModel:SetAnswerFlag(arg_11_1, arg_11_2)
	PlayerPrefs.SetInt(arg_11_1 .. "_" .. arg_11_2 .. "_" .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	for iter_11_0, iter_11_1 in ipairs(self.questiones) do
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

function LanternRiddlesModel:UpdateWrongAnswerFlag(arg_12_1, arg_12_2)
	self:SetAnswerFlag(arg_12_1, _.detect(self.questiones, function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end).answers[arg_12_2][1])
	self:SetNextTime(arg_12_1)

	return
end

function LanternRiddlesModel:UpdateRightAnswerFlag(arg_14_1)
	if not table.contains(self.finishList, arg_14_1) then
		table.insert(self.finishList, arg_14_1)

		self.finishCount = self.finishCount + 1
	end

	self:GetQuestion(arg_14_1).isFinish = true
	self.unlockCount = self.unlockCount - 1

	if self.unlockCount <= 0 then
		for iter_14_0, iter_14_1 in ipairs(self.questiones) do
			if not iter_14_1.isFinish then
				iter_14_1.isUnlock = false
			end
		end
	end

	return
end

function LanternRiddlesModel:UpdateData(arg_15_1)
	self.finishCount = arg_15_1.finishCount or 0
	self.unlockCount = arg_15_1.unlockCount or 0
	self.nextTimes = arg_15_1.nextTimes
	self.finishList = arg_15_1.finishList
	self.lockTime = self.nextTimes[#self.nextTimes]

	self:Init()

	return
end

function LanternRiddlesModel:IsRight(arg_16_1, arg_16_2)
	return _.any(self.questiones, function(arg_17_0)
		return arg_16_1 == arg_17_0.id and arg_17_0.rightIndex == arg_16_2
	end)
end

function LanternRiddlesModel:GetQuestiones()
	return self.questiones
end

function LanternRiddlesModel:GetQuestion(arg_19_1)
	return _.detect(self.questiones, function(arg_20_0)
		return arg_20_0.id == arg_19_1
	end)
end

function LanternRiddlesModel:Dispose()
	return
end

return LanternRiddlesModel
