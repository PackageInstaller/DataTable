pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.CameraRTMgr = var_0_10001("CameraRTMgr")
pg = var_0

local var_0_1 = var_0.CameraRTMgr

var_0_1.CONFIG = {
	rotX = 0,
	height = 500,
	posX = -500,
	autoResize = false,
	posY = 200,
	rotY = 0,
	camera = "TestCamera",
	rotZ = 0,
	id = 1,
	width = 500
}

function var_0_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing camera rt manager...")

	pg = var_1_10002
	arg_1_0.mainTransform = var_1_10002.UIMgr.GetInstance().UIMain.transform
	arg_1_0.uiList = {}

	arg_1_1()

	return
end

function var_0_1.Bind(arg_2_0, arg_2_1, arg_2_2)
	assert = var_1_10003

	var_1_10003(arg_2_1 and arg_2_2)

	arg_2_1.RenderCamera = arg_2_2
	setActive = var_1_10003

	var_1_10003(arg_2_2, true)

	return
end

function var_0_1.Clean(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_1)
	arg_3_1:CleanRenderTexture()

	setActive = var_2

	var_2(arg_3_1.RenderCamera, false)

	arg_3_1.RenderCamera = nil

	return
end

function var_0_1.Create(arg_4_0, arg_4_1)
	GameObject = var_1_10002

	local var_4_0 = var_1_10002.Find("[RTCamera]")

	assert = var_1_10003

	var_1_10003(var_4_0, "不存在[RTCamera]")

	findTF = var_1_10003

	local var_4_1 = var_1_10003(var_4_0, arg_4_1.camera)

	assert = var_4

	var_4(var_4_1, "不存在相机" .. arg_4_1.camera)

	local var_4_2 = "CameraRTUI" .. arg_4_1.id

	GameObject = var_5

	local var_4_3 = var_5(var_4_2)

	GetOrAddComponent = var_6

	local var_4_4 = var_6(var_4_3, "CameraRTUI")

	setActive = var_7

	var_7(var_4_1, true)

	setParent = var_7

	var_7(var_4_3, arg_4_0.mainTransform, false)

	setSizeDelta = var_7

	var_7(var_4_3, {
		x = arg_4_1.width,
		y = arg_4_1.height
	})

	setLocalEulerAngles = var_7

	var_7(var_4_3, {
		x = arg_4_1.rotX,
		y = arg_4_1.rotY,
		z = arg_4_1.rotZ
	})

	setAnchoredPosition = var_7

	var_7(var_4_3, {
		x = arg_4_1.posX,
		y = arg_4_1.posY
	})

	var_4_4.autoResize = arg_4_1.autoResize

	local var_4_5 = var_4_1
	local var_4_6 = var_4_1.GetComponent

	typeof = var_10
	Camera = var_1_10012
	var_4_4.RenderCamera = var_4_6(var_4_5, var_10(var_1_10012))
	arg_4_0.uiList[var_4_2] = var_4_3

	return var_4_3
end

function var_0_1.ShowOrHide(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = "CameraRTUI" .. arg_5_1

	if not arg_5_0.uiList[var_5_0] then
		warning = var_1_10005

		var_1_10005("不存在CameraRTUI id=" .. arg_5_1)

		return
	end

	setActive = var_1_10005

	var_1_10005(var_4:GetComponent("CameraRTUI").RenderCamera, arg_5_2)

	setActive = var_1_10005

	var_1_10005(var_4, arg_5_2)

	return
end

function var_0_1.Destroy(arg_6_0, arg_6_1)
	local var_6_0 = "CameraRTUI" .. arg_6_1

	if not arg_6_0.uiList[var_6_0] then
		warning = var_1_10004

		var_1_10004("不存在CameraRTUI id=" .. arg_6_1)

		return
	end

	setActive = var_1_10004

	var_1_10004(var_3:GetComponent("CameraRTUI").RenderCamera, false)

	Destroy = var_1_10004

	var_1_10004(var_3)

	arg_6_0.uiList[var_6_0] = nil

	return
end

return
