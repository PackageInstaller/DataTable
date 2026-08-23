local ActivityReturnProAwardCell = class("ActivityReturnProAwardCell", require("app.fairyGUI.activityReturn.UI_ActivityReturnProAwardCell"))

function ActivityReturnProAwardCell:ctor()
	self._prePro = 0
	self._nextPro = 0
	self._curAward = nil

	self.m_pro:setMax(100)
	self:addClickListener(handler(self, self._onClicked))
end

function ActivityReturnProAwardCell:updateProItem(arg_2_1, arg_2_2)
	self._curAward = arg_2_1
	self._nextPro = arg_2_2.next or arg_2_1.max
	self._prePro = arg_2_2.pre or 0

	if not arg_2_2.next then
		self.m_isFinalController:setSelectedIndex(1)
	else
		self.m_isFinalController:setSelectedIndex(0)
	end

	self.m_stateController:setSelectedIndex(arg_2_1.state)
	self:_updatePro()
	self:setIcon((g.core.common.Path:getIconByTypeValue(arg_2_1.awards[1].type, arg_2_1.awards[1].value)))
	self.m_numTxt:setText(arg_2_1.awards[1].size)
	self:_checkAwardEffect()
end

function ActivityReturnProAwardCell:_updatePro()
	local var_3_0 = self._curAward.cur.num - (self._prePro + (self._curAward.max - self._prePro) / 2)

	if self._curAward.cur.num - (self._prePro + (self._curAward.max - self._prePro) / 2) > 0 then
		var_3_0 = var_3_0 / ((self._curAward.max - self._prePro) / 2 + (self._nextPro - self._curAward.max) / 2)
		var_3_0 = math.ceil(var_3_0 * 100)

		self.m_pro:setValue(var_3_0)
	else
		var_3_0 = 0

		self.m_pro:setValue(0)
	end

	local var_3_1 = self.m_bg:getSize()

	var_3_1.width = math.floor(var_3_1.width * (var_3_0 / 100))

	self.m_bar:setSize(var_3_1)
	self.m_proText:setText(self._curAward.max)
end

function ActivityReturnProAwardCell:_onClicked()
	if self._curAward.state == 1 then
		self:dispatchCompEvent("getStageAward", {
			idList = {
				self._curAward.cfg.id
			}
		})
	else
		g.core.common.GlobalFunc.pushInfoPop(self._curAward.awards[1])
	end
end

function ActivityReturnProAwardCell:_checkAwardEffect()
	self.m_eff:removeAllEffect()

	if self.m_stateController:getSelectedIndex() == 1 then
		self.m_eff:addEffectSpine({
			remove = false,
			name = "eff_ui_activityReturn_icon",
			anim = "play",
			isLoop = true
		})
	end
end

return ActivityReturnProAwardCell
