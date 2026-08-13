class = var_0_10000

local var_0_0 = "PublicGuildTechnologyCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..cards.GuildTechnologyCard"))

function var_0_1.Update(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.group.id
	local var_1_1 = arg_1_1.group
	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.getConfig(var_1_2, "name")

	arg_1_0.titleImg.text = var_1_3

	local var_1_4 = arg_1_0.iconImag

	GetSpriteFromAtlas = var_1_2
	var_1_4.sprite = var_1_2("GuildTechnology", var_1_0)

	local var_1_5 = arg_1_1:GetMaxLevel()
	local var_1_6 = arg_1_1:GetLevel()

	if arg_1_1:IsGuildMember() then
		arg_1_0.levelTxt.text = "Lv." .. var_1_6
	else
		arg_1_0.levelTxt.text = "Lv." .. var_1_6 .. "/" .. var_1_5
	end

	local var_1_7 = arg_1_0.descTxt

	var_1_7.text = arg_1_1:GetDesc()
	setActive = var_1_7

	var_1_7(arg_1_0.maxTF, var_1_5 <= var_1_6)

	setActive = var_1_7

	var_1_7(arg_1_0.upgradeTF, var_1_6 < var_1_5)

	local var_1_8 = true

	removeOnButton = var_1_9

	var_1_9(arg_1_0._tf)

	local var_1_9, var_1_10

	if var_1_6 < var_1_5 then
		var_1_9, var_1_10 = arg_1_1:GetConsume()
		arg_1_0.guildResTxt.text = var_1_9

		local var_1_11 = arg_1_0.goldResTxt

		var_1_11.text = var_1_10
		onButton = var_1_11

		local var_1_12 = arg_1_0
		local var_1_13 = arg_1_0._tf

		local function var_1_14()
			if var_1_6 >= var_1_5 then
				return
			end

			pg = var_0

			local var_2_0 = var_0.MsgboxMgr.GetInstance()
			local var_2_1 = var_0.ShowMsgBox
			local var_2_2 = {}

			i18n = var_2_10004
			var_2_2.content = var_2_10004("guild_tech_consume_tip", var_1_9, var_1_10, var_1_3)

			function var_2_2.onYes()
				local var_3_0 = arg_1_0.view
				local var_3_1 = var_0.emit

				PublicGuildMainMediator = var_3_10003

				var_3_1(var_3_0, var_3_10003.UPGRADE_TECH, var_1_0)

				return
			end

			var_2_1(var_2_0, var_2_2)

			return
		end

		SFX_PANEL = var_1_10015

		var_1_11(var_1_12, var_1_13, var_1_14, var_1_10015)
	end

	setActive = var_1_9

	var_1_9(arg_1_0.guildRes, var_1_8)

	setActive = var_1_9

	var_1_9(arg_1_0.goldRes, var_1_8)

	setActive = var_1_9

	var_1_9(arg_1_0.upgradeBtn, var_1_8)

	setActive = var_1_9

	var_1_9(arg_1_0.livnessTF, not var_1_8)

	local var_1_15 = true

	setActive = var_1_10

	var_1_10(arg_1_0.breakoutSlider.gameObject, var_1_15)

	if var_1_15 then
		local var_1_16 = var_1_1:GetTargetProgress()
		local var_1_17 = var_1_1:GetProgress()

		arg_1_0.breakoutSlider.value = var_1_17 / var_1_16
		arg_1_0.breakoutTxt.text = var_1_17 .. "/" .. var_1_16
	end

	return
end

return var_0_1
