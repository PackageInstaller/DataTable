local TreeBigStageUpComp = class("TreeBigStageUpComp", require("app.fairyGUI.tree.UI_TreeBigStageUpComp"))

function TreeBigStageUpComp:ctor()
	self._nodeStruct = nil
	self._attrList = {}

	self:initView()
end

function TreeBigStageUpComp:initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function TreeBigStageUpComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._attrList[arg_3_1 + 1])
end

function TreeBigStageUpComp:update(arg_4_1)
	self._nodeStruct = arg_4_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	self.m_nodeCompBefore:updateAfterNodeByValue(self._nodeStruct:getBeforeStageInfo())
	self.m_nodeComp:updateNode(self._nodeStruct)
	self.m_extraName:setText(self._nodeStruct:getInfo().talent_name)

	self._attrList = {}

	local var_4_0 = self._nodeStruct:getStageBaseAttrDict(self._nodeStruct:getStage() - 1)

	for iter_4_0, iter_4_1 in pairs((self._nodeStruct:getStageBaseAttrDict())) do
		local var_4_1, var_4_2 = g.core.lang:getAttr(iter_4_0, iter_4_1, true)
		local var_4_4, var_4_5 = g.core.lang:getAttr(iter_4_0, var_4_0[iter_4_0] or 0, true)

		table.insert(self._attrList, {
			desc = var_4_1,
			beforeValue = var_4_5,
			afterValue = var_4_2
		})
	end

	self.m_attrList:setNumItems(#self._attrList)
	self.m_attrList:resizeToFit(#self._attrList)
	self.m_extraTip:setText(g.core.lang:get(426519, {
		desc = self._nodeStruct:getInfo().condition_des
	}))
	self.m_enterTransition:play(handler(self, self._updateShowFinish))
end

function TreeBigStageUpComp:_updateShowFinish()
	self.m_showFinishController:setSelectedIndex(1)
	self:newScheduleOnce(handler(self, self._playTran2))
end

function TreeBigStageUpComp:_playTran2()
	self.m_enter2Transition:play()
end

return TreeBigStageUpComp
