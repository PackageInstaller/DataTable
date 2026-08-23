local var_0_0 = g.core.config.activity_theme_boss_integral_info
local var_0_1 = g.core.model.User.themeData
local ThemeBossPreviewCell = class("ThemeBossPreviewCell", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossPreviewCell"))

function ThemeBossPreviewCell:ctor()
	self._progressWidth = self.m_barImg:getWidth()
	self._awardList = {}
	self._isGetAward = false
	self._themeValue = 0
	self._id = 0

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_getArea:addClickListener(handler(self, self._onClickGetAwardBtn))
	self.m_getBtn:addClickListener(handler(self, self._onClickGetAwardBtn))
end

function ThemeBossPreviewCell:_onClickGetAwardBtn(arg_2_1, arg_2_2)
	var_0_1:getThemeData(self._themeValue):getBossData():requestAutoBossGetAllAward()
end

function ThemeBossPreviewCell:_onRenderAwardList(arg_3_1, arg_3_2)
	arg_3_2:updateIconCell(self._awardList[arg_3_1 + 1], self._isGetAward)
end

function ThemeBossPreviewCell:setShowPos(arg_4_1)
	if arg_4_1 % 2 == 0 then
		self.m_showPosController:setSelectedIndex(1)
	else
		self.m_showPosController:setSelectedIndex(0)
	end
end

function ThemeBossPreviewCell:updatePreviewCell(arg_5_1, arg_5_2, arg_5_3)
	self._themeValue = arg_5_3

	local var_5_0 = var_0_1:getThemeData(arg_5_3):getBossData()

	if not arg_5_1 then
		self.m_stateController:setSelectedIndex(0)

		local var_5_1 = var_5_0:getScoreInfoList()

		self.m_barImg:setWidth(self._progressWidth * math.min(var_5_0:getTotalScore() / var_5_1[#var_5_1].integral_demand, 1))

		return
	end

	if var_5_0:getTotalScore() < arg_5_1.integral_demand then
		self.m_stateController:setSelectedIndex(3)
		self.m_barImg:setWidth(0)
	else
		if var_5_0:isGetAwardById(arg_5_1.id) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(2)
		end

		if var_5_0:getScoreListCurIndex() == arg_5_2 then
			self.m_barImg:setWidth(self._progressWidth * var_5_0:getCurProgressValue())
		else
			self.m_barImg:setWidth(self._progressWidth)
		end
	end

	self.m_scoreText:setText(arg_5_1.integral_demand)

	self._isGetAward = var_5_0:isGetAwardById(arg_5_1.id)
	self._awardList = {}

	local var_5_2 = 1

	while var_0_0.hasKey("reward_type_" .. var_5_2) do
		if arg_5_1["reward_type_" .. var_5_2] > 0 then
			table.insert(self._awardList, {
				type = arg_5_1["reward_type_" .. var_5_2],
				value = arg_5_1["reward_value_" .. var_5_2],
				size = arg_5_1["reward_size_" .. var_5_2]
			})
		end

		var_5_2 = var_5_2 + 1
	end

	local var_5_3 = arg_5_1.reward_token_type

	if arg_5_1.reward_token_type > 0 then
		table.insert(self._awardList, {
			type = var_5_3,
			value = arg_5_1.reward_token_value,
			size = arg_5_1.reward_token_size
		})
	end

	self.m_awardList:setNumItems(#self._awardList)
	self.m_awardList:setScrollEnabled(#self._awardList > 3)
end

return ThemeBossPreviewCell
