local var_0_0 = g.core.model.User.newSlgData
local NewSlgPvcQuestCell = class("NewSlgPvcQuestCell", require("app.fairyGUI.newSlg.UI_NewSlgPvcQuestCell"))

function NewSlgPvcQuestCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderListAwardCell))
	self.m_getBtn:addClickListener(handler(self, self._onClickBtnGet))
	self.m_routeBtn:addClickListener(handler(self, self._onClickBtnRoute))
end

function NewSlgPvcQuestCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._cfg = arg_2_1.cfg
	self._state = arg_2_1.state
	self._cityIdIndex = arg_2_1.cityIdIndex
	self._awards = {}

	for iter_2_0, iter_2_1, iter_2_2 in self._cfg.gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		if iter_2_2 and iter_2_2[1] ~= 0 then
			table.insert(self._awards, {
				type = iter_2_2[1],
				value = iter_2_2[2],
				size = iter_2_2[3]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awards)
	self.m_nameTxt:setText(self._cfg.name)
	self.m_taskDescTxt:setText(self._cfg.description .. "(" .. g.core.lang:get(428977, {
		num1 = math.min(var_0_0:getCityQuestProgress(self._cfg.level), self._cfg.num),
		num2 = self._cfg.num
	}) .. ")")
	self.m_stateController:setSelectedIndex(self._state)
end

function NewSlgPvcQuestCell:_onRenderListAwardCell(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

function NewSlgPvcQuestCell:_onClickBtnGet()
	self:dispatchCompEvent("NewSlgPvcQuestCell_onClickBtnGet", {
		id = self._cfg.id
	})
end

function NewSlgPvcQuestCell:_onClickBtnRoute()
	self:dispatchCompEvent("NewSlgPvcQuestCell_onClickBtnRoute", {
		cityIdIndex = self._cityIdIndex
	})
end

return NewSlgPvcQuestCell
