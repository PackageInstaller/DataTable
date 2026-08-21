local var_0_0 = class("PlayerProxy", import(".NetProxy"))

var_0_0.UPDATED = "PlayerProxy.UPDATED"

function var_0_0.register(arg_1_0)
	arg_1_0._flags = {}
	arg_1_0.combatFleetId = 1
	arg_1_0.mainBGShiftFlag = false
	arg_1_0.inited = false
	arg_1_0.botHelp = false
	arg_1_0.playerAssists = {}
	arg_1_0.playerGuildAssists = {}
	arg_1_0.summaryInfo = nil

	arg_1_0:on(11000, function(arg_2_0)
		arg_1_0:sendNotification(GAME.TIME_SYNCHRONIZATION, arg_2_0)

		return
	end)
	arg_1_0:on(11003, function(arg_3_0)
		local var_3_0 = Player.New(arg_3_0)

		var_3_0.resUpdateTm = pg.TimeMgr.GetInstance():GetServerTime()

		arg_1_0:updatePlayer(var_3_0)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inAdmiral")

		local var_3_1 = arg_3_0.story_list or {}

		pg.NewStoryMgr.GetInstance():SetData(var_3_1)
		print("days from regist time to new :" .. arg_1_0.data:GetDaysFromRegister())

		if arg_1_0.data:GetDaysFromRegister() == 1 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_2D_RETENTION)
		elseif arg_1_0.data:GetDaysFromRegister() == 6 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_7D_RETENTION)
		end

		local var_3_3 = arg_3_0.battle_ui or 0

		var_3_2(arg_1_0.data, AttireConst.TYPE_COMBAT_UI_STYLE, var_3_3)
		var_0_0.SetDeviceMaxPlayerLevel(var_3_0.level)

		return
	end)
	arg_1_0:on(11004, function(arg_4_0)
		if not arg_1_0.data then
			return
		end

		local var_4_0 = arg_1_0.data:clone()

		var_4_0:updateResources(arg_4_0.resource_list)

		var_4_0.resUpdateTm = pg.TimeMgr.GetInstance():GetServerTime()

		arg_1_0:updatePlayer(var_4_0)

		if arg_1_0.data:isFull() then
			-- block empty
		end

		return
	end)
	arg_1_0:on(10999, function(arg_5_0)
		if arg_5_0.reason == LOGOUT_NEW_VERSION then
			getProxy(SettingsProxy).lastRequestVersionTime = nil
		else
			arg_1_0:sendNotification(GAME.LOGOUT, {
				code = arg_5_0.reason
			})
		end

		return
	end)
	arg_1_0:on(11015, function(arg_6_0)
		local var_6_0 = arg_1_0.data:clone()

		var_6_0.buff_list = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_0.buff_list) do
			table.insert(var_6_0.buff_list, {
				id = iter_6_1.id,
				timestamp = iter_6_1.timestamp
			})
		end

		arg_1_0:updatePlayer(var_6_0)

		return
	end)
	arg_1_0:on(11503, function(arg_7_0)
		getProxy(ShopsProxy):removeChargeTimer(arg_7_0.pay_id)
		arg_1_0:sendNotification(GAME.CHARGE_SUCCESS, {
			shopId = arg_7_0.shop_id,
			payId = arg_7_0.pay_id,
			gem = arg_7_0.gem,
			gem_free = arg_7_0.gem_free
		})

		return
	end)
	arg_1_0:on(11802, function(arg_8_0)
		local var_8_0 = arg_1_0.data:clone()

		var_8_0:SetCommonFlag(arg_8_0.id, arg_8_0.value == 1)
		arg_1_0:updatePlayer(var_8_0)

		return
	end)

	return
end

function var_0_0.timeCall(arg_9_0)
	return {
		[ProxyRegister.DayCall] = function(arg_10_0)
			local var_10_0 = arg_9_0:getData()

			var_10_0:resetBuyOilCount()

			for iter_10_0, iter_10_1 in pairs(var_10_0.vipCards) do
				if iter_10_1:isExpire() then
					var_10_0.vipCards[iter_10_1.id] = nil
				end
			end

			arg_9_0:updatePlayer(var_10_0)

			return
		end
	}
end

function var_0_0.remove(arg_11_0)
	return
end

function var_0_0.getSummaryInfo(arg_12_0)
	return arg_12_0.summaryInfo
end

function var_0_0.setSummaryInfo(arg_13_0, arg_13_1)
	arg_13_0.summaryInfo = arg_13_1

	return
end

function var_0_0.updatePlayer(arg_14_0, arg_14_1)
	assert(isa(arg_14_1, Player), "should be an instance of Player")

	if arg_14_0.data then
		arg_14_0:sendNotification(GAME.ON_PLAYER_RES_CHANGE, {
			oldPlayer = arg_14_0.data,
			newPlayer = arg_14_1
		})
	end

	arg_14_0.data = arg_14_1:clone()

	arg_14_0.data:display("updated")
	arg_14_0:sendNotification(var_0_0.UPDATED, arg_14_1:clone())

	return
end

function var_0_0.UpdatePlayerRes(arg_15_0, arg_15_1)
	if not arg_15_0.data then
		return
	end

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_1 = id2res(iter_15_1.id)

		if iter_15_1.count < 0 then
			({})[var_15_1] = defaultValue(({})[var_15_1], 0) - iter_15_1.count
		else
			var_15_0[var_15_1] = defaultValue(var_15_0[var_15_1], 0) + iter_15_1.count
		end
	end

	local var_15_2 = arg_15_0.data:clone()

	var_15_2:addResources(var_15_0)
	var_15_2:consume({})
	arg_15_0:updatePlayer(var_15_2)

	return
end

function var_0_0.updatePlayerMedalDisplay(arg_16_0, arg_16_1)
	arg_16_0.data.displayTrophyList = arg_16_1

	return
end

function var_0_0.getPlayerId(arg_17_0)
	return arg_17_0.data.id
end

function var_0_0.setFlag(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._flags[arg_18_1] = arg_18_2

	return
end

function var_0_0.getFlag(arg_19_0, arg_19_1)
	return arg_19_0._flags[arg_19_1]
end

function var_0_0.isSelf(arg_20_0, arg_20_1)
	return arg_20_0.data.id == arg_20_1
end

function var_0_0.setInited(arg_21_0, arg_21_1)
	arg_21_0.inited = arg_21_1

	return
end

function var_0_0.getInited(arg_22_0)
	return arg_22_0.inited
end

function var_0_0.setRefundInfo(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_1 and #arg_23_1 > 0 then
		var_23_0 = {}

		for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
			table.insert(var_23_0, {
				shopId = iter_23_1.shop_id,
				buyTime = iter_23_1.buy_time,
				refundTime = iter_23_1.refund_time
			})
		end
	end

	arg_23_0.refundInfo = var_23_0

	return
end

function var_0_0.getRefundInfo(arg_24_0)
	if not arg_24_0.refundInfo then
		return nil
	end

	if #arg_24_0.refundInfo <= 0 then
		return nil
	end

	return arg_24_0.refundInfo
end

function var_0_0.IsShowCommssionTip(arg_25_0)
	local var_25_0 = getProxy(EventProxy):hasFinishState()
	local var_25_1 = getProxy(NavalAcademyProxy)
	local var_25_2 = arg_25_0:getRawData()
	local var_25_3 = var_25_1:GetClassVO()
	local var_25_4 = var_25_1:GetOilVO():isCommissionNotify(var_25_2.oilField)
	local var_25_5 = var_25_1:GetGoldVO():isCommissionNotify(var_25_2.goldField)
	local var_25_6 = var_25_3:GetGenResCnt()
	local var_25_7 = 0

	for iter_25_0, iter_25_1 in ipairs((var_25_3:GetEffectAttrs())) do
		if iter_25_1.attrName == "stock" then
			var_25_7 = iter_25_1.value
		end
	end

	local var_25_8 = NotifyTipHelper.ShouldShowUrTip()
	local var_25_9 = 0

	_.each(_.values((var_25_1:getStudents())), function(arg_26_0)
		if arg_26_0:getFinishTime() <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_25_9 = var_25_9 + 1
		end

		return
	end)

	local var_25_10 = 0

	_.each(getProxy(TechnologyProxy):getPlanningTechnologys(), function(arg_27_0)
		if arg_27_0:isCompleted() then
			var_25_10 = var_25_10 + 1
		end

		return
	end)

	local var_25_11 = WorldBossConst.GetCommissionSceneMetaBossBtnState()
	local var_25_12 = CommissionMetaBossBtn.STATE_GET_AWARDS == var_25_11 or CommissionMetaBossBtn.STATE_FINSH_BATTLE == var_25_11
	local var_25_13 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)
	local var_25_14 = false

	if var_25_13 and not var_25_13:isEnd() then
		var_25_14 = #var_25_13:GetCrusingUnreceiveAward() > 0
	end

	return var_25_12 or var_25_0 or var_25_4 or var_25_5 or var_25_7 ~= 0 and var_25_6 > var_25_7 - 10 or var_25_8 or var_25_9 > 0 or var_25_10 > 0 or var_25_14
end

function var_0_0.SetDeviceMaxPlayerLevel(arg_28_0)
	if arg_28_0 > var_0_0.GetDeviceMaxPlayerLevel() then
		PlayerPrefs.SetInt("DeviceMaxPlayerLevel", arg_28_0)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetDeviceMaxPlayerLevel()
	return PlayerPrefs.GetInt("DeviceMaxPlayerLevel", 0)
end

return var_0_0
