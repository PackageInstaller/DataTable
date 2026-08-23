local HomeInfoRemindDetailCell = class("HomeInfoRemindDetailCell", require("app.fairyGUI.home.UI_HomeInfoRemindDetailCell"))

function HomeInfoRemindDetailCell:ctor()
	self._data = nil

	self.m_btn:addClickListener(handler(self, self._onBtnClicked))
	self.m_pro:setMax(100)
end

function HomeInfoRemindDetailCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.updateDes), self)
end

function HomeInfoRemindDetailCell:updateDetailCell(arg_3_1)
	self._data = arg_3_1

	self.m_icon:setURL(g.core.common.Path:getTipsIcon((arg_3_1:getTipIconId())))
	self:updateDes()
	self:updateBtn()
	g.core.model.User.homeInfoRemindData:setViewTip(arg_3_1)

	if arg_3_1:getExpireTime() then
		self:updateTime()
		self:updatePro()
	end

	self.m_templateController:setSelectedIndex(arg_3_1:getCfg().template_type - 1)
end

function HomeInfoRemindDetailCell:updateDes()
	local var_4_0 = self._data:getTipStr()

	self.m_des:setText(var_4_0)
	self.m_desText:setText(var_4_0)
end

function HomeInfoRemindDetailCell:updateBtn()
	local var_5_0 = self._data:getCfg()

	if var_5_0.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG then
		if var_5_0.id % 2 == 1 then
			self.m_btn:setTitle(g.core.lang:get(429549))
			self.m_btn:setCtrlState("style", {
				index = 11
			})
		elseif var_5_0.id % 2 == 0 then
			self.m_btn:setTitle(g.core.lang:get(429550))
			self.m_btn:setCtrlState("style", {
				index = 12
			})
		end
	else
		self.m_btn:setTitle(g.core.lang:get(303005))
		self.m_btn:setCtrlState("style", {
			index = 11
		})
	end
end

function HomeInfoRemindDetailCell:updatePro()
	local var_6_0 = string.split(self._data:getParams(), ":")

	if #var_6_0 > 1 then
		local var_6_1 = self._data:getExpireTime()

		self.m_pro:setValue(math.floor((var_6_1 - g.core.common.ServerTime:getTime()) / (var_6_1 - tonumber(var_6_0[3])) * 100))
		self.m_pro:setVisible(true)
	else
		self.m_pro:setVisible(false)
	end
end

function HomeInfoRemindDetailCell:updateTime()
	local var_7_0 = self._data:getExpireTime()

	if not var_7_0 then
		self.m_proTxt:setText("")

		return
	end

	if var_7_0 - g.core.common.ServerTime:getTime() > 0 then
		self.m_proTxt:setText(g.core.common.ServerTime:getLeftSecondsString(var_7_0))
	else
		self.m_proTxt:setText("")
	end
end

function HomeInfoRemindDetailCell:_onBtnClicked()
	local var_8_0 = self._data:getExpireTime()

	if var_8_0 then
		if var_8_0 > g.core.common.ServerTime:getTime() then
			self:dispatchCompEvent("clickTip", {
				data = self._data
			})
		else
			self:dispatchCompEvent("refreshComp")
		end
	else
		self:dispatchCompEvent("clickTip", {
			data = self._data
		})
	end
end

return HomeInfoRemindDetailCell
