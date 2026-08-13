class = var_0_10000

local var_0_0 = "ShipPreviewLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 12
local var_0_3 = 3

Vector3 = var_3

local var_0_4 = var_3(0, 1, 40)

function var_0_1.getUIName(arg_1_0)
	return "ShipPreviewUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	pg = var_1
	arg_2_0.UIMain = var_1.UIMgr.GetInstance().UIMain
	GameObject = var_1
	arg_2_0.seaCameraGO = var_1.Find("BarrageCamera")

	local var_2_1 = arg_2_0._tf

	arg_2_0.leftPanel = var_1.Find(var_2_1, "left_panel")

	local var_2_2 = arg_2_0.leftPanel

	arg_2_0.sea = var_1.Find(var_2_2, "sea")

	local var_2_3 = arg_2_0.seaCameraGO

	arg_2_0.seaCamera = var_1.GetComponent(var_2_3, "Camera")
	arg_2_0.seaCamera.enabled = true

	local var_2_4 = arg_2_0.sea

	arg_2_0.rawImage = var_1.GetComponent(var_2_4, "RawImage")
	setActive = var_1

	var_1(arg_2_0.rawImage, false)

	arg_2_0.seaCamera.targetTexture = arg_2_0.rawImage.texture

	local var_2_5 = arg_2_0._tf

	arg_2_0.healTF = var_1.Find(var_2_5, "resources/heal")

	local var_2_6 = arg_2_0.healTF.transform

	Vector3 = var_2_5
	var_2_6.localPosition = var_2_5(-360, 50, 40)
	setActive = var_2_6

	var_2_6(arg_2_0.healTF, false)

	local var_2_7 = arg_2_0.healTF
	local var_2_8 = var_1.GetComponent(var_2_7, "DftAniEvent")

	var_1.SetEndEvent(var_2_8, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.healTF, false)

		setText = var_2_10000

		local var_3_0 = arg_2_0.healTF

		var_2_10000(var_1.Find(var_3_0, "text"), "")

		return
	end)

	local var_2_9 = arg_2_0.leftPanel

	arg_2_0.seaLoading = var_2.Find(var_2_9, "bg/loading")

	arg_2_0:playLoadingAni()

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.seaLoading, function()
		if not arg_4_0.previewer then
			local var_5_0 = arg_4_0

			var_0.showBarrage(var_5_0)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0._tf, function()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end)

	return
end

function var_0_1.setShip(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.shipVO = arg_7_1
	arg_7_0.weaponIds = arg_7_2
	arg_7_0.equipSkinId = arg_7_3

	return
end

function var_0_1.showBarrage(arg_8_0)
	WeaponPreviewer = var_1_10001
	arg_8_0.previewer = var_1_10001.New(arg_8_0.rawImage)

	local var_8_0 = arg_8_0.previewer

	var_1.configUI(var_8_0, arg_8_0.healTF)

	local var_8_1 = arg_8_0.previewer

	var_1.setDisplayWeapon(var_8_1, arg_8_0.weaponIds, arg_8_0.equipSkinId, true)

	local var_8_2 = arg_8_0.previewer

	var_1.load(var_8_2, 40000, arg_8_0.shipVO, arg_8_0.weaponIds, function()
		local var_9_0 = arg_8_0

		var_0.stopLoadingAni(var_9_0)

		return
	end)

	return
end

function var_0_1.getWaponIdsById(arg_10_0, arg_10_1)
	return arg_10_0.ship_data_breakout[arg_10_1].weapon_ids
end

function var_0_1.playLoadingAni(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.seaLoading, true)

	return
end

function var_0_1.stopLoadingAni(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.seaLoading, false)

	return
end

function var_0_1.willExit(arg_13_0)
	local var_13_0 = arg_13_0.seaCamera

	var_13_0.enabled = false
	pg = var_13_0

	local var_13_1 = var_13_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_1, arg_13_0._tf, arg_13_0.UIMain)

	if arg_13_0.previewer then
		local var_13_2 = arg_13_0.previewer

		var_1.clear(var_13_2)

		arg_13_0.previewer = nil
	end

	return
end

return var_0_1
