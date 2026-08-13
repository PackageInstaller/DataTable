class = var_0_10000

local var_0_0 = "CommanderSkillInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderSkillInfoUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "panel/bg/skill_name")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillNameTxt = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "panel/bg/skill_lv")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillLevelTxt = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "panel/bg/help_panel/skill_intro")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillDescTxt = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0._tf

	arg_2_0.skillIcon = var_1.Find(var_2_10, "panel/bg/skill_icon")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "panel/top/btnBack")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_4.Find(var_3_8, "panel/ok_button")

	local function var_3_10()
		local var_6_0 = arg_3_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_3_8

	var_1_10001(var_3_7, var_3_9, var_3_10, var_3_8)
	arg_3_0:updateSkill()

	return
end

function var_0_1.updateSkill(arg_7_0)
	local var_7_0 = arg_7_0.contextData.skill

	arg_7_0.skillNameTxt.text = var_7_0:getConfig("name")
	arg_7_0.skillLevelTxt.text = "Lv." .. var_7_0:getLevel()

	local var_7_1 = arg_7_0.skillDescTxt

	var_7_1.text = var_7_0:getConfig("desc")
	GetImageSpriteFromAtlasAsync = var_7_1

	var_7_1("CommanderSkillIcon/" .. var_7_0:getConfig("icon"), "", arg_7_0.skillIcon)

	return
end

function var_0_1.close(arg_8_0)
	arg_8_0:emit(var_0_1.ON_CLOSE)

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf)

	return
end

return var_0_1
