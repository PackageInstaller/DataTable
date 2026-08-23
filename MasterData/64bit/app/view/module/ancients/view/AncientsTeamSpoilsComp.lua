local AncientsTeamSpoilsComp = class("AncientsTeamSpoilsComp", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsComp"))

function var_0_0:ctor()
	self.m_List_allocated:setIniter(self)
	self.m_List_allocated:setItemRenderer(handler(self, self._onRenderListAllocatedCell))
	self.m_List_myAllocated:setIniter(self)
	self.m_List_myAllocated:setItemRenderer(handler(self, self._onRenderListMyAllocatedCell))
end

function var_0_0:updateView(arg_2_1)
	self._showArr = arg_2_1.showArr
	self._dicesDataMap = arg_2_1.dicesDataMap
	self._weekIndex = arg_2_1.weekIndex
	self._myArr = {}
	self._otherArr = {}

	for iter_2_0, iter_2_1 in ipairs(self._showArr) do
		local var_2_0

		if self._dicesDataMap[self._weekIndex .. "_" .. iter_2_1.id] then
			var_2_0 = self._dicesDataMap[self._weekIndex .. "_" .. iter_2_1.id].rolls or {}

			if var_2_0 and var_2_0[1] and var_2_0[1].uid == g.core.model.User:getId() then
				table.insert(self._myArr, {
					info = iter_2_1,
					dices = var_2_0
				})

				goto label_2_0
			end
		end

		table.insert(self._otherArr, {
			info = iter_2_1,
			dices = var_2_0
		})

		::label_2_0::
	end

	self.m_my_emptyController:setSelectedIndex(#self._myArr > 0 and 0 or 1)
	self.m_List_myAllocated:setNumItems(#self._myArr)
	self.m_List_allocated:setNumItems(#self._otherArr)
	self.m_List_myAllocated:resizeToFit(#self._myArr)
	self.m_List_allocated:resizeToFit(#self._otherArr)
end

function var_0_0:_onRenderListAllocatedCell(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._otherArr[arg_3_1 + 1], arg_3_1)
end

function var_0_0:_onRenderListMyAllocatedCell(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._myArr[arg_4_1 + 1], arg_4_1)
end

return var_0_0
