class = var_0_10000

local var_0_0 = "IdolMasterMedalCollectionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.FADE_OUT_TIME = 1
var_0_1.PAGE_NUM = 7
var_0_1.MEDAL_NUM_PER_PAGE = 2
var_0_1.MEDAL_STATUS_UNACTIVATED = 1
var_0_1.MEDAL_STATUS_ACTIVATED = 2
var_0_1.MEDAL_STATUS_ACTIVATABLE = 3
var_0_1.INDEX_CONVERT = {
	1,
	2,
	5,
	6,
	7,
	4,
	3
}

function var_0_1.getUIName(arg_1_0)
	return "IdolMasterMedalCollectionUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:checkAward()

	setText = var_1

	local var_3_0 = arg_3_0.progressText

	setColorStr = var_1_10003
	tostring = var_1_10004

	var_1(var_3_0, var_1_10003(var_1_10004(#arg_3_0.activeIDList), "#8CD5FFFF") .. "/" .. #arg_3_0.allIDList)

	triggerToggle = var_1

	var_1(arg_3_0.switchBtnList[1], true)

	return
end

function var_0_1.willExit(arg_4_0)
	LeanTween = var_1_10001

	local var_4_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_4_0(var_1_10002(arg_4_0.photo)) then
		LeanTween = var_1

		local var_4_1 = var_1.cancel

		go = var_2

		var_4_1(var_2(arg_4_0.photo), false)
	end

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002
	arg_5_0.activityProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.activityProxy
	local var_5_1 = var_1.getActivityById

	ActivityConst = var_1_10003
	arg_5_0.activityData = var_5_1(var_5_0, var_1_10003.IDOL_MASTER_MEDAL_ID)

	local var_5_2 = arg_5_0.activityData

	arg_5_0.allIDList = var_1.GetPicturePuzzleIds(var_5_2)
	arg_5_0.pageIDList = {}

	for iter_5_0 = 1, var_0_1.PAGE_NUM do
		local var_5_3 = var_0_1.INDEX_CONVERT[iter_5_0]

		arg_5_0.pageIDList[iter_5_0] = {}

		for iter_5_1 = 1, var_0_1.MEDAL_NUM_PER_PAGE do
			arg_5_0.pageIDList[iter_5_0][iter_5_1] = arg_5_0.allIDList[(var_5_3 - 1) * var_0_1.MEDAL_NUM_PER_PAGE + iter_5_1]
		end
	end

	arg_5_0.activatableIDList = arg_5_0.activityData.data1_list
	arg_5_0.activeIDList = arg_5_0.activityData.data2_list
	arg_5_0.curPage = nil
	arg_5_0.newMedalID = nil

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_1.Find(var_6_1, "NotchAdapt")

	arg_6_0.backBtn = var_1.Find(var_6_2, "BackBtn")
	arg_6_0.progressText = var_1:Find("ProgressImg/ProgressText")
	arg_6_0.helpBtn = var_1:Find("HelpBtn")

	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_2.Find(var_6_3, "SwitchBtnList")

	findTF = var_6_3
	arg_6_0.tplButtom = var_6_3(var_6_4, "tplButtom")
	arg_6_0.imgGot = var_1:Find("ProgressImg/got")
	arg_6_0.switchBtnList = {}

	for iter_6_0 = 1, var_0_1.PAGE_NUM do
		tf = var_1_10007
		instantiate = var_1_10008
		go = var_1_10009
		var_1_10007 = var_1_10007(var_1_10008(var_1_10009(arg_6_0.tplButtom)))
		LoadSpriteAtlasAsync = var_1_10008

		var_1_10008("ui/idolmastermedalcollectionui_atlas", "icon" .. iter_6_0, function(arg_7_0)
			if var_1_10007 then
				setImageSprite = var_1
				findTF = var_2_10002

				var_1(var_2_10002(var_1_10007, "icon"), arg_7_0, true)
			end

			return
		end)

		LoadSpriteAtlasAsync = var_1_10008

		var_1_10008("ui/idolmastermedalcollectionui_atlas", "iconSelect" .. iter_6_0, function(arg_8_0)
			if var_1_10007 then
				setImageSprite = var_1
				findTF = var_2_10002

				var_1(var_2_10002(var_1_10007, "iconSelect"), arg_8_0, true)
			end

			return
		end)

		setParent = var_1_10008

		var_1_10008(var_1_10007, var_6_4)

		setActive = var_1_10008

		var_1_10008(var_1_10007, true)

		table = var_1_10008

		var_1_10008.insert(arg_6_0.switchBtnList, var_1_10007)
	end

	local var_6_5 = arg_6_0._tf

	arg_6_0.infoNode = var_3.Find(var_6_5, "book/info")

	local var_6_6 = arg_6_0._tf

	arg_6_0.photoNode = var_3.Find(var_6_6, "book/photo")

	local var_6_7 = arg_6_0.photoNode

	arg_6_0.photo = var_3.Find(var_6_7, "got")

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.backBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.helpBtn

	local function var_9_5()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_11_2.type = var_2_10003
		pg = var_2_10003
		var_11_2.helps = var_2_10003.gametip.idolmaster_collection.tip

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10005)

	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.switchBtnList) do
		onToggle = var_1_10006

		local var_9_6 = arg_9_0
		local var_9_7 = iter_9_1

		local function var_9_8(arg_12_0)
			if arg_12_0 == true then
				local var_12_0 = arg_9_0.curPage ~= iter_9_0

				arg_9_0.curPage = iter_9_0

				local var_12_1 = arg_9_0

				var_2.updateSwitchBtnTF(var_12_1)

				local var_12_2 = arg_9_0

				var_2.updateMedalContainerView(var_12_2, iter_9_0, var_12_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_9_6, var_9_7, var_9_8, var_1_10010)
	end

	return
end

function var_0_1.UpdateActivity(arg_13_0, arg_13_1)
	arg_13_0:checkAward()

	return
end

function var_0_1.updateMedalContainerView(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.pageIDList[arg_14_1]

	arg_14_0:updatePhotoNode(var_14_0[1], arg_14_2)
	arg_14_0:updateInfoNode(var_14_0[2])

	return
end

function var_0_1.getMedalStatus(arg_15_0, arg_15_1)
	table = var_1_10002

	local var_15_0 = var_1_10002.contains(arg_15_0.activeIDList, arg_15_1)

	table = var_3

	local var_15_1

	if var_3.contains(arg_15_0.activatableIDList, arg_15_1) then
		var_15_1 = not var_15_0
	end

	local var_15_2 = not var_15_0 and not var_15_1

	if var_15_0 then
		return var_0_1.MEDAL_STATUS_ACTIVATED
	elseif var_15_1 then
		return var_0_1.MEDAL_STATUS_ACTIVATABLE
	elseif var_15_2 then
		return var_0_1.MEDAL_STATUS_UNACTIVATED
	end

	return
end

function var_0_1.updatePhotoNode(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.photoNode
	local var_16_1 = var_3.Find(var_16_0, "task")
	local var_16_2 = arg_16_0.photoNode
	local var_16_3 = var_4.Find(var_16_2, "get")
	local var_16_4 = arg_16_0.photoNode
	local var_16_5 = var_5.Find(var_16_4, "got")
	local var_16_6 = arg_16_0:getMedalStatus(arg_16_1)
	local var_16_7 = (arg_16_0.curPage - 1) * var_0_1.MEDAL_NUM_PER_PAGE + 1

	if var_16_6 == var_0_1.MEDAL_STATUS_UNACTIVATED then
		LoadSpriteAtlasAsync = var_8

		var_8("ui/idolmastermedalcollectionui_atlas", "task" .. var_16_7, function(arg_17_0)
			setImageSprite = var_2_10001

			var_2_10001(var_16_1, arg_17_0, true)

			setActive = var_2_10001

			var_2_10001(var_16_1, true)

			return
		end)
	else
		setActive = var_8

		var_8(var_16_1, false)
	end

	if var_16_6 == var_0_1.MEDAL_STATUS_ACTIVATED then
		if arg_16_2 then
			setActive = var_8

			var_8(arg_16_0.photo, false)

			LoadSpriteAtlasAsync = var_8

			var_8("ui/idolmastermedalcollectionui_atlas", "photo" .. arg_16_0.curPage, function(arg_18_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_16_0.photo, arg_18_0, true)

				LeanTween = var_2_10001

				local var_18_0 = var_2_10001.isTweening

				go = var_2

				local var_18_1

				if var_18_0(var_2(arg_16_0.photo)) then
					LeanTween = var_18_1
					var_18_1 = var_18_1.cancel
					go = var_2

					var_18_1(var_2(arg_16_0.photo), false)
				end

				GetComponent = var_18_1

				local var_18_2 = arg_16_0.photo

				typeof = var_3
				CanvasGroup = var_4

				local var_18_3 = var_18_1(var_18_2, var_3(var_4))

				var_18_3.alpha = 0
				LeanTween = var_18_3

				local var_18_4 = var_18_3.value

				go = var_2

				local var_18_5 = var_18_4(var_2(arg_16_0.photo), 0, 1, 0.3)
				local var_18_6 = var_1.setOnUpdate

				System = var_3

				var_18_6(var_18_5, var_3.Action_float(function(arg_19_0)
					GetComponent = var_3_10001

					local var_19_0 = arg_16_0.photo

					typeof = var_3_10003
					CanvasGroup = var_3_10004
					var_3_10001(var_19_0, var_3_10003(var_3_10004)).alpha = arg_19_0

					return
				end))

				setActive = var_18_6

				var_18_6(arg_16_0.photo, true)

				return
			end)
		else
			LoadSpriteAtlasAsync = var_8

			var_8("ui/idolmastermedalcollectionui_atlas", "photo" .. arg_16_0.curPage, function(arg_20_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_16_0.photo, arg_20_0, true)

				setActive = var_2_10001

				var_2_10001(arg_16_0.photo, true)

				return
			end)
		end
	else
		setActive = var_8

		var_8(arg_16_0.photo, false)
	end

	setActive = var_8

	var_8(var_16_3, var_16_6 == var_0_1.MEDAL_STATUS_ACTIVATABLE)

	if var_16_6 == var_0_1.MEDAL_STATUS_ACTIVATABLE then
		onButton = var_8

		local var_16_8 = arg_16_0
		local var_16_9 = arg_16_0.photoNode

		local function var_16_10()
			pg = var_2_10000

			local var_21_0 = var_2_10000.m02
			local var_21_1 = var_0.sendNotification

			GAME = var_2_10002

			var_21_1(var_21_0, var_2_10002.MEMORYBOOK_UNLOCK, {
				id = arg_16_1,
				actId = arg_16_0.activityData.id
			})

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_16_8, var_16_9, var_16_10, var_1_10012)
	end

	return
end

function var_0_1.updateInfoNode(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.infoNode
	local var_22_1 = var_2.Find(var_22_0, "task")
	local var_22_2 = arg_22_0.infoNode
	local var_22_3 = var_3.Find(var_22_2, "get")
	local var_22_4 = arg_22_0.infoNode
	local var_22_5 = var_4.Find(var_22_4, "got")
	local var_22_6 = arg_22_0:getMedalStatus(arg_22_1)
	local var_22_7 = (arg_22_0.curPage - 1) * var_0_1.MEDAL_NUM_PER_PAGE + 2

	if var_22_6 == var_0_1.MEDAL_STATUS_UNACTIVATED then
		LoadSpriteAtlasAsync = var_7

		var_7("ui/idolmastermedalcollectionui_atlas", "task" .. var_22_7, function(arg_23_0)
			setImageSprite = var_2_10001

			var_2_10001(var_22_1, arg_23_0, true)

			setActive = var_2_10001

			var_2_10001(var_22_1, true)

			return
		end)
	else
		setActive = var_7

		var_7(var_22_1, false)
	end

	if var_22_6 == var_0_1.MEDAL_STATUS_ACTIVATED then
		LoadSpriteAtlasAsync = var_7

		var_7("ui/idolmastermedalcollectionui_atlas", "info" .. arg_22_0.curPage, function(arg_24_0)
			setImageSprite = var_2_10001

			var_2_10001(var_22_5, arg_24_0, true)

			setActive = var_2_10001

			var_2_10001(var_22_5, true)

			return
		end)
	else
		setActive = var_7

		var_7(var_22_5, false)
	end

	setActive = var_7

	var_7(var_22_3, var_22_6 == var_0_1.MEDAL_STATUS_ACTIVATABLE)

	if var_22_6 == var_0_1.MEDAL_STATUS_ACTIVATABLE then
		onButton = var_7

		local var_22_8 = arg_22_0
		local var_22_9 = arg_22_0.infoNode

		local function var_22_10()
			pg = var_2_10000

			local var_25_0 = var_2_10000.m02
			local var_25_1 = var_0.sendNotification

			GAME = var_2_10002

			var_25_1(var_25_0, var_2_10002.MEMORYBOOK_UNLOCK, {
				id = arg_22_1,
				actId = arg_22_0.activityData.id
			})

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_22_8, var_22_9, var_22_10, var_1_10011)
	end

	return
end

function var_0_1.updateSwitchBtnTF(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.switchBtnList) do
		local var_26_0 = iter_26_1:Find("tip")
		local var_26_1 = arg_26_0

		if arg_26_0.caculateActivatable(var_26_1, iter_26_0) == 0 or iter_26_0 == arg_26_0.curPage then
			setActive = var_26_1

			var_26_1(var_26_0, false)
		end

		if var_7 > 0 and iter_26_0 ~= arg_26_0.curPage then
			setActive = var_8

			var_8(var_26_0, true)
		end

		local var_26_2 = iter_26_0 == arg_26_0.curPage

		setActive = var_9

		var_9(iter_26_1:Find("icon"), not var_26_2)

		setActive = var_9

		var_9(iter_26_1:Find("iconSelect"), var_26_2)
	end

	return
end

function var_0_1.updateAfterSubmit(arg_27_0, arg_27_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003
	arg_27_0.activityProxy = var_1_10002(var_1_10003)

	local var_27_0 = arg_27_0.activityProxy
	local var_27_1 = var_2.getActivityById

	ActivityConst = var_1_10004
	arg_27_0.activityData = var_27_1(var_27_0, var_1_10004.IDOL_MASTER_MEDAL_ID)
	arg_27_0.activatableIDList = arg_27_0.activityData.data1_list
	arg_27_0.activeIDList = arg_27_0.activityData.data2_list
	arg_27_0.newMedalID = arg_27_1
	triggerToggle = var_2

	var_2(arg_27_0.switchBtnList[arg_27_0.curPage], true)

	setText = var_2

	local var_27_2 = arg_27_0.progressText

	setColorStr = var_4
	tostring = var_1_10005

	local var_27_3 = var_1_10005(#arg_27_0.activeIDList)

	COLOR_WHITE = var_6

	var_2(var_27_2, var_4(var_27_3, var_6) .. "/" .. #arg_27_0.allIDList)
	arg_27_0:checkAward()

	return
end

function var_0_1.caculateActivatable(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.pageIDList[arg_28_1]
	local var_28_1 = 0

	ipairs = var_1_10004

	for iter_28_0, iter_28_1 in var_1_10004(var_28_0) do
		table = var_1_10009
		var_1_10009 = var_1_10009.contains(arg_28_0.activeIDList, iter_28_1)
		table = var_10

		local var_28_2 = var_10.contains(arg_28_0.activatableIDList, iter_28_1)

		if not var_1_10009 and var_28_2 then
			var_28_1 = var_28_1 + 1
		end
	end

	return var_28_1
end

function var_0_1.checkAward(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.imgGot, #arg_29_0.activeIDList == #arg_29_0.allIDList and arg_29_0.activityData.data1 == 1)

	if #arg_29_0.activeIDList == #arg_29_0.allIDList and arg_29_0.activityData.data1 ~= 1 then
		pg = var_1

		local var_29_0 = var_1.m02
		local var_29_1 = var_1.sendNotification

		GAME = var_3

		local var_29_2 = var_3.ACTIVITY_OPERATION
		local var_29_3 = {
			cmd = 1
		}

		ActivityConst = var_1_10005
		var_29_3.activity_id = var_1_10005.IDOL_MASTER_MEDAL_ID

		var_29_1(var_29_0, var_29_2, var_29_3)

		setActive = var_29_1

		var_29_1(arg_29_0.imgGot, true)
	end

	return
end

return var_0_1
