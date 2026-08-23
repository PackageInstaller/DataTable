local PetShowItem = class("PetShowItem", require("app.fairyGUI.infoPop.UI_PetShowItem"))
local var_0_3 = g.core.common.Path

function PetShowItem:ctor()
	return
end

function PetShowItem:updateComp(arg_2_1)
	local var_2_0 = g.core.config.pet_info.get(arg_2_1.value)

	self.m_qualityBg:setURL("ui://base_new/bg_zm_gmwz_pinzhidi_" .. var_2_0.quality)
	self.m_nameTxt:setText(var_2_0.name)
	self.m_petIcon:setURL(g.core.common.Path:getPetDrawing(var_2_0.resource))
	self.m_shadowLoader:setURL(g.core.common.Path:getPetDrawing(var_2_0.resource))
	self.m_shadowLoader:setOpacity(0)
	self.m_shadowLoader:setOpacity(25.5)
	self.m_qualityGLoader:setURL(var_0_3:getQualityArtTxtURL(var_2_0.quality))
	self.m_newSignIcon:setVisible(arg_2_1.isNew)

	if not arg_2_1.isNew then
		self.m_autoFragmentTxt:setText("X" .. var_2_0.return_fragment_num)
		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_PET, arg_2_1.value, true)))
	end

	self.m_fragGroup:setVisible(not arg_2_1.isNew)
	self.m_qualityBg:setURL(var_0_3:getPetShowQualityBg(var_2_0.quality))
	self.m_lineVer:setURL(var_0_3:getRecruitPetQualityLine(var_2_0.quality))
	self.m_lineHor:setURL(var_0_3:getInfoPopQualityLine(var_2_0.quality))
	self:_updateColorLoaderAndBoxLoader(var_2_0.quality)
	self.m_pointTipLoader:setURL(var_0_3:getPetQualityDian(var_2_0.quality))

	if self.m_petMask then
		-- block empty
	end
end

function PetShowItem:_updateColorLoaderAndBoxLoader(arg_3_1)
	for iter_3_0 = 1, 5 do
		self["m_colorLoader" .. iter_3_0]:setURL(var_0_3:getPetRewardLayerItemColorBlock(arg_3_1))
		self["m_colorLoader" .. iter_3_0]:setOpacity(0)
		self["m_colorLoader" .. iter_3_0]:setOpacity(63.75)
	end

	self.m_boxLoader1:setURL(var_0_3:getPetQualityKuang1(arg_3_1))
	self.m_boxLoader2:setURL(var_0_3:getPetQualityKuang2(arg_3_1))
end

return PetShowItem
