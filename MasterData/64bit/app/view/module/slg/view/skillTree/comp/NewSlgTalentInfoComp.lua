local var_0_0 = g.core.common.Path
local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_3 = g.core.const.ConstMgr.NewSlgConst
local NewSlgTalentInfoComp = class("NewSlgTalentInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgTalentInfoComp"))

function NewSlgTalentInfoComp:ctor()
	self._talentStruct = nil
	self._skillTreeData = nil
	self._attrList = {}

	self:initView()

	self._autoState = -1

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onTalentAttrRenderer))
end

function NewSlgTalentInfoComp:initView()
	self.m_activeBtn:addClickListener(handler(self, self._onClickActiveBtn))
	self.m_activeToBtn:addClickListener(handler(self, self._onClickActiveToBtn))
	self.m_activeButtonBtn:addClickListener(handler(self, self._onClickActiveButtonBtn))
	self.m_activeTopBtn:addClickListener(handler(self, self._onClickActiveTopBtn))
	self.m_activeCurBtn:addClickListener(handler(self, self._onClickActiveBtn))
	self.m_activeAutoBtn:addClickListener(handler(self, self._onClickAutoActiveBtn))
end

function NewSlgTalentInfoComp:_onClickActiveBtn()
	if not self._talentStruct then
		return
	end

	local var_3_0, var_3_1 = self._skillTreeData:getBtnState(self._talentStruct, self._skillTreeType)

	if var_3_0 == var_0_3.BTN_STATE.CAN_ACTIVE or var_3_0 == var_0_3.BTN_STATE.AUTO then
		local var_3_2 = self._talentStruct:getInfo()

		if var_3_0 == var_0_3.BTN_STATE.CAN_ACTIVE then
			if var_3_2.activate_size_1 > 0 and self.m_resComp1:isLack() then
				g.core.module.ModuleManager:tip(g.core.lang:get(429732, {
					name = g.core.common.Goods:convert({
						type = var_3_2.activate_type_1,
						value = var_3_2.activate_value_1
					}).name
				}))

				return
			end
		elseif var_3_2.activate_size_1 > 0 and self.m_resComp2:isLack() then
			g.core.module.ModuleManager:tip(g.core.lang:get(429732, {
				name = g.core.common.Goods:convert({
					type = var_3_2.activate_type_1,
					value = var_3_2.activate_value_1
				}).name
			}))

			return
		end

		g.core.network.GameNetProxy:send_C2S_NewSlg_TechnologyActivate({
			id = var_3_2.id
		})
	end
end

function NewSlgTalentInfoComp:_onClickResetBtn()
	if not self._talentStruct then
		return
	end
end

function NewSlgTalentInfoComp:updateCompByStruct(arg_5_1, arg_5_2, arg_5_3)
	self._talentStruct = arg_5_1
	self._skillTreeData = arg_5_2
	self._skillTreeType = arg_5_3

	self:_updateView(arg_5_1)
end

function NewSlgTalentInfoComp:refreshComp()
	if self._talentStruct then
		self:updateCompByStruct(self._talentStruct, self._skillTreeData, self._skillTreeType)
	end
end

function NewSlgTalentInfoComp:_updateView(arg_7_1)
	self.m_talentName:setText(arg_7_1:getName())

	local var_7_0 = arg_7_1:getInfo()
	local var_7_1, var_7_2 = self._skillTreeData:getBtnState(arg_7_1, self._skillTreeType)
	local var_7_3 = {}
	local var_7_4 = {}

	self.m_res2:setVisible(false)
	self.m_res1:setVisible(false)

	if var_7_1 == var_0_3.BTN_STATE.CAN_ACTIVE then
		var_7_3 = {
			arg_7_1:getId()
		}
	elseif var_7_1 == var_0_3.BTN_STATE.PRE_LOCK then
		if arg_7_1:isCanActive() then
			self.m_unlockDesc:setText(g.core.lang:get(429727))
		else
			self.m_unlockDesc:setText(g.core.lang:getByString(var_7_0.unlock_des, {
				num = var_7_0.unlock_value_2
			}))
		end
	elseif var_7_1 == var_0_3.BTN_STATE.LOCK then
		self.m_unlockDesc:setText(g.core.lang:getByString(var_7_0.unlock_des, {
			num = var_7_0.unlock_value_2
		}))
	elseif var_7_1 == var_0_3.BTN_STATE.LOCK_TO then
		var_7_3 = self._skillTreeData:getPreSameLocationUnActiveIds(arg_7_1, arg_7_1:getInfo().pot_location, self._skillTreeType)
	elseif var_7_1 == var_0_3.BTN_STATE.DOUBLE then
		var_7_3 = self._skillTreeData:getPreSameLocationUnActiveIds(arg_7_1, 0, self._skillTreeType)
		var_7_4 = self._skillTreeData:getPreSameLocationUnActiveIds(arg_7_1, 2, self._skillTreeType)
	elseif var_7_1 == var_0_3.BTN_STATE.AUTO then
		self._autoState = var_7_2

		if var_7_2 == 0 then
			self.m_activeAutoBtn:setTitle(g.core.lang:get(429759))
		else
			self.m_activeAutoBtn:setTitle(g.core.lang:get(429760))
		end

		var_7_3 = self._skillTreeData:getPreSameLocationUnActiveIds(arg_7_1, var_7_2, self._skillTreeType)
		var_7_4 = {
			arg_7_1:getId()
		}
	end

	if next(var_7_3) then
		local var_7_5 = 0

		for iter_7_0, iter_7_1 in pairs(var_7_3) do
			var_7_5 = var_7_5 + self._skillTreeData:getTalentById(iter_7_1, false, self._skillTreeType):getInfo().activate_size_1
		end

		self.m_resComp1:updateByTVS({
			type = var_7_0.activate_type_1,
			value = var_7_0.activate_value_1,
			size = var_7_5
		})
		self.m_res1:setVisible(true)
	end

	local var_7_7

	if next(var_7_4) then
		local var_7_6 = 0

		for iter_7_2, iter_7_3 in pairs(var_7_4) do
			var_7_6 = var_7_6 + self._skillTreeData:getTalentById(iter_7_3, false, self._skillTreeType):getInfo().activate_size_1
		end

		self.m_resComp2:updateByTVS({
			type = var_7_0.activate_type_1,
			value = var_7_0.activate_value_1,
			size = var_7_6
		})
		self.m_res2:setVisible(true)

		var_7_7 = {}
	end

	var_7_7[1] = {
		attrType = var_7_0.talent_type,
		attrValue = var_7_0.talent_value,
		addType = var_7_0.add_type,
		addModule = var_7_0.add_module
	}
	self._attrList = var_7_7

	self.m_attrList:setNumItems(#self._attrList)
	self.m_btnStateController:setSelectedIndex(var_7_1)
	self.m_talentTypeController:setSelectedIndex(arg_7_1:getInfo().pot_type - 1)
	self.m_nodeIcon:setURL(var_0_0:getNewSlgSkillIconByName(self._talentStruct:getInfo().pot_icon))
end

function NewSlgTalentInfoComp:_onClickAutoActiveBtn()
	if self._autoState == -1 then
		return
	end

	if self.m_resComp1:isLack() then
		local var_8_0 = self._talentStruct:getInfo()

		g.core.module.ModuleManager:tip(g.core.lang:get(429732, {
			name = g.core.common.Goods:convert({
				type = var_8_0.activate_type_1,
				value = var_8_0.activate_value_1
			}).name
		}))
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_TechnologyActivateOneKey({
		id = self._talentStruct:getId(),
		location = self._autoState
	})

	self._autoState = -1
end

function NewSlgTalentInfoComp:_onTalentAttrRenderer(arg_9_1, arg_9_2)
	local var_9_0 = self._attrList[arg_9_1 + 1].attrValue
	local var_9_1 = (var_0_3.ATTR_MODULE_STRING[self._attrList[arg_9_1 + 1].addModule] or "") .. var_0_3.ATTR_STRING[self._attrList[arg_9_1 + 1].attrType]
	local var_9_2

	if self._attrList[arg_9_1 + 1].addType == var_0_3.ATTR_TYPE.PRE then
		var_9_0 = var_9_0 / 10
		var_9_0 = var_9_0 .. "%"
		var_9_2 = {
			name = var_9_1,
			value = var_9_0
		}
	end

	var_9_2.iconRes = var_0_0:getNewSlgSkillIconByName(self._talentStruct:getInfo().pot_icon)

	arg_9_2:updateAttr(var_9_2)
end

function NewSlgTalentInfoComp:_onClickActiveToBtn()
	if self.m_resComp1:isLack() then
		local var_10_0 = self._talentStruct:getInfo()

		g.core.module.ModuleManager:tip(g.core.lang:get(429732, {
			name = g.core.common.Goods:convert({
				type = var_10_0.activate_type_1,
				value = var_10_0.activate_value_1
			}).name
		}))
	end

	local var_10_1, var_10_2 = self._skillTreeData:getBtnState(self._talentStruct, self._skillTreeType)

	g.core.network.GameNetProxy:send_C2S_NewSlg_TechnologyActivateOneKey({
		id = self._talentStruct:getId(),
		location = var_10_2 == 1 and 0 or var_10_2
	})
end

function NewSlgTalentInfoComp:_onClickActiveButtonBtn()
	if self.m_resComp2:isLack() then
		local var_11_0 = self._talentStruct:getInfo()

		g.core.module.ModuleManager:tip(g.core.lang:get(429732, {
			name = g.core.common.Goods:convert({
				type = var_11_0.activate_type_1,
				value = var_11_0.activate_value_1
			}).name
		}))
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_TechnologyActivateOneKey({
		location = 2,
		id = self._talentStruct:getId()
	})
end

function NewSlgTalentInfoComp:_onClickActiveTopBtn()
	if self.m_resComp1:isLack() then
		local var_12_0 = self._talentStruct:getInfo()

		g.core.module.ModuleManager:tip(g.core.lang:get(429732, {
			name = g.core.common.Goods:convert({
				type = var_12_0.activate_type_1,
				value = var_12_0.activate_value_1
			}).name
		}))
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_TechnologyActivateOneKey({
		location = 0,
		id = self._talentStruct:getId()
	})
end

return NewSlgTalentInfoComp
