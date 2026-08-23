local var_0_0 = g.core.model.User.petHandBookData
local var_0_1 = g.core.model.User.petsData
local var_0_2 = g.core.const.ConstMgr.PetHandBookConst
local PetHandBookLvUpPop = class("PetHandBookLvUpPop", require("app.fairyGUI.petHandBook.UI_PetHandBookLvUpPop"), function()
	return fgui.GComponent:create({
		resName = "PetHandBookLvUpPop",
		pkgPath = "ui/petHandBook/petHandBook",
		pkgName = "petHandBook"
	})
end)

function PetHandBookLvUpPop:ctor(arg_2_1)
	self._showLvUpFeedBack = arg_2_1.showLvUpFeedBack
	self._oldScore = arg_2_1.oldScore

	self:setWidth(display.width)
	self:showAtCenter()
	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self:updateView(arg_2_1)
end

function PetHandBookLvUpPop:updateView(arg_3_1)
	local var_3_0 = var_0_1:getPetByAdvanceId(var_0_0:getComposeCfgById(arg_3_1.id).pet_1)

	self.m_petPicComp:setURL((g.core.common.Path:getPetMiddle(var_3_0:getCfg().resource)))
	self.m_nameComp:setData(var_3_0)
	self.m_lvUpEffHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_handbook_upgrade",
		isLoop = false
	})

	if arg_3_1.state == var_0_2.CELL_STATE.CAN_ACTIVATE then
		self.m_stateController:setSelectedIndex(0)

		local var_3_1 = var_0_0:getPetBookAttrById(arg_3_1.preId)

		for iter_3_0 = 1, var_0_2.ATTR_NUM do
			if var_3_1[iter_3_0] then
				local var_3_2 = {
					name = var_3_1[iter_3_0].attr[1]
				}

				var_3_2.value = 0
				var_3_2.value2 = var_3_1[iter_3_0].attr[2]
				var_3_2.isAll = var_3_1[iter_3_0].isAll

				self["m_attr" .. iter_3_0]:updateAttr(var_3_2)
				self["m_attr" .. iter_3_0]:setVisible(true)
			else
				self["m_attr" .. iter_3_0]:setVisible(false)
			end
		end

		self.m_enter_1Transition:play()

		self._state = 0
	else
		self.m_stateController:setSelectedIndex(1)
		self.m_levelTxt2:setText(arg_3_1.level + 1)
		self.m_levelTxt1:setText(arg_3_1.level)

		local var_3_3 = var_0_0:getPetBookAttrById(arg_3_1.preId)
		local var_3_4 = var_0_0:getPetBookAttrById(arg_3_1.id)

		for iter_3_1 = 1, var_0_2.ATTR_NUM do
			if var_3_4[iter_3_1] then
				self["m_attr" .. iter_3_1]:updateAttr({
					name = var_3_3[iter_3_1].attr[1],
					value = var_3_3[iter_3_1].attr[2],
					value2 = var_3_4[iter_3_1].attr[2],
					isAll = var_3_4[iter_3_1].isAll
				})
				self["m_attr" .. iter_3_1]:setVisible(true)
			else
				self["m_attr" .. iter_3_1]:setVisible(false)
			end
		end

		self.m_enter_1Transition:play()

		self._state = 1
	end
end

return PetHandBookLvUpPop
