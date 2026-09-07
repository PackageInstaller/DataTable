local DailyLevelMediator = class("DailyLevelMediator", import("..base.ContextMediator"))

DailyLevelMediator.ON_STAGE = "DailyLevelMediator:ON_STAGE"
DailyLevelMediator.ON_CHALLENGE = "DailyLevelMediator:ON_CHALLENGE"
DailyLevelMediator.ON_RESET_CHALLENGE = "DailyLevelMediator:ON_RESET_CHALLENGE"
DailyLevelMediator.ON_CONTINUE_CHALLENGE = "DailyLevelMediator:ON_CONTINUE_CHALLENGE"
DailyLevelMediator.ON_CHALLENGE_EDIT_FLEET = "DailyLevelMediator:ON_CHALLENGE_EDIT_FLEET"
DailyLevelMediator.ON_REQUEST_CHALLENGE = "DailyLevelMediator:ON_REQUEST_CHALLENGE"
DailyLevelMediator.ON_CHALLENGE_FLEET_CLEAR = "DailyLevelMediator.ON_CHALLENGE_FLEET_CLEAR"
DailyLevelMediator.ON_CHALLENGE_FLEET_RECOMMEND = "DailyLevelMediator.ON_CHALLENGE_FLEET_RECOMMEND"
DailyLevelMediator.ON_QUICK_BATTLE = "DailyLevelMediator:ON_QUICK_BATTLE"

function DailyLevelMediator:register()
	local var_1_0 = getProxy(DailyLevelProxy)

	self.viewComponent:setDailyCounts(var_1_0:getRawData())

	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:setShips(self.ships)
	self.viewComponent:updateRes((getProxy(PlayerProxy):getData()))
	self.viewComponent:setActivity(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DAILY_STAGE_BONUS))
	self:bind(DailyLevelMediator.ON_QUICK_BATTLE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:CheckShipExpItemOverflow(arg_2_2, function()
			self:sendNotification(GAME.DAILY_LEVEL_QUICK_BATTLE, {
				dailyLevelId = arg_2_1,
				stageId = arg_2_2,
				cnt = arg_2_3
			})

			return
		end)

		return
	end)
	self:bind(DailyLevelMediator.ON_STAGE, function(arg_4_0, arg_4_1)
		var_1_0.dailyLevelId = self.contextData.dailyLevelId

		local var_4_0 = PreCombatLayer
		local var_4_1 = SYSTEM_ROUTINE

		if pg.expedition_data_template[arg_4_1.id].type == Stage.SubmarinStage then
			var_4_0 = PreCombatLayerSubmarine
			var_4_1 = SYSTEM_SUB_ROUTINE
		end

		self:addSubLayers(Context.New({
			mediator = PreCombatMediator,
			viewComponent = var_4_0,
			data = {
				stageId = arg_4_1.id,
				system = var_4_1,
				OnConfirm = function(arg_5_0)
					self:CheckShipExpItemOverflow(arg_4_1.id, arg_5_0)

					return
				end
			}
		}))

		return
	end)

	return
end

function DailyLevelMediator:CheckShipExpItemOverflow(arg_6_1, arg_6_2)
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

function DailyLevelMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.DAILY_LEVEL_QUICK_BATTLE_DONE,
		GAME.REMOVE_LAYERS
	}
end

function DailyLevelMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:updateRes(var_9_1)
	elseif var_9_0 == GAME.DAILY_LEVEL_QUICK_BATTLE_DONE then
		if #var_9_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
		end

		self.viewComponent:setDailyCounts(getProxy(DailyLevelProxy):getRawData())
		self.viewComponent:UpdateBattleBtn({
			id = var_9_1.stageId
		})
		self.viewComponent:UpdateDailyLevelCnt(var_9_1.dailyLevelId)
		self.viewComponent:UpdateDailyLevelCntForDescPanel(var_9_1.dailyLevelId)
	elseif var_9_0 == GAME.REMOVE_LAYERS and var_9_1.context.mediator.__cname == "PreCombatMediator" then
		setActive(self.viewComponent.blurPanel, true)
	end

	return
end

return DailyLevelMediator
