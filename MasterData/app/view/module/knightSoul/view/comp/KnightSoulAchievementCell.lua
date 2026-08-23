local var_0_0 = g.core.model.User.knightSoulData
local KnightSoulAchievementCell = class("KnightSoulAchievementCell", require("app.fairyGUI.knightSoul.UI_KnightSoulAchievementCell"))

function KnightSoulAchievementCell:ctor()
	self:addClickListener(handler(self, self._onSelfClick))
end

function KnightSoulAchievementCell:setShowData(arg_2_1)
	arg_2_1 = arg_2_1 or self._showData
	self._lineBaseAdd = arg_2_1.isBigLine and 2 or 0
	self._showData = arg_2_1
	self._showIndex = arg_2_1.index

	if arg_2_1.isLast then
		self.m_lineLoader:setVisible(false)
	else
		self.m_lineLoader:setVisible(true)
	end

	local var_2_0 = arg_2_1.cfg

	self.m_scoreTxt:setText(arg_2_1.cfg.honor_num)
	self.m_nameTxt:setText(var_2_0.name)
	self.m_eff:removeAllEffect()

	if var_2_0.type == 1 then
		if arg_2_1.isActive then
			self.m_typeController:setSelectedIndex(1)
		else
			self.m_typeController:setSelectedIndex(0)

			if var_2_0.id == var_0_0:getActivationHonorId() + 1 and var_2_0.honor_num <= var_0_0:getCurHonorNum() then
				self.m_eff:addEffectSpine({
					anim = "play_small",
					name = "eff_ui_KnightSoul_achvCell",
					isLoop = true
				})
			end
		end
	elseif arg_2_1.isActive then
		self.m_typeController:setSelectedIndex(3)
	else
		self.m_typeController:setSelectedIndex(2)

		if var_2_0.id == var_0_0:getActivationHonorId() + 1 and var_2_0.honor_num <= var_0_0:getCurHonorNum() then
			self.m_eff:addEffectSpine({
				anim = "play_big",
				name = "eff_ui_KnightSoul_achvCell",
				isLoop = true
			})
		end
	end

	if var_2_0.id + 1 <= var_0_0:getActivationHonorId() then
		self.m_isBigPointController:setSelectedIndex(self._lineBaseAdd + 1)
	else
		self.m_isBigPointController:setSelectedIndex(self._lineBaseAdd)
	end

	if var_0_0:getActivationHonorId() < var_2_0.id then
		self.m_activeController:setSelectedIndex(1)
	else
		self.m_activeController:setSelectedIndex(0)
	end

	self.m_indexController:setSelectedIndex(self._showIndex % 2 == 0 and 1 or 0)
end

function KnightSoulAchievementCell:checkSelIndex(arg_3_1)
	if self._showData and self._showData.index == arg_3_1 then
		self.m_inSelectController:setSelectedIndex(1)
	else
		self.m_inSelectController:setSelectedIndex(0)
	end
end

function KnightSoulAchievementCell:updateActiveState()
	self:setShowData()
end

function KnightSoulAchievementCell:_onSelfClick()
	if self._showData then
		self:dispatchCompEvent("KnightSoulAchievementSelectItem", self._showData)
	end
end

function KnightSoulAchievementCell:getShowIndex()
	return self._showIndex
end

function KnightSoulAchievementCell:getShowX()
	return self._showData.posX
end

return KnightSoulAchievementCell
