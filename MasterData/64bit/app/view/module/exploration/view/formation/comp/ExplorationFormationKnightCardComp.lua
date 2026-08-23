local var_0_0 = g.core.model.User.knightsData
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.common.Path
local ExplorationFormationKnightCardComp = class("ExplorationFormationKnightCardComp", require("app.fairyGUI.exploration.UI_ExplorationFormationKnightCardComp"))

function ExplorationFormationKnightCardComp:ctor()
	self._sid = 0
	self._index = 0

	self:addClickListener(handler(self, self._onClickKnight))
	self.m_starComp:initStar({
		style = 2,
		num = 0,
		gap = 0,
		index = 3,
		max = var_0_1.STAR_MAX
	})
end

function ExplorationFormationKnightCardComp:updateKnightCard(arg_2_1, arg_2_2)
	self._index = arg_2_2 or 0
	self._sid = arg_2_1 or 0

	if self._sid == 0 then
		self.m_hasPlayerController:setSelectedIndex(0)
		self.m_qualityLine:setURL(var_0_2:getMulTeamLeftVerticalQualityBarURL(0))

		return
	end

	self.m_hasPlayerController:setSelectedIndex(1)

	local var_2_0 = var_0_0:getKnightById(self._sid)

	self.m_knightNameTxt:setText(var_2_0:getName())
	self.m_starComp:setStarNum(var_2_0:getStarLv())
	self.m_knightLoader:setURL(var_0_2:getKnightBookPicRes(var_2_0:getResInfo().painted_id))
	self.m_qualityLine:setURL(var_0_2:getMulTeamLeftVerticalQualityBarURL(var_2_0:getQuality()))
end

function ExplorationFormationKnightCardComp:_onClickKnight()
	self:dispatchCompEvent("pop_knight_list", {
		index = self._index
	})
end

return ExplorationFormationKnightCardComp
