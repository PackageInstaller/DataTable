class = var_0_10000

local var_0_0 = "Doa2MedalCollectionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.FADE_OUT_TIME = 1
var_0_1.PAGE_NUM = 9
var_0_1.MEDAL_NUM_PER_PAGE = 2

local var_0_2 = "ui/doa2medalcollectionui_atlas"

function var_0_1.getUIName(arg_1_0)
	return "Doa2MedalCollectionUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:checkAward()

	if arg_3_0.activeIDList then
		setText = var_1

		local var_3_0 = arg_3_0.progressText

		setColorStr = var_1_10003
		tostring = var_1_10004

		local var_3_1 = var_1_10004(#arg_3_0.activeIDList)

		COLOR_WHITE = var_5

		var_1(var_3_0, var_1_10003(var_3_1, var_5) .. "/" .. #arg_3_0.allIDList)
	end

	triggerToggle = var_1

	var_1(arg_3_0.switchBtnList[1], true)

	return
end

function var_0_1.willExit(arg_4_0)
	LeanTween = var_1_10001

	local var_4_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_4_0(var_1_10002(arg_4_0.picture)) then
		LeanTween = var_1

		local var_4_1 = var_1.cancel

		go = var_2

		var_4_1(var_2(arg_4_0.picture), false)
	end

	return
end

function var_0_1.getBGM(arg_5_0)
	return "doa-az-story-1"
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002
	arg_6_0.activityProxy = var_1_10001(var_1_10002)

	local var_6_0 = arg_6_0.activityProxy
	local var_6_1 = var_1.getActivityById

	ActivityConst = var_1_10003
	arg_6_0.activityData = var_6_1(var_6_0, var_1_10003.DOA_MEDAL_ACT_ID)

	if not arg_6_0.activityData then
		return
	end

	local var_6_2 = arg_6_0.activityData

	arg_6_0.allIDList = var_1.GetPicturePuzzleIds(var_6_2)
	arg_6_0.pageIDList = {}

	for iter_6_0 = 1, var_0_1.PAGE_NUM do
		arg_6_0.pageIDList[iter_6_0] = {}

		for iter_6_1 = 1, var_0_1.MEDAL_NUM_PER_PAGE do
			arg_6_0.pageIDList[iter_6_0][iter_6_1] = arg_6_0.allIDList[(iter_6_0 - 1) * var_0_1.MEDAL_NUM_PER_PAGE + iter_6_1]
		end
	end

	local var_6_3

	if not arg_6_0.activityData or not arg_6_0.activityData.data1_list then
		var_6_3 = {}
	end

	arg_6_0.activatableIDList = var_6_3

	local var_6_4

	if arg_6_0.activityData then
		var_6_4 = arg_6_0.activityData.data2_list
	end

	arg_6_0.activeIDList = var_6_4
	arg_6_0.curPage = nil
	arg_6_0.newMedalID = nil

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf
	local var_7_2 = var_1.Find(var_7_1, "NotchAdapt")

	arg_7_0.backBtn = var_1.Find(var_7_2, "BackBtn")
	arg_7_0.progressText = var_1:Find("ProgressImg/ProgressText")
	arg_7_0.helpBtn = var_1:Find("HelpBtn")

	local var_7_3 = arg_7_0._tf
	local var_7_4 = var_2.Find(var_7_3, "SwitchBtnList")

	findTF = var_7_3
	arg_7_0.tplButtom = var_7_3(var_7_4, "tplButtom")
	setActive = var_3

	var_3(arg_7_0.tplButtom, false)

	arg_7_0.imgGot = var_1:Find("ProgressImg/got")
	arg_7_0.switchBtnList = {}
	arg_7_0.medalTfList = {}

	for iter_7_0 = 1, var_0_1.PAGE_NUM do
		tf = var_1_10007
		instantiate = var_1_10008
		go = var_1_10009
		var_1_10007 = var_1_10007(var_1_10008(var_1_10009(arg_7_0.tplButtom)))
		LoadSpriteAtlasAsync = var_1_10008

		var_1_10008(var_0_2, "ship" .. iter_7_0 .. "Icon", function(arg_8_0)
			if var_1_10007 then
				setImageSprite = var_1
				findTF = var_2_10002

				var_1(var_2_10002(var_1_10007, "icon"), arg_8_0, true)
			end

			return
		end)

		LoadSpriteAtlasAsync = var_1_10008

		var_1_10008(var_0_2, "ship" .. iter_7_0 .. "Name", function(arg_9_0)
			if var_1_10007 then
				setImageSprite = var_1
				findTF = var_2_10002

				var_1(var_2_10002(var_1_10007, "name"), arg_9_0, true)
			end

			return
		end)

		LoadSpriteAtlasAsync = var_1_10008

		var_1_10008(var_0_2, "ship" .. iter_7_0 .. "NameSelect", function(arg_10_0)
			if var_1_10007 then
				setImageSprite = var_1
				findTF = var_2_10002

				var_1(var_2_10002(var_1_10007, "nameSelect"), arg_10_0, true)
			end

			return
		end)

		setParent = var_1_10008

		var_1_10008(var_1_10007, var_7_4)

		setActive = var_1_10008

		var_1_10008(var_1_10007, true)

		table = var_1_10008

		var_1_10008.insert(arg_7_0.switchBtnList, var_1_10007)

		for iter_7_1 = 1, var_0_1.MEDAL_NUM_PER_PAGE do
			local var_7_5 = (iter_7_0 - 1) * var_0_1.MEDAL_NUM_PER_PAGE + iter_7_1

			findTF = var_13

			local var_7_6 = var_13(arg_7_0._tf, "MedalContainer/medal" .. var_7_5)

			setActive = var_14

			var_14(var_7_6, false)

			GetComponent = var_14
			findTF = var_15

			local var_7_7 = var_15(var_7_6, "disAcive/lock")

			typeof = var_16
			Image = var_17

			local var_7_8 = var_14(var_7_7, var_16(var_17))

			var_14.SetNativeSize(var_7_8)

			GetComponent = var_14
			findTF = var_7_8

			local var_7_9 = var_7_8(var_7_6, "disAcive/unlock")

			typeof = var_16
			Image = var_17

			local var_7_10 = var_14(var_7_9, var_16(var_17))

			var_14.SetNativeSize(var_7_10)

			table = var_14

			var_14.insert(arg_7_0.medalTfList, var_7_6)
		end
	end

	findTF = var_3
	arg_7_0.picture = var_3(arg_7_0._tf, "picture")
	findTF = var_3
	arg_7_0.pictureName = var_3(arg_7_0._tf, "picture/name")
	findTF = var_3
	arg_7_0.leftPage = var_3(arg_7_0._tf, "book/leftPage")
	findTF = var_3
	arg_7_0.rightPage = var_3(arg_7_0._tf, "book/rightPage")

	return
end

function var_0_1.addListener(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.backBtn

	local function var_11_2()
		local var_12_0 = arg_11_0

		var_0.closeView(var_12_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10005)

	onButton = var_1_10001

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.helpBtn

	local function var_11_5()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_13_2.type = var_2_10003
		pg = var_2_10003
		var_13_2.helps = var_2_10003.gametip.doa_collection.tip

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_11_3, var_11_4, var_11_5, var_1_10005)

	ipairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.switchBtnList) do
		onToggle = var_1_10006

		local var_11_6 = arg_11_0
		local var_11_7 = iter_11_1

		local function var_11_8(arg_14_0)
			if arg_14_0 == true then
				local var_14_0 = arg_11_0.curPage ~= iter_11_0

				arg_11_0.curPage = iter_11_0

				local var_14_1 = arg_11_0

				var_2.updateSwitchBtnTF(var_14_1)

				local var_14_2 = arg_11_0

				var_2.updateMedalContainerView(var_14_2, iter_11_0, var_14_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_11_6, var_11_7, var_11_8, var_1_10010)
	end

	return
end

function var_0_1.UpdateActivity(arg_15_0, arg_15_1)
	arg_15_0:checkAward()

	return
end

function var_0_1.updateMedalContainerView(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		setActive = var_1_10003

		var_1_10003(arg_16_0.picture, false)

		LoadSpriteAtlasAsync = var_1_10003

		var_1_10003(var_0_2, "pictureImage" .. arg_16_1, function(arg_17_0)
			setImageSprite = var_2_10001

			var_2_10001(arg_16_0.picture, arg_17_0, true)

			LeanTween = var_2_10001

			local var_17_0 = var_2_10001.isTweening

			go = var_2

			local var_17_1

			if var_17_0(var_2(arg_16_0.picture)) then
				LeanTween = var_17_1
				var_17_1 = var_17_1.cancel
				go = var_2

				var_17_1(var_2(arg_16_0.picture), false)
			end

			LeanTween = var_17_1

			local var_17_2 = var_17_1.value

			go = var_2

			local var_17_3 = var_17_2(var_2(arg_16_0.picture), 0, 1, 0.3)
			local var_17_4 = var_1.setOnUpdate

			System = var_3

			var_17_4(var_17_3, var_3.Action_float(function(arg_18_0)
				GetComponent = var_3_10001

				local var_18_0 = arg_16_0.picture

				typeof = var_3_10003
				CanvasGroup = var_3_10004
				var_3_10001(var_18_0, var_3_10003(var_3_10004)).alpha = arg_18_0

				return
			end))

			setActive = var_17_4

			var_17_4(arg_16_0.picture, true)

			return
		end)
	else
		setActive = var_1_10003

		var_1_10003(arg_16_0.picture, true)

		LoadSpriteAtlasAsync = var_1_10003

		var_1_10003(var_0_2, "pictureImage" .. arg_16_1, function(arg_19_0)
			setImageSprite = var_2_10001

			var_2_10001(arg_16_0.picture, arg_19_0, true)

			return
		end)
	end

	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003(var_0_2, "pictureName" .. arg_16_1, function(arg_20_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_16_0.pictureName, arg_20_0, true)

		return
	end)

	for iter_16_0 = 1, #arg_16_0.medalTfList do
		local var_16_0 = (arg_16_1 - 1) * var_0_1.MEDAL_NUM_PER_PAGE
		local var_16_1 = (arg_16_1 - 1) * var_0_1.MEDAL_NUM_PER_PAGE + var_0_1.MEDAL_NUM_PER_PAGE

		if var_16_0 < iter_16_0 and iter_16_0 <= var_16_1 then
			setActive = var_9

			var_9(arg_16_0.medalTfList[iter_16_0], true)
		else
			setActive = var_9

			var_9(arg_16_0.medalTfList[iter_16_0], false)
		end
	end

	if arg_16_0.pageIDList then
		local var_16_2 = arg_16_0.pageIDList[arg_16_1]

		ipairs = var_4

		for iter_16_1, iter_16_2 in var_4(var_16_2) do
			arg_16_0:updateMedalView(var_16_2, iter_16_2)
		end
	end

	return
end

function var_0_1.updateMedalView(arg_21_0, arg_21_1, arg_21_2)
	table = var_1_10003

	local var_21_0 = var_1_10003.contains(arg_21_0.activeIDList, arg_21_2)

	table = var_4

	local var_21_1

	if var_4.contains(arg_21_0.activatableIDList, arg_21_2) then
		var_21_1 = not var_21_0
	end

	local var_21_2

	var_21_2 = not var_21_0 and not var_21_1
	table = var_6

	local var_21_3 = var_6.indexof(arg_21_1, arg_21_2, 1)
	local var_21_4 = (arg_21_0.curPage - 1) * var_0_1.MEDAL_NUM_PER_PAGE + var_21_3
	local var_21_5 = arg_21_0.medalTfList[var_21_4]

	if var_21_0 then
		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_21_5, "isActive"), true)

		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_21_5, "disAcive"), false)
	else
		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_21_5, "isActive"), false)

		setActive = var_9
		findTF = var_10

		var_9(var_10(var_21_5, "disAcive"), true)

		local var_21_6

		if var_21_1 then
			onButton = var_9
			var_21_6 = arg_21_0
			findTF = var_11

			local var_21_7 = var_11(var_21_5, "disAcive")

			local function var_21_8()
				pg = var_2_10000

				local var_22_0 = var_2_10000.m02
				local var_22_1 = var_0.sendNotification

				GAME = var_2_10002

				var_22_1(var_22_0, var_2_10002.MEMORYBOOK_UNLOCK, {
					id = arg_21_2,
					actId = arg_21_0.activityData.id
				})

				return
			end

			SFX_PANEL = var_13

			var_9(var_21_6, var_21_7, var_21_8, var_13)

			setActive = var_9
			findTF = var_21_6

			var_9(var_21_6(var_21_5, "disAcive/lock"), false)

			setActive = var_9
			findTF = var_21_6

			var_9(var_21_6(var_21_5, "disAcive/unlock"), true)
		else
			setActive = var_9
			findTF = var_21_6

			var_9(var_21_6(var_21_5, "disAcive/lock"), true)

			setActive = var_9
			findTF = var_10

			var_9(var_10(var_21_5, "disAcive/unlock"), false)
		end
	end

	return
end

function var_0_1.updateSwitchBtnTF(arg_23_0)
	setText = var_1_10001

	var_1_10001(arg_23_0.leftPage, (arg_23_0.curPage - 1) * var_0_1.MEDAL_NUM_PER_PAGE + 1)

	setText = var_1_10001

	var_1_10001(arg_23_0.rightPage, (arg_23_0.curPage - 1) * var_0_1.MEDAL_NUM_PER_PAGE + 2)

	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.switchBtnList) do
		local var_23_0 = iter_23_1:Find("Tip")
		local var_23_1 = arg_23_0

		if arg_23_0.caculateActivatable(var_23_1, iter_23_0) == 0 then
			setActive = var_23_1

			var_23_1(var_23_0, false)
		end

		if 0 < var_7 then
			setActive = var_8

			var_8(var_23_0, true)
		end
	end

	return
end

function var_0_1.updateAfterSubmit(arg_24_0, arg_24_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003
	arg_24_0.activityProxy = var_1_10002(var_1_10003)

	local var_24_0 = arg_24_0.activityProxy
	local var_24_1 = var_2.getActivityById

	ActivityConst = var_1_10004
	arg_24_0.activityData = var_24_1(var_24_0, var_1_10004.DOA2_MEDAL_ACT_ID)
	arg_24_0.activatableIDList = arg_24_0.activityData.data1_list
	arg_24_0.activeIDList = arg_24_0.activityData.data2_list
	arg_24_0.newMedalID = arg_24_1
	triggerToggle = var_2

	var_2(arg_24_0.switchBtnList[arg_24_0.curPage], true)

	setText = var_2

	local var_24_2 = arg_24_0.progressText

	setColorStr = var_4
	tostring = var_1_10005

	local var_24_3 = var_1_10005(#arg_24_0.activeIDList)

	COLOR_WHITE = var_6

	var_2(var_24_2, var_4(var_24_3, var_6) .. "/" .. #arg_24_0.allIDList)
	arg_24_0:checkAward()

	return
end

function var_0_1.caculateActivatable(arg_25_0, arg_25_1)
	local var_25_0 = 0

	if not arg_25_0.pageIDList then
		return var_25_0
	end

	local var_25_1 = arg_25_0.pageIDList[arg_25_1]

	ipairs = var_1_10004

	for iter_25_0, iter_25_1 in var_1_10004(var_25_1) do
		table = var_1_10009
		var_1_10009 = var_1_10009.contains(arg_25_0.activeIDList, iter_25_1)
		table = var_10

		local var_25_2 = var_10.contains(arg_25_0.activatableIDList, iter_25_1)

		if not var_1_10009 and var_25_2 then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function var_0_1.checkAward(arg_26_0)
	if not arg_26_0.activeIDList then
		return
	end

	setActive = var_1

	var_1(arg_26_0.imgGot, #arg_26_0.activeIDList == #arg_26_0.allIDList and arg_26_0.activityData.data1 == 1)

	if #arg_26_0.activeIDList == #arg_26_0.allIDList and arg_26_0.activityData.data1 ~= 1 and not arg_26_0.awardFlag then
		pg = var_1

		local var_26_0 = var_1.m02
		local var_26_1 = var_1.sendNotification

		GAME = var_3

		local var_26_2 = var_3.ACTIVITY_OPERATION
		local var_26_3 = {
			cmd = 1
		}

		ActivityConst = var_1_10005
		var_26_3.activity_id = var_1_10005.DOA_MEDAL_ACT_ID

		var_26_1(var_26_0, var_26_2, var_26_3)

		setActive = var_26_1

		var_26_1(arg_26_0.imgGot, true)

		arg_26_0.awardFlag = true
	end

	return
end

return var_0_1
