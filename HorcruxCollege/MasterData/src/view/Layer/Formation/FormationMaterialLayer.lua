local FormationMaterialLayer = class("FormationMaterialLayer", (require("view.Layer.Formation.FormationModeLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationMaterialLayer:ctor()
	FormationMaterialLayer.super.ctor(self)
	self:setAutoAdapt(true)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.selectGirlType = SELECT_GIRL_FIGHT_MATERIAL
	self.selectHorcruxType = SELECT_HORCRUX_FIGHT_MATERIAL
	self.configType = CONFIG_TYPE_MODE
end

function FormationMaterialLayer:initManager()
	self.manager = require("controller.formation.formation_mode_manager"):getInstance()
end

function FormationMaterialLayer:create(arg_3_1)
	local var_3_0 = FormationMaterialLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationMaterialLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationMaterialLayer:getAutoAdvanceForcesCallBack()
	return function()
		local var_6_0 = self.manager:getAdvanceForcesOneTimeArray()
		local var_6_1 = false

		for iter_6_0, iter_6_1 in pairs(self.manager:getFormationInfo()[self.curFormationIndex]) do
			if iter_6_1.assist_girl ~= var_6_0["pos_" .. iter_6_1.pos].assist_girl then
				var_6_1 = true

				break
			end

			if iter_6_1.fight_girl ~= var_6_0["pos_" .. iter_6_1.pos].fight_girl then
				var_6_1 = true

				break
			end
		end

		if var_6_1 then
			self.manager:requestOneTimeUpdateArray(nil, var_6_0)
		else
			global_ShowBlockWords("与先遣阵容相同，无需更换")
		end
	end
end

function FormationMaterialLayer:getSelectGirlConfig(arg_7_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.manager._mode,
		sureCallBack = function(arg_8_0)
			return
		end
	}
end

function FormationMaterialLayer:selectGirl(arg_9_1)
	if self:selectGirlConditionScreening(arg_9_1, {
		bAutoTips = true
	}) then
		local var_9_0 = self:getFormationInfo()

		if var_9_0 and var_9_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_9_1)))
		end
	end
end

function FormationMaterialLayer:isShowAutoHelpBattleBtn()
	return true
end

return FormationMaterialLayer
