class = var_0_10000

local var_0_0 = "MetaCharacterTacticsMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.GO_TASK = "MetaCharacterTacticsMediator:GO_TASK"
var_0_1.ON_SUBMIT = "MetaCharacterTacticsMediator:ON_SUBMIT"
var_0_1.ON_TRIGGER = "MetaCharacterTacticsMediator:ON_TRIGGER"
var_0_1.ON_SKILL = "MetaCharacterTacticsMediator:ON_SKILL"
var_0_1.ON_QUICK = "MetaCharacterTacticsMediator:ON_QUICK"

function var_0_1.register(arg_1_0)
	arg_1_0:requestTacticsData()
	arg_1_0:bindEvent()

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.TACTICS_META_INFO_REQUEST_DONE
	GAME = var_2
	var_2_0[2] = var_2.TACTICS_META_UNLOCK_SKILL_DONE
	GAME = var_2
	var_2_0[3] = var_2.TACTICS_META_SWITCH_SKILL_DONE
	GAME = var_2
	var_2_0[4] = var_2.TACTICS_META_LEVELUP_SKILL_DONE
	GAME = var_2
	var_2_0[5] = var_2.META_QUICK_TACTICS_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	GAME = var_3_0

	local var_3_3

	if var_3_1 == var_3_0.TACTICS_META_INFO_REQUEST_DONE then
		var_3_3 = var_3_2

		local var_3_4 = arg_3_0.viewComponent

		var_5.setTacticsData(var_3_4, var_3_3)

		local var_3_5 = arg_3_0.viewComponent

		var_5.updateTacticsRedTag(var_3_5)

		local var_3_6 = arg_3_0.viewComponent

		var_5.updateExpPanel(var_3_6)

		local var_3_7 = arg_3_0.viewComponent

		var_5.updateMain(var_3_7)

		local var_3_8 = arg_3_0.viewComponent

		var_5.updateSkillTFLearning(var_3_8)
	else
		GAME = var_3_3

		local var_3_10

		if var_3_1 == var_3_3.TACTICS_META_UNLOCK_SKILL_DONE then
			local var_3_9 = arg_3_0.viewComponent

			var_3_10 = var_3_10.isAllSkillLock(var_3_9)

			local var_3_11 = arg_3_0.viewComponent

			var_5.updateData(var_3_11)

			local var_3_12 = arg_3_0.viewComponent

			var_5.updateSkillListPanel(var_3_12)

			local var_3_13 = arg_3_0.viewComponent

			var_5.updateMain(var_3_13)

			if var_3_10 then
				local var_3_14 = arg_3_0.viewComponent

				var_5.tryLearnSkillAfterFirstUnlock(var_3_14)
			end

			local var_3_15 = arg_3_0.viewComponent

			var_5.closeUnlockSkillPanel(var_3_15)
		else
			GAME = var_3_10

			local var_3_16

			if var_3_1 == var_3_10.TACTICS_META_SWITCH_SKILL_DONE then
				var_3_16 = var_3_2.skillID

				local var_3_17 = var_3_2.leftSwitchCount
				local var_3_18 = arg_3_0.viewComponent

				var_6.switchTacticsSkillData(var_3_18, var_3_16, var_3_17)

				local var_3_19 = arg_3_0.viewComponent

				var_6.updateExpPanel(var_3_19)

				local var_3_20 = arg_3_0.viewComponent

				var_6.updateTaskPanel(var_3_20, var_3_16)

				local var_3_21 = arg_3_0.viewComponent

				var_6.updateSkillTFLearning(var_3_21)
			else
				GAME = var_3_16

				local var_3_22

				if var_3_1 == var_3_16.TACTICS_META_LEVELUP_SKILL_DONE then
					var_3_22 = var_3_2.skillID

					local var_3_23 = var_3_2.leftSwitchCount
					local var_3_24 = arg_3_0.viewComponent

					var_6.updateData(var_3_24)

					local var_3_25 = arg_3_0.viewComponent

					var_6.levelupTacticsSkillData(var_3_25, var_3_22, var_3_23)

					local var_3_26 = arg_3_0.viewComponent

					var_6.updateTacticsRedTag(var_3_26)

					local var_3_27 = arg_3_0.viewComponent

					var_6.updateSkillListPanel(var_3_27)

					local var_3_28 = arg_3_0.viewComponent

					var_6.updateTaskPanel(var_3_28, var_3_22)
				else
					GAME = var_3_22

					if var_3_1 == var_3_22.META_QUICK_TACTICS_DONE then
						local var_3_29 = var_3_2.skillID
						local var_3_30 = var_3_2.skillExp

						if var_3_2.isLevelUp then
							local var_3_31 = arg_3_0.viewComponent

							var_6.clearTaskInfo(var_3_31, var_3_29)
						end

						local var_3_32 = arg_3_0.viewComponent

						var_6.updateSkillExp(var_3_32, var_3_29, var_3_30)

						local var_3_33 = arg_3_0.viewComponent

						var_6.updateData(var_3_33)

						local var_3_34 = arg_3_0.viewComponent

						var_6.updateTacticsRedTag(var_3_34)

						local var_3_35 = arg_3_0.viewComponent

						var_6.updateSkillListPanel(var_3_35)

						local var_3_36 = arg_3_0.viewComponent

						var_6.updateTaskPanel(var_3_36, var_3_29)
					end
				end
			end
		end
	end

	return
end

function var_0_1.bindEvent(arg_4_0)
	arg_4_0:bind(var_0_1.ON_QUICK, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_4_0
		local var_5_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_5_2 = var_2_10006.New
		local var_5_3 = {}

		MetaQuickTacticsMediator = var_2_10009
		var_5_3.mediator = var_2_10009
		MetaQuickTacticsLayer = var_2_10009
		var_5_3.viewComponent = var_2_10009
		var_5_3.data = {
			shipID = arg_5_1,
			skillID = arg_5_2
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.requestTacticsData(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.sendNotification

	GAME = var_1_10004

	var_6_1(var_6_0, var_1_10004.TACTICS_META_INFO_REQUEST, {
		id = arg_6_0.contextData.shipID
	})

	return
end

return var_0_1
