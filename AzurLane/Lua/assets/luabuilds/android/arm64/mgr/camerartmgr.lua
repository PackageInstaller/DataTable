pg = pg or {}
pg.CameraRTMgr = singletonClass("CameraRTMgr")
pg.CameraRTMgr.CONFIG = {
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

function pg.CameraRTMgr.Init(arg_1_0, arg_1_1)
	print("initializing camera rt manager...")

	arg_1_0.mainTransform = pg.UIMgr.GetInstance().UIMain.transform
	arg_1_0.uiList = {}

	arg_1_1()

	return
end

function pg.CameraRTMgr.Bind(arg_2_0, arg_2_1, arg_2_2)
	assert(arg_2_1 and arg_2_2)

	arg_2_1.RenderCamera = arg_2_2

	setActive(arg_2_2, true)

	return
end

function pg.CameraRTMgr.Clean(arg_3_0, arg_3_1)
	assert(arg_3_1)
	arg_3_1:CleanRenderTexture()
	setActive(arg_3_1.RenderCamera, false)

	arg_3_1.RenderCamera = nil

	return
end

function pg.CameraRTMgr.Create(arg_4_0, arg_4_1)
	local var_4_0 = GameObject.Find("[RTCamera]")

	assert(var_4_0, "不存在[RTCamera]")

	local var_4_1 = findTF(var_4_0, arg_4_1.camera)

	assert(var_4_1, "不存在相机" .. arg_4_1.camera)

	local var_4_2 = GameObject("CameraRTUI" .. arg_4_1.id)
	local var_4_3 = GetOrAddComponent(var_4_2, "CameraRTUI")

	setActive(var_4_1, true)
	setParent(var_4_2, arg_4_0.mainTransform, false)
	setSizeDelta(var_4_2, {
		x = arg_4_1.width,
		y = arg_4_1.height
	})
	setLocalEulerAngles(var_4_2, {
		x = arg_4_1.rotX,
		y = arg_4_1.rotY,
		z = arg_4_1.rotZ
	})
	setAnchoredPosition(var_4_2, {
		x = arg_4_1.posX,
		y = arg_4_1.posY
	})

	var_4_3.autoResize = arg_4_1.autoResize
	var_4_3.RenderCamera = var_4_1:GetComponent(typeof(Camera))
	arg_4_0.uiList["CameraRTUI" .. arg_4_1.id] = var_4_2

	return var_4_2
end

function pg.CameraRTMgr.ShowOrHide(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.uiList["CameraRTUI" .. arg_5_1] then
		warning("不存在CameraRTUI id=" .. arg_5_1)

		return
	end

	setActive(arg_5_0.uiList["CameraRTUI" .. arg_5_1]:GetComponent("CameraRTUI").RenderCamera, arg_5_2)
	setActive(arg_5_0.uiList["CameraRTUI" .. arg_5_1], arg_5_2)

	return
end

function pg.CameraRTMgr.Destroy(arg_6_0, arg_6_1)
	if not arg_6_0.uiList["CameraRTUI" .. arg_6_1] then
		warning("不存在CameraRTUI id=" .. arg_6_1)

		return
	end

	setActive(arg_6_0.uiList["CameraRTUI" .. arg_6_1]:GetComponent("CameraRTUI").RenderCamera, false)
	Destroy(arg_6_0.uiList["CameraRTUI" .. arg_6_1])

	arg_6_0.uiList["CameraRTUI" .. arg_6_1] = nil

	return
end

return
