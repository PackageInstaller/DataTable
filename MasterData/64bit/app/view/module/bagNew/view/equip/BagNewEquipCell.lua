local BagNewEquipCell = class("BagNewEquipCell", require("app.fairyGUI.bagNew.UI_BagNewEquipCell"))

function BagNewEquipCell:ctor()
	self._oldSelectIndex = 0
	self.m_selectTrans = self:getSharedTrans("enter", "CommonSelected", self.m_selectIcon)

	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)

	self.m_buttonController = self:getController("button")

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelfSelectChanged))
end

function BagNewEquipCell:_onTouchBegin()
	self._oldSelectIndex = self.m_buttonController:getSelectedIndex()
end

function BagNewEquipCell:_onSelfSelectChanged()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 == 1 and self._oldSelectIndex ~= var_3_0 then
		self.m_selectTrans:play()
	end
end

function BagNewEquipCell:update(arg_4_1)
	if arg_4_1 then
		local var_4_0 = arg_4_1:getServerData()
		local var_4_1 = arg_4_1:getOwner()
		local var_4_2 = ""

		if var_4_1 ~= nil then
			var_4_2 = g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_4_1:getBaseInfo().res_id).icon_id)
		end

		local var_4_3 = {
			changeControllers = true,
			resonanceState = 1,
			type = g.core.common.Goods.TYPE_EQUIP,
			value = arg_4_1:getCfg().id,
			level = var_4_0.level,
			stage = var_4_0.refining_level,
			refineLevel = var_4_0.refining_level,
			glyphLevel = var_4_0.glyph_level
		}

		var_4_3.resonanceLevel = var_4_0.resonance_level or 0
		var_4_3.magicalStage = var_4_0.magical_stage

		self.m_iconComp:updateIcon(var_4_3)
		self.m_iconComp:setTouchable(false)
		self.m_knightIcon:setURL(var_4_2)
		self.m_isWearController:setSelectedIndex(checkbool(var_4_1) and 1 or 0)
	end
end

return BagNewEquipCell
