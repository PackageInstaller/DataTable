local var_0_0 = g.core.config.tree_bonus_info
local var_0_1 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeAttrStageCell"))

function TreeTalentComp:updateStageCell(arg_1_1, arg_1_2, arg_1_3)
	self.m_isActiveController:setSelectedIndex(arg_1_2:getStage() >= arg_1_1.node_stage and 1 or 0)
	self.m_isConditionActiveController:setSelectedIndex(arg_1_2:isFinishCondition(arg_1_1) and 1 or 0)

	if arg_1_1.node_type == var_0_1.NODE_TYPE.BIG then
		self.m_stageName:setText(g.core.lang:get(426512, {
			stage = arg_1_3
		}))
		self.m_baseStr:setText(g.core.lang:get(426509, {
			desc = arg_1_2:getBigTalentAttrStr(arg_1_1, false)
		}))
		self.m_extraStr:setText(g.core.lang:get(426510, {
			desc = arg_1_2:getBigTalentAttrStr(arg_1_1, true)
		}))
	else
		self.m_stageName:setText(g.core.lang:get(426512, {
			stage = arg_1_3
		}))

		local var_1_0 = var_0_0.get(arg_1_1.cultivate_skill)

		self.m_baseStr:setText(g.core.lang:get(426509, {
			desc = var_1_0.basic_des
		}))
		self.m_extraStr:setText(g.core.lang:get(426510, {
			desc = var_1_0.extra_des
		}))
		self.m_conditionStr:setText(g.core.lang:get(426518, {
			desc = var_1_0.extra_condition_des
		}))
	end

	self.m_activeStr:setText(g.core.lang:get(426514, {
		quality = arg_1_1.node_quality,
		stage = arg_1_3
	}))
end

return TreeTalentComp
