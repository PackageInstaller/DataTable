FormationMainLayer = class("FormationMainLayer", (require("view.Layer.Formation.BaseFormationLayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_1 = config._DEBUG and 0 or 1

function FormationMainLayer:ctor()
	FormationMainLayer.super.ctor(self)

	local var_1_0 = require("model.playermodel").curArray or 1

	self.manager:setCurFormationIndex(var_1_0)

	self.curFormationIndex = var_1_0
	self.configType = CONFIG_TYPE_HANGUP
	self.selectGirlType = SELECT_GIRL_FIGHT
	self.selectHorcruxType = SELECT_HORCRUX_FIGHT
	self.bInit = true
	self.bChange = false
	self.repeatChallenge = false
end

function FormationMainLayer.initManager(arg_2_0)
	arg_2_0.manager = require("controller.formation.formation_main_manager"):getInstance()
end

function FormationMainLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = FormationMainLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationMainLayer:init(arg_4_1)
	self.configMode = arg_4_1.initmode
	self.isAuto = arg_4_1.isAuto

	if arg_4_1.repeatChallenge == true then
		self.repeatChallenge = true
	end

	if FormationMainLayer.super.init(self, arg_4_1) then
		self:updateLayer()

		return true
	end

	return false
end

function FormationMainLayer:checkAutoFight()
	if not self.isAuto then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false) then
		global_count_down_layer(4, function()
			self:sureButtonCallBack()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)
		end)
	end
end

function FormationMainLayer.onEnter(arg_8_0)
	FormationMainLayer.super.onEnter(arg_8_0)
end

function FormationMainLayer.onExit(arg_9_0)
	FormationMainLayer.super.onExit(arg_9_0)
	require("controller.array_manager"):executeHangupArrayChange()
end

function FormationMainLayer:sureButtonCallBack()
	local array_manager = require("controller.array_manager")
	local patrol_manager = require("controller.patrol_manager")
	local alert_manager = require("controller.alert_manager")
	local audio_manager = require("controller.audio_manager")

	if self.configType == CONFIG_TYPE_REFIGHT then
		local var_10_4, var_10_5 = array_manager:setRefightArray(self.curFormationIndex)

		if var_10_4 then
			if self.configCallback then
				self.configCallback(self.curFormationIndex)
			end

			array_manager:executeHangupArrayChange()
			self:closeAction()
		elseif var_10_5 == 0 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[0], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif var_10_5 == 1 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[1], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif var_10_5 == 2 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[2])
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	else
		array_manager:setHangupArray(self.configMode, self.curFormationIndex, function(arg_11_0)
			if arg_11_0 == 1 then
				if self.configCallback then
					self.configCallback(self.curFormationIndex)
				end

				array_manager:executeHangupArrayChange()
				self:closeAction()
			elseif arg_11_0 == 2 then
				global_ShowBlockWords(L_TEAM_Array_WARNING.Type_HangUp[2], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_11_0 == 3 then
				global_ShowBlockWords(L_TEAM_Array_WARNING.Type_HangUp[3], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end
end

function FormationMainLayer.isCanExtendFormation(arg_12_0)
	return #(require("model.playermodel").arrays or {}) < MAX_ARRAY_COUNT
end

function FormationMainLayer.extendArrayCallBack(arg_13_0)
	L_TEAM_TIPS.Expansion_Labels.titleNewImage = "public/title/title_add_teams.png"

	LayerManager:pushInLayer("PopDoLayer", {
		cost = 100,
		costtype = "diamond",
		labels = L_TEAM_TIPS.Expansion_Labels,
		own = require("model.playermodel").diamond,
		surecallback = function()
			arg_13_0.manager:requestExtendArray()
		end
	})
end

function FormationMainLayer:getSureBtnTextInfo()
	local var_15_0 = {}

	var_15_0.strSize = 30
	var_15_0.configTextureType = var_0_1
	var_15_0.strFont = FONT_BUTTON
	var_15_0.str = ""
	var_15_0.str = self.repeatChallenge and L_FORMATIONMAINLAYER[1] or L_FORMATIONMAINLAYER[2]

	if self.curFormationIndex == require("model.playermodel").curArray and not self.bChange and not self.repeatChallenge then
		var_15_0.path = "public/button/public_button_gray_long.png"
		var_15_0.strColor = "242C3A"
	else
		var_15_0.path = "public/button/public_button_orange_long.png"
		var_15_0.strColor = "242C3A"
	end

	return var_15_0
end

function FormationMainLayer:getSureBtnExtendTextInfo()
	local var_16_0 = {}

	var_16_0.strColor = "FFD102"
	var_16_0.strSize = 24
	var_16_0.strFont = FONT_BUTTON
	var_16_0.visible = true

	if self.repeatChallenge then
		var_16_0.visible = false
	end

	var_16_0.str = self.curFormationIndex == require("model.playermodel").curArray and L_FORMATIONMAINLAYER[3] or L_FORMATIONMAINLAYER[4]

	return var_16_0
end

function FormationMainLayer:updateGirlSuccess(arg_17_1)
	FormationMainLayer.super.updateGirlSuccess(self, arg_17_1)
	self:updateSureBtnInfo()
end

function FormationMainLayer.selectHorcrux(arg_18_0, arg_18_1)
	FormationMainLayer.super.selectHorcrux(arg_18_0, arg_18_1)

	arg_18_0.bChange = true
end

function FormationMainLayer.getHorcruxSpriteType(arg_19_0)
	return "arrayMemberMainStyle"
end

function FormationMainLayer:getSelectGirlConfig(arg_20_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		formationIndex = self.curFormationIndex,
		sureCallBack = function(arg_21_0)
			return
		end
	}
end

function FormationMainLayer:selectGirl(arg_22_1)
	if self:selectGirlConditionScreening(arg_22_1, {
		bAutoTips = true
	}) then
		local var_22_0 = self:getFormationInfo()

		if var_22_0 and var_22_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_22_1)))

			self.bChange = true
		end
	end
end

function FormationMainLayer.isShowHelpBattle(arg_23_0)
	return true
end

function FormationMainLayer.isShowAutoHelpBattleBtn(arg_24_0)
	return true
end

return FormationMainLayer
