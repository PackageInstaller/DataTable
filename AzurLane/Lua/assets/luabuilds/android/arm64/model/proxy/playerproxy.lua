class = var_0_10000

local var_0_0 = "PlayerProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.UPDATED = "PlayerProxy.UPDATED"

function var_0_1.register(arg_1_0)
	arg_1_0._flags = {}
	arg_1_0.combatFleetId = 1
	arg_1_0.mainBGShiftFlag = false
	arg_1_0.inited = false
	arg_1_0.botHelp = false
	arg_1_0.playerAssists = {}
	arg_1_0.playerGuildAssists = {}
	arg_1_0.summaryInfo = nil

	arg_1_0:on(11000, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.TIME_SYNCHRONIZATION, arg_2_0)

		return
	end)
	arg_1_0:on(11003, function(arg_3_0)
		Player = var_2_10001

		local var_3_0 = var_2_10001.New(arg_3_0)

		pg = var_2_10002

		local var_3_1 = var_2_10002.TimeMgr.GetInstance()

		var_3_0.resUpdateTm = var_2.GetServerTime(var_3_1)

		local var_3_2 = arg_1_0

		var_2.updatePlayer(var_3_2, var_3_0)

		pg = var_2

		local var_3_3 = var_2.ShipFlagMgr.GetInstance()

		var_2.UpdateFlagShips(var_3_3, "inAdmiral")

		pg = var_2

		local var_3_4 = var_2.NewStoryMgr.GetInstance()
		local var_3_5 = var_2.SetData
		local var_3_6

		if not arg_3_0.story_list then
			var_3_6 = {}
		end

		var_3_5(var_3_4, var_3_6)

		print = var_3_5

		local var_3_7 = "days from regist time to new :"
		local var_3_8 = arg_1_0.data

		var_3_5(var_3_7 .. var_5.GetDaysFromRegister(var_3_8))

		local var_3_9 = arg_1_0.data

		if var_2.GetDaysFromRegister(var_3_9) == 1 then
			pg = var_2

			local var_3_10 = var_2.TrackerMgr.GetInstance()
			local var_3_11 = var_2.Tracking

			TRACKING_2D_RETENTION = var_5

			var_3_11(var_3_10, var_5)
		else
			local var_3_12 = arg_1_0.data

			if var_2.GetDaysFromRegister(var_3_12) == 6 then
				pg = var_2

				local var_3_13 = var_2.TrackerMgr.GetInstance()
				local var_3_14 = var_2.Tracking

				TRACKING_7D_RETENTION = var_5

				var_3_14(var_3_13, var_5)
			end
		end

		local var_3_15 = arg_1_0.data
		local var_3_16 = var_2.updateAttireFrame

		AttireConst = var_5

		local var_3_17 = var_5.TYPE_COMBAT_UI_STYLE
		local var_3_18

		if not arg_3_0.battle_ui then
			var_3_18 = 0
		end

		var_3_16(var_3_15, var_3_17, var_3_18)
		var_0_1.SetDeviceMaxPlayerLevel(var_3_0.level)

		return
	end)
	arg_1_0:on(11004, function(arg_4_0)
		if not arg_1_0.data then
			return
		end

		local var_4_0 = arg_1_0.data
		local var_4_1 = var_1.clone(var_4_0)

		var_1.updateResources(var_4_1, arg_4_0.resource_list)

		pg = var_2

		local var_4_2 = var_2.TimeMgr.GetInstance()

		var_1.resUpdateTm = var_2.GetServerTime(var_4_2)

		local var_4_3 = arg_1_0

		var_2.updatePlayer(var_4_3, var_1)

		local var_4_4 = arg_1_0.data

		if var_2.isFull(var_4_4) then
			-- block empty
		end

		return
	end)
	arg_1_0:on(10999, function(arg_5_0)
		local var_5_0 = arg_5_0.reason

		LOGOUT_NEW_VERSION = var_2_10002

		if var_5_0 == var_2_10002 then
			getProxy = var_5_0
			SettingsProxy = var_2_10003
			var_5_0(var_2_10003).lastRequestVersionTime = nil
		else
			local var_5_1 = arg_1_0
			local var_5_2 = var_1.sendNotification

			GAME = var_2_10004

			var_5_2(var_5_1, var_2_10004.LOGOUT, {
				code = arg_5_0.reason
			})
		end

		return
	end)
	arg_1_0:on(11015, function(arg_6_0)
		local var_6_0 = arg_1_0.data
		local var_6_1 = var_1.clone(var_6_0)

		var_6_1.buff_list = {}
		ipairs = var_2

		for iter_6_0, iter_6_1 in var_2(arg_6_0.buff_list) do
			local var_6_2 = {
				id = iter_6_1.id,
				timestamp = iter_6_1.timestamp
			}

			table = var_8

			var_8.insert(var_6_1.buff_list, var_6_2)
		end

		local var_6_3 = arg_1_0

		var_2.updatePlayer(var_6_3, var_6_1)

		return
	end)
	arg_1_0:on(11503, function(arg_7_0)
		getProxy = var_2_10001
		ShopsProxy = var_2_10003

		local var_7_0 = var_2_10001(var_2_10003)

		var_1.removeChargeTimer(var_7_0, arg_7_0.pay_id)

		local var_7_1 = arg_1_0
		local var_7_2 = var_2.sendNotification

		GAME = var_5

		var_7_2(var_7_1, var_5.CHARGE_SUCCESS, {
			shopId = arg_7_0.shop_id,
			payId = arg_7_0.pay_id,
			gem = arg_7_0.gem,
			gem_free = arg_7_0.gem_free
		})

		return
	end)
	arg_1_0:on(11802, function(arg_8_0)
		local var_8_0 = arg_1_0.data
		local var_8_1 = var_1.clone(var_8_0)

		var_1.SetCommonFlag(var_8_1, arg_8_0.id, arg_8_0.value == 1)

		local var_8_2 = arg_1_0

		var_2.updatePlayer(var_8_2, var_1)

		return
	end)

	return
end

function var_0_1.timeCall(arg_9_0)
	local var_9_0 = {}

	ProxyRegister = var_1_10002
	var_9_0[var_1_10002.DayCall] = function(arg_10_0)
		local var_10_0 = arg_9_0
		local var_10_1 = var_1.getData(var_10_0)

		var_1.resetBuyOilCount(var_10_1)

		pairs = var_2

		for iter_10_0, iter_10_1 in var_2(var_1.vipCards) do
			if iter_10_1:isExpire() then
				var_1.vipCards[iter_10_1.id] = nil
			end
		end

		local var_10_2 = arg_9_0

		var_2.updatePlayer(var_10_2, var_1)

		return
	end

	return var_9_0
end

function var_0_1.remove(arg_11_0)
	return
end

function var_0_1.getSummaryInfo(arg_12_0)
	return arg_12_0.summaryInfo
end

function var_0_1.setSummaryInfo(arg_13_0, arg_13_1)
	arg_13_0.summaryInfo = arg_13_1

	return
end

function var_0_1.updatePlayer(arg_14_0, arg_14_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_14_0 = arg_14_1

	Player = var_1_10007

	var_1_10002(var_1_10004(var_14_0, var_1_10007), "should be an instance of Player")

	if arg_14_0.data then
		local var_14_1 = arg_14_0
		local var_14_2 = arg_14_0.sendNotification

		GAME = var_5

		var_14_2(var_14_1, var_5.ON_PLAYER_RES_CHANGE, {
			oldPlayer = arg_14_0.data,
			newPlayer = arg_14_1
		})
	end

	arg_14_0.data = arg_14_1:clone()

	local var_14_3 = arg_14_0.data

	var_2.display(var_14_3, "updated")
	arg_14_0:sendNotification(var_0_1.UPDATED, arg_14_1:clone())

	return
end

function var_0_1.UpdatePlayerRes(arg_15_0, arg_15_1)
	if not arg_15_0.data then
		return
	end

	local var_15_0 = {}
	local var_15_1 = {}

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(arg_15_1) do
		id2res = var_1_10009
		var_1_10009 = var_1_10009(iter_15_1.id)

		if iter_15_1.count < 0 then
			defaultValue = var_10
			var_15_1[var_1_10009] = var_10(var_15_1[var_1_10009], 0) - iter_15_1.count
		else
			defaultValue = var_10
			var_15_0[var_1_10009] = var_10(var_15_0[var_1_10009], 0) + iter_15_1.count
		end
	end

	local var_15_2 = arg_15_0.data
	local var_15_3 = var_4.clone(var_15_2)

	var_4.addResources(var_15_3, var_15_0)
	var_4:consume(var_15_1)
	arg_15_0:updatePlayer(var_4)

	return
end

function var_0_1.updatePlayerMedalDisplay(arg_16_0, arg_16_1)
	arg_16_0.data.displayTrophyList = arg_16_1

	return
end

function var_0_1.getPlayerId(arg_17_0)
	return arg_17_0.data.id
end

function var_0_1.setFlag(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._flags[arg_18_1] = arg_18_2

	return
end

function var_0_1.getFlag(arg_19_0, arg_19_1)
	return arg_19_0._flags[arg_19_1]
end

function var_0_1.isSelf(arg_20_0, arg_20_1)
	return arg_20_0.data.id == arg_20_1
end

function var_0_1.setInited(arg_21_0, arg_21_1)
	arg_21_0.inited = arg_21_1

	return
end

function var_0_1.getInited(arg_22_0)
	return arg_22_0.inited
end

function var_0_1.setRefundInfo(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_1 and #arg_23_1 > 0 then
		var_23_0 = {}
		ipairs = var_3

		for iter_23_0, iter_23_1 in var_3(arg_23_1) do
			table = var_1_10008

			var_1_10008.insert(var_23_0, {
				shopId = iter_23_1.shop_id,
				buyTime = iter_23_1.buy_time,
				refundTime = iter_23_1.refund_time
			})
		end
	end

	arg_23_0.refundInfo = var_23_0

	return
end

function var_0_1.getRefundInfo(arg_24_0)
	if not arg_24_0.refundInfo then
		return nil
	end

	if #arg_24_0.refundInfo <= 0 then
		return nil
	end

	return arg_24_0.refundInfo
end

function var_0_1.IsShowCommssionTip(arg_25_0)
	getProxy = var_1_10001
	EventProxy = var_1_10003

	local var_25_0 = var_1_10001(var_1_10003)
	local var_25_1 = var_1.hasFinishState(var_25_0)

	getProxy = var_1_10003
	NavalAcademyProxy = var_1_10005

	local var_25_2 = var_1_10003(var_1_10005)
	local var_25_3 = arg_25_0:getRawData()
	local var_25_4 = var_25_2:GetOilVO()
	local var_25_5 = var_25_2:GetGoldVO()
	local var_25_6 = var_25_2:GetClassVO()
	local var_25_7 = var_25_4:isCommissionNotify(var_25_3.oilField)
	local var_25_8 = var_25_5:isCommissionNotify(var_25_3.goldField)
	local var_25_9 = var_25_6:GetGenResCnt()
	local var_25_10 = var_25_6
	local var_25_11 = var_25_6.GetEffectAttrs(var_25_10)
	local var_25_12 = 0

	ipairs = var_25_10

	for iter_25_0, iter_25_1 in var_25_10(var_25_11) do
		if iter_25_1.attrName == "stock" then
			var_25_12 = iter_25_1.value
		end
	end

	NotifyTipHelper = var_13

	local var_25_13 = var_13.ShouldShowUrTip()
	local var_25_14 = var_25_2
	local var_25_15 = var_25_2.getStudents(var_25_14)
	local var_25_16 = 0

	_ = var_25_14

	local var_25_17 = var_25_14.each

	_ = var_1_10018

	var_25_17(var_1_10018.values(var_25_15), function(arg_26_0)
		local var_26_0 = arg_26_0:getFinishTime()

		pg = var_2_10002

		local var_26_1 = var_2_10002.TimeMgr.GetInstance()

		if var_26_0 <= var_2.GetServerTime(var_26_1) then
			var_25_16 = var_25_16 + 1
		end

		return
	end)

	local var_25_18 = 0

	_ = iter_25_1

	local var_25_19 = iter_25_1.each

	getProxy = var_19
	TechnologyProxy = var_1_10021

	local var_25_20 = var_19(var_1_10021)

	var_25_19(var_19.getPlanningTechnologys(var_25_20), function(arg_27_0)
		if arg_27_0:isCompleted() then
			var_25_18 = var_25_18 + 1
		end

		return
	end)

	WorldBossConst = var_25_19

	local var_25_21 = var_25_19.GetCommissionSceneMetaBossBtnState()

	CommissionMetaBossBtn = var_18

	local var_25_22

	if var_18.STATE_GET_AWARDS ~= var_25_21 then
		CommissionMetaBossBtn = var_18

		if var_18.STATE_FINSH_BATTLE ~= var_25_21 then
			var_25_22 = false

			goto label_25_0
		end
	end

	var_25_22 = true

	::label_25_0::

	getProxy = var_19
	ActivityProxy = var_25_20

	local var_25_23 = var_19(var_25_20)
	local var_25_24 = var_19.getAliveActivityByType

	ActivityConst = var_1_10022

	local var_25_25 = var_25_24(var_25_23, var_1_10022.ACTIVITY_TYPE_PT_CRUSING)
	local var_25_26 = false

	if var_25_25 and not var_25_25:isEnd() then
		var_25_26 = #var_25_25:GetCrusingUnreceiveAward() > 0
	end

	return var_25_22 or var_25_1 or var_25_7 or var_25_8 or var_25_12 ~= 0 and var_25_9 > var_25_12 - 10 or var_25_13 or var_25_16 > 0 or var_25_18 > 0 or var_25_26
end

function var_0_1.SetDeviceMaxPlayerLevel(arg_28_0)
	if arg_28_0 > var_0_1.GetDeviceMaxPlayerLevel() then
		PlayerPrefs = var_1_10002

		var_1_10002.SetInt("DeviceMaxPlayerLevel", arg_28_0)

		PlayerPrefs = var_2

		var_2.Save()
	end

	return
end

function var_0_1.GetDeviceMaxPlayerLevel()
	PlayerPrefs = var_1_10000

	return var_1_10000.GetInt("DeviceMaxPlayerLevel", 0)
end

return var_0_1
