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
	local var_3_0 = getProxy(PlayerProxy)
	local var_3_1 = var_3_0:getRawData()
	local var_3_2 = getProxy(UserProxy):getRawData()
	local var_3_3 = getProxy(ServerProxy).getRawData(var_3_0)[(var_3_2 or nil) and (var_3_2.server or 0)]
	local var_3_4

	if var_3_1 then
		var_3_4 = var_3_1.name or ""

		local var_3_5

		if var_3_3 then
			var_3_5 = var_3_3.name or ""
		end
	end

	setText(arg_3_1:Find("name/value"), var_3_4)
	setText(arg_3_1:Find("server/value"), var_3_5)
	setText(arg_3_1:Find("lv/value"), var_3_1.level)

	if PLATFORM_CODE == PLATFORM_CHT or PLATFORM_CODE == PLATFORM_CH then
		setActive(arg_3_1:Find("code_bg"), true)
	else
		setActive(arg_3_1:Find("code_bg"), false)
	end

	return
end

function pg.ShareMgr:Share(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	self.noBlur = arg_4_4

	if not IsUnityEditor and PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() ~= PACKAGE_TYPE_BILI then
		var_0_0.TipsMgr.GetInstance():ShowTips("指挥官，当前平台不支持分享功能哦")

		return
	end

	self:Init()
	assert(var_0_0.share_template[arg_4_1], "share_template not exist: " .. arg_4_1)

	local var_4_0 = self.deckTF
	local var_4_1 = self.ANCHORS_TYPE[var_0_0.share_template[arg_4_1].deck] or {
		0.5,
		0.5,
		0.5,
		0.5
	}

	self.deckTF.anchorMin = Vector2(var_4_1[1], var_4_1[2])
	self.deckTF.anchorMax = Vector2(var_4_1[3], var_4_1[4])
	self.deckTF.anchoredPosition3D = Vector3(var_0_0.share_template[arg_4_1].qrcode_location[1], var_0_0.share_template[arg_4_1].qrcode_location[2], -100)
	self.deckTF.anchoredPosition = Vector2(var_0_0.share_template[arg_4_1].qrcode_location[1], var_0_0.share_template[arg_4_1].qrcode_location[2])

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

		self.deckTF.anchoredPosition3D = Vector3(var_0_0.share_template[arg_4_1].qrcode_location[1] - (var_4_2.sizeDelta.x - arg_4_5.x) / 2, var_0_0.share_template[arg_4_1].qrcode_location[2] + (var_4_2.sizeDelta.y - arg_4_5.y) / 2, -100)
		self.deckTF.anchoredPosition = Vector2(var_0_0.share_template[arg_4_1].qrcode_location[1] - (var_4_2.sizeDelta.x - arg_4_5.x) / 2, var_0_0.share_template[arg_4_1].qrcode_location[2] + (var_4_2.sizeDelta.y - arg_4_5.y) / 2)
	end

	self:UpdateDeck(self.deckTF)
	_.each(var_0_0.share_template[arg_4_1].hidden_comps, function(arg_6_0)
		local var_6_0 = GameObject.Find(arg_6_0)

		if not IsNil(var_6_0) and var_6_0.activeSelf then
			table.insert(self.cacheComps, var_6_0)
			var_6_0:SetActive(false)
		end

		return
	end)
	_.each(var_0_0.share_template[arg_4_1].show_comps, function(arg_7_0)
		local var_7_0 = GameObject.Find(arg_7_0)

		if not IsNil(var_7_0) and not var_7_0.activeSelf then
			table.insert(self.cacheShowComps, var_7_0)
			var_7_0:SetActive(true)
		end

		return
	end)
	_.each(var_0_0.share_template[arg_4_1].move_comps, function(arg_8_0)
		local var_8_0 = GameObject.Find(arg_8_0.path)

		if not IsNil(var_8_0) then
			table.insert(self.cacheMoveComps, {
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
	SetParent(self.deckTF, var_4_2, false)
	self.deckTF:SetAsLastSibling()
	self:ShotAndSave(arg_4_1, arg_4_5, var_4_2, function()
		SetParent(var_4_0, self.tr, false)
		_.each(self.cacheComps, function(arg_10_0)
			arg_10_0:SetActive(true)

			return
		end)

		self.cacheComps = {}

		_.each(self.cacheShowComps, function(arg_11_0)
			arg_11_0:SetActive(false)

			return
		end)

		self.cacheShowComps = {}

		_.each(self.cacheMoveComps, function(arg_12_0)
			setAnchoredPosition(arg_12_0[1], {
				x = arg_12_0[2],
				y = arg_12_0[3]
			})

			return
		end)

		self.cacheMoveComps = {}

		if not self:ShowSharePanel(arg_4_1, arg_4_2, arg_4_3, arg_4_4) then
			self:Dispose()
		end

		return
	end)

	return
end

function pg.ShareMgr.ShotAndSave(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	assert(var_0_0.share_template[arg_13_1], "share_template not exist: " .. arg_13_1)

	local var_13_0 = GameObject.Find(var_0_0.share_template[arg_13_1].camera):GetComponent(typeof(Camera))
	local var_13_1 = {}

	table.insert(var_13_1, function(arg_14_0)
		var_0_0.UIMgr.GetInstance():LoadingOn(false)
		BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_13_0, arg_14_0)

		return
	end)
	table.insert(var_13_1, function(arg_15_0, arg_15_1)
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
	seriesAsync(var_13_1, arg_13_4)

	return
end

function pg.ShareMgr:ShowSharePanel(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self.noBlur = arg_17_4

	local var_17_0 = var_0_0.share_template[arg_17_1]

	assert(var_0_0.share_template[arg_17_1], "share_template not exist: " .. arg_17_1)

	local var_17_1 = LuaHelper.GetCHPackageType()

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		if var_0_0.SdkMgr.GetInstance():GetIsPlatform() then
			local var_17_2 = UnityEngine.Texture2D.New(Screen.width, Screen.height, TextureFormat.ARGB32, false)

			Tex2DExtension.LoadImage(var_17_2, (System.IO.File.ReadAllBytes(self.screenshotPath)))
			var_0_0.SdkMgr.GetInstance():GameShare(var_17_0.description, var_17_2)
			var_0_0.UIMgr.GetInstance():LoadingOn()
			onDelayTick(function()
				var_0_0.UIMgr.GetInstance():LoadingOff()

				return
			end, 2)

			goto label_17_0
		end
	end

	if PLATFORM_CODE == PLATFORM_CHT then
		var_0_0.SdkMgr.GetInstance():ShareImg(self.screenshotPath, function()
			return
		end)
	elseif PLATFORM_CODE == PLATFORM_CH and var_17_1 == PACKAGE_TYPE_BILI then
		var_0_0.SdkMgr.GetInstance():GameShare(var_17_0.description, self.screenshotPath)
	else
		self:ShowOwnUI(arg_17_1, arg_17_2, arg_17_3, arg_17_4)

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

function pg.ShareMgr:TakePhoto(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == var_0_1.TypeValentineQte then
		local var_21_0 = System.Collections.Generic.List_UnityEngine_Camera()

		var_21_0:Add((GameObject.Find("UICamera"):GetComponent(typeof(Camera))))
		var_21_0:Add((GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera))))

		return arg_21_2:TakeMultiCam(var_21_0, self.screenshotPath)
	else
		return arg_21_2:Take(arg_21_3, self.screenshotPath)
	end

	return
end

function pg.ShareMgr:ShowOwnUI(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self.noBlur = arg_22_4

	assert(var_0_0.share_template[arg_22_1], "share_template not exist: " .. arg_22_1)
	self.go:SetActive(true)
	setActive(self.deckTF, false)

	arg_22_2 = arg_22_2 or var_0_1.PANEL_TYPE_BLACK

	if arg_22_2 == var_0_1.PANEL_TYPE_BLACK then
		self.panel = self.panelBlack
	elseif arg_22_2 == var_0_1.PANEL_TYPE_PINK then
		self.panel = self.panelPink
	end

	setActive(self.panelBlack, arg_22_2 == var_0_1.PANEL_TYPE_BLACK)
	setActive(self.panelPink, arg_22_2 == var_0_1.PANEL_TYPE_PINK)

	if not arg_22_4 then
		var_0_0.UIMgr.GetInstance():BlurPanel(self.panel, setmetatable({
			staticBlur = true
		}, {
			__index = arg_22_3
		}))
	end

	local function var_22_0()
		self:Dispose()

		return
	end

	onButton(self, self.panel:Find("main/top/btnBack"), var_22_0)
	onButton(self, self.panel:Find("main/buttons/weibo"), function()
		var_22_0()

		return
	end)
	onButton(self, self.panel:Find("main/buttons/weixin"), function()
		var_22_0()

		return
	end)

	if PLATFORM_CODE == PLATFORM_KR then
		onButton(self, self.panel:Find("main/buttons/facebook"), function()
			var_0_0.SdkMgr.GetInstance():ShareImg(self.screenshotPath)
			var_22_0()

			return
		end)
	end

	return
end

function pg.ShareMgr:Dispose()
	self.go:SetActive(false)

	if self.panel and not self.noBlur then
		var_0_0.UIMgr.GetInstance():UnOverlayPanel(self.panel, self.tr)
	end

	PoolMgr.GetInstance():ReturnUI("ShareUI", self.go)
	var_0_0.DelegateInfo.Dispose(self)

	self.go = nil
	self.tr = nil
	self.panel = nil

	return
end

function pg.ShareMgr:SaveImageWithBytes(arg_28_1)
	BackYardThemeTempalteUtil.CheckSaveDirectory()
	System.IO.File.WriteAllBytes(self.screenshotPath, arg_28_1)

	return
end

return
