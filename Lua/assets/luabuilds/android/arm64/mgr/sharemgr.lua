pg = pg or {}

local var_0_0 = pg

pg.ShareMgr = singletonClass("ShareMgr")

local var_0_1 = pg.ShareMgr

pg.ShareMgr.TypeAdmira = 1
pg.ShareMgr.TypeShipProfile = 2
pg.ShareMgr.TypeNewShip = 3
pg.ShareMgr.TypeBackyard = 4
pg.ShareMgr.TypeNewSkin = 5
pg.ShareMgr.TypeSummary = 6
pg.ShareMgr.TypePhoto = 7
pg.ShareMgr.TypeReflux = 8
pg.ShareMgr.TypeCommander = 9
pg.ShareMgr.TypeColoring = 10
pg.ShareMgr.TypeChallenge = 11
pg.ShareMgr.TypeInstagram = 12
pg.ShareMgr.TypePizzahut = 13
pg.ShareMgr.TypeSecondSummary = 14
pg.ShareMgr.TypePoraisMedals = 15
pg.ShareMgr.TypeIcecream = 16
pg.ShareMgr.TypeValentineQte = 17
pg.ShareMgr.TypeBossRushEX = 18
pg.ShareMgr.TypeTWCelebrationShare = 5000
pg.ShareMgr.TypeCardTower = 17
pg.ShareMgr.TypeDorm3dPhoto = 19
pg.ShareMgr.AuctionGame = 20
pg.ShareMgr.PANEL_TYPE_BLACK = 1
pg.ShareMgr.PANEL_TYPE_PINK = 2
pg.ShareMgr.ANCHORS_TYPE = {
	{
		0,
		0,
		0,
		0
	},
	{
		1,
		0,
		1,
		0
	},
	{
		0,
		1,
		0,
		1
	},
	{
		1,
		1,
		1,
		1
	},
	{
		0.5,
		0.5,
		0.5,
		0.5
	}
}

function pg.ShareMgr.Init(arg_1_0)
	PoolMgr.GetInstance():GetUI("ShareUI", false, function(arg_2_0)
		arg_1_0.go = arg_2_0

		arg_1_0.go:SetActive(false)

		arg_1_0.tr = arg_2_0.transform

		setParent(arg_1_0.tr, var_0_0.UIMgr.GetInstance().OverlayMain.transform, false)

		arg_1_0.panelBlack = arg_1_0.tr:Find("panel")
		arg_1_0.panelPink = arg_1_0.tr:Find("panel_pink")
		arg_1_0.deckTF = arg_1_0.tr:Find("deck")

		setActive(arg_1_0.panelBlack, false)
		setActive(arg_1_0.panelPink, false)

		arg_1_0.logo = arg_1_0.tr:Find("deck/logo")

		GetComponent(arg_1_0.logo, "Image"):SetNativeSize()
		var_0_0.DelegateInfo.New(arg_1_0)

		return
	end)

	arg_1_0.screenshotPath = Application.persistentDataPath .. "/screen_scratch/last_picture_for_share.jpg"
	arg_1_0.cacheComps = {}
	arg_1_0.cacheShowComps = {}
	arg_1_0.cacheMoveComps = {}

	return
end

function pg.ShareMgr.UpdateDeck(arg_3_0, arg_3_1)
	local var_3_9000
	local var_3_0 = getProxy(PlayerProxy)
	local var_3_1 = var_3_0.getRawData(var_3_9000)
	local var_3_2 = getProxy(UserProxy):getRawData()
	local var_3_3 = getProxy(ServerProxy).getRawData(var_3_0)

	if var_3_2 then
		local var_3_4 = var_3_2.server or 0
		local var_3_5 = var_3_3[var_3_4]

		if var_3_1 then
			local var_3_6 = var_3_1.name or ""

			if var_3_5 then
				local var_3_7 = var_3_5.name or ""

				setText(arg_3_1:Find("name/value"), var_3_6)
				setText(arg_3_1:Find("server/value"), var_3_7)
				setText(arg_3_1:Find("lv/value"), var_3_1.level)

				if PLATFORM_CODE == PLATFORM_CHT or PLATFORM_CODE == PLATFORM_CH then
					setActive(arg_3_1:Find("code_bg"), true)
				else
					setActive(arg_3_1:Find("code_bg"), false)
				end

				return
			end
		end
	end
end

function pg.ShareMgr.Share(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0.noBlur = arg_4_4

	if not IsUnityEditor and PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() ~= PACKAGE_TYPE_BILI then
		var_0_0.TipsMgr.GetInstance():ShowTips("指挥官，当前平台不支持分享功能哦")

		return
	end

	arg_4_0:Init()
	assert(var_0_0.share_template[arg_4_1], "share_template not exist: " .. arg_4_1)

	local var_4_0 = arg_4_0.deckTF
	local var_4_1 = arg_4_0.ANCHORS_TYPE[var_0_0.share_template[arg_4_1].deck] or {
		0.5,
		0.5,
		0.5,
		0.5
	}

	arg_4_0.deckTF.anchorMin = Vector2(var_4_1[1], var_4_1[2])
	arg_4_0.deckTF.anchorMax = Vector2(var_4_1[3], var_4_1[4])
	arg_4_0.deckTF.anchoredPosition3D = Vector3(var_0_0.share_template[arg_4_1].qrcode_location[1], var_0_0.share_template[arg_4_1].qrcode_location[2], -100)
	arg_4_0.deckTF.anchoredPosition = Vector2(var_0_0.share_template[arg_4_1].qrcode_location[1], var_0_0.share_template[arg_4_1].qrcode_location[2])

	local var_4_2 = GameObject.Find(var_0_0.share_template[arg_4_1].camera):GetComponent(typeof(Camera)).transform:GetChild(0)

	if arg_4_5 then
		local var_4_3 = (var_4_2.sizeDelta.x - arg_4_5.x) / 2
		local var_4_4 = (var_4_2.sizeDelta.y - arg_4_5.y) / 2

		;(function()
			if arg_4_6 then
				var_4_3 = var_4_3 + arg_4_6[1]
				var_4_4 = var_4_4 + arg_4_6[2]
			end

			return
		end)()

		arg_4_0.deckTF.anchoredPosition3D = Vector3(var_0_0.share_template[arg_4_1].qrcode_location[1] - (var_4_2.sizeDelta.x - arg_4_5.x) / 2, var_0_0.share_template[arg_4_1].qrcode_location[2] + (var_4_2.sizeDelta.y - arg_4_5.y) / 2, -100)
		arg_4_0.deckTF.anchoredPosition = Vector2(var_0_0.share_template[arg_4_1].qrcode_location[1] - (var_4_2.sizeDelta.x - arg_4_5.x) / 2, var_0_0.share_template[arg_4_1].qrcode_location[2] + (var_4_2.sizeDelta.y - arg_4_5.y) / 2)
	end

	arg_4_0:UpdateDeck(arg_4_0.deckTF)
	_.each(var_0_0.share_template[arg_4_1].hidden_comps, function(arg_6_0)
		local var_6_0 = GameObject.Find(arg_6_0)

		if not IsNil(var_6_0) and var_6_0.activeSelf then
			table.insert(arg_4_0.cacheComps, var_6_0)
			var_6_0:SetActive(false)
		end

		return
	end)
	_.each(var_0_0.share_template[arg_4_1].show_comps, function(arg_7_0)
		local var_7_0 = GameObject.Find(arg_7_0)

		if not IsNil(var_7_0) and not var_7_0.activeSelf then
			table.insert(arg_4_0.cacheShowComps, var_7_0)
			var_7_0:SetActive(true)
		end

		return
	end)
	_.each(var_0_0.share_template[arg_4_1].move_comps, function(arg_8_0)
		local var_8_0 = GameObject.Find(arg_8_0.path)

		if not IsNil(var_8_0) then
			table.insert(arg_4_0.cacheMoveComps, {
				var_8_0,
				var_8_0.transform.anchoredPosition.x,
				var_8_0.transform.anchoredPosition.y
			})
			setAnchoredPosition(var_8_0, {
				x = arg_8_0.x,
				y = arg_8_0.y
			})
		end

		return
	end)
	SetParent(arg_4_0.deckTF, var_4_2, false)
	arg_4_0.deckTF:SetAsLastSibling()
	arg_4_0:ShotAndSave(arg_4_1, arg_4_5, var_4_2, function()
		SetParent(var_4_0, arg_4_0.tr, false)
		_.each(arg_4_0.cacheComps, function(arg_10_0)
			arg_10_0:SetActive(true)

			return
		end)

		arg_4_0.cacheComps = {}

		_.each(arg_4_0.cacheShowComps, function(arg_11_0)
			arg_11_0:SetActive(false)

			return
		end)

		arg_4_0.cacheShowComps = {}

		_.each(arg_4_0.cacheMoveComps, function(arg_12_0)
			setAnchoredPosition(arg_12_0[1], {
				x = arg_12_0[2],
				y = arg_12_0[3]
			})

			return
		end)

		arg_4_0.cacheMoveComps = {}

		if not arg_4_0:ShowSharePanel(arg_4_1, arg_4_2, arg_4_3, arg_4_4) then
			arg_4_0:Dispose()
		end

		return
	end)

	return
end

function pg.ShareMgr.ShotAndSave(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	assert(var_0_0.share_template[arg_13_1], "share_template not exist: " .. arg_13_1)

	local var_13_0 = GameObject.Find(var_0_0.share_template[arg_13_1].camera):GetComponent(typeof(Camera))

	table.insert({}, function(arg_14_0)
		var_0_0.UIMgr.GetInstance():LoadingOn(false)
		BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_13_0, arg_14_0)

		return
	end)
	table.insert({}, function(arg_15_0, arg_15_1)
		var_0_0.UIMgr.GetInstance():LoadingOff()

		if arg_13_2 then
			arg_15_1 = (function(arg_16_0, arg_16_1)
				local var_16_0 = UnityEngine.Texture2D.New(arg_16_1.x / arg_13_3.sizeDelta.x * Screen.width, arg_16_1.y / arg_13_3.sizeDelta.y * Screen.height)

				var_16_0:SetPixels((arg_16_0:GetPixels((Screen.width - arg_16_1.x / arg_13_3.sizeDelta.x * Screen.width) / 2, (Screen.height - arg_16_1.y / arg_13_3.sizeDelta.y * Screen.height) / 2, arg_16_1.x / arg_13_3.sizeDelta.x * Screen.width, arg_16_1.y / arg_13_3.sizeDelta.y * Screen.height)))
				var_16_0:Apply()

				return var_16_0
			end)(arg_15_1, arg_13_2)
		end

		arg_13_0:SaveImageWithBytes((Tex2DExtension.EncodeToJPG(arg_15_1)))
		arg_15_0()

		return
	end)
	seriesAsync({}, arg_13_4)

	return
end

function pg.ShareMgr.ShowSharePanel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0.noBlur = arg_17_4

	local var_17_0 = var_0_0.share_template[arg_17_1]

	assert(var_0_0.share_template[arg_17_1], "share_template not exist: " .. arg_17_1)

	local var_17_1 = LuaHelper.GetCHPackageType()

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		local var_17_2 = var_0_0.SdkMgr.GetInstance()

		if var_17_2:GetIsPlatform() then
			local var_17_3 = UnityEngine.Texture2D.New(Screen.width, Screen.height, TextureFormat.ARGB32, false)

			Tex2DExtension.LoadImage(var_17_3, (System.IO.File.ReadAllBytes(arg_17_0.screenshotPath)))
			var_0_0.SdkMgr.GetInstance():GameShare(var_17_0.description, var_17_3)
			var_0_0.UIMgr.GetInstance():LoadingOn()
			onDelayTick(function()
				var_0_0.UIMgr.GetInstance():LoadingOff()

				return
			end, 2)

			goto label_17_0
		end
	end

	if PLATFORM_CODE == PLATFORM_CHT then
		var_0_0.SdkMgr.GetInstance():ShareImg(arg_17_0.screenshotPath, function()
			return
		end)
	elseif PLATFORM_CODE == PLATFORM_CH and var_17_1 == PACKAGE_TYPE_BILI then
		var_0_0.SdkMgr.GetInstance():GameShare(var_17_0.description, arg_17_0.screenshotPath)
	else
		arg_17_0:ShowOwnUI(arg_17_1, arg_17_2, arg_17_3, arg_17_4)

		return true
	end

	::label_17_0::

	return
end

function pg.ShareMgr.TakeTexture(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 == var_0_1.TypeValentineQte then
		local var_20_0 = System.Collections.Generic.List_UnityEngine_Camera()

		var_20_0:Add((GameObject.Find("UICamera"):GetComponent(typeof(Camera))))
		var_20_0:Add((GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera))))

		return (arg_20_2:EncodeToJPG((arg_20_2:TakePhotoMultiCam(var_20_0))))
	else
		return (arg_20_2:EncodeToJPG((arg_20_2:TakePhoto(arg_20_3))))
	end

	return
end

function pg.ShareMgr.TakePhoto(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == var_0_1.TypeValentineQte then
		local var_21_0 = System.Collections.Generic.List_UnityEngine_Camera()

		var_21_0:Add((GameObject.Find("UICamera"):GetComponent(typeof(Camera))))
		var_21_0:Add((GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera))))

		return arg_21_2:TakeMultiCam(var_21_0, arg_21_0.screenshotPath)
	else
		return arg_21_2:Take(arg_21_3, arg_21_0.screenshotPath)
	end

	return
end

function pg.ShareMgr.ShowOwnUI(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_0.noBlur = arg_22_4

	assert(var_0_0.share_template[arg_22_1], "share_template not exist: " .. arg_22_1)
	arg_22_0.go:SetActive(true)
	setActive(arg_22_0.deckTF, false)

	arg_22_2 = arg_22_2 or var_0_1.PANEL_TYPE_BLACK

	if arg_22_2 == var_0_1.PANEL_TYPE_BLACK then
		arg_22_0.panel = arg_22_0.panelBlack
	elseif arg_22_2 == var_0_1.PANEL_TYPE_PINK then
		arg_22_0.panel = arg_22_0.panelPink
	end

	setActive(arg_22_0.panelBlack, arg_22_2 == var_0_1.PANEL_TYPE_BLACK)
	setActive(arg_22_0.panelPink, arg_22_2 == var_0_1.PANEL_TYPE_PINK)

	if not arg_22_4 then
		var_0_0.UIMgr.GetInstance():BlurPanel(arg_22_0.panel, setmetatable({
			staticBlur = true
		}, {
			__index = arg_22_3
		}))
	end

	onButton(arg_22_0, arg_22_0.panel:Find("main/top/btnBack"), function()
		arg_22_0:Dispose()

		return
	end)
	onButton(arg_22_0, arg_22_0.panel:Find("main/buttons/weibo"), function()
		var_0()

		return
	end)
	onButton(arg_22_0, arg_22_0.panel:Find("main/buttons/weixin"), function()
		var_0()

		return
	end)

	if PLATFORM_CODE == PLATFORM_KR then
		onButton(arg_22_0, arg_22_0.panel:Find("main/buttons/facebook"), function()
			var_0_0.SdkMgr.GetInstance():ShareImg(arg_22_0.screenshotPath)
			var_0()

			return
		end)
	end

	return
end

function pg.ShareMgr.Dispose(arg_27_0)
	arg_27_0.go:SetActive(false)

	if arg_27_0.panel and not arg_27_0.noBlur then
		var_0_0.UIMgr.GetInstance():UnOverlayPanel(arg_27_0.panel, arg_27_0.tr)
	end

	PoolMgr.GetInstance():ReturnUI("ShareUI", arg_27_0.go)
	var_0_0.DelegateInfo.Dispose(arg_27_0)

	arg_27_0.go = nil
	arg_27_0.tr = nil
	arg_27_0.panel = nil

	return
end

function pg.ShareMgr.SaveImageWithBytes(arg_28_0, arg_28_1)
	BackYardThemeTempalteUtil.CheckSaveDirectory()
	System.IO.File.WriteAllBytes(arg_28_0.screenshotPath, arg_28_1)

	return
end

return
