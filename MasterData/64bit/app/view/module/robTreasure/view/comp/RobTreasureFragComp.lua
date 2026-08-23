local RobTreasureFragComp = class("RobTreasureFragComp")
local var_0_1 = g.core.const.ConstMgr.RobTreasureConst

function RobTreasureFragComp:ctor()
	self.m_fragIcons = {}
	self.m_lines = {}
	self._fragNum = 0
	self.m_selectedIcon = self:getController("selectedIcon")

	for iter_1_0 = 1, var_0_1.MAX_FRAG_NUM do
		local var_1_0 = self:getChild("fragmentCell" .. iter_1_0)

		if var_1_0 then
			self.m_fragIcons[iter_1_0] = var_1_0
			self._fragNum = self._fragNum + 1

			self:addListen(var_1_0)
		else
			break
		end

		self.m_lines[iter_1_0] = self:getChild("line" .. iter_1_0):getController("light")
	end
end

function RobTreasureFragComp:setFragmentInfo(arg_2_1)
	local var_2_0

	for iter_2_0 = 1, self._fragNum do
		local var_2_1 = arg_2_1[iter_2_0]

		self.m_fragIcons[iter_2_0]:setVisible(true)
		self.m_fragIcons[iter_2_0]:updateComp({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = var_2_1.id,
			size = var_2_1.num,
			index = iter_2_0
		})

		local var_2_2

		if var_2_0 then
			if var_2_0 > 0 and var_2_1.num > 0 then
				self.m_lines[iter_2_0 - 1]:setSelectedIndex(1)
			else
				self.m_lines[iter_2_0 - 1]:setSelectedIndex(0)
			end
		else
			var_2_2 = var_2_1.num
		end

		var_2_0 = var_2_1.num
	end

	if var_2_0 > 0 and nil > 0 then
		self.m_lines[self._fragNum]:setSelectedIndex(1)
	else
		self.m_lines[self._fragNum]:setSelectedIndex(0)
	end
end

function RobTreasureFragComp:isSelectedFrag(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.m_fragIcons) do
		if iter_3_1:containPoint(arg_3_1) then
			return true
		end
	end

	self.m_selectedIcon:setSelectedIndex(0)

	return false
end

function RobTreasureFragComp:showEffect()
	for iter_4_0, iter_4_1 in ipairs(self.m_fragIcons) do
		iter_4_1:showEffect()
	end
end

return RobTreasureFragComp
