local var_0_0 = 3
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.drop_info
local var_0_4 = g.core.model.User.firstRechargeData
local FirstRechargePop = class("FirstRechargePop", require("app.fairyGUI.firstRecharge.firstRecharge.UI_FirstRechargePop"), function()
	return fgui.GComponent:create({
		pkgName = "firstRecharge",
		pkgPath = "ui/firstRecharge/firstRecharge",
		resName = var_0_4:getFirstRechargePopResName()
	})
end)

function FirstRechargePop:ctor()
	self._showList = {}
	self._showItem = {}
	self._schedule = nil
	self._inClose = false
	self._sendDays = {}
	self._hasSendSkinAward = false
	self._sendCount = 0
	self._allStagingAward = {}
	self._isEnterFinish = false
	self._isGetInfo = false

	self:showAtCenter()
	self:initView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FIRST_RECHARGE)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_FIRST_RECHARGE)
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FIRST_RECHARGE_ENTER)
	self.m_enterTransition:play(handler(self, self.enterFinish))

	self._effect = self.m_effectComp:addEffectSpine({
		isLoop = false,
		anim = "enter",
		name = "eff_ui_NewFirstRechargeCN_enter"
	})
end

function FirstRechargePop:initView()
	self.m_goBtn:addClickListener(handler(self, self.onClickGoBtn))
	self.m_loaderBtn:addClickListener(handler(self, self._onClickLoaderBtn))
	self.m_showTouch:addClickListener(handler(self, self._onClickLoaderBtn))
	self.m_closeBtn:addClickListener(handler(self, self._onClickClose))
	self.m_showList:setIniter()
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowList))
	self.m_showList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
	self.m_btnEffect:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_NewFirstRechargeCN_paybtn"
	})

	local var_3_0 = var_0_4:getFirstRechargeActId()

	self.m_bgLoader:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_510050_3.png")
	self.m_skinBgLoader:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_51005001_3.png")
	self.m_shadowLoader:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_510050_1.png")
	self.m_skinShadowLoader:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_51005001_1.png")
	self.m_roleLoader:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_510050_2.png")
	self.m_skinRoleLoader:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_51005001_2.png")

	local var_3_1 = self:getChild("effLoader")

	if var_3_1 then
		var_3_1:setURL("pic/firstRecharge/" .. var_3_0 .. "/pic_sc_gf_51005001_4.png")
	end

	local var_3_2 = self:getController("isSexy")

	if var_3_2 then
		if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
			var_3_2:setSelectedIndex(0)
		else
			var_3_2:setSelectedIndex(1)
		end
	end
end

function FirstRechargePop:enterFinish()
	self._isEnterFinish = true

	self:checkSend()
end

function FirstRechargePop:_onClickCell(arg_5_1)
	local var_5_0 = self._showList[arg_5_1:getDataValue() + 1]

	if not var_5_0 then
		return
	end

	g.core.common.GlobalFunc.pushInfoPop(var_5_0)
end

function FirstRechargePop:_onRenderShowList(arg_6_1, arg_6_2)
	local var_6_0 = var_0_2:convert(self._showList[arg_6_1 + 1])

	arg_6_2:setIcon(var_6_0.icon)
	arg_6_2:setTitle(var_6_0.size)
end

function FirstRechargePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvChargeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFIRSTRECHARGEAWARD, handler(self, self._onGetDayAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD, handler(self, self._onGetTimesAward), self)

	self._isGetInfo = false

	g.core.network.GameNetProxy:send_C2S_Recharge_GetRecharge({})
	self:updateView()
end

function FirstRechargePop:addSchedule()
	local var_8_0, var_8_1 = var_0_4:getActivityTime()
	local var_8_2 = var_0_1:getTime()

	if var_0_4:isRecharged() and var_8_0 <= var_8_2 and var_8_2 <= var_8_1 and not self._schedule then
		self._schedule = self:newSchedule(handler(self, self._updateTime), 1)

		self:_updateTime()
	end
end

function FirstRechargePop:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_Recharge_GetRecharge({})
end

function FirstRechargePop:_updateTime()
	local var_10_0, var_10_1 = var_0_4:getActivityTime()
	local var_10_2

	if var_10_1 < var_0_1:getTime() then
		self:_onClickClose()

		do return end

		var_10_2 = {}
	end

	var_10_2.time = var_0_1:getLeftDHMSFormat(var_10_1)

	self.m_timeText:setText(g.core.lang:get(405502, var_10_2))
end

function FirstRechargePop:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "FirstRechargePop_dayComp_playEnd" then
		self:showAwardSummary()

		return true
	end
end

function FirstRechargePop:showAwardSummary()
	if next(self._allStagingAward) then
		g.core.module.ModuleManager:awardSummary(self._allStagingAward, false, nil, nil, handler(self, self.awardSummaryEnd))

		self._allStagingAward = {}
	else
		self:awardSummaryEnd()
	end
end

function FirstRechargePop:awardSummaryEnd()
	if not self or not self._sendDays then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(self._sendDays) do
		if iter_13_1 == 0 then
			self._effect:setAnimation(0, "change", false)
			self.m_enterTransition:play()
		end
	end

	self:updateView()

	self._sendDays = {}
end

function FirstRechargePop:_onGetDayAward(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	table.insertto(self._allStagingAward, arg_14_4.awards or {})
	self:_onGetReward()
end

function FirstRechargePop:_onGetTimesAward(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	table.insertto(self._allStagingAward, arg_15_4.award or {})
	self:_onGetReward()
	self:updateSkinView()
end

function FirstRechargePop:_onGetReward()
	self._sendCount = self._sendCount - 1

	if self._sendCount <= 0 then
		if self._sendDays then
			local var_16_0 = false

			for iter_16_0, iter_16_1 in ipairs(self._sendDays) do
				if iter_16_1 > 0 then
					var_16_0 = true

					local var_16_1 = self["m_day" .. iter_16_1]

					self["m_day" .. iter_16_1]:updateCompByReward(var_0_4:getDayCellData(iter_16_1))
					var_16_1:playGetEff(iter_16_0 == #self._sendDays)
				end
			end

			if not var_16_0 then
				self:showAwardSummary()
			end
		else
			self:showAwardSummary()
		end
	end
end

function FirstRechargePop:_recvChargeInfo(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self._isGetInfo = true

	self:checkSend()
end

function FirstRechargePop:checkSend()
	if self._isEnterFinish and self._isGetInfo then
		if var_0_4:isRecharged() and self._sendCount <= 0 then
			local var_18_0 = {}

			for iter_18_0 = 0, var_0_0 do
				local var_18_1 = var_0_4:getDayCellData(iter_18_0)

				if var_18_1.canGet and not var_18_1.isGet then
					table.insert(var_18_0, iter_18_0)
				end
			end

			if #var_18_0 > 0 then
				g.core.network.GameNetProxy:send_C2S_Recharge_GetFirstRechargeAward({
					day = var_18_0
				})

				self._sendDays = var_18_0
				self._sendCount = self._sendCount + 1
			end

			if var_0_4:isSecondRechargeEnough() and not var_0_4:isGetTimesRechargeAward() then
				g.core.network.GameNetProxy:send_C2S_Recharge_First_Recharge_GetRechargeAward({})

				self._hasSendSkinAward = true
				self._sendCount = self._sendCount + 1
			end
		end

		if self._sendCount <= 0 then
			self:updateView()
		end
	end
end

function FirstRechargePop:updateView()
	for iter_19_0 = 1, var_0_0 do
		self["m_day" .. iter_19_0]:updateCompByReward(var_0_4:getDayCellData(iter_19_0))
	end

	if var_0_4:isRecharged() and var_0_4:isGetFirstAward() then
		self.m_showBgController:setSelectedIndex(1)

		if var_0_4:getTimeRechargeAward().type ~= var_0_2.TYPE_SKIN then
			self.m_showGroup:setVisible(false)
		end

		self.m_hasTimeController:setSelectedIndex(1)
		self:updateSkinView()
	else
		self.m_showBgController:setSelectedIndex(0)
		self.m_hasTimeController:setSelectedIndex(0)
		self:updateShowList()
	end

	self:addSchedule()
end

function FirstRechargePop:updateSkinView()
	if var_0_4:getCurDay() <= 1 then
		self.m_skinViewStateController:setSelectedIndex(0)
	elseif var_0_4:isGetTimesRechargeAward() then
		self.m_skinViewStateController:setSelectedIndex(2)
	else
		self.m_skinViewStateController:setSelectedIndex(1)
	end
end

function FirstRechargePop:updateShowList()
	local var_21_0 = var_0_4:getInfo().special
	local var_21_1 = var_0_3.get(var_0_4:getInfo().first_value, 1)

	self._showItem = {
		type = var_21_1["reward_type_" .. var_21_0],
		value = var_21_1["reward_value_" .. var_21_0],
		size = var_21_1["reward_min_" .. var_21_0]
	}

	self.m_showIcon:updateIcon(self._showItem)

	self._showList = {}

	while var_0_3.hasKey("reward_type_" .. 1) do
		if 1 ~= var_21_0 then
			if var_21_1["reward_type_" .. 1] > 0 then
				table.insert(self._showList, {
					type = var_21_1["reward_type_" .. 1],
					value = var_21_1["reward_value_" .. 1],
					size = var_21_1["reward_min_" .. 1]
				})
			end
		end
	end

	self.m_showList:setNumItems(#self._showList)
end

function FirstRechargePop:onClickGoBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE
	})
end

function FirstRechargePop:_onClickLoaderBtn()
	if var_0_4:isRecharged() then
		g.core.common.GlobalFunc.pushInfoPop((var_0_4:getTimeRechargeAward()))
	else
		g.core.common.GlobalFunc.pushInfoPop(self._showItem)
	end
end

function FirstRechargePop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_UPRETE_HOME_ACTIVITY_LIST)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function FirstRechargePop:onUnload()
	self._schedule = nil
end

return FirstRechargePop
