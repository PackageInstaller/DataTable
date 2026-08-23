local var_0_0 = g.core.const.ConstMgr.ServerPassActivityConst
local ServerPassAwardGroupComp = class("ServerPassAwardGroupComp", require("app.fairyGUI.serverPassActivity.UI_ServerPassAwardGroupComp"))

function ServerPassAwardGroupComp:ctor()
	self._groupDataList = nil
	self._statue = nil

	self:addClickListener(handler(self, self._onClickSelf))
	self:_initList()
end

function ServerPassAwardGroupComp:_initList()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardItemList))
	self.m_awardList:doFairyBatching(false)
end

function ServerPassAwardGroupComp:setPayType(arg_3_1)
	self._payType = arg_3_1
end

function ServerPassAwardGroupComp:updateGroupComp(arg_4_1, arg_4_2)
	self._groupDataList = arg_4_1 or {}
	self._statue = arg_4_2

	self.m_awardList:setNumItems(#self._groupDataList)
end

function ServerPassAwardGroupComp:playUnlockAnim(arg_5_1)
	if self._statue ~= var_0_0.AWARD_STATUE.LOCK or arg_5_1 ~= var_0_0.AWARD_STATUE.CAN_GET then
		return
	end

	for iter_5_0, iter_5_1 in ipairs((self.m_awardList:getChildren())) do
		iter_5_1:playUnlockAnim(arg_5_1)
	end

	self._statue = arg_5_1
end

function ServerPassAwardGroupComp:_onRenderAwardItemList(arg_6_1, arg_6_2)
	arg_6_2:updateGroupIcon(self._groupDataList[arg_6_1 + 1], self._statue)
end

function ServerPassAwardGroupComp:_onClickSelf()
	if self._statue ~= var_0_0.AWARD_STATUE.CAN_GET then
		return
	end

	self:dispatchCompEvent("requestAward", {
		payType = self._payType
	})
end

return ServerPassAwardGroupComp
