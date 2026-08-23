local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreEventDescPop = class("ThemeExploreEventDescPop", require("app.fairyGUI.summerTheme.UI_ThemeExploreEventDescPop"), function()
	return fgui.GComponent:create({
		pkgName = "summerTheme",
		resName = "ThemeExploreEventDescPop",
		pkgPath = "ui/summerTheme/summerTheme"
	})
end)

function ThemeExploreEventDescPop:ctor(arg_2_1)
	self._objId = arg_2_1.infoId
	self._opeCallFunc = arg_2_1.callback

	self:showAtCenter()
	self.m_operateBtn:addClickListener(handler(self, self._onOpeBtnClick))

	local var_2_0 = "bg/theme/bg_summert_tansuo.png"

	if arg_2_1.themeValue == var_0_2.THEME_VALUE.HORUS then
		var_2_0 = "bg/theme/bg_horus_tansuo.png"
	elseif arg_2_1.themeValue == var_0_2.THEME_VALUE.NEWYEAR then
		var_2_0 = "bg/theme/bg_newyear_tansuo.png"
	elseif arg_2_1.themeValue == var_0_2.THEME_VALUE.LEVIA then
		var_2_0 = "bg/theme/bg_activity_levia_tansuo.png"
	elseif arg_2_1.themeValue == var_0_2.THEME_VALUE.IFURITO then
		var_2_0 = "bg/theme/bg_horus_tansuo.png"
	end

	self.m_bgImg:setURL(var_2_0)
	self:updateView()
end

function ThemeExploreEventDescPop:updateView()
	local var_3_0 = g.core.config.activity_theme_explore_object.get(self._objId)

	self.m_nameTxt:setText(var_3_0.name)
	self.m_descTxtComp:setTitle(var_3_0.des)
	self.m_operateBtn:setTitle(var_3_0.operation)

	if var_3_0.res == 0 then
		self.m_styleController:setSelectedIndex(2)
	elseif var_3_0.res_type == 2 then
		self.m_styleController:setSelectedIndex(0)
		self.m_roleImg:setIcon((var_0_1:getKnightPicRes(var_3_0.res)))
	elseif var_3_0.res_type == 1 then
		self.m_styleController:setSelectedIndex(1)
		self.m_itemImg:setURL("pic/explore/item_tansuo_" .. var_3_0.res .. ".png")
	end
end

function ThemeExploreEventDescPop:_onOpeBtnClick()
	if self._opeCallFunc then
		self._opeCallFunc()
	end

	self:removeSelf()
end

return ThemeExploreEventDescPop
