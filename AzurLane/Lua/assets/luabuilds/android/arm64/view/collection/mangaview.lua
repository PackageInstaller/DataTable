class = var_0_10000

local var_0_0 = "MangaView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

var_0_1.MangaGroupName = "MANGA"

function var_0_1.getUIName(arg_1_0)
	return "MangaUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:updateBtnList()
	arg_2_0:Show()
	arg_2_0:updatePanel()
	arg_2_0:tryShowTipMsgBox()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	local var_3_0 = arg_3_0.resLoader

	var_1.Clear(var_3_0)
	arg_3_0:stopUpdateEmpty()
	arg_3_0:stopUpdateDownloadBtnPanel()

	return
end

function var_0_1.onBackPressed(arg_4_0)
	return true
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	AppreciateProxy = var_1_10003
	arg_5_0.appreciateProxy = var_1_10001(var_1_10003)
	AutoLoader = var_1
	arg_5_0.resLoader = var_1.New()
	arg_5_0.isShowNotRead = false
	arg_5_0.isShowLike = false
	arg_5_0.isUpOrder = false
	GroupHelper = var_1
	arg_5_0.group = var_1.GetGroupMgrByName(var_0_1.MangaGroupName)
	arg_5_0.mangaIDListForShow = arg_5_0:getMangaIDListForShow()

	return
end

function var_0_1.initUI(arg_6_0)
	setLocalPosition = var_1_10001

	local var_6_0 = arg_6_0._tf

	Vector2 = var_1_10004

	var_1_10001(var_6_0, var_1_10004.zero)

	local var_6_1 = arg_6_0._tf

	Vector2 = var_1_10002
	var_6_1.anchorMin = var_1_10002.zero

	local var_6_2 = arg_6_0._tf

	Vector2 = var_2
	var_6_2.anchorMax = var_2.one

	local var_6_3 = arg_6_0._tf

	Vector2 = var_2
	var_6_3.offsetMax = var_2.zero

	local var_6_4 = arg_6_0._tf

	Vector2 = var_2
	var_6_4.offsetMin = var_2.zero

	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_1.Find(var_6_5, "BtnList")

	arg_6_0.likeFilteBtn = var_1.Find(var_6_6, "LikeFilterBtn")
	arg_6_0.readFilteBtn = var_1:Find("ReadFilteBtn")
	arg_6_0.orderBtn = var_1:Find("OrderBtn")
	arg_6_0.repairBtn = var_1:Find("RepairBtn")

	local var_6_7 = arg_6_0._tf

	arg_6_0.scrollView = var_2.Find(var_6_7, "ScrollView")

	local var_6_8 = arg_6_0._tf

	arg_6_0.emptyPanel = var_2.Find(var_6_8, "EmptyPanel")

	local var_6_9 = arg_6_0._tf

	arg_6_0.downloadBtnPanel = var_2.Find(var_6_9, "UpdatePanel")

	local var_6_10 = arg_6_0._tf

	arg_6_0.mangaContainer = var_2.Find(var_6_10, "ScrollView/Content")

	local var_6_11 = arg_6_0._tf
	local var_6_12 = var_2.Find(var_6_11, "ScrollView/Content")

	arg_6_0.lScrollRectSC = var_2.GetComponent(var_6_12, "LScrollRect")

	local var_6_13 = arg_6_0._tf

	arg_6_0.mangaTpl = var_2.Find(var_6_13, "MangaTpl")

	local var_6_14 = arg_6_0.lScrollRectSC

	var_2.BeginLayout(var_6_14)

	local var_6_15 = arg_6_0.lScrollRectSC

	var_2.EndLayout(var_6_15)
	arg_6_0:initUIText()

	return
end

function var_0_1.initUIText(arg_7_0)
	local var_7_0 = arg_7_0.readFilteBtn
	local var_7_1 = var_1.Find(var_7_0, "ShowingAll/Text")
	local var_7_2 = arg_7_0.readFilteBtn
	local var_7_3 = var_2.Find(var_7_2, "ShowingNotRead/Text")
	local var_7_4 = arg_7_0.mangaTpl
	local var_7_5 = var_3.Find(var_7_4, "Content/Bottom/BottomNotRead/Tag/Text")
	local var_7_6 = arg_7_0.emptyPanel
	local var_7_7 = var_4.Find(var_7_6, "Text")

	setText = var_7_4

	local var_7_8 = var_7_1

	i18n = var_1_10008

	var_7_4(var_7_8, var_1_10008("cartoon_notall"))

	setText = var_7_4

	local var_7_9 = var_7_3

	i18n = var_8

	var_7_4(var_7_9, var_8("cartoon_notall"))

	setText = var_7_4

	local var_7_10 = var_7_5

	i18n = var_8

	var_7_4(var_7_10, var_8("cartoon_notall"))

	setText = var_7_4

	local var_7_11 = var_7_7

	i18n = var_8

	var_7_4(var_7_11, var_8("cartoon_haveno"))

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.likeFilteBtn

	local function var_8_2()
		arg_8_0.isShowLike = not arg_8_0.isShowLike

		local var_9_0 = arg_8_0
		local var_9_1 = arg_8_0

		var_9_0.mangaIDListForShow = var_1.getMangaIDListForShow(var_9_1)

		local var_9_2 = arg_8_0

		var_0.updateBtnList(var_9_2)

		local var_9_3 = arg_8_0

		var_0.updatePanel(var_9_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.readFilteBtn

	local function var_8_5()
		arg_8_0.isShowNotRead = not arg_8_0.isShowNotRead

		local var_10_0 = arg_8_0
		local var_10_1 = arg_8_0

		var_10_0.mangaIDListForShow = var_1.getMangaIDListForShow(var_10_1)

		local var_10_2 = arg_8_0

		var_0.updateBtnList(var_10_2)

		local var_10_3 = arg_8_0

		var_0.updatePanel(var_10_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.orderBtn

	local function var_8_8()
		arg_8_0.isUpOrder = not arg_8_0.isUpOrder

		local var_11_0 = arg_8_0
		local var_11_1 = arg_8_0

		var_11_0.mangaIDListForShow = var_1.getMangaIDListForShow(var_11_1)

		local var_11_2 = arg_8_0

		var_0.updateBtnList(var_11_2)

		local var_11_3 = arg_8_0

		var_0.updatePanel(var_11_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.repairBtn

	local function var_8_11()
		local var_12_0 = {}

		i18n = var_2_10001
		var_12_0.text = var_2_10001("msgbox_repair")

		function var_12_0.onCallback()
			PathMgr = var_3_10000

			local var_13_0 = var_3_10000.FileExists

			Application = var_3_10002

			if var_13_0(var_3_10002.persistentDataPath .. "/hashes-manga.csv") then
				local var_13_1 = arg_8_0.group

				var_0.StartVerifyForLua(var_13_1)
			else
				pg = var_0

				local var_13_2 = var_0.TipsMgr.GetInstance()
				local var_13_3 = var_0.ShowTips

				i18n = var_3

				var_13_3(var_13_2, var_3("word_no_cache"))
			end

			return
		end

		IsUnityEditor = var_1

		if var_1 then
			PlayerPrefs = var_1

			var_1.SetInt("mangaVersion", 0)
		end

		pg = var_1

		local var_12_1 = var_1.MsgboxMgr.GetInstance()
		local var_12_2 = var_1.ShowMsgBox
		local var_12_3 = {
			hideYes = true
		}

		i18n = var_2_10005
		var_12_3.content = var_2_10005("resource_verify_warn")
		var_12_3.custom = {
			var_12_0
		}

		var_12_2(var_12_1, var_12_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10006)

	return
end

function var_0_1.updateMangaTpl(arg_14_0, arg_14_1, arg_14_2)
	tf = var_1_10003

	local var_14_0 = var_1_10003(arg_14_2)
	local var_14_1 = arg_14_0.mangaIDListForShow[arg_14_1]

	assert = var_5

	var_5(var_14_1, "null mangaID")

	local var_14_2 = var_14_0:Find("Update")

	setActive = var_1_10006

	var_1_10006(var_14_2, false)

	local var_14_3 = var_14_0:Find("Content/Mask/Pic")
	local var_14_4 = var_14_0:Find("Content/Bottom/BottomNew")
	local var_14_5 = var_14_0:Find("Content/Bottom/BottomNotRead")
	local var_14_6 = var_14_0:Find("Content/Bottom/BottomNormal")
	local var_14_7 = var_14_0:Find("Content/Bottom/BottomTip")
	local var_14_8 = var_14_0:Find("TopSpecial")
	local var_14_9 = var_14_4:Find("NumText")
	local var_14_10 = var_14_5
	local var_14_11 = var_14_5.Find(var_14_10, "NumText")
	local var_14_12 = var_14_6
	local var_14_13 = var_14_6.Find(var_14_12, "NumText")

	MangaConst = var_14_10

	local var_14_14 = var_14_10.isMangaEverReadByID(var_14_1)

	MangaConst = var_14_12

	local var_14_15 = var_14_12.isMangaNewByID(var_14_1)

	setActive = var_17

	var_17(var_14_7, false)

	setActive = var_17

	var_17(var_14_4, not var_14_14)

	setActive = var_17

	var_17(var_14_5, false)

	setActive = var_17

	var_17(var_14_6, var_14_14)

	setActive = var_17

	var_17(var_14_8, not var_14_14)

	setText = var_17

	local var_14_16 = var_14_9
	local var_14_17 = "#"

	pg = var_1_10021

	var_17(var_14_16, var_14_17 .. var_1_10021.cartoon[var_14_1].cartoon_id)

	setText = var_17

	local var_14_18 = var_14_11
	local var_14_19 = "#"

	pg = var_21

	var_17(var_14_18, var_14_19 .. var_21.cartoon[var_14_1].cartoon_id)

	setText = var_17

	local var_14_20 = var_14_13
	local var_14_21 = "#"

	pg = var_21

	var_17(var_14_20, var_14_21 .. var_21.cartoon[var_14_1].cartoon_id)

	removeOnButton = var_17

	var_17(var_14_0)

	onButton = var_17

	local var_14_22 = arg_14_0
	local var_14_23 = var_14_0

	local function var_14_24()
		local var_15_0 = arg_14_0

		var_0.openMangaViewLayer(var_15_0, arg_14_1)

		return
	end

	SFX_PANEL = var_1_10022

	var_17(var_14_22, var_14_23, var_14_24, var_1_10022)

	pg = var_17

	local var_14_25 = var_17.cartoon[var_14_1].resource

	MangaConst = var_18

	local var_14_26 = var_18.MANGA_PATH_PREFIX .. var_14_25

	GetComponent = var_19

	local var_14_27 = var_19(var_14_3, "Image").sprite

	IsNil = var_14_23

	if not var_14_23(var_14_27) then
		if var_14_27.name ~= var_14_25 then
			local var_14_28 = arg_14_0.resLoader

			var_21.LoadSprite(var_14_28, var_14_26, var_14_25, var_14_3, false)
		end
	else
		local var_14_29 = arg_14_0.resLoader

		var_20.LoadSprite(var_14_29, var_14_26, var_14_25, var_14_3, false)
	end

	return
end

function var_0_1.initEmpty(arg_16_0, arg_16_1)
	tf = var_1_10002

	local var_16_0 = var_1_10002(arg_16_1)
	local var_16_1 = var_2.Find(var_16_0, "TopSpecial")

	setActive = var_4

	var_4(var_16_1, false)

	local var_16_2 = var_2:Find("Content/Bottom/BottomNew")
	local var_16_3 = var_2:Find("Content/Bottom/BottomNotRead")
	local var_16_4 = var_2
	local var_16_5 = var_2.Find(var_16_4, "Content/Bottom/BottomNormal")
	local var_16_6 = var_2:Find("Content/Bottom/BottomTip")

	setActive = var_16_4

	var_16_4(var_16_2, false)

	setActive = var_16_4

	var_16_4(var_16_3, false)

	setActive = var_16_4

	var_16_4(var_16_5, false)

	setActive = var_16_4

	var_16_4(var_16_6, true)

	local var_16_7 = var_2:Find("Update")
	local var_16_8 = var_8.Find(var_16_7, "Btn")
	local var_16_9 = var_8
	local var_16_10 = var_8.Find(var_16_9, "Progress")
	local var_16_11 = var_10.Find(var_16_10, "Slider")

	setActive = var_16_9

	var_16_9(var_8, true)

	setActive = var_16_9

	var_16_9(var_16_8, true)

	setActive = var_16_9

	var_16_9(var_10, false)

	local var_16_12
	local var_16_13

	ipairs = var_14
	pg = var_1_10016

	for iter_16_0, iter_16_1 in var_14(var_1_10016.cartoon.all) do
		pg = var_1_10019
		var_1_10019 = var_1_10019.cartoon[iter_16_1].resource
		MangaConst = var_1_10020
		var_1_10020 = var_1_10020.MANGA_PATH_PREFIX .. var_1_10019
		checkABExist = var_21

		if var_21(var_1_10020) then
			var_16_12 = var_1_10019
			var_16_13 = var_1_10020

			break
		end
	end

	local var_16_14 = var_2:Find("Content/Mask/Pic")
	local var_16_15 = arg_16_0.resLoader

	var_15.LoadSprite(var_16_15, var_16_13, var_16_12, var_16_14, false)

	setText = var_15

	var_15(var_16_6:Find("Text"), "")

	onButton = var_15

	local var_16_16 = arg_16_0
	local var_16_17 = var_16_8

	local function var_16_18()
		local var_17_0 = arg_16_0.group.state

		DownloadState = var_2_10001

		if var_17_0 ~= var_2_10001.None then
			DownloadState = var_1

			if var_17_0 == var_1.CheckFailure then
				local var_17_1 = arg_16_0.group

				var_1.CheckD(var_17_1)

				goto label_17_0
			end

			DownloadState = var_1

			if var_17_0 ~= var_1.CheckToUpdate then
				DownloadState = var_1

				if var_17_0 == var_1.UpdateFailure then
					GroupHelper = var_1

					local var_17_2 = var_1.GetGroupSize(var_0_1.MangaGroupName)

					HashUtil = var_2_10002

					local var_17_3 = var_2_10002.BytesToString(var_17_2)

					pg = var_3

					local var_17_4 = var_3.MsgboxMgr.GetInstance()
					local var_17_5 = var_3.ShowMsgBox
					local var_17_6 = {}

					MSGBOX_TYPE_NORMAL = var_2_10007
					var_17_6.type = var_2_10007
					string = var_2_10007

					local var_17_7 = var_2_10007.format

					i18n = var_2_10009
					var_17_6.content = var_17_7(var_2_10009("group_download_tip", var_17_3))

					function var_17_6.onYes()
						local var_18_0 = arg_16_0.group

						var_0.UpdateD(var_18_0)

						return
					end

					var_17_5(var_17_4, var_17_6)
				end

				::label_17_0::

				return
			end
		end
	end

	SFX_PANEL = var_20

	var_15(var_16_16, var_16_17, var_16_18, var_20)
	arg_16_0:startUpdateEmpty(arg_16_1)

	return
end

function var_0_1.updateEmpty(arg_19_0, arg_19_1)
	tf = var_1_10002

	local var_19_0 = var_1_10002(arg_19_1)
	local var_19_1 = var_2.Find(var_19_0, "Update")
	local var_19_2 = var_3.Find(var_19_1, "Btn")
	local var_19_3 = var_4.Find(var_19_2, "Text")
	local var_19_4 = var_3:Find("Progress")
	local var_19_5 = var_6.Find(var_19_4, "Slider")
	local var_19_6 = arg_19_0.group.state

	DownloadState = var_19_4

	if var_19_6 == var_19_4.None then
		setText = var_9

		var_9(var_19_3, "None")

		setActive = var_9

		var_9(var_4, true)

		setActive = var_9

		var_9(var_6, false)
	else
		DownloadState = var_9

		if var_19_6 == var_9.Checking then
			setText = var_9

			local var_19_7 = var_19_3

			i18n = var_1_10012

			var_9(var_19_7, var_1_10012("word_manga_checking"))

			setActive = var_9

			var_9(var_4, true)

			setActive = var_9

			var_9(var_6, false)
		else
			DownloadState = var_9

			if var_19_6 == var_9.CheckToUpdate then
				setText = var_9

				local var_19_8 = var_19_3

				i18n = var_1_10012

				var_9(var_19_8, var_1_10012("word_manga_checktoupdate"))

				setActive = var_9

				var_9(var_4, true)

				setActive = var_9

				var_9(var_6, false)
			else
				DownloadState = var_9

				if var_19_6 == var_9.CheckOver then
					setText = var_9

					var_9(var_19_3, "Latest Ver")

					setActive = var_9

					var_9(var_4, true)

					setActive = var_9

					var_9(var_6, false)
				else
					DownloadState = var_9

					if var_19_6 == var_9.CheckFailure then
						setText = var_9

						local var_19_9 = var_19_3

						i18n = var_1_10012

						var_9(var_19_9, var_1_10012("word_manga_checkfailure"))

						setActive = var_9

						var_9(var_4, true)

						setActive = var_9

						var_9(var_6, false)
					else
						DownloadState = var_9

						if var_19_6 == var_9.Updating then
							setText = var_9

							local var_19_10 = var_19_3

							i18n = var_1_10012

							var_9(var_19_10, var_1_10012("word_manga_updating", arg_19_0.group.downloadCount, arg_19_0.group.downloadTotal))

							setActive = var_9

							var_9(var_4, false)

							setActive = var_9

							var_9(var_6, true)

							setSlider = var_9

							var_9(var_19_5, 0, arg_19_0.group.downloadTotal, arg_19_0.group.downloadCount)
						else
							DownloadState = var_9

							if var_19_6 == var_9.UpdateSuccess then
								setText = var_9

								local var_19_11 = var_19_3

								i18n = var_1_10012

								var_9(var_19_11, var_1_10012("word_manga_updatesuccess"))

								setActive = var_9

								var_9(var_4, true)

								setActive = var_9

								var_9(var_6, false)

								arg_19_0.mangaIDListForShow = arg_19_0:getMangaIDListForShow()

								arg_19_0:updatePanel()
							else
								DownloadState = var_9

								if var_19_6 == var_9.UpdateFailure then
									setText = var_9

									local var_19_12 = var_19_3

									i18n = var_1_10012

									var_9(var_19_12, var_1_10012("word_manga_updatefailure"))

									setActive = var_9

									var_9(var_4, true)

									setActive = var_9

									var_9(var_6, false)
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.startUpdateEmpty(arg_20_0, arg_20_1)
	if arg_20_0.timer then
		local var_20_0 = arg_20_0.timer

		var_2.Stop(var_20_0)
	end

	Timer = var_2
	arg_20_0.timer = var_2.New(function()
		local var_21_0 = arg_20_0

		var_0.updateEmpty(var_21_0, arg_20_1)

		return
	end, 0.5, -1)

	local var_20_1 = arg_20_0.timer

	var_2.Start(var_20_1)
	arg_20_0:updateEmpty(arg_20_1)

	return
end

function var_0_1.stopUpdateEmpty(arg_22_0, arg_22_1)
	if arg_22_0.timer then
		local var_22_0 = arg_22_0.timer

		var_2.Stop(var_22_0)
	end

	return
end

function var_0_1.updateMangaList(arg_23_0)
	local var_23_0 = arg_23_0.resLoader

	var_1.Clear(var_23_0)

	function arg_23_0.lScrollRectSC.onReturnItem(arg_24_0, arg_24_1)
		arg_24_0 = arg_24_0 + 1

		if arg_23_0.mangaIDListForShow[arg_24_0] == false then
			local var_24_0 = arg_23_0

			var_3.stopUpdateEmpty(var_24_0, arg_24_1)
		end

		return
	end

	function arg_23_0.lScrollRectSC.onUpdateItem(arg_25_0, arg_25_1)
		arg_25_0 = arg_25_0 + 1

		if arg_23_0.mangaIDListForShow[arg_25_0] == false then
			local var_25_0 = arg_23_0

			var_3.initEmpty(var_25_0, arg_25_1)

			local var_25_1 = arg_23_0

			var_3.updateEmpty(var_25_1, arg_25_1)
		else
			local var_25_2 = arg_23_0

			var_3.updateMangaTpl(var_25_2, arg_25_0, arg_25_1)
		end

		return
	end

	local var_23_1 = arg_23_0.lScrollRectSC

	var_1.SetTotalCount(var_23_1, #arg_23_0.mangaIDListForShow)

	return
end

function var_0_1.initDownloadBtnPanel(arg_26_0)
	local var_26_0 = arg_26_0.downloadBtnPanel
	local var_26_1 = var_1.Find(var_26_0, "Btn")
	local var_26_2 = var_1.Find(var_26_1, "Text")
	local var_26_3 = arg_26_0.downloadBtnPanel
	local var_26_4 = var_3.Find(var_26_3, "Progress")
	local var_26_5 = var_3.Find(var_26_4, "Slider")

	setActive = var_26_3

	var_26_3(var_1, true)

	setActive = var_26_3

	var_26_3(var_3, false)

	onButton = var_26_3

	local var_26_6 = arg_26_0
	local var_26_7 = var_1

	local function var_26_8()
		local var_27_0 = arg_26_0.group.state

		DownloadState = var_2_10001

		if var_27_0 ~= var_2_10001.None then
			DownloadState = var_1

			if var_27_0 == var_1.CheckFailure then
				local var_27_1 = arg_26_0.group

				var_1.CheckD(var_27_1)

				goto label_27_0
			end

			DownloadState = var_1

			if var_27_0 ~= var_1.CheckToUpdate then
				DownloadState = var_1

				if var_27_0 == var_1.UpdateFailure then
					GroupHelper = var_1

					local var_27_2 = var_1.GetGroupSize(var_0_1.MangaGroupName)

					HashUtil = var_2_10002

					local var_27_3 = var_2_10002.BytesToString(var_27_2)

					pg = var_3

					local var_27_4 = var_3.MsgboxMgr.GetInstance()
					local var_27_5 = var_3.ShowMsgBox
					local var_27_6 = {}

					MSGBOX_TYPE_NORMAL = var_2_10007
					var_27_6.type = var_2_10007
					string = var_2_10007

					local var_27_7 = var_2_10007.format

					i18n = var_2_10009
					var_27_6.content = var_27_7(var_2_10009("group_download_tip", var_27_3))

					function var_27_6.onYes()
						local var_28_0 = arg_26_0.group

						var_0.UpdateD(var_28_0)

						return
					end

					var_27_5(var_27_4, var_27_6)
				end

				::label_27_0::

				return
			end
		end
	end

	SFX_PANEL = var_1_10010

	var_26_3(var_26_6, var_26_7, var_26_8, var_1_10010)
	arg_26_0:startUpdateDownloadBtnPanel()

	return
end

function var_0_1.updateDownloadBtnPanel(arg_29_0)
	local var_29_0 = arg_29_0.downloadBtnPanel
	local var_29_1 = var_1.Find(var_29_0, "Btn")
	local var_29_2 = var_1.Find(var_29_1, "Text")
	local var_29_3 = arg_29_0.downloadBtnPanel
	local var_29_4 = var_3.Find(var_29_3, "Progress")
	local var_29_5 = var_3.Find(var_29_4, "Slider")
	local var_29_6 = arg_29_0.group.state

	DownloadState = var_29_4

	if var_29_6 == var_29_4.None then
		setText = var_6

		var_6(var_29_2, "None")

		setActive = var_6

		var_6(var_1, true)

		setActive = var_6

		var_6(var_3, false)
	else
		DownloadState = var_6

		if var_29_6 == var_6.Checking then
			setText = var_6

			local var_29_7 = var_29_2

			i18n = var_1_10009

			var_6(var_29_7, var_1_10009("word_manga_checking"))

			setActive = var_6

			var_6(var_1, true)

			setActive = var_6

			var_6(var_3, false)
		else
			DownloadState = var_6

			if var_29_6 == var_6.CheckToUpdate then
				setText = var_6

				local var_29_8 = var_29_2

				i18n = var_1_10009

				var_6(var_29_8, var_1_10009("word_manga_checktoupdate"))

				setActive = var_6

				var_6(var_1, true)

				setActive = var_6

				var_6(var_3, false)
			else
				DownloadState = var_6

				if var_29_6 == var_6.CheckOver then
					setText = var_6

					var_6(var_29_2, "Latest Ver")

					setActive = var_6

					var_6(var_1, true)

					setActive = var_6

					var_6(var_3, false)
				else
					DownloadState = var_6

					if var_29_6 == var_6.CheckFailure then
						setText = var_6

						local var_29_9 = var_29_2

						i18n = var_1_10009

						var_6(var_29_9, var_1_10009("word_manga_checkfailure"))

						setActive = var_6

						var_6(var_1, true)

						setActive = var_6

						var_6(var_3, false)
					else
						DownloadState = var_6

						if var_29_6 == var_6.Updating then
							setText = var_6

							local var_29_10 = var_29_2

							i18n = var_1_10009

							var_6(var_29_10, var_1_10009("word_manga_updating", arg_29_0.group.downloadCount, arg_29_0.group.downloadTotal))

							setActive = var_6

							var_6(var_1, false)

							setActive = var_6

							var_6(var_3, true)

							setSlider = var_6

							var_6(var_29_5, 0, arg_29_0.group.downloadTotal, arg_29_0.group.downloadCount)
						else
							DownloadState = var_6

							if var_29_6 == var_6.UpdateSuccess then
								setText = var_6

								local var_29_11 = var_29_2

								i18n = var_1_10009

								var_6(var_29_11, var_1_10009("word_manga_updatesuccess"))

								setActive = var_6

								var_6(var_1, true)

								setActive = var_6

								var_6(var_3, false)

								arg_29_0.mangaIDListForShow = arg_29_0:getMangaIDListForShow()

								arg_29_0:updatePanel()
							else
								DownloadState = var_6

								if var_29_6 == var_6.UpdateFailure then
									setText = var_6

									local var_29_12 = var_29_2

									i18n = var_1_10009

									var_6(var_29_12, var_1_10009("word_manga_updatefailure"))

									setActive = var_6

									var_6(var_1, true)

									setActive = var_6

									var_6(var_3, false)
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.startUpdateDownloadBtnPanel(arg_30_0)
	if arg_30_0.timer then
		local var_30_0 = arg_30_0.timer

		var_1.Stop(var_30_0)
	end

	Timer = var_1
	arg_30_0.timer = var_1.New(function()
		local var_31_0 = arg_30_0

		var_0.updateDownloadBtnPanel(var_31_0)

		return
	end, 0.5, -1)

	local var_30_1 = arg_30_0.timer

	var_1.Start(var_30_1)
	arg_30_0:updateDownloadBtnPanel()

	return
end

function var_0_1.stopUpdateDownloadBtnPanel(arg_32_0)
	if arg_32_0.timer then
		local var_32_0 = arg_32_0.timer

		var_1.Stop(var_32_0)
	end

	return
end

function var_0_1.updatePanel(arg_33_0)
	local var_33_0 = #arg_33_0.mangaIDListForShow <= 0
	local var_33_1 = #arg_33_0.mangaIDListForShow == 1 and arg_33_0.mangaIDListForShow[1] == false

	setActive = var_1_10003

	var_1_10003(arg_33_0.emptyPanel, var_33_0)

	setActive = var_1_10003

	var_1_10003(arg_33_0.downloadBtnPanel, var_33_1)

	setActive = var_1_10003

	var_1_10003(arg_33_0.scrollView, not var_33_0 and not var_33_1)
	arg_33_0:stopUpdateEmpty()
	arg_33_0:stopUpdateDownloadBtnPanel()

	if not var_33_0 and not var_33_1 then
		arg_33_0:updateMangaList()
	elseif var_33_1 then
		arg_33_0:initDownloadBtnPanel()
	end

	return
end

function var_0_1.updateBtnList(arg_34_0)
	local var_34_0 = arg_34_0.likeFilteBtn
	local var_34_1 = var_1.Find(var_34_0, "On")

	setActive = var_1_10002

	var_1_10002(var_34_1, arg_34_0.isShowLike)

	local var_34_2 = arg_34_0.readFilteBtn
	local var_34_3 = var_2.Find(var_34_2, "ShowingAll")
	local var_34_4 = arg_34_0.readFilteBtn
	local var_34_5 = var_3.Find(var_34_4, "ShowingNotRead")

	setActive = var_34_2

	var_34_2(var_34_3, not arg_34_0.isShowNotRead)

	setActive = var_34_2

	var_34_2(var_34_5, arg_34_0.isShowNotRead)

	local var_34_6 = arg_34_0.orderBtn
	local var_34_7 = var_4.Find(var_34_6, "Up")
	local var_34_8 = arg_34_0.orderBtn
	local var_34_9 = var_5.Find(var_34_8, "Down")

	setActive = var_34_6

	var_34_6(var_34_7, arg_34_0.isUpOrder)

	setActive = var_34_6

	var_34_6(var_34_9, not arg_34_0.isUpOrder)

	return
end

function var_0_1.tryShowTipMsgBox(arg_35_0)
	local var_35_0 = arg_35_0.appreciateProxy

	if var_1.isMangaHaveNewRes(var_35_0) then
		local function var_35_1()
			PlayerPrefs = var_2_10000

			local var_36_0 = var_2_10000.SetInt
			local var_36_1 = "mangaVersion"

			MangaConst = var_2_10003

			var_36_0(var_36_1, var_2_10003.Version)

			local var_36_2 = arg_35_0
			local var_36_3 = var_0.emit

			CollectionScene = var_3

			var_36_3(var_36_2, var_3.UPDATE_RED_POINT)

			return
		end

		pg = var_35_0

		local var_35_2 = var_35_0.MsgboxMgr.GetInstance()
		local var_35_3 = var_3.ShowMsgBox
		local var_35_4 = {
			hideNo = true,
			hideClose = true
		}

		i18n = var_1_10007

		local var_35_5 = "res_cartoon_new_tip"

		MangaConst = var_1_10010
		var_35_4.content = var_1_10007(var_35_5, var_1_10010.NewCount)
		var_35_4.onYes = var_35_1
		var_35_4.onCancel = var_35_1
		var_35_4.onClose = var_35_1

		var_35_3(var_35_2, var_35_4)
	end

	return
end

function var_0_1.openMangaViewLayer(arg_37_0, arg_37_1)
	LoadContextCommand = var_1_10002

	local var_37_0 = var_1_10002.LoadLayerOnTopContext

	Context = var_1_10004

	local var_37_1 = var_1_10004.New
	local var_37_2 = {}

	MangaFullScreenMediator = var_1_10007
	var_37_2.mediator = var_1_10007
	MangaFullScreenLayer = var_1_10007
	var_37_2.viewComponent = var_1_10007

	local var_37_3 = {
		mangaIndex = arg_37_1,
		mangaIDLIst = arg_37_0.mangaIDListForShow,
		mangaContext = arg_37_0
	}

	isActive = var_8

	local var_37_4 = arg_37_0.readFilteBtn

	var_37_3.isShowingNotRead = var_8(var_10.Find(var_37_4, "ShowingNotRead"))
	var_37_2.data = var_37_3

	function var_37_2.onRemoved()
		return
	end

	var_37_0(var_37_1(var_37_2))

	return
end

function var_0_1.updateLineAfterRead(arg_39_0, arg_39_1)
	table = var_1_10002

	local var_39_0 = var_1_10002.indexof(arg_39_0.mangaIDListForShow, arg_39_1) - 1
	local var_39_1 = arg_39_0.mangaContainer
	local var_39_2 = var_3.Find

	tostring = var_1_10006

	if var_39_2(var_39_1, var_1_10006(var_39_0)) then
		local var_39_3 = var_3:Find("Content/Bottom/BottomNew")
		local var_39_4 = var_3:Find("Content/Bottom/BottomNotRead")
		local var_39_5 = var_3
		local var_39_6 = var_3.Find(var_39_5, "Content/Bottom/BottomNormal")
		local var_39_7 = var_3
		local var_39_8 = var_3.Find(var_39_7, "TopSpecial")

		MangaConst = var_39_5

		local var_39_9 = var_39_5.isMangaEverReadByID(arg_39_1)

		MangaConst = var_39_7

		local var_39_10 = var_39_7.isMangaNewByID(arg_39_1)

		setActive = var_10

		var_10(var_39_3, var_39_10 and not var_39_9)

		setActive = var_10

		var_10(var_39_4, not var_39_10 and not var_39_9)

		setActive = var_10

		var_10(var_39_6, var_39_9)

		setActive = var_10

		var_10(var_39_8, not var_39_9)
	end

	return
end

function var_0_1.updateToMangaID(arg_40_0, arg_40_1)
	table = var_1_10002

	local var_40_0 = var_1_10002.indexof(arg_40_0.mangaIDListForShow, arg_40_1) - 1
	local var_40_1 = arg_40_0.lScrollRectSC
	local var_40_2 = var_3.HeadIndexToValue(var_40_1, var_40_0)
	local var_40_3 = arg_40_0.lScrollRectSC
	local var_40_4 = var_4.SetTotalCount
	local var_40_5 = #arg_40_0.mangaIDListForShow

	defaultValue = var_1_10008

	var_40_4(var_40_3, var_40_5, var_1_10008(var_40_2, -1))

	return
end

function var_0_1.getMangaIDListForShow(arg_41_0, arg_41_1)
	local var_41_0 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_41_0, iter_41_1 in var_1_10003(var_1_10005.cartoon.all) do
		if arg_41_0:isMangaExist(iter_41_1) then
			MangaConst = var_8

			local var_41_1 = var_8.isMangaEverReadByID(iter_41_1)

			MangaConst = var_1_10009
			var_1_10009 = var_1_10009.isMangaLikeByID(iter_41_1)

			if arg_41_0.isShowNotRead and arg_41_0.isShowLike then
				if not var_41_1 and var_1_10009 then
					table = var_10

					var_10.insert(var_41_0, iter_41_1)
				end
			elseif arg_41_0.isShowNotRead and not arg_41_0.isShowLike then
				if not var_41_1 then
					table = var_10

					var_10.insert(var_41_0, iter_41_1)
				end
			elseif not arg_41_0.isShowNotRead and arg_41_0.isShowLike then
				if var_1_10009 then
					table = var_10

					var_10.insert(var_41_0, iter_41_1)
				end
			else
				table = var_10

				var_10.insert(var_41_0, iter_41_1)
			end
		end
	end

	local function var_41_2(arg_42_0, arg_42_1)
		pg = var_2_10002

		local var_42_0 = var_2_10002.cartoon[arg_42_0]

		pg = var_2_10003

		local var_42_1 = var_2_10003.cartoon[arg_42_1]
		local var_42_2 = var_42_0.cartoon_id

		if var_42_1.cartoon_id < var_42_2 then
			return not arg_41_0.isUpOrder
		elseif var_42_2 == var_5 then
			return arg_42_0 < arg_42_1
		elseif var_42_2 < var_5 then
			return arg_41_0.isUpOrder
		end

		return
	end

	table = var_4

	var_4.sort(var_41_0, var_41_2)

	if arg_41_0:isNeedShowDownBtn() then
		table = var_4

		var_4.insert(var_41_0, 1, false)
	end

	return var_41_0
end

function var_0_1.isMangaExist(arg_43_0, arg_43_1)
	MangaConst = var_1_10002

	local var_43_0 = var_1_10002.MANGA_PATH_PREFIX .. arg_43_1
	local var_43_1 = arg_43_0.group
	local var_43_2 = var_3.CheckF(var_43_1, var_43_0)

	DownloadState = var_1_10004

	local var_43_3

	if var_43_2 ~= var_1_10004.None then
		DownloadState = var_4

		if var_43_2 ~= var_4.UpdateSuccess then
			var_43_3 = false

			goto label_43_0
		end
	end

	var_43_3 = true

	::label_43_0::

	return var_43_3
end

function var_0_1.isNeedShowDownBtn(arg_44_0)
	Application = var_1_10001

	if var_1_10001.isEditor then
		return false
	end

	GroupHelper = var_1

	if var_1.IsGroupVerLastest(var_0_1.MangaGroupName) then
		return false
	end

	GroupHelper = var_1

	if not var_1.IsGroupWaitToUpdate(var_0_1.MangaGroupName) then
		return false
	end

	return true
end

return var_0_1
