local var_0_0 = g.core.model.User.knightFavoData
local FavoKnightListComp = class("FavoKnightListComp", require("app.fairyGUI.knightFavorability.UI_FavoKnightListComp"))

function FavoKnightListComp:ctor(arg_1_1)
	self._tabGroup = 0
	self._ownKnightList = {}
	self._curKnightList = {}

	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupItemClick))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onKnightItemClick))
	self.m_knightList:setVirtual()
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._renderItem))
	self.m_groupList:setSelectedIndex(0)
	self.m_runnerComp:init({
		target = self.m_groupList
	})
end

function FavoKnightListComp:_onGroupItemClick(arg_2_1)
	local var_2_0 = arg_2_1:getDataValue()

	if self._tabGroup ~= var_2_0 then
		self._tabGroup = var_2_0

		self:_updateComp()
	end
end

function FavoKnightListComp:_onKnightItemClick(arg_3_1)
	g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_FAVO, {
		knightList = self._curKnightList,
		selectedIndex = arg_3_1:getDataValue() + 1
	})
end

function FavoKnightListComp:_renderItem(arg_4_1, arg_4_2)
	arg_4_2:updateView(self._curKnightList[arg_4_1 + 1])
end

function FavoKnightListComp:updateView()
	self._ownKnightList = {}

	self:_updateComp()
end

function FavoKnightListComp:_updateComp()
	self._curKnightList = self:_getShowKnightList()

	if #self._curKnightList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_knightList:setNumItems(#self._curKnightList)
		self.m_knightList:transitionShowCells("enter_scaleOut", 0.03)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function FavoKnightListComp:_getShowKnightList()
	local var_7_0 = self._ownKnightList[self._tabGroup]

	if not self._ownKnightList[self._tabGroup] then
		var_7_0 = var_0_0:getOwnDisplayedKnightArr(self._tabGroup)
		self._ownKnightList[self._tabGroup] = var_7_0
	end

	return var_7_0
end

return FavoKnightListComp
