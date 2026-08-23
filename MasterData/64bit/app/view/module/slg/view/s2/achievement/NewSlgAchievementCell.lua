local var_0_0 = g.core.model.User.newSlgData
local NewSlgAchievementCell = class("NewSlgAchievementCell", require("app.fairyGUI.newSlg.UI_NewSlgAchievementCell"))

function NewSlgAchievementCell:ctor()
	self._info = nil
	self._awards = {}

	self.m_awardList:setIniter()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderListAwardCell))
	self.m_getBtn:addClickListener(handler(self, self._onClickBtnGet))
	self.m_routeBtn:addClickListener(handler(self, self._onClickBtnRoute))
end

function NewSlgAchievementCell:_onRenderListAwardCell(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function NewSlgAchievementCell:_onClickBtnGet()
	self:dispatchCompEvent("NewSlgS2AchieveCell_onClickBtnGet", {
		id = self._info.id
	})
end

function NewSlgAchievementCell:_onClickBtnRoute()
	self:dispatchCompEvent("NewSlgS2AchieveCell_onClickBtnRoute", {
		routeId = self._info.jump
	})
end

function NewSlgAchievementCell:updateCell(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._cellData = arg_5_1
	self._info = var_0_0:getAchievementInfoById(arg_5_1.id)
	self._awards = {}

	for iter_5_0, iter_5_1, iter_5_2 in self._info.gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		if iter_5_2 and iter_5_2[1] ~= 0 then
			table.insert(self._awards, {
				type = iter_5_2[1],
				value = iter_5_2[2],
				size = iter_5_2[3]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awards)

	local var_5_0 = var_0_0:getMainQuestGoal(self._info)

	self.m_taskDesc:setText(self._info.description .. g.core.lang:get(428988, {
		num1 = math.min(arg_5_1.value, var_5_0),
		num2 = var_5_0
	}))
	self.m_stateController:setSelectedIndex(self._cellData.state)
end

return NewSlgAchievementCell
