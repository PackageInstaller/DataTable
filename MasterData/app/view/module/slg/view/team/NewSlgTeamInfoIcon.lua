local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local NewSlgTeamInfoIcon = class("NewSlgTeamInfoIcon", require("app.fairyGUI.newSlg.UI_NewSlgTeamInfoIcon"))

function NewSlgTeamInfoIcon:ctor()
	self._btnIcon = self:getChild("Btn_icon")
	self._groupCd = self:getChild("Group_cd")
	self._txtCd = self:getChild("Txt_cd")
	self._compType = self:getChild("Comp_type")
	self._typeCtrl = self:getController("type")
	self._endTime = 0
end

function NewSlgTeamInfoIcon:updateView(arg_2_1)
	self:cancelAllSchedule()
	self._groupCd:setVisible(false)
	self._typeCtrl:setSelectedIndex(0)

	local var_2_0 = arg_2_1.isAssemble

	self.m_effFight:removeAllEffect()
	self.m_effMarc:removeAllEffect()

	if arg_2_1.character then
		self:setVisible(true)
		self._btnIcon:updateView({
			character = arg_2_1.character
		})
		self._compType:updateView({
			armyType = arg_2_1.troopType
		})

		self._endTime = arg_2_1.endTime or 0
		self._farmTime = arg_2_1.farmTime or 0

		if self._farmTime > 0 then
			self._typeCtrl:setSelectedIndex(4)
			self._groupCd:setVisible(true)
			self:_update()
			self:newSchedule(handler(self, self._update), 1)
		elseif self._endTime > 0 then
			self._groupCd:setVisible(true)

			if arg_2_1.teamStatueFlag == var_0_0.TEAM_CLIENT_STATUS_TYPE.FIGHTING then
				self._typeCtrl:setSelectedIndex(3)
				self.m_effMarc:addEffectSpine({
					isLoop = true,
					name = "eff_ui_newSlg_statefight"
				})
			else
				self._typeCtrl:setSelectedIndex(var_2_0 and 2 or 1)

				if not var_2_0 then
					self.m_effMarc:addEffectSpine({
						isLoop = true,
						name = "eff_ui_newSlg_statemarch"
					})
				end
			end

			self:_update()
			self:newSchedule(handler(self, self._update), 1)
		end
	else
		self:setVisible(false)
	end
end

function NewSlgTeamInfoIcon:_update()
	if self._endTime > 0 then
		local var_3_0 = g.core.common.ServerTime:getTime()

		if self._endTime - var_3_0 >= 0 then
			self._txtCd:setText((g.core.common.ServerTime:getActivityLeftTime(self._endTime - var_3_0)))
		elseif self._farmTime > 0 then
			self._txtCd:setText((g.core.common.ServerTime:secondToHMSString(var_3_0 - self._farmTime)))
		else
			self:cancelAllSchedule()
			self._groupCd:setVisible(false)
		end
	else
		self:cancelAllSchedule()
		self._groupCd:setVisible(false)
	end
end

return NewSlgTeamInfoIcon
