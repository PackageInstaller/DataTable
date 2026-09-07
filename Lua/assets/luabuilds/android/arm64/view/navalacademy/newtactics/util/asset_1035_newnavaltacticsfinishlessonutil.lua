local NewNavalTacticsFinishLessonUtil = class("NewNavalTacticsFinishLessonUtil")

function NewNavalTacticsFinishLessonUtil:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.studentsPage = arg_1_1
	self.selLessonPage = arg_1_2
	self.selSkillPage = arg_1_3
	self.queue = {}

	return
end

function NewNavalTacticsFinishLessonUtil:Enter(arg_2_1, arg_2_2)
	if _.any(self.queue, function(arg_3_0)
		return arg_3_0[1] == arg_2_1
	end) then
		return
	end

	table.insert(self.queue, {
		arg_2_1,
		arg_2_2
	})

	if #self.queue == 1 then
		self:Excute()
	end

	return
end

function NewNavalTacticsFinishLessonUtil:Excute()
	if self.queue[1][2] == Student.CANCEL_TYPE_QUICKLY then
		pg.m02:sendNotification(GAME.QUICK_FINISH_LEARN_TACTICS, {
			shipId = self.queue[1][1]
		})
	else
		pg.m02:sendNotification(GAME.CANCEL_LEARN_TACTICS, {
			shipId = self.queue[1][1],
			type = self.queue[1][2]
		})
	end

	return
end

function NewNavalTacticsFinishLessonUtil:NextOne()
	table.remove(self.queue, 1)
	pg.m02:sendNotification(NewNavalTacticsMediator.ON_FINISH_ONE_ANIM)

	if #self.queue > 0 then
		self:Excute()
	end

	return
end

function NewNavalTacticsFinishLessonUtil:IsWorking()
	return #self.queue > 0
end

function NewNavalTacticsFinishLessonUtil:WaitForFinish(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = self.studentsPage:GetCard(arg_7_1)

	var_7_0:RemoveTimer()
	self:DoAnimtion(var_7_0, arg_7_3, arg_7_4, arg_7_5, function()
		self:DisplayResult(arg_7_1, arg_7_3, arg_7_2, arg_7_4, arg_7_5)

		return
	end)

	return
end

function NewNavalTacticsFinishLessonUtil:DisplayResult(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = ""
	local var_9_1 = getProxy(BayProxy):RawGetShipById(arg_9_3)
	local var_9_2 = var_9_1:getName()
	local var_9_3 = arg_9_4:GetName()

	var_9_0 = arg_9_5.level > arg_9_4.level and i18n("tactics_end_to_learn", var_9_2, var_9_3, arg_9_2) .. i18n("tactics_skill_level_up", arg_9_4.level, arg_9_5.level) or i18n("tactics_end_to_learn", var_9_2, var_9_3, arg_9_2)

	if arg_9_5:IsMaxLevel() then
		self:HandleMaxLevel(arg_9_1, var_9_1, var_9_0, var_9_2, var_9_3, arg_9_2)
	else
		self:WhetherToContinue(var_9_0, arg_9_1, var_9_1, arg_9_4.id)
	end

	return
end

function NewNavalTacticsFinishLessonUtil:HandleMaxLevel(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if _.all(arg_10_2:getSkillList(), function(arg_11_0)
		return ShipSkill.New(arg_10_2.skills[arg_11_0]):IsMaxLevel()
	end) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			hideClose = true,
			content = arg_10_3,
			onYes = function()
				self:NextOne()

				return
			end
		})
	else
		self:WhetherToContinueForOtherSkill(arg_10_1, arg_10_2, arg_10_4, arg_10_5, arg_10_6)
	end

	return
end

function NewNavalTacticsFinishLessonUtil:WhetherToContinueForOtherSkill(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideClose = true,
		content = i18n("tactics_end_to_learn", arg_13_3, arg_13_4, arg_13_5) .. i18n("tactics_continue_to_learn_other_skill"),
		onYes = function()
			if self:ExistBook() then
				self:ContinuousLearningForOtherSkill(arg_13_1, arg_13_2)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
				self:NextOne()
			end

			return
		end,
		onNo = function()
			self:NextOne()

			return
		end
	})

	return
end

function NewNavalTacticsFinishLessonUtil:ContinuousLearningForOtherSkill(arg_16_1, arg_16_2)
	self.selSkillPage:SetCancelCallback(function()
		self:NextOne()

		return
	end)
	self.selLessonPage:SetHideCallback(function()
		self:NextOne()

		return
	end)
	self.selSkillPage:ExecuteAction("Show", (Student.New({
		id = arg_16_1,
		ship_id = arg_16_2.id
	})))

	return
end

function NewNavalTacticsFinishLessonUtil:WhetherToContinue(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_1 = arg_19_1 .. i18n("tactics_continue_to_learn")

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideClose = true,
		content = arg_19_1,
		onYes = function()
			if self:ExistBook() then
				self:ContinuousLearning(arg_19_2, arg_19_3, arg_19_4)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
				self:NextOne()
			end

			return
		end,
		onNo = function()
			self:NextOne()

			return
		end
	})

	return
end

function NewNavalTacticsFinishLessonUtil:ExistBook()
	return #getProxy(BagProxy):getItemsByType(Item.LESSON_TYPE) > 0
end

function NewNavalTacticsFinishLessonUtil:ContinuousLearning(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = Student.New({
		id = arg_23_1,
		ship_id = arg_23_2.id
	})
	local var_23_1 = table.indexof(arg_23_2:getSkillList(), arg_23_3)

	assert(var_23_1 and var_23_1 > 0)
	var_23_0:setSkillIndex(var_23_1)
	self.selLessonPage:SetHideCallback(function()
		self:NextOne()

		return
	end)
	self.selLessonPage:ExecuteAction("Show", var_23_0, false)

	return
end

function NewNavalTacticsFinishLessonUtil:DoAnimtion(arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	if not arg_25_1 then
		arg_25_5()
	else
		arg_25_1:DoAddExpAnim(arg_25_3, arg_25_4, arg_25_5)
	end

	return
end

function NewNavalTacticsFinishLessonUtil:Dispose()
	self.studentsPage = nil
	self.selLessonPage = nil
	self.selSkillPage = nil
	self.queue = {}

	return
end

return NewNavalTacticsFinishLessonUtil
