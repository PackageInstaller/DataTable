local var_0_0 = g.core.model.User.activityMonthGachaData
local ActivityGachaSelectPop = class("ActivityGachaSelectPop", require("app.fairyGUI.activity.UI_ActivityGachaSelectPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/activity/activity",
		resName = "ActivityGachaSelectPop",
		pkgName = "activity"
	})
end)

function ActivityGachaSelectPop:ctor(arg_2_1)
	self._param = arg_2_1
	self._selItems = nil

	self:showAtCenter()
	self.m_selectBtn:addClickListener(handler(self, self._onSelectClick))
	self.m_selectItemList:setVirtual()
	self.m_selectItemList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_selectItemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClick))
	self:initChooseView()
end

function ActivityGachaSelectPop:_onItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateSelComp(self._selItems[arg_3_1 + 1], self._param.type)
end

function ActivityGachaSelectPop:_onSelectClick()
	self:setItemChoose(self._param.id, self.m_selectItemList:getSelectedIndex() + 1)
end

function ActivityGachaSelectPop:_onItemClick()
	local var_5_0 = self.m_selectItemList:getSelectedIndex()

	if self._oldSelIndex == var_5_0 + 1 then
		self._oldSelIndex = -1

		self.m_selectItemList:setSelectedIndex(-1)

		return
	end

	self._oldSelIndex = var_5_0 + 1
end

function ActivityGachaSelectPop:initChooseView()
	local var_6_0 = g.core.common.Drops:getGoodsArray(self._param.dropId)

	self._selItems = var_6_0

	self.m_selectItemList:setNumItems(#var_6_0)

	local var_6_1 = var_0_0:getSelectRewardIndex(self._param.id) or 0

	if var_6_1 > 0 then
		self._oldSelIndex = var_6_1

		self.m_selectItemList:setSelectedIndex(var_6_1 - 1)
	end
end

function ActivityGachaSelectPop:setItemChoose(arg_7_1, arg_7_2)
	if arg_7_2 > 0 then
		if (var_0_0:getSelectRewardIndex(self._param.id) or 0) == arg_7_2 then
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		else
			g.core.network.GameNetProxy:send_C2S_MonthGacha_ChoseAward({
				award_id = arg_7_1,
				index = arg_7_2
			})
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408115))
	end
end

return ActivityGachaSelectPop
