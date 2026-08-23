local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local SummerThemeBossSelectLayer = class("SummerThemeBossSelectLayer", require("app.fairyGUI.summerTheme.UI_SummerThemeBossSelectLayer"), function()
	local var_1_1 = {
		pkgPath = "ui/summerTheme/summerTheme",
		isFullScreen = true,
		pkgName = "summerTheme"
	}

	var_1_1.resName = var_0_1.THEME_BOSS_SELECT_LAYER[({
		...
	})[1].activeThemeValue or var_0_1.THEME_VALUE.ILIYI] or var_0_1.THEME_BOSS_SELECT_LAYER[96]

	return fgui.GComponent:create(var_1_1, ...)
end)

function SummerThemeBossSelectLayer:ctor(arg_2_1)
	self._activityValues = arg_2_1.activityValues
	self._activeThemeValue = arg_2_1.activeThemeValue

	self:addBg(var_0_1.THEME_SELECT_BOSS_BG[self._activeThemeValue], nil, nil, 1)

	self._displayInfo = g.core.config.activity_theme_display_info.get(self._activeThemeValue)

	self.m_topBarComp:setTitle(self._displayInfo.boss_name)
	self.m_entryList:setVirtual()
	self.m_entryList:setItemRenderer(handler(self, self._onItemRender))
	self.m_entryList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClick))
end

function SummerThemeBossSelectLayer:onLoad()
	self.m_entryList:setNumItems(#self._activityValues)
	self.m_entryList:transitionShowCells("enter_right", 0.03, 1)
end

function SummerThemeBossSelectLayer:_onItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._activityValues[arg_4_1 + 1])
end

function SummerThemeBossSelectLayer:_onItemClick(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()
	local var_5_1 = self._activityValues[var_5_0 + 1]
	local var_5_2 = self.m_entryList:getChildAt(var_5_0)
	local var_5_3 = var_5_2 and var_5_2.getBossState and var_5_2:getBossState() or var_0_1.THEME_STATE_TYPE.UNOPEN

	if var_5_3 == var_0_1.THEME_STATE_TYPE.OPENING then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_BOSS_WAR, {
			themeValue = var_5_1
		})
		var_0_0:getThemeData(var_5_1):getBossData():redDoBossNewPhase()
	elseif var_5_3 == var_0_1.THEME_STATE_TYPE.UNOPEN then
		local var_5_4

		if var_5_2 then
			::label_5_0::

			var_5_4 = var_5_2.getUnlockTipText and var_5_2:getUnlockTipText()
		end

		g.core.module.ModuleManager:tip(var_5_4 and #var_5_4 > 0 and var_5_4 or g.core.lang:get(1008))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
	end
end

return SummerThemeBossSelectLayer
