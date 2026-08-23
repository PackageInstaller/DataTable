local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.common.Color
local EquipMagicalFragComp = class("EquipMagicalFragComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalFragComp"))

function EquipMagicalFragComp:ctor()
	self._equip = nil
	self._canStageUp = true

	self.m_stageUpBtn:addClickListener(handler(self, self._onClickStageUpBtn))
end

function EquipMagicalFragComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_MAGICALSTAGE_UP, handler(self, self._onS2CEquipMagicalStageUp), self)
end

function EquipMagicalFragComp:updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._equip = arg_3_1

	local var_3_0 = arg_3_1:getMagicalStageUpCost()
	local var_3_1 = var_0_0:convert({
		type = var_3_0.type,
		value = var_3_0.value
	})

	self.m_costIcon:updateIcon(var_3_1)
	self.m_name:setText(var_3_1.name)

	local var_3_2 = var_0_1:getOwnNum(var_3_1.type, var_3_1.value)

	self.m_numText:setText(math.min(var_3_2, var_3_0.size) .. "/" .. var_3_0.size)
	self.m_numText:setColor((var_3_2 >= var_3_0.size or nil) and (var_0_2.A1 or var_0_2.A4))
	self.m_fragProgBar:setPercent({
		cur = var_3_2,
		max = var_3_0.size
	})
end

function EquipMagicalFragComp:_onClickStageUpBtn()
	if not self._equip then
		return
	end

	if self._equip:isMagicalStageUpCostEnough() then
		if self._canStageUp then
			self._canStageUp = false

			g.core.model.User.equipmentData:cacheActiveSuitMap(self._equip:getKnightPos())
			g.core.network.GameNetProxy:send_C2S_Equipment_MagicalStage_Up({
				id = self._equip:getSid(),
				target_stage = self._equip:getNextMagicalStage()
			})
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(302093))
	end
end

function EquipMagicalFragComp:_onS2CEquipMagicalStageUp()
	self._canStageUp = true
end

return EquipMagicalFragComp
