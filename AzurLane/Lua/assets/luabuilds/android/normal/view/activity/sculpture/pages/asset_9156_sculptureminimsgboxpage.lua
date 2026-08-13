class = var_0_10000

local var_0_0 = "SculptureMiniMsgBoxPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureMiniMsgBoxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.contentTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_3, "frame/btns/btn_confrim")

	local var_2_4 = arg_2_0.confirmBtn
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.btnImg = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_6, "frame/btns/btn_cancel")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		if arg_3_0.settings.model then
			return
		end

		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		if arg_3_0.settings.model then
			return
		end

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
	SetParent = var_7_0

	local var_7_1 = arg_7_0._tf

	pg = var_4

	var_7_0(var_7_1, var_4.UIMgr.GetInstance().OverlayMain)

	local var_7_2

	if not arg_7_1.yes_text then
		var_7_2 = "btn_confrim"
	end

	GetSpriteFromAtlas = var_7_1

	local var_7_3 = var_7_1("ui/SculptureUI_atlas", var_7_2)

	arg_7_0.btnImg.sprite = var_7_3

	if arg_7_1.effect then
		arg_7_0:LoadEffect()
	end

	setActive = var_4

	var_4(arg_7_0.cancelBtn, arg_7_1.showNo)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	if arg_8_0.effectGo then
		Object = var_1

		var_1.Destroy(arg_8_0.effectGo)

		arg_8_0.effectGo = nil
	end

	return
end

function var_0_1.LoadEffect(arg_9_0)
	local var_9_0 = "liwucaijian_caidai"
	local var_9_2

	if not arg_9_0.effectGo then
		ResourceMgr = var_9_2

		local var_9_1 = var_9_2.Inst

		var_9_2 = var_9_2.getAssetAsync

		local var_9_3 = "ui/" .. var_9_0
		local var_9_4 = ""

		UnityEngine = var_1_10006

		var_9_2(var_9_1, var_9_3, var_9_4, var_1_10006.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
			if arg_9_0.exited then
				return
			end

			local var_10_0 = arg_9_0

			Object = var_2_10002
			var_10_0.effectGo = var_2_10002.Instantiate(arg_10_0, arg_9_0._tf)
			arg_9_0.effectGo.name = var_9_0

			return
		end), true, true)
	else
		setActive = var_9_2

		var_9_2(arg_9_0.effectGo, false)

		setActive = var_9_2

		var_9_2(arg_9_0.effectGo, true)
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	if arg_11_0:isShowing() then
		arg_11_0:Hide()
	end

	return
end

return var_0_1
