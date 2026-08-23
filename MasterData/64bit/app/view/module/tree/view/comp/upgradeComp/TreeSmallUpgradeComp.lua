local TreeSmallUpgradeComp = class("TreeSmallUpgradeComp", require("app.fairyGUI.tree.UI_TreeSmallUpgradeComp"))

function TreeSmallUpgradeComp:ctor()
	self._nodeStruct = nil
	self._attrList = {}

	self:initView()
end

function TreeSmallUpgradeComp:initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function TreeSmallUpgradeComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._attrList[arg_3_1 + 1])
end

function TreeSmallUpgradeComp:update(arg_4_1)
	self._nodeStruct = arg_4_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	self.m_nodeCompBefore:updateAfterNodeByValue(self._nodeStruct:getBeforeStageInfo())
	self.m_nodeComp:updateNode(self._nodeStruct)

	self._attrList = {}

	local var_4_0 = self._nodeStruct:getBeforeStageInfo().level_max

	table.insert(self._attrList, {
		desc = g.core.lang:get(2084),
		beforeValue = g.core.lang:get(201607, {
			num = var_4_0,
			max = var_4_0
		}),
		afterValue = g.core.lang:get(201607, {
			num = self._nodeStruct:getLevel(),
			max = self._nodeStruct:getInfo().level_max
		})
	})

	local var_4_1, var_4_2 = g.core.lang:getAttr(self._nodeStruct:getInfo().cultivate_affect_type, self._nodeStruct:getInfo().cultivate_affect_initial_value, true)

	table.insert(self._attrList, {
		desc = g.core.lang:get(426504, {
			name = var_4_1
		}),
		beforeValue = self._nodeStruct:getBeforeStageInfo().cultivate_affect_initial_value + self._nodeStruct:getBeforeStageInfo().cultivate_affect_develop_value * var_4_0,
		afterValue = var_4_2
	})
	self.m_attrList:setNumItems(#self._attrList)
	self.m_enterTransition:play(handler(self, self._updateShowFinish))
end

function TreeSmallUpgradeComp:_updateShowFinish()
	self.m_showFinishController:setSelectedIndex(1)
	self:newScheduleOnce(handler(self, self._playTran2))
end

function TreeSmallUpgradeComp:_playTran2()
	self.m_enter2Transition:play()
end

return TreeSmallUpgradeComp
