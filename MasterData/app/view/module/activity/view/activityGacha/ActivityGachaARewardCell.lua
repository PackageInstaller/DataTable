local var_0_0 = g.core.model.User.activityMonthGachaData
local ActivityGachaARewardCell = class("ActivityGachaARewardCell", require("app.fairyGUI.activity.UI_ActivityGachaARewardCell"))

function ActivityGachaARewardCell:ctor()
	self:addClickListener(handler(self, self._onDetailClick))
	self.m_selectBtn:addClickListener(handler(self, self._onSelectClick))
	self.m_changeBtn:addClickListener(handler(self, self._onSelectClick))
end

function ActivityGachaARewardCell:_onSelectClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityGacha.ActivityGachaSelectPop").new({
		type = 1,
		dropId = self._item.dropId,
		id = self._item.cfgId
	})))
end

function ActivityGachaARewardCell:updateGachaARewardCell(arg_3_1)
	self._item = {
		dropId = arg_3_1.dropId,
		cfgId = arg_3_1.cfgId
	}

	local var_3_0 = var_0_0:getSelectRewardIndex(arg_3_1.cfgId)
	local var_3_1 = g.core.common.Drops:getGoodsArray(arg_3_1.dropId)

	self.m_fragImg:setVisible(false)
	self.m_eff:removeAllEffect()

	if var_3_0 and var_3_0 > 0 then
		if var_3_1[var_3_0] then
			local var_3_2 = g.core.common.Goods:convert(var_3_1[var_3_0])

			self.m_itemIcon:setURL(var_3_2.icon)
			self.m_itemIconMask:setURL(var_3_2.icon)
			self.m_nameTxt:setText(var_3_2.name)

			self._good = var_3_2

			self.m_fragImg:setVisible(var_3_2.is_frag)
			self.m_numTxt:setText("x" .. var_3_2.size)
		else
			self.m_nameTxt:setText(arg_3_1.dropName)
		end

		if arg_3_1.lastNum == 0 then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(1)
		end

		self.m_lastTxt:setText(g.core.lang:get(408111, {
			num = arg_3_1.lastNum,
			max = arg_3_1.allNum
		}))
	else
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_activityGacha_plusA",
			isLoop = true
		})
		self.m_nameTxt:setText(arg_3_1.dropName)
		self.m_stateController:setSelectedIndex(0)
	end
end

function ActivityGachaARewardCell:_onDetailClick()
	if not self._good then
		return
	end

	g.core.common.GlobalFunc.pushInfoPop(self._good)
end

return ActivityGachaARewardCell
