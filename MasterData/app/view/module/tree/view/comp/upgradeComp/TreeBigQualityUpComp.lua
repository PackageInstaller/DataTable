local TreeBigQualityUpComp = class("TreeBigQualityUpComp", require("app.fairyGUI.tree.UI_TreeBigQualityUpComp"))

function TreeBigQualityUpComp:ctor()
	self._nodeStruct = nil
	self._attrList = {}
	self._extraAttrList = {}

	self:initView()
end

function TreeBigQualityUpComp:initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_extraAttrList:setVirtual()
	self.m_extraAttrList:setItemRenderer(handler(self, self._onRenderExtraAttrList))
end

function TreeBigQualityUpComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._attrList[arg_3_1 + 1])
end

function TreeBigQualityUpComp:_onRenderExtraAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._extraAttrList[arg_4_1 + 1])
end

function TreeBigQualityUpComp:update(arg_5_1)
	self._nodeStruct = arg_5_1.nodeStruct

	if not self._nodeStruct then
		return
	end

	local var_5_0 = self._nodeStruct:getBeforeStageInfo()

	self.m_nodeCompBefore:updateAfterNodeByValue(var_5_0)
	self.m_beforeDesc:setText(var_5_0.talent_name)
	self.m_nodeComp:updateNode(self._nodeStruct)
	self.m_extraName:setText(self._nodeStruct:getInfo().talent_name)
	self.m_afterDesc:setText(self._nodeStruct:getInfo().talent_name)

	self._attrList = {}

	local var_5_1 = self._nodeStruct:getStageBaseAttrDict(self._nodeStruct:getStage() - 1)

	for iter_5_0, iter_5_1 in pairs((self._nodeStruct:getStageBaseAttrDict())) do
		local var_5_2, var_5_3 = g.core.lang:getAttr(iter_5_0, iter_5_1, true)
		local var_5_5, var_5_6 = g.core.lang:getAttr(iter_5_0, var_5_1[iter_5_0] or 0, true)

		table.insert(self._attrList, {
			desc = var_5_2,
			beforeValue = var_5_6,
			afterValue = var_5_3,
			hasNew = var_5_1[iter_5_0] == nil
		})
	end

	self.m_attrList:setNumItems(#self._attrList)
	self.m_attrList:resizeToFit(#self._attrList)

	self._extraAttrList = {}

	local var_5_7 = {}

	self._nodeStruct:getExtraAttrDictByInfo(self._nodeStruct:getInfo(self._nodeStruct:getStage() - 1), var_5_7)

	local var_5_8 = {}

	self._nodeStruct:getExtraAttrDictByInfo(self._nodeStruct:getInfo(), var_5_8)

	for iter_5_2, iter_5_3 in pairs(var_5_8) do
		local var_5_9, var_5_10 = g.core.lang:getAttr(iter_5_2, iter_5_3, true)
		local var_5_12, var_5_13 = g.core.lang:getAttr(iter_5_2, var_5_7[iter_5_2] or 0, true)

		table.insert(self._extraAttrList, {
			desc = var_5_9,
			beforeValue = var_5_13,
			afterValue = var_5_10,
			hasNew = var_5_7[iter_5_2] == nil
		})
	end

	self.m_extraAttrList:setNumItems(#self._extraAttrList)
	self.m_extraAttrList:resizeToFit(#self._extraAttrList)
	self.m_extraTip:setText(g.core.lang:get(426519, {
		desc = self._nodeStruct:getInfo().condition_des
	}))
	self.m_enterTransition:play(handler(self, self._updateShowFinish))
end

function TreeBigQualityUpComp:_updateShowFinish()
	self.m_showFinishController:setSelectedIndex(1)
	self:newScheduleOnce(handler(self, self._playTran2))
end

function TreeBigQualityUpComp:_playTran2()
	self.m_enter2Transition:play()
end

return TreeBigQualityUpComp
