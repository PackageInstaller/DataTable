local AncientsTeamSpoilsAllocateCell = class("AncientsTeamSpoilsAllocateCell", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsAllocateCell"))

function var_0_1:ctor()
	self.m_Btn_check:addClickListener(handler(self, self._onClickBtnDetail))
end

function var_0_1:updateCell(arg_2_1)
	local var_2_0
	local var_2_2 = 0

	self._cellData = arg_2_1

	local var_2_3 = arg_2_1.dices and #arg_2_1.dices > 0

	self.m_stateController:setSelectedIndex(arg_2_1.state)

	local var_2_4 = g.core.common.Goods:convert({
		type = arg_2_1.info.type,
		value = arg_2_1.info.value,
		size = arg_2_1.info.size
	})

	if var_2_4 then
		self.m_Comp_icon:setURL(g.core.common.Path:getIconByTypeValue(var_2_4.type, var_2_4.value))
		self.m_goodsNum:setText(var_2_4.size)
		self.m_Txt_goodsName:setText(var_2_4.name)
		self.m_qualityLoader:setURL(g.core.common.Path:getUserIconQualityStarBg(var_2_4.quality))
	else
		dumpError(arg_2_1, "goods is nil")
	end

	if arg_2_1.dices then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.dices) do
			if iter_2_1.uid == g.core.model.User:getId() then
				var_2_0 = iter_2_1
			end

			if var_2_2 < iter_2_1.points then
				var_2_2 = iter_2_1.points
			end
		end
	end

	self.m_Txt_maxPoint:setText(var_2_2)
	self.m_has_diceController:setSelectedIndex(var_2_3 and 1 or 0)
	self.m_has_myDiceController:setSelectedIndex(var_2_0 and 1 or 0)

	if var_2_0 then
		self.m_Txt_curPoint:setText(var_2_0.points)
		self.m_me_maxController:setSelectedIndex(var_2_0.points == var_2_2 and 1 or 0)
	end
end

function var_0_1:_onClickBtnDetail()
	if self._cellData and self._cellData.state == 1 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_TEAM_SPOILS_DETAIL_POP, self._cellData)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(433373))
	end
end

return var_0_1
