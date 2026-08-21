local var_0_0 = class("ShipPreviewLayer", import("..base.BaseUI"))
local var_0_3 = Vector3(0, 1, 40)

function var_0_0.getUIName(arg_1_0)
	return "ShipPreviewUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0.UIMain = pg.UIMgr.GetInstance().UIMain
	arg_2_0.seaCameraGO = GameObject.Find("BarrageCamera")
	arg_2_0.leftPanel = arg_2_0._tf:Find("left_panel")
	arg_2_0.sea = arg_2_0.leftPanel:Find("sea")
	arg_2_0.seaCamera = arg_2_0.seaCameraGO:GetComponent("Camera")
	arg_2_0.seaCamera.enabled = true
	arg_2_0.rawImage = arg_2_0.sea:GetComponent("RawImage")

	setActive(arg_2_0.rawImage, false)

	arg_2_0.seaCamera.targetTexture = arg_2_0.rawImage.texture
	arg_2_0.healTF = arg_2_0._tf:Find("resources/heal")
	arg_2_0.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(arg_2_0.healTF, false)
	arg_2_0.healTF:GetComponent("DftAniEvent"):SetEndEvent(function()
		setActive(arg_2_0.healTF, false)
		setText(arg_2_0.healTF:Find("text"), "")

		return
	end)

	arg_2_0.seaLoading = arg_2_0.leftPanel:Find("bg/loading")

	arg_2_0:playLoadingAni()

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0.seaLoading, function()
		if not arg_4_0.previewer then
			arg_4_0:showBarrage()
		end

		return
	end)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	return
end

function var_0_0.setShip(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.shipVO = arg_7_1
	arg_7_0.weaponIds = arg_7_2
	arg_7_0.equipSkinId = arg_7_3

	return
end

function var_0_0.showBarrage(arg_8_0)
	arg_8_0.previewer = WeaponPreviewer.New(arg_8_0.rawImage)

	arg_8_0.previewer:configUI(arg_8_0.healTF)
	arg_8_0.previewer:setDisplayWeapon(arg_8_0.weaponIds, arg_8_0.equipSkinId, true)
	arg_8_0.previewer:load(40000, arg_8_0.shipVO, arg_8_0.weaponIds, function()
		arg_8_0:stopLoadingAni()

		return
	end)

	return
end

function var_0_0.getWaponIdsById(arg_10_0, arg_10_1)
	return arg_10_0.ship_data_breakout[arg_10_1].weapon_ids
end

function var_0_0.playLoadingAni(arg_11_0)
	setActive(arg_11_0.seaLoading, true)

	return
end

function var_0_0.stopLoadingAni(arg_12_0)
	setActive(arg_12_0.seaLoading, false)

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0.seaCamera.enabled = false

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0.UIMain)

	if arg_13_0.previewer then
		arg_13_0.previewer:clear()

		arg_13_0.previewer = nil
	end

	return
end

return var_0_0
