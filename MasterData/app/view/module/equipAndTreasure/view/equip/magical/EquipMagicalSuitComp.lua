local var_0_0 = g.core.const.ConstMgr.EquipConst
local var_0_1 = g.core.model.User.equipmentData
local var_0_2 = g.core.const.ConstMgr.TipConst
local EquipMagicalSuitComp = class("EquipMagicalSuitComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalSuitComp"))

function EquipMagicalSuitComp:ctor()
	self._suitId = 0

	self.m_suitStage:addClickListener(handler(self, self._onClickSuitStage))

	self._curStage = 0
	self._activeNum = 0
end

function EquipMagicalSuitComp:updateView(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:getMaxMagicalStage()

	self._suitId = arg_2_1.suitId
	self._activeNum = arg_2_1.activeNum

	local var_2_2

	if self.m_suitTypeController:getSelectedIndex() == var_0_0.EQUIP_SUIT_TYPE.TWO then
		self._curStage = math.clamp(arg_2_1.maxStage, 0, var_0_0.MAGICAL_MAX_STAGE[arg_2_1.quality])
		var_2_2 = 201654
	else
		self._curStage = math.clamp(arg_2_1.minStage, 0, var_0_0.MAGICAL_MAX_STAGE[arg_2_1.quality])
		var_2_2 = 201655
	end

	local var_2_3 = var_0_1:getSuitStageInfoBySuitIdAndStage(arg_2_1.suitId, (math.clamp(self._curStage + 1, 1, var_2_0)))
	local var_2_5 = (g.core.config.equipment_suit_info.get(self._suitId) or {}).name or ""

	if self._curStage < var_0_0.MAGICAL_MAX_STAGE[arg_2_1.quality] then
		self.m_conditionDesc:setTitle(g.core.lang:get(var_2_2, {
			name = var_2_5,
			level = self._curStage + 1
		}))
	else
		self.m_conditionDesc:setTitle(g.core.lang:get(var_2_2, {
			name = var_2_5,
			level = self._curStage
		}))
	end

	self.m_suitStage:updateView(var_2_3)
end

function EquipMagicalSuitComp:_onClickSuitStage()
	if self._suitId == 0 then
		return
	end

	local var_3_0 = self.m_suitTypeController:getSelectedIndex()
	local var_3_1 = require("app.view.module.tip.view.EquipMagicalStageTalentTip").new
	local var_3_2 = {
		talentData = var_0_1:getSuitTalentList(self._suitId, var_3_0, self._curStage, self._activeNum)
	}

	if var_3_0 == var_0_0.EQUIP_SUIT_TYPE.TWO then
		var_3_2.style = var_0_2.EquipMagicalTipType.TWO or var_0_2.EquipMagicalTipType.FOUR
	end

	var_3_2.activeNum = self._activeNum

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.EquipMagicalStageTalentTip").new(var_3_2), {
		touchDisappear = true
	})
end

return EquipMagicalSuitComp
