local var_0_0 = g.core.const.ConstMgr.ThemeConst
local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local ThemeExploreSelectTimePowerPop = class("ThemeExploreSelectTimePowerPop", require("app.fairyGUI.summerTheme.UI_ThemeExploreSelectTimePowerPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/summerTheme/summerTheme",
		resName = "ThemeExploreSelectTimePowerPop",
		pkgName = "summerTheme"
	})
end)

function ThemeExploreSelectTimePowerPop:ctor(arg_2_1)
	self:showAtCenter()

	self._param = arg_2_1

	if not arg_2_1 then
		return
	end

	self._isSelected = false

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._chapter = arg_2_1.chapter
	self._selType = arg_2_1.selType or RiskMapConst.SEL_BUFF_TYPE.QUALITY
	self._quality = arg_2_1.quality
	self._clickIndex = nil

	if self._selType == RiskMapConst.SEL_BUFF_TYPE.ID then
		local var_2_1 = g.core.config.activity_theme_explore_item.get(self._quality)

		self._selectList = {
			var_2_1,
			var_2_1,
			var_2_1
		}

		self.m_cardComp1:setVisible(false)
		self.m_cardComp3:setVisible(false)
	else
		self._selectList = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getRandomTimePower(self._quality)
	end

	for iter_2_0 = 1, 3 do
		self["m_cardComp" .. iter_2_0].powerIndex = iter_2_0

		self["m_cardComp" .. iter_2_0]:addClickListener(handler(self, self.onSelectPower))
	end

	self:updateView()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExitFinish))
end

function ThemeExploreSelectTimePowerPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETTIMEPOWER, handler(self, self._onGetTimePower), self)
end

function ThemeExploreSelectTimePowerPop:_onGetTimePower(arg_4_1, arg_4_2, arg_4_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_EXPLORE_SELECT_POWER, false, {
		cfg = self._selectList[self._clickIndex],
		worldPos = (self._clickIndex and self["m_cardComp" .. self._clickIndex] or nil) and self:localToGlobal((self["m_cardComp" .. self._clickIndex]:getPosition()))
	})
	self:removeSelf()
end

function ThemeExploreSelectTimePowerPop:updateView()
	for iter_5_0 = 1, 3 do
		self["m_cardComp" .. iter_5_0]:updateCardInfo(self._selectList[iter_5_0])
	end
end

function ThemeExploreSelectTimePowerPop:onSelectPower(arg_6_1)
	if self._isSelected then
		return
	end

	local var_6_0 = arg_6_1:getSender().powerIndex

	self._clickIndex = var_6_0

	if var_6_0 then
		self._isSelected = true

		g.core.network.GameNetProxy:send_C2S_ThemeExplore_GetTimePower({
			act_id = self._activeThemeValue,
			chapter_id = self._chapter,
			time_power_id = self._selectList[var_6_0].id
		})
	end
end

function ThemeExploreSelectTimePowerPop:_onSelfExitFinish()
	if self._param and self._param.exitCall then
		self._param:exitCall()
	end
end

return ThemeExploreSelectTimePowerPop
