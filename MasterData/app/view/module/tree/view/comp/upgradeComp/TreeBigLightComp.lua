local TreeBigLightComp = class("TreeBigLightComp", require("app.fairyGUI.tree.UI_TreeBigLightComp"))

function TreeBigLightComp:ctor()
	self._nodeStruct = nil
	self._attrList = {}

	self:initView()
end

function TreeBigLightComp:initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function TreeBigLightComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._attrList[arg_3_1 + 1])
end

function TreeBigLightComp:update(arg_4_1)
	self._nodeStruct = arg_4_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	self.m_nodeComp:updateNode(self._nodeStruct)
	self.m_extraName:setText(self._nodeStruct:getInfo().talent_name)

	self._attrList = {}

	for iter_4_0, iter_4_1 in pairs((self._nodeStruct:getStageBaseAttrDict())) do
		local var_4_0, var_4_1 = g.core.lang:getAttr(iter_4_0, iter_4_1, true)

		table.insert(self._attrList, {
			beforeValue = 0,
			desc = var_4_0,
			afterValue = var_4_1
		})
	end

	self.m_attrList:setNumItems(#self._attrList)
	self.m_attrList:resizeToFit(#self._attrList)
	self.m_enterTransition:play(handler(self, self._updateShowFinish))
end

function TreeBigLightComp:_updateShowFinish()
	self.m_showFinishController:setSelectedIndex(1)
	self:newScheduleOnce(handler(self, self._playTran2))
end

function TreeBigLightComp:_playTran2()
	self.m_enter2Transition:play()
end

return TreeBigLightComp
