class = var_0_10000

local var_0_0 = "BossRushDALCollabMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_FLEET_SELECT = "BossRushDALCollabMediator:ON_FLEET_SELECT"
var_0_1.ON_PERFORM_COMBAT = "BossRushDALCollabMediator:ON_PERFORM_COMBAT"
var_0_1.ON_UPGRADE = "BossRushDALCollabMediator:ON_UPGRADE"
var_0_1.GO_SHOPS_LAYER = "BossRushDALCollabMediator:GO_SHOPS_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		BossRushFleetSelectMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		BossRushDALFleetSelectView = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {
			seriesData = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.GO_SHOPS_LAYER, function(arg_3_0, arg_3_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10003

		local var_3_0 = var_2_10002(var_2_10003)

		if not var_2.getActivityById(var_3_0, arg_3_1.actId) then
			pg = var_3_0

			local var_3_1 = var_3_0.TipsMgr.GetInstance()
			local var_3_2 = var_3.ShowTips

			i18n = var_2_10005

			var_3_2(var_3_1, var_2_10005("common_activity_end"))

			return
		end

		local var_3_3 = arg_1_0
		local var_3_4 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_5 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		local var_3_6 = var_2_10006.SHOP

		if not arg_3_1 then
			::label_3_0::

			var_2_10007 = {}
			NewShopsScene = var_2_10008
			var_2_10007.warp = var_2_10008.TYPE_ACTIVITY
		end

		var_3_4(var_3_3, var_3_5, var_3_6, var_2_10007)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
	local var_1_4 = arg_1_0.viewComponent

	var_3.SetActivity(var_1_4, var_1_3)

	local var_1_5 = var_1
	local var_1_6 = var_1.getActivityByType

	ActivityConst = var_5

	local var_1_7 = var_1_6(var_1_5, var_5.ACTIVITY_TYPE_BUILDING_BUFF)
	local var_1_8 = arg_1_0.viewComponent

	var_4.SetUpgradeActvity(var_1_8, var_1_7)

	local var_1_9 = var_1_3:getConfig("config_client").PTID
	local var_1_10 = arg_1_0.viewComponent
	local var_1_11 = var_5.SetPTActivity

	underscore = var_1_10007

	local var_1_12 = var_1_10007.detect
	local var_1_13 = var_1
	local var_1_14 = var_1.getActivitiesByType

	ActivityConst = var_1_10010

	var_1_11(var_1_10, var_1_12(var_1_14(var_1_13, var_1_10010.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		return arg_4_0:getConfig("config_id") == var_1_9
	end))

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.sendNotification

	GAME = var_7

	var_1_16(var_1_15, var_7.COLLABRATE_BOSS_RUSH_REQUEST_DATA, {
		actId = var_1_3.id
	})

	local var_1_17 = arg_1_0.viewComponent

	var_5.addbubbleMsgBox(var_1_17, function(arg_5_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_5_0 = var_2_10001(var_2_10002)
		local var_5_1 = var_1.getCurrentContext(var_5_0)
		local var_5_2 = var_1.getContextByMediator

		BossRushTotalRewardPanelMediator = var_2_10003

		if var_5_2(var_5_1, var_2_10003) then
			return
		end

		arg_5_0()

		return
	end)

	local var_1_18 = arg_1_0.viewComponent

	var_5.addbubbleMsgBox(var_1_18, function(arg_6_0)
		pg = var_2_10001

		local var_6_0 = var_2_10001.GuildMsgBoxMgr.GetInstance()

		var_1.NotificationForBattle(var_6_0, arg_6_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPGRADE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.ACTIVITY_OPERATION, arg_7_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	ActivityProxy = var_1_10002
	var_8_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_8_0[2] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_8_0[3] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_8_0[4] = var_2.BEGIN_STAGE_DONE
	BossRushTotalRewardPanelMediator = var_2
	var_8_0[5] = var_2.ON_WILL_EXIT
	GAME = var_2
	var_8_0[6] = var_2.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()
	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.getType(var_9_2)

	if var_9_0 == nil then
		-- block empty
	else
		GAME = var_9_2

		local var_9_4

		if var_9_0 == var_9_2.BEGIN_STAGE_DONE then
			getProxy = var_9_4
			ContextProxy = var_1_10006
			var_1_10006 = var_9_4(var_1_10006)
			var_9_4 = var_9_4.getContextByMediator
			BossRushPreCombatMediator = var_1_10007

			if not var_9_4(var_1_10006, var_1_10007) then
				var_1_10007 = arg_9_0
				var_1_10006 = arg_9_0.sendNotification
				GAME = var_1_10008

				local var_9_5 = var_1_10008.GO_SCENE

				SCENE = var_1_10009

				var_1_10006(var_1_10007, var_9_5, var_1_10009.COMBATLOAD, var_9_1)
			end
		else
			ActivityProxy = var_9_4

			if var_9_0 == var_9_4.ACTIVITY_UPDATED then
				if var_9_1 then
					if var_5.id == arg_9_0.viewComponent.activity.id then
						var_1_10007 = arg_9_0.viewComponent

						var_1_10006.SetActivity(var_1_10007, var_5)

						var_1_10007 = arg_9_0.viewComponent

						var_1_10006.UpdateView(var_1_10007)
					end

					var_1_10007 = var_5
					var_1_10006 = var_5.getConfig(var_1_10007, "type")
					ActivityConst = var_1_10007

					if var_1_10006 == var_1_10007.ACTIVITY_TYPE_BUILDING_BUFF then
						var_1_10007 = arg_9_0.viewComponent.upgradeView

						var_1_10006.SetData(var_1_10007, var_5)

						var_1_10007 = arg_9_0.viewComponent.upgradeView

						var_1_10006.UpdateView(var_1_10007)
					end
				end
			else
				GAME = var_5

				local var_9_6

				if var_9_0 == var_5.SUBMIT_ACTIVITY_TASK_DONE then
					var_1_10006 = arg_9_0.viewComponent
					var_9_6 = var_9_6.emit
					BaseUI = var_1_10007

					var_9_6(var_1_10006, var_1_10007.ON_ACHIEVE, var_9_1.awards, function()
						local var_10_0 = arg_9_0.viewComponent

						var_0.UpdateTasks(var_10_0, var_9_3)

						return
					end)
				else
					BossRushTotalRewardPanelMediator = var_9_6

					if var_9_0 == var_9_6.ON_WILL_EXIT then
						var_1_10006 = arg_9_0.viewComponent

						var_5.resumeBubble(var_1_10006)

						var_1_10006 = arg_9_0.viewComponent

						var_5.UpdateView(var_1_10006)
					else
						GAME = var_5

						if var_9_0 == var_5.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE then
							getProxy = var_5
							ActivityProxy = var_1_10006

							local var_9_7 = var_5(var_1_10006)
							local var_9_8 = var_5.getActivityByType

							ActivityConst = var_1_10007

							local var_9_9 = var_9_8(var_9_7, var_1_10007.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
							local var_9_10 = arg_9_0.viewComponent

							var_6.SetActivity(var_9_10, var_9_9)

							local var_9_11 = arg_9_0.viewComponent

							var_6.UpdateView(var_9_11)
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.remove(arg_11_0)
	return
end

return var_0_1
