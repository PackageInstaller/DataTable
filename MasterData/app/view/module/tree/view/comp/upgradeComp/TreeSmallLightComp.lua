local TreeSmallLightComp = class("TreeSmallLightComp", require("app.fairyGUI.tree.UI_TreeSmallLightComp"))

function TreeSmallLightComp:ctor()
	self._nodeStruct = nil
	self._attrList = {}

	self:initView()
end

function TreeSmallLightComp:initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function TreeSmallLightComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._attrList[arg_3_1 + 1])
end

function TreeSmallLightComp:update(arg_4_1)
	self._nodeStruct = arg_4_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	self.m_nodeComp:updateNode(self._nodeStruct)

	self._attrList = {}

	table.insert(self._attrList, {
		desc = g.core.lang:get(2084),
		beforeValue = g.core.lang:get(201607, {
			num = 0,
			max = self._nodeStruct:getInfo().level_max
		}),
		afterValue = g.core.lang:get(201607, {
			num = self._nodeStruct:getLevel(),
			max = self._nodeStruct:getInfo().level_max
		})
	})

	local var_4_0, var_4_1 = g.core.lang:getAttr(self._nodeStruct:getInfo().cultivate_affect_type, self._nodeStruct:getInfo().cultivate_affect_initial_value, true)

	table.insert(self._attrList, {
		beforeValue = 0,
		desc = g.core.lang:get(426504, {
			name = var_4_0
		}),
		afterValue = var_4_1
	})
	self.m_attrList:setNumItems(#self._attrList)
	self.m_enterTransition:play(handler(self, self._updateShowFinish))
end

function TreeSmallLightComp:_updateShowFinish()
	self.m_showFinishController:setSelectedIndex(1)
	self:newScheduleOnce(handler(self, self._playTran2))
end

function TreeSmallLightComp:_playTran2()
	self.m_enter2Transition:play()
end

return TreeSmallLightComp
