local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareExploreStageItem = class("FogNightmareExploreStageItem", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreStageItem"))

function FogNightmareExploreStageItem:ctor()
	self._spine = nil
	self._stageStruct = nil
end

function FogNightmareExploreStageItem:getStageBgRes(arg_2_1)
	local var_2_0 = {}

	if arg_2_1 == 1 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_2_1"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_1_1"
	elseif arg_2_1 == 2 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_2_2"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_1_2"
	elseif arg_2_1 == 3 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_3"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_3"
	elseif arg_2_1 == 4 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_2_4"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_1_4"
	elseif arg_2_1 == 5 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_2_5"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_1_5"
	elseif arg_2_1 == 6 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_2_6"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_1_6"
	elseif arg_2_1 == 7 then
		var_2_0[1] = "ui://fogNightmare/pic_gqxz_2_7"
		var_2_0[2] = "ui://fogNightmare/pic_gqxz_1_7"
	end

	return var_2_0
end

function FogNightmareExploreStageItem:getStageEffectName(arg_3_1)
	local var_3_0 = ""

	if var_0_1.WAVE_EFFECT_TYPE.MONSTER_NORMAL == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelPutong"
	elseif var_0_1.WAVE_EFFECT_TYPE.MONSTER_HARD == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelKunnan"
	elseif var_0_1.WAVE_EFFECT_TYPE.MONSTER_BOSS == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelBoss"
	elseif var_0_1.WAVE_EFFECT_TYPE.EFFECT_RECOVER == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelHuixue"
	elseif var_0_1.WAVE_EFFECT_TYPE.EFFECT_REVIVAL == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelFuhuo"
	elseif var_0_1.WAVE_EFFECT_TYPE.EFFECT_CHOICE == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelJueze"
	elseif var_0_1.WAVE_EFFECT_TYPE.EFFECT_SACRIFICE == arg_3_1 then
		var_3_0 = "eff_ui_fogNightmare_levelDemon"
	end

	return var_3_0
end

function FogNightmareExploreStageItem:updateItem(arg_4_1, arg_4_2, arg_4_3)
	self._stageStruct = arg_4_1
	self._id = arg_4_1:getStageId()

	local var_4_0 = arg_4_1:getAllWave()[1]
	local var_4_1 = var_4_0:getCfg()

	self.m_nameText:setText(var_4_0:getWaveName())
	self.m_powerText:setText(var_4_1.power)

	local var_4_2 = var_4_1.type

	self.m_centerIconLoader:setURL("ui://fogNightmare/icon_gqxz_" .. var_4_1.type)
	self.m_nameBgLoader:setURL("ui://fogNightmare/pic_gqxz_guang_" .. var_4_2)

	if var_4_2 == 3 then
		self.m_maskLoader:setURL("ui://fogNightmare/pic_gqxz_zhezhao5")
	elseif arg_4_2 then
		self.m_maskLoader:setURL("ui://fogNightmare/pic_gqxz_zhezhao1")
	else
		self.m_maskLoader:setURL("ui://fogNightmare/pic_gqxz_zhezhao2")
	end

	local var_4_3 = self:getStageBgRes(var_4_2)

	if arg_4_2 then
		self.m_bgLoader:setURL(var_4_3[1])
	else
		self.m_bgLoader:setURL(var_4_3[2])
	end

	local var_4_4 = self:getStageEffectName(var_4_2)

	if self._spine then
		self._spine:dispose()

		self._spine = nil
	end

	if var_4_4 ~= "" then
		self._spine = self.m_effectNode:addEffectSpine({
			anim = "play",
			isLoop = true,
			name = var_4_4
		})
	end

	local var_4_5 = var_0_1.WAVE_EFFECT_TYPE

	self.m_powerGroup:setVisible(var_4_2 <= var_0_1.WAVE_EFFECT_TYPE.MONSTER_BOSS)
	self:_setLock(arg_4_3)
	self.m_isBossController:setSelectedIndex(var_4_2 == var_4_5.MONSTER_BOSS and 1 or 0)
end

function FogNightmareExploreStageItem:setGrayed(arg_5_1)
	self.m_centerIconLoader:setGrayed(arg_5_1)
	self.m_nameBgLoader:setGrayed(arg_5_1)
	self.m_isShowMaskController:setSelectedIndex(arg_5_1 and 1 or 0)

	if arg_5_1 then
		self.m_maskTransition:play()
	end
end

function FogNightmareExploreStageItem:_setLock(arg_6_1)
	self.m_centerIconLoader:setGrayed(arg_6_1)
	self.m_nameBgLoader:setGrayed(arg_6_1)
	self.m_isShowMaskController:setSelectedIndex(arg_6_1 and 1 or 0)
end

function FogNightmareExploreStageItem:playUpAction()
	self.m_upTransition:play()
end

function FogNightmareExploreStageItem:playDownAction()
	self.m_downTransition:play()
end

return FogNightmareExploreStageItem
