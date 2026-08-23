local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostRecoverItemComp = class("OutpostRecoverItemComp", require("app.fairyGUI.outpost.UI_OutpostRecoverItemComp"))

function OutpostRecoverItemComp:ctor()
	self._costDataList = {}
	self._data = nil

	self.m_wayBtn:addClickListener(handler(self, self._onWayBtnClicked))
end

function OutpostRecoverItemComp:updateItemComp(arg_2_1, arg_2_2)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.costDic) do
		iter_2_1.type = var_0_0.EXCHANGE_ITEM_TYPE
		var_2_0[#var_2_0 + 1] = iter_2_1
	end

	self._costDataList = var_2_0

	local var_2_1 = g.core.config.outpost_item_info.get(var_2_0[1].value)

	self.m_icon:setURL((g.core.common.Path:getOutpostItemBigIcon(var_2_1.icon)))

	local var_2_2 = g.core.model.User.outpostData:getBagData():getOwnNum(var_2_0[1].value)

	self.m_numTxt:setText(var_2_2)

	self._data = arg_2_1

	self.m_wayBtn:setVisible(var_2_2 == 0)
	self.m_qualityLine:setURL(g.core.common.Path:getQualityLineByQuality(var_2_1.quality + 1))

	if arg_2_2 then
		self.m_dragStateController:setSelectedIndex(1)
	else
		self.m_dragStateController:setSelectedIndex(0)
	end
end

function OutpostRecoverItemComp:getItemData()
	return self._data
end

function OutpostRecoverItemComp:getCostData()
	return self._costDataList
end

function OutpostRecoverItemComp:_onWayBtnClicked()
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		size = 0,
		type = self._costDataList[1].type,
		value = self._costDataList[1].value
	})
end

return OutpostRecoverItemComp
