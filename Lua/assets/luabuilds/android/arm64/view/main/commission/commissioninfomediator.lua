local var_0_0 = class("CommissionInfoMediator", import("...base.ContextMediator"))

var_0_0.FINISH_EVENT = "CommissionInfoMediator.FINISH_EVENT"
var_0_0.FINISH_CLASS = "CommissionInfoMediator.FINISH_CLASS"
var_0_0.GET_OIL_RES = "CommissionInfoMediator.GET_OIL_RES"
var_0_0.GET_GOLD_RES = "CommissionInfoMediator.GET_GOLD_RES"
var_0_0.ON_ACTIVE_EVENT = "CommissionInfoMediator.ON_ACTIVE_EVENT"
var_0_0.ON_ACTIVE_CLASS = "CommissionInfoMediator.ON_ACTIVE_CLASS"
var_0_0.ON_ACTIVE_TECH = "CommissionInfoMediator.ON_ACTIVE_TECH"
var_0_0.ON_TECH_FINISHED = "CommissionInfoMediator.ON_TECH_FINISHED"
var_0_0.ON_TECH_QUEUE_FINISH = "CommissionInfoMediator.ON_TECH_QUEUE_FINISH"
var_0_0.ON_INS = "CommissionInfoMediator.ON_INS"
var_0_0.ON_UR_ACTIVITY = "CommissionInfoMediator:ON_UR_ACTIVITY"
var_0_0.ON_CRUSING = "CommissionInfoMediator.ON_CRUSING"
var_0_0.GET_CLASS_RES = "CommissionInfoMediator:GET_CLASS_RES"
var_0_0.FINISH_CLASS_ALL = "CommissionInfoMediator:FINISH_CLASS_ALL"
var_0_0.GO_META_BOSS = "CommissionInfoMediator:GO_META_BOSS"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
	arg_1_0:bind(var_0_0.GO_META_BOSS, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.WORLDBOSS)

		return
	end)
	arg_1_0:bind(var_0_0.ON_UR_ACTIVITY, function(arg_3_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.UR_ITEM_ACT_ID
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CRUSING, function(arg_4_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

		return
	end)
	arg_1_0:bind(var_0_0.GET_CLASS_RES, function(arg_5_0)
		arg_1_0:sendNotification(GAME.HARVEST_CLASS_RES)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TECH_QUEUE_FINISH, function(arg_6_0)
		arg_1_0:sendNotification(GAME.FINISH_QUEUE_TECHNOLOGY)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TECH_FINISHED, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.FINISH_TECHNOLOGY, {
			id = arg_7_1.id,
			pool_id = arg_7_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_0.FINISH_EVENT, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0.contextData.oneStepFinishEventCount = arg_8_2
		arg_1_0.contextData.inFinished = true

		arg_1_0:sendNotification(GAME.EVENT_FINISH, {
			id = arg_8_1.id,
			callback = function()
				arg_1_0.contextData.inFinished = nil

				return
			end,
			onConfirm = function()
				if arg_8_3 then
					arg_8_3()
				end

				if arg_1_0.contextData.oneStepFinishEventCount then
					arg_1_0.contextData.oneStepFinishEventCount = arg_1_0.contextData.oneStepFinishEventCount - 1

					if arg_1_0.contextData.oneStepFinishEventCount <= 0 then
						MainMetaSkillSequence.New():Execute()
					end
				else
					MainMetaSkillSequence.New():Execute()
				end

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.FINISH_CLASS, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		arg_1_0:sendNotification(GAME.CANCEL_LEARN_TACTICS, {
			shipId = arg_11_1,
			type = arg_11_2,
			onConfirm = arg_11_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVE_EVENT, function(arg_12_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EVENT)

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVE_CLASS, function(arg_13_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVE_TECH, function(arg_14_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)

		return
	end)
	arg_1_0:bind(var_0_0.GET_OIL_RES, function(arg_15_0)
		arg_1_0:sendNotification(GAME.HARVEST_RES, PlayerConst.ResOil)

		return
	end)
	arg_1_0:bind(var_0_0.GET_GOLD_RES, function(arg_16_0)
		arg_1_0:sendNotification(GAME.HARVEST_RES, PlayerConst.ResGold)

		return
	end)
	arg_1_0:bind(var_0_0.ON_INS, function(arg_17_0)
		arg_1_0:sendNotification(GAME.ON_OPEN_INS_LAYER)
		arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)
	arg_1_0:bind(var_0_0.FINISH_CLASS_ALL, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

		return
	end)
	arg_1_0:Notify()

	return
end

function var_0_0.Notify(arg_19_0)
	arg_19_0.viewComponent:NotifyIns()
	arg_19_0.viewComponent:UpdateLinkPanel()

	return
end

function var_0_0.continueClass(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if table.getCount(getProxy(BagProxy):getItemsByType(Item.LESSON_TYPE) or {}) <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))

		return
	end

	arg_20_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS, {
		shipToLesson = {
			shipId = arg_20_1,
			skillIndex = getProxy(BayProxy):getShipById(arg_20_1):getSkillIndex(arg_20_2),
			index = arg_20_3
		}
	})

	return
end

function var_0_0.listNotificationInterests(arg_21_0)
	return {
		PlayerProxy.UPDATED,
		GAME.HARVEST_RES_DONE,
		GAME.EVENT_LIST_UPDATE,
		GAME.EVENT_FINISH_UPDATE,
		GAME.EVENT_SHOW_AWARDS,
		GAME.CANCEL_LEARN_TACTICS_DONE,
		GAME.FINISH_TECHNOLOGY_DONE,
		GAME.FINISH_QUEUE_TECHNOLOGY_DONE
	}
end

function var_0_0.handleNotification(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:getName()
	local var_22_1 = arg_22_1:getBody()

	if var_22_0 == PlayerProxy.UPDATED then
		arg_22_0.viewComponent:OnPlayerUpdate(var_22_1)
	elseif var_22_0 == GAME.HARVEST_RES_DONE then
		local var_22_2

		if var_22_1.type == 2 then
			var_22_2 = i18n("word_oil")
		elseif var_22_1.type == 1 then
			var_22_2 = i18n("word_gold")
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("commission_get_award", var_22_2, var_22_1.outPut))
	elseif var_22_0 == GAME.EVENT_LIST_UPDATE or var_22_0 == GAME.EVENT_FINISH_UPDATE then
		local var_22_3 = getProxy(EventProxy)

		arg_22_0.viewComponent:OnUpdateEventInfo()
	elseif var_22_0 == GAME.EVENT_SHOW_AWARDS then
		local var_22_4

		coroutine.wrap(function()
			if #var_22_1.oldShips > 0 then
				arg_22_0.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
					title = pg.collection_template[var_22_1.eventId].title,
					oldShips = var_22_1.oldShips,
					newShips = var_22_1.newShips,
					isCri = var_22_1.isCri
				}, var_22_4)
				coroutine.yield()
			end

			arg_22_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_22_1.awards, function()
				if var_22_1.onConfirm then
					var_22_1.onConfirm()
				end

				return
			end)

			return
		end)()
	elseif var_22_0 == GAME.CANCEL_LEARN_TACTICS_DONE then
		arg_22_0.viewComponent:OnUpdateClass()

		local var_22_5 = var_22_1.totalExp
		local var_22_6 = var_22_1.newSkill
		local var_22_7 = getProxy(BayProxy):getShipById(var_22_1.shipId)
		local var_22_8 = var_22_1.newSkill.id
		local var_22_9 = var_22_1.newSkill.level > var_22_1.oldSkill.level and i18n("tactics_end_to_learn", var_22_7:getName(), getSkillName(var_22_8), var_22_5) .. i18n("tactics_skill_level_up", var_22_1.oldSkill.level, var_22_6.level) or i18n("tactics_end_to_learn", var_22_7:getName(), getSkillName(var_22_8), var_22_5)

		if pg.skill_data_template[var_22_8].max_level <= var_22_6.level then
			arg_22_0:HandleClassMaxLevel(var_22_7, var_22_1, var_22_8, var_22_5)
		else
			({
				modal = true,
				hideNo = false,
				hideClose = true
			}).content = var_22_9 .. i18n("tactics_continue_to_learn")
			;({
				modal = true,
				hideNo = false,
				hideClose = true
			}).onYes = function()
				arg_22_0.openMsgBox = false

				arg_22_0:continueClass(var_22_1.shipId, var_22_8, var_22_1.id)

				return
			end
			;({
				modal = true,
				hideNo = false,
				hideClose = true
			}).onNo = function()
				arg_22_0.openMsgBox = false

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				hideNo = false,
				hideClose = true
			})
		end
	elseif var_22_0 == GAME.FINISH_TECHNOLOGY_DONE then
		arg_22_0.viewComponent:OnUpdateTechnology()

		if #var_22_1.items > 0 then
			arg_22_0.viewComponent:emit(BaseUI.ON_AWARD, {
				animation = true,
				items = var_22_1.items
			})
		end
	elseif var_22_0 == GAME.FINISH_QUEUE_TECHNOLOGY_DONE then
		arg_22_0.viewComponent:OnUpdateTechnology()

		for iter_22_0, iter_22_1 in ipairs(var_22_1.dropInfos) do
			if #iter_22_1 > 0 then
				table.insert({}, function(arg_27_0)
					arg_22_0.viewComponent:emit(BaseUI.ON_AWARD, {
						animation = true,
						items = iter_22_1,
						removeFunc = arg_27_0
					})

					return
				end)
			end
		end

		seriesAsync({}, function()
			local var_28_0 = getProxy(TechnologyProxy):getActivateTechnology()

			if var_28_0 and var_28_0:isCompleted() then
				arg_22_0:sendNotification(GAME.FINISH_TECHNOLOGY, {
					id = var_28_0.id,
					pool_id = var_28_0.poolId
				})
			end

			return
		end)
	end

	return
end

function var_0_0.HandleClassMaxLevel(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = i18n("tactics_end_to_learn", arg_29_1:getName(), getSkillName(arg_29_3), arg_29_4)

	if _.all(arg_29_1:getSkillList(), function(arg_30_0)
		return ShipSkill.New(arg_29_1.skills[arg_30_0]):IsMaxLevel()
	end) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideClose = true,
			content = var_29_0 .. i18n("tactics_continue_to_learn_other_ship_skill"),
			onYes = function()
				arg_29_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

				return
			end
		})
	else
		({
			modal = true,
			hideClose = true
		}).content = var_29_0 .. i18n("tactics_continue_to_learn_other_skill")
		;({
			modal = true,
			hideClose = true
		}).onYes = function()
			arg_29_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS, {
				shipToLesson = {
					shipId = arg_29_2.shipId,
					index = arg_29_2.id
				}
			})

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideClose = true
		})
	end

	return
end

return var_0_0
