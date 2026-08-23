local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreTimePowerPop = class("ThemeExploreTimePowerPop", require("app.fairyGUI.summerTheme.UI_ThemeExploreTimePowerPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeExploreTimePowerPop",
		pkgPath = "ui/summerTheme/summerTheme",
		pkgName = "summerTheme"
	})
end)

function ThemeExploreTimePowerPop:ctor(arg_2_1)
	self:showAtCenter()

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_1.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._chapter = arg_2_1.chapter
	self._itemData = {}
	self._curSel = 0

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRenderer))
	self.m_itemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeSelect))
end

function ThemeExploreTimePowerPop:onLoad()
	self:updateBagData()

	if #self._itemData == 0 then
		self.m_emptyController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_itemList:setNumItems(#self._itemData)
		self.m_itemList:setSelectedIndex(0)
		self:_onChangeSelect(true)
	end
end

function ThemeExploreTimePowerPop:_onChangeSelect(arg_4_1)
	local var_4_0 = self.m_itemList:getSelectedIndex()

	if not arg_4_1 and self._curSel == var_4_0 then
		return
	end

	self._curSel = var_4_0

	self:_updateRightView()
end

function ThemeExploreTimePowerPop:_updateRightView()
	if not self._itemData[self._curSel + 1] then
		return
	end

	local var_5_0 = self._itemData[self._curSel + 1].cfg

	self.m_titleTxt:setText(self._itemData[self._curSel + 1].cfg.name)
	self.m_picBgLoader:setURL(var_0_0:getBagNewQualityBgPath(var_5_0.quality))
	self.m_itemIcon:setURL(g.core.common.Path:getThemeExplorePowerPic(var_5_0.icon))
	self.m_descComp:setTitle(var_5_0.description)
end

function ThemeExploreTimePowerPop:_onItemListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._itemData[arg_6_1 + 1].cfg)
end

function ThemeExploreTimePowerPop:updateBagData()
	self._itemData = {}

	for iter_7_0, iter_7_1 in ipairs(g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getTimerPowerBag(self._chapter) or {}) do
		table.insert(self._itemData, {
			cfg = g.core.config.activity_theme_explore_item.get(iter_7_1)
		})
	end
end

return ThemeExploreTimePowerPop
