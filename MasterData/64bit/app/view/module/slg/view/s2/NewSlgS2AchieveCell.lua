local NewSlgS2AchieveCell = class("NewSlgS2AchieveCell")

function NewSlgS2AchieveCell:ctor()
	self._listAward = self:getChild("List_award")

	self._listAward:setVirtual(self)
	self._listAward:setItemRenderer(handler(self, self._onRenderListAwardCell))

	self._txtPercent = self:getChild("Txt_percent")
	self._txtTaskDesc = self:getChild("Txt_taskDesc")
	self._btnGet = self:getChild("Btn_get")

	self._btnGet:addClickListener(handler(self, self._onClickBtnGet))
	self._btnGet:addBtnEffect()

	self._btnRoute = self:getChild("Btn_route")

	self._btnRoute:addClickListener(handler(self, self._onClickBtnRoute))

	self._stateCtrl = self:getController("state")
end

function NewSlgS2AchieveCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._cellData = arg_2_1
	self._info = g.core.model.User.newSlgData:getAchievementInfoById(arg_2_1.id)

	self._txtTaskDesc:setText(self._info.description)

	self._awards = {}

	for iter_2_0, iter_2_1, iter_2_2 in self._info.gmatch({
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

	self._listAward:setNumItems(#self._awards)

	local var_2_0 = g.core.model.User.newSlgData:getMainQuestGoal(self._info)

	self._txtPercent:setText(g.core.lang:get("COMMON_PROG_TXT", {
		num1 = math.min(arg_2_1.value, var_2_0),
		num2 = var_2_0
	}))
	self._stateCtrl:setSelectedIndex(self._cellData.state)
end

function NewSlgS2AchieveCell:_onRenderListAwardCell(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

function NewSlgS2AchieveCell:_onClickBtnGet()
	self:dispatchCompEvent("NewSlgS2AchieveCell_onClickBtnGet", {
		id = self._info.id
	})
end

function NewSlgS2AchieveCell:_onClickBtnRoute()
	self:dispatchCompEvent("NewSlgS2AchieveCell_onClickBtnRoute", {
		routeId = self._info.jump
	})
end

return NewSlgS2AchieveCell
