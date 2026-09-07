local MetaCharacterSynLayer = class("MetaCharacterSynLayer", import("...base.BaseUI"))

function MetaCharacterSynLayer:getUIName()
	return "MetaCharacterSynUI"
end

function MetaCharacterSynLayer:init()
	self:initUITextTips()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function MetaCharacterSynLayer:didEnter()
	self:updateShipImg()
	self:updatePtPanel()
	self:updateTaskList()
	self:updateGetAwardBtn()
	self:updateActTimePanel()
	self:enablePartialBlur()

	if self.contextData.isMainOpen then
		self.contextData.isMainOpen = nil

		self:moveShipImg(true)
	end

	self:movePanel()
	self:TryPlayGuide()

	return
end

function MetaCharacterSynLayer:willExit()
	self:moveShipImg(false)
	self:disablePartialBlur()

	return
end

function MetaCharacterSynLayer:initUITextTips()
	setText(self._tf:Find("PTPanel/TipText"), i18n("meta_cur_pt"))
	setText(self._tf:Find("TaskPanel/ActTimePanel/Tip"), i18n("meta_acttime_limit"))

	return
end

function MetaCharacterSynLayer:initData()
	self.curMetaShipID = self.contextData.shipID
	self.curShipVO = nil
	self.curMetaCharacterVO = nil
	self.curMetaProgressVO = nil

	self:updateData()

	return
end

function MetaCharacterSynLayer:updateData()
	self.curShipVO = getProxy(BayProxy):getShipById(self.curMetaShipID)
	self.curMetaCharacterVO = self.curShipVO:getMetaCharacter()
	self.curMetaProgressVO = getProxy(MetaCharacterProxy):getMetaProgressVOByID(self.curMetaCharacterVO.id)

	return
end

function MetaCharacterSynLayer:findUI()
	self.shipImg = self._tf:Find("ShipImg")
	self.ptPanel = self._tf:Find("PTPanel")
	self.ptSynRateText = self.ptPanel:Find("ProgressText")
	self.ptNumText = self.ptPanel:Find("Count/NumText")
	self.ptIconLeft = self.ptPanel:Find("Icon")
	self.showWayBtn = self.ptPanel:Find("ShowWayBtn")
	self.taskPanel = self._tf:Find("TaskPanel")
	self.taskTplContainer = self.taskPanel:Find("Scroll/Viewport/Content")
	self.taskTpl = self.taskPanel:Find("TaskTpl")
	self.getAllBtn = self.taskPanel:Find("BtnGetAll")
	self.getAllBtnDisable = self.taskPanel:Find("BtnGetAllDisable")
	self.getNextBtn = self.taskPanel:Find("BtnGetMore")
	self.taskUIItemList = UIItemList.New(self.taskTplContainer, self.taskTpl)
	self.sizeH = GetComponent(self.taskTpl, "LayoutElement").preferredHeight
	self.spaceH = GetComponent(self.taskTplContainer, "VerticalLayoutGroup").spacing
	self.topH = GetComponent(self.taskTplContainer, "VerticalLayoutGroup").padding.top
	self.scrollSC = GetComponent(self.taskPanel:Find("Scroll"), "ScrollRect")
	self.actTimePanel = self._tf:Find("TaskPanel/ActTimePanel")
	self.actTimeText = self._tf:Find("TaskPanel/ActTimePanel/Text")

	return
end

function MetaCharacterSynLayer:addListener()
	onButton(self, self.getAllBtn, function()
		local var_10_0, var_10_1 = self:getOneStepPTAwardLevelAndCount()

		pg.m02:sendNotification(GAME.GET_META_PT_AWARD, {
			groupID = self.curMetaProgressVO.id,
			targetCount = var_10_1
		})

		return
	end, SFX_PANEL)
	onButton(self, self.getAllBtnDisable, function()
		return
	end)
	onButton(self, self.getNextBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("meta_pt_notenough"))

		return
	end)
	onButton(self, self.showWayBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = {
				count = 0,
				type = DROP_TYPE_ITEM,
				id = self.curMetaProgressVO.metaPtData.resId
			}
		})

		return
	end, SFX_PANEL)

	return
end

function MetaCharacterSynLayer:TryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0028")

	return
end

function MetaCharacterSynLayer:updateActTimePanel()
	if type(self.curMetaProgressVO.timeConfig) == "string" then
		setActive(self.actTimePanel, false)
	elseif type(self.curMetaProgressVO.timeConfig) == "table" then
		setText(self.actTimeText, i18n("meta_pt_left", (pg.TimeMgr.GetInstance():DiffDay(pg.TimeMgr.GetInstance():GetServerTime(), (pg.TimeMgr.GetInstance():parseTimeFromConfig(self.curMetaProgressVO.timeConfig[2]))))))
	end

	return
end

function MetaCharacterSynLayer:updateShipImg()
	local var_16_0, var_16_1 = MetaCharacterConst.GetMetaCharacterPaintPath(self.curMetaCharacterVO.id, true)

	setImageSprite(self.shipImg, LoadSprite(var_16_0, var_16_1), true)
	setLocalPosition(self.shipImg, {
		x = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][9],
		y = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][10]
	})
	setLocalScale(self.shipImg, {
		x = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][3],
		y = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][4]
	})

	return
end

function MetaCharacterSynLayer:updatePtPanel()
	setImageSprite(self.ptIconLeft, LoadSprite(self.curMetaProgressVO:getPtIconPath()))
	setText(self.ptSynRateText, string.format("%d", self.curMetaProgressVO:getSynRate() * 100) .. "%")
	setText(self.ptNumText, (self.curMetaProgressVO.metaPtData:GetResProgress()))

	return
end

function MetaCharacterSynLayer:updateTaskList()
	self.taskUIItemList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			arg_19_1 = arg_19_1 + 1

			self:updateTaskTpl(arg_19_2, arg_19_1)
		end

		return
	end)

	local var_18_0, var_18_1, var_18_2 = self.curMetaProgressVO.metaPtData:GetLevelProgress()

	self.taskUIItemList:align(var_18_1)
	setLocalPosition(self.taskTplContainer, {
		y = self.topH + (var_18_0 - 1) * (self.sizeH + self.spaceH)
	})

	return
end

function MetaCharacterSynLayer:updateTaskTpl(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:Find("Info/AwardInfo/Award/Tag/Get")
	local var_20_1 = arg_20_1:Find("Info/AwardInfo/Award/Tag/Got")
	local var_20_2 = arg_20_1:Find("GotMask")

	setText(arg_20_1:Find("Target/IndexText"), arg_20_2)
	setText(arg_20_1:Find("PT/Count/NumText"), self.curMetaProgressVO.metaPtData.targets[arg_20_2])
	setImageSprite(arg_20_1:Find("PT/Icon"), LoadSprite(self.curMetaProgressVO:getPtIconPath()))

	local var_20_3 = Drop.Create(self.curMetaProgressVO.metaPtData.dropList[arg_20_2])

	updateDrop(arg_20_1:Find("Info/AwardInfo/Award/Item"), var_20_3, {
		hideName = true
	})
	onButton(self, arg_20_1:Find("Info/AwardInfo/Award"), function()
		self:emit(BaseUI.ON_DROP, var_20_3)

		return
	end, SFX_PANEL)
	setText(arg_20_1:Find("Info/AwardInfo/NameMask/NameText"), shortenString(var_20_3:getConfig("name"), 6))
	setText(arg_20_1:Find("Info/AwardInfo/SynProgressText"), math.round(self.curMetaProgressVO.metaPtData.targets[arg_20_2] / self.curMetaProgressVO.unlockPTNum * 100) .. "%")

	if arg_20_2 < self.curMetaProgressVO.metaPtData.level + 1 then
		setActive(var_20_1, true)
		setActive(var_20_0, false)
		setActive(var_20_2, true)
		setGray(arg_20_1, true, true)
	else
		if self.curMetaProgressVO.metaPtData.targets[arg_20_2] > self.curMetaProgressVO.metaPtData.count then
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

function MetaCharacterSynLayer:updateGetAwardBtn()
	if self.curMetaProgressVO.metaPtData:CanGetAward() then
		setActive(self.getAllBtn, true)
		setActive(self.getAllBtnDisable, false)
		setActive(self.getNextBtn, false)
	elseif self.curMetaProgressVO.metaPtData:CanGetNextAward() then
		setActive(self.getAllBtn, false)
		setActive(self.getAllBtnDisable, false)
		setActive(self.getNextBtn, true)
	else
		setActive(self.getAllBtn, false)
		setActive(self.getAllBtnDisable, true)
		setActive(self.getNextBtn, false)
	end

	return
end

function MetaCharacterSynLayer:moveShipImg(arg_23_1)
	local var_23_0 = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id]

	self:managedTween(LeanTween.moveX, nil, rtf(self.shipImg), (arg_23_1 or nil) and (var_23_0[9] or -2000), 0.3):setFrom(arg_23_1 and -2000 or var_23_0[9])

	return
end

function MetaCharacterSynLayer:movePanel()
	self:managedTween(LeanTween.moveX, nil, rtf(self.taskPanel), 500, 0.3):setFrom(2000)
	self:managedTween(LeanTween.moveX, nil, rtf(self.ptPanel), -516, 0.3):setFrom(-2000)

	return
end

function MetaCharacterSynLayer:enablePartialBlur()
	if self._tf then
		local var_25_0 = {}

		table.insert(var_25_0, self.taskPanel)
		self:OverlayPanel(self._tf, {
			groupDelta = -1,
			pbList = var_25_0
		})
	end

	return
end

function MetaCharacterSynLayer:disablePartialBlur()
	if self._tf then
		self:UnOverlayPanel(self._tf)
	end

	return
end

function MetaCharacterSynLayer:getOneStepPTAwardLevelAndCount()
	local var_27_0 = self.curMetaProgressVO.metaPtData:GetResProgress()
	local var_27_1 = self.curMetaProgressVO:getStoryIndexList()
	local var_27_3 = 0

	for iter_27_0 = 1, #self.curMetaProgressVO.metaPtData.targets do
		local var_27_4 = false
		local var_27_5 = false

		if var_27_0 >= self.curMetaProgressVO.metaPtData.targets[iter_27_0] then
			var_27_4 = true
		end

		if var_27_1[iter_27_0] == 0 then
			var_27_5 = true
		elseif pg.NewStoryMgr.GetInstance():IsPlayed(var_27_1[iter_27_0]) then
			var_27_5 = true
		end

		if var_27_4 and var_27_5 then
			var_27_3 = iter_27_0
		else
			break
		end
	end

	print("calc max level", var_27_3, self.curMetaProgressVO.metaPtData.targets[var_27_3])

	return var_27_3, self.curMetaProgressVO.metaPtData.targets[var_27_3]
end

function MetaCharacterSynLayer:goWorldFunc()
	getProxy(ContextProxy):getContextByMediator(MetaCharacterMediator).data.lastPageIndex = pg.m02:retrieveMediator("MetaCharacterMediator").viewComponent.curPageIndex

	self:closeView()
	self:sendNotification(GAME.GO_SCENE, SCENE.WORLDBOSS)

	return
end

return MetaCharacterSynLayer
