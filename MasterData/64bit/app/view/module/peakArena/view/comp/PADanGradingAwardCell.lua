local var_0_0 = g.core.common.Path
local PARankAwardCell = class("PARankAwardCell", require("app.fairyGUI.peakArena.UI_PADanGradingAwardCell"))

function PARankAwardCell:ctor()
	self._awardData = {}

	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onIconListRenderer))
end

function PARankAwardCell:updateCell(arg_2_1, arg_2_2)
	self._awardData = arg_2_2.awardData

	self.m_showBgController:setSelectedIndex(arg_2_1 and 1 or 0)

	if arg_2_2.maxScore == 0 then
		self.m_score:setText(g.core.lang:get(307018, {
			score = arg_2_2.minScore
		}))
	else
		self.m_score:setText(g.core.lang:get(307019, {
			minScore = arg_2_2.minScore,
			maxScore = arg_2_2.maxScore
		}))
	end

	local var_2_0 = arg_2_2.cfg

	self.m_rankIcon:setURL(var_0_0:getPeakArenaDanGradingPic(arg_2_2.cfg.pic))
	self.m_levelName:setText(var_2_0.name)
	self.m_iconList:setNumItems(#self._awardData)
end

function PARankAwardCell:_onIconListRenderer(arg_3_1, arg_3_2)
	self._awardData[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._awardData[arg_3_1 + 1])
end

return PARankAwardCell
