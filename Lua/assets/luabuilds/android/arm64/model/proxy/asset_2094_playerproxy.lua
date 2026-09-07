local PlayerProxy = class("PlayerProxy", import(".NetProxy"))

PlayerProxy.UPDATED = "PlayerProxy.UPDATED"

function PlayerProxy:register()
	self._flags = {}
	self.combatFleetId = 1
	self.mainBGShiftFlag = false
	self.inited = false
	self.botHelp = false
	self.playerAssists = {}
	self.playerGuildAssists = {}
	self.summaryInfo = nil

	self:on(11000, function(arg_2_0)
		self:sendNotification(GAME.TIME_SYNCHRONIZATION, arg_2_0)

		return
	end)
	self:on(11003, function(arg_3_0)
		local var_3_0 = Player.New(arg_3_0)

		var_3_0.resUpdateTm = pg.TimeMgr.GetInstance():GetServerTime()

		self:updatePlayer(var_3_0)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inAdmiral")
		pg.NewStoryMgr.GetInstance():SetData(arg_3_0.story_list or {})
		print("days from regist time to new :" .. self.data:GetDaysFromRegister())

		if self.data:GetDaysFromRegister() == 1 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_2D_RETENTION)
		elseif self.data:GetDaysFromRegister() == 6 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_7D_RETENTION)
		end

		self.data:updateAttireFrame(AttireConst.TYPE_COMBAT_UI_STYLE, arg_3_0.battle_ui or 0)
		PlayerProxy.SetDeviceMaxPlayerLevel(var_3_0.level)

		return
	end)
	self:on(11004, function(arg_4_0)
		if not self.data then
			return
		end

		local var_4_0 = self.data:clone()

		var_4_0:updateResources(arg_4_0.resource_list)

		var_4_0.resUpdateTm = pg.TimeMgr.GetInstance():GetServerTime()

		self:updatePlayer(var_4_0)

		if self.data:isFull() then
			-- block empty
		end

		return
	end)
	self:on(10999, function(arg_5_0)
		if arg_5_0.reason == LOGOUT_NEW_VERSION then
			getProxy(SettingsProxy).lastRequestVersionTime = nil
		else
			self:sendNotification(GAME.LOGOUT, {
				code = arg_5_0.reason
			})
		end

		return
	end)
	self:on(11015, function(arg_6_0)
		local var_6_0 = self.data:clone()

		var_6_0.buff_list = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_0.buff_list) do
			table.insert(var_6_0.buff_list, {
				id = iter_6_1.id,
				timestamp = iter_6_1.timestamp
			})
		end

		self:updatePlayer(var_6_0)

		return
	end)
	self:on(11503, function(arg_7_0)
		getProxy(ShopsProxy):removeChargeTimer(arg_7_0.pay_id)
		self:sendNotification(GAME.CHARGE_SUCCESS, {
			shopId = arg_7_0.shop_id,
			payId = arg_7_0.pay_id,
			gem = arg_7_0.gem,
			gem_free = arg_7_0.gem_free
		})

		return
	end)
	self:on(11802, function(arg_8_0)
		local var_8_0 = self.data:clone()

		var_8_0:SetCommonFlag(arg_8_0.id, arg_8_0.value == 1)
		self:updatePlayer(var_8_0)

		return
	end)

	return
end

function PlayerProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_10_0)
			local var_10_0 = self:getData()

			var_10_0:resetBuyOilCount()

			for iter_10_0, iter_10_1 in pairs(var_10_0.vipCards) do
				if iter_10_1:isExpire() then
					var_10_0.vipCards[iter_10_1.id] = nil
				end
			end

			self:updatePlayer(var_10_0)

			return
		end
	}
end

function PlayerProxy:remove()
	return
end

function PlayerProxy:getSummaryInfo()
	return self.summaryInfo
end

function PlayerProxy:setSummaryInfo(arg_13_1)
	self.summaryInfo = arg_13_1

	return
end

function PlayerProxy:updatePlayer(arg_14_1)
	assert(isa(arg_14_1, Player), "should be an instance of Player")

	if self.data then
		self:sendNotification(GAME.ON_PLAYER_RES_CHANGE, {
			oldPlayer = self.data,
			newPlayer = arg_14_1
		})
	end

	self.data = arg_14_1:clone()

	self.data:display("updated")
	self:sendNotification(PlayerProxy.UPDATED, arg_14_1:clone())

	return
end

function PlayerProxy:UpdatePlayerRes(arg_15_1)
	if not self.data then
		return
	end

	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_2 = id2res(iter_15_1.id)

		if iter_15_1.count < 0 then
			var_15_1[var_15_2] = defaultValue(var_15_1[var_15_2], 0) - iter_15_1.count
		else
			var_15_0[var_15_2] = defaultValue(var_15_0[var_15_2], 0) + iter_15_1.count
		end
	end

	local var_15_3 = self.data:clone()

	var_15_3:addResources(var_15_0)
	var_15_3:consume(var_15_1)
	self:updatePlayer(var_15_3)

	return
end

function PlayerProxy:updatePlayerMedalDisplay(arg_16_1)
	self.data.displayTrophyList = arg_16_1

	return
end

function PlayerProxy:getPlayerId()
	return self.data.id
end

function PlayerProxy:setFlag(arg_18_1, arg_18_2)
	self._flags[arg_18_1] = arg_18_2

	return
end

function PlayerProxy:getFlag(arg_19_1)
	return self._flags[arg_19_1]
end

function PlayerProxy:isSelf(arg_20_1)
	return self.data.id == arg_20_1
end

function PlayerProxy:setInited(arg_21_1)
	self.inited = arg_21_1

	return
end

function PlayerProxy:getInited()
	return self.inited
end

function PlayerProxy:setRefundInfo(arg_23_1)
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

	self.refundInfo = var_23_0

	return
end

function PlayerProxy:getRefundInfo()
	if not self.refundInfo then
		return nil
	end

	if #self.refundInfo <= 0 then
		return nil
	end

	return self.refundInfo
end

function PlayerProxy:IsShowCommssionTip()
	local var_25_0 = getProxy(EventProxy):hasFinishState()
	local var_25_1 = getProxy(NavalAcademyProxy)
	local var_25_2 = self:getRawData()
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

	return var_25_12 or var_25_0 or var_25_4 or var_25_5 or var_25_7 ~= 0 and var_25_6 > var_25_7 - 10 or var_25_8 or var_25_9 > 0 or var_25_10 > 0 or (var_25_13 and not var_25_13:isEnd() or nil) and #var_25_13:GetCrusingUnreceiveAward() > 0 or getProxy(ChapterAutoProxy):IsShowTip()
end

function PlayerProxy:SetDeviceMaxPlayerLevel()
	if self > PlayerProxy.GetDeviceMaxPlayerLevel() then
		PlayerPrefs.SetInt("DeviceMaxPlayerLevel", self)
		PlayerPrefs.Save()
	end

	return
end

function PlayerProxy.GetDeviceMaxPlayerLevel()
	return PlayerPrefs.GetInt("DeviceMaxPlayerLevel", 0)
end

return PlayerProxy
