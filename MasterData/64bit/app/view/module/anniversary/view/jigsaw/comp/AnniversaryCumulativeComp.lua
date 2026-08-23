local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryCumulativeComp = class("AnniversaryCumulativeComp", require("app.fairyGUI.anniversary.UI_AnniversaryCumulativeComp"))

function AnniversaryCumulativeComp:ctor()
	self._cumulativeAwards = {}

	self.m_cumulativeList:setVirtual()
	self.m_cumulativeList:setItemRenderer(handler(self, self._onCumulativeItemRender))
	self:addListen(self.m_cumulativeList)
end

function AnniversaryCumulativeComp:updateCumulativeComp()
	self.m_cumulativeTxt:setText(var_0_0:getCumulativeDrawNum())
	self.m_cumulativeTxt:setColor(var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().jigsaw_draw_number_color))
	self:getChild("n14"):setColor(var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().jigsaw_draw_number_color))

	self._cumulativeAwards = var_0_0:getCumulativeAwards()

	self.m_cumulativeList:setNumItems(#self._cumulativeAwards)
	self:scrollToAwardIdx()
end

function AnniversaryCumulativeComp:scrollToAwardIdx()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(self._cumulativeAwards) do
		local var_3_1 = var_0_0:getJigsawCumulativeState(iter_3_1.id)

		if var_3_1 == var_0_1.CUMULATIVE_AWARD.CAN_GET then
			var_3_0 = iter_3_0

			break
		elseif var_3_1 == var_0_1.CUMULATIVE_AWARD.NOT_GET then
			var_3_0 = iter_3_0

			break
		end
	end

	self.m_cumulativeList:scrollToView(math.max(var_3_0 - 1, 0))
end

function AnniversaryCumulativeComp:_onCumulativeItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateCumulativeCell(self._cumulativeAwards[arg_4_1 + 1 - 1], self._cumulativeAwards[arg_4_1 + 1], arg_4_1 + 1 == #self._cumulativeAwards)
end

return AnniversaryCumulativeComp
