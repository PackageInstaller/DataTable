-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/view/SevenSigninTipsView.lua

module("logic.extensions.signin.view.SevenSigninTipsView", package.seeall)

local M = class("SevenSigninTipsView", ViewComponent)
local kDayCount = 7
local kRemainMaxDay = 99

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Wekfare)

	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._txtTime = self:getText("seven_signin_tips_985652879")
	self._btnFullScreenSignIn = self:getBtn("seven_signin_tips_-820459949")
	self._btnFullScreenClose = self:getBtn("seven_signin_tips_-422554575")
	self._btnJumpAni = self:getBtn("seven_signin_tips_-226371977")
	self._btnClose = self:getBtnByPath("btn_close")

	local rawImgCommBlurRt = goutil.findChildRawImageComponent(self.mainGO, "common_blur_rt")

	if rawImgCommBlurRt then
		rawImgCommBlurRt.raycastTarget = false
	end

	local rectItemRoot = self:getUIComponent("seven_signin_tips_137837635", UIComponentType.RectTransform)

	self._signGroup = {}

	for i = 0, rectItemRoot.childCount - 1 do
		local tmpGo = rectItemRoot:GetChild(i).gameObject
		local day = i + 1
		local shower = Astral.SimpleLuaComponentContainer.Add(tmpGo, WelfareSignInItemCell)

		self._signGroup[day] = shower
	end

	self._signLineItems = {}

	local tranfLineGroup = self:getUIComponent("seven_signin_tips_1686219713", UIComponentType.RectTransform)

	for i = 0, tranfLineGroup.childCount - 1 do
		local goLine = tranfLineGroup:GetChild(i).gameObject

		self._signLineItems[i + 1] = {
			point1 = goutil.findChild(goLine, "point1"),
			point2 = goutil.findChild(goLine, "point2"),
			canvas = goLine:GetComponent(ComponentType.CanvasGroup)
		}
	end
end

function M:destroyUI()
	self._txtTime = nil
	self._signGroup = nil
	self._btnFullScreenSignIn = nil
	self._btnClose = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Wekfare)
	self:fakeDestroyUI()
end

function M:bindEvents()
	self._btnJumpAni:AddClickListener(self._onClickJumpAni, self)
	self._btnFullScreenClose:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnFullScreenSignIn:AddClickListener(self._onClickFullScreenSignIn, self)
end

function M:unbindEvents()
	self._btnJumpAni:RemoveClickListener()
	self._btnFullScreenClose:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnFullScreenSignIn:RemoveClickListener()
	self:fakeUnBindEvent()
end

function M:onEnter()
	goutil.setActive(self._btnJumpAni.gameObject, true)

	self._waitForSign = false
	self._openAniFinish = false
	self._canvasGroup.interactable = true

	self:_setEvent(true)
	self:showFullScreenSignInBtn(false)

	self._isEnter = true

	local info = self:getFirstParam() or {}

	self._activityId = info.actId

	if not self._activityId then
		if enableLog then
			printWarn("活动id为空")
		end

		self:close()

		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.WelfareSignInHistory, false) then
		if enableLog then
			printWarn("七登功能未开启")
		end

		self:close()

		return
	end

	local actMo = ActivityModel.instance:getActivityById(self._activityId)

	if actMo == nil or actMo == false then
		if enableLog then
			printWarn(string.format("ActivityModel没有[%s]对应数据", self._activityId))
		end

		self:close()

		return
	end

	if not actMo:getIsOpen() then
		if enableLog then
			printWarn(string.format("七登[%s]未开启", self._activityId))
		end

		self:close()

		return
	end

	if enableLog then
		printWarn(string.format("七登formula[%s],actId[%s]", actMo:getConfigId(), self._activityId))
	end

	self:refreshData()
	self:updateShow()
	self:checkOpen()
end

function M:onExit()
	self._canvasGroup.interactable = false

	self:_setEvent(false)

	self._isEnter = nil

	self:showFullScreenSignInBtn(false)

	local info = self:getFirstParam() or {}

	if info.openByPopUp then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_VIEW_EXIT)
	end
end

function M:_onClickJumpAni()
	goutil.setActive(self._btnJumpAni.gameObject, false)

	if not self._openAniFinish then
		self._viewPresentor:jumpOpenAniToEnd()

		return
	end
end

function M:_onClickClose()
	if self._waitForSign then
		if enableLog then
			printWarn("waitForSign...")
		end

		return
	end

	self:close()
end

function M:getActivityId()
	return self._activityId
end

function M:_getSignInActId()
	return self._activityId
end

function M:_getSignInData()
	return WelfareSigninModel.instance:getSignInMo(self._activityId)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_RECEIVE_REWARD, self._onReceiveReward, self)
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_RECEIVE_REWARD, self._onReceiveReward, self)
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handleSignInInfoChange(e)
	self:refreshData()
end

function M:_onReceiveReward(e, actvityId, day)
	if self._activityId == actvityId then
		self:dealSignInAni(day)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "open" then
		goutil.setActive(self._btnJumpAni.gameObject, false)

		self._openAniFinish = true
		self._canvasGroup.interactable = true

		if self._autoSign then
			self._autoSign = false

			self:_onClickFullScreenSignIn()
		end
	end
end

function M:dealSignInAni(day)
	local theItem = self._signGroup[day]

	if not theItem:getIsSign() then
		if theItem then
			theItem:playSignAni(self._playSignInAniCallBack, self)
		else
			self:_playSignInAniCallBack()
		end
	end
end

function M:_playSignInAniCallBack()
	self:updateShow()
	settimer(0.2, function()
		local popUp = SigninController.instance:tryPopUpCacheSignInReward(self._closeGainItemView, self)

		if not popUp then
			self._waitForSign = false
		end
	end, self, false)
end

function M:_closeGainItemView()
	self._waitForSign = false
end

function M:_refreshNewSignInfo()
	local actData = self:_getSignInData()
	local actId = actData:getActivity()

	self:refreshData()
	self:updateShow()

	local isAllReceive = WelfareSigninModel.instance:isAllReceive(actId)

	self:showFullScreenSignInBtn(not isAllReceive)
end

function M:showFullScreenSignInBtn(show, autoSign)
	goutil.setActive(self._btnFullScreenSignIn.gameObject, show)

	self._autoSign = false

	if show then
		self._autoSign = autoSign
	end
end

function M:_onClickFullScreenSignIn()
	local actData = self:_getSignInData()

	if actData == nil then
		FloatWordMgr.instance:show(lang("tip_activity_over"))
		self:close()

		return
	end

	local actId = actData:getActivity()

	if enableLog then
		print(actId)
	end

	if not WelfareSigninUtil.getSignInActIsOpen(actId) then
		FloatWordMgr.instance:show(lang("tip_activity_over"))
		self:close()

		return
	end

	self:showFullScreenSignInBtn(false)

	local signInMo = WelfareSigninModel.instance:getSignInMo(actId)
	local isAllReceive = signInMo:isAllReceive(actId)

	if not isAllReceive then
		local signDay
		local maxDay = signInMo:getMaxRewardDay()

		for i = 1, maxDay do
			if not signDay and WelfareSigninModel.instance:isCanReceive(actId, i) then
				signDay = i
			end
		end

		if signDay then
			self._waitForSign = true

			if Astral.OSDef.isEditor and actData:getIsFakeData() then
				self:_fakeOnClickSign()
				self:showFullScreenSignInBtn(false)

				return
			end

			WelfareSigninAgent.instance:sendTakeSignInRewardRequest(actId, signDay)
		end
	end
end

function M:playSignInAni(uiIndex, timeStamp, callBackFunc, callBackHandler)
	local theItem = self._signGroup[uiIndex]

	if theItem then
		local actTyp = WelfareSigninEnum.ActTyp.SevenDaySignIn

		theItem:playSignAni(actTyp, timeStamp, callBackFunc, callBackHandler)
	else
		callBackHandler:callBackFunc()
	end
end

function M:refreshData()
	local signInMo = self:_getSignInData()

	if signInMo == nil then
		if enableLog then
			printWarn("七日签到数据Mo为空")
		end

		return
	end

	self._typ = signInMo:getActTyp()

	self:checkOpen()

	self._totalSigned = signInMo:getTotalSigned()

	local isAllReceive = WelfareSigninModel.instance:isAllReceive(self:_getSignInActId())

	self:showFullScreenSignInBtn(not isAllReceive, true)
end

function M:checkOpen()
	local actMo = ActivityModel.instance:getActivityById(self:_getSignInActId())

	if actMo then
		if not actMo:getIsOpen() then
			self:_showExpirePopUpContent(lang("tip_activity_over"))

			return false
		end
	else
		self:_showExpirePopUpContent(lang("tip_activity_over"))

		return false
	end

	return true
end

function M:_showExpirePopUpContent(str)
	if self._isEnter then
		FloatWordMgr.instance:show(str)
	end
end

function M:updateShow()
	local actId = self:_getSignInActId()
	local actTyp = WelfareSigninEnum.ActTyp.SevenDaySignIn
	local formula = WelfareSigninUtil.getSignInActFormula(actId)

	if enableLog then
		printWarn(string.format("[%s] formula[%s]今天签到[%s]", actId, formula, self._todaySigned))
	end

	for day, shower in pairs(self._signGroup or {}) do
		local isReceived = WelfareSigninModel.instance:isReceived(actId, day)
		local rewardTable = WelfareSigninConfig.instance:getHistoryReward(formula, day)
		local itemId = rewardTable and rewardTable.code or 0
		local itemCount = rewardTable and rewardTable.num or 0
		local canReceive = self:_isCanReceive(day)
		local rewardType = WelfareSigninConfig.instance:getSevenSignInRewardTye(formula, day)
		local data = {
			day = day,
			rewardType = rewardType,
			itemId = itemId,
			itemCount = itemCount,
			isReceived = isReceived,
			canReceive = canReceive,
			activityId = actId
		}

		shower:setData(data)
	end

	self:updateEndTime(WelfareSigninUtil.getSignInActRemainTime(actId))
	self:_updateLineGroup()
end

function M:_updateLineGroup()
	for day = 1, kDayCount do
		local canReceive = self:_isCanReceive(day)
		local isReceived = WelfareSigninModel.instance:isReceived(self._activityId, day)
		local item = self._signLineItems[day]

		goutil.setActive(item.point1, not canReceive)
		goutil.setActive(item.point2, canReceive)

		item.canvas.alpha = (canReceive or isReceived) and 0.8 or 0.2
	end
end

function M:_isCanReceive(day)
	return WelfareSigninModel.instance:isCanReceive(self._activityId, day)
end

function M:updateEndTime(day, hour, minute, second)
	local timeStr

	if day == 0 then
		if hour > 0 then
			hour = (minute > 0 or second > 0) and hour + 1 or hour
			timeStr = string.format(lang("tip_left_xx_hour"), hour)
		else
			minute = minute <= 1 and 1 or second > 0 and minute + 1 or minute
			timeStr = string.format(lang("tip_left_xx_min"), minute)
		end
	else
		day = (hour > 0 or minute > 0) and day + 1 or day
		timeStr = string.format(lang("tip_left_xx_day"), day)
	end

	if day > kRemainMaxDay then
		timeStr = lang("tip_daily_refresh_hint")
	end

	self._txtTime.text = timeStr

	local timeRoot = self._txtTime.transform.parent.gameObject

	goutil.setActive(timeRoot, true)
end

function M:fakeUnBindEvent()
	if self._btnFakeSign then
		self._btnFakeSign:RemoveClickListener()
	end
end

function M:fakeDestroyUI()
	self._btnFakeSign = nil
end

function M:_fakeBtnForTest()
	if not Astral.OSDef.isEditor then
		return
	end

	self._btnFakeSign = goutil.findChild(self.mainGO, "fakeBtnSign")

	if self._btnFakeSign == nil then
		self._btnFakeSign = goutil.create("fakeBtnSign", true)

		local tempRect = self._btnFakeSign:GetComponent(goutil.Type_RectTransform)

		goutil.setHeight(tempRect, 50)
		goutil.addChildToParent(self._btnFakeSign, self.mainGO)
		Astral.TransformUtil.SetLocalPos(self._btnFakeSign.transform, -100, 350, 0)
		self._btnFakeSign.transform:SetAsLastSibling()

		local image = self._btnFakeSign:AddComponent(goutil.Type_UIImage)

		image.raycastTarget = true
	end

	self._btnFakeSign = UIComponentType.ButtonAdapter(self._btnFakeSign)

	self._btnFakeSign:AddClickListener(self._fakeOnClickSign, self)
end

function M:_fakeOnClickSign()
	local signInMo = self:_getSignInData()

	if signInMo then
		WelfareSigninUtil.fakeSignIn(signInMo:getActivity())
	end
end

return M
