local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreBoxComp = class("ThemeExploreBoxComp", require("app.fairyGUI.summerTheme.UI_ThemeExploreBoxComp"))

function ThemeExploreBoxComp:ctor()
	self:addClickListener(handler(self, self._onShowDetailClick))
end

function ThemeExploreBoxComp:updateBoxCompShow(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._param = arg_2_1

	self.m_progressTxt:setText(arg_2_1.getNum .. "/" .. arg_2_1.allNum)
	self.m_progress:setMax(arg_2_1.allNum)
	self.m_progress:setValue(arg_2_1.getNum)

	local var_2_1 = var_0_0.THEME_EXPLORE_BOX[var_2_0]
	local var_2_2

	if not var_0_0.THEME_EXPLORE_BOX[var_2_0] then
		var_2_1 = var_0_0.THEME_EXPLORE_BOX[1]
		var_2_2 = "ui://summerTheme/"
	end

	self.m_itemLoader:setURL(var_2_2 .. var_2_1[self.m_typeController:getSelectedIndex() == 0 and "small" or "big"])
end

function ThemeExploreBoxComp:_onShowDetailClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreShowRewardPop").new({
		items = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getAllBoxRewards(self._param.dataStruct)
	})))
end

return ThemeExploreBoxComp
