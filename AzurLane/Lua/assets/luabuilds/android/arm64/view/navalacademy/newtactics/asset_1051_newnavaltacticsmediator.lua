class = var_0_10000

local var_0_0 = "NewNavalTacticsMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_SKILL = "NewNavalTacticsMediator:ON_SKILL"
var_0_1.ON_SHOPPING = "NewNavalTacticsMediator:ON_SHOPPING"
var_0_1.ON_SELECT_SHIP = "NewNavalTacticsMediator:ON_SELECT_SHIP"
var_0_1.ON_START = "NewNavalTacticsMediator:ON_START"
var_0_1.ON_CANCEL = "NewNavalTacticsMediator:ON_CANCEL"
var_0_1.ON_FINISH_ONE_ANIM = "NewNavalTacticsMediator:ON_FINISH_ONE_ANIM"
var_0_1.ON_CANCEL_ADD_STUDENT = "NewNavalTacticsMediator:ON_CANCEL_ADD_STUDENT"
var_0_1.ON_QUICK_FINISH = "NavalTacticsMediator:ON_QUICK_FINISH"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_CANCEL_ADD_STUDENT, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.sendNotification(var_2_0, var_0_1.ON_CANCEL_ADD_STUDENT)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_SHIP, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.SelectShip(var_3_0, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKILL, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_4_2 = var_2_10006.New
		local var_4_3 = {}

		SkillInfoMediator = var_2_10009
		var_4_3.mediator = var_2_10009
		NavalTacticsSkillInfoLayer = var_2_10009
		var_4_3.viewComponent = var_2_10009
		var_4_3.data = {
			skillOnShip = arg_4_2,
			skillId = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.SHOPPING, {
			count = 1,
			id = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.START_TO_LEARN_TACTICS, arg_6_1)

		return
	end)

	arg_1_0.cancelList = {}

	arg_1_0:bind(var_0_1.ON_CANCEL, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0.viewComponent

		if var_3.IsInAddStudentProcess(var_7_0) then
			table = var_3

			var_3.insert(arg_1_0.cancelList, {
				arg_7_1,
				arg_7_2
			})
		else
			local var_7_1 = arg_1_0.viewComponent.finishLessonUtil

			var_3.Enter(var_7_1, arg_7_1, arg_7_2)
		end

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_QUICK_FINISH, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0.viewComponent

		if var_2.IsInAddStudentProcess(var_8_0) then
			table = var_2

			local var_8_1 = var_2.insert
			local var_8_2 = arg_1_0.cancelList
			local var_8_3 = {
				arg_8_1
			}

			type = var_2_10006
			var_8_3[2] = var_2_10006

			var_8_1(var_8_2, var_8_3)
		else
			local var_8_4 = arg_1_0.viewComponent.finishLessonUtil
			local var_8_5 = var_2.Enter
			local var_8_6 = arg_8_1

			Student = var_2_10006

			var_8_5(var_8_4, var_8_6, var_2_10006.CANCEL_TYPE_QUICKLY)
		end

		return
	end)

	getProxy = var_1
	NavalAcademyProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.RawGetStudentList(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_2.SetStudents(var_1_3, var_1_2)

	return
end

function var_0_1.SelectShip(arg_9_0, arg_9_1)
	local var_9_0 = {}

	getProxy = var_1_10003
	NavalAcademyProxy = var_1_10005

	local var_9_1 = var_1_10003(var_1_10005)

	pairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(var_9_1:RawGetStudentList()) do
		table = var_1_10009

		var_1_10009.insert(var_9_0, iter_9_1.shipId)
	end

	local var_9_2 = {
		selectedMax = 1,
		prevPage = "NewNavalTacticsMediator",
		ignoredIds = var_9_0
	}

	ShipStatus = var_5
	var_9_2.hideTagFlags = var_5.TAG_HIDE_TACTICES

	function var_9_2.onShip(arg_10_0, arg_10_1, arg_10_2)
		if not arg_10_0 then
			return false
		end

		ShipStatus = var_2_10003

		local var_10_0, var_10_1 = var_2_10003.ShipStatusCheck("inTactics", arg_10_0, arg_10_1)

		if not var_10_0 then
			return var_10_0, var_10_1
		end

		return true
	end

	function var_9_2.onSelected(arg_11_0)
		if not arg_11_0[1] then
			return
		end

		getProxy = var_2_10002
		BayProxy = var_2_10004

		local var_11_0 = var_2_10002(var_2_10004)
		local var_11_1 = var_2.RawGetShipById(var_11_0, var_1)

		if var_2.isMetaShip(var_11_1) then
			arg_9_0.contextData.metaShipID = var_1

			local var_11_2 = arg_9_0.viewComponent

			var_3.Init(var_11_2)

			return
		end

		arg_9_0.contextData.shipToLesson = {
			shipId = var_1,
			index = arg_9_1
		}

		local var_11_3 = arg_9_0.viewComponent

		var_3.Init(var_11_3)

		return
	end

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.addSubLayers

	Context = iter_9_1

	local var_9_5 = iter_9_1.New
	local var_9_6 = {}

	NavTacticsDockyardScene = var_1_10011
	var_9_6.viewComponent = var_1_10011
	DockyardMediator = var_1_10011
	var_9_6.mediator = var_1_10011
	var_9_6.data = var_9_2

	var_9_4(var_9_3, var_9_5(var_9_6))

	return
end

function var_0_1.listNotificationInterests(arg_12_0)
	local var_12_0 = {}

	NavalAcademyProxy = var_1_10002
	var_12_0[1] = var_1_10002.SKILL_CLASS_POS_UPDATED
	GAME = var_2
	var_12_0[2] = var_2.START_TO_LEARN_TACTICS_DONE
	GAME = var_2
	var_12_0[3] = var_2.CANCEL_LEARN_TACTICS_DONE
	var_12_0[4] = var_0_1.ON_FINISH_ONE_ANIM
	GAME = var_2
	var_12_0[5] = var_2.CANCEL_LEARN_TACTICS
	var_12_0[6] = var_0_1.ON_CANCEL_ADD_STUDENT
	GAME = var_2
	var_12_0[7] = var_2.TACTICS_META_UNLOCK_SKILL_DONE
	GAME = var_2
	var_12_0[8] = var_2.TACTICS_META_SWITCH_SKILL_DONE
	GAME = var_2
	var_12_0[9] = var_2.QUICK_FINISH_LEARN_TACTICS_DONE

	return var_12_0
end

function var_0_1.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.getName(var_13_0)
	local var_13_2 = arg_13_1:getBody()

	NavalAcademyProxy = var_13_0

	if var_13_1 == var_13_0.SKILL_CLASS_POS_UPDATED then
		var_1_10006 = arg_13_0.viewComponent

		var_4.OnUnlockSlot(var_1_10006)
	else
		GAME = var_4

		if var_13_1 == var_4.START_TO_LEARN_TACTICS_DONE then
			var_1_10006 = arg_13_0.viewComponent

			var_4.OnAddStudent(var_1_10006)

			var_1_10006 = arg_13_0.viewComponent

			var_4.ResendCancelOp(var_1_10006, arg_13_0.cancelList)

			arg_13_0.cancelList = {}
		elseif var_13_1 == var_0_1.ON_CANCEL_ADD_STUDENT then
			var_1_10006 = arg_13_0.viewComponent

			var_4.ResendCancelOp(var_1_10006, arg_13_0.cancelList)

			arg_13_0.cancelList = {}
		else
			GAME = var_4

			local var_13_3

			if var_13_1 == var_4.CANCEL_LEARN_TACTICS_DONE then
				var_13_3 = var_13_2.id

				local var_13_4 = var_13_2.totalExp

				ShipSkill = var_1_10006

				local var_13_5 = var_1_10006.New(var_13_2.oldSkill)

				ShipSkill = var_1_10007

				local var_13_6 = var_1_10007.New(var_13_2.newSkill)
				local var_13_7 = var_13_2.shipId
				local var_13_8 = arg_13_0.viewComponent.finishLessonUtil

				var_9.WaitForFinish(var_13_8, var_13_3, var_13_7, var_13_4, var_13_5, var_13_6)
			else
				GAME = var_13_3

				if var_13_1 == var_13_3.CANCEL_LEARN_TACTICS then
					local var_13_9 = arg_13_0.viewComponent

					var_4.BlockEvents(var_13_9)
				elseif var_13_1 == var_0_1.ON_FINISH_ONE_ANIM then
					local var_13_10 = arg_13_0.viewComponent

					var_4.UnblockEvents(var_13_10)

					local var_13_11 = arg_13_0.viewComponent

					var_4.OnExitStudent(var_13_11)
				else
					GAME = var_4

					if var_13_1 == var_4.TACTICS_META_UNLOCK_SKILL_DONE then
						local var_13_12 = arg_13_0.viewComponent

						var_4.OnUpdateMetaSkillPanel(var_13_12, var_13_2.metaShipID)
					else
						GAME = var_4

						if var_13_1 == var_4.TACTICS_META_SWITCH_SKILL_DONE then
							local var_13_13 = arg_13_0.viewComponent

							var_4.OnUpdateMetaSkillPanel(var_13_13, var_13_2.metaShipID)
						else
							GAME = var_4

							if var_13_1 == var_4.QUICK_FINISH_LEARN_TACTICS_DONE then
								local var_13_14 = arg_13_0.viewComponent

								var_4.BlockEvents(var_13_14)

								local var_13_15 = arg_13_0.viewComponent

								var_4.OnUpdateQuickFinishPanel(var_13_15)
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
