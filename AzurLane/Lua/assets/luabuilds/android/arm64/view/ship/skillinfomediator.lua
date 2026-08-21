local var_0_0 = class("SkillInfoMediator", import("..base.ContextMediator"))

var_0_0.WARP_TO_TACTIC = "SkillInfoMediator:WARP_TO_TACTIC"
var_0_0.WARP_TO_META_TACTICS = "SkillInfoMediator:WARP_TO_METATASK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.WARP_TO_TACTIC, function(arg_2_0)
		local var_2_0 = getProxy(NavalAcademyProxy)
		local var_2_1 = var_2_0:getStudents()
		local var_2_2 = 0
		local var_2_3 = 0

		for iter_2_0 = 1, var_2_0.MAX_SKILL_CLASS_NUM do
			if var_2_1[iter_2_0] then
				var_2_2 = var_2_2 + 1
			else
				var_2_3 = iter_2_0

				break
			end
		end

		if var_2_2 >= var_2_0:getSkillClassNum() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_lesson_full"))
			arg_1_0.viewComponent:close()

			return
		end

		local var_2_4 = getProxy(BagProxy)

		if table.getCount(var_2_4:getItemsByType(Item.LESSON_TYPE) or {}) <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))
			arg_1_0.viewComponent:close()

			return
		end

		for iter_2_1, iter_2_2 in pairs(var_2_1) do
			if iter_2_2.shipId == arg_1_0.contextData.shipId then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_lesson_repeated"))
				arg_1_0.viewComponent:close()

				return
			end
		end

		arg_1_0.viewComponent:close()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALACADEMYSCENE, {
			warp = NavalAcademyScene.WARP_TO_TACTIC,
			shipToLesson = {
				shipId = arg_1_0.contextData.shipId,
				skillIndex = arg_1_0.contextData.index,
				index = var_2_3
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.WARP_TO_META_TACTICS, function(arg_3_0, arg_3_1)
		arg_1_0.viewComponent:close()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenTactics = true,
			autoOpenShipConfigID = arg_3_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_0
