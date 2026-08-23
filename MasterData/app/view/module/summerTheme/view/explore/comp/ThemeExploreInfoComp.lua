local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreInfoComp = class("ThemeExploreInfoComp", require("app.fairyGUI.summerTheme.UI_ThemeExploreInfoComp"))

function ThemeExploreInfoComp:ctor()
	self.m_resetBtn:addClickListener(handler(self, self._onClickResetBtn))
	self.m_enterBtn:addClickListener(handler(self, self._onClickEnterStageBtn))
	self.m_iconLoader1:addClickListener(handler(self, self._onClickSmallBox))
	self.m_iconLoader2:addClickListener(handler(self, self._onClickBigBox))
end

function ThemeExploreInfoComp:updateInfo(arg_2_1)
	self._param = arg_2_1

	local var_2_0 = arg_2_1.info

	self.m_descTxt:setText(arg_2_1.info.des)

	local var_2_1

	if arg_2_1 then
		var_2_1 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_1
	self._chapter = var_2_0.id

	local var_2_2, var_2_3, var_2_4 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterRewardBox(self._chapter)

	self._bigBox = var_2_2
	self._smallBox = var_2_3

	self:updateBoxState()

	local var_2_5 = var_0_0.THEME_EXPLORE_BOX[var_2_1] or var_0_0.THEME_EXPLORE_BOX[1]

	self.m_iconLoader1:setURL("ui://summerTheme/" .. var_2_5.small)
	self.m_iconLoader2:setURL("ui://summerTheme/" .. var_2_5.big)
end

function ThemeExploreInfoComp:updateBoxState()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(self._smallBox) do
		if iter_3_1.finish then
			var_3_0 = var_3_0 + 1
		end
	end

	self.m_progressTxt1:setText(var_3_0 .. "/" .. #self._smallBox)
	self.m_progress1:setMax(#self._smallBox)
	self.m_progress1:setValue(var_3_0)

	local var_3_1 = 0

	for iter_3_2, iter_3_3 in ipairs(self._bigBox) do
		if iter_3_3.finish then
			var_3_1 = var_3_1 + 1
		end
	end

	self.m_progressTxt2:setText(var_3_1 .. "/" .. #self._bigBox)
	self.m_progress2:setMax(#self._bigBox)
	self.m_progress2:setValue(var_3_1)

	if var_3_0 + var_3_1 == 0 then
		self.m_resetBtn:setVisible(false)
	else
		self.m_resetBtn:setVisible(true)
	end
end

function ThemeExploreInfoComp:_onClickResetBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(405729),
		desc = g.core.lang:get(405730),
		confirmText = g.core.lang:get(405740),
		onConfirm = handler(self, function()
			g.core.network.GameNetProxy:send_C2S_ThemeExplore_ResetInfo({
				act_id = self._activeThemeValue,
				chapter_id = self._chapter
			})
		end)
	}))
end

function ThemeExploreInfoComp:_onClickSmallBox(arg_6_1)
	arg_6_1:stopPropagation()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreShowRewardPop").new({
		items = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getAllBoxRewards(self._smallBox)
	})))
end

function ThemeExploreInfoComp:_onClickBigBox(arg_7_1)
	arg_7_1:stopPropagation()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreShowRewardPop").new({
		items = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getAllBoxRewards(self._bigBox)
	})))
end

function ThemeExploreInfoComp:_onClickEnterStageBtn()
	g.core.network.GameNetProxy:send_C2S_ThemeExplore_GetMapInfo({
		act_id = self._activeThemeValue,
		chapter_id = self._chapter
	})
end

return ThemeExploreInfoComp
