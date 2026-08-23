local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreBattleInfoPop = class("ThemeExploreBattleInfoPop", require("app.fairyGUI.summerTheme.UI_ThemeExploreBattleInfoPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeExploreBattleInfoPop",
		pkgPath = "ui/summerTheme/summerTheme",
		pkgName = "summerTheme"
	})
end)

function ThemeExploreBattleInfoPop:ctor(arg_2_1)
	self._params = arg_2_1

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self.m_rightBattleInfo:setWidth(display.width)

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0

	self.m_rightBattleInfo:updateInfo(arg_2_1)
	self.m_rightBattleInfo:setCLoseFunc(handler(self, self._onClickPnlClick))
	self.m_closePanel:addClickListener(handler(self, self._onClickPnlClick))
end

function ThemeExploreBattleInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_BEGINCHALLENGE, self._onBattleChallengeBegin, self)
end

function ThemeExploreBattleInfoPop:_onBattleChallengeBegin()
	self:removeSelf()
end

function ThemeExploreBattleInfoPop:_onClickPnlClick()
	if self._inclose then
		return
	end

	self._inclose = true

	if self.m_rightBattleInfo and self.m_rightBattleInfo.onClosePnl then
		self.m_rightBattleInfo:onClosePnl(handler(self, self.onCloseAnimFinish))
	else
		self:onCloseAnimFinish()
	end
end

function ThemeExploreBattleInfoPop:onCloseAnimFinish()
	self:removeSelf()
end

return ThemeExploreBattleInfoPop
