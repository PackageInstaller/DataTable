return {
	UpdateUI = function()
		return
	end,
	MapExtension = function()
		manager.notify:CallUpdateFunc(CIVILIZATION_MAP_EXTENSION)
	end,
	OpenChooseSkill = function(arg_3_0)
		JumpTools.OpenPageByJump("civilizationGameChooseSkillView", {
			chooseType = CivilizationGameConst.techType.TECH,
			idList = arg_3_0
		})
	end,
	OpenChooseHex = function(arg_4_0, arg_4_1)
		JumpTools.OpenPageByJump("civilizationGameChooseSkillView", {
			chooseType = CivilizationGameConst.techType.HEX,
			idList = arg_4_0,
			index = arg_4_1
		})
	end,
	OpenHeroPop = function(arg_5_0)
		JumpTools.OpenPageByJump("civilizationGameChooseSkillView", {
			heroID = arg_5_0
		})
	end,
	OpenStagePop = function(arg_6_0, arg_6_1)
		manager.notify:CallUpdateFunc(CIVILIZATION_AGE_CHANGE, arg_6_0, arg_6_1)
	end,
	GameOver = function(arg_7_0, arg_7_1)
		CivilizationGameAction.GameOver(arg_7_0, arg_7_1)
	end,
	ClickSkill = function(arg_8_0, arg_8_1)
		manager.notify:CallUpdateFunc(CIVILIZATION_ON_CLICK_SKILL, arg_8_0, arg_8_1)
	end,
	ShowFoodShort = function(arg_9_0)
		manager.notify:CallUpdateFunc(CIVILIZATION_SHOW_FOOD_SHORTAGE, arg_9_0)
	end,
	ChangeControllerState = function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_10_0:GetComponent("ControllerExCollection"):GetController(arg_10_1)

		if var_10_0 then
			var_10_0:SetSelectedState(arg_10_2)
		end
	end
}
