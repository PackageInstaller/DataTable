local ValentinesDayVoteTaskCell = class("ValentinesDayVoteTaskCell", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteTaskCell"))
local var_0_1 = g.core.const.ConstMgr.ValentinesDayVoteConst.ACTIVITY_STAGE
local var_0_2 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteTaskCell:ctor()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListItemRender))
	self.m_taskBtn:addClickListener(handler(self, self._onRewardClick))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function ValentinesDayVoteTaskCell:updateView(arg_2_1)
	self._struct = arg_2_1

	self.m_name:setText(self._struct:getCfg().title)
	self.m_descText:setText(g.core.lang:getByString(self._struct:getCfg().text, {
		num = self._struct:getCfg().task_value
	}))

	self._rewardList = self._struct:getRewardList()

	self.m_awardList:setNumItems(#self._rewardList)
	self.m_curProgressText:setText(self._struct:getCurProgress())
	self.m_destinNumText:setText("/" .. self._struct:getCfg().task_value)

	self._statue = 0

	if self._struct:isGetReward() then
		self._statue = 2
	elseif self._struct:getCurProgress() < self._struct:getCfg().task_value then
		self._statue = 0
	elseif self._struct:getCurProgress() >= self._struct:getCfg().task_value then
		self._statue = 1
	end

	if var_0_2:getActivityStage() == var_0_1.SHOW and self._statue ~= 1 then
		self._statue = 3
	end

	self.m_stateController:setSelectedIndex(self._statue)
end

function ValentinesDayVoteTaskCell:_onAwardListItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardList[arg_3_1 + 1])
end

function ValentinesDayVoteTaskCell:_onRewardClick()
	if self._statue == 0 then
		if self._struct:getCfg().route_id > 0 then
			if self._struct:getCfg().task_type == 1389 then
				g.core.module.ModuleManager:popModule()
			else
				g.view.entrance.ModuleGotoProxy:gotoModule(self._struct:getCfg().route_id)
			end
		end
	elseif self._statue == 1 then
		g.core.network.GameNetProxy:send_C2S_Support_TaskAward({
			id = self._struct:getCfg().id
		})
	elseif self._statue == 3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))
	end
end

return ValentinesDayVoteTaskCell
