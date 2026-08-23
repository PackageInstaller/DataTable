local var_0_0 = g.core.model.User.treeData
local var_0_1 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeInfoComp"))

function TreeTalentComp:ctor()
	self._nodeStruct = nil
	self._nodeType = 0
	self._conditionList = {}
	self._attrList = {}

	self:initView()
end

function TreeTalentComp:initView()
	self.m_upgradeBtn:addClickListener(handler(self, self._onClickUpgrade))
	self.m_conditionList:setVirtual()
	self.m_conditionList:setItemRenderer(handler(self, self._onRenderConditionList))
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self:addListen(self.m_conditionList)
	self.m_extraBtn:addClickListener(handler(self, self._onClickExtraBtn))
end

function TreeTalentComp:_onClickExtraBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tree.view.TreeNodeAttrPop").new({
		nodeStruct = self._nodeStruct
	}))
end

function TreeTalentComp:_onRenderConditionList(arg_4_1, arg_4_2)
	arg_4_2:updateData(self._conditionList[arg_4_1 + 1])
end

function TreeTalentComp:_onRenderAttrList(arg_5_1, arg_5_2)
	arg_5_2:updateData(self._attrList[arg_5_1 + 1])
end

function TreeTalentComp:_onClickUpgrade()
	if not self._nodeStruct then
		return
	end

	if not self._nodeStruct:isLight() then
		for iter_6_0, iter_6_1 in pairs((self._nodeStruct:getParentDict())) do
			if not iter_6_1:isLight() then
				g.core.module.ModuleManager:tip(g.core.lang:get(426505))

				return
			end
		end

		if self.m_resGroup:isVisible() and self.m_resComp:isLack() then
			self.m_resComp:popGotoSource()

			return
		end

		g.core.network.GameNetProxy:send_C2S_Tree_Node_UpStage({
			advance_id = self._nodeStruct:getAdvanceId()
		})

		return
	end

	if self._nodeType == var_0_1.NODE_TYPE.SMALL and not self._nodeStruct:isMaxLevel() then
		local var_6_0

		if self.m_resGroup:isVisible() and self.m_resComp:isLack() then
			self.m_resComp:popGotoSource()

			do return end

			var_6_0 = {
				advance_id = self._nodeStruct:getAdvanceId()
			}
		end

		var_6_0.target_level = self._nodeStruct:getLevel() + self.m_subAddComp:getCurNum()

		g.core.network.GameNetProxy:send_C2S_Tree_Node_LevelUp(var_6_0)
	else
		for iter_6_2, iter_6_3 in pairs((self._nodeStruct:getParentDict())) do
			if iter_6_3:getQuality() < self._nodeStruct:getNextStageInfo().node_quality then
				g.core.module.ModuleManager:tip(g.core.lang:get(426506))

				return
			end
		end

		if self.m_resGroup:isVisible() and self.m_resComp:isLack() then
			self.m_resComp:popGotoSource()

			return
		end

		g.core.network.GameNetProxy:send_C2S_Tree_Node_UpStage({
			advance_id = self._nodeStruct:getAdvanceId()
		})
	end
end

function TreeTalentComp:updateNode(arg_7_1)
	self._nodeStruct = arg_7_1 or self._nodeStruct

	local var_7_0 = self._nodeStruct:getNodeType()

	self._nodeType = var_7_0

	self.m_resGroup:setVisible(true)

	if var_7_0 == var_0_1.NODE_TYPE.SMALL then
		local var_7_1 = false

		if self._nodeStruct:isLight() then
			if self._nodeStruct:isMaxStage() then
				if self._nodeStruct:isMaxLevel() then
					self.m_stateController:setSelectedIndex(3)
				else
					var_7_1 = true

					self.m_stateController:setSelectedIndex(1)
					self.m_tips:setText("")
				end
			elseif self._nodeStruct:isMaxLevel() then
				self.m_stateController:setSelectedIndex(2)
				self:updateCondition()
				self.m_nodeCompAfter:updateAfterNodeByValue(self._nodeStruct:getNextStageInfo())
			else
				var_7_1 = true

				self.m_tips:setText(g.core.lang:get(426507, {
					maxLevel = self._nodeStruct:getMaxLevel(),
					curLevel = self._nodeStruct:getLevel(),
					nextQuality = var_0_1.QUALITY_NAME[self._nodeStruct:getNextStageInfo().node_quality]
				}))
				self.m_stateController:setSelectedIndex(1)
			end
		else
			self.m_stateController:setSelectedIndex(0)
			self:updateCondition()
		end

		if var_7_1 then
			self.m_resComp:updateByTVS(self._nodeStruct:getLevelUpMaterial())
			self.m_subAddComp:initMinMaxNum({
				cur = 1,
				min = 1,
				max = self._nodeStruct:getCurCanLevelUpMaxLevel(),
				callback = handler(self, self._setCount)
			})
		else
			self.m_resComp:updateByTVS(self._nodeStruct:getStageUpMaterial())
		end

		self:updateAttr()
	elseif var_7_0 == var_0_1.NODE_TYPE.BIG then
		if self._nodeStruct:isLight() then
			if self._nodeStruct:isMaxStage() then
				self.m_stateController:setSelectedIndex(7)
			elseif self._nodeStruct:getNextStageInfo().node_quality > self._nodeStruct:getQuality() then
				self.m_stateController:setSelectedIndex(6)
				self:updateCondition()
				self.m_nodeCompAfter:updateAfterNodeByValue(self._nodeStruct:getNextStageInfo())
			else
				self.m_stateController:setSelectedIndex(5)
				self.m_tips:setText(g.core.lang:get(426508, {
					maxStage = self._nodeStruct:getInfo().stage_max,
					curStage = self._nodeStruct:getStage(),
					nextQuality = var_0_1.QUALITY_NAME[self._nodeStruct:getNextStageInfo().node_quality]
				}))
			end
		else
			self.m_stateController:setSelectedIndex(4)
			self:updateCondition()
		end

		self:updateAttr()
		self.m_resComp:updateByTVS(self._nodeStruct:getStageUpMaterial())
	elseif var_7_0 == var_0_1.NODE_TYPE.CENTER then
		if self._nodeStruct:isLight() then
			if self._nodeStruct:isMaxStage() then
				self.m_stateController:setSelectedIndex(10)
			else
				self.m_stateController:setSelectedIndex(9)
				self:updateCondition()
				self.m_nodeCompAfter:updateAfterNodeByValue(self._nodeStruct:getNextStageInfo())
			end
		else
			self.m_stateController:setSelectedIndex(8)
			self:updateCondition()
		end

		self:updateAttr()

		local var_7_2 = self._nodeStruct:getStageUpMaterial()

		if var_7_2.type > 0 then
			self.m_resComp:updateByTVS(var_7_2)
		else
			self.m_resGroup:setVisible(false)
		end
	end

	self.m_nodeComp:updateNode(self._nodeStruct, var_7_0)
end

function TreeTalentComp:updateCondition()
	local var_8_0 = {}

	self.m_conditionGroup:setVisible(true)

	local var_8_1 = self._nodeStruct:getParentDict()

	if self._nodeType == var_0_1.NODE_TYPE.SMALL then
		if self._nodeStruct:isLight() then
			if not next(var_8_1) then
				self.m_conditionGroup:setVisible(false)
			else
				local var_8_2 = self._nodeStruct:getNextStageInfo().node_quality

				for iter_8_0, iter_8_1 in pairs(var_8_1) do
					table.insert(var_8_0, {
						parentStruct = iter_8_1,
						str = g.core.lang:get(426503, {
							name = iter_8_1:getInfo().node_name,
							qualityName = var_0_1.QUALITY_NAME[var_8_2]
						}),
						isCondition = var_8_2 <= iter_8_1:getQuality()
					})
				end
			end
		elseif not next(var_8_1) then
			self.m_conditionGroup:setVisible(false)
		else
			for iter_8_2, iter_8_3 in pairs(var_8_1) do
				table.insert(var_8_0, {
					parentStruct = iter_8_3,
					str = g.core.lang:get(426501, {
						name = iter_8_3:getInfo().node_name
					}),
					isCondition = iter_8_3:isLight()
				})
			end
		end
	elseif self._nodeType == var_0_1.NODE_TYPE.BIG then
		if self._nodeStruct:isLight() then
			local var_8_3 = self._nodeStruct:getNextStageInfo().node_quality

			for iter_8_4, iter_8_5 in pairs(var_8_1) do
				table.insert(var_8_0, {
					parentStruct = iter_8_5,
					str = g.core.lang:get(426503, {
						name = iter_8_5:getInfo().node_name,
						qualityName = var_0_1.QUALITY_NAME[var_8_3]
					}),
					isCondition = var_8_3 <= iter_8_5:getQuality()
				})
			end
		elseif not next(var_8_1) then
			self.m_conditionGroup:setVisible(false)
		else
			for iter_8_6, iter_8_7 in pairs(var_8_1) do
				table.insert(var_8_0, {
					parentStruct = iter_8_7,
					str = g.core.lang:get(426501, {
						name = iter_8_7:getInfo().node_name
					}),
					isCondition = iter_8_7:isLight()
				})
			end
		end
	elseif self._nodeType == var_0_1.NODE_TYPE.CENTER then
		local var_8_4 = var_0_1.CENTER_ID[self._nodeStruct:getAdvanceId()]

		if self._nodeStruct:isLight() then
			local var_8_5 = self._nodeStruct:getNextStageInfo().node_quality

			for iter_8_8 = 1, var_0_1.CENTER_LENGTH do
				local var_8_6 = var_0_0:getNodeByAdvanceId(var_8_4 + iter_8_8)

				if var_8_6 then
					table.insert(var_8_0, {
						parentStruct = var_8_6,
						str = g.core.lang:get(426503, {
							name = var_8_6:getInfo().node_name,
							qualityName = var_0_1.QUALITY_NAME[var_8_5]
						}),
						isCondition = var_8_5 <= var_8_6:getQuality()
					})
				end
			end
		else
			for iter_8_9 = 1, var_0_1.CENTER_LENGTH do
				local var_8_7 = var_0_0:getNodeByAdvanceId(var_8_4 + iter_8_9)

				if var_8_7 then
					table.insert(var_8_0, {
						parentStruct = var_8_7,
						str = g.core.lang:get(426501, {
							name = var_8_7:getInfo().node_name
						}),
						isCondition = var_8_7:isLight()
					})
				end
			end
		end
	end

	self._conditionList = var_8_0

	self.m_conditionList:setNumItems(#var_8_0)
	self.m_conditionList:resizeToFit(#var_8_0)
end

function TreeTalentComp:updateAttr()
	local var_9_9000

	if self._nodeType == var_0_1.NODE_TYPE.SMALL then
		self._attrList = {}

		if not self._nodeStruct:isLight() then
			local var_9_0 = {
				desc = g.core.lang:get(2084),
				curValue = g.core.lang:get(201607, {
					num = self._nodeStruct:getLevel(),
					max = self._nodeStruct:getNextStageInfo().level_max
				})
			}
			local var_9_1 = {}

			var_9_1.num = 1
			var_9_1.max = self._nodeStruct:getNextStageInfo().level_max
			var_9_0.afterValue = g.core.lang:get(201607, var_9_1)

			table.insert(self._attrList, var_9_0)

			local var_9_2, var_9_3 = g.core.lang:getAttr(self._nodeStruct:getNextStageInfo().cultivate_affect_type, 0, true)

			table.insert(self._attrList, {
				desc = g.core.lang:get(426504, {
					name = var_9_2
				}),
				curValue = var_9_3,
				afterValue = self._nodeStruct:getNextStageInfo().cultivate_affect_initial_value
			})
		elseif self._nodeStruct:isMaxLevel() then
			if self._nodeStruct:isMaxStage() then
				table.insert(self._attrList, {
					isMax = true,
					desc = g.core.lang:get(2084),
					curValue = g.core.lang:get(201607, {
						num = self._nodeStruct:getLevel(),
						max = self._nodeStruct:getMaxLevel()
					})
				})

				local var_9_4, var_9_5 = next((self._nodeStruct:getLevelAttrDict()))
				local var_9_6, var_9_7 = g.core.lang:getAttr(var_9_4, var_9_5, true)

				table.insert(self._attrList, {
					isMax = true,
					desc = g.core.lang:get(426504, {
						name = var_9_6
					}),
					curValue = var_9_7
				})
			else
				local var_9_8 = {
					desc = g.core.lang:get(2084),
					curValue = g.core.lang:get(201607, {
						num = self._nodeStruct:getLevel(),
						max = self._nodeStruct:getMaxLevel()
					})
				}
				local var_9_9 = {}

				var_9_9.num = 1
				var_9_9.max = self._nodeStruct:getNextStageInfo().level_max
				var_9_8.afterValue = g.core.lang:get(201607, var_9_9)

				table.insert(self._attrList, var_9_8)

				local var_9_10, var_9_11 = next((self._nodeStruct:getLevelAttrDict()))
				local var_9_12, var_9_13 = g.core.lang:getAttr(var_9_10, var_9_11, true)

				table.insert(self._attrList, {
					desc = g.core.lang:get(426504, {
						name = var_9_12
					}),
					curValue = var_9_13,
					afterValue = self._nodeStruct:getNextStageInfo().cultivate_affect_initial_value
				})
			end
		else
			local var_9_14 = {
				desc = g.core.lang:get(2084),
				curValue = g.core.lang:get(201607, {
					num = self._nodeStruct:getLevel(),
					max = self._nodeStruct:getMaxLevel()
				})
			}
			local var_9_15 = {}

			var_9_15.num = self._nodeStruct:getLevel()
			var_9_15.max = self._nodeStruct:getMaxLevel()
			var_9_14.afterValue = g.core.lang:get(201607, var_9_15)

			table.insert(self._attrList, var_9_14)

			local var_9_16, var_9_17 = next((self._nodeStruct:getLevelAttrDict()))
			local var_9_18, var_9_19 = g.core.lang:getAttr(var_9_16, var_9_17, true)
			local var_9_20, var_9_21 = next((self._nodeStruct:getLevelAttrDict(var_9_9000 + self.m_subAddComp:getCurNum())))
			local var_9_22, var_9_23 = g.core.lang:getAttr(var_9_20, var_9_21, true)

			table.insert(self._attrList, {
				desc = g.core.lang:get(426504, {
					name = var_9_18
				}),
				curValue = var_9_19,
				afterValue = var_9_23
			})
		end

		self.m_attrList:setNumItems(#self._attrList)
	elseif self._nodeType == var_0_1.NODE_TYPE.BIG then
		local var_9_24 = self._nodeStruct:getNextStageInfo() or self._nodeStruct:getInfo()

		self.m_extraName:setText(self._nodeStruct:getBigTalentAttrStr(var_9_24, false))
		self.m_attrDesc:setText(self._nodeStruct:getBigTalentAttrStr(var_9_24, true))
	elseif self._nodeType == var_0_1.NODE_TYPE.CENTER then
		local var_9_25 = self._nodeStruct:getNextStageInfo()
		local var_9_26 = not var_9_25 and self._nodeStruct:getBonusInfo() or self._nodeStruct:getBonusInfo(var_9_25.node_stage)

		self.m_extraName:setText(var_9_26.basic_des)
		self.m_attrDesc:setText(var_9_26.extra_des)
	end
end

function TreeTalentComp:_setCount(arg_10_1, arg_10_2)
	self.m_resComp:updateByTVS(self._nodeStruct:getLevelUpToMaterial(self._nodeStruct:getLevel() + arg_10_1 - 1))
	self:updateAttr()
end

return TreeTalentComp
