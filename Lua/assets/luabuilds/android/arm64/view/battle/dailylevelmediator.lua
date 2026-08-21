local var_0_0 = class("DailyLevelMediator", import("..base.ContextMediator"))

var_0_0.ON_STAGE = "DailyLevelMediator:ON_STAGE"
var_0_0.ON_CHALLENGE = "DailyLevelMediator:ON_CHALLENGE"
var_0_0.ON_RESET_CHALLENGE = "DailyLevelMediator:ON_RESET_CHALLENGE"
var_0_0.ON_CONTINUE_CHALLENGE = "DailyLevelMediator:ON_CONTINUE_CHALLENGE"
var_0_0.ON_CHALLENGE_EDIT_FLEET = "DailyLevelMediator:ON_CHALLENGE_EDIT_FLEET"
var_0_0.ON_REQUEST_CHALLENGE = "DailyLevelMediator:ON_REQUEST_CHALLENGE"
var_0_0.ON_CHALLENGE_FLEET_CLEAR = "DailyLevelMediator.ON_CHALLENGE_FLEET_CLEAR"
var_0_0.ON_CHALLENGE_FLEET_RECOMMEND = "DailyLevelMediator.ON_CHALLENGE_FLEET_RECOMMEND"
var_0_0.ON_QUICK_BATTLE = "DailyLevelMediator:ON_QUICK_BATTLE"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(DailyLevelProxy)

	arg_1_0.viewComponent:setDailyCounts(getProxy(DailyLevelProxy):getRawData())

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:setShips(arg_1_0.ships)
	arg_1_0.viewComponent:updateRes((getProxy(PlayerProxy):getData()))
	arg_1_0.viewComponent:setActivity(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DAILY_STAGE_BONUS))
	arg_1_0:bind(var_0_0.ON_QUICK_BATTLE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:CheckShipExpItemOverflow(arg_2_2, function()
			arg_1_0:sendNotification(GAME.DAILY_LEVEL_QUICK_BATTLE, {
				dailyLevelId = arg_2_1,
				stageId = arg_2_2,
				cnt = arg_2_3
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.ON_STAGE, function(arg_4_0, arg_4_1)
		var_1_0.dailyLevelId = arg_1_0.contextData.dailyLevelId

		local var_4_0 = PreCombatLayer
		local var_4_1 = SYSTEM_ROUTINE

		if pg.expedition_data_template[arg_4_1.id].type == Stage.SubmarinStage then
			var_4_0 = PreCombatLayerSubmarine
			var_4_1 = SYSTEM_SUB_ROUTINE
		end

		arg_1_0:addSubLayers(Context.New({
			mediator = PreCombatMediator,
			viewComponent = var_4_0,
			data = {
				stageId = arg_4_1.id,
				system = var_4_1,
				OnConfirm = function(arg_5_0)
					arg_1_0:CheckShipExpItemOverflow(arg_4_1.id, arg_5_0)

					return
				end
			}
		}))

		return
	end)

	return
end

function var_0_0.CheckShipExpItemOverflow(arg_6_0, arg_6_1, arg_6_2)
	if _.any(pg.expedition_data_template[arg_6_1].award_display, function(arg_7_0)
		local var_7_0 = getProxy(BagProxy):getItemCountById(arg_7_0[2])
		local var_7_1 = Item.getConfigData(arg_7_0[2])

		return arg_7_0[1] == DROP_TYPE_ITEM and var_7_1.type == Item.EXP_BOOK_TYPE and var_7_0 >= var_7_1.max_num
	end) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("player_expResource_mail_fullBag"),
			onYes = arg_6_2
		})
	else
		arg_6_2()
	end

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		PlayerProxy.UPDATED,
		GAME.DAILY_LEVEL_QUICK_BATTLE_DONE,
		GAME.REMOVE_LAYERS
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == PlayerProxy.UPDATED then
		arg_9_0.viewComponent:updateRes(var_9_1)
	elseif var_9_0 == GAME.DAILY_LEVEL_QUICK_BATTLE_DONE then
		if #var_9_1.awards > 0 then
			arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
		end

		local var_9_2 = getProxy(DailyLevelProxy)

		arg_9_0.viewComponent:setDailyCounts(var_9_2:getRawData())
		arg_9_0.viewComponent:UpdateBattleBtn({
			id = var_9_1.stageId
		})
		arg_9_0.viewComponent:UpdateDailyLevelCnt(var_9_1.dailyLevelId)
		arg_9_0.viewComponent:UpdateDailyLevelCntForDescPanel(var_9_1.dailyLevelId)
	elseif var_9_0 == GAME.REMOVE_LAYERS and var_9_1.context.mediator.__cname == "PreCombatMediator" then
		setActive(arg_9_0.viewComponent.blurPanel, true)
	end

	return
end

return var_0_0
