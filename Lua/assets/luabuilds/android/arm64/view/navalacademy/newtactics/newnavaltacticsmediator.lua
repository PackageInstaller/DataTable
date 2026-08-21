local var_0_0 = class("NewNavalTacticsMediator", import("...base.ContextMediator"))

var_0_0.ON_SKILL = "NewNavalTacticsMediator:ON_SKILL"
var_0_0.ON_SHOPPING = "NewNavalTacticsMediator:ON_SHOPPING"
var_0_0.ON_SELECT_SHIP = "NewNavalTacticsMediator:ON_SELECT_SHIP"
var_0_0.ON_START = "NewNavalTacticsMediator:ON_START"
var_0_0.ON_CANCEL = "NewNavalTacticsMediator:ON_CANCEL"
var_0_0.ON_FINISH_ONE_ANIM = "NewNavalTacticsMediator:ON_FINISH_ONE_ANIM"
var_0_0.ON_CANCEL_ADD_STUDENT = "NewNavalTacticsMediator:ON_CANCEL_ADD_STUDENT"
var_0_0.ON_QUICK_FINISH = "NavalTacticsMediator:ON_QUICK_FINISH"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_CANCEL_ADD_STUDENT, function(arg_2_0)
		arg_1_0:sendNotification(var_0_0.ON_CANCEL_ADD_STUDENT)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_SHIP, function(arg_3_0, arg_3_1)
		arg_1_0:SelectShip(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKILL, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = NavalTacticsSkillInfoLayer,
			data = {
				skillOnShip = arg_4_2,
				skillId = arg_4_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHOPPING, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_START, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.START_TO_LEARN_TACTICS, arg_6_1)

		return
	end)

	arg_1_0.cancelList = {}

	arg_1_0:bind(var_0_0.ON_CANCEL, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_1_0.viewComponent:IsInAddStudentProcess() then
			table.insert(arg_1_0.cancelList, {
				arg_7_1,
				arg_7_2
			})
		else
			arg_1_0.viewComponent.finishLessonUtil:Enter(arg_7_1, arg_7_2)
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_QUICK_FINISH, function(arg_8_0, arg_8_1)
		if arg_1_0.viewComponent:IsInAddStudentProcess() then
			table.insert(arg_1_0.cancelList, {
				arg_8_1,
				type
			})
		else
			arg_1_0.viewComponent.finishLessonUtil:Enter(arg_8_1, Student.CANCEL_TYPE_QUICKLY)
		end

		return
	end)
	arg_1_0.viewComponent:SetStudents((getProxy(NavalAcademyProxy):RawGetStudentList()))

	return
end

function var_0_0.SelectShip(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(getProxy(NavalAcademyProxy):RawGetStudentList()) do
		table.insert({}, iter_9_1.shipId)
	end

	arg_9_0:addSubLayers(Context.New({
		viewComponent = NavTacticsDockyardScene,
		mediator = DockyardMediator,
		data = {
			selectedMax = 1,
			prevPage = "NewNavalTacticsMediator",
			ignoredIds = {},
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
			onSelected = function(arg_11_0)
				if not arg_11_0[1] then
					return
				end

				local var_11_0 = getProxy(BayProxy):RawGetShipById(arg_11_0[1])

				if var_11_0:isMetaShip() then
					arg_9_0.contextData.metaShipID = arg_11_0[1]

					arg_9_0.viewComponent:Init()

					return
				end

				arg_9_0.contextData.shipToLesson = {
					shipId = arg_11_0[1],
					index = arg_9_1
				}

				arg_9_0.viewComponent:Init()

				return
			end
		}
	}))

	return
end

function var_0_0.listNotificationInterests(arg_12_0)
	return {
		NavalAcademyProxy.SKILL_CLASS_POS_UPDATED,
		GAME.START_TO_LEARN_TACTICS_DONE,
		GAME.CANCEL_LEARN_TACTICS_DONE,
		var_0_0.ON_FINISH_ONE_ANIM,
		GAME.CANCEL_LEARN_TACTICS,
		var_0_0.ON_CANCEL_ADD_STUDENT,
		GAME.TACTICS_META_UNLOCK_SKILL_DONE,
		GAME.TACTICS_META_SWITCH_SKILL_DONE,
		GAME.QUICK_FINISH_LEARN_TACTICS_DONE
	}
end

function var_0_0.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()

	if var_13_0 == NavalAcademyProxy.SKILL_CLASS_POS_UPDATED then
		arg_13_0.viewComponent:OnUnlockSlot()
	elseif var_13_0 == GAME.START_TO_LEARN_TACTICS_DONE then
		arg_13_0.viewComponent:OnAddStudent()
		arg_13_0.viewComponent:ResendCancelOp(arg_13_0.cancelList)

		arg_13_0.cancelList = {}
	elseif var_13_0 == var_0_0.ON_CANCEL_ADD_STUDENT then
		arg_13_0.viewComponent:ResendCancelOp(arg_13_0.cancelList)

		arg_13_0.cancelList = {}
	elseif var_13_0 == GAME.CANCEL_LEARN_TACTICS_DONE then
		arg_13_0.viewComponent.finishLessonUtil:WaitForFinish(var_13_1.id, var_13_1.shipId, var_13_1.totalExp, ShipSkill.New(var_13_1.oldSkill), (ShipSkill.New(var_13_1.newSkill)))
	elseif var_13_0 == GAME.CANCEL_LEARN_TACTICS then
		arg_13_0.viewComponent:BlockEvents()
	elseif var_13_0 == var_0_0.ON_FINISH_ONE_ANIM then
		arg_13_0.viewComponent:UnblockEvents()
		arg_13_0.viewComponent:OnExitStudent()
	elseif var_13_0 == GAME.TACTICS_META_UNLOCK_SKILL_DONE then
		arg_13_0.viewComponent:OnUpdateMetaSkillPanel(var_13_1.metaShipID)
	elseif var_13_0 == GAME.TACTICS_META_SWITCH_SKILL_DONE then
		arg_13_0.viewComponent:OnUpdateMetaSkillPanel(var_13_1.metaShipID)
	elseif var_13_0 == GAME.QUICK_FINISH_LEARN_TACTICS_DONE then
		arg_13_0.viewComponent:BlockEvents()
		arg_13_0.viewComponent:OnUpdateQuickFinishPanel()
	end

	return
end

return var_0_0
