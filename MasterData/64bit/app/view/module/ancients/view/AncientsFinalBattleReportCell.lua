local AncientsFinalBattleReportCell = class("AncientsFinalBattleReportCell", require("app.fairyGUI.ancients.UI_AncientsFinalBattleReportCell"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self.m_List_turn:setVirtual(self)
	self.m_List_turn:setItemRenderer(handler(self, self._onRenderListTurnCell))
end

function var_0_0:updateCell(arg_2_1)
	local var_2_0 = arg_2_1.scoreData
	local var_2_1 = arg_2_1.pathData.pathType == var_0_2.PATH_TYPE.TYPE4

	if arg_2_1.pathData.pathType == var_0_2.PATH_TYPE.TYPE4 then
		self.m_Txt_score:setText(g.core.lang:get(433327))
	else
		local var_2_2 = {}

		var_2_2.num1 = var_2_0.atk_score or 0
		var_2_2.num2 = var_2_0.def_score or 0

		self.m_Txt_score:setText(g.core.lang:get(({
			433324,
			433325,
			433326
		})[arg_2_1.pathData.pathType], var_2_2))
	end

	self.m_Comp_user:updateView(arg_2_1.pathData)

	self._turnsData = arg_2_1.pathData.turnsData

	self.m_has_turnController:setSelectedIndex(#self._turnsData > 0 and 1 or 0)
	self.m_List_turn:setNumItems(#self._turnsData)

	if #self._turnsData > 0 then
		self.m_List_turn:resizeToFit(#self._turnsData)
	end

	self.m_show_userController:setSelectedIndex((#arg_2_1.pathData.atkUserIds > 0 or #arg_2_1.pathData.defUserIds > 0) and not var_2_1 and 1 or 0)
end

function var_0_0:_onRenderListTurnCell(arg_3_1, arg_3_2)
	arg_3_2:updateCell({
		index = arg_3_1,
		turn = self._turnsData[arg_3_1 + 1]
	})
end

return var_0_0
