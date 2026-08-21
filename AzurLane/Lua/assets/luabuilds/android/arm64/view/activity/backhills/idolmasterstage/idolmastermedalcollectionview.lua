local var_0_0 = class("IdolMasterMedalCollectionView", import("view.base.BaseUI"))

var_0_0.FADE_OUT_TIME = 1
var_0_0.PAGE_NUM = 7
var_0_0.MEDAL_NUM_PER_PAGE = 2
var_0_0.MEDAL_STATUS_UNACTIVATED = 1
var_0_0.MEDAL_STATUS_ACTIVATED = 2
var_0_0.MEDAL_STATUS_ACTIVATABLE = 3
var_0_0.INDEX_CONVERT = {
	1,
	2,
	5,
	6,
	7,
	4,
	3
}

function var_0_0.getUIName(arg_1_0)
	return "IdolMasterMedalCollectionUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:checkAward()
	setText(arg_3_0.progressText, setColorStr(tostring(#arg_3_0.activeIDList), "#8CD5FFFF") .. "/" .. #arg_3_0.allIDList)
	triggerToggle(arg_3_0.switchBtnList[1], true)

	return
end

function var_0_0.willExit(arg_4_0)
	if LeanTween.isTweening(go(arg_4_0.photo)) then
		LeanTween.cancel(go(arg_4_0.photo), false)
	end

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.activityProxy = getProxy(ActivityProxy)
	arg_5_0.activityData = arg_5_0.activityProxy:getActivityById(ActivityConst.IDOL_MASTER_MEDAL_ID)
	arg_5_0.allIDList = arg_5_0.activityData:GetPicturePuzzleIds()
	arg_5_0.pageIDList = {}

	for iter_5_0 = 1, var_0_0.PAGE_NUM do
		arg_5_0.pageIDList[iter_5_0] = {}

		for iter_5_1 = 1, var_0_0.MEDAL_NUM_PER_PAGE do
			arg_5_0.pageIDList[iter_5_0][iter_5_1] = arg_5_0.allIDList[(var_0_0.INDEX_CONVERT[iter_5_0] - 1) * var_0_0.MEDAL_NUM_PER_PAGE + iter_5_1]
		end
	end

	arg_5_0.activatableIDList = arg_5_0.activityData.data1_list
	arg_5_0.activeIDList = arg_5_0.activityData.data2_list
	arg_5_0.curPage = nil
	arg_5_0.newMedalID = nil

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("BG")

	local var_6_0 = arg_6_0._tf:Find("NotchAdapt")

	arg_6_0.backBtn = var_6_0:Find("BackBtn")
	arg_6_0.progressText = var_6_0:Find("ProgressImg/ProgressText")
	arg_6_0.helpBtn = var_6_0:Find("HelpBtn")

	local var_6_1 = arg_6_0._tf:Find("SwitchBtnList")

	arg_6_0.tplButtom = findTF(var_6_1, "tplButtom")
	arg_6_0.imgGot = var_6_0:Find("ProgressImg/got")
	arg_6_0.switchBtnList = {}

	for iter_6_0 = 1, var_0_0.PAGE_NUM do
		local var_6_2 = tf(instantiate(go(arg_6_0.tplButtom)))

		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "icon" .. iter_6_0, function(arg_7_0)
			if var_6_2 then
				setImageSprite(findTF(var_6_2, "icon"), arg_7_0, true)
			end

			return
		end)
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "iconSelect" .. iter_6_0, function(arg_8_0)
			if var_6_2 then
				setImageSprite(findTF(var_6_2, "iconSelect"), arg_8_0, true)
			end

			return
		end)
		setParent(var_6_2, var_6_1)
		setActive(var_6_2, true)
		table.insert(arg_6_0.switchBtnList, var_6_2)
	end

	arg_6_0.infoNode = arg_6_0._tf:Find("book/info")
	arg_6_0.photoNode = arg_6_0._tf:Find("book/photo")
	arg_6_0.photo = arg_6_0.photoNode:Find("got")

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idolmaster_collection.tip
		})

		return
	end, SFX_PANEL)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.switchBtnList) do
		onToggle(arg_9_0, iter_9_1, function(arg_12_0)
			if arg_12_0 == true then
				local var_12_0 = arg_9_0.curPage ~= iter_9_0

				arg_9_0.curPage = iter_9_0

				arg_9_0:updateSwitchBtnTF()
				arg_9_0:updateMedalContainerView(iter_9_0, var_12_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateActivity(arg_13_0, arg_13_1)
	arg_13_0:checkAward()

	return
end

function var_0_0.updateMedalContainerView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:updatePhotoNode(arg_14_0.pageIDList[arg_14_1][1], arg_14_2)
	arg_14_0:updateInfoNode(arg_14_0.pageIDList[arg_14_1][2])

	return
end

function var_0_0.getMedalStatus(arg_15_0, arg_15_1)
	local var_15_0 = table.contains(arg_15_0.activeIDList, arg_15_1)
	local var_15_1 = table.contains(arg_15_0.activatableIDList, arg_15_1) and not var_15_0
	local var_15_2 = not var_15_0 and not var_15_1

	if var_15_0 then
		return var_0_0.MEDAL_STATUS_ACTIVATED
	elseif var_15_1 then
		return var_0_0.MEDAL_STATUS_ACTIVATABLE
	elseif var_15_2 then
		return var_0_0.MEDAL_STATUS_UNACTIVATED
	end

	return
end

function var_0_0.updatePhotoNode(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.photoNode:Find("task")
	local var_16_1 = arg_16_0.photoNode:Find("get")
	local var_16_2 = arg_16_0.photoNode:Find("got")
	local var_16_3 = arg_16_0:getMedalStatus(arg_16_1)

	if var_16_3 == var_0_0.MEDAL_STATUS_UNACTIVATED then
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "task" .. (arg_16_0.curPage - 1) * var_0_0.MEDAL_NUM_PER_PAGE + 1, function(arg_17_0)
			setImageSprite(var_16_0, arg_17_0, true)
			setActive(var_16_0, true)

			return
		end)
	else
		setActive(arg_16_0.photoNode:Find("task"), false)
	end

	if var_16_3 == var_0_0.MEDAL_STATUS_ACTIVATED then
		if arg_16_2 then
			setActive(arg_16_0.photo, false)
			LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "photo" .. arg_16_0.curPage, function(arg_18_0)
				setImageSprite(arg_16_0.photo, arg_18_0, true)

				if LeanTween.isTweening(go(arg_16_0.photo)) then
					LeanTween.cancel(go(arg_16_0.photo), false)
				end

				GetComponent(arg_16_0.photo, typeof(CanvasGroup)).alpha = 0

				LeanTween.value(go(arg_16_0.photo), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_19_0)
					GetComponent(arg_16_0.photo, typeof(CanvasGroup)).alpha = arg_19_0

					return
				end))
				setActive(arg_16_0.photo, true)

				return
			end)
		else
			LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "photo" .. arg_16_0.curPage, function(arg_20_0)
				setImageSprite(arg_16_0.photo, arg_20_0, true)
				setActive(arg_16_0.photo, true)

				return
			end)
		end
	else
		setActive(arg_16_0.photo, false)
	end

	setActive(var_16_1, var_16_3 == var_0_0.MEDAL_STATUS_ACTIVATABLE)

	if var_16_3 == var_0_0.MEDAL_STATUS_ACTIVATABLE then
		onButton(arg_16_0, arg_16_0.photoNode, function()
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = arg_16_1,
				actId = arg_16_0.activityData.id
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateInfoNode(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.infoNode:Find("task")
	local var_22_1 = arg_22_0.infoNode:Find("get")
	local var_22_2 = arg_22_0.infoNode:Find("got")
	local var_22_3 = arg_22_0:getMedalStatus(arg_22_1)

	if var_22_3 == var_0_0.MEDAL_STATUS_UNACTIVATED then
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "task" .. (arg_22_0.curPage - 1) * var_0_0.MEDAL_NUM_PER_PAGE + 2, function(arg_23_0)
			setImageSprite(var_22_0, arg_23_0, true)
			setActive(var_22_0, true)

			return
		end)
	else
		setActive(arg_22_0.infoNode:Find("task"), false)
	end

	if var_22_3 == var_0_0.MEDAL_STATUS_ACTIVATED then
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "info" .. arg_22_0.curPage, function(arg_24_0)
			setImageSprite(var_22_2, arg_24_0, true)
			setActive(var_22_2, true)

			return
		end)
	else
		setActive(var_22_2, false)
	end

	setActive(var_22_1, var_22_3 == var_0_0.MEDAL_STATUS_ACTIVATABLE)

	if var_22_3 == var_0_0.MEDAL_STATUS_ACTIVATABLE then
		onButton(arg_22_0, arg_22_0.infoNode, function()
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = arg_22_1,
				actId = arg_22_0.activityData.id
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateSwitchBtnTF(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.switchBtnList) do
		local var_26_0 = iter_26_1:Find("tip")
		local var_26_1 = arg_26_0:caculateActivatable(iter_26_0)

		if var_26_1 == 0 or iter_26_0 == arg_26_0.curPage then
			setActive(var_26_0, false)
		end

		if var_26_1 > 0 and iter_26_0 ~= arg_26_0.curPage then
			setActive(var_26_0, true)
		end

		local var_26_2 = iter_26_0 == arg_26_0.curPage

		setActive(iter_26_1:Find("icon"), not (iter_26_0 == arg_26_0.curPage))
		setActive(iter_26_1:Find("iconSelect"), var_26_2)
	end

	return
end

function var_0_0.updateAfterSubmit(arg_27_0, arg_27_1)
	arg_27_0.activityProxy = getProxy(ActivityProxy)
	arg_27_0.activityData = arg_27_0.activityProxy:getActivityById(ActivityConst.IDOL_MASTER_MEDAL_ID)
	arg_27_0.activatableIDList = arg_27_0.activityData.data1_list
	arg_27_0.activeIDList = arg_27_0.activityData.data2_list
	arg_27_0.newMedalID = arg_27_1

	triggerToggle(arg_27_0.switchBtnList[arg_27_0.curPage], true)
	setText(arg_27_0.progressText, setColorStr(tostring(#arg_27_0.activeIDList), COLOR_WHITE) .. "/" .. #arg_27_0.allIDList)
	arg_27_0:checkAward()

	return
end

function var_0_0.caculateActivatable(arg_28_0, arg_28_1)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.pageIDList[arg_28_1]) do
		local var_28_1 = table.contains(arg_28_0.activatableIDList, iter_28_1)

		if not table.contains(arg_28_0.activeIDList, iter_28_1) and var_28_1 then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_0.checkAward(arg_29_0)
	setActive(arg_29_0.imgGot, #arg_29_0.activeIDList == #arg_29_0.allIDList and arg_29_0.activityData.data1 == 1)

	if #arg_29_0.activeIDList == #arg_29_0.allIDList and arg_29_0.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.IDOL_MASTER_MEDAL_ID
		})
		setActive(arg_29_0.imgGot, true)
	end

	return
end

return var_0_0
