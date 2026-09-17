local FormationOverclockLayer = class("FormationOverclockLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_4 = L_SUBSTITUTION_ARRAY_LOCK
local var_0_5 = L_SUBSTITUTION_ARRAY_UP

function FormationOverclockLayer:ctor()
	FormationOverclockLayer.super.ctor(self)
	self:setAutoAdapt(true)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = self.manager:getCurFormationIndex()
	self.selectGirlType = SELECT_GIRL_SUBSTITUTION
	self.selectHorcruxType = SELECT_HORCRUX_SUBSTITUTION
	self.configType = CONFIG_TYPE_SUBSTITUTION
end

function FormationOverclockLayer:initManager()
	self.manager = require("controller.formation.formation_overclock_manager"):getInstance()
end

function FormationOverclockLayer:create(arg_3_1)
	local var_3_0 = FormationOverclockLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationOverclockLayer:init(arg_4_1)
	FormationOverclockLayer.super.init(self, arg_4_1)

	arg_4_1 = arg_4_1 or {}
	self.mode = arg_4_1.mode
	self.level = arg_4_1.level
	self.cancelcallback = arg_4_1.cancelcallback

	return true
end

function FormationOverclockLayer:onEnter()
	FormationOverclockLayer.super.onEnter(self)
	self.manager:requestInfo(self.mode)
end

function FormationOverclockLayer:onExit()
	FormationOverclockLayer.super.onExit(self)
end

function FormationOverclockLayer:initListener()
	FormationOverclockLayer.super.initListener(self)
	self._root:_addEvent(function()
		if self.cancelcallback then
			self.cancelcallback()
		end

		self:closeAction()
	end)
end

function FormationOverclockLayer:selectGirl(arg_9_1)
	if self.manager:getScoreData(self.curFormationIndex) then
		global_ShowBlockWords(var_0_4)
	else
		FormationOverclockLayer.super.selectGirl(self, arg_9_1)
	end
end

function FormationOverclockLayer:selectHorcrux(arg_10_1)
	if self.manager:getScoreData(self.curFormationIndex) then
		global_ShowBlockWords(var_0_4)
	else
		FormationOverclockLayer.super.selectHorcrux(self, arg_10_1)
	end
end

function FormationOverclockLayer:sureButtonCallBack()
	if self.manager:getScoreData(self.curFormationIndex) then
		global_ShowBlockWords(var_0_5)
	else
		self.manager:requestChallenge(self.mode, self.level)
	end
end

function FormationOverclockLayer:updateLayer()
	for iter_12_0 = 1, #self:getFormationInfo() do
		if not self.manager:getScoreData(iter_12_0) then
			self.manager:setCurFormationIndex(iter_12_0)

			self.curFormationIndex = self.manager:getCurFormationIndex()

			break
		end
	end

	FormationOverclockLayer.super.updateLayer(self)
end

function FormationOverclockLayer:isShowAutoFormationBtn()
	return false
end

function FormationOverclockLayer:getSureBtnTextInfo()
	local var_14_0 = {}

	if self.manager:getScore(self.curFormationIndex) then
		var_14_0.path = "public/button/public_button_gray_long.png"
		var_14_0.str = L_SUBSTITUTION_ARRAY_UP
	else
		var_14_0.path = "public/button/public_button_orange_long.png"
		var_14_0.str = L_BASE_FORMATION[7]
	end

	var_14_0.configTextureType = var_0_2
	var_14_0.strColor = "242C3A"
	var_14_0.strSize = 30
	var_14_0.strFont = FONT_BUTTON

	return var_14_0
end

function FormationOverclockLayer:getSureBtnExtendTextInfo()
	local var_15_0 = {}
	local var_15_1 = self.manager:getScore(self.curFormationIndex)

	if var_15_1 then
		var_15_0.str = L_TEAM_TIPS.Team .. L_FALLINGLAYER[1] .. ":" .. var_15_1
		var_15_0.visible = true
	else
		var_15_0.str = L_BASE_FORMATION[7]
		var_15_0.visible = false
	end

	var_15_0.strColor = "FFD102"
	var_15_0.strSize = 24
	var_15_0.strFont = FONT_BUTTON

	return var_15_0
end

function FormationOverclockLayer:getSelectGirlConfig(arg_16_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.mode,
		formationIndex = self.curFormationIndex,
		sureCallBack = function(arg_17_0)
			return
		end
	}
end

function FormationOverclockLayer:selectGirl(arg_18_1)
	if self:selectGirlConditionScreening(arg_18_1, {
		bAutoTips = true
	}) then
		local var_18_0 = self:getFormationInfo()

		if var_18_0 and var_18_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_18_1)))
		end
	end
end

function FormationOverclockLayer:isShowHelpBattle()
	return false
end

return FormationOverclockLayer
