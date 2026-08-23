local var_0_0 = g.core.model.User.themeData
local ThemeTurnTableProgressComp = class("ThemeTurnTableProgressComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableProgressComp"))

function ThemeTurnTableProgressComp:ctor()
	self._turnTableData = nil
	self._isInitIcon = false
	self._iconList = {}
end

function ThemeTurnTableProgressComp:_initProgressIcons()
	if self._isInitIcon then
		return
	end

	self._isInitIcon = true

	local var_2_0 = self._turnTableData:getProgMaxNum()
	local var_2_1 = self._turnTableData:getProgressList()

	for iter_2_0 = 1, #var_2_1 do
		local var_2_2 = fgui.UIPackage:createObject("summerThemeGame", "ThemeTurnTableProgressIcon")

		var_2_2:setPosition(112, 378 - var_2_1[iter_2_0].cfg.times / var_2_0 * 332)
		self:addChild(var_2_2)
		table.insert(self._iconList, var_2_2)
	end
end

function ThemeTurnTableProgressComp:updateProgressInfo(arg_3_1)
	local var_3_0 = var_0_0:getThemeData(arg_3_1)

	if not var_3_0 then
		return
	end

	self._turnTableData = var_3_0:getTurnTableData()

	local var_3_1 = self._turnTableData:getCurTurnNum()

	self.m_turnTimesText:setText(var_3_1)
	self.m_progImg:setHeight(math.min(1, var_3_1 / self._turnTableData:getProgMaxNum()) * 332)
	self:_initProgressIcons()

	for iter_3_0 = 1, #self._iconList do
		self._iconList[iter_3_0]:updateProgressIcon(arg_3_1, iter_3_0)
	end
end

return ThemeTurnTableProgressComp
