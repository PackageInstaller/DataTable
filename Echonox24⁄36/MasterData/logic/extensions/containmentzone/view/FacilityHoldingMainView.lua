-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingMainView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingMainView", package.seeall)

local M = class("FacilityHoldingMainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._rootGo = self.mainGO
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._txtReturnBtn = self:getText("1&title_view_-788888785")
	self._btnHideUI = self:getBtn("facility_holding_main_view_178398535")
	self._HideUIMarkShow = self:getGo("facility_holding_main_view_2847706")
	self._HideUIMarkHide = self:getGo("facility_holding_main_view_159495249")
	self._btnFacilityManage = self:getBtn("facility_holding_main_view_272249212")
	self._btnPersonnelManage = self:getBtn("facility_holding_main_view_1669882228")
	self._btnDressUp = self:getBtn("facility_holding_main_view_102530839")
	self._btnChangeAction = self:getBtn("facility_holding_main_view_1318812084")
	self._bigBgAction1 = self:getImage("facility_holding_main_view_1615000303")
	self._bigBgAction2 = self:getImage("facility_holding_main_view_1834577582")
	self._bigBgAction3 = self:getImage("facility_holding_main_view_406534214")
	self._ActionMarkGroup = {}
	self._ActionMarkGroup[1] = self._bigBgAction1
	self._ActionMarkGroup[2] = self._bigBgAction2
	self._ActionMarkGroup[3] = self._bigBgAction3
	self._orgPosY = -16
	self._offsetY = 80
	self._rootPressureValueGroup = self:getRectTransform("facility_holding_main_view_1912736687")
	self._prefabPressureValue = self:getGo("facility_holding_main_view_57006698")
	self._rootBtnL = self:getGo("facility_holding_main_view_320817230")
	self._rootBtnR = self:getGo("facility_holding_main_view_619688804")
	self._rootTop = self:getGo("facility_holding_main_view_142400246")
	self._rootCurrency = self:getGo("0&top_currency_1050779625")
	self._rootTitle = self:getGo("1&title_view_-478490097")
	self._rootPoint = self:getGo("facility_holding_main_view_1689953045")
	self._btnEventBlocker = self:getBtn("facility_holding_main_view_-28538820")
	self._rootHintPerson = self:getGo("facility_holding_main_view_310411435")
	self._rootHintEfficient = self:getRectTransform("facility_holding_main_view_-1333505337")
	self._hintHero = {
		btn = self:getBtn("facility_holding_main_view_-1878248517"),
		icon = self:getImage("facility_holding_main_view_1105459490"),
		goNoHero = self:getGo("facility_holding_main_view_-960399951"),
		goMoodRoot = self:getGo("facility_holding_main_view_147460243"),
		Mood = {
			{
				go = self:getGo("facility_holding_main_view_-756170984"),
				img = self:getImage("facility_holding_main_view_1588458514")
			},
			{
				go = self:getGo("facility_holding_main_view_-945065737"),
				img = self:getImage("facility_holding_main_view_1526990284")
			},
			{
				go = self:getGo("facility_holding_main_view_-725929875"),
				img = self:getImage("facility_holding_main_view_340309818")
			}
		}
	}
	self._btnPropertyTip = self:getBtn("facility_holding_main_view_-1999277383")
	self._holdingTipsView = FacilityHoldingTipsView.New(self.mainGO, self._viewPresentor)

	self._holdingTipsView:buildUI()
end

function M:destroyUI()
	self._rootGo = nil
	self._guiAnimation = nil
	self._txtReturnBtn = nil
	self._btnHideUI = nil
	self._HideUIMarkShow = nil
	self._HideUIMarkHide = nil
	self._btnFacilityManage = nil
	self._btnPersonnelManage = nil
	self._btnDressUp = nil
	self._btnChangeAction = nil
	self._bigBgAction1 = nil
	self._bigBgAction2 = nil
	self._bigBgAction3 = nil
	self._ActionMarkGroup = nil
	self._rootPressureValueGroup = nil
	self._prefabPressureValue = nil
	self._rootBtnL = nil
	self._rootBtnR = nil
	self._rootTop = nil
	self._rootCurrency = nil
	self._rootTitle = nil
	self._rootPoint = nil
	self._btnEventBlocker = nil
	self._rootHintPerson = nil
	self._rootHintEfficient = nil
	self._hintHero = nil
	self._btnPropertyTip = nil

	self._holdingTipsView:destroyUI()

	self._holdingTipsView = nil
end

function M:bindEvents()
	self._btnHideUI:AddClickListener(self._onClickHideUI, self)
	self._btnFacilityManage:AddClickListener(self._onClickFacilityManage, self)
	self._btnPersonnelManage:AddClickListener(self._onClickPersonnelManage, self)
	self._btnDressUp:AddClickListener(self._onClickDressUp, self)
	self._btnChangeAction:AddClickListener(self._onClickChangeAction, self)
	self._btnEventBlocker:AddClickListener(self._onClickEventBlocker, self)
	self._hintHero.btn:AddClickListener(self._onClickHeroHint, self)
	self._btnPropertyTip:AddClickListener(self._onClickPropertyTip, self)
	self._holdingTipsView:bindEvents()
end

function M:unbindEvents()
	self._btnHideUI:RemoveClickListener()
	self._btnFacilityManage:RemoveClickListener()
	self._btnPersonnelManage:RemoveClickListener()
	self._btnDressUp:RemoveClickListener()
	self._btnChangeAction:RemoveClickListener()
	self._btnEventBlocker:RemoveClickListener()
	self._hintHero.btn:RemoveClickListener()
	self._btnPropertyTip:RemoveClickListener()
	self._holdingTipsView:unbindEvents()
end

function M:onEnter()
	goutil.setActive(self._btnDressUp.gameObject, false)
	goutil.setActive(self._btnEventBlocker.gameObject, false)
	self._holdingTipsView:setShow(false)

	local info = self:getFirstParam()

	self.roomId = info and info.roomId or 0

	self:_enterRoom(self.roomId)

	local nowTime = ServerTime.now()

	if nowTime - ContainmentModel.instance:getLastUpdateRoomLstTS() >= HouseMainEnum.ServerScheduleTime then
		ContainmentZoneAgent.instance:sendGetHoldRoomInfoRequest()
	end

	self:setEvent(true)
end

function M:onExit(closeReasonType)
	self:setEvent(false)

	for key, value in pairs(self._ActionMarkGroup) do
		goutil.setActive(value.gameObject, false)
	end

	if closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
	end
end

function M:setEvent(add)
	if add then
		settimer(HouseMainEnum.ServerScheduleTime, self._timerAutoGetRoomInfoFromServer, self, true)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._handleHouseProtomerInfoChange, self)
	else
		removetimer(self._timerAutoGetRoomInfoFromServer, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._handleHouseProtomerInfoChange, self)
	end
end

function M:_timerAutoGetRoomInfoFromServer()
	ContainmentZoneAgent.instance:sendGetHoldRoomInfoRequest()
end

function M:_handleHouseHoldRoomInfoChange()
	self:_enterRoom(self.roomId)
end

function M:_handleHouseProtomerInfoChange()
	self:_enterRoom(self.roomId)
end

function M:_onClickHideUI()
	local show = not self._rootTitle.activeSelf

	goutil.setActive(self._HideUIMarkShow, not show)
	goutil.setActive(self._HideUIMarkHide, show)
	goutil.setActive(self._rootBtnL, show)
	goutil.setActive(self._rootBtnR, show)
	goutil.setActive(self._rootTop, show)
	goutil.setActive(self._rootCurrency, show)
	goutil.setActive(self._rootTitle, show)
	goutil.setActive(self._rootPoint, show)

	local protomerId = ContainmentModel.instance:getProtomerId(self.roomId)

	goutil.setActive(self._rootHintPerson, show and protomerId and protomerId > 0)
end

function M:_onClickFacilityManage()
	local roomInfo = ContainmentModel.instance:getRoomInfoById(self.roomId)

	if roomInfo then
		if roomInfo:hasProtomer() then
			local protomerId = roomInfo:getProtomerId()

			ContainmentFacade.instance:openHoldingManageView(protomerId)
		else
			local defaultSelectTabIndex = self.roomId > 1100 and self.roomId - 1100 or self.roomId

			ContainmentFacade.instance:openHoldingChangeView(defaultSelectTabIndex)
		end
	end
end

function M:_onClickPersonnelManage()
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(self.roomId)

	ViewMgr.instance:open(ViewName.JobDetail, {
		clickIndex = 1,
		roomIndex = jobConfigList[1].houseIndex
	})
end

function M:_onClickDressUp()
	FloatWordMgr.instance:show(lang("tip_please_expect"))
end

function M:_onClickChangeAction()
	ToolTipsMgr.showFacilityHoldingBillboardTips(self.roomId)
end

function M:_onClickEventBlocker()
	local show = not self._btnEventBlocker.gameObject.activeSelf

	goutil.setActive(self._btnEventBlocker.gameObject, show)
	self._holdingTipsView:setShow(show)
end

function M:_onClickHeroHint()
	self:_onClickPersonnelManage()
end

function M:_onClickPropertyTip()
	local hasProtomer = ContainmentModel.instance:getProtomerId(self.roomId)

	if hasProtomer then
		self:_onClickEventBlocker()
	end
end

function M:_updatePressureShow(curVal, maxVal)
	while self._rootPressureValueGroup.childCount < maxVal + 1 do
		goutil.cloneAndSetParent(self._prefabPressureValue, self._rootPressureValueGroup)
	end

	for i = 1, self._rootPressureValueGroup.childCount - 1 do
		local show = i <= maxVal
		local active = i <= curVal
		local tempTr = self._rootPressureValueGroup:GetChild(i)

		if show then
			goutil.setActive(tempTr:GetChild(0).gameObject, active)
		end

		goutil.setActive(tempTr.gameObject, show)
	end
end

function M:_updateBillBoardShow(billboardT)
	self._billBoardCount = billboardT and #billboardT or 0

	for key, value in pairs(self._ActionMarkGroup) do
		local show = false

		goutil.setActive(value.gameObject, show)
	end

	self:_updateBillBoardChangeBtnPos()
end

function M:_updateBillBoardChangeBtnPos()
	local x, y = Astral.TransformUtil.GetAnchoredPos(self._btnChangeAction.transform, 0, 0)

	y = self._orgPosY - self._billBoardCount * self._offsetY

	RectTransformUtils.SetAnchoredPosition(self._btnChangeAction.transform, x, y)

	if ContainmentModel.instance:getProtomerId(self.roomId) > 0 then
		settimer(0.1, self._tryGetBillBoardScreenPos, self, false)
	end
end

function M:_tryGetBillBoardScreenPos()
	removetimer(self._tryGetBillBoardScreenPos, self)

	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.roomMgr then
		local roomUnit = currScene.roomMgr:getUnitById(self.roomId)

		if roomUnit then
			local billBoardComp = roomUnit:getComponents("shelterBillboard")

			if billBoardComp then
				billBoardComp:tryGetBillBoardScreenPos(self._onGetBillBoardScreenPos, self)
			else
				printWarn("ShelterRoomUnit找不到组件shelterBillboard")
			end
		else
			printWarn(string.format("无法获取[%d]房间的ShelterRoomUnit", self.roomId))
		end
	end
end

function M:_onGetBillBoardScreenPos(screenPos)
	if screenPos and self._rootGo then
		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
		local uiPos = Astral.GeometryUtil.ScreenToLocalPos(screenPos, self._rootGo.transform, uiCamera)

		RectTransformUtils.SetAnchoredPosition(self._rootBtnR.transform, uiPos.x, uiPos.y)
	end
end

function M:_changeBillBoardIcon(img, billboardId)
	local protomerId = ContainmentModel.instance:getProtomerId(self.roomId)

	ContainmentUtil.changeBillBoardIcon(img, protomerId, 2, billboardId)
end

function M:_enterRoom(roomId)
	local roomInfo = ContainmentModel.instance:getRoomInfoById(roomId)
	local hasProtomer = false

	if roomInfo == nil then
		self:_enterUnlockRoom()
	else
		self._txtReturnBtn.text = roomInfo:getRoomName()
		hasProtomer = roomInfo:hasProtomer()

		if hasProtomer then
			local protomerInfo = ContainmentModel.instance:getProtomerInfo(roomId)

			self:_updatePressureShow(protomerInfo:getPressure(), protomerInfo:getPressureLimitEnhance())
			self:_updateBillBoardShow(protomerInfo:getBillBoardActiveTable())
			self:_updateHintPerson(roomInfo, protomerInfo)
			self._holdingTipsView:updateShow(roomInfo, protomerInfo)
		else
			self:_updatePressureShow(0, 0)
			self:_updateBillBoardShow(nil)
		end
	end

	goutil.setActive(self._btnPersonnelManage.gameObject, hasProtomer)
	goutil.setActive(self._btnChangeAction.gameObject, hasProtomer)
	goutil.setActive(self._rootHintPerson, hasProtomer)
	GlobalDispatcher:dispatchEvent(EventType.HOUSE_MAIN_ROOM_ENTER, roomId)
end

function M:_enterUnlockRoom()
	self._txtReturnBtn.text = lang("tip_lock_room")

	self:_updatePressureShow(0, 0)
	self:_updateBillBoardShow(nil)
end

function M:_updateHintPerson(roomInfoMo, protomerInfoMo)
	self:_updateHintHeroInfo(roomInfoMo)

	local holdEfficient = protomerInfoMo:getHoldEfficient()

	for i = 0, self._rootHintEfficient.childCount - 1 do
		local tmpGo = self._rootHintEfficient:GetChild(i):GetChild(0).gameObject
		local show = i < holdEfficient

		goutil.setActive(tmpGo, show)
	end
end

function M:_updateHintHeroInfo(roomInfoMo)
	local heroId = roomInfoMo:getHeroId()

	if heroId > 0 then
		IconLoader.setSprite(self._hintHero.icon, IconType.HeadIcon, ContainmentUtil.getHeroHeadIconSrc(heroId))

		local moodValue = ContainmentUtil.getHeroRoomMood(heroId)
		local moodMaxValue = HouseConfig.instance:getHouseConst("MoodMax").numValue
		local moodTyp = HouseWorkerModel.instance:getMoodInterval(moodValue)
		local fillAmount = moodValue / moodMaxValue

		for index, value in ipairs(self._hintHero.Mood) do
			local show = index == moodTyp

			if show then
				value.img.fillAmount = fillAmount
			end

			goutil.setActive(value.go, show)
		end
	end

	goutil.setActive(self._hintHero.icon.gameObject, heroId > 0)
	goutil.setActive(self._hintHero.goMoodRoot, heroId > 0)
	goutil.setActive(self._hintHero.goNoHero, heroId == 0)
end

function M:_fakeMaskForTest()
	self._fakeMask = goutil.findChildImageComponent(self.mainGO, "fakeMask")

	if self._fakeMask == nil then
		local tempCreateMaskGo = goutil.create("fakeMask", true)
		local tempRect = tempCreateMaskGo:GetComponent(goutil.Type_RectTransform)

		goutil.addChildToParent(tempCreateMaskGo, self.mainGO)
		Astral.TransformUtil.SetLocalPos(tempCreateMaskGo.transform, 0, 0, 0)

		local mainRectTrans = self.mainGO:GetComponent(goutil.Type_RectTransform)

		goutil.setWidth(tempRect, goutil.getWidth(mainRectTrans))
		goutil.setHeight(tempRect, goutil.getHeight(mainRectTrans))
		tempCreateMaskGo.transform:SetAsFirstSibling()
	end
end

function M:_fakeBtnForTest()
	self._btnUnLockRoom = goutil.findChild(self._rootPoint, "fakeBtnUnlock")

	if self._btnUnLockRoom == nil then
		self._btnUnLockRoom = goutil.create("fakeBtnUnlock", true)

		local tempRect = self._btnUnLockRoom:GetComponent(goutil.Type_RectTransform)

		goutil.setHeight(tempRect, 50)
		goutil.addChildToParent(self._btnUnLockRoom, self._rootPoint)
		Astral.TransformUtil.SetLocalPos(self._btnUnLockRoom.transform, 0, -200, 0)
		self._btnUnLockRoom.transform:SetAsLastSibling()

		local image = self._btnUnLockRoom:AddComponent(goutil.Type_UIImage)

		image.raycastTarget = true

		local textGo = goutil.create("Text", true)

		goutil.addChildToParent(textGo, self._btnUnLockRoom)
		goutil.setHeight(textGo:GetComponent(goutil.Type_RectTransform), 50)

		local txt = textGo:AddComponent(goutil.Type_UIText)

		txt.font = self._txtReturnBtn.font
		txt.text = lang("tip_unlock")
		txt.resizeTextForBestFit = true
	end

	self._btnUnLockRoom = UIComponentType.ButtonAdapter(self._btnUnLockRoom)

	self._btnUnLockRoom:AddClickListener(self._fakeOnClickUnLockRoom, self)

	self._btnStopHolding = goutil.findChild(self._rootPoint, "fakeBtnStopHolding")

	if self._btnStopHolding == nil then
		self._btnStopHolding = goutil.create("fakeBtnStopHolding", true)

		local tempRect = self._btnStopHolding:GetComponent(goutil.Type_RectTransform)

		goutil.setHeight(tempRect, 50)
		goutil.addChildToParent(self._btnStopHolding, self._rootPoint)
		Astral.TransformUtil.SetLocalPos(self._btnStopHolding.transform, 0, -260, 0)
		self._btnStopHolding.transform:SetAsLastSibling()

		local image = self._btnStopHolding:AddComponent(goutil.Type_UIImage)

		image.raycastTarget = true

		local textGo = goutil.create("Text", true)

		goutil.addChildToParent(textGo, self._btnStopHolding)
		goutil.setHeight(textGo:GetComponent(goutil.Type_RectTransform), 50)

		local txt = textGo:AddComponent(goutil.Type_UIText)

		txt.font = self._txtReturnBtn.font
		txt.text = lang("tip_room_report")
		txt.resizeTextForBestFit = true
	end

	self._btnStopHolding = UIComponentType.ButtonAdapter(self._btnStopHolding)

	self._btnStopHolding:AddClickListener(self._fakeOnClickStopHolding, self)

	self._btnTestBtn = goutil.findChild(self._rootPoint, "TestBtn")

	if self._btnTestBtn == nil then
		self._btnTestBtn = goutil.create("TestBtn", true)

		local tempRect = self._btnTestBtn:GetComponent(goutil.Type_RectTransform)

		goutil.setHeight(tempRect, 50)
		goutil.addChildToParent(self._btnTestBtn, self._rootPoint)
		Astral.TransformUtil.SetLocalPos(self._btnTestBtn.transform, -400, -260, 0)
		self._btnTestBtn.transform:SetAsLastSibling()

		local image = self._btnTestBtn:AddComponent(goutil.Type_UIImage)

		image.raycastTarget = true

		local textGo = goutil.create("Text", true)

		goutil.addChildToParent(textGo, self._btnTestBtn)
		goutil.setHeight(textGo:GetComponent(goutil.Type_RectTransform), 50)

		local txt = textGo:AddComponent(goutil.Type_UIText)

		txt.font = self._txtReturnBtn.font
		txt.text = lang("tip_room_info")
		txt.resizeTextForBestFit = true
	end

	self._btnTestBtn = UIComponentType.ButtonAdapter(self._btnTestBtn)

	self._btnTestBtn:AddClickListener(self._fakeOnClickTestBtn, self)
end

function M:_fakeOnClickUnLockRoom()
	local roomIds = HouseMainRoomModel.instance:getRoomIdsLst(HouseEnum.RoomType.Shelter)
	local toBeUnlockRoomId = 0

	if roomIds and #roomIds > 0 then
		for _, cfgRoomId in pairs(roomIds) do
			if not ContainmentModel.instance:getRoomInfoExist(cfgRoomId) then
				toBeUnlockRoomId = cfgRoomId

				break
			end
		end
	end

	if toBeUnlockRoomId > 0 then
		print(string.format("检测到收容室[%d]尚未解锁，发送解锁", toBeUnlockRoomId))
		LivingFacilitiesAgent.instance:sendActiveZoneRequest(toBeUnlockRoomId)
	else
		print("没有可解锁的收容室")
	end
end

function M:_fakeOnClickStopHolding()
	local roomId = self.roomId

	print(string.format("收容室[%d]原体，重新获取房间报告", roomId))
	ContainmentZoneAgent.instance:sendGetReportsRequest(roomId)
end

function M:_fakeOnClickTestBtn()
	local roomId = self.roomId

	print(string.format("收容室[%d],重新获取房间信息", roomId))
	ContainmentZoneAgent.instance:sendGetSingleHoldRoomInfoRequest(roomId)
end

function M:_fakeBindEvents()
	self:_fakeMaskForTest()
	self:_fakeBtnForTest()
end

function M:_fakeUnBindEvents()
	if self._btnUnLockRoom then
		self._btnUnLockRoom:RemoveClickListener()
	end

	if self._btnStopHolding then
		self._btnStopHolding:RemoveClickListener()
	end

	if self._btnTestBtn then
		self._btnTestBtn:RemoveClickListener()
	end
end

function M:_fakeDestroyUI()
	self._btnUnLockRoom = nil
	self._btnStopHolding = nil
	self._btnTestBtn = nil
end

function M:_fakeDuelReportLst()
	local _reportLst = {}
	local roomId = 1

	if ContainmentModel.instance:getRoomInfoExist(roomId) then
		local reportLstFromServer = ContainmentReportModel.instance:getReportLst(roomId)

		reportLstFromServer = ContainmentUtil.sortHoldRoomReport(reportLstFromServer)

		for _, value in pairs(reportLstFromServer) do
			table.insert(_reportLst, value)
		end

		local reportRunning = ContainmentModel.instance:getRunningReport(roomId)

		if reportRunning:getIsVaild() then
			table.insert(_reportLst, 1, reportRunning)
		end

		ContainmentFacade.instance:openReprotDetailView(roomId, _reportLst)
	end
end

return M
