-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimePanel.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimePanel", package.seeall)

local M = class("AirtightRoomTimePanel")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._btnDetail = UIComponentType.ButtonAdapter(registry:findUIElement("secret_time_panel_1217622527"))
	self._animTimeRoot = registry:findUIElement("secret_time_panel_1217622527", ComponentType.Animation)
	self._rectTrTimeRoot = registry:findUIElement("secret_time_panel_1217622527", UIComponentType.RectTransform)
	self._animTimeLost = registry:findUIElement("secret_time_panel_-1701773785", ComponentType.Animation)
	self._animTimeLostListener = Astral.AnimationEventListener.Get(self._animTimeLost.gameObject)
	self._goTimeRootLost = registry:findUIElement("secret_time_panel_-1701773785")
	self._goTimeRootNormal = registry:findUIElement("secret_time_panel_-163190000")
	self._rectTrTimeRootNormal = self._goTimeRootNormal:GetComponent(UIComponentType.RectTransform)
	self._canvasGroupTimeRootNormal = self._goTimeRootNormal:GetComponent(ComponentType.CanvasGroup)
	self._txtTimeNormal = registry:findUIElement("secret_time_panel_976926256", UIComponentType.Text)
	self._goTimeRootAirtight = registry:findUIElement("secret_time_panel_-1892950473")
	self._txtTimeAirtight = registry:findUIElement("secret_time_panel_-1525818514", UIComponentType.Text)
	self._goInfoNormal = registry:findUIElement("secret_time_panel_-502491431")
	self._txtInfoNormal = registry:findUIElement("secret_time_panel_1126724946", UIComponentType.Text)
	self._goInfoAirtight = registry:findUIElement("secret_time_panel_-608135415")
	self._txtInfoAirtight = registry:findUIElement("secret_time_panel_-849474893", UIComponentType.Text)
	self._btnGoSecret = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGoSecret"))
	self._btnGoInstance = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGoInstance"))
end

function M:destroyUI()
	self:setHandler(nil)
	self:_setEvent(false)

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end

	self._btnDetail = nil
	self._animTimeRoot = nil
	self._animTimeLost = nil
	self._animTimeLostListener = nil
	self._goTimeRootLost = nil
	self._goTimeRootNormal = nil
	self._txtTimeNormal = nil
	self._goTimeRootAirtight = nil
	self._txtTimeAirtight = nil
	self._goInfoNormal = nil
	self._txtInfoNormal = nil
	self._goInfoAirtight = nil
	self._txtInfoAirtight = nil
end

function M:bindEvents()
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._btnGoSecret:AddClickListener(self._onClickBtnGoSecret, self)
	self._btnGoInstance:AddClickListener(self._onClickBtnGoInstance, self)
	self._animTimeLostListener:AddListener(self._onAnimEventTimeLost, self)
end

function M:unbindEvents()
	self._btnDetail:RemoveClickListener()
	self._btnGoSecret:RemoveClickListener()
	self._btnGoInstance:RemoveClickListener()
	self._animTimeLostListener:RemoveListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getRegistry()
	return self._registry
end

function M:getMainGo()
	return self.mainGO
end

function M:setActive(active)
	goutil.setActive(self:getMainGo(), active)
end

function M:setBtnGoSecretVisible(visible)
	goutil.setActive(self._btnGoSecret.gameObject, visible)
end

function M:setBtnGoInstanceVisible(visible)
	goutil.setActive(self._btnGoInstance.gameObject, visible)
end

function M:onEnter()
	self._playingTimeLostXS = 0
	self._cacheAirtightStatus = nil

	Astral.GeometryUtil.SetAnchorPosY(self._rectTrTimeRoot, 90)
	RectTransformUtils.SetScale(self._rectTrTimeRootNormal, 1, 1, 1)

	self._canvasGroupTimeRootNormal.alpha = 1

	self:clearIsNotice()
	self:_delayHideNotice(0)
	self:_updateAirtightTime()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)

	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end

	self._isNotice = nil

	goutil.setActive(self.mainGO, false)
end

function M:_setEvent(add)
	if add then
		Scheduler.addListener(1, self._updateAirtightTime, self, true)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKWEEK, self._handleTickWeek, self)
		GlobalDispatcher:addEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
	else
		Scheduler.removeListener(self._updateAirtightTime, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKWEEK, self._handleTickWeek, self)
		GlobalDispatcher:removeEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
	end
end

function M:_handleTickWeek()
	return
end

function M:_handleAirtightExitTimeChange()
	self:_updateAirtightTime()
end

function M:_onClickDetail()
	if AirtightRoomUtil.isSystemOpen(false) then
		ToolTipsMgr.showAirtightRoomTimeShowTips()
	else
		printWarn("功能未开启，不能查看密室时间详情")
	end
end

function M:_onClickBtnGoSecret()
	self._handler:clickBtnGoSecret()
end

function M:_onClickBtnGoInstance()
	self._handler:clickBtnGoInstance()
end

function M:_updateAirtightTime()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local systemOpen = AirtightRoomUtil.isSystemOpen(false)
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime)

	if inAirtightTime then
		self._txtTimeAirtight.text = string.format("%02d:%02d:%02d", hour, minute, second)

		self:clearIsNotice()

		if self._noticeShow then
			self:_delayHideNotice(0)
		end
	else
		self._txtTimeNormal.text = string.format("%02d:%02d:%02d", hour, minute, second)

		self:checkNotice(hour, minute, second)
	end

	local showTimeLost = not systemOpen or inAirtightTime and inTimeByItem

	if showTimeLost then
		-- block empty
	end

	local showNormal = systemOpen and not inAirtightTime

	if showTimeLost then
		-- block empty
	end

	local showAirtight = systemOpen and inAirtightTime and not inTimeByItem
	local cacheState = self._cacheAirtightStatus
	local cacheInTimeByItem = self._cacheInTimeByItem

	if cacheState ~= nil then
		if cacheInTimeByItem ~= nil and cacheInTimeByItem ~= inTimeByItem then
			self._animTimeLost:Stop()
			goutil.setActive(self._goTimeRootLost, true)

			if showTimeLost then
				self._animTimeLost:Play("time_lost_cx")
			else
				self._animTimeLost:Play("time_lost_xs")

				self._playingTimeLostXS = 2
			end
		else
			goutil.setActive(self._goTimeRootLost, showTimeLost)
		end

		if cacheState ~= inAirtightTime then
			GlobalDispatcher:dispatchEvent(EventType.ON_ARITIGHT_STATE_CHANGE, inAirtightTime, airtightEndTS)

			if self._playingTimeLostXS <= 0 then
				self:_playTimeRootAni(showAirtight, showNormal)
			end
		elseif self._playingTimeLostXS > 0 then
			self._playingTimeLostXS = self._playingTimeLostXS - 1

			if self._playingTimeLostXS <= 0 then
				self._playingTimeLostXS = 0

				RectTransformUtils.SetScale(self._rectTrTimeRootNormal, 1, 1, 1)

				self._canvasGroupTimeRootNormal.alpha = 1

				goutil.setActive(self._goTimeRootNormal, showNormal)
				goutil.setActive(self._goTimeRootAirtight, showAirtight)
				self._animTimeRoot:Play("jishiban_cx")
			end
		else
			goutil.setActive(self._goTimeRootNormal, showNormal)
			goutil.setActive(self._goTimeRootAirtight, showAirtight)
		end
	else
		goutil.setActive(self._goTimeRootNormal, showNormal)
		goutil.setActive(self._goTimeRootAirtight, showAirtight)
		goutil.setActive(self._goTimeRootLost, showTimeLost)
		self._animTimeRoot:Stop()

		if showNormal then
			self._animTimeRoot:Play("jishiban_cx")
		elseif showAirtight then
			self._animTimeRoot:Play("jishiban_qiehuan")
			Astral.GeometryUtil.SetAnchorPosY(self._rectTrTimeRoot, 0)
		elseif showTimeLost then
			self._animTimeLost:Play("time_lost_cx")
			Astral.GeometryUtil.SetAnchorPosY(self._rectTrTimeRoot, 0)
		end
	end

	self._cacheAirtightStatus = inAirtightTime
	self._cacheInTimeByItem = inTimeByItem ~= nil and inTimeByItem or false
end

function M:_playTimeRootAni(showAirtight, showNormal)
	self._animTimeRoot:Stop()

	if showAirtight then
		self._animTimeRoot:Play("jishiban_qiehuan")
		goutil.setActive(self._goTimeRootNormal, true)
		goutil.setActive(self._goTimeRootAirtight, true)
	elseif showNormal then
		RectTransformUtils.SetScale(self._rectTrTimeRootNormal, 1, 1, 1)

		self._canvasGroupTimeRootNormal.alpha = 1

		goutil.setActive(self._goTimeRootNormal, showNormal)
		goutil.setActive(self._goTimeRootAirtight, showAirtight)
		self._animTimeRoot:Play("jishiban_cx")
	else
		goutil.setActive(self._goTimeRootNormal, showNormal)
		goutil.setActive(self._goTimeRootAirtight, showAirtight)
	end
end

function M:_onAnimEventTimeLost(animationEvent)
	if animationEvent.stringParameter == "cx_end" and self._goTimeRootLost.activeSelf then
		self._animTimeLost:Stop()
		self._animTimeLost:Play("time_lost")
	end
end

function M:checkNotice(hour, min, sec)
	local noticeMap = AirtightRoomModel.instance:getNoticeMap()
	local index = false
	local t = hour * 60 * 60 + min * 60 + sec

	for i = #noticeMap, 1, -1 do
		local isNotice = self:getIsNotice(i)

		if not index and not isNotice and t >= noticeMap[i].time then
			index = i
		end
	end

	if index then
		local showRed = noticeMap[index].showRed
		local str = noticeMap[index].content

		for i = index, 1, -1 do
			self:setIsNotice(i)
		end

		local delayHide = index == #noticeMap and 1 or nil

		self:_showNotice(true, str, delayHide, showRed)
	end
end

function M:_showNotice(show, content, delayHide, showRed)
	if show then
		self:_changeNotice(content, showRed)
	end

	self:_delayHideNotice(delayHide)
end

function M:_delayHideNotice(delayHide)
	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end

	if delayHide then
		if delayHide > 0 then
			self._delayTween = DoTweenUtil.DelayedCall(delayHide, function()
				goutil.setActive(self._goInfoNormal, false)
				goutil.setActive(self._goInfoAirtight, false)

				self._noticeShow = false
			end)
		else
			goutil.setActive(self._goInfoNormal, false)
			goutil.setActive(self._goInfoAirtight, false)

			self._noticeShow = false
		end
	end
end

function M:_changeNotice(content, showRed)
	local txtComp = showRed and self._txtInfoAirtight or self._txtInfoNormal

	txtComp.text = content

	goutil.setActive(self._goInfoNormal, not showRed)
	goutil.setActive(self._goInfoAirtight, showRed)

	self._noticeShow = true
end

function M:setIsNotice(index)
	self._isNotice[index] = 1
end

function M:getIsNotice(index)
	return self._isNotice[index] ~= nil
end

function M:clearIsNotice()
	self._isNotice = {}
end

return M
