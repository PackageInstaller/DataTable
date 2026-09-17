local FormationBossfightLayer = class("FormationBossfightLayer", (require("view.Layer.Formation.FormationJumptowerLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationBossfightLayer:ctor()
	FormationBossfightLayer.super.ctor(self)

	self.selectGirlType = SELECT_GIRL_BOSS_FIGHT
	self.selectHorcruxType = SELECT_HORCRUX_BOSS_FIGHT
	self.configType = CONFIG_TYPE_BOSS_FIGHT
end

function FormationBossfightLayer:create(arg_2_1)
	local var_2_0 = FormationBossfightLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function FormationBossfightLayer:init(arg_3_1)
	if FormationBossfightLayer.super.init(self, arg_3_1) then
		self.configCallback = arg_3_1.configcallback

		return true
	end

	return false
end

function FormationBossfightLayer:initManager()
	self.manager = require("controller.formation.formation_bossfight_manager"):getInstance()
end

function FormationBossfightLayer:getSelectGirlConfig(arg_5_1)
	return {
		layerType = CONFIG_TYPE_BOSS_FIGHT,
		excludelist = require("controller.activity_manager"):getBossfightLockServants(self.activityId),
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.manager._mode,
		sureCallBack = function(arg_6_0)
			return
		end
	}
end

function FormationBossfightLayer:sureButtonCallBack()
	local var_7_0, var_7_1 = self.manager:checkAdventureArray()

	if var_7_0 then
		self:executeHangupArrayChange()

		if self.configCallback and self.manager:checkIsSameColorTeam(self.mode) then
			local var_7_2 = {}

			for iter_7_0, iter_7_1 in pairs(self:getFormationInfo()[1]) do
				table.insert(var_7_2, iter_7_1.fight_girl)
			end

			self.configCallback(var_7_2)
		end
	elseif var_7_1 == 0 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[0], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	elseif var_7_1 == 1 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	end
end

return FormationBossfightLayer
