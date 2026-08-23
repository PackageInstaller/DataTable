local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local ThemeTurnTableProgressPop = class("ThemeTurnTableProgressPop", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableProgressPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeTurnTableProgressPop",
		pkgName = "summerThemeGame"
	})
end)

function ThemeTurnTableProgressPop:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_0.THEME_VALUE.MOLLY
	end

	self._turnTableData = nil
	self._progressList = {}

	self:_initListView()
	self:showAtCenter()
end

function ThemeTurnTableProgressPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_REWARD, self._onProgressInfoRefresh, self)
end

function ThemeTurnTableProgressPop:_initListView()
	local var_4_0 = var_0_1:getThemeData(self._activeThemeValue)

	if not var_4_0 then
		return
	end

	self._turnTableData = var_4_0:getTurnTableData()
	self._progressList = self._turnTableData:getProgressList()

	self.m_curTurnNumText:setText((self._turnTableData:getCurTurnNum()))
	self.m_progressList:setVirtual()
	self.m_progressList:doFairyBatching(false)
	self.m_progressList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_progressList:setNumItems(#self._progressList)
end

function ThemeTurnTableProgressPop:_onRenderAwardList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._activeThemeValue, arg_5_1 + 1)
end

function ThemeTurnTableProgressPop:_onProgressInfoRefresh(arg_6_1, arg_6_2, arg_6_3)
	self.m_progressList:setNumItems(#self._progressList)
end

return ThemeTurnTableProgressPop
