local var_0_0 = g.core.config.tree_bonus_info
local var_0_1 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeAttrQualityCell"))

function TreeTalentComp:ctor()
	self._nodeStruct = nil
	self._stageList = {}

	self:initView()
end

function TreeTalentComp:initView()
	self.m_stageList:setIniter()
	self.m_stageList:setItemRenderer(handler(self, self._onRenderStageList))
end

function TreeTalentComp:_onRenderStageList(arg_3_1, arg_3_2)
	arg_3_2:updateStageCell(self._stageList[arg_3_1 + 2], self._nodeStruct, arg_3_1 + 1)
end

function TreeTalentComp:updateQualityCell(arg_4_1, arg_4_2)
	self._nodeStruct = arg_4_2

	self.m_isActiveController:setSelectedIndex(arg_4_1.isActive and 1 or 0)

	self._stageList = arg_4_1.stageList or {}

	table.sort(self._stageList, function(arg_5_0, arg_5_1)
		return arg_5_0.node_stage < arg_5_1.node_stage
	end)

	local var_4_1 = self._stageList[1]

	self.m_stageList:setNumItems(#self._stageList - 1)
	self.m_stageList:resizeToFit(#self._stageList - 1)

	if not var_4_1 then
		return
	end

	if arg_4_2:getNodeType() == var_0_1.NODE_TYPE.BIG then
		self.m_isConditionActiveController:setSelectedIndex(arg_4_2:isFinishCondition(var_4_1) and 1 or 0)
		self.m_baseStr:setText(g.core.lang:get(426509, {
			desc = arg_4_2:getBigTalentAttrStr(var_4_1, false)
		}))
		self.m_extraStr:setText(g.core.lang:get(426510, {
			desc = arg_4_2:getBigTalentAttrStr(var_4_1, true)
		}))
		self.m_conditionStr:setText(g.core.lang:get(426518, {
			desc = var_4_1.condition_des
		}))
		self.m_qualityName:setText(g.core.lang:get(426511, {
			quality = var_0_1.QUALITY_NAME[var_4_1.node_quality]
		}))
	else
		self.m_isConditionActiveController:setSelectedIndex(arg_4_2:isFinishCondition(var_4_1) and 1 or 0)

		local var_4_2 = var_0_0.get(var_4_1.cultivate_skill)

		self.m_baseStr:setText(g.core.lang:get(426509, {
			desc = var_4_2.basic_des
		}))
		self.m_extraStr:setText(g.core.lang:get(426510, {
			desc = var_4_2.extra_des
		}))
		self.m_conditionStr:setText(g.core.lang:get(426518, {
			desc = var_4_2.extra_condition_des
		}))
		self.m_qualityName:setText(g.core.lang:get(426511, {
			quality = var_0_1.QUALITY_NAME[var_4_1.node_quality]
		}))
	end

	self.m_activeStr:setText(g.core.lang:get(426513, {
		quality = var_0_1.QUALITY_NAME[var_4_1.node_quality]
	}))
end

return TreeTalentComp
