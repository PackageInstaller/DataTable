local var_0_2 = g.core.const.ConstMgr.PetHandBookConst
local PetHandbookGroupUpgradePop = class("PetHandbookGroupUpgradePop", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupUpgradePop"), function()
	return fgui.GComponent:create({
		resName = "PetHandbookGroupUpgradePop",
		pkgPath = "ui/petHandBook/petHandBook",
		pkgName = "petHandBook"
	})
end)

function PetHandbookGroupUpgradePop:ctor(arg_2_1)
	self._groupStruct = arg_2_1.groupStruct

	self:setWidth(display.width)
	self:showAtCenter()
	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")

	self._isActivate = arg_2_1.upgradeType == var_0_2.GROUP_UPGRADE_TYPE.ACTIVATE

	self.m_isActivateController:setSelectedIndex(self._isActivate and 0 or 1)
	self:updateView(arg_2_1)
end

function PetHandbookGroupUpgradePop:updateView(arg_3_1)
	self.m_groupName:setText(self._groupStruct:getName())

	local var_3_0 = self._groupStruct:getPetNum()

	self.m_petNumController:setSelectedIndex(var_3_0)

	local var_3_1, var_3_2 = self._groupStruct:getPetAdvanceId()

	if var_3_0 == 1 then
		self.m_singleIcon:updatePetIcon(var_3_1, true)
	elseif var_3_0 == 2 then
		self.m_leftIcon:updatePetIcon(var_3_1)
		self.m_rightIcon:updatePetIcon(var_3_2)
	end

	local var_3_3 = self._groupStruct:getQuality() + 1

	self.m_qualityLoader:setURL("ui://base_new/pic_yzs_" .. var_3_3 .. "_tj_jihuodi")
	self.m_bigQualityLoader:setURL("ui://base_new/pic_yzs_" .. var_3_3 .. "_tujian_zs")

	local var_3_4 = self._groupStruct:getSumAttrList(self._groupStruct:getBaseId())

	if self._isActivate then
		self.m_enter_1Transition:play()

		for iter_3_0 = 1, var_0_2.GROUP_ATTR_MAX do
			self["m_attr" .. iter_3_0]:setVisible(checkbool(var_3_4[iter_3_0]))

			if var_3_4[iter_3_0] then
				self["m_attr" .. iter_3_0]:updateAttr({
					value = 0,
					type = var_3_4[iter_3_0].type,
					value2 = var_3_4[iter_3_0].value,
					isAll = var_3_4[iter_3_0].isAll
				})
			end
		end
	else
		self.m_enter_0Transition:play()

		local var_3_5 = self._groupStruct:getSumAttrMap(arg_3_1.prevId)

		for iter_3_1 = 1, var_0_2.GROUP_ATTR_MAX do
			local var_3_6 = var_3_4[iter_3_1]
			local var_3_7 = self["m_attr" .. iter_3_1]

			self["m_attr" .. iter_3_1]:setVisible(checkbool(var_3_4[iter_3_1]))

			if var_3_6 then
				local var_3_8 = var_3_5[var_3_6.type] or 0
				local var_3_9 = var_3_6.value

				var_3_7:setVisible(var_3_8 < var_3_6.value)

				if var_3_8 < var_3_9 then
					var_3_7:updateAttr({
						type = var_3_6.type,
						value = var_3_8,
						value2 = var_3_9,
						isAll = var_3_6.isAll
					})
				end
			end
		end
	end
end

function PetHandbookGroupUpgradePop:onUnload()
	if self._isActivate then
		self.m_back_1Transition:play()
	else
		self.m_back_0Transition:play()
	end
end

return PetHandbookGroupUpgradePop
