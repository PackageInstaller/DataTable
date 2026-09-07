local NewNavalTacticsMediator = class("NewNavalTacticsMediator", import("...base.ContextMediator"))

NewNavalTacticsMediator.ON_SKILL = "NewNavalTacticsMediator:ON_SKILL"
NewNavalTacticsMediator.ON_SHOPPING = "NewNavalTacticsMediator:ON_SHOPPING"
NewNavalTacticsMediator.ON_SELECT_SHIP = "NewNavalTacticsMediator:ON_SELECT_SHIP"
NewNavalTacticsMediator.ON_START = "NewNavalTacticsMediator:ON_START"
NewNavalTacticsMediator.ON_CANCEL = "NewNavalTacticsMediator:ON_CANCEL"
NewNavalTacticsMediator.ON_FINISH_ONE_ANIM = "NewNavalTacticsMediator:ON_FINISH_ONE_ANIM"
NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT = "NewNavalTacticsMediator:ON_CANCEL_ADD_STUDENT"
NewNavalTacticsMediator.ON_QUICK_FINISH = "NavalTacticsMediator:ON_QUICK_FINISH"

function NewNavalTacticsMediator:register()
	self:bind(NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT, function(arg_2_0)
		self:sendNotification(NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT)

		return
	end)
	self:bind(NewNavalTacticsMediator.ON_SELECT_SHIP, function(arg_3_0, arg_3_1)
		self:SelectShip(arg_3_1)

		return
	end)
	self:bind(NewNavalTacticsMediator.ON_SKILL, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = NavalTacticsSkillInfoLayer,
			data = {
				skillOnShip = arg_4_2,
				skillId = arg_4_1
			}
		}))

		return
	end)
	self:bind(NewNavalTacticsMediator.ON_SHOPPING, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_5_1
		})

		return
	end)
	self:bind(NewNavalTacticsMediator.ON_START, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.START_TO_LEARN_TACTICS, arg_6_1)

		return
	end)

	self.cancelList = {}

	self:bind(NewNavalTacticsMediator.ON_CANCEL, function(arg_7_0, arg_7_1, arg_7_2)
		if self.viewComponent:IsInAddStudentProcess() then
			table.insert(self.cancelList, {
				arg_7_1,
				arg_7_2
			})
		else
			self.viewComponent.finishLessonUtil:Enter(arg_7_1, arg_7_2)
		end

		return
	end)
	self:bind(NewNavalTacticsMediator.ON_QUICK_FINISH, function(arg_8_0, arg_8_1)
		if self.viewComponent:IsInAddStudentProcess() then
			table.insert(self.cancelList, {
				arg_8_1,
				type
			})
		else
			self.viewComponent.finishLessonUtil:Enter(arg_8_1, Student.CANCEL_TYPE_QUICKLY)
		end

		return
	end)
	self.viewComponent:SetStudents((getProxy(NavalAcademyProxy):RawGetStudentList()))

	return
end

function NewNavalTacticsMediator:SelectShip(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(getProxy(NavalAcademyProxy):RawGetStudentList()) do
		table.insert(var_9_0, iter_9_1.shipId)
	end

	self:addSubLayers(Context.New({
		viewComponent = NavTacticsDockyardScene,
		mediator = DockyardMediator,
		data = {
			selectedMax = 1,
			prevPage = "NewNavalTacticsMediator",
			ignoredIds = var_9_0,
			hideTagFlags = ShipStatus.TAG_HIDE_TACTICES,
			onShip = function(arg_10_0, arg_10_1, arg_10_2)
				if not arg_10_0 then
					return false
				end

				local var_10_0, var_10_1 = ShipStatus.ShipStatusCheck("inTactics", arg_10_0, arg_10_1)

				if not var_10_0 then
					return var_10_0, var_10_1
				end

				return true
			end,
			onSelected = function(self)
				if not self[1] then
					return
				end

				if getProxy(BayProxy):RawGetShipById(self[1]):isMetaShip() then
					self.contextData.metaShipID = self[1]

					self.viewComponent:Init()

					return
				end

				self.contextData.shipToLesson = {
					shipId = self[1],
					index = arg_9_1
				}

				self.viewComponent:Init()

				return
			end
		}
	}))

	return
end

function NewNavalTacticsMediator:listNotificationInterests()
	return {
		NavalAcademyProxy.SKILL_CLASS_POS_UPDATED,
		GAME.START_TO_LEARN_TACTICS_DONE,
		GAME.CANCEL_LEARN_TACTICS_DONE,
		NewNavalTacticsMediator.ON_FINISH_ONE_ANIM,
		GAME.CANCEL_LEARN_TACTICS,
		NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT,
		GAME.TACTICS_META_UNLOCK_SKILL_DONE,
		GAME.TACTICS_META_SWITCH_SKILL_DONE,
		GAME.QUICK_FINISH_LEARN_TACTICS_DONE
	}
end

function NewNavalTacticsMediator:handleNotification(arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()

	if var_13_0 == NavalAcademyProxy.SKILL_CLASS_POS_UPDATED then
		self.viewComponent:OnUnlockSlot()
	elseif var_13_0 == GAME.START_TO_LEARN_TACTICS_DONE then
		self.viewComponent:OnAddStudent()
		self.viewComponent:ResendCancelOp(self.cancelList)

		self.cancelList = {}
	elseif var_13_0 == NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT then
		self.viewComponent:ResendCancelOp(self.cancelList)

		self.cancelList = {}
	elseif var_13_0 == GAME.CANCEL_LEARN_TACTICS_DONE then
		self.viewComponent.finishLessonUtil:WaitForFinish(var_13_1.id, var_13_1.shipId, var_13_1.totalExp, ShipSkill.New(var_13_1.oldSkill), (ShipSkill.New(var_13_1.newSkill)))
	elseif var_13_0 == GAME.CANCEL_LEARN_TACTICS then
		self.viewComponent:BlockEvents()
	elseif var_13_0 == NewNavalTacticsMediator.ON_FINISH_ONE_ANIM then
		self.viewComponent:UnblockEvents()
		self.viewComponent:OnExitStudent()
	elseif var_13_0 == GAME.TACTICS_META_UNLOCK_SKILL_DONE then
		self.viewComponent:OnUpdateMetaSkillPanel(var_13_1.metaShipID)
	elseif var_13_0 == GAME.TACTICS_META_SWITCH_SKILL_DONE then
		self.viewComponent:OnUpdateMetaSkillPanel(var_13_1.metaShipID)
	elseif var_13_0 == GAME.QUICK_FINISH_LEARN_TACTICS_DONE then
		self.viewComponent:BlockEvents()
		self.viewComponent:OnUpdateQuickFinishPanel()
	end

	return
end

return NewNavalTacticsMediator
