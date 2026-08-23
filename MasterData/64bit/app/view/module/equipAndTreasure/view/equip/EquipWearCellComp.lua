local var_0_0 = g.core.const.ConstMgr
local EquipWearCellComp = class("EquipWearCellComp", require("app.fairyGUI.equipAndTreasure.UI_EquipWearCellComp"))

function EquipWearCellComp:ctor()
	self._data = nil
	self._equipPos = nil

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self:addClickListener(handler(self, self._onWearClick))
end

function EquipWearCellComp:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 or not arg_2_2 then
		return
	end

	local var_2_0 = g.core.model.User.equipmentData:getEquipIdByPos(arg_2_2)
	local var_2_1 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = arg_2_1:getCfg().id
	})
	local var_2_2 = arg_2_1:getOwner()
	local var_2_3 = checkbool(var_2_2)

	self._isWorn = var_2_3

	self:setTouchable(not (var_2_3 and math.uint64_equal(arg_2_1:getServerData().id, var_2_0)))

	local var_2_4 = {
		resonanceState = 1,
		type = var_2_1.type,
		value = var_2_1.value,
		level = arg_2_1:getServerData().level,
		refineLevel = arg_2_1:getServerData().refining_level,
		glyphLevel = arg_2_1:getServerData().glyph_level,
		equip = arg_2_1:getServerData()
	}

	var_2_4.resonanceLevel = arg_2_1:getServerData().resonance_level or 0
	var_2_4.magicalStage = arg_2_1:getServerData().magical_stage

	self.m_cellComp:updateIcon(var_2_4)
	self.m_isWearController:setSelectedIndex(var_2_3 and 1 or 0)
	self.m_euqipNameTxt:setText(var_2_1.name)

	local var_2_5

	if var_2_3 then
		self.m_icon:setURL((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(arg_2_1:getOwner():getBaseInfo().res_id).icon_id)))

		var_2_5 = {}
	end

	var_2_5.pos = math.ceil(arg_2_2 / 4)

	local var_2_6 = g.core.model.User.knightsData:getKnight(var_2_5)
	local var_2_7 = false
	local var_2_8 = 0

	if var_2_6 then
		var_2_7, var_2_8 = g.core.model.User.equipmentData:isCanActiveAssc(var_2_6:getInfo().id, arg_2_1:getCfg().id)
	end

	if var_2_7 and not var_2_2 then
		self.m_isHaveAssoController:setSelectedIndex(1)
		self.m_assoNumComp:initStar({
			index = 1,
			style = 1,
			type = 1,
			num = var_2_8
		})
	else
		self.m_isHaveAssoController:setSelectedIndex(0)
	end

	self._data = arg_2_1
	self._equipPos = arg_2_2
end

function EquipWearCellComp:_onWearClick()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_BAG) then
		return
	end

	if self._data and self._equipPos then
		local var_3_0 = self._data:getServerData().id
		local var_3_1 = g.core.model.User.equipmentData:getEquipDataByPos(self._equipPos)

		if var_3_1 then
			if var_3_1:getServerData().level > 1 or var_3_1:getServerData().refining_level > 0 or var_3_1:getResonanceLevel() > 0 or var_3_1:getMagicalStage() > 0 then
				g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.InheritFormationPop").new({
					pos = self._equipPos,
					id = var_3_0,
					type = var_0_0.InfoConst.InheritType.EQUIP
				})))
			else
				local var_3_2 = {}

				var_3_2.tp = g.core.network.proto.TYPE_EQUIPMENT
				var_3_2.pos = self._equipPos
				var_3_2.id = var_3_0

				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation(var_3_2)
			end
		else
			local var_3_3 = {}

			var_3_3.tp = g.core.network.proto.TYPE_EQUIPMENT
			var_3_3.pos = self._equipPos
			var_3_3.id = var_3_0

			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation(var_3_3)
		end
	end
end

return EquipWearCellComp
