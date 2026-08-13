class = var_0_10000

local var_0_0 = "NewGuildMainRedPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewGuildRedUI"
end

function var_0_1.OnLoaded(arg_2_0)
	findTF = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0._tf, "bg/frame/name_bg/input")
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	InputField = var_1_10006
	arg_2_0.nameInput = var_2_1(var_2_0, var_4(var_1_10006))
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._tf, "bg/frame/policy_container/input_frame/input")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	InputField = var_1_10006
	arg_2_0.manifestoInput = var_2_3(var_2_2, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.relaxToggle = var_1(arg_2_0._tf, "bg/frame/policy_container/policy/relax")
	findTF = var_1
	arg_2_0.powerToggle = var_1(arg_2_0._tf, "bg/frame/policy_container/policy/power")
	findTF = var_1
	arg_2_0.cancelBtn = var_1(arg_2_0._tf, "bg/frame/cancel_btn")
	findTF = var_1
	arg_2_0.confirmBtn = var_1(arg_2_0._tf, "bg/frame/confirm_btn")
	findTF = var_1

	local var_2_4 = var_1(arg_2_0._tf, "bg/frame/confirm_btn/print_container/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.costTF = var_2_5(var_2_4, var_4(var_1_10006))

	return
end

function var_0_1.OnInit(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.gameset.create_guild_cost.key_value
	local var_3_1 = arg_3_0.costTF

	var_3_1.text = var_3_0
	onInputChanged = var_3_1

	var_3_1(arg_3_0, arg_3_0.nameInput, function()
		getInputText = var_2_10000

		local var_4_0 = var_2_10000(arg_3_0.nameInput)

		wordVer = var_2_10001

		local var_4_1, var_4_2 = var_2_10001(var_4_0, {
			isReplace = true
		})

		if 0 < var_4_1 then
			setInputText = var_3

			var_3(arg_3_0.nameInput, var_4_2)
		end

		return
	end)

	onInputChanged = var_3_1

	var_3_1(arg_3_0, arg_3_0.manifestoInput, function()
		getInputText = var_2_10000

		local var_5_0 = var_2_10000(arg_3_0.manifestoInput)

		wordVer = var_2_10001

		local var_5_1, var_5_2 = var_2_10001(var_5_0, {
			isReplace = true
		})

		if 0 < var_5_1 then
			setInputText = var_3

			var_3(arg_3_0.manifestoInput, var_5_2)
		end

		return
	end)

	onToggle = var_3_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.relaxToggle

	local function var_3_4(arg_6_0)
		if arg_6_0 then
			GuildConst = var_2_10001

			local var_6_0 = var_2_10001.POLICY_TYPE_RELAXATION
			local var_6_1 = arg_3_0.newGuildVO

			var_2.setPolicy(var_6_1, var_6_0)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3_1(var_3_2, var_3_3, var_3_4, var_1_10007)

	onToggle = var_3_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.powerToggle

	local function var_3_7(arg_7_0)
		if arg_7_0 then
			GuildConst = var_2_10001

			local var_7_0 = var_2_10001.POLICY_TYPE_POWER
			local var_7_1 = arg_3_0.newGuildVO

			var_2.setPolicy(var_7_1, var_7_0)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3_1(var_3_5, var_3_6, var_3_7, var_1_10007)

	onButton = var_3_1

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.cancelBtn

	local function var_3_10()
		if arg_3_0.onCancel then
			arg_3_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10007

	var_3_1(var_3_8, var_3_9, var_3_10, var_1_10007)

	onButton = var_3_1

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.confirmBtn

	local function var_3_13()
		local var_9_0 = arg_3_0.nameInput.text
		local var_9_1 = arg_3_0.newGuildVO

		var_1.setName(var_9_1, var_9_0)

		local var_9_2 = arg_3_0.manifestoInput.text

		wordVer = var_2_10002

		local var_9_3 = var_2_10002(var_9_2)
		local var_9_4 = arg_3_0.newGuildVO

		var_3.setManifesto(var_9_4, var_9_2)

		local var_9_5 = arg_3_0.newGuildVO
		local var_9_7

		if not var_3.getName(var_9_5) or var_3 == "" then
			pg = var_9_7

			local var_9_6 = var_9_7.TipsMgr.GetInstance()

			var_9_7 = var_9_7.ShowTips
			i18n = var_2_10007

			var_9_7(var_9_6, var_2_10007("guild_create_error_noname"))

			return
		end

		nameValidityCheck = var_9_7

		if not var_9_7(var_3, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"err_name_existOtherChar"
		}) then
			return
		end

		local var_9_8 = arg_3_0.newGuildVO

		if not var_4.getFaction(var_9_8) then
			pg = var_4

			local var_9_9 = var_4.TipsMgr.GetInstance()
			local var_9_10 = var_4.ShowTips

			i18n = var_7

			var_9_10(var_9_9, var_7("guild_create_error_nofaction"))

			return
		end

		local var_9_11 = arg_3_0.newGuildVO

		if not var_4.getPolicy(var_9_11) then
			pg = var_4

			local var_9_12 = var_4.TipsMgr.GetInstance()
			local var_9_13 = var_4.ShowTips

			i18n = var_7

			var_9_13(var_9_12, var_7("guild_create_error_nopolicy"))

			return
		end

		local var_9_14 = arg_3_0.newGuildVO

		if not var_4.getManifesto(var_9_14) or var_4 == "" then
			pg = var_9_5

			local var_9_15 = var_9_5.TipsMgr.GetInstance()

			var_9_5 = var_9_5.ShowTips
			i18n = var_8

			var_9_5(var_9_15, var_8("guild_create_error_nomanifesto"))

			return
		end

		pg = var_9_5

		local var_9_16 = var_9_5.MsgboxMgr.GetInstance()
		local var_9_17 = var_5.ShowMsgBox
		local var_9_18 = {}

		i18n = var_9
		var_9_18.content = var_9("guild_create_confirm", var_3_0)

		function var_9_18.onYes()
			local var_10_0 = arg_3_0.playerVO

			if var_0.getTotalGem(var_10_0) < var_3_0 then
				GoShoppingMsgBox = var_0
				i18n = var_10_0

				local var_10_1 = "switch_to_shop_tip_3"

				i18n = var_3_10005

				local var_10_2 = var_10_0(var_10_1, var_3_10005("word_gem"))

				ChargeScene = var_3_10003

				var_0(var_10_2, var_3_10003.TYPE_DIAMOND)
			else
				local var_10_3 = arg_3_0
				local var_10_4 = var_0.emit

				NewGuildMediator = var_3_10003

				var_10_4(var_10_3, var_3_10003.CREATE, arg_3_0.newGuildVO)
			end

			return
		end

		var_9_17(var_9_16, var_9_18)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3_1(var_3_11, var_3_12, var_3_13, var_1_10007)

	return
end

function var_0_1.Show(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0.playerVO = arg_11_2

	var_0_1.super.Show(arg_11_0)

	arg_11_0.onCancel = arg_11_4
	arg_11_0.newGuildVO = arg_11_1
	triggerToggle = var_5

	var_5(arg_11_0.relaxToggle, true)

	GetOrAddComponent = var_5

	local var_11_0 = var_5(arg_11_0._tf, "CanvasGroup")

	var_11_0.alpha = 0
	arg_11_0.isPlaying = true
	LeanTween = var_6

	local var_11_1 = var_6.value(arg_11_0._go, 0, 1, 0.6)
	local var_11_2 = var_6.setOnUpdate

	System = var_9

	local var_11_3 = var_11_2(var_11_1, var_9.Action_float(function(arg_12_0)
		var_11_0.alpha = arg_12_0

		return
	end))
	local var_11_4 = var_6.setOnComplete

	System = var_9

	local var_11_5 = var_11_4(var_11_3, var_9.Action(function()
		arg_11_0.isPlaying = false

		arg_11_3()

		return
	end))

	var_6.setDelay(var_11_5, 0.5)

	local var_11_6 = arg_11_0._tf

	var_6.SetSiblingIndex(var_11_6, 1)

	return
end

function var_0_1.IsPlaying(arg_14_0)
	return arg_14_0.isPlaying
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1
