class = var_0_10000

local var_0_0 = "SkillInfoMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.WARP_TO_TACTIC = "SkillInfoMediator:WARP_TO_TACTIC"
var_0_1.WARP_TO_META_TACTICS = "SkillInfoMediator:WARP_TO_METATASK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.WARP_TO_TACTIC, function(arg_2_0)
		getProxy = var_2_10001
		NavalAcademyProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
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

		local var_2_5 = var_1
		local var_2_6

		if var_2_2 >= var_1.getSkillClassNum(var_2_5) then
			pg = var_2_5
			var_2_6 = var_2_5.TipsMgr.GetInstance()
			var_2_5 = var_2_5.ShowTips
			i18n = iter_2_0

			var_2_5(var_2_6, iter_2_0("tactics_lesson_full"))

			var_2_6 = arg_1_0.viewComponent

			var_2_5.close(var_2_6)

			return
		end

		getProxy = var_2_5
		BagProxy = var_2_6

		local var_2_7 = var_2_5(var_2_6)
		local var_2_8 = var_7.getItemsByType

		Item = var_2_10010

		local var_2_9 = var_2_8(var_2_7, var_2_10010.LESSON_TYPE)

		table = var_2_7

		local var_2_11

		if var_2_7.getCount(var_2_9 or {}) <= 0 then
			pg = var_2_11

			local var_2_10 = var_2_11.TipsMgr.GetInstance()

			var_2_11 = var_2_11.ShowTips
			i18n = var_2_10011

			var_2_11(var_2_10, var_2_10011("tactics_no_lesson"))

			local var_2_12 = arg_1_0.viewComponent

			var_2_11.close(var_2_12)

			return
		end

		pairs = var_2_11

		for iter_2_1, iter_2_2 in var_2_11(var_2_1) do
			if iter_2_2.shipId == arg_1_0.contextData.shipId then
				pg = var_2_10014

				local var_2_13 = var_2_10014.TipsMgr.GetInstance()

				var_2_10014 = var_2_10014.ShowTips
				i18n = var_2_10016

				var_2_10014(var_2_13, var_2_10016("tactics_lesson_repeated"))

				local var_2_14 = arg_1_0.viewComponent

				var_2_10014.close(var_2_14)

				return
			end
		end

		local var_2_15 = arg_1_0.viewComponent

		var_9.close(var_2_15)

		local var_2_16 = arg_1_0
		local var_2_17 = var_9.sendNotification

		GAME = var_11

		local var_2_18 = var_11.GO_SCENE

		SCENE = iter_2_1

		local var_2_19 = iter_2_1.NAVALACADEMYSCENE
		local var_2_20 = {}

		NavalAcademyScene = var_2_10014
		var_2_20.warp = var_2_10014.WARP_TO_TACTIC
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

		GAME = var_2_10004

		local var_3_3 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_3_2(var_3_1, var_3_3, var_2_10005.METACHARACTER, {
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
