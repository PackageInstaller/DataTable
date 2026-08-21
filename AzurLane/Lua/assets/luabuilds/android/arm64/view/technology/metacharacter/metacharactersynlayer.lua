local var_0_0 = class("MetaCharacterSynLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MetaCharacterSynUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateShipImg()
	arg_3_0:updatePtPanel()
	arg_3_0:updateTaskList()
	arg_3_0:updateGetAwardBtn()
	arg_3_0:updateActTimePanel()
	arg_3_0:enablePartialBlur()

	if arg_3_0.contextData.isMainOpen then
		arg_3_0.contextData.isMainOpen = nil

		arg_3_0:moveShipImg(true)
	end

	arg_3_0:movePanel()
	arg_3_0:TryPlayGuide()

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:moveShipImg(false)
	arg_4_0:disablePartialBlur()

	return
end

function var_0_0.initUITextTips(arg_5_0)
	setText(arg_5_0._tf:Find("PTPanel/TipText"), i18n("meta_cur_pt"))
	setText(arg_5_0._tf:Find("TaskPanel/ActTimePanel/Tip"), i18n("meta_acttime_limit"))

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.curMetaShipID = arg_6_0.contextData.shipID
	arg_6_0.curShipVO = nil
	arg_6_0.curMetaCharacterVO = nil
	arg_6_0.curMetaProgressVO = nil

	arg_6_0:updateData()

	return
end

function var_0_0.updateData(arg_7_0)
	arg_7_0.curShipVO = getProxy(BayProxy):getShipById(arg_7_0.curMetaShipID)
	arg_7_0.curMetaCharacterVO = arg_7_0.curShipVO:getMetaCharacter()
	arg_7_0.curMetaProgressVO = getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_7_0.curMetaCharacterVO.id)

	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.shipImg = arg_8_0._tf:Find("ShipImg")
	arg_8_0.ptPanel = arg_8_0._tf:Find("PTPanel")
	arg_8_0.ptSynRateText = arg_8_0.ptPanel:Find("ProgressText")
	arg_8_0.ptNumText = arg_8_0.ptPanel:Find("Count/NumText")
	arg_8_0.ptIconLeft = arg_8_0.ptPanel:Find("Icon")
	arg_8_0.showWayBtn = arg_8_0.ptPanel:Find("ShowWayBtn")
	arg_8_0.taskPanel = arg_8_0._tf:Find("TaskPanel")
	arg_8_0.taskTplContainer = arg_8_0.taskPanel:Find("Scroll/Viewport/Content")
	arg_8_0.taskTpl = arg_8_0.taskPanel:Find("TaskTpl")
	arg_8_0.getAllBtn = arg_8_0.taskPanel:Find("BtnGetAll")
	arg_8_0.getAllBtnDisable = arg_8_0.taskPanel:Find("BtnGetAllDisable")
	arg_8_0.getNextBtn = arg_8_0.taskPanel:Find("BtnGetMore")
	arg_8_0.taskUIItemList = UIItemList.New(arg_8_0.taskTplContainer, arg_8_0.taskTpl)
	arg_8_0.sizeH = GetComponent(arg_8_0.taskTpl, "LayoutElement").preferredHeight
	arg_8_0.spaceH = GetComponent(arg_8_0.taskTplContainer, "VerticalLayoutGroup").spacing
	arg_8_0.topH = GetComponent(arg_8_0.taskTplContainer, "VerticalLayoutGroup").padding.top
	arg_8_0.scrollSC = GetComponent(arg_8_0.taskPanel:Find("Scroll"), "ScrollRect")
	arg_8_0.actTimePanel = arg_8_0._tf:Find("TaskPanel/ActTimePanel")
	arg_8_0.actTimeText = arg_8_0._tf:Find("TaskPanel/ActTimePanel/Text")

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.getAllBtn, function()
		local var_10_0, var_10_1 = arg_9_0:getOneStepPTAwardLevelAndCount()

		pg.m02:sendNotification(GAME.GET_META_PT_AWARD, {
			groupID = arg_9_0.curMetaProgressVO.id,
			targetCount = var_10_1
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.getAllBtnDisable, function()
		return
	end)
	onButton(arg_9_0, arg_9_0.getNextBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("meta_pt_notenough"))

		return
	end)
	onButton(arg_9_0, arg_9_0.showWayBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = {
				count = 0,
				type = DROP_TYPE_ITEM,
				id = arg_9_0.curMetaProgressVO.metaPtData.resId
			}
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.TryPlayGuide(arg_14_0)
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0028")

	return
end

function var_0_0.updateActTimePanel(arg_15_0)
	local var_15_9000

	if type(arg_15_0.curMetaProgressVO.timeConfig) == "string" then
		setActive(arg_15_0.actTimePanel, false)
	elseif type(arg_15_0.curMetaProgressVO.timeConfig) == "table" then
		setText(arg_15_0.actTimeText, i18n("meta_pt_left", (pg.TimeMgr.GetInstance():DiffDay(pg.TimeMgr.GetInstance():GetServerTime(), (pg.TimeMgr.GetInstance().parseTimeFromConfig(var_15_9000, arg_15_0.curMetaProgressVO.timeConfig[2]))))))
	end

	return
end

function var_0_0.updateShipImg(arg_16_0)
	local var_16_0, var_16_1 = MetaCharacterConst.GetMetaCharacterPaintPath(arg_16_0.curMetaCharacterVO.id, true)

	setImageSprite(arg_16_0.shipImg, LoadSprite(var_16_0, var_16_1), true)
	setLocalPosition(arg_16_0.shipImg, {
		x = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][9],
		y = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][10]
	})
	setLocalScale(arg_16_0.shipImg, {
		x = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][3],
		y = MetaCharacterConst.UIConfig[arg_16_0.curMetaCharacterVO.id][4]
	})

	return
end

function var_0_0.updatePtPanel(arg_17_0)
	setImageSprite(arg_17_0.ptIconLeft, LoadSprite(arg_17_0.curMetaProgressVO:getPtIconPath()))
	setText(arg_17_0.ptSynRateText, string.format("%d", arg_17_0.curMetaProgressVO:getSynRate() * 100) .. "%")
	setText(arg_17_0.ptNumText, (arg_17_0.curMetaProgressVO.metaPtData:GetResProgress()))

	return
end

function var_0_0.updateTaskList(arg_18_0)
	arg_18_0.taskUIItemList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			arg_19_1 = arg_19_1 + 1

			arg_18_0:updateTaskTpl(arg_19_2, arg_19_1)
		end

		return
	end)

	local var_18_0, var_18_1, var_18_2 = arg_18_0.curMetaProgressVO.metaPtData:GetLevelProgress()

	arg_18_0.taskUIItemList:align(var_18_1)
	setLocalPosition(arg_18_0.taskTplContainer, {
		y = arg_18_0.topH + (var_18_0 - 1) * (arg_18_0.sizeH + arg_18_0.spaceH)
	})

	return
end

function var_0_0.updateTaskTpl(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:Find("Info/AwardInfo/Award/Tag/Get")
	local var_20_1 = arg_20_1:Find("Info/AwardInfo/Award/Tag/Got")
	local var_20_2 = arg_20_1:Find("GotMask")

	setText(arg_20_1:Find("Target/IndexText"), arg_20_2)
	setText(arg_20_1:Find("PT/Count/NumText"), arg_20_0.curMetaProgressVO.metaPtData.targets[arg_20_2])
	setImageSprite(arg_20_1:Find("PT/Icon"), LoadSprite(arg_20_0.curMetaProgressVO:getPtIconPath()))

	local var_20_3 = Drop.Create(arg_20_0.curMetaProgressVO.metaPtData.dropList[arg_20_2])

	updateDrop(arg_20_1:Find("Info/AwardInfo/Award/Item"), var_20_3, {
		hideName = true
	})
	onButton(arg_20_0, arg_20_1:Find("Info/AwardInfo/Award"), function()
		arg_20_0:emit(BaseUI.ON_DROP, var_20_3)

		return
	end, SFX_PANEL)
	setText(arg_20_1:Find("Info/AwardInfo/NameMask/NameText"), shortenString(var_20_3:getConfig("name"), 6))
	setText(arg_20_1:Find("Info/AwardInfo/SynProgressText"), math.round(arg_20_0.curMetaProgressVO.metaPtData.targets[arg_20_2] / arg_20_0.curMetaProgressVO.unlockPTNum * 100) .. "%")

	if arg_20_2 < arg_20_0.curMetaProgressVO.metaPtData.level + 1 then
		setActive(var_20_1, true)
		setActive(var_20_0, false)
		setActive(var_20_2, true)
		setGray(arg_20_1, true, true)
	else
		if arg_20_0.curMetaProgressVO.metaPtData.targets[arg_20_2] > arg_20_0.curMetaProgressVO.metaPtData.count then
			setActive(var_20_1, false)
			setActive(var_20_0, false)
		else
			setActive(var_20_1, false)
			setActive(var_20_0, true)
		end

		setActive(var_20_2, false)
		setGray(arg_20_1, false, true)
	end

	return
end

function var_0_0.updateGetAwardBtn(arg_22_0)
	if arg_22_0.curMetaProgressVO.metaPtData:CanGetAward() then
		setActive(arg_22_0.getAllBtn, true)
		setActive(arg_22_0.getAllBtnDisable, false)
		setActive(arg_22_0.getNextBtn, false)
	elseif arg_22_0.curMetaProgressVO.metaPtData:CanGetNextAward() then
		setActive(arg_22_0.getAllBtn, false)
		setActive(arg_22_0.getAllBtnDisable, false)
		setActive(arg_22_0.getNextBtn, true)
	else
		setActive(arg_22_0.getAllBtn, false)
		setActive(arg_22_0.getAllBtnDisable, true)
		setActive(arg_22_0.getNextBtn, false)
	end

	return
end

function var_0_0.moveShipImg(arg_23_0, arg_23_1)
	local var_23_0 = MetaCharacterConst.UIConfig[arg_23_0.curMetaCharacterVO.id]
	local var_23_1 = arg_23_1 and -2000 or var_23_0[9]

	if arg_23_1 then
		arg_23_0:managedTween(LeanTween.moveX, nil, rtf(arg_23_0.shipImg), var_23_2, 0.3):setFrom(var_23_1)

		return
	end
end

function var_0_0.movePanel(arg_24_0)
	arg_24_0:managedTween(LeanTween.moveX, nil, rtf(arg_24_0.taskPanel), 500, 0.3):setFrom(2000)
	arg_24_0:managedTween(LeanTween.moveX, nil, rtf(arg_24_0.ptPanel), -516, 0.3):setFrom(-2000)

	return
end

function var_0_0.enablePartialBlur(arg_25_0)
	if arg_25_0._tf then
		table.insert({}, arg_25_0.taskPanel)
		arg_25_0:OverlayPanel(arg_25_0._tf, {
			groupDelta = -1,
			pbList = {}
		})
	end

	return
end

function var_0_0.disablePartialBlur(arg_26_0)
	if arg_26_0._tf then
		arg_26_0:UnOverlayPanel(arg_26_0._tf)
	end

	return
end

function var_0_0.getOneStepPTAwardLevelAndCount(arg_27_0)
	local var_27_0 = arg_27_0.curMetaProgressVO.metaPtData:GetResProgress()
	local var_27_1 = arg_27_0.curMetaProgressVO:getStoryIndexList()
	local var_27_3 = 0

	for iter_27_0 = 1, #arg_27_0.curMetaProgressVO.metaPtData.targets do
		local var_27_4 = false
		local var_27_5 = false

		if var_27_0 >= arg_27_0.curMetaProgressVO.metaPtData.targets[iter_27_0] then
			var_27_4 = true
		end

		local var_27_6 = var_27_1[iter_27_0]

		if var_27_1[iter_27_0] == 0 then
			var_27_5 = true
		else
			local var_27_7 = pg.NewStoryMgr.GetInstance()

			if var_27_7:IsPlayed(var_27_6) then
				var_27_5 = true
			end
		end

		if var_27_4 and var_27_5 then
			var_27_3 = iter_27_0
		else
			break
		end
	end

	print("calc max level", var_27_3, arg_27_0.curMetaProgressVO.metaPtData.targets[var_27_3])

	return var_27_3, arg_27_0.curMetaProgressVO.metaPtData.targets[var_27_3]
end

function var_0_0.goWorldFunc(arg_28_0)
	getProxy(ContextProxy):getContextByMediator(MetaCharacterMediator).data.lastPageIndex = pg.m02:retrieveMediator("MetaCharacterMediator").viewComponent.curPageIndex

	arg_28_0:closeView()
	arg_28_0:sendNotification(GAME.GO_SCENE, SCENE.WORLDBOSS)

	return
end

return var_0_0
