class = var_0_10000

local var_0_0 = var_0_10000("GuildTechnologyCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_2
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	tf = var_3
	arg_1_0._tf = var_3(arg_1_1)

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "title")
	local var_1_2 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.titleImg = var_1_2(var_1_1, var_6(var_1_10008))

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_3.Find(var_1_3, "icon")
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.iconImag = var_1_5(var_1_4, var_6(var_1_10008))

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "level")
	local var_1_8 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.levelTxt = var_1_8(var_1_7, var_6(var_1_10008))

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_3.Find(var_1_9, "desc")
	local var_1_11 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.descTxt = var_1_11(var_1_10, var_6(var_1_10008))

	local var_1_12 = arg_1_0._tf

	arg_1_0.upgradeTF = var_3.Find(var_1_12, "upgrade")

	local var_1_13 = arg_1_0.upgradeTF

	arg_1_0.guildRes = var_3.Find(var_1_13, "cion")

	local var_1_14 = arg_1_0.upgradeTF
	local var_1_15 = var_3.Find(var_1_14, "cion/Text")
	local var_1_16 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.guildResTxt = var_1_16(var_1_15, var_6(var_1_10008))

	local var_1_17 = arg_1_0.upgradeTF

	arg_1_0.goldRes = var_3.Find(var_1_17, "gold")

	local var_1_18 = arg_1_0.upgradeTF
	local var_1_19 = var_3.Find(var_1_18, "gold/Text")
	local var_1_20 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.goldResTxt = var_1_20(var_1_19, var_6(var_1_10008))

	local var_1_21 = arg_1_0.upgradeTF

	arg_1_0.upgradeBtn = var_3.Find(var_1_21, "upgrade_btn")

	local var_1_22 = arg_1_0._tf

	arg_1_0.maxTF = var_3.Find(var_1_22, "max")

	local var_1_23 = arg_1_0._tf

	arg_1_0.breakoutTF = var_3.Find(var_1_23, "breakout")

	local var_1_24 = arg_1_0._tf
	local var_1_25 = var_3.Find(var_1_24, "progress")
	local var_1_26 = var_3.GetComponent

	typeof = var_6
	Slider = var_1_10008
	arg_1_0.breakoutSlider = var_1_26(var_1_25, var_6(var_1_10008))

	local var_1_27 = arg_1_0._tf
	local var_1_28 = var_3.Find(var_1_27, "progress/Text")
	local var_1_29 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.breakoutTxt = var_1_29(var_1_28, var_6(var_1_10008))

	local var_1_30 = arg_1_0.upgradeTF

	arg_1_0.livnessTF = var_3.Find(var_1_30, "livness")
	setActive = var_3

	var_3(arg_1_0.breakoutSlider.gameObject, false)

	setActive = var_3

	var_3(arg_1_0.upgradeTF, false)

	setActive = var_3

	var_3(arg_1_0.maxTF, false)

	setActive = var_3

	var_3(arg_1_0.breakoutTF, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.group.id
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.getConfig(var_2_1, "name")

	arg_2_0.titleImg.text = var_2_2

	local var_2_3 = arg_2_0.iconImag

	GetSpriteFromAtlas = var_2_1
	var_2_3.sprite = var_2_1("GuildTechnology", var_2_0)

	local var_2_4 = arg_2_1:GetMaxLevel()
	local var_2_5 = arg_2_1
	local var_2_6 = arg_2_1.GetLevel(var_2_5)
	local var_2_7 = arg_2_1.group
	local var_2_8 = var_7.GetFakeLevel(var_2_7)

	math = var_2_5

	local var_2_9 = var_2_5.max(var_2_4, var_2_8)
	local var_2_10

	if arg_2_1:IsGuildMember() then
		var_2_10 = arg_2_0.levelTxt
		var_2_10.text = "Lv." .. var_2_6
	else
		string = var_2_10

		local var_2_11 = var_2_10.format
		local var_2_12 = " [%s+%s]"
		local var_2_13 = var_2_4

		math = var_1_10013

		local var_2_14 = var_2_11(var_2_12, var_2_13, var_1_10013.max(0, var_2_8 - var_2_4))

		arg_2_0.levelTxt.text = "Lv." .. var_2_6 .. "/" .. var_2_9 .. var_2_14
	end

	local var_2_15 = arg_2_0.descTxt

	var_2_15.text = arg_2_1:GetDesc()
	setActive = var_2_15

	var_2_15(arg_2_0.maxTF, var_2_9 <= var_2_6)

	setActive = var_2_15

	var_2_15(arg_2_0.upgradeTF, var_2_6 < var_2_9)

	local var_2_16 = arg_2_1
	local var_2_17 = arg_2_1._ReachTargetLiveness_(var_2_16)
	local var_2_18 = arg_2_1
	local var_2_19 = arg_2_1.CanUpgrade(var_2_18)

	removeOnButton = var_2_16

	var_2_16(arg_2_0._tf)

	if var_2_19 then
		var_2_17 = true
		var_2_16, var_2_18 = arg_2_1:GetConsume()
		arg_2_0.guildResTxt.text = var_2_16

		local var_2_20 = arg_2_0.goldResTxt

		var_2_20.text = var_2_18
		onButton = var_2_20

		local var_2_21 = arg_2_0
		local var_2_22 = arg_2_0._tf

		local function var_2_23()
			if var_2_6 >= var_2_9 then
				return
			end

			local var_3_0 = arg_2_0

			var_0.DoUprade(var_3_0, arg_2_1)

			return
		end

		SFX_PANEL = var_1_10018

		var_2_20(var_2_21, var_2_22, var_2_23, var_1_10018)
	elseif not var_2_17 then
		setText = var_2_16

		local var_2_24 = arg_2_0.livnessTF

		i18n = var_1_10014

		var_2_16(var_2_24, var_1_10014("guild_tech_livness_no_enough_label", arg_2_1:GetTargetLivness()))
	end

	setActive = var_2_16

	var_2_16(arg_2_0.guildRes, var_2_17)

	setActive = var_2_16

	var_2_16(arg_2_0.goldRes, var_2_17)

	setActive = var_2_16

	var_2_16(arg_2_0.upgradeBtn, var_2_17)

	setActive = var_2_16

	var_2_16(arg_2_0.livnessTF, not var_2_17)

	local var_2_25 = arg_2_2 and arg_2_2.id == var_2_0

	setActive = var_2_18

	var_2_18(arg_2_0.breakoutSlider.gameObject, var_2_25)

	if var_2_25 then
		local var_2_26 = arg_2_2:GetTargetProgress()
		local var_2_27 = arg_2_2:GetProgress()

		arg_2_0.breakoutSlider.value = var_2_27 / var_2_26
		arg_2_0.breakoutTxt.text = var_2_27 .. "/" .. var_2_26
	end

	return
end

function var_0_0.DoUprade(arg_4_0, arg_4_1)
	local function var_4_0()
		local var_5_0 = arg_4_1
		local var_5_1 = var_0.getConfig(var_5_0, "name")
		local var_5_2 = arg_4_1
		local var_5_3, var_5_4 = var_1.GetConsume(var_5_2)

		pg = var_5_2

		local var_5_5 = var_5_2.MsgboxMgr.GetInstance()
		local var_5_6 = var_3.ShowMsgBox
		local var_5_7 = {}

		i18n = var_2_10007
		var_5_7.content = var_2_10007("guild_tech_consume_tip", var_5_3, var_5_4, var_5_1)

		function var_5_7.onYes()
			local var_6_0 = arg_4_0.view
			local var_6_1 = var_0.emit

			GuildTechnologyMediator = var_3_10003

			var_6_1(var_6_0, var_3_10003.ON_UPGRADE, arg_4_1.group.id)

			return
		end

		var_5_6(var_5_5, var_5_7)

		return
	end

	local function var_4_1(arg_7_0)
		local var_7_0 = arg_4_1

		if var_1.IsRiseInPrice(var_7_0) then
			local var_7_1 = arg_4_1
			local var_7_2, var_7_3, var_7_4 = var_1.CanUpgradeBySelf(var_7_1)

			i18n = var_2_10004

			local var_7_5 = var_2_10004("guild_tech_price_inc_tip")

			if var_7_4 and not var_7_3 then
				local var_7_6 = arg_4_1

				var_2_10005 = var_2_10005.GetLivenessOffset(var_7_6)
				i18n = var_6
				var_7_5 = var_6("guild_tech_livness_no_enough", var_2_10005)
			end

			pg = var_2_10005

			local var_7_7 = var_2_10005.MsgboxMgr.GetInstance()

			var_5.ShowMsgBox(var_7_7, {
				content = var_7_5,
				onYes = arg_7_0
			})
		else
			arg_7_0()
		end

		return
	end

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_8_0)
			var_4_1(arg_8_0)

			return
		end,
		function(arg_9_0)
			var_4_0()

			return
		end
	})

	return
end

function var_0_0.Destroy(arg_10_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_10_0)

	return
end

return var_0_0
