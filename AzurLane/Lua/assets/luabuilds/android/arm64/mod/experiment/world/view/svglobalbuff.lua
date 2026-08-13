class = var_0_10000

local var_0_0 = "SVGlobalBuff"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.HideView = "SVGlobalBuff.HideView"

function var_0_1.getUIName(arg_1_0)
	return "SVGlobalBuff"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtFrame = var_1.Find(var_3_0, "frame")

	local var_3_1 = arg_3_0.rtFrame

	arg_3_0.rtPanel = var_1.Find(var_3_1, "buff_panel/buff_bg")

	local var_3_2 = arg_3_0.rtFrame

	arg_3_0.rtInfo = var_1.Find(var_3_2, "buff_panel/info")
	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnDestroy(arg_5_0)
	return
end

function var_0_1.Show(arg_6_0)
	setLocalScale = var_1_10001

	local var_6_0 = arg_6_0.rtFrame

	Vector3 = var_1_10004

	var_1_10001(var_6_0, var_1_10004(0.5, 0.5, 0.5))

	LeanTween = var_1_10001

	local var_6_1 = var_1_10001.cancel

	go = var_6_0

	var_6_1(var_6_0(arg_6_0.rtFrame))

	LeanTween = var_6_1

	local var_6_2 = var_6_1.scale
	local var_6_3 = arg_6_0.rtFrame

	Vector3 = var_4

	var_6_2(var_6_3, var_4.one, 0.15)

	setActive = var_6_2

	var_6_2(arg_6_0._tf, true)

	pg = var_6_2

	local var_6_4 = var_6_2.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_4, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_7_0)
	LeanTween = var_1_10001

	local var_7_0 = var_1_10001.cancel

	go = var_1_10003

	var_7_0(var_1_10003(arg_7_0.rtFrame))

	setActive = var_7_0

	var_7_0(arg_7_0._tf, false)

	pg = var_7_0

	local var_7_1 = var_7_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_1, arg_7_0._tf, arg_7_0._parentTf)
	arg_7_0:emit(var_0_1.HideView, arg_7_0.callback)

	return
end

function var_0_1.Setup(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.callback = arg_8_2
	eachChild = var_1_10003

	var_1_10003(arg_8_0.rtPanel, function(arg_9_0)
		setActive = var_2_10001

		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.name

		tostring = var_2_10005

		var_2_10001(var_9_0, var_9_1 == var_2_10005(arg_8_1.id))

		return
	end)

	WorldBuff = var_1_10003

	local var_8_0 = var_1_10003.New()

	var_3.Setup(var_8_0, {
		id = arg_8_1.id,
		floor = arg_8_1.before
	})

	setText = var_4

	local var_8_1 = arg_8_0.rtInfo

	var_4(var_6.Find(var_8_1, "name"), var_3.config.name)

	setText = var_4

	local var_8_2 = arg_8_0.rtInfo

	var_4(var_6.Find(var_8_2, "value_before"), var_3:GetFloor())
	var_3:AddFloor(arg_8_1.floor)

	setText = var_4

	local var_8_3 = arg_8_0.rtInfo

	var_4(var_6.Find(var_8_3, "value"), var_3:GetFloor())

	return
end

return var_0_1
