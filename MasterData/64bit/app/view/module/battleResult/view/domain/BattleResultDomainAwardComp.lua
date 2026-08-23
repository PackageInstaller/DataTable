local var_0_0 = g.core.const.ConstMgr.DomainConst
local BattleResultDomainAwardComp = class("BattleResultDomainAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultDomainAwardComp"))

function BattleResultDomainAwardComp:ctor()
	self._awardParams = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultDomainAwardComp:_onTransAward()
	if self._awardParams then
		self.m_awardList:setNumItems(#self._awardParams)
		self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	end
end

function BattleResultDomainAwardComp:_onListAwardRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateAwardIcon(self._awardParams[arg_3_1 + 1])
end

function BattleResultDomainAwardComp:update(arg_4_1)
	self._firstAward = arg_4_1.firstAwards or {}
	self._gradeAward = arg_4_1.gradeAwards or {}
	self._awardParams = {}

	for iter_4_0, iter_4_1 in ipairs(self._firstAward) do
		table.insert(self._awardParams, {
			isFirst = true,
			award = iter_4_1
		})
	end

	for iter_4_2, iter_4_3 in ipairs(self._gradeAward) do
		table.insert(self._awardParams, {
			isFirst = false,
			award = iter_4_3
		})
	end

	local var_4_0 = g.core.model.User.domainData:getDungeon(arg_4_1.id)

	self.m_hpTxt:setText(var_4_0:getStage((var_4_0:getCurStageAndGrade())):getStageInfo().grade_type == var_0_0.GRADE_TYPE.HP and g.core.lang:get(433159, {
		hp = arg_4_1.gradeParam
	}) or g.core.lang:get(433160, {
		num = arg_4_1.gradeParam
	}))
end

return BattleResultDomainAwardComp
