local Formation3V3SettingLayer = class("Formation3V3SettingLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function Formation3V3SettingLayer:ctor()
	Formation3V3SettingLayer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.configType = CONFIG_TYPE_TVT_ATTACK_FORM
	self.selectGirlType = SELECT_GIRL_TVT_ATTACK
	self.selectHorcruxType = SELECT_HORCRUX_TVT_ATTACK
	self.bInit = true
end

function Formation3V3SettingLayer:initManager()
	self.manager = require("controller.formation.formation_3v3_setting_manager"):getInstance()
end

function Formation3V3SettingLayer:create(arg_3_1)
	local var_3_0 = Formation3V3SettingLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function Formation3V3SettingLayer:init(arg_4_1)
	if Formation3V3SettingLayer.super.init(self, arg_4_1) then
		self:updateLayer()

		return true
	end

	return false
end

function Formation3V3SettingLayer:onEnter()
	Formation3V3SettingLayer.super.onEnter(self)
end

function Formation3V3SettingLayer:onExit()
	Formation3V3SettingLayer.super.onExit(self)
end

function Formation3V3SettingLayer:sureButtonCallBack()
	local var_7_0 = self.manager:getFormationInfo()
	local arenatft_manager = require("controller.arenatft_manager")

	for iter_7_0 = 1, #var_7_0 do
		local var_7_2 = iter_7_0

		for iter_7_1, iter_7_2 in pairs(var_7_0[iter_7_0]) do
			if iter_7_2.fight_girl then
				var_7_2 = false

				break
			end
		end

		if var_7_2 ~= false then
			global_ShowBlockWords(string.format(L_TVT_DEFENCE_ARRAY_NIL, var_7_2))

			return
		end
	end

	if self.configCallback then
		self.configCallback()
	end

	require("controller.array_manager"):executeHangupArrayChange()
	self:closeAction()
end

return Formation3V3SettingLayer
