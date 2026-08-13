class = var_0_10000

local var_0_0 = "BossRushDALCollabMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_FLEET_SELECT = "BossRushDALCollabMediator:ON_FLEET_SELECT"
var_0_1.ON_PERFORM_COMBAT = "BossRushDALCollabMediator:ON_PERFORM_COMBAT"
var_0_1.ON_UPGRADE = "BossRushDALCollabMediator:ON_UPGRADE"
var_0_1.GO_SHOPS_LAYER = "BossRushDALCollabMediator:GO_SHOPS_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		BossRushFleetSelectMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		BossRushDALFleetSelectView = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {
			seriesData = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.GO_SHOPS_LAYER, function(arg_3_0, arg_3_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10004

		local var_3_0 = var_2_10002(var_2_10004)

		if not var_2.getActivityById(var_3_0, arg_3_1.actId) then
			pg = var_2_10003

			local var_3_1 = var_2_10003.TipsMgr.GetInstance()
			local var_3_2 = var_3.ShowTips

			i18n = var_2_10006

			var_3_2(var_3_1, var_2_10006("common_activity_end"))

			return
		end

		local var_3_3 = arg_1_0
		local var_3_4 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_5 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_3_6 = var_2_10007.SHOP

		if not arg_3_1 then
			::label_3_0::

			var_2_10008 = {}
			NewShopsScene = var_2_10009
			var_2_10008.warp = var_2_10009.TYPE_ACTIVITY
		end

		var_3_4(var_3_3, var_3_5, var_3_6, var_2_10008)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_5

	local var_1_3 = var_1_2(var_1_1, var_5.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
	local var_1_4 = arg_1_0.viewComponent

	var_3.SetActivity(var_1_4, var_1_3)

	local var_1_5 = var_1
	local var_1_6 = var_1.getActivityByType

	ActivityConst = var_6

	local var_1_7 = var_1_6(var_1_5, var_6.ACTIVITY_TYPE_BUILDING_BUFF)
	local var_1_8 = arg_1_0.viewComponent

	var_4.SetUpgradeActvity(var_1_8, var_1_7)

	local var_1_9 = var_1_3:getConfig("config_client").PTID
	local var_1_10 = arg_1_0.viewComponent
	local var_1_11 = var_5.SetPTActivity

	underscore = var_1_10008

	local var_1_12 = var_1_10008.detect
	local var_1_13 = var_1
	local var_1_14 = var_1.getActivitiesByType

	ActivityConst = var_1_10013

	var_1_11(var_1_10, var_1_12(var_1_14(var_1_13, var_1_10013.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		return arg_4_0:getConfig("config_id") == var_1_9
	end))

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.sendNotification

	GAME = var_8

	var_1_16(var_1_15, var_8.COLLABRATE_BOSS_RUSH_REQUEST_DATA, {
		actId = var_1_3.id
	})

	local var_1_17 = arg_1_0.viewComponent

	var_5.addbubbleMsgBox(var_1_17, function(arg_5_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_5_0 = var_2_10001(var_2_10003)
		local var_5_1 = var_1.getCurrentContext(var_5_0)
		local var_5_2 = var_1.getContextByMediator

		BossRushTotalRewardPanelMediator = var_2_10004

		if var_5_2(var_5_1, var_2_10004) then
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

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.ACTIVITY_OPERATION, arg_7_1)

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
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)
	local var_9_3 = arg_9_1:getType()

	if var_9_0 == nil then
		-- block empty
	else
		GAME = var_9_1

		local var_9_4

		if var_9_0 == var_9_1.BEGIN_STAGE_DONE then
			getProxy = var_9_4
			ContextProxy = var_1_10007
			var_1_10007 = var_9_4(var_1_10007)
			var_9_4 = var_9_4.getContextByMediator
			BossRushPreCombatMediator = var_1_10008

			if not var_9_4(var_1_10007, var_1_10008) then
				var_1_10008 = arg_9_0

				local var_9_5 = arg_9_0.sendNotification

				GAME = var_1_10009

				local var_9_6 = var_1_10009.GO_SCENE

				SCENE = var_1_10010

				var_9_5(var_1_10008, var_9_6, var_1_10010.COMBATLOAD, var_9_2)
			end
		else
			ActivityProxy = var_9_4

			if var_9_0 == var_9_4.ACTIVITY_UPDATED then
				if var_9_2 then
					if var_5.id == arg_9_0.viewComponent.activity.id then
						var_1_10008 = arg_9_0.viewComponent

						var_6.SetActivity(var_1_10008, var_5)

						var_1_10008 = arg_9_0.viewComponent

						var_6.UpdateView(var_1_10008)
					end

					var_1_10008 = var_5

					local var_9_7 = var_5.getConfig(var_1_10008, "type")

					ActivityConst = var_1_10007

					if var_9_7 == var_1_10007.ACTIVITY_TYPE_BUILDING_BUFF then
						var_1_10008 = arg_9_0.viewComponent.upgradeView

						var_6.SetData(var_1_10008, var_5)

						var_1_10008 = arg_9_0.viewComponent.upgradeView

						var_6.UpdateView(var_1_10008)
					end
				end
			else
				GAME = var_5

				local var_9_8

				if var_9_0 == var_5.SUBMIT_ACTIVITY_TASK_DONE then
					var_1_10007 = arg_9_0.viewComponent
					var_9_8 = var_9_8.emit
					BaseUI = var_1_10008

					var_9_8(var_1_10007, var_1_10008.ON_ACHIEVE, var_9_2.awards, function()
						local var_10_0 = arg_9_0.viewComponent

						var_0.UpdateTasks(var_10_0, var_9_3)

						return
					end)
				else
					BossRushTotalRewardPanelMediator = var_9_8

					if var_9_0 == var_9_8.ON_WILL_EXIT then
						var_1_10007 = arg_9_0.viewComponent

						var_5.resumeBubble(var_1_10007)

						var_1_10007 = arg_9_0.viewComponent

						var_5.UpdateView(var_1_10007)
					else
						GAME = var_5

						if var_9_0 == var_5.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE then
							getProxy = var_5
							ActivityProxy = var_1_10007

							local var_9_9 = var_5(var_1_10007)
							local var_9_10 = var_5.getActivityByType

							ActivityConst = var_1_10008

							local var_9_11 = var_9_10(var_9_9, var_1_10008.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
							local var_9_12 = arg_9_0.viewComponent

							var_6.SetActivity(var_9_12, var_9_11)

							local var_9_13 = arg_9_0.viewComponent

							var_6.UpdateView(var_9_13)
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
