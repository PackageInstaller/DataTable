local AncientsBattlePetCurtainComp = class("AncientsBattlePetCurtainComp", require("app.fairyGUI.ancients.UI_AncientsBattlePetCurtainComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateView(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.m_mask_loader:setSize(display.width, display.height)

	local var_2_0 = g.core.model.User.ancientsData
	local var_2_1 = 2

	if arg_2_2 < arg_2_1 then
		var_2_1 = 1
	elseif arg_2_1 == arg_2_2 then
		var_2_1 = 3
	end

	local var_2_2 = {
		state = 0,
		petId = var_2_0:getTeamPetId(var_0_2.GET_TEAM_TYPE.CUSTOM_TEAM, arg_2_3)
	}

	var_2_2.fightValue = arg_2_3.pet_fight_value or 0

	self.m_Left_comp:updateView(var_2_2)

	local var_2_3 = {
		state = 0,
		petId = var_2_0:getTeamPetId(var_0_2.GET_TEAM_TYPE.CUSTOM_TEAM, arg_2_4)
	}

	var_2_3.fightValue = arg_2_4.pet_fight_value or 0

	self.m_Right_comp:updateView(var_2_3)

	local var_2_4 = {
		petId = var_2_0:getTeamPetId(var_0_2.GET_TEAM_TYPE.CUSTOM_TEAM, arg_2_3)
	}

	var_2_4.fightValue = arg_2_3.pet_fight_value or 0
	var_2_4.state = var_2_1

	self.m_Result_comp:updateView(var_2_4)
end

function var_0_0:playStartEff()
	self.m_Effstart_comp:addEffectSpine({
		anim = "play",
		name = "eff_ui_ancientsBattle_petCurtain",
		remove = true,
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Battle_01)
end

function var_0_0:playVsEff()
	self.m_VSEff_comp:addEffectSpine({
		anim = "play",
		name = "eff_ui_ancientsBattle_petVS",
		remove = true,
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Battle_02)
end

function var_0_0:playResultEff(arg_5_1)
	self.m_Effplay_comp:addEffectSpine({
		anim = "play",
		remove = true,
		isLoop = false,
		name = arg_5_1
	})
end

return var_0_0
