local FormationElementsLayer = class("FormationElementsLayer", (require("view.Layer.Formation.FormationModeLayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = config._DEBUG and 0 or 1
local level_manager = require("controller.level_manager")

function FormationElementsLayer:ctor()
	FormationElementsLayer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.selectGirlType = SELECT_GIRL_FIGHT_ELEMENTS
	self.selectHorcruxType = SELECT_HORCRUX_FIGHT_ELEMENTS
	self.configType = CONFIG_TYPE_MODE
end

function FormationElementsLayer:initManager()
	self.manager = require("controller.formation.formation_mode_manager"):getInstance()
end

function FormationElementsLayer:create(arg_3_1)
	local var_3_0 = FormationElementsLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationElementsLayer:init(arg_4_1)
	if FormationElementsLayer.super.init(self, arg_4_1) then
		self.configCallback = arg_4_1.configcallback

		return true
	end

	return false
end

function FormationElementsLayer:onEnter()
	FormationElementsLayer.super.onEnter(self)

	local levelmode_data = require("data.levelmode_data")
	local var_5_1 = global_get_levelmode_ele_type(self.mode) or "all"

	if not RoleDefault:getInstance():getBoolForKey("AdventureTowerArray" .. self.mode, false) and self:getAutoFormationCallBack()({
		type = var_5_1
	}) then
		RoleDefault:getInstance():setBoolForKey("AdventureTowerArray" .. self.mode, true)
	end
end

function FormationElementsLayer:initLayer()
	FormationElementsLayer.super.initLayer(self)
	self:checkAutoFight()
	self:checkWeeklyAutoFight()
end

function FormationElementsLayer:executeHangupArrayChange()
	FightManager.registerPlayerReplace()
	AlertManager:check_servant_strenghth()
	AlertManager:check_horcrux_strenghth()
	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
end

function FormationElementsLayer:sureButtonCallBack()
	local var_8_0, var_8_1 = self.manager:checkAdventureArray()

	if var_8_0 then
		self:executeHangupArrayChange()

		if self.configCallback and self.manager:checkIsSameColorTeam(self.mode) then
			self.configCallback(1)
		end
	elseif var_8_1 == 0 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[0], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	elseif var_8_1 == 1 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	end
end

local function var_0_5(arg_9_0)
	return ({
		[81421] = true,
		[572] = true,
		[89021] = true,
		[77921] = true,
		[83221] = true,
		[582] = true,
		[562] = true,
		[80921] = true,
		[74221] = true,
		[1042] = true,
		[79821] = true,
		[552] = true,
		[1041] = true,
		[76321] = true,
		[86721] = true,
		[87921] = true,
		[542] = true,
		[84221] = true,
		[79021] = true,
		[88621] = true,
		[81921] = true,
		[532] = true,
		[84921] = true,
		[522] = true,
		[75921] = true,
		[512] = true,
		[88221] = true,
		[85421] = true,
		[1043] = true,
		[87521] = true,
		[501] = true,
		[75021] = true,
		[79421] = true,
		[77121] = true,
		[85921] = true,
		[82721] = true,
		[83621] = true,
		[86221] = true,
		[85721] = true,
		[82521] = true
	})[arg_9_0]
end

function FormationElementsLayer:checkAutoFight()
	if not var_0_5(self.mode) then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("AdventureTowerAutoFight", false) then
		global_count_down_layer(4, function()
			self:sureButtonCallBack()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("adv_tower_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("AdventureTowerAutoFight", false)
		end)
	end
end

function FormationElementsLayer:checkWeeklyAutoFight()
	if require("controller.weekly_tower_manager").getInstance():isWeeklyTowerModetpye(require("data.levelmode_data")[self.mode].modetype) == false then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("WeeklyAutoFight", false) then
		global_count_down_layer(4, function()
			self:sureButtonCallBack()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_weekly_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("WeeklyAutoFight", false)
		end)
	end
end

function FormationElementsLayer:getSelectGirlConfig(arg_16_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.manager._mode,
		sureCallBack = function(arg_17_0)
			return
		end
	}
end

function FormationElementsLayer:selectGirl(arg_18_1)
	if self:selectGirlConditionScreening(arg_18_1, {
		bAutoTips = true
	}) then
		local var_18_0 = self:getFormationInfo()

		if var_18_0 and var_18_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_18_1)))
		end
	end
end

function FormationElementsLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationElementsLayer:isShowHelpBattle()
	return true
end

function FormationElementsLayer:createElementsIcon(arg_21_1, arg_21_2)
	if not arg_21_1 or not arg_21_2 then
		return
	end

	self.super.updateElementsIcon()

	local var_21_0 = arg_21_1:getName("drop_up_icon")

	if not var_21_0 then
		var_21_0 = ccui.ImageView:create("weeklytower/reward_up_icon.png", var_0_2)

		var_21_0:setAnchorPoint(0, 1)
		var_21_0:setPosition(-10, arg_21_1:getContentSize().height)
		arg_21_1:addChild(var_21_0, 100)
		var_21_0:setName("drop_up_icon")
	end

	var_21_0:setVisible(false)

	local var_21_1 = level_manager:getDropUpServants(self.mode)

	if not var_21_1 then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		if arg_21_2 == iter_21_1 then
			var_21_0:setVisible(true)

			return
		end
	end
end

function FormationElementsLayer:updateElementsIcon(arg_22_1, arg_22_2)
	if not arg_22_1 or not arg_22_2 then
		return
	end

	self.super.updateElementsIcon()

	local var_22_0 = arg_22_1:getName("drop_up_icon")

	if not var_22_0 then
		var_22_0 = ccui.ImageView:create("weeklytower/reward_up_icon.png", var_0_2)

		var_22_0:setAnchorPoint(0, 1)
		var_22_0:setPosition(-10, arg_22_1:getContentSize().height)
		arg_22_1:addChild(var_22_0, 100)
		var_22_0:setName("drop_up_icon")
	end

	var_22_0:setVisible(false)

	local var_22_1 = level_manager:getDropUpServants(self.mode)

	if not var_22_1 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		if arg_22_2 == iter_22_1 then
			var_22_0:setVisible(true)

			return
		end
	end
end

return FormationElementsLayer
