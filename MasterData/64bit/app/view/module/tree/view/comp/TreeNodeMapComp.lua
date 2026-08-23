local var_0_0 = g.core.model.User.treeData
local TreeNodeMapComp = class("TreeNodeMapComp", require("app.fairyGUI.tree.UI_TreeNodeMapComp"))

function TreeNodeMapComp:ctor()
	self._lineDataDict = {}
	self._allLineDict = {}

	self:initView()
end

function TreeNodeMapComp:initView()
	for iter_2_0, iter_2_1 in ipairs((self:getChildren())) do
		local var_2_0 = iter_2_1:getName()

		if string.find(var_2_0, "line") then
			local var_2_1 = string.split(string.sub(var_2_0, 5), "_")
			local var_2_2 = tonumber(var_2_1[1])
			local var_2_3 = tonumber(var_2_1[2])

			self._lineDataDict[var_2_2] = self._lineDataDict[var_2_2] or {}
			self._lineDataDict[var_2_2][var_2_3] = iter_2_1
			self._lineDataDict[var_2_3] = self._lineDataDict[var_2_3] or {}
			self._lineDataDict[var_2_3][var_2_2] = iter_2_1

			table.insert(self._allLineDict, {
				id1 = var_2_2,
				id2 = var_2_3,
				line = iter_2_1
			})
		end
	end
end

function TreeNodeMapComp:onLoad()
	self.m_effMap:addEffectSpine({
		anim = "play",
		name = "eff_ui_tree_center",
		remove = true,
		isLoop = false
	})
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_CenterClick)
end

function TreeNodeMapComp:updateAllNode()
	local var_4_0 = var_0_0:getAllNode()

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		self["m_talent" .. iter_4_1:getAdvanceId()]:updateNode(iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(self._allLineDict) do
		local var_4_1 = iter_4_3.line
		local var_4_2 = var_4_0[iter_4_3.id2]

		if (not var_4_0[iter_4_3.id1] or var_4_0[iter_4_3.id1]:isLight()) and (not var_4_2 or var_4_2:isLight()) then
			var_4_1:setOpacity(255)
		else
			var_4_1:setOpacity(125)
		end
	end
end

function TreeNodeMapComp:updateLevelUpNode(arg_5_1)
	local var_5_0 = arg_5_1:getAdvanceId()

	if arg_5_1 then
		self["m_talent" .. var_5_0]:updateNode(arg_5_1)

		for iter_5_0, iter_5_1 in pairs(self._lineDataDict[var_5_0] or {}) do
			local var_5_1 = var_0_0:getNodeByAdvanceId(iter_5_0)
			local var_5_2 = iter_5_1

			if (not var_5_1 or var_5_1:isLight()) and arg_5_1:isLight() then
				var_5_2:setOpacity(255)
			else
				var_5_2:setOpacity(125)
			end
		end

		for iter_5_2, iter_5_3 in pairs(arg_5_1:getChildDict()) do
			self["m_talent" .. iter_5_3:getAdvanceId()]:updateNode(iter_5_3)
		end
	end
end

function TreeNodeMapComp:updateStageUpNode(arg_6_1)
	local var_6_0 = arg_6_1:getAdvanceId()

	if arg_6_1 then
		self["m_talent" .. var_6_0]:updateStageUpNode(arg_6_1)

		for iter_6_0, iter_6_1 in pairs(self._lineDataDict[var_6_0] or {}) do
			local var_6_1 = var_0_0:getNodeByAdvanceId(iter_6_0)
			local var_6_2 = iter_6_1

			if (not var_6_1 or var_6_1:isLight()) and arg_6_1:isLight() then
				var_6_2:setOpacity(255)
			else
				var_6_2:setOpacity(125)
			end
		end

		for iter_6_2, iter_6_3 in pairs(arg_6_1:getChildDict()) do
			self["m_talent" .. iter_6_3:getAdvanceId()]:updateNode(iter_6_3)
		end
	end
end

function TreeNodeMapComp:updateBigNodeUpCenterNode(arg_7_1, arg_7_2)
	self["m_talent" .. arg_7_1]:setBigNodeQualityUp(arg_7_2)
end

function TreeNodeMapComp:setSelectNode(arg_8_1, arg_8_2)
	local var_8_0 = self["m_talent" .. arg_8_1:getAdvanceId()]

	if var_8_0 then
		var_8_0:setSelected(arg_8_2)
	end
end

function TreeNodeMapComp:getNodePos(arg_9_1)
	return self["m_talent" .. arg_9_1]:getPosition()
end

function TreeNodeMapComp:onRemoved()
	self._lineDataDict = {}
	self._allLineDict = {}
end

return TreeNodeMapComp
