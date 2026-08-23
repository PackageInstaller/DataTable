local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local ThemeBossScorePreviewPop = class("ThemeBossScorePreviewPop", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossScorePreviewPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeBossScorePreviewPop",
		pkgName = "summerThemeBoss",
		isFullScreen = true,
		pkgPath = "ui/summerThemeBoss/summerThemeBoss"
	})
end)
local var_0_3 = 1
local var_0_4 = 270

function ThemeBossScorePreviewPop:ctor(arg_2_1)
	self._activeThemeType = var_0_1.THEME_TYPE

	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._bossData = var_0_0:getThemeData(self._activeThemeValue):getBossData()
	self._length = 0

	self:initView()
	self.m_enterTransition:play()
	self.m_effBg:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play",
		name = "eff_ui_themeboss_awardviewbg"
	})
end

function ThemeBossScorePreviewPop:initView()
	self.m_closeBtn:addClickListener(handler(self, self._onClickClose))
	self.m_previewList:setVirtual()
	self.m_previewList:setItemRenderer(handler(self, self.onRenderPreviewList))
	self.m_previewList:getScrollPane():cancelDragging()
	self.m_curScoreText:setText(self._bossData:getTotalScore())
end

function ThemeBossScorePreviewPop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self._close))
end

function ThemeBossScorePreviewPop:_close()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ThemeBossScorePreviewPop:onRenderPreviewList(arg_6_1, arg_6_2)
	arg_6_2:setShowPos(arg_6_1 + 1)
	arg_6_2:updatePreviewCell(self._bossData:getScoreInfoByIndex(self._length - arg_6_1), self._length - arg_6_1, self._activeThemeValue)
end

function ThemeBossScorePreviewPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETAWARD, handler(self, self.updateView), self)
	self:updateView()
end

function ThemeBossScorePreviewPop:updateView()
	self._length = #self._bossData:getScoreInfoList() + var_0_3

	self.m_previewList:setNumItems(self._length)
	self.m_previewList:getScrollPane():setPosX(math.max((self._length - self._bossData:getScoreListCurIndex()) * var_0_4 + var_0_4 * self._bossData:getCurProgressValue() - display.cx, 0), true)
end

return ThemeBossScorePreviewPop
