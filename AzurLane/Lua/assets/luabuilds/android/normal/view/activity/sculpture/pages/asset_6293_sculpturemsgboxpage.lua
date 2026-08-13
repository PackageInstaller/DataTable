class = var_0_10000

local var_0_0 = "SculptureMsgBoxPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureMsgboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.contentTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.nextBtn = var_1.Find(var_2_3, "frame/btn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "frame/btn_confrim")

	local var_2_5 = arg_2_0._tf

	arg_2_0.consumeTr = var_1.Find(var_2_5, "frame/consume")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/consume/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.consumeTxt = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/consume/icon")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.consumeIcon = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/role")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.role = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "frame/title/Text")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.title = var_2_17(var_2_16, var_3(var_1_10004))
	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "frame/tip")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("sculpture_close_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.nextBtn

	local function var_3_5()
		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	arg_7_0.settings = arg_7_1

	local var_7_0 = arg_7_0.contentTxt

	HXSet = var_3
	var_7_0.text = var_3.hxLan(arg_7_1.content)
	setActive = var_7_0

	var_7_0(arg_7_0.consumeTr, arg_7_1.consume)

	local var_7_1, var_7_2

	if arg_7_1.consume then
		var_7_1 = arg_7_0.consumeTxt
		var_7_1.text = arg_7_1.consume
		var_7_1 = arg_7_1.consumeId
		pg = var_7_2
		var_7_2 = var_7_2.activity_workbench_item[var_7_1]

		local var_7_3 = arg_7_0.consumeIcon

		LoadSprite = var_1_10005
		var_7_3.sprite = var_1_10005("props/" .. var_7_2.icon)
		rtf = var_7_3

		local var_7_4 = var_7_3(arg_7_0.consumeIcon.gameObject)

		Vector2 = var_5
		var_7_4.sizeDelta = var_5(60, 60)
	else
		rtf = var_7_1

		local var_7_5 = var_7_1(arg_7_0.consumeIcon.gameObject)

		Vector2 = var_7_2
		var_7_5.sizeDelta = var_7_2(0, 0)
	end

	if arg_7_1.iconName then
		var_7_2 = arg_7_0

		arg_7_0.LoadChar(var_7_2, arg_7_1.iconName)
	else
		var_7_2 = arg_7_0

		arg_7_0.ClearChar(var_7_2)
	end

	if arg_7_1.title then
		local var_7_6 = arg_7_0.title

		GetSpriteFromAtlas = var_7_2
		var_7_6.sprite = var_7_2("ui/SculptureUI_atlas", arg_7_1.title)
	else
		local var_7_7 = arg_7_0.title

		GetSpriteFromAtlas = var_7_2
		var_7_7.sprite = var_7_2("ui/SculptureUI_atlas", "item_title")
	end

	local var_7_8 = arg_7_0.title

	var_2.SetNativeSize(var_7_8)

	setActive = var_2

	var_2(arg_7_0.nextBtn, arg_7_1.nextBtn)

	setActive = var_2

	var_2(arg_7_0.confirmBtn, not arg_7_1.nextBtn)

	return
end

function var_0_1.LoadChar(arg_8_0, arg_8_1)
	if arg_8_0.charName == arg_8_1 then
		return
	end

	arg_8_0:ClearChar()

	PoolMgr = var_2

	local var_8_0 = var_2.GetInstance()

	var_2.GetSpineChar(var_8_0, "takegift_" .. arg_8_1, true, function(arg_9_0)
		local var_9_0 = arg_9_0.transform

		var_1.SetParent(var_9_0, arg_8_0.role.gameObject.transform.parent)

		local var_9_1 = arg_9_0.transform

		Vector3 = var_9_0
		var_9_1.localScale = var_9_0(0.8, 0.8, 0)

		local var_9_2 = arg_9_0.transform

		Vector3 = var_2
		var_9_2.localPosition = var_2(550, -300, 0)

		local var_9_3 = arg_9_0
		local var_9_4 = arg_9_0.GetComponent

		typeof = var_3
		SpineAnimUI = var_4

		local var_9_5 = var_9_4(var_9_3, var_3(var_4))

		var_1.SetAction(var_9_5, "gift_wait_" .. arg_8_1, 0)

		arg_8_0.charGo = arg_9_0

		return
	end)

	arg_8_0.charName = arg_8_1

	return
end

function var_0_1.ClearChar(arg_10_0)
	if arg_10_0.charName and arg_10_0.charGo then
		PoolMgr = var_1

		local var_10_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_10_0, arg_10_0.charName, arg_10_0.charGo)

		arg_10_0.charName = nil
		arg_10_0.charGo = nil
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	arg_11_0:ClearChar()

	return
end

return var_0_1
