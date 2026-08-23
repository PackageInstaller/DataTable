local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.competitionData
local var_0_2 = g.core.const.ConstMgr.CompetitionConst
local var_0_3 = g.core.common.GlobalFunc
local var_0_4 = g.core.config.competition_score_info
local CompetitionAwardCell = class("CompetitionAwardCell", require("app.fairyGUI.competition.UI_CompetitionAwardCell"))

function CompetitionAwardCell:ctor()
	self._scoreInfo = nil
	self._spineEff = nil

	self.m_iconLoader:addClickListener(handler(self, self._onClickIcon))
end

function CompetitionAwardCell:updateAwardCell(arg_2_1, arg_2_2, arg_2_3)
	self._scoreInfo = arg_2_1

	self.m_iconLoader:setURL(var_0_0:convert({
		type = self._scoreInfo.reward_type_1,
		value = self._scoreInfo.reward_value_1
	}).icon)
	self.m_scoreIconLoader:setURL(var_0_0:convert({
		type = var_0_0.TYPE_RESOURCE,
		value = var_0_2.COMPETITION_SCORE_VALUE
	}).icon_mini)
	self.m_numTxt:setText("×" .. self._scoreInfo.reward_size_1)
	self.m_scoreTxt:setText(self._scoreInfo.score)

	self._awardState = var_0_1:getScoreAwardState(self._scoreInfo.id)

	self.m_stateController:setSelectedIndex(self._awardState)
	self.m_bottomController:setSelectedIndex(arg_2_2 and 1 or 0)

	if not arg_2_3 then
		self:_updateProgressBar()
	end

	self._spineEff = self._spineEff or self.m_effGetAward:addEffectSpine({
		anim = "play_0",
		name = "eff_ui_common_iconget",
		isLoop = true
	})

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = arg_2_1.id
		}
	})
end

function CompetitionAwardCell:_updateProgressBar()
	local var_3_0 = self._scoreInfo.id + 1
	local var_3_1 = var_0_4.fetch(self._scoreInfo.id - 1)
	local var_3_2

	if var_3_1 then
		var_3_2 = var_3_1.score or 0
	end

	local var_3_3 = var_0_4.fetch(var_3_0)
	local var_3_4

	if var_3_3 then
		var_3_4 = var_3_3.score or 0
	end

	self.m_topProgBar:setValue((self:_getProgress(var_3_2, self._scoreInfo.score)))
	self.m_bottomProgBar:setValue((self:_getProgress(self._scoreInfo.score, var_3_4)))
end

function CompetitionAwardCell:_getProgress(arg_4_1, arg_4_2)
	if arg_4_2 - arg_4_1 <= 0 then
		return 100
	else
		return math.max(0, var_0_1:getCurCompetitionScore() - arg_4_1) / (arg_4_2 - arg_4_1) * 100
	end
end

function CompetitionAwardCell:_onClickIcon()
	if self._awardState == var_0_2.AWARD_STATE.CANGET then
		g.core.network.GameNetProxy:send_C2S_HandbookCompetition_GetAward({
			id = var_0_1:getCanGetAwardScoreList(),
			type = var_0_2.AWARD_TYPE.SCORE
		})
	else
		var_0_3.pushInfoPop({
			type = self._scoreInfo.reward_type_1,
			value = self._scoreInfo.reward_value_1
		})
	end
end

return CompetitionAwardCell
