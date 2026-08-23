local var_0_0 = g.core.model.User.activityMonthGachaData
local ActivityGachaSRewardComp = class("ActivityGachaSRewardComp", require("app.fairyGUI.activity.UI_ActivityGachaSRewardComp"))

function ActivityGachaSRewardComp:ctor()
	self.m_selectBtn:addClickListener(handler(self, self._onSelectClick))
	self.m_changeBtn:addClickListener(handler(self, self._onSelectClick))
	self.m_detailBtn:addClickListener(handler(self, self._onDetailClick))
	self.m_luckyBg:addClickListener(handler(self, self._onLuckBgClick))
end

function ActivityGachaSRewardComp:_onSelectClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityGacha.ActivityGachaSelectPop").new({
		type = 0,
		dropId = self._item.dropId,
		id = self._item.cfgId
	})))
end

function ActivityGachaSRewardComp:updateGachaSRewardComp(arg_3_1)
	self._item = arg_3_1[1]

	local var_3_0 = var_0_0:getSelectRewardIndex(arg_3_1[1].cfgId)

	self.m_luckyValueTxt:setText(var_0_0:getLuckyValue())

	local var_3_1 = g.core.common.Drops:getGoodsArray(arg_3_1[1].dropId)

	self.m_eff:removeAllEffect()

	if var_3_0 and var_3_0 > 0 then
		if var_3_1[var_3_0] then
			local var_3_2 = g.core.common.Goods:convert(var_3_1[var_3_0])

			self._good = var_3_2

			self.m_itemLoader:setURL(var_3_2.pic)
			self.m_itemLoaderMask:setURL(var_3_2.pic)
			self.m_sTitleTxt:setText(var_3_2.name)
		else
			self.m_sTitleTxt:setText(arg_3_1[1].dropName)
		end

		self.m_stateController:setSelectedIndex(1)
	else
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_activityGacha_plusS",
			isLoop = true
		})
		self.m_sTitleTxt:setText(arg_3_1[1].dropName)
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_lastTxt:setText(g.core.lang:get(408111, {
		num = arg_3_1[1].lastNum,
		max = arg_3_1[1].allNum
	}))

	if arg_3_1[1].lastNum == 0 then
		self.m_isGetController:setSelectedIndex(1)
	else
		self.m_isGetController:setSelectedIndex(0)
	end
end

function ActivityGachaSRewardComp:_onDetailClick()
	if self._good then
		g.core.common.GlobalFunc.pushInfoPop(self._good)
	end
end

function ActivityGachaSRewardComp:_onLuckBgClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 415
	}), {
		touchDisappear = true
	})
end

return ActivityGachaSRewardComp
