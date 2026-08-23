local PetInfoPopAssctCell = class("PetInfoPopAssctCell", require("app.fairyGUI.pet.UI_PetInfoPopAssctCell"))
local var_0_1 = g.core.config.passive_skill_info
local var_0_2 = g.core.config.skill_info
local var_0_3 = g.core.model.User.petsData
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.model.User.knightsData
local var_0_6 = {
	IS_ACTIVATED = 1,
	NOT_ACTIVATED = 0
}

function PetInfoPopAssctCell:ctor()
	self._matchInfos = nil
	self._petAdvId = nil
	self._assId = nil
	self._assData = nil
	self._linkSkillId = nil
	self._petAdvId = nil
	self._assctInfo = nil
	self._petInfo = nil

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightIconRenderer))
end

function PetInfoPopAssctCell:_onKnightIconRenderer(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:getChild("iconComp")
	local var_2_1 = arg_2_2:getController("isActive")
	local var_2_2 = arg_2_2:getController("isLast")

	if arg_2_1 == 0 then
		self:_updateSelfIcon(var_2_0)
	else
		self:_updateOtherIcon(arg_2_1, var_2_0)
	end

	var_2_1:setSelectedIndex(self._assData.isActive and 1 or 0)
	var_2_2:setSelectedIndex(self._itemNum == arg_2_1 + 1 and 1 or 0)
end

function PetInfoPopAssctCell:_updateOtherIcon(arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1 = self._assId

	if self._assId > 0 then
		local var_3_2 = false

		var_3_2 = self._matchInfos and self._matchInfos[g.core.common.Goods.TYPE_KNIGHT][var_3_1] or var_0_5:hasKnightByAdvanceId(var_3_1)
		var_3_0 = {
			isGetShow = true,
			type = var_0_4.TYPE_KNIGHT,
			advanceId = var_3_1,
			isMask = not var_3_2
		}
	end

	arg_3_2:updateIcon(var_3_0)
	arg_3_2:setGrayed(var_3_0.isMask)
end

function PetInfoPopAssctCell:_updateSelfIcon(arg_4_1)
	local var_4_0 = false
	local var_4_1

	if self._matchInfos then
		var_4_0 = self._matchInfos[g.core.common.Goods.TYPE_PET][self._petAdvId]
	else
		var_4_0 = var_0_3:getPetByAdvanceId(self._petAdvId):isOwn()
		var_4_1 = {
			isGetShow = true,
			type = var_0_4.TYPE_PET,
			quality = self._petInfo.quality
		}
	end

	var_4_1.icon = g.core.common.Path:getPetIcon(self._petInfo.resource)
	var_4_1.name = self._petInfo.name
	var_4_1.value = self._petInfo.id

	arg_4_1:updateIcon(var_4_1)
	arg_4_1:setGrayed(not var_4_0)
end

function PetInfoPopAssctCell:updateComp(arg_5_1, arg_5_2)
	self._matchInfos = arg_5_2
	self._petAdvId = arg_5_1.petAdvId
	self._assId = arg_5_1.assData.assId
	self._assData = arg_5_1.assData
	self._linkSkillId = arg_5_1.assData.linkSkillId
	self._assctInfo = var_0_2.get(var_0_1.get(self._linkSkillId).passive_skill_value)

	local var_5_0 = var_0_3:getPetByAdvanceId(self._petAdvId)

	self._petInfo = var_5_0:getCfg()

	self.m_nameTxt:setText(self._assctInfo.curtain_name)

	self._itemNum = 2

	self.m_knightList:setNumItems(self._itemNum)

	local var_5_1 = var_0_6.NOT_ACTIVATED

	if self._assData.isActivated and var_5_0:isOwn() then
		var_5_1 = var_0_6.IS_ACTIVATED
	end

	self.m_isActiveController:setSelectedIndex(var_5_1)

	local var_5_2 = g.core.utils.String.formatPassiveSkillDesc(self._linkSkillId)

	var_5_2 = var_5_1 == var_0_6.IS_ACTIVATED and var_5_2 or g.core.utils.String.paintDescGreyColorful(var_5_2)

	self.m_descText:setText(var_5_2)
end

return PetInfoPopAssctCell
