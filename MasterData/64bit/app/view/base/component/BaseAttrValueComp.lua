local var_0_1 = {
	BLACK = 1,
	WHITE = 2
}
local BaseAttrValueComp = class("BaseAttrValueComp", require("app.fairyGUI.base_new.UI_BaseAttrValueComp1"))

function BaseAttrValueComp:updateView(arg_1_1)
	self:updateAttr(arg_1_1)
end

function BaseAttrValueComp:updateAttr(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._iconType = arg_2_1.iconType

	local var_2_0 = arg_2_1.name
	local var_2_1 = arg_2_1.value
	local var_2_2 = arg_2_1.value2 or ""

	if arg_2_1.type then
		var_2_0, var_2_1 = g.core.lang:getAttr(arg_2_1.type, tonumber(arg_2_1.value), arg_2_1.withoutPlus1 ~= false and true or false)

		if arg_2_1.value2 then
			var_2_2 = g.core.lang:getAttrValue(arg_2_1.type, tonumber(arg_2_1.value2), ((arg_2_1.isShowAnima or nil) and true) ~= false and true or false)
		end
	end

	if arg_2_1.name and arg_2_1.name ~= "" then
		var_2_0 = arg_2_1.name
	end

	if arg_2_1.isAll then
		var_2_0 = g.core.lang:get(2071, {
			name = var_2_0
		})
	end

	if arg_2_1.isAllDev then
		var_2_0 = g.core.lang:get(2079, {
			name = var_2_0
		})
	end

	self:setAttrIconByType(arg_2_1.type, arg_2_1.iconRes)
	self:_setName(var_2_0 or "")
	self:_setFirstValue(var_2_1 or "")

	if var_2_2 ~= "" then
		if arg_2_1.isShowAnima then
			self:_showValueAnimation(var_2_1, var_2_2)
		else
			self:_setSecondValue(var_2_2)

			if self.m_attrNumController then
				self.m_attrNumController:setSelectedIndex(1)
			end
		end
	else
		self:_setSecondValue(0)

		if self.m_attrNumController then
			self.m_attrNumController:setSelectedIndex(0)
		end
	end

	if self.m_grayController then
		if arg_2_1.isGray then
			self.m_grayController:setSelectedIndex(1)
		else
			self.m_grayController:setSelectedIndex(0)
		end
	end

	if arg_2_1.customBg then
		if self.m_attrNumController:getSelectedIndex() == 0 then
			if self.m_customBg then
				self.m_customBg:setURL(arg_2_1.customBg)
			end
		elseif self.m_customBg2 then
			self.m_customBg2:setURL(arg_2_1.customBg)
		end
	else
		if self.m_customBg then
			self.m_customBg:setURL("")
		end

		if self.m_customBg2 then
			self.m_customBg2:setURL("")
		end
	end
end

function BaseAttrValueComp:_setName(arg_3_1)
	if self.m_attName then
		self.m_attName:setText(arg_3_1)
	end
end

function BaseAttrValueComp:_setFirstValue(arg_4_1)
	if self.m_firstAttValue then
		self.m_firstAttValue:setText(arg_4_1)
	end
end

function BaseAttrValueComp:_setSecondValue(arg_5_1)
	if self.m_secondAttrValue then
		self.m_secondAttrValue:setText(arg_5_1)
	end
end

function BaseAttrValueComp:setAttrIconByType(arg_6_1, arg_6_2)
	if self.m_icon then
		self.m_icon:setVisible(true)

		if arg_6_2 and arg_6_2 ~= "" then
			self.m_icon:setURL(arg_6_2)
		elseif arg_6_1 then
			local var_6_0 = ""
			local var_6_1 = g.core.config.attribute_info.fetch(arg_6_1)

			if var_6_1 and var_6_1.icon and var_6_1.icon ~= "" then
				var_6_0 = g.core.common.Path:getAttrIconByName(var_6_1.icon .. (self._iconType == var_0_1.WHITE and "_2" or ""))
			else
				var_6_0 = g.core.common.Path:getAttrIcon(arg_6_1)

				if self._iconType and self._iconType == var_0_1.WHITE then
					var_6_0 = g.core.common.Path:getAttrIcon(arg_6_1, false)
				end
			end

			self.m_icon:setURL(var_6_0)
		else
			self.m_icon:setVisible(false)
		end
	end
end

function BaseAttrValueComp:playAnimAction(arg_7_1, arg_7_2)
	self._actionName = arg_7_1

	if arg_7_2 and arg_7_2 > 0 then
		self._schedulePlayAnimId = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onAnimScheduler), arg_7_2)
	else
		self:getTransition(arg_7_1):play()
	end
end

function BaseAttrValueComp:_onAnimScheduler()
	self:getTransition(self._actionName):play()

	self._schedulePlayAnimId = nil
end

function BaseAttrValueComp:onUnload()
	if self._schedulePlayAnimId then
		g.core.common.Scheduler:cancelSchedule(self._schedulePlayAnimId)

		self._schedulePlayAnimId = nil
	end
end

function BaseAttrValueComp:setIsShowBg(arg_10_1)
	if self.m_isShowBgController then
		self.m_isShowBgController:setSelectedIndex(arg_10_1 and 1 or 0)
	end
end

function BaseAttrValueComp:_showValueAnimation(arg_11_1, arg_11_2)
	self:_setFirstValue(arg_11_2 or "")
end

return BaseAttrValueComp
