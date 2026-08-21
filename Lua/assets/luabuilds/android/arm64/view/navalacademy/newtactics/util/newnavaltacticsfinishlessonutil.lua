local var_0_0 = class("NewNavalTacticsFinishLessonUtil")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.studentsPage = arg_1_1
	arg_1_0.selLessonPage = arg_1_2
	arg_1_0.selSkillPage = arg_1_3
	arg_1_0.queue = {}

	return
end

function var_0_0.Enter(arg_2_0, arg_2_1, arg_2_2)
	if _.any(arg_2_0.queue, function(arg_3_0)
		return arg_3_0[1] == arg_2_1
	end) then
		return
	end

	table.insert(arg_2_0.queue, {
		arg_2_1,
		arg_2_2
	})

	if #arg_2_0.queue == 1 then
		arg_2_0:Excute()
	end

	return
end

function var_0_0.Excute(arg_4_0)
	if arg_4_0.queue[1][2] == Student.CANCEL_TYPE_QUICKLY then
		pg.m02:sendNotification(GAME.QUICK_FINISH_LEARN_TACTICS, {
			shipId = arg_4_0.queue[1][1]
		})
	else
		pg.m02:sendNotification(GAME.CANCEL_LEARN_TACTICS, {
			shipId = arg_4_0.queue[1][1],
			type = arg_4_0.queue[1][2]
		})
	end

	return
end

function var_0_0.NextOne(arg_5_0)
	table.remove(arg_5_0.queue, 1)
	pg.m02:sendNotification(NewNavalTacticsMediator.ON_FINISH_ONE_ANIM)

	if #arg_5_0.queue > 0 then
		arg_5_0:Excute()
	end

	return
end

function var_0_0.IsWorking(arg_6_0)
	return #arg_6_0.queue > 0
end

function var_0_0.WaitForFinish(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = arg_7_0.studentsPage:GetCard(arg_7_1)

	var_7_0:RemoveTimer()
	arg_7_0:DoAnimtion(var_7_0, arg_7_3, arg_7_4, arg_7_5, function()
		arg_7_0:DisplayResult(arg_7_1, arg_7_3, arg_7_2, arg_7_4, arg_7_5)

		return
	end)

	return
end

function var_0_0.DisplayResult(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = ""
	local var_9_1 = getProxy(BayProxy):RawGetShipById(arg_9_3)
	local var_9_2 = var_9_1:getName()
	local var_9_3 = arg_9_4:GetName()

	var_9_0 = arg_9_5.level > arg_9_4.level and i18n("tactics_end_to_learn", var_9_2, var_9_3, arg_9_2) .. i18n("tactics_skill_level_up", arg_9_4.level, arg_9_5.level) or i18n("tactics_end_to_learn", var_9_2, var_9_3, arg_9_2)

	if arg_9_5:IsMaxLevel() then
		arg_9_0:HandleMaxLevel(arg_9_1, var_9_1, var_9_0, var_9_2, var_9_3, arg_9_2)
	else
		arg_9_0:WhetherToContinue(var_9_0, arg_9_1, var_9_1, arg_9_4.id)
	end

	return
end

function var_0_0.HandleMaxLevel(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if _.all(arg_10_2:getSkillList(), function(arg_11_0)
		return ShipSkill.New(arg_10_2.skills[arg_11_0]):IsMaxLevel()
	end) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			hideClose = true,
			content = arg_10_3,
			onYes = function()
				arg_10_0:NextOne()

				return
			end
		})
	else
		arg_10_0:WhetherToContinueForOtherSkill(arg_10_1, arg_10_2, arg_10_4, arg_10_5, arg_10_6)
	end

	return
end

function var_0_0.WhetherToContinueForOtherSkill(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideClose = true,
		content = i18n("tactics_end_to_learn", arg_13_3, arg_13_4, arg_13_5) .. i18n("tactics_continue_to_learn_other_skill"),
		onYes = function()
			if arg_13_0:ExistBook() then
				arg_13_0:ContinuousLearningForOtherSkill(arg_13_1, arg_13_2)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
				arg_13_0:NextOne()
			end

			return
		end,
		onNo = function()
			arg_13_0:NextOne()

			return
		end
	})

	return
end

function var_0_0.ContinuousLearningForOtherSkill(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.selSkillPage:SetCancelCallback(function()
		arg_16_0:NextOne()

		return
	end)
	arg_16_0.selLessonPage:SetHideCallback(function()
		arg_16_0:NextOne()

		return
	end)
	arg_16_0.selSkillPage:ExecuteAction("Show", (Student.New({
		id = arg_16_1,
		ship_id = arg_16_2.id
	})))

	return
end

function var_0_0.WhetherToContinue(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_1 = arg_19_1 .. i18n("tactics_continue_to_learn")

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideClose = true,
		content = arg_19_1,
		onYes = function()
			if arg_19_0:ExistBook() then
				arg_19_0:ContinuousLearning(arg_19_2, arg_19_3, arg_19_4)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
				arg_19_0:NextOne()
			end

			return
		end,
		onNo = function()
			arg_19_0:NextOne()

			return
		end
	})

	return
end

function var_0_0.ExistBook(arg_22_0)
	local var_22_0 = #getProxy(BagProxy):getItemsByType(Item.LESSON_TYPE)

	return var_22_0 > 0
end

function var_0_0.ContinuousLearning(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = Student.New({
		id = arg_23_1,
		ship_id = arg_23_2.id
	})
	local var_23_1 = table.indexof(arg_23_2:getSkillList(), arg_23_3)

	assert(var_23_1 and var_23_1 > 0)
	var_23_0:setSkillIndex(var_23_1)
	arg_23_0.selLessonPage:SetHideCallback(function()
		arg_23_0:NextOne()

		return
	end)
	arg_23_0.selLessonPage:ExecuteAction("Show", var_23_0, false)

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
