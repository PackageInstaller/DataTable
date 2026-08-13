pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ShareMgr = var_0_10001("ShareMgr")

local var_0_1 = var_0.ShareMgr

var_0_1.TypeAdmira = 1
var_0_1.TypeShipProfile = 2
var_0_1.TypeNewShip = 3
var_0_1.TypeBackyard = 4
var_0_1.TypeNewSkin = 5
var_0_1.TypeSummary = 6
var_0_1.TypePhoto = 7
var_0_1.TypeReflux = 8
var_0_1.TypeCommander = 9
var_0_1.TypeColoring = 10
var_0_1.TypeChallenge = 11
var_0_1.TypeInstagram = 12
var_0_1.TypePizzahut = 13
var_0_1.TypeSecondSummary = 14
var_0_1.TypePoraisMedals = 15
var_0_1.TypeIcecream = 16
var_0_1.TypeValentineQte = 17
var_0_1.TypeBossRushEX = 18
var_0_1.TypeTWCelebrationShare = 5000
var_0_1.TypeCardTower = 17
var_0_1.TypeDorm3dPhoto = 19
var_0_1.AuctionGame = 20
var_0_1.PANEL_TYPE_BLACK = 1
var_0_1.PANEL_TYPE_PINK = 2
var_0_1.ANCHORS_TYPE = {
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

function var_0_1.Init(arg_1_0)
	PoolMgr = var_1_10001

	local var_1_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_1_0, "ShareUI", false, function(arg_2_0)
		arg_1_0.go = arg_2_0

		local var_2_0 = arg_1_0.go

		var_1.SetActive(var_2_0, false)

		arg_1_0.tr = arg_2_0.transform

		local var_2_1 = var_0.UIMgr.GetInstance().OverlayMain

		setParent = var_2

		var_2(arg_1_0.tr, var_2_1.transform, false)

		local var_2_2 = arg_1_0
		local var_2_3 = arg_1_0.tr

		var_2_2.panelBlack = var_3.Find(var_2_3, "panel")

		local var_2_4 = arg_1_0
		local var_2_5 = arg_1_0.tr

		var_2_4.panelPink = var_3.Find(var_2_5, "panel_pink")

		local var_2_6 = arg_1_0
		local var_2_7 = arg_1_0.tr

		var_2_6.deckTF = var_3.Find(var_2_7, "deck")
		setActive = var_2_6

		var_2_6(arg_1_0.panelBlack, false)

		setActive = var_2_6

		var_2_6(arg_1_0.panelPink, false)

		local var_2_8 = arg_1_0
		local var_2_9 = arg_1_0.tr

		var_2_8.logo = var_3.Find(var_2_9, "deck/logo")
		GetComponent = var_2_8

		local var_2_10 = var_2_8(arg_1_0.logo, "Image")

		var_2.SetNativeSize(var_2_10)
		var_0.DelegateInfo.New(arg_1_0)

		return
	end)

	Application = var_1
	arg_1_0.screenshotPath = var_1.persistentDataPath .. "/screen_scratch/last_picture_for_share.jpg"
	arg_1_0.cacheComps = {}
	arg_1_0.cacheShowComps = {}
	arg_1_0.cacheMoveComps = {}

	return
end

function var_0_1.UpdateDeck(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)
	local var_3_1 = var_2.getRawData(var_3_0)

	getProxy = var_1_10003
	UserProxy = var_1_10005

	local var_3_2 = var_1_10003(var_1_10005)
	local var_3_3 = var_3.getRawData(var_3_2)

	getProxy = var_3_0
	ServerProxy = var_1_10006

	local var_3_4 = var_3_0(var_1_10006)
	local var_3_5 = var_4.getRawData(var_3_4)
	local var_3_6

	if not var_3_3 or not var_3_3.server then
		var_3_6 = 0
	end

	local var_3_7 = var_3_5[var_3_6]
	local var_3_8

	if not var_3_1 or not var_3_1.name then
		var_3_8 = ""
	end

	local var_3_9

	if not var_3_7 or not var_3_7.name then
		var_3_9 = ""
	end

	setText = var_1_10007

	var_1_10007(arg_3_1:Find("name/value"), var_3_8)

	setText = var_1_10007

	var_1_10007(arg_3_1:Find("server/value"), var_3_9)

	setText = var_1_10007

	var_1_10007(arg_3_1:Find("lv/value"), var_3_1.level)

	PLATFORM_CODE = var_1_10007
	PLATFORM_CHT = var_1_10008

	if var_1_10007 ~= var_1_10008 then
		PLATFORM_CODE = var_1_10007
		PLATFORM_CH = var_1_10008

		if var_1_10007 == var_1_10008 then
			setActive = var_1_10007

			var_1_10007(arg_3_1:Find("code_bg"), true)
		else
			setActive = var_1_10007

			var_1_10007(arg_3_1:Find("code_bg"), false)
		end

		return
	end
end

function var_0_1.Share(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0.noBlur = arg_4_4
	LuaHelper = var_1_10007

	local var_4_0 = var_1_10007.GetCHPackageType()

	IsUnityEditor = var_1_10008

	if not var_1_10008 then
		PLATFORM_CODE = var_1_10008
		PLATFORM_CH = var_1_10009

		if var_1_10008 == var_1_10009 then
			PACKAGE_TYPE_BILI = var_1_10008

			if var_4_0 ~= var_1_10008 then
				local var_4_1 = var_0.TipsMgr.GetInstance()

				var_8.ShowTips(var_4_1, "指挥官，当前平台不支持分享功能哦")

				return
			end
		end
	end

	arg_4_0:Init()

	local var_4_2 = var_0.share_template[arg_4_1]

	assert = var_1_10009

	var_1_10009(var_4_2, "share_template not exist: " .. arg_4_1)

	local var_4_3 = arg_4_0.deckTF
	local var_4_4

	if not arg_4_0.ANCHORS_TYPE[var_4_2.deck] then
		var_4_4 = {
			0.5,
			0.5,
			0.5,
			0.5
		}
	end

	Vector2 = var_11
	var_4_3.anchorMin = var_11(var_4_4[1], var_4_4[2])
	Vector2 = var_11
	var_4_3.anchorMax = var_11(var_4_4[3], var_4_4[4])
	Vector3 = var_11
	var_4_3.anchoredPosition3D = var_11(var_4_2.qrcode_location[1], var_4_2.qrcode_location[2], -100)
	Vector2 = var_11
	var_4_3.anchoredPosition = var_11(var_4_2.qrcode_location[1], var_4_2.qrcode_location[2])
	GameObject = var_11

	local var_4_5 = var_11.Find(var_4_2.camera)
	local var_4_6 = var_11.GetComponent

	typeof = var_14
	Camera = var_1_10016

	local var_4_7 = var_4_6(var_4_5, var_14(var_1_10016)).transform
	local var_4_8 = var_12.GetChild(var_4_7, 0)

	if arg_4_5 then
		local var_4_9 = (var_4_8.sizeDelta.x - arg_4_5.x) / 2
		local var_4_10 = (var_4_8.sizeDelta.y - arg_4_5.y) / 2

		;(function()
			if arg_4_6 then
				var_4_9 = var_4_9 + arg_4_6[1]
				var_4_10 = var_4_10 + arg_4_6[2]
			end

			return
		end)()

		Vector3 = var_16
		var_4_3.anchoredPosition3D = var_16(var_4_2.qrcode_location[1] - var_4_9, var_4_2.qrcode_location[2] + var_4_10, -100)
		Vector2 = var_16
		var_4_3.anchoredPosition = var_16(var_4_2.qrcode_location[1] - var_4_9, var_4_2.qrcode_location[2] + var_4_10)
	end

	arg_4_0:UpdateDeck(var_4_3)

	_ = var_13

	var_13.each(var_4_2.hidden_comps, function(arg_6_0)
		GameObject = var_2_10001

		local var_6_0 = var_2_10001.Find(arg_6_0)

		IsNil = var_2_10002

		if not var_2_10002(var_6_0) and var_6_0.activeSelf then
			table = var_2

			var_2.insert(arg_4_0.cacheComps, var_6_0)
			var_6_0:SetActive(false)
		end

		return
	end)

	_ = var_13

	var_13.each(var_4_2.show_comps, function(arg_7_0)
		GameObject = var_2_10001

		local var_7_0 = var_2_10001.Find(arg_7_0)

		IsNil = var_2_10002

		if not var_2_10002(var_7_0) and not var_7_0.activeSelf then
			table = var_2

			var_2.insert(arg_4_0.cacheShowComps, var_7_0)
			var_7_0:SetActive(true)
		end

		return
	end)

	_ = var_13

	var_13.each(var_4_2.move_comps, function(arg_8_0)
		GameObject = var_2_10001

		local var_8_0 = var_2_10001.Find(arg_8_0.path)

		IsNil = var_2_10002

		if not var_2_10002(var_8_0) then
			local var_8_1 = var_8_0.transform.anchoredPosition.x
			local var_8_2 = var_8_0.transform.anchoredPosition.y
			local var_8_3 = arg_8_0.x
			local var_8_4 = arg_8_0.y

			table = var_2_10006

			var_2_10006.insert(arg_4_0.cacheMoveComps, {
				var_8_0,
				var_8_1,
				var_8_2
			})

			setAnchoredPosition = var_6

			var_6(var_8_0, {
				x = var_8_3,
				y = var_8_4
			})
		end

		return
	end)

	SetParent = var_13

	var_13(var_4_3, var_4_8, false)
	var_4_3:SetAsLastSibling()
	arg_4_0:ShotAndSave(arg_4_1, arg_4_5, var_4_8, function()
		SetParent = var_2_10000

		var_2_10000(var_4_3, arg_4_0.tr, false)

		local var_9_0 = arg_4_0
		local var_9_1 = var_0.ShowSharePanel(var_9_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)

		_ = var_2_10001

		var_2_10001.each(arg_4_0.cacheComps, function(arg_10_0)
			arg_10_0:SetActive(true)

			return
		end)

		local var_9_2 = arg_4_0

		var_9_2.cacheComps = {}
		_ = var_9_2

		var_9_2.each(arg_4_0.cacheShowComps, function(arg_11_0)
			arg_11_0:SetActive(false)

			return
		end)

		local var_9_3 = arg_4_0

		var_9_3.cacheShowComps = {}
		_ = var_9_3

		var_9_3.each(arg_4_0.cacheMoveComps, function(arg_12_0)
			setAnchoredPosition = var_3_10001

			var_3_10001(arg_12_0[1], {
				x = arg_12_0[2],
				y = arg_12_0[3]
			})

			return
		end)

		arg_4_0.cacheMoveComps = {}

		if not var_9_1 then
			local var_9_4 = arg_4_0

			var_1.Dispose(var_9_4)
		end

		return
	end)

	return
end

function var_0_1.ShotAndSave(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = var_0.share_template[arg_13_1]

	assert = var_1_10006

	var_1_10006(var_13_0, "share_template not exist: " .. arg_13_1)

	GameObject = var_1_10006

	local var_13_1 = var_1_10006.Find(var_13_0.camera)
	local var_13_2 = var_6.GetComponent

	typeof = var_9
	Camera = var_1_10011

	local var_13_3 = var_13_2(var_13_1, var_9(var_1_10011))
	local var_13_4 = {}

	table = var_13_1

	var_13_1.insert(var_13_4, function(arg_14_0)
		local var_14_0 = var_0.UIMgr.GetInstance()

		var_1.LoadingOn(var_14_0, false)

		BLHX = var_1

		var_1.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_13_3, arg_14_0)

		return
	end)

	table = var_8

	var_8.insert(var_13_4, function(arg_15_0, arg_15_1)
		local var_15_0 = var_0.UIMgr.GetInstance()

		var_2.LoadingOff(var_15_0)

		local function var_15_1(arg_16_0, arg_16_1)
			local var_16_0 = arg_16_1.x / arg_13_3.sizeDelta.x

			Screen = var_3

			local var_16_1 = var_16_0 * var_3.width
			local var_16_2 = arg_16_1.y / arg_13_3.sizeDelta.y

			Screen = var_4

			local var_16_3 = var_16_2 * var_4.height

			Screen = var_4

			local var_16_4 = (var_4.width - var_16_1) / 2

			Screen = var_3_10005

			local var_16_5 = (var_3_10005.height - var_16_3) / 2
			local var_16_6 = arg_16_0:GetPixels(var_16_4, var_16_5, var_16_1, var_16_3)

			UnityEngine = var_3_10007

			local var_16_7 = var_3_10007.Texture2D.New(var_16_1, var_16_3)

			var_7.SetPixels(var_16_7, var_16_6)
			var_7:Apply()

			return var_7
		end

		if arg_13_2 then
			arg_15_1 = var_15_1(arg_15_1, arg_13_2)
		end

		Tex2DExtension = var_3

		local var_15_2 = var_3.EncodeToJPG(arg_15_1)
		local var_15_3 = arg_13_0

		var_4.SaveImageWithBytes(var_15_3, var_15_2)
		arg_15_0()

		return
	end)

	seriesAsync = var_8

	var_8(var_13_4, arg_13_4)

	return
end

function var_0_1.ShowSharePanel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0.noBlur = arg_17_4

	local var_17_0 = var_0.share_template[arg_17_1]

	assert = var_1_10006

	var_1_10006(var_17_0, "share_template not exist: " .. arg_17_1)

	LuaHelper = var_1_10006

	local var_17_1 = var_1_10006.GetCHPackageType()

	PLATFORM_CODE = var_1_10007
	PLATFORM_JP = var_17_3

	if var_1_10007 ~= var_17_3 then
		PLATFORM_CODE = var_1_10007
		PLATFORM_US = var_17_3

		local var_17_3

		if var_1_10007 == var_17_3 then
			local var_17_2 = var_0.SdkMgr.GetInstance()

			if var_1_10007.GetIsPlatform(var_17_2) then
				System = var_1_10007
				var_1_10007 = var_1_10007.IO.File.ReadAllBytes(arg_17_0.screenshotPath)
				UnityEngine = var_17_3
				var_17_3 = var_17_3.Texture2D.New
				Screen = var_10

				local var_17_4 = var_10.width

				Screen = var_1_10011

				local var_17_5 = var_1_10011.height

				TextureFormat = var_1_10012
				var_17_3 = var_17_3(var_17_4, var_17_5, var_1_10012.ARGB32, false)
				Tex2DExtension = var_9

				var_9.LoadImage(var_17_3, var_1_10007)

				local var_17_6 = var_0.SdkMgr.GetInstance()

				var_9.GameShare(var_17_6, var_17_0.description, var_17_3)

				local var_17_7 = var_0.UIMgr.GetInstance()

				var_9.LoadingOn(var_17_7)

				onDelayTick = var_9

				var_9(function()
					local var_18_0 = var_0.UIMgr.GetInstance()

					var_0.LoadingOff(var_18_0)

					return
				end, 2)

				goto label_17_0
			end
		end

		PLATFORM_CODE = var_1_10007
		PLATFORM_CHT = var_17_3

		if var_1_10007 == var_17_3 then
			local var_17_8 = var_0.SdkMgr.GetInstance()

			var_1_10007.ShareImg(var_17_8, arg_17_0.screenshotPath, function()
				return
			end)
		else
			PLATFORM_CODE = var_1_10007
			PLATFORM_CH = var_17_3

			if var_1_10007 == var_17_3 then
				PACKAGE_TYPE_BILI = var_1_10007

				if var_17_1 == var_1_10007 then
					local var_17_9 = var_0.SdkMgr.GetInstance()

					var_7.GameShare(var_17_9, var_17_0.description, arg_17_0.screenshotPath)

					goto label_17_0
				end
			end

			arg_17_0:ShowOwnUI(arg_17_1, arg_17_2, arg_17_3, arg_17_4)

			return true
		end

		::label_17_0::

		return
	end
end

function var_0_1.TakeTexture(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 == var_0_1.TypeValentineQte then
		System = var_4

		local var_20_0 = var_4.Collections.Generic.List_UnityEngine_Camera()

		GameObject = var_1_10005

		local var_20_1 = var_1_10005.Find("UICamera")
		local var_20_2 = var_5.GetComponent

		typeof = var_1_10008
		Camera = var_1_10010

		local var_20_3 = var_20_2(var_20_1, var_1_10008(var_1_10010))

		GameObject = var_1_10006

		local var_20_4 = var_1_10006.Find("OverlayCamera")
		local var_20_5 = var_6.GetComponent

		typeof = var_1_10009
		Camera = var_1_10011

		local var_20_6 = var_20_5(var_20_4, var_1_10009(var_1_10011))

		var_20_0:Add(var_20_3)
		var_20_0:Add(var_20_6)

		local var_20_7 = arg_20_2:TakePhotoMultiCam(var_20_0)

		return (arg_20_2:EncodeToJPG(var_20_7))
	else
		local var_20_8 = arg_20_2:TakePhoto(arg_20_3)

		return (arg_20_2:EncodeToJPG(var_20_8))
	end

	return
end

function var_0_1.TakePhoto(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == var_0_1.TypeValentineQte then
		System = var_4

		local var_21_0 = var_4.Collections.Generic.List_UnityEngine_Camera()

		GameObject = var_1_10005

		local var_21_1 = var_1_10005.Find("UICamera")
		local var_21_2 = var_5.GetComponent

		typeof = var_1_10008
		Camera = var_1_10010

		local var_21_3 = var_21_2(var_21_1, var_1_10008(var_1_10010))

		GameObject = var_1_10006

		local var_21_4 = var_1_10006.Find("OverlayCamera")
		local var_21_5 = var_6.GetComponent

		typeof = var_1_10009
		Camera = var_1_10011

		local var_21_6 = var_21_5(var_21_4, var_1_10009(var_1_10011))

		var_21_0:Add(var_21_3)
		var_21_0:Add(var_21_6)

		return arg_21_2:TakeMultiCam(var_21_0, arg_21_0.screenshotPath)
	else
		return arg_21_2:Take(arg_21_3, arg_21_0.screenshotPath)
	end

	return
end

function var_0_1.ShowOwnUI(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_0.noBlur = arg_22_4

	local var_22_0 = var_0.share_template[arg_22_1]

	assert = var_1_10006

	var_1_10006(var_22_0, "share_template not exist: " .. arg_22_1)

	local var_22_1 = arg_22_0.go

	var_6.SetActive(var_22_1, true)

	setActive = var_6

	var_6(arg_22_0.deckTF, false)

	arg_22_2 = arg_22_2 or var_0_1.PANEL_TYPE_BLACK

	if arg_22_2 == var_0_1.PANEL_TYPE_BLACK then
		arg_22_0.panel = arg_22_0.panelBlack
	elseif arg_22_2 == var_0_1.PANEL_TYPE_PINK then
		arg_22_0.panel = arg_22_0.panelPink
	end

	setActive = var_6

	var_6(arg_22_0.panelBlack, arg_22_2 == var_0_1.PANEL_TYPE_BLACK)

	setActive = var_6

	var_6(arg_22_0.panelPink, arg_22_2 == var_0_1.PANEL_TYPE_PINK)

	local var_22_2

	if not arg_22_4 then
		var_22_2 = var_0.UIMgr.GetInstance()

		local var_22_3 = var_6.BlurPanel
		local var_22_4 = arg_22_0.panel

		setmetatable = var_10

		var_22_3(var_22_2, var_22_4, var_10({
			staticBlur = true
		}, {
			__index = arg_22_3
		}))
	end

	local function var_22_5()
		local var_23_0 = arg_22_0

		var_0.Dispose(var_23_0)

		return
	end

	onButton = var_1_10007

	local var_22_6 = arg_22_0
	local var_22_7 = arg_22_0.panel

	var_1_10007(var_22_6, var_10.Find(var_22_7, "main/top/btnBack"), var_22_5)

	onButton = var_1_10007

	local var_22_8 = arg_22_0
	local var_22_9 = arg_22_0.panel

	var_1_10007(var_22_8, var_10.Find(var_22_9, "main/buttons/weibo"), function()
		var_22_5()

		return
	end)

	onButton = var_1_10007

	local var_22_10 = arg_22_0
	local var_22_11 = arg_22_0.panel

	var_1_10007(var_22_10, var_10.Find(var_22_11, "main/buttons/weixin"), function()
		var_22_5()

		return
	end)

	PLATFORM_CODE = var_1_10007
	PLATFORM_KR = var_22_2

	if var_1_10007 == var_22_2 then
		onButton = var_1_10007

		local var_22_12 = arg_22_0
		local var_22_13 = arg_22_0.panel

		var_1_10007(var_22_12, var_10.Find(var_22_13, "main/buttons/facebook"), function()
			local var_26_0 = var_0.SdkMgr.GetInstance()

			var_0.ShareImg(var_26_0, arg_22_0.screenshotPath)
			var_22_5()

			return
		end)
	end

	return
end

function var_0_1.Dispose(arg_27_0)
	local var_27_0 = arg_27_0.go

	var_1.SetActive(var_27_0, false)

	if arg_27_0.panel and not arg_27_0.noBlur then
		local var_27_1 = var_0.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_27_1, arg_27_0.panel, arg_27_0.tr)
	end

	PoolMgr = var_1

	local var_27_2 = var_1.GetInstance()

	var_1.ReturnUI(var_27_2, "ShareUI", arg_27_0.go)
	var_0.DelegateInfo.Dispose(arg_27_0)

	arg_27_0.go = nil
	arg_27_0.tr = nil
	arg_27_0.panel = nil

	return
end

function var_0_1.SaveImageWithBytes(arg_28_0, arg_28_1)
	BackYardThemeTempalteUtil = var_1_10002

	var_1_10002.CheckSaveDirectory()

	local var_28_0 = arg_28_0.screenshotPath

	System = var_1_10003

	var_1_10003.IO.File.WriteAllBytes(var_28_0, arg_28_1)

	return
end

return
