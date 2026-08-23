local var_0_0 = g.core.config.talent_skill_info
local var_0_1 = g.core.config.succuba_advance_info
local var_0_2 = g.core.model.User.succubaData
local SuccubaAdvUpComp = class("SuccubaAdvUpComp", require("app.fairyGUI.succuba.UI_SuccubaAdvUpComp"))

function SuccubaAdvUpComp:ctor()
	self._succubaStruct = nil
	self._costList = {}
	self._barNodeControl = self.m_advProgressBar:getController("nodeNum")
	self._advInfoList = {}

	self:_initBtn()
	self:_initListView()

	self._showCharmData = nil
	self._lastShowCharmData = nil
end

function SuccubaAdvUpComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_STAGEUP, handler(self, self._onRecvAdvlUp), self)
end

function SuccubaAdvUpComp:_initBtn()
	self.m_advanceTransition:setHook("cut", handler(self, self.updateStageText))
	self.m_baseAttrComp:addClickListener(handler(self, self._onBaseAttrClick))
	self.m_advUpBtn:addClickListener(handler(self, self._onAdvUpBtnClick))
end

function SuccubaAdvUpComp:updateStageText()
	if self._succubaStruct then
		self.m_advLvText:setText(self._succubaStruct:getStage())
	end
end

function SuccubaAdvUpComp:_initListView()
	self.m_costList:setVirtual()
	self.m_costList:setItemRenderer(handler(self, self._onRenderCostList))
end

function SuccubaAdvUpComp:_onRenderCostList(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._costList[arg_6_1 + 1])
end

function SuccubaAdvUpComp:updateView(arg_7_1)
	self.m_enterTransition:play()

	if not arg_7_1 or not arg_7_1.data or not arg_7_1.data.advId then
		return
	end

	local var_7_0 = arg_7_1.data.advId

	self._succubaStruct = var_0_2:getSuccubaByAdvanceId(arg_7_1.data.advId)

	if self._succubaStruct then
		self._advInfoList = {}

		for iter_7_0, iter_7_1 in var_0_1.ipairs() do
			if iter_7_1.advance_id == var_7_0 then
				table.insert(self._advInfoList, iter_7_1)
			end
		end
	end

	self:updateCompView(false)
end

function SuccubaAdvUpComp:updateCompView(arg_8_1, arg_8_2)
	if not self._succubaStruct then
		return
	end

	local var_8_0 = self._succubaStruct:getStage()
	local var_8_1 = self._succubaStruct:getNode()

	if not arg_8_2 then
		self.m_advLvText:setText(var_8_0)
	end

	local var_8_2 = self._succubaStruct:getAdvanceStageInfo()
	local var_8_3 = 0
	local var_8_4 = {}
	local var_8_5 = {}

	for iter_8_0, iter_8_1 in ipairs(self._advInfoList) do
		if iter_8_1.stage == var_8_0 then
			var_8_3 = var_8_3 + 1
		end

		local var_8_6 = iter_8_1.skill_id

		if iter_8_1.skill_id > 0 and not var_8_5[var_8_6] then
			var_8_5[var_8_6] = true

			local var_8_7 = g.core.config.passive_skill_info.get(var_8_6)
			local var_8_8 = var_8_0 >= iter_8_1.stage and 0 or 1
			local var_8_9 = g.core.lang:get(431024, {
				name = var_8_7.name,
				lv = var_8_7.level
			})
			local var_8_10 = g.core.utils.String.formatPassiveSkillDesc(var_8_6)

			if (var_8_0 >= iter_8_1.stage and 0 or 1) == 1 then
				var_8_10 = var_8_10 .. g.core.lang:get(431048, {
					stage = iter_8_1.stage
				})
			end

			table.insert(var_8_4, {
				state = var_8_8,
				level = var_8_9,
				text = var_8_10
			})
		end
	end

	local var_8_11 = var_8_3 - 1

	if var_8_3 - 1 <= 0 then
		var_8_11 = 1
		var_8_1 = 1
	end

	self._barNodeControl:setSelectedIndex(math.clamp(var_8_11 - 1, 0, 5))
	self.m_advProgressBar:setPercent({
		cur = var_8_1,
		max = var_8_11,
		tween = arg_8_1
	})
	self.m_skillIcon1:setVisible(true)

	local var_8_12

	if var_8_2.id_num > 0 then
		self.m_isStarMaxController:setSelectedIndex(0)

		local var_8_13 = var_0_1.get(var_8_2.id_num)

		if var_8_13.skill_id == var_8_2.skill_id then
			self.m_isSkillChangeController:setSelectedIndex(0)
		else
			self.m_isSkillChangeController:setSelectedIndex(1)
			self.m_skillIcon2:openClick()
			self.m_skillIcon2:updateIcon({
				isPassive = true,
				skillId = var_8_13.skill_id,
				skillDescList = var_8_4
			})
		end

		var_8_12 = var_8_13.charm

		if var_8_2.skill_id == 0 then
			self.m_isSkillChangeController:setSelectedIndex(0)

			if var_8_13.skill_id > 0 then
				self.m_skillIcon1:openClick()
				self.m_skillIcon1:updateIcon({
					isPassive = true,
					skillId = var_8_13.skill_id,
					skillDescList = var_8_4
				})
			else
				self.m_skillIcon1:setVisible(false)
			end
		else
			self.m_skillIcon1:openClick()
			self.m_skillIcon1:updateIcon({
				isPassive = true,
				skillId = var_8_2.skill_id,
				skillDescList = var_8_4
			})
		end
	else
		self.m_skillIcon1:openClick()
		self.m_skillIcon1:updateIcon({
			isPassive = true,
			skillId = var_8_2.skill_id,
			skillDescList = var_8_4
		})
		self.m_isStarMaxController:setSelectedIndex(1)
		self.m_isSkillChangeController:setSelectedIndex(0)
	end

	if var_8_12 == var_8_2.charm then
		var_8_12 = nil
	end

	local var_8_14 = {
		iconRes = "icon/attrIcon/icon_meilizhi.png",
		name = g.core.lang:get(431008),
		value = var_8_2.charm,
		value2 = var_8_12
	}

	self.m_charmComp:setWidth(var_8_12 and 192 or 350)
	self.m_charmComp:updateAttr(var_8_14)

	self._showCharmData = var_8_14
	self._costList = {}

	while var_0_1.hasKey("cost_type_" .. 1) do
		if var_8_2["cost_num_" .. 1] > 0 then
			table.insert(self._costList, {
				type = var_8_2["cost_type_" .. 1],
				value = var_8_2["cost_value_" .. 1],
				size = g.core.model.User.bagData:getCountById(var_8_2["cost_type_" .. 1], var_8_2["cost_value_" .. 1]),
				numCost = var_8_2["cost_num_" .. 1]
			})
		end
	end

	self.m_costList:setNumItems(#self._costList)
end

function SuccubaAdvUpComp:_onRecvAdvlUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.m_advUpBtn:setTouchable(true)

	self._lastShowCharmData = self._showCharmData

	self:updateCompView(true, true)

	if self._succubaStruct:getNode() ~= 0 then
		self.m_effDadComp:addEffectSpine({
			remove = true,
			name = "eff_ui_succuba_add",
			scale = 1,
			isLoop = false
		})
	else
		self.m_advanceTransition:play(handler(self, self.showStageUpPop))
		self.m_effDadComp:addEffectSpine({
			remove = true,
			name = "eff_ui_succuba_advance",
			scale = 1,
			isLoop = false
		})
	end
end

function SuccubaAdvUpComp:showStageUpPop()
	local var_10_0 = self._succubaStruct:getAdvanceStageInfo()
	local var_10_1 = self._succubaStruct:getSid()
	local var_10_2 = self._lastShowCharmData

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "succubaAdvanceUp",
				func = function()
					return require("app.view.module.show.ShowFactory"):showFeedBackTipsPop({
						title = g.core.lang:get(431049),
						sid = var_10_1,
						curAdvInfo = var_10_0,
						showCharmData = var_10_2,
						showComp = fgui.UIPackage:createObject("succuba", "SuccubaAdvSuccessPopComp")
					}, {
						hideContinue = true
					})
				end
			}
		}
	})
end

function SuccubaAdvUpComp:_onBaseAttrClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	if not self._succubaStruct then
		return
	end

	local var_12_0 = {}
	local var_12_1 = self._succubaStruct:getStage()
	local var_12_2 = self._succubaStruct:getNode()
	local var_12_3 = {}
	local var_12_4 = self._succubaStruct:getAdvanceStageInfo()

	for iter_12_0, iter_12_1 in ipairs(self._advInfoList) do
		if (var_12_1 > iter_12_1.stage or iter_12_1.stage == var_12_1 and var_12_2 >= iter_12_1.node) and iter_12_1.talent_skill > 0 then
			local var_12_5 = var_0_0.get(iter_12_1.talent_skill)
			local var_12_6 = 1

			while var_0_0.hasKey("affect_type_" .. var_12_6) do
				if var_12_5["affect_type_" .. var_12_6] > 0 then
					var_12_3[var_12_5["affect_type_" .. var_12_6]] = var_12_3[var_12_5["affect_type_" .. var_12_6]] and var_12_3[var_12_5["affect_type_" .. var_12_6]] + var_12_5["affect_value_" .. var_12_6] or var_12_5["affect_value_" .. var_12_6]
				end

				var_12_6 = var_12_6 + 1
			end
		end
	end

	local var_12_7 = true
	local var_12_8 = {}

	if var_12_4 and var_12_4.id_num > 0 then
		var_12_7 = false

		local var_12_9 = var_0_0.get(var_0_1.get(var_12_4.id_num).talent_skill)
		local var_12_10 = 1

		while var_0_0.hasKey("affect_type_" .. var_12_10) do
			if var_12_9["affect_type_" .. var_12_10] > 0 then
				var_12_8[var_12_9["affect_type_" .. var_12_10]] = var_12_8[var_12_9["affect_type_" .. var_12_10]] and var_12_8[var_12_9["affect_type_" .. var_12_10]] + var_12_9["affect_value_" .. var_12_10] or var_12_9["affect_value_" .. var_12_10]
			end

			var_12_10 = var_12_10 + 1
		end
	end

	for iter_12_2, iter_12_3 in pairs(var_12_8) do
		if not var_12_3[iter_12_2] then
			table.insert(var_12_0, {
				value = 0,
				type = iter_12_2,
				nextValue = iter_12_3
			})
		end
	end

	for iter_12_4, iter_12_5 in pairs(var_12_3) do
		local var_12_12 = {
			type = iter_12_4,
			value = iter_12_5
		}

		var_12_12.nextValue = var_12_8[iter_12_4] and iter_12_5 + var_12_8[iter_12_4]

		table.insert(var_12_0, var_12_12)
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonAttrPop2").new({
		attrList = var_12_0,
		isMax = var_12_7
	}), {
		touchDisappear = true
	})
end

function SuccubaAdvUpComp:_onAdvUpBtnClick()
	if not self._succubaStruct then
		return
	end

	local var_13_0 = self._succubaStruct:getStage()
	local var_13_1 = self._succubaStruct:getAdvanceStageInfo()

	if var_13_1.id_num <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431022))

		return
	end

	for iter_13_0, iter_13_1 in ipairs(self._costList) do
		if g.core.model.User.bagData:getOwnNum(iter_13_1.type, iter_13_1.value) < iter_13_1.numCost then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = iter_13_1.type,
				value = iter_13_1.value
			})

			return
		end
	end

	local var_13_2 = var_13_0
	local var_13_3 = self._succubaStruct:getNode() + 1
	local var_13_4 = var_0_1.get(var_13_1.id_num)

	if var_13_4.stage ~= var_13_0 then
		var_13_2 = var_13_4.stage
		var_13_3 = 0
	end

	g.core.network.GameNetProxy:send_C2S_Succuba_StageUp({
		id = self._succubaStruct:getSid(),
		next_stage = var_13_2,
		next_node = var_13_3
	})
	self.m_advUpBtn:setTouchable(false)
end

return SuccubaAdvUpComp
