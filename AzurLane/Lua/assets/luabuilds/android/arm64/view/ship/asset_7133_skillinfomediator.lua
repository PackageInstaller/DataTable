class = var_0_10000

local var_0_0 = "SkillInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.WARP_TO_TACTIC = "SkillInfoMediator:WARP_TO_TACTIC"
var_0_1.WARP_TO_META_TACTICS = "SkillInfoMediator:WARP_TO_METATASK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.WARP_TO_TACTIC, function(arg_2_0)
		getProxy = var_2_10001
		NavalAcademyProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1 = var_1.getStudents(var_2_0)
		local var_2_2 = 0
		local var_2_3 = 0
		local var_2_4 = var_1.MAX_SKILL_CLASS_NUM

		for iter_2_0 = 1, var_2_4 do
			if var_2_1[iter_2_0] then
				var_2_2 = var_2_2 + 1
			else
				var_2_3 = iter_2_0

				break
			end
		end

		local var_2_5

		if var_2_2 >= var_1:getSkillClassNum() then
			pg = var_2_5
			iter_2_0 = var_2_5.TipsMgr.GetInstance()
			var_2_5 = var_2_5.ShowTips
			i18n = var_2_10010

			var_2_5(iter_2_0, var_2_10010("tactics_lesson_full"))

			iter_2_0 = arg_1_0.viewComponent

			var_2_5.close(iter_2_0)

			return
		end

		getProxy = var_2_5
		BagProxy = iter_2_0

		local var_2_6 = var_2_5(iter_2_0)
		local var_2_7 = var_7.getItemsByType

		Item = var_2_10011

		local var_2_8 = var_2_7(var_2_6, var_2_10011.LESSON_TYPE)

		table = iter_2_0

		local var_2_10

		if iter_2_0.getCount(var_2_8 or {}) <= 0 then
			pg = var_2_10

			local var_2_9 = var_2_10.TipsMgr.GetInstance()

			var_2_10 = var_2_10.ShowTips
			i18n = var_2_10012

			var_2_10(var_2_9, var_2_10012("tactics_no_lesson"))

			local var_2_11 = arg_1_0.viewComponent

			var_2_10.close(var_2_11)

			return
		end

		pairs = var_2_10

		for iter_2_1, iter_2_2 in var_2_10(var_2_1) do
			if iter_2_2.shipId == arg_1_0.contextData.shipId then
				pg = var_14

				local var_2_12 = var_14.TipsMgr.GetInstance()
				local var_2_13 = var_14.ShowTips

				i18n = var_2_10017

				var_2_13(var_2_12, var_2_10017("tactics_lesson_repeated"))

				local var_2_14 = arg_1_0.viewComponent

				var_14.close(var_2_14)

				return
			end
		end

		local var_2_15 = arg_1_0.viewComponent

		var_9.close(var_2_15)

		local var_2_16 = arg_1_0
		local var_2_17 = var_9.sendNotification

		GAME = iter_2_1

		local var_2_18 = iter_2_1.GO_SCENE

		SCENE = iter_2_2

		local var_2_19 = iter_2_2.NAVALACADEMYSCENE
		local var_2_20 = {}

		NavalAcademyScene = var_2_10015
		var_2_20.warp = var_2_10015.WARP_TO_TACTIC
		var_2_20.shipToLesson = {
			shipId = arg_1_0.contextData.shipId,
			skillIndex = arg_1_0.contextData.index,
			index = var_2_3
		}

		var_2_17(var_2_16, var_2_18, var_2_19, var_2_20)

		return
	end)
	arg_1_0:bind(var_0_1.WARP_TO_META_TACTICS, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.viewComponent

		var_2.close(var_3_0)

		local var_3_1 = arg_1_0
		local var_3_2 = var_2.sendNotification

		GAME = var_2_10005

		local var_3_3 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_3_2(var_3_1, var_3_3, var_2_10006.METACHARACTER, {
			autoOpenTactics = true,
			autoOpenShipConfigID = arg_3_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_1
