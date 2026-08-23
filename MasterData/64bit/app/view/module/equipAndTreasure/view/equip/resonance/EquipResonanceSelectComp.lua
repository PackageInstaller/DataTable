local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.config.equipment_resonance_info
local EquipResonanceSelectComp = class("EquipResonanceSelectComp", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceSelectComp"))

function EquipResonanceSelectComp:ctor()
	self.m_matList:setVirtual()
	self.m_matList:setItemRenderer(handler(self, self._onMatItemRenderer))
	self:addListen(self.m_matList)

	self._materialData = {}
	self._selectedNum = {}

	self.m_advBtn0:addClickListener(handler(self, self._onClickAdvBtn))
	self.m_advBtn1:addClickListener(handler(self, self._onClickAdvBtn))
	self.m_onekeyBtn:addClickListener(handler(self, self._onClickOnekeyBtn))
	self.m_checkBtn:addClickListener(handler(self, self._onClickCheckBtn))
	self.m_onekeyController:setSelectedIndex(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_RESONANCE_QUICK) and 1 or 0)
end

function EquipResonanceSelectComp:updateMaterial(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.isCheck then
		self.m_isCheckController:setSelectedIndex(1)
	else
		self.m_isCheckController:setSelectedIndex(0)
	end

	if arg_2_1.materials then
		self._materialData = arg_2_1.materials
	end

	if arg_2_1.equip then
		self._equip = arg_2_1.equip
	end

	if arg_2_1.selectedNum then
		self._selectedNum = arg_2_1.selectedNum
	else
		for iter_2_0, iter_2_1 in ipairs(self._materialData) do
			self._selectedNum[iter_2_0] = 0
		end
	end

	self.m_matList:setNumItems(#self._materialData)

	self._curLevel = self._equip:getResonanceLevel()
	self._curExp = self._equip:getResonanceExp()
end

function EquipResonanceSelectComp:onLoad()
	return
end

function EquipResonanceSelectComp:onUnload()
	return
end

function EquipResonanceSelectComp:_onMatItemRenderer(arg_5_1, arg_5_2)
	if self._materialData[arg_5_1 + 1] then
		local var_5_0 = {
			material = {
				type = self._materialData[arg_5_1 + 1].cost_type,
				value = self._materialData[arg_5_1 + 1].cost_value,
				size = var_0_0:getOwnNum(self._materialData[arg_5_1 + 1].cost_type, self._materialData[arg_5_1 + 1].cost_value)
			}
		}

		var_5_0.selectedNum = self._selectedNum[arg_5_1 + 1] or 0
		var_5_0.itemIdx = arg_5_1 + 1

		arg_5_2:updateItem(var_5_0)
	end
end

function EquipResonanceSelectComp:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "EquipMaterialItem_sub" then
		if arg_6_2.itemIdx then
			self:_changeSelectedItemNum(arg_6_2.itemIdx, -1)
		end
	elseif arg_6_1 == "EquipMaterialItem_add" and arg_6_2.itemIdx then
		self:_changeSelectedItemNum(arg_6_2.itemIdx, 1)
	end
end

function EquipResonanceSelectComp:_changeSelectedItemNum(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0, var_7_1, var_7_2 = self:_caculateLevelExpAdd(arg_7_1, arg_7_2)

	if var_7_2 then
		self._selectedNum[arg_7_1] = self._selectedNum[arg_7_1] + arg_7_2
	end

	self._selectedNum[arg_7_1] = math.min(self._selectedNum[arg_7_1], (var_0_0:getOwnNum(self._materialData[arg_7_1].cost_type, self._materialData[arg_7_1].cost_value)))

	self.m_matList:setNumItems(#self._materialData)

	local var_7_3 = var_0_1.get(self._equip:getCfg().resonance_id, self._curLevel + 1).exp

	self:dispatchCompEvent("EquipResonance_selectMaterial", {
		predictLevel = var_7_0,
		predictExp = var_7_1
	})
end

function EquipResonanceSelectComp:_onClickAdvBtn()
	self:_sendC2SResonanceUp()
end

function EquipResonanceSelectComp:_sendC2SResonanceUp()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._selectedNum) do
		if self._selectedNum[iter_9_0] > 0 then
			var_9_0[#var_9_0 + 1] = {
				type = self._materialData[iter_9_0].cost_type,
				value = self._materialData[iter_9_0].cost_value,
				size = self._selectedNum[iter_9_0]
			}
		end
	end

	if next(var_9_0) then
		g.core.network.GameNetProxy:send_C2S_Equipment_Resonance_Up({
			id = self._equip:getServerData().id,
			consume = var_9_0
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201608))
	end
end

function EquipResonanceSelectComp:_onClickOnekeyBtn()
	local var_10_0, var_10_1 = self._equip:getNextResonanceInfo()

	if not var_10_0 then
		return
	end

	if var_10_1 then
		return
	end

	local var_10_2 = var_10_0.exp - self._curExp
	local var_10_3 = 0

	for iter_10_0, iter_10_1 in ipairs(self._materialData) do
		self._selectedNum[iter_10_0] = 0
	end

	local var_10_5 = false

	for iter_10_2, iter_10_3 in ipairs(self._materialData) do
		local var_10_6 = var_0_0:getOwnNum(iter_10_3.cost_type, iter_10_3.cost_value)

		if var_10_6 > 0 then
			var_10_5 = true
		end

		if var_10_6 > 0 and var_10_2 < var_10_3 + iter_10_3.exp * var_10_6 then
			local var_10_8 = math.ceil((var_10_2 - var_10_3) / iter_10_3.exp)

			self._selectedNum[iter_10_2] = var_10_8
			var_10_3 = var_10_3 + iter_10_3.exp * var_10_8

			break
		else
			self._selectedNum[iter_10_2] = var_10_6
			var_10_3 = var_10_3 + iter_10_3.exp * var_10_6
		end
	end

	if var_10_5 then
		self.m_isCheckController:setSelectedIndex(1)
		self.m_matList:setNumItems(#self._materialData)

		local var_10_9, var_10_10, var_10_11 = self:_caculateLevelExpAdd()

		self:dispatchCompEvent("EquipResonance_selectMaterial", {
			predictLevel = var_10_9,
			predictExp = var_10_10
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201609))
	end
end

function EquipResonanceSelectComp:_onClickCheckBtn()
	self.m_isCheckController:setSelectedIndex(0)
	self:_sendC2SResonanceUp()
end

function EquipResonanceSelectComp:materialReset()
	if self.m_isCheckController:getSelectedIndex() == 1 then
		self.m_isCheckController:setSelectedIndex(0)

		for iter_12_0, iter_12_1 in ipairs(self._materialData) do
			self._selectedNum[iter_12_0] = 0
		end

		self.m_matList:setNumItems(#self._materialData)
	end
end

function EquipResonanceSelectComp:_caculateLevelExpAdd(arg_13_1, arg_13_2)
	local var_13_0 = 0
	local var_13_1 = false

	for iter_13_0, iter_13_1 in ipairs(self._selectedNum) do
		if self._selectedNum[iter_13_0] > 0 then
			var_13_0 = var_13_0 + self._materialData[iter_13_0].exp * self._selectedNum[iter_13_0]
		end
	end

	local var_13_2 = self._curLevel
	local var_13_4 = var_0_1.get(self._equip:getCfg().resonance_id, self._curLevel + 1).exp
	local var_13_5 = self._curExp + var_13_0

	if var_13_4 <= self._curExp + var_13_0 and arg_13_2 and arg_13_2 > 0 then
		var_13_1 = false
		var_13_2 = var_13_2 + 1
		var_13_5 = var_13_5 - var_13_4
	else
		var_13_1 = true

		if arg_13_1 and arg_13_2 then
			var_13_5 = var_13_5 + self._materialData[arg_13_1].exp * arg_13_2
		end

		if var_13_4 <= var_13_5 then
			var_13_2 = var_13_2 + 1
			var_13_5 = var_13_5 - var_13_4
		elseif var_13_5 < 0 and var_13_2 > self._curLevel then
			var_13_5 = var_13_4 + var_13_5
			var_13_2 = var_13_2 - 1
		end
	end

	return var_13_2, var_13_5, var_13_1
end

return EquipResonanceSelectComp
