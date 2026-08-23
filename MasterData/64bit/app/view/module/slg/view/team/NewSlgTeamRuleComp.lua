local NewSlgTeamRuleComp = class("NewSlgTeamRuleComp")

function NewSlgTeamRuleComp:ctor()
	self._comp1 = self:getChild("Comp_1")
	self._comp2 = self:getChild("Comp_2")
	self._comp3 = self:getChild("Comp_3")
	self._comp4 = self:getChild("Comp_4")
	self._comp5 = self:getChild("Comp_5")
	self._txtRule = self:getChild("Txt_rule")
	self._hasExtTeamCtr = self:getController("hasExtTeam")
	self._teamMap = clone(g.core.model.User.newSlgData:getMyTeamMap())
end

function NewSlgTeamRuleComp:updateView(arg_2_1)
	if arg_2_1 and arg_2_1.teamMap then
		self._teamMap = arg_2_1.teamMap
	end

	self:_updateView()
end

function NewSlgTeamRuleComp:_updateView()
	local var_3_0 = g.core.model.User.newSlgData:getMaxTeamCnt()

	self._hasExtTeamCtr:setSelectedIndex(g.core.model.User.newSlgDevelopData:getMaxTroopNum() < var_3_0 and 1 or 0)

	local var_3_1 = g.core.model.User.newSlgData:getCurTeamCnt()

	for iter_3_0 = 1, var_3_0 do
		self["_comp" .. iter_3_0]:updateCell({
			teamIndex = iter_3_0,
			team = self._teamMap[iter_3_0]
		})
	end

	self._txtRule:setText(g.core.model.User.newSlgData:getMyTeamAllAuthority())
	self._comp5:updateCell({
		isBase = true
	})
end

return NewSlgTeamRuleComp
