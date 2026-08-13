class = var_0_10000

local var_0_0 = "EmojiInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EmojiInfoUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/name")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/desc")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.emojiContainer = var_1.Find(var_2_6, "frame/icon_bg")
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "frame/tip")

	i18n = var_4

	var_1(var_2_8, var_4("word_click_to_close"))

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

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)
	arg_3_0:Flush()

	pg = var_1

	local var_3_3 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_3, arg_3_0._tf)

	return
end

function var_0_1.Flush(arg_5_0)
	local var_5_0 = arg_5_0.contextData.id

	assert = var_1_10002

	var_1_10002(var_5_0)

	pg = var_1_10002

	local var_5_1 = var_1_10002.emoji_template[var_5_0]

	arg_5_0.nameTxt.text = var_5_1.item_name
	arg_5_0.descTxt.text = var_5_1.item_desc

	arg_5_0:ReturnEmoji()
	arg_5_0:LoadEmoji(var_5_1)

	return
end

function var_0_1.LoadEmoji(arg_6_0, arg_6_1)
	PoolMgr = var_1_10002

	local var_6_0 = var_1_10002.GetInstance()

	var_2.GetPrefab(var_6_0, "emoji/" .. arg_6_1.pic, arg_6_1.pic, true, function(arg_7_0)
		if arg_7_0:GetComponent("Animator") then
			var_1.enabled = true
		end

		setParent = var_2_10002

		var_2_10002(arg_7_0, arg_6_0.emojiContainer, false)

		arg_6_0.emoji = arg_7_0

		return
	end)

	arg_6_0.template = arg_6_1

	return
end

function var_0_1.ReturnEmoji(arg_8_0)
	if arg_8_0.template and arg_8_0.emoji then
		local var_8_0 = arg_8_0.template

		PoolMgr = var_1_10002

		local var_8_1 = var_1_10002.GetInstance()

		var_2.ReturnPrefab(var_8_1, "emoji/" .. var_8_0.pic, var_8_0.pic, arg_8_0.emoji)

		arg_8_0.template = nil
		arg_8_0.emoji = nil
	end

	return
end

function var_0_1.onBackPressed(arg_9_0)
	var_0_1.super.onBackPressed(arg_9_0)

	return
end

function var_0_1.willExit(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf)
	arg_10_0:ReturnEmoji()

	return
end

return var_0_1
