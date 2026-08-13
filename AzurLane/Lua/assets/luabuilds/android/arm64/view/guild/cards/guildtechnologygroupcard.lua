class = var_0_10000

local var_0_0 = "GuildTechnologyGroupCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildTechnologyCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_0.breakoutTF

	arg_1_0.devBtn = var_3.Find(var_1_0, "dev_btn")

	local var_1_1 = arg_1_0.breakoutTF

	arg_1_0.cancelBtn = var_3.Find(var_1_1, "cancel_btn")

	local var_1_2 = arg_1_0.devBtn
	local var_1_3 = var_3.Find(var_1_2, "Text")
	local var_1_4 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.devBtnTxt = var_1_4(var_1_3, var_6(var_1_10008))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1.id

	arg_2_0.titleImg.text = arg_2_1:getConfig("name")

	local var_2_1 = arg_2_0.iconImag

	GetSpriteFromAtlas = var_6
	var_2_1.sprite = var_6("GuildTechnology", var_2_0)
	arg_2_0.descTxt.text = arg_2_1:GetDesc()

	local var_2_2 = arg_2_1:GetMaxLevel()
	local var_2_3 = arg_2_1
	local var_2_4 = arg_2_1.GetLevel(var_2_3)
	local var_2_5 = arg_2_1
	local var_2_6 = arg_2_1.GetState(var_2_5)

	setActive = var_2_3

	var_2_3(arg_2_0.maxTF, var_2_2 <= var_2_4)

	setActive = var_2_3

	var_2_3(arg_2_0.breakoutTF, var_2_4 < var_2_2)

	setActive = var_2_3

	local var_2_7 = arg_2_0.devBtn

	GuildTechnologyGroup = var_11

	var_2_3(var_2_7, var_2_6 == var_11.STATE_STOP and var_2_4 < var_2_2)

	setActive = var_2_3

	local var_2_8 = arg_2_0.breakoutSlider.gameObject

	GuildTechnologyGroup = var_11

	var_2_3(var_2_8, var_2_6 == var_11.STATE_START)

	setActive = var_2_3

	var_2_3(arg_2_0.cancelBtn, false)

	if var_2_4 < var_2_2 then
		onButton = var_2_3

		local var_2_9 = arg_2_0
		local var_2_10 = arg_2_0._tf

		local function var_2_11()
			local var_3_1

			if not arg_2_3 then
				pg = var_3_1

				local var_3_0 = var_3_1.TipsMgr.GetInstance()

				var_3_1 = var_3_1.ShowTips
				i18n = var_2_10003

				var_3_1(var_3_0, var_2_10003("guild_tech_non_admin"))

				return
			end

			pg = var_3_1

			local var_3_2 = var_3_1.MsgboxMgr.GetInstance()
			local var_3_3 = var_0.ShowMsgBox
			local var_3_4 = {}

			i18n = var_2_10004

			local var_3_5 = "guild_start_tech_group_tip"
			local var_3_6 = arg_2_1

			var_3_4.content = var_2_10004(var_3_5, var_7.getConfig(var_3_6, "name"))

			function var_3_4.onYes()
				local var_4_0 = arg_2_0.view
				local var_4_1 = var_0.emit

				GuildTechnologyMediator = var_3_10003

				var_4_1(var_4_0, var_3_10003.ON_START, var_2_0)

				return
			end

			var_3_3(var_3_2, var_3_4)

			return
		end

		SFX_PANEL = var_1_10013

		var_2_3(var_2_9, var_2_10, var_2_11, var_1_10013)

		var_2_3 = arg_2_0.levelTxt
		var_2_3.text = "Lv." .. var_2_4 .. "/" .. var_2_2
	else
		var_2_3 = arg_2_0.levelTxt
		var_2_3.text = "Lv." .. var_2_2 .. "/" .. var_2_2
	end

	GuildTechnologyGroup = var_2_3

	local var_2_12

	if var_2_6 == var_2_3.STATE_START then
		var_2_12 = arg_2_1:GetTargetProgress()
		var_2_5 = arg_2_1:GetProgress()
		arg_2_0.breakoutSlider.value = var_2_5 / var_2_12
		arg_2_0.breakoutTxt.text = var_2_5 .. "/" .. var_2_12
	end

	onButton = var_2_12

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.cancelBtn

	local function var_2_15()
		local var_5_1

		if not arg_2_3 then
			pg = var_5_1

			local var_5_0 = var_5_1.TipsMgr.GetInstance()

			var_5_1 = var_5_1.ShowTips
			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("guild_tech_non_admin"))

			return
		end

		pg = var_5_1

		local var_5_2 = var_5_1.MsgboxMgr.GetInstance()
		local var_5_3 = var_0.ShowMsgBox
		local var_5_4 = {}

		i18n = var_2_10004

		local var_5_5 = "guild_cancel_tech_tip"
		local var_5_6 = arg_2_1

		var_5_4.content = var_2_10004(var_5_5, var_7.getConfig(var_5_6, "name"))

		function var_5_4.onYes()
			local var_6_0 = arg_2_0.view
			local var_6_1 = var_0.emit

			GuildTechnologyMediator = var_3_10003

			var_6_1(var_6_0, var_3_10003.ON_CANCEL_TECH, var_2_0)

			return
		end

		var_5_3(var_5_2, var_5_4)

		return
	end

	SFX_PANEL = var_1_10013

	var_2_12(var_2_13, var_2_14, var_2_15, var_1_10013)

	local var_2_16 = arg_2_0.devBtnTxt

	i18n = var_2_5
	var_2_16.text = var_2_5("guild_tech_donate_target", arg_2_1:GetTargetProgress())

	return
end

return var_0_1
