local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local ThemeTurnTableProbPop = class("ThemeTurnTableProbPop", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableProbPop"), function()
	return fgui.GComponent:create({
		pkgName = "summerThemeGame",
		resName = "ThemeTurnTableProbPop"
	})
end)

function ThemeTurnTableProbPop:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_0.THEME_VALUE.MOLLY
	end

	self._turnTableData = nil
	self._awardList = {}

	self:_initListView()
	self:showAtCenter()
end

function ThemeTurnTableProbPop:_initListView()
	local var_3_0 = var_0_1:getThemeData(self._activeThemeValue)

	if not var_3_0 then
		return
	end

	self._turnTableData = var_3_0:getTurnTableData()
	self._awardList = self._turnTableData:getRewardList()

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_awardList:setNumItems(#self._awardList)
end

function ThemeTurnTableProbPop:_onRenderAwardList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._awardList[arg_4_1 + 1], (self._turnTableData:getRewardWholeProb()))
end

return ThemeTurnTableProbPop
