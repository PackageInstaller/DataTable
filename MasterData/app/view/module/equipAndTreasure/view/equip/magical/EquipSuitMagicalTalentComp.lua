local var_0_0 = g.core.model.User.equipmentData
local var_0_1 = g.core.const.ConstMgr.EquipConst
local EquipSuitMagicalTalentComp = class("EquipSuitMagicalTalentComp", require("app.fairyGUI.equipAndTreasure.UI_EquipSuitMagicalTalentComp"))

function EquipSuitMagicalTalentComp:ctor()
	self._twoAttrList = {}
	self._fourAttrList = {}
end

function EquipSuitMagicalTalentComp:updateSuitTalentComp(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_2:getMaxMagicalStage()
	local var_2_1 = math.clamp(arg_2_1.maxStage, 1, var_2_0)
	local var_2_2 = math.clamp(arg_2_1.minStage, 1, var_2_0)

	self._twoAttrList = var_0_0:getSuitTalentListOfSpecificStage(arg_2_1.suitId, var_0_1.EQUIP_SUIT_TYPE.TWO, var_2_1)
	self._fourAttrList = var_0_0:getSuitTalentListOfSpecificStage(arg_2_1.suitId, var_0_1.EQUIP_SUIT_TYPE.FOUR, var_2_2)

	local var_2_3 = var_0_0:getSuitStageInfoBySuitIdAndStage(arg_2_1.suitId, var_2_1)

	self.m_twoSuitTitle:setQuality(arg_2_2:getQuality())
	self.m_twoSuitTitle:setTitle(g.core.lang:get(201657, {
		name = var_2_3.talent_name_1,
		level = var_2_3.suit_stage
	}))

	local var_2_4 = var_2_1 <= arg_2_1.maxStage
	local var_2_5 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.stageList) do
		if iter_2_1 > 0 then
			var_2_5 = var_2_5 + 1
		end
	end

	if not var_2_4 then
		self.m_twoSuitTitle:setActiveProgress(var_2_5)
	end

	self.m_twoSuitTitle:setActiveState(var_2_4)

	local var_2_6 = self.m_twoAttr:getChild("attrComp")

	if var_2_6 then
		var_2_6:updateAttr({
			type = self._twoAttrList[1].type,
			value = self._twoAttrList[1].value,
			isGray = not var_2_4
		})
	end

	local var_2_7 = var_0_0:getSuitStageInfoBySuitIdAndStage(arg_2_1.suitId, var_2_2)

	self.m_fourSuitTitle:setQuality(arg_2_2:getQuality())
	self.m_fourSuitTitle:setTitle(g.core.lang:get(201657, {
		name = var_2_7.talent_name_2,
		level = var_2_7.suit_stage
	}))

	local var_2_8 = var_2_2 <= arg_2_1.minStage

	if var_2_2 > arg_2_1.minStage then
		self.m_fourSuitTitle:setActiveProgress(var_2_5)
	end

	self.m_fourSuitTitle:setActiveState(var_2_8)

	local var_2_9 = self.m_fourAttr:getChild("attrComp")

	if var_2_9 then
		var_2_9:updateAttr({
			type = self._fourAttrList[1].type,
			value = self._fourAttrList[1].value,
			isGray = not var_2_8
		})
	end
end

return EquipSuitMagicalTalentComp
