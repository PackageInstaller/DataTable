local AncientsActiveAwardsComp = class("AncientsActiveAwardsComp", require("app.fairyGUI.ancients.UI_AncientsActiveAwardsComp"))

function var_0_0:ctor()
	self._awardCellComps = {
		self.m_Comp_awardCell1,
		self.m_Comp_awardCell2,
		self.m_Comp_awardCell3,
		self.m_Comp_awardCell4,
		self.m_Comp_awardCell5
	}
end

function var_0_0:updateView()
	local var_2_0 = g.core.model.User.ancientsData:getActiveCount()

	self.m_Txt_activeNum:setText(var_2_0)

	local var_2_1 = g.core.model.User.ancientsData:getActiveInfoArr()
	local var_2_2 = self.m_Comp_prog:getX()
	local var_2_3 = self.m_Comp_prog:getWidth()
	local var_2_4 = 0
	local var_2_5 = 0
	local var_2_6 = 0

	for iter_2_0 = 1, #var_2_1 do
		if var_2_0 >= var_2_1[iter_2_0].num then
			var_2_4 = var_2_4 + 1
		else
			if iter_2_0 > 1 then
				var_2_5 = var_2_0 - var_2_1[iter_2_0 - 1].num
				var_2_6 = var_2_1[iter_2_0].num - var_2_1[iter_2_0 - 1].num

				break
			end

			var_2_5 = var_2_0
			var_2_6 = var_2_1[iter_2_0].num

			break
		end
	end

	self.m_Comp_prog:setMax(var_2_3)
	self.m_Comp_prog:setValue(var_2_3 / 5 * var_2_4 + var_2_3 / 5 * (var_2_5 / var_2_6))

	for iter_2_1, iter_2_2 in ipairs(self._awardCellComps) do
		if var_2_1[iter_2_1] then
			iter_2_2:setVisible(true)
			iter_2_2:updateCell(var_2_1[iter_2_1])
			iter_2_2:setX(var_2_3 / 5 * iter_2_1 + var_2_2)
		else
			iter_2_2:setVisible(false)
		end
	end
end

return var_0_0
