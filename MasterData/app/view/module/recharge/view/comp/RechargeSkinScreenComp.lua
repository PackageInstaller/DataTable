local var_0_0 = g.core.config.skin_theme_info
local SkinScreenCfg = require("app.view.module.recharge.const.SkinScreenCfg")
local var_0_2 = g.core.model.User.skinGoodsData
local RechargeSkinScreenComp = class("RechargeSkinScreenComp", require("app.fairyGUI.recharge.UI_RechargeSkinScreenComp"))

function RechargeSkinScreenComp:ctor()
	self._selectedIndex = 0
	self._screenData = {
		quality = {},
		camp = {},
		theme = {}
	}

	self:_initThemeList()
	self.m_ThemeList:setItemRenderer(handler(self, self._onRendererTheme))
	self.m_ThemeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTheme))
end

function RechargeSkinScreenComp:initComp(arg_2_1)
	self._selectedIndex = self._themeIdToIndexDict[arg_2_1.index] or 0
	self._screenData = {
		quality = {},
		camp = {},
		theme = {}
	}

	self.m_ThemeList:setNumItems(#self._indexToThemeIdList)
	self.m_ThemeList:setSelectedIndex(self:_luaIndexToCppIndex(self._selectedIndex))
end

function RechargeSkinScreenComp:_initThemeList()
	self._skinThemeDict = var_0_2:getShowThemeDict()
	self._indexToThemeIdList = {}

	for iter_3_0, iter_3_1 in ipairs(self._skinThemeDict) do
		if iter_3_1 then
			table.insert(self._indexToThemeIdList, iter_3_0)
		end
	end

	self._themeIdToIndexDict = {}

	for iter_3_2, iter_3_3 in ipairs(self._indexToThemeIdList) do
		self._themeIdToIndexDict[iter_3_3] = iter_3_2
	end
end

function RechargeSkinScreenComp:_onRendererTheme(arg_4_1, arg_4_2)
	arg_4_2:getChild("icon"):setURL((g.core.common.Path:getSkinConditionImg(var_0_0.get(self._indexToThemeIdList[arg_4_1 + 1]).res)))
end

function RechargeSkinScreenComp:_onClickTheme(arg_5_1)
	local var_5_0 = self.m_ThemeList:getSelectedIndex()

	if self._selectedIndex == self:_cppIndexToLuaIndex(var_5_0) then
		self._selectedIndex = 0

		self.m_ThemeList:setSelectedIndex(-1)

		self._screenData.theme = {}

		return
	end

	self._selectedIndex = self:_cppIndexToLuaIndex(var_5_0)
end

function RechargeSkinScreenComp:onConfirm()
	if self._selectedIndex > 0 then
		local var_6_0 = var_0_0.get(self._indexToThemeIdList[self._selectedIndex]).id

		self._screenData.theme = {}
		self._screenData.theme[var_6_0] = var_6_0
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SKIN_SCREEN, false, nil, self._screenData)
end

function RechargeSkinScreenComp:getSelectedIndex()
	return self._indexToThemeIdList[self._selectedIndex]
end

function RechargeSkinScreenComp:_cppIndexToLuaIndex(arg_8_1)
	return arg_8_1 + 1
end

function RechargeSkinScreenComp:_luaIndexToCppIndex(arg_9_1)
	return arg_9_1 - 1
end

return RechargeSkinScreenComp
