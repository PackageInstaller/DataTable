local OutpostBuildEquipCreateIcon = class("OutpostBuildEquipCreateIcon", require("app.fairyGUI.outpost.UI_OutpostBuildEquipCreateIcon"))

function OutpostBuildEquipCreateIcon:ctor()
	self:addClickListener(handler(self, self.onEquipCreateClick))
	self.m_numTxt:enableRich()

	self._itemCfg = nil
	self._needNum = 0
end

function OutpostBuildEquipCreateIcon:updateIconShow(arg_2_1)
	self.m_icon:updateItemIcon({
		item_id = arg_2_1.info.id,
		item_num = arg_2_1.ownNum
	})

	self._itemCfg = arg_2_1.info
	self._needNum = 0

	if arg_2_1.ownNum >= arg_2_1.size then
		self.m_numTxt:setText(g.core.lang:get(432659, {
			cur = arg_2_1.ownNum,
			max = arg_2_1.size
		}))
	else
		self.m_numTxt:setText(g.core.lang:get(432660, {
			cur = arg_2_1.ownNum,
			max = arg_2_1.size
		}))
	end
end

function OutpostBuildEquipCreateIcon:onEquipCreateClick()
	if self._itemCfg then
		-- block empty
	end
end

return OutpostBuildEquipCreateIcon
