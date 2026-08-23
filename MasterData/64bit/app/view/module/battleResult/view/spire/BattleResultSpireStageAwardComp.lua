local BattleResultSpireStageAwardComp = class("BattleResultSpireStageAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultSpireStageAwardComp"))

function BattleResultSpireStageAwardComp:ctor()
	self._awardItems = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_idleList:setVirtual()
	self.m_idleList:setItemRenderer(handler(self, self._onIdleListRenderer))
end

function BattleResultSpireStageAwardComp:update(arg_2_1)
	self._awardItems = arg_2_1.awardList or {}

	self.m_awardList:setNumItems(#self._awardItems)
	self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)

	self._idleList = arg_2_1.idleAwards

	self.m_idleList:setNumItems(#self._idleList)

	local var_2_0 = self.m_idleList:getSize()

	var_2_0.width = 30

	for iter_2_0, iter_2_1 in ipairs((self.m_idleList:getChildren())) do
		var_2_0.width = var_2_0.width + iter_2_1:getSize().width
	end

	self.m_idleList:setSize(var_2_0)
end

function BattleResultSpireStageAwardComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._awardItems[arg_3_1 + 1])
end

function BattleResultSpireStageAwardComp:_onIdleListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIdleItem(self._idleList[arg_4_1 + 1])
end

return BattleResultSpireStageAwardComp
