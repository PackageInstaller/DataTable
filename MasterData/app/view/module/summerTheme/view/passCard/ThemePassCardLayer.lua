local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.config.activity_theme_display_info
local ThemePassCardLayer = class("ThemePassCardLayer", require("app.fairyGUI.themePasscard.UI_ThemePassCardLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemePassCardLayer",
		pkgPath = "ui/themePasscard/themePasscard",
		isFullScreen = true,
		pkgName = "themePasscard"
	}, ...)
end)

function ThemePassCardLayer:ctor(arg_2_1)
	self._themeValue = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	self.m_changePhaseList = self:getChild("changePhaseList")

	self:_initView()
end

function ThemePassCardLayer:_initView()
	self:addBg(var_0_0.THEME_TASK_BG[self._themeValue], nil, nil, 1)

	local var_3_0 = var_0_0.THEME_RES_KEY_ALIAS[self._themeValue] or self._themeValue

	self.m_listBgLoader:setURL(g.core.common.Path:getThemePassCardImage("pic_bg_zl", var_3_0))
	self.m_easyGetBtn:setIcon(g.core.common.Path:getThemePassCardImage("btn_zl_middle1", var_3_0))
	self:_setSprite9Icon((g.core.common.Path:getThemePassCardImage("pic_timedi", var_3_0)))
	self.m_textLoader:setURL(g.core.common.Path:getThemePassCardMulLangImage("txt_activity26_zl_rie", var_3_0))

	local var_3_1 = g.core.config.activity_theme_display_info.get(self._themeValue)

	self.m_topBarComp:setResInfoById(var_3_1.passcard_top_bar)
	self.m_knightPicComp:updateKnight({
		resId = var_3_1.passcard_res
	})
	self.m_easyGetBtn:addClickListener(handler(self, self._onEasyBtnClicked))
	self.m_isEasyController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onStateChanged))
	self.m_topBarComp:setTitle(var_3_1.passcard_name)
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self.m_rewardList:doFairyBatching(false)
	self:_initChangePhaseList()
	self:_onStateChanged()
end

function ThemePassCardLayer:_initChangePhaseList()
	if not self.m_changePhaseList then
		return
	end

	self._mergedValues = var_0_1:getThemeMergeConfigValueList(self._themeValue)

	if #self._mergedValues <= 1 then
		self.m_changePhaseList:setVisible(false)

		return
	end

	self.m_changePhaseList:setVisible(true)
	self.m_changePhaseList:setVirtual()
	self.m_changePhaseList:setItemRenderer(handler(self, self._onChangePhaseItemRender))
	self.m_changePhaseList:setItemProvider(handler(self, self._onChangePhaseItemProvider))
	self.m_changePhaseList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangePhaseListClick))
	self.m_changePhaseList:setNumItems(#self._mergedValues)
end

function ThemePassCardLayer:_onChangePhaseItemRender(arg_5_1, arg_5_2)
	local var_5_0 = self._mergedValues[arg_5_1 + 1]

	arg_5_2:setTitle(var_0_2.get(self._mergedValues[arg_5_1 + 1]).pass_tab)
	arg_5_2:updateTabCell(var_5_0)
	arg_5_2:setSelected(self._themeValue == var_5_0)
end

function ThemePassCardLayer:_onChangePhaseItemProvider()
	return var_0_0.THEME_PASSCARD_CHANGE_ITEM[self._themeValue]
end

function ThemePassCardLayer:_onChangePhaseListClick(arg_7_1)
	local var_7_0 = arg_7_1:getDataValue()

	if var_7_0 >= 0 and self._mergedValues[var_7_0 + 1] then
		local var_7_1 = self._mergedValues[var_7_0 + 1]
		local var_7_2 = var_0_1:getActivityData(self._mergedValues[var_7_0 + 1])
		local var_7_3 = g.core.const.ConstMgr.ActivityConst
		local var_7_4 = var_7_2 and var_7_2:getActivityState()

		if var_7_4 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.START or var_7_4 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.END then
			self:_onChangePhaseItemClick(self._mergedValues[var_7_0 + 1])

			return
		end

		if var_7_4 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.EXPIRE then
			g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		else
			local var_7_5 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_8_0)
				if arg_8_0:getActivityType() == var_7_3.ACTIVITY_TYPE.SUMMER_ACTIVITY then
					return arg_8_0:getConfigActivityValue() == var_7_1
				end
			end)
			local var_7_6 = var_7_5 and var_7_5[1]

			if not (var_7_5 and var_7_5[1]) then
				g.core.module.ModuleManager:tip(g.core.lang:get(1005))
			else
				local var_7_7 = var_7_6:getStartTime() or 0

				if var_7_7 > g.core.common.ServerTime:getTime() then
					local var_7_8, var_7_9, var_7_10, var_7_11 = g.core.common.ServerTime:getLeftTimeParts(var_7_7)

					if var_7_10 > 0 or var_7_11 > 0 then
						var_7_9 = var_7_9 + 1
					end

					g.core.module.ModuleManager:tip(g.core.lang:get(500125, {
						day = var_7_8,
						hour = var_7_9
					}))
				else
					g.core.module.ModuleManager:tip(g.core.lang:get(1008))
				end
			end
		end
	end
end

function ThemePassCardLayer:_onChangePhaseItemClick(arg_9_1)
	if arg_9_1 == self._themeValue then
		return
	end

	self._themeValue = arg_9_1
	self._themeData = g.core.model.User.themeData:getThemeData(arg_9_1)
	require("app.core.common.Provider").reqThemePassCardParam.activity_id = arg_9_1

	self:_refreshThemeUI()
	self.m_changePhaseList:setNumItems(#self._mergedValues)
	self:_reqPassCardInfo()
end

function ThemePassCardLayer:_refreshThemeUI()
	self:addBg(var_0_0.THEME_TASK_BG[self._themeValue], nil, nil, 1)

	local var_10_0 = var_0_0.THEME_RES_KEY_ALIAS[self._themeValue] or self._themeValue

	self.m_listBgLoader:setURL(g.core.common.Path:getThemePassCardImage("pic_bg_zl", var_10_0))
	self.m_easyGetBtn:setIcon(g.core.common.Path:getThemePassCardImage("btn_zl_middle1", var_10_0))
	self:_setSprite9Icon((g.core.common.Path:getThemePassCardImage("pic_timedi", var_10_0)))
	self.m_textLoader:setURL(g.core.common.Path:getThemePassCardMulLangImage("txt_activity26_zl_rie", var_10_0))

	local var_10_1 = g.core.config.activity_theme_display_info.get(self._themeValue)

	self.m_topBarComp:setResInfoById(var_10_1.passcard_top_bar)
	self.m_topBarComp:setTitle(var_10_1.passcard_name)
	self.m_knightPicComp:updateKnight({
		resId = var_10_1.passcard_res
	})
	self.m_easyBtnText:setColor((var_0_0.THEME_ACTIVITY_PASS_CARD_BTN_COLOR[self._themeValue] or var_0_0.THEME_ACTIVITY_PASS_CARD_BTN_COLOR[var_0_0.THEME_VALUE.RIE])[self.m_isEasyController:getSelectedIndex() == 0 and 1 or 2])
end

function ThemePassCardLayer:_setSprite9Icon(arg_11_1)
	local var_11_0 = self.m_timeBgHolder:getSize()
	local var_11_1 = display.newSprite(arg_11_1, {
		scale9 = true,
		capInsets = {
			width = 3,
			height = 22,
			x = 10,
			y = 0
		}
	})

	var_11_1:setContentSize(var_11_0)
	var_11_1:setPosition(cc.p(var_11_0.width / 2, var_11_0.height / 2))
	self.m_timeBgHolder:addNode(var_11_1)
end

function ThemePassCardLayer:_onStateChanged()
	local var_12_0 = var_0_0.THEME_ACTIVITY_PASS_CARD_BTN_COLOR[self._themeValue] or var_0_0.THEME_ACTIVITY_PASS_CARD_BTN_COLOR[var_0_0.THEME_VALUE.RIE]

	self.m_easyBtnText:setColor(self.m_isEasyController:getSelectedIndex() == 0 and var_12_0[1] or var_12_0[2])
end

function ThemePassCardLayer:_onRenderRewardList(arg_13_1, arg_13_2)
	arg_13_2:updatePassCardCell(self._passCardList[arg_13_1 + 1], arg_13_1 + 1, self._themeValue)
end

function ThemePassCardLayer:_addCustomEvent()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_GETINFO, handler(self, self._onPassCardInfoReceive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_GETAWARD, handler(self, self._onPassCardAwardReceive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_UPDATEACTION, handler(self, self._onPassCardTaskUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onRechargeAwardReceive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._reqPassCardInfo), self)
end

function ThemePassCardLayer:onLoad()
	self:_addCustomEvent()

	self._themeData = g.core.model.User.themeData:getThemeData(self._themeValue)
	self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._refreshActivityCountDown), 60)

	self:_refreshActivityCountDown()

	if self._needReqInfo then
		self:_reqPassCardInfo()
	else
		self:_updateLayer()
	end
end

function ThemePassCardLayer:onUnload()
	if self._cdScheduler then
		self:cancelSchedule(self._cdScheduler)
	end

	self._cdScheduler = nil
	self._needReqInfo = true
end

function ThemePassCardLayer:_checkTime()
	return g.core.model.User.themeData:getThemeMergeEntranceActivityData(self._themeValue):getExpireTime() > g.core.common.ServerTime:getTime()
end

function ThemePassCardLayer:_reqPassCardInfo()
	if not self:_checkTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	g.core.network.GameNetProxy:send_C2S_ThemePasscard_GetInfo({
		activity_id = self._themeValue
	})
end

function ThemePassCardLayer:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "req_free_award" then
		self:_reqGetFreeAward({
			arg_19_2.id
		})

		return true
	elseif arg_19_1 == "do_pay_item" then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, arg_19_2.rechargeInfo, self._themeValue, arg_19_2.id)

		return true
	end
end

function ThemePassCardLayer:_reqGetFreeAward(arg_20_1)
	g.core.network.GameNetProxy:send_C2S_ThemePasscard_GetAward({
		activity_id = self._themeValue,
		passcard_ids = arg_20_1
	})
end

function ThemePassCardLayer:_updateLayer()
	self._passCardList = self._themeData:getPassCardData():getPassCardInfoList()

	self.m_rewardList:setNumItems(#self._passCardList)

	if #self._themeData:getPassCardData():getAllFreeAwardPassId() > 0 then
		self.m_isEasyController:setSelectedIndex(1)
	else
		self.m_isEasyController:setSelectedIndex(0)
	end

	if self._needReqInfo == nil or self._needReqInfo == true then
		self.m_enterTransition:play()
		self:newScheduleOnce(handler(self, self._checkCellAndLocate), 0.2)
	end

	self._needReqInfo = false
end

function ThemePassCardLayer:_refreshActivityCountDown()
	local var_22_0 = g.core.model.User.themeData:getThemeMergeEntranceActivityData(self._themeValue):getExpireTime()
	local var_22_1, var_22_2, var_22_3, var_22_4 = g.core.common.ServerTime:getLeftTimeParts(var_22_0)

	if var_22_0 > g.core.common.ServerTime:getTime() then
		self.m_timeTxt:setText(var_22_1 >= 1 and g.core.lang:get(425504, {
			day = var_22_1,
			hour = var_22_2
		}) or g.core.lang:get(425505, {
			hour = var_22_2,
			minute = var_22_3
		}))
	else
		self.m_timeTxt:setText("")

		if self._cdScheduler then
			self:cancelSchedule(self._cdScheduler)

			self._cdScheduler = nil
		end

		self:_reqPassCardInfo()
	end
end

function ThemePassCardLayer:_checkCellAndLocate()
	local var_23_0
	local var_23_1
	local var_23_2
	local var_23_3

	for iter_23_0 = 1, #self._passCardList do
		if not var_23_1 and self._passCardList[iter_23_0].state == 1 then
			var_23_1 = iter_23_0 - 1
		elseif not var_23_2 and self._passCardList[iter_23_0].state > 1 and self._passCardList[iter_23_0].payLimit > self._passCardList[iter_23_0].payNum then
			var_23_2 = iter_23_0 - 1
		elseif not var_23_3 and self._passCardList[iter_23_0].state == 0 then
			var_23_3 = iter_23_0 - 1
		end

		if var_23_3 or var_23_1 and var_23_2 then
			break
		end
	end

	if var_23_1 then
		var_23_0 = var_23_1
	elseif var_23_3 then
		var_23_0 = var_23_3
	elseif var_23_2 then
		var_23_0 = var_23_2
	end

	if var_23_0 then
		self.m_rewardList:scrollToView(var_23_0, true, true)
	end
end

function ThemePassCardLayer:_onEasyBtnClicked()
	local var_24_0 = self._themeData:getPassCardData():getAllFreeAwardPassId()

	if #var_24_0 > 0 then
		self:_reqGetFreeAward(var_24_0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(425501))
	end
end

function ThemePassCardLayer:_onPassCardInfoReceive(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	self:_updateLayer()
end

function ThemePassCardLayer:_onPassCardAwardReceive(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = {
		showNow = true
	}
	local var_26_1 = {}

	var_26_1.awards = arg_26_4.awards or {}
	var_26_0.award = var_26_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_26_0)
	self:_updateLayer()
end

function ThemePassCardLayer:_onPassCardTaskUpdate(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	self:_updateLayer()
end

function ThemePassCardLayer:_onRechargeAwardReceive(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	if not arg_28_4.theme_passcard then
		return
	end

	local var_28_0 = {
		showNow = true
	}
	local var_28_1 = {}

	var_28_1.awards = arg_28_4.theme_passcard.awards or {}
	var_28_0.award = var_28_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_28_0)
	self:_updateLayer()
end

return ThemePassCardLayer
