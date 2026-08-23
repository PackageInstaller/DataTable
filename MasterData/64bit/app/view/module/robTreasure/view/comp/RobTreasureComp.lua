local RobTreasureComp = class("RobTreasureComp", require("app.fairyGUI.robTreasure.UI_RobTreasureComp"))
local var_0_1 = g.core.const.ConstMgr.RobTreasureConst

function RobTreasureComp:ctor()
	self._index = 0
	self._pList = {}

	self:addBg("bg/robTreasure/bg_yizhironghe.jpg")
end

function RobTreasureComp:updateComp(arg_2_1)
	self._pList = arg_2_1.treasureList

	self:updateIndex(arg_2_1.index)
	self:updateSelectedIndex(arg_2_1.selectTreasIndex)
end

function RobTreasureComp:updateIndex(arg_3_1)
	self._index = arg_3_1

	if next(self._pList) then
		for iter_3_0 = 1, var_0_1.MAX_SHOW_TREASURE_NUM do
			self["m_treasure" .. iter_3_0]:updateWithAnimation(self._pList[self._index * var_0_1.MAX_SHOW_TREASURE_NUM + iter_3_0], self._index * var_0_1.MAX_SHOW_TREASURE_NUM + iter_3_0)
		end
	end
end

function RobTreasureComp:updateSelectedIndex(arg_4_1)
	if math.floor((arg_4_1 - 1) / var_0_1.MAX_SHOW_TREASURE_NUM) == self._index then
		local var_4_0 = arg_4_1 % var_0_1.MAX_SHOW_TREASURE_NUM

		var_4_0 = arg_4_1 % var_0_1.MAX_SHOW_TREASURE_NUM == 0 and var_0_1.MAX_SHOW_TREASURE_NUM or var_4_0

		self.m_selectIndexController:setSelectedIndex(var_4_0)
	else
		self.m_selectIndexController:setSelectedIndex(0)
	end
end

return RobTreasureComp
