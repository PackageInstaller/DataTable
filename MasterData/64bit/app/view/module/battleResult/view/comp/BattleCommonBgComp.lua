local var_0_0 = {
	DONG_XI = 3,
	LIN_DONG = 2,
	JIAO_GUO = 1,
	LI_JIN = 4
}
local var_0_1 = {
	[var_0_0.JIAO_GUO] = "ui://base_new/icon_jiaoguo_4",
	[var_0_0.LIN_DONG] = "ui://base_new/icon_lindonggongye_4",
	[var_0_0.DONG_XI] = "ui://base_new/icon_dongxi_4",
	[var_0_0.LI_JIN] = "ui://base_new/icon_lijinlianmeng_4"
}
local BattleCommonBgComp = class("BattleCommonBgComp", require("app.fairyGUI.battleResult.UI_BattleCommonBgComp"))

function BattleCommonBgComp:ctor()
	self._startPos = {
		x = self.m_redImg:getX(),
		y = self.m_redImg:getY()
	}

	self.m_comEnterTransition:setHook("playImgEnter", handler(self, self._playEnterRedImg))

	self.m_againChallengeBtn = self:getChild("againChallengeBtn")

	if self.m_againChallengeBtn then
		self.m_againChallengeBtn:addClickListener(handler(self, self._onClickAgainChallenge))
	end
end

function BattleCommonBgComp:_playEnterRedImg()
	local var_2_0 = (display.width - 1334) / 2

	if (display.width - 1334) / 2 > 0 then
		if self._startPos.x + var_2_0 > 0 then
			var_2_0 = -self._startPos.x

			self.m_redImg:setWidth(self.m_redImg:getWidth() + (self._startPos.x + var_2_0))
		end

		self.m_redImgEnterTransition:changeParams({
			changePos = {
				self._startPos.x + var_2_0,
				self._startPos.y
			}
		}):play()
	else
		self.m_redImgEnterTransition:play()
	end
end

function BattleCommonBgComp:update(arg_3_1)
	if arg_3_1.isWin and arg_3_1.knight_id then
		self.m_campIcon:setURL(var_0_1[g.core.config.knight_info.get(arg_3_1.knight_id).group])
	else
		self:_showFailureState(arg_3_1)
	end

	self.gameType = arg_3_1.gameType
end

function BattleCommonBgComp:_showFailureState(arg_4_1)
	if self.m_failEnterTransition then
		self.m_failEnterTransition:setHook("failDot", handler(self, self._onFailDotBegin))
	end
end

function BattleCommonBgComp:_onFailDotBegin()
	self.m_failDot:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_dungeon_failDot"
	})
end

function BattleCommonBgComp:_onClickAgainChallenge()
	if self.gameType == 4 then
		self:dispatchCompEvent("rest_puzzle_game")
	elseif self.gameType == 3 then
		self:dispatchCompEvent("reset_gem_eliminate")
	elseif self.gameType == 5 then
		self:dispatchCompEvent("reset_guess")
	else
		self:dispatchCompEvent("reset_turn_card")
	end
end

return BattleCommonBgComp
