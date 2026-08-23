local StormTargetHegemonyPop = class("StormTargetHegemonyPop", require("app.fairyGUI.storm.UI_StormTargetHegemonyPop"), function()
	return fgui.GComponent:create({
		resName = "StormTargetHegemonyPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	}, ...)
end)

function StormTargetHegemonyPop:ctor()
	self:showAtCenter()

	self._achieveList = nil
	self._curPoint = 0

	self.m_infoBtn:addClickListener(handler(self, self._onInfoClick))
	self.m_rewardItemList:setVirtual()
	self.m_rewardItemList:setItemRenderer(handler(self, self._onRewardCellRenderer))
	self.m_rewardItemList:doFairyBatching(false)
	self:_updateView()
end

function StormTargetHegemonyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDACHIVEAWARD, self._onRcvGetLordAchieveAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDACHIVE, self._updateView, self)
	g.core.network.GameNetProxy:send_C2S_StormCity_GetLordAchive({})
end

function StormTargetHegemonyPop:_updateView()
	self._curPoint = g.core.model.User.stormCityData:getLordAchievePoint()

	self.m_currentValueTxt:setText(g.core.lang:get(304617, {
		num = self._curPoint
	}))

	self._achieveList = g.core.model.User.stormCityData:getLordAchieveList()

	self.m_rewardItemList:setNumItems(#self._achieveList)
end

function StormTargetHegemonyPop:_onInfoClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.storm.view.station.StormOverlordRoadPop").new()))
end

function StormTargetHegemonyPop:_onRewardCellRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCellView(false, self._achieveList[arg_6_1 + 1], self._curPoint)
end

function StormTargetHegemonyPop:_onRcvGetLordAchieveAward(arg_7_1, arg_7_2, arg_7_3)
	self:_updateView()
end

return StormTargetHegemonyPop
