local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.commonCompetitionDataManager
local var_0_2 = g.core.const.ConstMgr.CompetitionConst
local var_0_3 = g.core.common.GlobalFunc
local CompetitionCommonAwardCell = class("CompetitionCommonAwardCell", require("app.fairyGUI.competition.UI_CompetitionCommonAwardCell"))

function CompetitionCommonAwardCell:ctor()
	self._scoreInfo = nil
	self._spineEff = nil
	self._activeSubId = 0

	self.m_iconLoader:addClickListener(handler(self, self._onClickIcon))
end

function CompetitionCommonAwardCell:updateAwardCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if not arg_2_1 then
		return
	end

	if not self._competitionData then
		self._activeSubId = arg_2_4
		self._competitionData = var_0_1:getDataById(arg_2_4)
	end

	local var_2_0 = self._competitionData:getInfo()

	self._scoreInfo = arg_2_1

	self.m_iconLoader:setURL(var_0_0:convert({
		type = self._scoreInfo.reward_type_1,
		value = self._scoreInfo.reward_value_1
	}).icon)
	self.m_scoreIconLoader:setURL(var_0_0:convert({
		type = var_2_0.score_type,
		value = var_2_0.score_value
	}).icon_mini)
	self.m_numTxt:setText("×" .. self._scoreInfo.reward_size_1)
	self.m_scoreTxt:setText(self._scoreInfo.score)

	self._awardState = self._competitionData:getScoreAwardState(self._scoreInfo.id)

	self.m_stateController:setSelectedIndex(self._awardState)
	self.m_bottomController:setSelectedIndex(arg_2_2 and 1 or 0)

	if not arg_2_3 then
		self:_updateProgressBar(arg_2_5)
	end

	self._spineEff = self._spineEff or self.m_effGetAward:addEffectSpine({
		isLoop = true,
		anim = "play_0",
		name = "eff_ui_common_iconget"
	})

	if self._competitionData:isGetInfo() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				subId = self._activeSubId,
				id = arg_2_1.id
			}
		})
	end
end

function CompetitionCommonAwardCell:_updateProgressBar(arg_3_1)
	local var_3_0 = arg_3_1 + 1
	local var_3_1 = self._competitionData:getScoreInfoByLevel(arg_3_1 - 1)
	local var_3_2

	if var_3_1 then
		var_3_2 = var_3_1.score or 0
	end

	local var_3_3 = self._competitionData:getScoreInfoByLevel(var_3_0)
	local var_3_4

	if var_3_3 then
		var_3_4 = var_3_3.score or 0
	end

	self.m_topProgBar:setValue((self:_getProgress(var_3_2, self._scoreInfo.score)))
	self.m_bottomProgBar:setValue((self:_getProgress(self._scoreInfo.score, var_3_4)))
end

function CompetitionCommonAwardCell:_getProgress(arg_4_1, arg_4_2)
	if arg_4_2 - arg_4_1 <= 0 then
		return 100
	else
		return math.max(0, self._competitionData:getCurCompetitionScore() - arg_4_1) / (arg_4_2 - arg_4_1) * 100
	end
end

function CompetitionCommonAwardCell:_onClickIcon()
	if self._awardState == var_0_2.AWARD_STATE.CANGET then
		g.core.network.GameNetProxy:send_C2S_Competition_ScoreAward({
			id = self._competitionData:getCanGetAwardScoreList(),
			activity_sub_id = self._activeSubId
		})
	else
		var_0_3.pushInfoPop({
			type = self._scoreInfo.reward_type_1,
			value = self._scoreInfo.reward_value_1
		})
	end
end

return CompetitionCommonAwardCell
