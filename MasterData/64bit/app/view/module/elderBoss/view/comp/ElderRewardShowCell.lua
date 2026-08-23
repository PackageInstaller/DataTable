local ElderRewardShowCell = class("ElderRewardShowCell", require("app.fairyGUI.elderBoss.UI_ElderRewardShowCell"))

function ElderRewardShowCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function ElderRewardShowCell:_onAwardListRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateIcon((g.core.common.Goods:convert(self._awardList[arg_2_1 + 1])))
end

function ElderRewardShowCell:updateView(arg_3_1, arg_3_2)
	self._awardList = arg_3_1.data

	self.m_awardList:setNumItems(#self._awardList)

	if arg_3_1.minRank == arg_3_1.maxRank then
		if arg_3_2 == 2 then
			self.m_descTxt:setText(g.core.lang:get(432521, {
				num = arg_3_1.minRank
			}))
		else
			self.m_descTxt:setText(g.core.lang:get(432511, {
				num = arg_3_1.minRank
			}))
		end
	elseif arg_3_2 == 2 then
		self.m_descTxt:setText(g.core.lang:get(432522, {
			min = arg_3_1.minRank,
			max = arg_3_1.maxRank
		}))
	else
		self.m_descTxt:setText(g.core.lang:get(432512, {
			min = arg_3_1.minRank,
			max = arg_3_1.maxRank
		}))
	end
end

return ElderRewardShowCell
