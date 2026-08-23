local NewSlgS2MatchSummaryComp = class("NewSlgS2MatchSummaryComp")

function NewSlgS2MatchSummaryComp:ctor()
	self._txtDesc1 = self:getChild("Txt_desc1")
	self._txtDesc2 = self:getChild("Txt_desc2")
	self._txtDesc3 = self:getChild("Txt_desc3")
	self._scoreCtrl = self:getController("score")
end

function NewSlgS2MatchSummaryComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWSTATISTIC, handler(self, self._onRcvShowStatistic), self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserShowStatistic({})
end

function NewSlgS2MatchSummaryComp:_onRcvShowStatistic(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:updateView(arg_3_4)
end

function NewSlgS2MatchSummaryComp:updateView(arg_4_1)
	self._score = 0

	self:_updateCityData(arg_4_1.attack_city)
	self:_updateMonsterData(arg_4_1.kill_monster)
	self:_updateBossData(arg_4_1.boss_team_win)
	self:_updateScore()
end

function NewSlgS2MatchSummaryComp:_updateScore()
	if self._score == 0 then
		self._scoreCtrl:setSelectedIndex(4)
	elseif self._score == 1 then
		self._scoreCtrl:setSelectedIndex(3)
	elseif self._score == 2 then
		self._scoreCtrl:setSelectedIndex(2)
	elseif self._score == 3 then
		self._scoreCtrl:setSelectedIndex(0)
	end
end

function NewSlgS2MatchSummaryComp:_updateCityData(arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.num or 0
	local var_6_1 = arg_6_1.over_num or 0
	local var_6_2 = arg_6_1.totalNum or 0

	if var_6_2 == 0 or var_6_1 == 0 then
		self._txtDesc1:setText(g.core.lang:getByString(g.core.model.User:getNoticeText(740), {
			num1 = var_6_0
		}))
	elseif var_6_1 + 1 == var_6_2 then
		self._txtDesc1:setText(g.core.lang:getByString(g.core.model.User:getNoticeText(753), {
			num1 = var_6_0
		}))

		self._score = self._score + 1
	else
		local var_6_3 = math.floor(var_6_1 / var_6_2)

		self._txtDesc1:setText(g.core.lang:getByString(g.core.model.User:getNoticeText(739), {
			num1 = var_6_0,
			num2 = var_6_3
		}))

		if var_6_3 >= 50 then
			self._score = self._score + 1
		end
	end
end

function NewSlgS2MatchSummaryComp:_updateMonsterData(arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_1.num or 0
	local var_7_1 = arg_7_1.totalNum or 0
	local var_7_3 = var_7_1 == 0 and 100 or math.floor((arg_7_1.over_num or 0) / var_7_1 * 100) / 100

	if 0 >= 50 then
		self._score = self._score + 1
	end

	self._txtDesc2:setText(g.core.lang:getByString(g.core.model.User:getNoticeText(737), {
		num1 = var_7_0,
		num2 = var_7_3
	}))
end

function NewSlgS2MatchSummaryComp:_updateBossData(arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.num or 0
	local var_8_1 = arg_8_1.totalNum or 0
	local var_8_3 = var_8_1 == 0 and 100 or math.floor((arg_8_1.over_num or 0) / var_8_1 * 100) / 100

	if 0 >= 50 then
		self._score = self._score + 1
	end

	self._txtDesc3:setText(g.core.lang:getByString(g.core.model.User:getNoticeText(738), {
		num1 = var_8_0,
		num2 = var_8_3
	}))
end

return NewSlgS2MatchSummaryComp
