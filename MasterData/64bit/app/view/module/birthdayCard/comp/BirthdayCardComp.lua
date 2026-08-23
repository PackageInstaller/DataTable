local var_0_0 = g.core.model.User.userFestivalData
local BirthdayCardComp = class("BirthdayCardComp", require("app.fairyGUI.birthdayCard.UI_BirthdayCardComp"))

function BirthdayCardComp:ctor()
	self.m_receiveBtn:addClickListener(handler(self, self._onReceiveClick))

	self._hasReceived = false

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function BirthdayCardComp:updateComp()
	self._rewardsArr = var_0_0:getBirthdayRewardsArr()

	self:_updateView()
end

function BirthdayCardComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FESTIVAL_GET_BIRTHDAY_AWARD, handler(self, self._onReceiveReward), self)
end

function BirthdayCardComp:_updateView()
	self.m_congratulationComp:getChild("congratulationTxt"):setText(g.core.lang:get(201701))

	self._hasReceived = var_0_0:hasReceived()

	self.m_receiveBtn:setCtrlState("hasReceived", {
		index = self._hasReceived and 1 or 0
	})
	self.m_rewardList:setNumItems(#self._rewardsArr)
end

function BirthdayCardComp:_onRenderRewardList(arg_5_1, arg_5_2)
	local var_5_0 = g.core.common.Goods:convert(self._rewardsArr[arg_5_1 + 1])

	var_5_0.scaleIndex = 3

	arg_5_2:updateIcon(var_5_0, self._hasReceived)
end

function BirthdayCardComp:_onReceiveClick()
	if self._hasReceived then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Festival_Get_Birthday_Award({})
end

function BirthdayCardComp:_onReceiveReward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	self:_updateView()
end

return BirthdayCardComp
