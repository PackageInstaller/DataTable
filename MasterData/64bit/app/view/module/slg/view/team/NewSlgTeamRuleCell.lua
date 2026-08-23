local NewSlgTeamRuleCell = class("NewSlgTeamRuleCell")

function NewSlgTeamRuleCell:ctor()
	self._compTitle = self:getChild("title")
	self._txtRule = self:getChild("Txt_rule")
	self._txtRule1 = self:getChild("Txt_rule1")
	self._txtUnlock = self:getChild("Txt_unlock")
	self._txtFormula = self:getChild("Txt_formula")
	self._listArmy = self:getChild("List_army")

	self._listArmy:setIniter(self)
	self._listArmy:setItemRenderer(handler(self, self._onRenderListArmyCell))

	self._isBaseCtrl = self:getController("is_base")
	self._teamIndex = nil
	self._team = nil
	self._showArr = {}
end

function NewSlgTeamRuleCell:updateCell(arg_2_1)
	if arg_2_1.isBase then
		self:_updateBase()

		return
	end

	local var_2_0 = g.core.const.ConstMgr.NewSlgConst

	self._showArr = {}
	self._teamIndex = arg_2_1.teamIndex

	local var_2_1, var_2_2, var_2_3 = g.core.model.User.newSlgData:getTeamUnlockLevelByIndex(self._teamIndex)

	self._team = arg_2_1.team

	self._compTitle:setText(g.core.lang:get(428818, {
		index = self._teamIndex
	}))
	self._listArmy:setVisible(true)

	if var_2_1 then
		self._team = self._team or g.core.model.User.newSlgData:getInitTeamData(self._teamIndex)

		local var_2_4 = g.core.model.User.newSlgData:getTeamAuthorityByTeam(self._team)
		local var_2_5 = self._team.characters or {}

		self._showArr = {
			{
				armyType = self._team.troop_type
			}
		}

		local var_2_6 = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_5) do
			if iter_2_1.tp == g.core.common.Goods.TYPE_KNIGHT and iter_2_1.base_id then
				local var_2_7 = g.core.common.Goods.CFG[iter_2_1.tp].get(iter_2_1.base_id).classical

				if var_2_7 ~= 0 then
					var_2_6[#var_2_6 + 1] = var_2_7
				end
			end

			table.insert(self._showArr, iter_2_1)
		end

		local var_2_8, var_2_9 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_2_6)

		self._listArmy:setNumItems(#self._showArr)
		self._listArmy:resizeToFit(#self._showArr)

		local var_2_10 = g.core.model.User.newSlgDevelopData:getBarrackAuthorityByType(self._team.troop_type)

		for iter_2_2, iter_2_3 in ipairs(var_2_5) do
			var_2_10 = var_2_10 + g.core.model.User.newSlgData:getItemAuthorityByCharacter(iter_2_3)
		end

		if var_2_8 > 0 then
			local var_2_11 = 0

			for iter_2_4, iter_2_5 in ipairs(var_2_9) do
				var_2_11 = var_2_11 + iter_2_5.value
			end

			self._txtFormula:setText(g.core.lang:get(429808, {
				num = var_2_10 / 100,
				elemNum = var_2_11 / 100
			}))
		else
			self._txtFormula:setText(g.core.lang:get(429575, {
				num = var_2_10 / 100
			}))
		end

		self._txtRule:setText(var_2_4)
	else
		self._isBaseCtrl:setSelectedIndex(2)

		local var_2_12 = g.core.lang:get(429539, {
			level = var_2_2
		})

		self._txtUnlock:setText((var_2_0.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE == var_2_3 or nil) and g.core.lang:get(429805, {
			name = g.core.lang:get(429805 + var_2_2)
		}))
		self._listArmy:setNumItems(0)
		self._listArmy:resizeToFit(0)
	end
end

function NewSlgTeamRuleCell:_updateBase()
	self._isBaseCtrl:setSelectedIndex(1)
	self._compTitle:setText(g.core.lang:get(429576))
	self._txtRule1:setText(g.core.lang:get(429577, {
		num = g.core.model.User.newSlgDevelopData:getTotalAuthority()
	}))

	self._showArr = {}

	for iter_3_0, iter_3_1 in pairs(g.core.model.User.newSlgDevelopData:getLineUpEmbryoStructMap() or {}) do
		local var_3_0 = iter_3_1:getCfg()

		table.insert(self._showArr, {
			isShowValue = true,
			base_id = var_3_0.cards_id,
			id = g.core.common.GlobalFunc.getSerIdByTypeAndStruct(var_3_0.type, (g.core.common.GlobalFunc.getStructByTypeAndValue(var_3_0.type, var_3_0.advance_id))),
			tp = var_3_0.type,
			authority = var_3_0.authority
		})
	end

	table.sort(self._showArr, function(arg_4_0, arg_4_1)
		if arg_4_0.tp ~= arg_4_1.tp then
			return arg_4_0.tp < arg_4_1.tp
		end

		return arg_4_0.authority > arg_4_1.authority
	end)
	dump(self._showArr)
	self._listArmy:setNumItems(#self._showArr)
	self._listArmy:resizeToFit(#self._showArr)
end

function NewSlgTeamRuleCell:_onRenderListArmyCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell({
		info = self._showArr[arg_5_1 + 1],
		index = arg_5_1 + 1
	})
end

return NewSlgTeamRuleCell
