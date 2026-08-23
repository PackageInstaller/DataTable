local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.const.ConstMgr.ActivityConst
local ThemeTurnTableMainLayer = class("ThemeTurnTableMainLayer", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableMainLayer"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_1.THEME_VALUE.MOLLY

	return fgui.GComponent:create({
		pkgName = "summerThemeGame",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true,
		resName = var_0_1.THEME_TURN_TABLE_LAYER[var_1_0]
	}, ...)
end)

function ThemeTurnTableMainLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_1.THEME_VALUE.MOLLY
	end

	self._summerThemeData = nil
	self._turnTableData = nil
	self._showAwards = {}
	self._isInAnim = false

	self:_initView()
	self:_initBtn()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.THEME_TURN_TABLE)
end

function ThemeTurnTableMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_ONCE, self._onTurnInfoRefresh, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_FIVE, self._onTurnInfoRefresh, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_REWARD, self._onProgressInfoRefresh, self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_turnFiveBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
	self.m_enterTransition:play()
	g.core.model.User.themeData:changeThemeBGM(self._activeThemeValue)
	self:updateTurnBtnInfo()
	self:updatePlateInfo()
	self:updateProgressInfo()
end

function ThemeTurnTableMainLayer:onUnload()
	return
end

function ThemeTurnTableMainLayer:receiveCompEvent(arg_5_1)
	if arg_5_1 == "TurnTable_result" then
		self._isInAnim = false

		g.core.module.ModuleManager:awardSummary(self._showAwards)
		self:updateTurnBtnInfo()
		self:updatePlateInfo()
		self:updateProgressInfo()
	elseif arg_5_1 == "TurnTable_animStart" then
		self._isInAnim = true
	end
end

function ThemeTurnTableMainLayer:_initView()
	self._summerThemeData = var_0_0:getThemeData(self._activeThemeValue)

	if self._summerThemeData then
		self._turnTableData = self._summerThemeData:getTurnTableData()
	end

	self:addBg(var_0_1.TURN_TABLE_BG)

	local var_6_0 = g.core.config.activity_theme_display_info.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(var_6_0.minigame_top_bar)
	self.m_topBarComp:setTitle(var_6_0.minigame_name)
	self.m_jumpShopBtn:setTitle(var_6_0.gift_name)

	self.m_costOnceComp = self.m_turnOnceBtn:getChild("costComp")
	self.m_costFiveComp = self.m_turnFiveBtn:getChild("costComp")
end

function ThemeTurnTableMainLayer:_initBtn()
	self.m_jumpShopBtn:addClickListener(handler(self, self._onThemeGiftBtnClick))
	self.m_probBtn:addClickListener(handler(self, self._onProbabilityClick))
	self.m_turnOnceBtn:addClickListener(handler(self, self._onTurnOnceClick))
	self.m_turnFiveBtn:addClickListener(handler(self, self._onTurnFiveClick))
end

function ThemeTurnTableMainLayer:_onThemeGiftBtnClick()
	local var_8_0 = var_0_0:getActivityData(self._activeThemeValue)
	local var_8_1

	if not var_8_0 or var_8_0:getActivityState() ~= var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		do return end

		var_8_1 = {
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT
		}
	end

	var_8_1.shopValue = g.core.const.ConstMgr.ShopConst.RECHARGE_HOT_VALUE.HOT_THEME

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, var_8_1)
end

function ThemeTurnTableMainLayer:_onProbabilityClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.turnTable.ThemeTurnTableProbPop").new({
		themeValue = self._activeThemeValue
	})))
end

function ThemeTurnTableMainLayer:_onTurnOnceClick()
	if self._isInAnim then
		g.core.module.ModuleManager:tip(g.core.lang:get(405901))

		return
	end

	if not self._turnTableData or self._turnTableData:isTurnTableClose() then
		return
	end

	if not self._turnTableData:isHaveNTurnTimes(1) then
		g.core.module.ModuleManager:tip(g.core.lang:get(405903))

		return
	end

	if g.core.utils.Tools.isCountEnoughByTVS(self._onceCostInfo) then
		g.core.network.GameNetProxy:send_C2S_Turntable_Once({
			act_id = self._activeThemeValue
		})
	end
end

function ThemeTurnTableMainLayer:_onTurnFiveClick()
	if self._isInAnim then
		g.core.module.ModuleManager:tip(g.core.lang:get(405901))

		return
	end

	if not self._turnTableData or self._turnTableData:isTurnTableClose() then
		return
	end

	if not self._turnTableData:isHaveNTurnTimes(5) then
		g.core.module.ModuleManager:tip(g.core.lang:get(405904))

		return
	end

	if g.core.utils.Tools.isCountEnoughByTVS(self._fiveCostInfo) then
		g.core.network.GameNetProxy:send_C2S_Turntable_Five({
			act_id = self._activeThemeValue
		})
	end
end

function ThemeTurnTableMainLayer:updateTurnBtnInfo()
	if not self._turnTableData then
		return
	end

	local var_12_0 = self._turnTableData:getBaseInfo()

	self._onceCostInfo = {
		type = var_12_0.use_type,
		value = var_12_0.use_value,
		size = var_12_0.use_size
	}
	self._fiveCostInfo = {
		type = var_12_0.use_type_five,
		value = var_12_0.use_value_five,
		size = var_12_0.use_size_five
	}

	self.m_costOnceComp:updateByTVS(self._onceCostInfo)
	self.m_costFiveComp:updateByTVS(self._fiveCostInfo)
end

function ThemeTurnTableMainLayer:updatePlateInfo()
	self.m_plateComp:updatePlateInfo(self._activeThemeValue)
end

function ThemeTurnTableMainLayer:updateProgressInfo()
	self.m_progressComp:updateProgressInfo(self._activeThemeValue)
end

function ThemeTurnTableMainLayer:_onTurnInfoRefresh(arg_15_1, arg_15_2, arg_15_3)
	self._showAwards = arg_15_3.awards or {}

	local var_15_0 = {}
	local var_15_1 = true

	if arg_15_3.reward_id then
		var_15_0 = {
			arg_15_3.reward_id
		}
	elseif arg_15_3.reward_ids then
		var_15_0 = arg_15_3.reward_ids
		var_15_1 = false
	end

	self.m_plateComp:playTurnPlateAnimation(var_15_0, var_15_1)
end

function ThemeTurnTableMainLayer:_onProgressInfoRefresh(arg_16_1, arg_16_2, arg_16_3)
	g.core.module.ModuleManager:awardSummary(arg_16_3.awards or {})
	self:updateProgressInfo()
end

return ThemeTurnTableMainLayer
