local NewSlgTeamRuleArmyCell = class("NewSlgTeamRuleArmyCell")

function NewSlgTeamRuleArmyCell:ctor()
	self._txtType = self:getChild("Txt_type")
	self._txtName = self:getChild("Txt_name")
	self._txtStarNum = self:getChild("Txt_star_num")
	self._txtStageNum = self:getChild("Txt_stage_num")
	self._txtLevel = self:getChild("Txt_level")
	self._txtRule = self:getChild("Txt_rule")
	self._compArmy = self:getChild("Comp_army")
	self._hasBgCtrl = self:getController("has_bg")
	self._isBaseCtrl = self:getController("is_base")
	self._compStar = self:getChild("starImg")
end

function NewSlgTeamRuleArmyCell:updateCell(arg_2_1)
	self._hasBgCtrl:setSelectedIndex(arg_2_1.index % 2 == 0 and 0 or 1)

	if arg_2_1.info.armyType then
		self:_updateArmy(arg_2_1.info)
	else
		self:_updateItem(arg_2_1.info)
	end
end

function NewSlgTeamRuleArmyCell:_updateItem(arg_3_1)
	self._txtType:setText((g.core.common.GlobalFunc.getEmbryoNameByType(arg_3_1.tp)))

	local var_3_0 = g.core.common.GlobalFunc.getStructByTypeAndSerId(arg_3_1.tp, arg_3_1.id)
	local var_3_1 = var_3_0:getCfg()

	if var_3_0.getCurStarCfg then
		var_3_1 = var_3_0:getCurStarCfg()
	end

	self._txtName:setText(var_3_1.name)

	local var_3_2, var_3_3 = g.core.common.GlobalFunc.getHasItemAndStarNumByTypeAndValue(arg_3_1.tp, (g.core.common.GlobalFunc.getItemAdvIdByInfo(arg_3_1.tp, var_3_1)))

	self._compStar:setVisible(true)
	self._txtStarNum:setVisible(true)
	self._txtStageNum:setVisible(false)
	self._txtStarNum:setText(var_3_3)

	if arg_3_1.isShowValue then
		local var_3_4 = arg_3_1.authority or 0

		self._txtRule:setText(g.core.lang:get(429578, {
			num = var_3_4
		}))
	else
		local var_3_5 = {}

		var_3_5.num = g.core.model.User.newSlgData:getItemAuthorityByCharacter(arg_3_1) / 100 .. "%"

		self._txtRule:setText(g.core.lang:get(429578, var_3_5))
	end
end

function NewSlgTeamRuleArmyCell:_updateArmy(arg_4_1)
	self._isBaseCtrl:setSelectedIndex(1)
	self._compArmy:updateView({
		armyType = arg_4_1.armyType
	})
	self._txtLevel:setText(g.core.lang:get(428987, {
		level = g.core.model.User.newSlgDevelopData:getBarrackLvByType(arg_4_1.armyType)
	}))
	self._txtRule:setText(g.core.lang:get(429578, {
		num = g.core.model.User.newSlgDevelopData:getBarrackAuthorityByType(arg_4_1.armyType) / 100 .. "%"
	}))
end

return NewSlgTeamRuleArmyCell
