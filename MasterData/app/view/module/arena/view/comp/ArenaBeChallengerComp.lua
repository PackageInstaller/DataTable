local var_0_0 = g.core.const.ConstMgr.ArenaConst
local ArenaCommon = require("app.view.module.arena.common.ArenaCommon")
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User
local ArenaBeChallengerComp = class("ArenaBeChallengerComp", require("app.fairyGUI.arena.UI_ArenaBeChallengerComp"))

function ArenaBeChallengerComp:ctor()
	self._challengeData = nil
	self.m_halfPhotoLoader = self.m_halfPhotoComp:getChild("halfPhotoLoader")

	self.m_rankingController:setSelectedIndex(var_0_0.CTRL_RANKING_OTHER)
	self:_initBtn()
end

function ArenaBeChallengerComp:_initBtn()
	self:addClickListener(handler(self, self._onChallengeClick))
end

function ArenaBeChallengerComp:updateCell(arg_3_1)
	if not arg_3_1 then
		self:setVisible(false)
		self:setTouchable(false)

		return
	end

	self._challengeData = arg_3_1

	self:_refreshKnightPictorialBook(arg_3_1.user)
	self.m_nameTxt:setText((g.core.utils.String.transRobotName(arg_3_1.user)))
	self.m_lvTxt:setText(g.core.lang:get(302516, {
		level = arg_3_1.user.level
	}))
	self.m_powerNumTxt:setText(arg_3_1.user.fight_value)

	self._rank = arg_3_1.rank

	self.m_rankingTxt:setText(self._rank)
	self.m_rankingController:setSelectedIndex((self:_getRankingCtrlerIdx(self._rank)))
	self:setVisible(true)
	self:setTouchable(true)
end

function ArenaBeChallengerComp:_refreshKnightPictorialBook(arg_4_1)
	local var_4_0 = var_0_3.arenaData:getPaintedIdBySnapshot(arg_4_1)

	if var_4_0 then
		self.m_halfPhotoLoader:setURL((var_0_2:getKnightPictorialBook(var_4_0)))
	end
end

function ArenaBeChallengerComp:_getRankingCtrlerIdx(arg_5_1)
	if arg_5_1 == 1 then
		return var_0_0.CTRL_RANKING_1
	elseif arg_5_1 == 2 then
		return var_0_0.CTRL_RANKING_2
	elseif arg_5_1 == 3 then
		return var_0_0.CTRL_RANKING_3
	elseif arg_5_1 > 3 and arg_5_1 < 100 then
		return var_0_0.CTRL_RANKING_2_DIGITS
	elseif arg_5_1 < 1000 then
		return var_0_0.CTRL_RANKING_3_DIGITS
	else
		return var_0_0.CTRL_RANKING_OTHER
	end
end

function ArenaBeChallengerComp:_onChallengeClick()
	if not self._challengeData then
		return
	end

	if not self._challengeData.canChallenge then
		g.core.module.ModuleManager:tip(g.core.lang:get(302503))
	elseif not ArenaCommon.checkLeftCount() then
		return
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.arena.view.ArenaChallengeConfirmPop").new(self._challengeData), {
			touchDisappear = false,
			hideContinue = true
		})
	end
end

return ArenaBeChallengerComp
