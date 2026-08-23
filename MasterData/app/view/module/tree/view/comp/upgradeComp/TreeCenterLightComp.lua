local TreeCenterLightComp = class("TreeCenterLightComp", require("app.fairyGUI.tree.UI_TreeCenterLightComp"))

function TreeCenterLightComp:ctor()
	self._nodeStruct = nil
	self._attrList = {}
	self._extraAttrList = {}

	self:initView()
end

function TreeCenterLightComp:initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_extraAttrList:setVirtual()
	self.m_extraAttrList:setItemRenderer(handler(self, self._onRenderExtraAttrList))
end

function TreeCenterLightComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._attrList[arg_3_1 + 1])
end

function TreeCenterLightComp:_onRenderExtraAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._extraAttrList[arg_4_1 + 1])
end

function TreeCenterLightComp:update(arg_5_1)
	self._nodeStruct = arg_5_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	self.m_nodeComp:updateNode(self._nodeStruct)
	self.m_extraName:setText(self._nodeStruct:getBonusInfo().name)

	self._attrList = {}

	for iter_5_0, iter_5_1 in pairs((self._nodeStruct:getStageBaseAttrDict())) do
		local var_5_0, var_5_1 = g.core.lang:getAttr(iter_5_0, iter_5_1, true)

		table.insert(self._attrList, {
			beforeValue = 0,
			desc = var_5_0,
			afterValue = var_5_1
		})
	end

	self.m_attrList:setNumItems(#self._attrList)
	self.m_attrList:resizeToFit(#self._attrList)

	self._extraAttrList = {}

	local var_5_2 = {}

	self._nodeStruct:getExtraAttrDictByInfo(self._nodeStruct:getBonusInfo(), var_5_2, 1)

	for iter_5_2, iter_5_3 in pairs(var_5_2) do
		local var_5_3, var_5_4 = g.core.lang:getAttr(iter_5_2, iter_5_3, true)

		table.insert(self._extraAttrList, {
			beforeValue = 0,
			desc = var_5_3,
			afterValue = var_5_4
		})
	end

	self.m_extraAttrList:setNumItems(#self._extraAttrList)
	self.m_extraAttrList:resizeToFit(#self._extraAttrList)
	self.m_extraTip:setText(g.core.lang:get(426519, {
		desc = self._nodeStruct:getBonusInfo().extra_condition_des
	}))
	self.m_enterTransition:play(handler(self, self._updateShowFinish))
end

function TreeCenterLightComp:_updateShowFinish()
	self.m_showFinishController:setSelectedIndex(1)
	self:newScheduleOnce(handler(self, self._playTran2))
end

function TreeCenterLightComp:_playTran2()
	self.m_enter2Transition:play()
end

return TreeCenterLightComp
