local var_0_0 = g.core.model.User.warriorsOfFateData
local WarriorsAttrInfoPop = class("WarriorsAttrInfoPop", require("app.fairyGUI.warriorsOfFate.UI_WarriorsAttrInfoPop"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/warriorsOfFate/warriorsOfFate",
		resName = "WarriorsAttrInfoPop",
		pkgName = "warriorsOfFate"
	}, ...)
end)

function WarriorsAttrInfoPop:ctor(arg_2_1)
	self._tabType = arg_2_1.tabType
	self._listStarNum = nil
	self.previousTipLable = nil
	self.attrsData = {}
	self.starListData = {}
	self._isFirstEnter = true
	self._curSelectIndex = 0

	self:showAtCenter()
	self.m_attrsList:setVirtual(self)
	self.m_attrsList:setItemRenderer(handler(self, self._onAttrsItemRenderer))
	self.m_starList:setIniter(self)
	self.m_starList:setItemRenderer(handler(self, self._onStarItemRenderer))
end

function WarriorsAttrInfoPop:onLoad()
	if not self._tabType then
		return
	end

	self:_updateView()
end

function WarriorsAttrInfoPop:_updateView()
	self.m_popPanel:setTitle(g.core.lang:get(105022))
	self:_updateAtrrsList()
	self:_updateStarList()
	self:_updateBaseInfo()
end

function WarriorsAttrInfoPop:_updateAtrrsList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs((var_0_0:getActChaptersByType(self._tabType))) do
		var_5_0[iter_5_1.attribute_type] = var_5_0[iter_5_1.attribute_type] or {
			value = 0,
			type = iter_5_1.attribute_type
		}
		var_5_0[iter_5_1.attribute_type].value = var_5_0[iter_5_1.attribute_type].value + iter_5_1.attribute_value
	end

	self.attrsData = table.values(var_5_0)

	self.m_attrsList:setNumItems(#self.attrsData)
	self.m_attrStateController:setSelectedIndex(#self.attrsData > 0 and 0 or 1)
end

function WarriorsAttrInfoPop:_updateStarList(arg_6_1)
	local var_6_0 = arg_6_1 or {}

	self._curSelectIndex = var_6_0.selectIndex and var_6_0.selectIndex or var_0_0:getNextActStage(1) - 1
	self._listStarNum = #var_0_0:getStageInfoByType(1)

	self.m_starList:setNumItems(self._listStarNum)

	if self._isFirstEnter then
		self._isFirstEnter = false

		self.m_starList:scrollToView(self._curSelectIndex)
	end
end

function WarriorsAttrInfoPop:_updateBaseInfo()
	local var_7_0 = g.core.model.User.knightsData:getMainKnight():getBaseInfo()

	self.m_qualityLoader:setURL(g.core.common.Path:getQualityArtTxtURL(var_7_0.quality) or "")
	self.m_starComp:initStar({
		gap = 1,
		style = 2,
		type = 1,
		index = 3,
		num = var_7_0.star
	})
end

function WarriorsAttrInfoPop:_onAttrsItemRenderer(arg_8_1, arg_8_2)
	local var_8_0, var_8_1 = g.core.lang:getAttr(self.attrsData[arg_8_1 + 1].type, self.attrsData[arg_8_1 + 1].value)

	arg_8_2:updateAttr({
		name = var_8_0,
		value = var_8_1
	})
end

function WarriorsAttrInfoPop:_onStarItemRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateInfo({
		type = self._tabType,
		index = arg_9_1,
		selectIndex = self._curSelectIndex,
		num = self._listStarNum
	})
end

function WarriorsAttrInfoPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "warriorStarItemClick" then
		self:_updateStarList(arg_10_2)
	end
end

return WarriorsAttrInfoPop
