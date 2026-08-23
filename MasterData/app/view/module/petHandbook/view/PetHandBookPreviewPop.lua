local var_0_0 = g.core.model.User.petHandBookData
local var_0_1 = g.core.model.User.petsData
local var_0_2 = g.core.const.ConstMgr.PetHandBookConst
local PetHandBookPreviewPop = class("PetHandBookPreviewPop", require("app.fairyGUI.petHandBook.UI_PetHandBookPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "PetHandBookPreviewPop",
		pkgPath = "ui/petHandBook/petHandBook",
		pkgName = "petHandBook"
	})
end)

function PetHandBookPreviewPop:ctor(arg_2_1)
	self._showLvUpFeedBack = false

	self:setWidth(display.width)
	self:showAtCenter()
	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self:updateView(arg_2_1)
end

function PetHandBookPreviewPop:updateView(arg_3_1)
	local var_3_0 = var_0_1:getPetByAdvanceId(arg_3_1.advId)
	local var_3_1 = var_3_0:getCfg()

	self.m_petPicComp:setURL((g.core.common.Path:getPetMiddle(var_3_0:getCfg().resource)))
	self.m_nameComp:setData(var_3_0)

	local var_3_2 = var_0_0:getPetBookAttrById(var_3_1.id)

	if arg_3_1.state == var_0_2.CELL_STATE.CAN_NOT_ACTIVATE then
		self.m_stateController:setSelectedIndex(0)

		for iter_3_0 = 1, var_0_2.ATTR_NUM do
			if var_3_2[iter_3_0] then
				local var_3_3 = {
					name = var_3_2[iter_3_0].attr[1]
				}

				var_3_3.value = 0
				var_3_3.value2 = var_3_2[iter_3_0].attr[2]
				var_3_3.isAll = var_3_2[iter_3_0].isAll

				self["m_attr" .. iter_3_0]:updateAttr(var_3_3)
				self["m_attr" .. iter_3_0]:setVisible(true)
			else
				self["m_attr" .. iter_3_0]:setVisible(false)
			end
		end

		self.m_enter_0Transition:play()
	elseif arg_3_1.state == var_0_2.CELL_STATE.ACTIVATED_NORMAL then
		self.m_stateController:setSelectedIndex(1)

		if var_3_1.next_id > 0 then
			local var_3_4 = var_0_0:getPetBookAttrById(var_3_1.next_id)

			for iter_3_1 = 1, var_0_2.ATTR_NUM do
				if var_3_2[iter_3_1] then
					self["m_attr" .. iter_3_1]:updateAttr({
						name = var_3_2[iter_3_1].attr[1],
						value = var_3_2[iter_3_1].attr[2],
						value2 = var_3_4[iter_3_1].attr[2],
						isAll = var_3_4[iter_3_1].isAll
					})
					self["m_attr" .. iter_3_1]:setVisible(true)
				else
					self["m_attr" .. iter_3_1]:setVisible(false)
				end
			end

			self.m_enter_0Transition:play()
		else
			for iter_3_2 = 1, var_0_2.ATTR_NUM do
				if var_3_2[iter_3_2] then
					self["m_attr" .. iter_3_2]:updateAttr({
						name = var_3_2[iter_3_2].attr[1],
						value = var_3_2[iter_3_2].attr[2],
						isAll = var_3_2[iter_3_2].isAll
					})
					self["m_attr" .. iter_3_2]:setVisible(true)
				else
					self["m_attr" .. iter_3_2]:setVisible(false)
				end
			end

			self.m_enter_0Transition:play()
		end
	end
end

return PetHandBookPreviewPop
