class = var_0_10000

local var_0_0 = var_0_10000("NewNavalTacticsFinishLessonUtil")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.studentsPage = arg_1_1
	arg_1_0.selLessonPage = arg_1_2
	arg_1_0.selSkillPage = arg_1_3
	arg_1_0.queue = {}

	return
end

function var_0_0.Enter(arg_2_0, arg_2_1, arg_2_2)
	_ = var_1_10003

	if var_1_10003.any(arg_2_0.queue, function(arg_3_0)
		return arg_3_0[1] == arg_2_1
	end) then
		return
	end

	table = var_3

	var_3.insert(arg_2_0.queue, {
		arg_2_1,
		arg_2_2
	})

	if #arg_2_0.queue == 1 then
		arg_2_0:Excute()
	end

	return
end

function var_0_0.Excute(arg_4_0)
	local var_4_0 = arg_4_0.queue[1][2]

	Student = var_1_10003

	if var_4_0 == var_1_10003.CANCEL_TYPE_QUICKLY then
		pg = var_4_0

		local var_4_1 = var_4_0.m02

		var_4_0 = var_4_0.sendNotification
		GAME = var_1_10005

		var_4_0(var_4_1, var_1_10005.QUICK_FINISH_LEARN_TACTICS, {
			shipId = var_1[1]
		})
	else
		pg = var_4_0

		local var_4_2 = var_4_0.m02
		local var_4_3 = var_2.sendNotification

		GAME = var_1_10005

		var_4_3(var_4_2, var_1_10005.CANCEL_LEARN_TACTICS, {
			shipId = var_1[1],
			type = var_1[2]
		})
	end

	return
end

function var_0_0.NextOne(arg_5_0)
	table = var_1_10001

	var_1_10001.remove(arg_5_0.queue, 1)

	pg = var_1

	local var_5_0 = var_1.m02
	local var_5_1 = var_1.sendNotification

	NewNavalTacticsMediator = var_4

	var_5_1(var_5_0, var_4.ON_FINISH_ONE_ANIM)

	if #arg_5_0.queue > 0 then
		arg_5_0:Excute()
	end

	return
end

function var_0_0.IsWorking(arg_6_0)
	return #arg_6_0.queue > 0
end

function var_0_0.WaitForFinish(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local function var_7_0()
		local var_8_0 = arg_7_0

		var_0.DisplayResult(var_8_0, arg_7_1, arg_7_3, arg_7_2, arg_7_4, arg_7_5)

		return
	end

	local var_7_1 = arg_7_0.studentsPage
	local var_7_2 = var_7.GetCard(var_7_1, arg_7_1)

	var_7.RemoveTimer(var_7_2)
	arg_7_0:DoAnimtion(var_7, arg_7_3, arg_7_4, arg_7_5, var_7_0)

	return
end

function var_0_0.DisplayResult(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = ""

	getProxy = var_1_10007
	BayProxy = var_1_10009

	local var_9_1 = var_1_10007(var_1_10009)
	local var_9_2 = var_7.RawGetShipById(var_9_1, arg_9_3)
	local var_9_3 = var_7.getName(var_9_2)
	local var_9_4 = arg_9_4:GetName()
	local var_9_5 = arg_9_5.level

	if arg_9_4.level < var_9_5 then
		i18n = var_9_5
		var_9_5 = var_9_5("tactics_end_to_learn", var_9_3, var_9_4, arg_9_2)
		i18n = var_11
		var_9_0 = var_9_5 .. var_11("tactics_skill_level_up", arg_9_4.level, arg_9_5.level)
	else
		i18n = var_9_5
		var_9_0 = var_9_5("tactics_end_to_learn", var_9_3, var_9_4, arg_9_2)
	end

	if arg_9_5:IsMaxLevel() then
		arg_9_0:HandleMaxLevel(arg_9_1, var_7, var_9_0, var_9_3, var_9_4, arg_9_2)
	else
		arg_9_0:WhetherToContinue(var_9_0, arg_9_1, var_7, arg_9_4.id)
	end

	return
end

function var_0_0.HandleMaxLevel(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	local var_10_0 = arg_10_2:getSkillList()

	_ = var_1_10008

	if var_1_10008.all(var_10_0, function(arg_11_0)
		ShipSkill = var_2_10001

		local var_11_0 = var_2_10001.New(arg_10_2.skills[arg_11_0])

		return var_1.IsMaxLevel(var_11_0)
	end) then
		pg = var_8

		local var_10_1 = var_8.MsgboxMgr.GetInstance()

		var_8.ShowMsgBox(var_10_1, {
			modal = true,
			hideNo = true,
			hideClose = true,
			content = arg_10_3,
			onYes = function()
				local var_12_0 = arg_10_0

				var_0.NextOne(var_12_0)

				return
			end
		})
	else
		arg_10_0:WhetherToContinueForOtherSkill(arg_10_1, arg_10_2, arg_10_4, arg_10_5, arg_10_6)
	end

	return
end

function var_0_0.WhetherToContinueForOtherSkill(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	i18n = var_1_10006

	local var_13_0 = var_1_10006("tactics_end_to_learn", arg_13_3, arg_13_4, arg_13_5)

	i18n = var_1_10007

	local var_13_1 = var_13_0 .. var_1_10007("tactics_continue_to_learn_other_skill")

	pg = var_7

	local var_13_2 = var_7.MsgboxMgr.GetInstance()

	var_7.ShowMsgBox(var_13_2, {
		modal = true,
		hideClose = true,
		content = var_13_1,
		onYes = function()
			local var_14_0 = arg_13_0

			if var_0.ExistBook(var_14_0) then
				local var_14_1 = arg_13_0

				var_0.ContinuousLearningForOtherSkill(var_14_1, arg_13_1, arg_13_2)
			else
				pg = var_0

				local var_14_2 = var_0.TipsMgr.GetInstance()
				local var_14_3 = var_0.ShowTips

				i18n = var_2_10003

				var_14_3(var_14_2, var_2_10003("tactics_no_lesson"))

				local var_14_4 = arg_13_0

				var_0.NextOne(var_14_4)
			end

			return
		end,
		onNo = function()
			local var_15_0 = arg_13_0

			var_0.NextOne(var_15_0)

			return
		end
	})

	return
end

function var_0_0.ContinuousLearningForOtherSkill(arg_16_0, arg_16_1, arg_16_2)
	Student = var_1_10003

	local var_16_0 = var_1_10003.New({
		id = arg_16_1,
		ship_id = arg_16_2.id
	})
	local var_16_1 = arg_16_0.selSkillPage

	var_4.SetCancelCallback(var_16_1, function()
		local var_17_0 = arg_16_0

		var_0.NextOne(var_17_0)

		return
	end)

	local var_16_2 = arg_16_0.selLessonPage

	var_4.SetHideCallback(var_16_2, function()
		local var_18_0 = arg_16_0

		var_0.NextOne(var_18_0)

		return
	end)

	local var_16_3 = arg_16_0.selSkillPage

	var_4.ExecuteAction(var_16_3, "Show", var_16_0)

	return
end

function var_0_0.WhetherToContinue(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_1

	i18n = var_1_10006
	arg_19_1 = var_19_0 .. var_1_10006("tactics_continue_to_learn")
	pg = var_19_0

	local var_19_1 = var_19_0.MsgboxMgr.GetInstance()

	var_5.ShowMsgBox(var_19_1, {
		modal = true,
		hideClose = true,
		content = arg_19_1,
		onYes = function()
			local var_20_0 = arg_19_0

			if var_0.ExistBook(var_20_0) then
				local var_20_1 = arg_19_0

				var_0.ContinuousLearning(var_20_1, arg_19_2, arg_19_3, arg_19_4)
			else
				pg = var_0

				local var_20_2 = var_0.TipsMgr.GetInstance()
				local var_20_3 = var_0.ShowTips

				i18n = var_2_10003

				var_20_3(var_20_2, var_2_10003("tactics_no_lesson"))

				local var_20_4 = arg_19_0

				var_0.NextOne(var_20_4)
			end

			return
		end,
		onNo = function()
			local var_21_0 = arg_19_0

			var_0.NextOne(var_21_0)

			return
		end
	})

	return
end

function var_0_0.ExistBook(arg_22_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_22_0 = var_1_10001(var_1_10003)
	local var_22_1 = var_1.getItemsByType

	Item = var_1_10004

	return #var_22_1(var_22_0, var_1_10004.LESSON_TYPE) > 0
end

function var_0_0.ContinuousLearning(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	Student = var_1_10004

	local var_23_0 = var_1_10004.New({
		id = arg_23_1,
		ship_id = arg_23_2.id
	})
	local var_23_1 = arg_23_2
	local var_23_2 = arg_23_2.getSkillList(var_23_1)

	table = var_6

	local var_23_3 = var_6.indexof(var_23_2, arg_23_3)

	assert = var_23_1

	var_23_1(var_23_3 and var_23_3 > 0)
	var_23_0:setSkillIndex(var_23_3)

	local var_23_4 = arg_23_0.selLessonPage

	var_7.SetHideCallback(var_23_4, function()
		local var_24_0 = arg_23_0

		var_0.NextOne(var_24_0)

		return
	end)

	local var_23_5 = arg_23_0.selLessonPage

	var_7.ExecuteAction(var_23_5, "Show", var_23_0, false)

	return
end

function var_0_0.DoAnimtion(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	if not arg_25_1 then
		arg_25_5()
	else
		arg_25_1:DoAddExpAnim(arg_25_3, arg_25_4, arg_25_5)
	end

	return
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0.studentsPage = nil
	arg_26_0.selLessonPage = nil
	arg_26_0.selSkillPage = nil
	arg_26_0.queue = {}

	return
end

return var_0_0
