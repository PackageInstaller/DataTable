-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/view/MailView.lua

module("logic.extensions.mail.view.MailView", package.seeall)

local M = class("MailView", ViewComponent)
local longClickTriggerTime = 0.5
local kSkipUnlockTime = 1
local kRightUnlockAniTime = 2
local rightViewType = {
	Detail = 2,
	Unlock = 3,
	None = 1
}
local leftTabPanelHeight = {
	CurMail = 478,
	HistoryMail = 538
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._togCurMail = self:getUIComponent("mailbox_view_-52572757", UIComponentType.SpaceXToggle)
	self._togHistoryMail = self:getUIComponent("mailbox_view_-1598569025", UIComponentType.SpaceXToggle)
	self._labCurMailNum = self:getText("mailbox_view_-1326866193")
	self._btnDeleteAll = self:getBtn("6&com_btn_2_-31477526")
	self._btnReceiveAll = self:getBtn("7&btn_middle_-31477526")
	self._surveyGo1 = self:getGo("mailbox_view_1209178421")
	self._btnGoToSurvey1 = self:getBtn("mailbox_view_2011875016")
	self._leftBottomGo = self:getGo("mailbox_view_-110676405")
	self._viewPort = self:getUIComponent("mailbox_view_-1052636116", UIComponentType.RectTransform)
	self._mailScroll = self:getUIComponent("mailbox_view_-1128369669", UIComponentType.RectTransform)
	self._mailScrollComp = self:getUIComponent("mailbox_view_-1128369669", UIComponentType.ScrollRect)
	self._loopListHelper = LoopListHelper.New(self._mailScroll.gameObject)

	self._loopListHelper:InitListView(0, self._updateMailData, self)

	self._leftEmptyGo = self:getGo("mailbox_view_-1339826556")
	self._rightEmptyGo = self:getGo("mailbox_view_-34421330")
	self._noNewEmailGo = self:getGo("mailbox_view_613711110")
	self._noHistoryMailGo = self:getGo("mailbox_view_1230609903")
	self._mailDetailPanel = self:getGo("mailbox_view_-682561369")
	self._canvasGroupDetailPanel = self:getUIComponent("mailbox_view_-682561369", ComponentType.CanvasGroup)
	self._mailUnlockPanel = self:getGo("mailbox_view_-265273019")
	self._labSender = self:getUIComponent("mailbox_view_-1780459307", UIComponentType.TextMeshProUGUI)
	self._labPlace = self:getUIComponent("mailbox_view_-1034191632", UIComponentType.TextMeshProUGUI)
	self._labSendTime = self:getText("mailbox_view_-1069536814")
	self._labValidTime = self:getText("mailbox_view_-887725611")
	self._labTitle = self:getUIComponent("mailbox_view_-899490708", UIComponentType.TextMeshProUGUI)
	self._labComDesc1 = self:getUIComponent("mailbox_view_-830263373", UIComponentType.TextMeshProUGUI)
	self._labComDesc2 = self:getUIComponent("mailbox_view_-478289289", UIComponentType.TextMeshProUGUI)
	self._commonDescGo1 = self:getGo("mailbox_view_-1301549128")
	self._commonDescGo2 = self:getGo("mailbox_view_-447129104")
	self._scrollRect1 = self:getUIComponent("mailbox_view_-1301549128", UIComponentType.ScrollRect)
	self._scrollRect2 = self:getUIComponent("mailbox_view_-447129104", UIComponentType.ScrollRect)
	self._rewardGo = self:getGo("mailbox_view_-882542745")
	self._rewardScrollGo = self:getGo("mailbox_view_-372707697")
	self._rewardLoopList = LoopListHelper.New(self._rewardScrollGo)

	self._rewardLoopList:InitListView(0, self._updateRewardData, self)

	self._rewardScrollComp = self:getUIComponent("mailbox_view_-372707697", UIComponentType.ScrollRect)
	self._commonGo = self:getGo("mailbox_view_-959191369")
	self._overdueGo = self:getGo("mailbox_view_-32624552")
	self._doneGo = self:getGo("mailbox_view_-788084969")
	self._btnReceiveGo = self:getGo("mailbox_view_-533093586")
	self._btnReceive = self:getBtn("mailbox_view_-533093586")
	self._btnUnlock = self:getBtn("mailbox_view_-1316935697")
	self._imgSecretLight = self:getGo("mailbox_view_1587748895")
	self._imgSecretNormal = self:getGo("mailbox_view_copy_-964558782")
	self._guiAnimationRight = goutil.addComponentOnce(self:getGo("mailbox_view_-529214102"), typeof(Astral.GUITimelineAniLua))
	self._animLeftPanel = self:getUIComponent("mailbox_view_-43442005", ComponentType.Animation)
	self._txtSecretUnlock = self:getText("mailbox_view_1967156171")
	self._goSecretBg = self:getGo("mailbox_view_copy_1149084721")
end

function M:destroyUI()
	self._togCurMail = nil
	self._togHistoryMail = nil
	self._labCurMailNum = nil
	self._btnDeleteAll = nil
	self._btnReceiveAll = nil
	self._btnGoToSurvey1 = nil
	self._mailScroll = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
	self._leftEmptyGo = nil
	self._rightEmptyGo = nil
	self._mailDetailPanel = nil
	self._mailUnlockPanel = nil
	self._labSender = nil
	self._labPlace = nil
	self._labSendTime = nil
	self._labValidTime = nil
	self._labTitle = nil
	self._labComDesc1 = nil
	self._rewardGo = nil
	self._rewardScrollGo = nil

	self._rewardLoopList:Dispose()

	self._rewardLoopList = nil
	self._overdueGo = nil
	self._doneGo = nil
	self._btnReceiveGo = nil
	self._btnReceive = nil
	self._btnUnlock = nil
	self._leftBottomGo = nil
	self._viewPort = nil
	self._noNewEmailGo = nil
	self._noHistoryMailGo = nil
	self._goSecretBg = nil
end

function M:bindEvents()
	self._btnDeleteAll:AddClickListener(self._onClickDeleteAll, self)
	self._btnReceiveAll:AddClickListener(self._onClickReceiveAll, self)
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnGoToSurvey1:AddClickListener(self._onClickGoToSurvey, self)
	self._togCurMail:AddListener(self._onToggleViewCurMail, self)
	self._togHistoryMail:AddListener(self._onToggleViewHistoryMail, self)
	self._btnUnlock:AddClickListener(self._onUnlockBtnClick, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_CUR_MAIL, self._onRefreshCurMail, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_HISTORY_MAIL, self._onRefreshHistoryMail, self)
	GlobalDispatcher:addEventListener(EventType.UNLOCK_SECRET_MAIL, self._onUnlockSecretyMail, self)
	GlobalDispatcher:addEventListener(EventType.TAKE_MAIL_ATTACHMENT, self._onTakeMailAttachmentMail, self)
	GlobalDispatcher:addEventListener(EventType.TAKE_ALL_MAIL_ATTACHMENT, self._onTakeAllMailAttachmentMail, self)
	GlobalDispatcher:addEventListener(EventType.REMOVE_ALL_READ_MAIL, self._onRemoveAllReadMail, self)
	GlobalDispatcher:addEventListener(EventType.UPDAET_READ_MAIL, self._onUpdateReadMail, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:unbindEvents()
	self._btnDeleteAll:RemoveClickListener()
	self._btnReceiveAll:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnGoToSurvey1:RemoveClickListener()
	self._togCurMail:RemoveListener()
	self._togHistoryMail:RemoveListener()
	self._btnUnlock:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_CUR_MAIL, self._onRefreshCurMail, self)
	GlobalDispatcher:removeEventListener(EventType.REFRESH_HISTORY_MAIL, self._onRefreshHistoryMail, self)
	GlobalDispatcher:removeEventListener(EventType.TAKE_MAIL_ATTACHMENT, self._onTakeMailAttachmentMail, self)
	GlobalDispatcher:removeEventListener(EventType.UNLOCK_SECRET_MAIL, self._onUnlockSecretyMail, self)
	GlobalDispatcher:removeEventListener(EventType.TAKE_ALL_MAIL_ATTACHMENT, self._onTakeAllMailAttachmentMail, self)
	GlobalDispatcher:removeEventListener(EventType.REMOVE_ALL_READ_MAIL, self._onRemoveAllReadMail, self)
	GlobalDispatcher:removeEventListener(EventType.UPDAET_READ_MAIL, self._onUpdateReadMail, self)
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName ~= "open" and tagName ~= "close" then
		self._playingGuiAnimName = nil
	end
end

function M:_dealAnimEvent(animationEvent)
	local strParam = animationEvent.stringParameter

	if strParam == "unlock" and self._curSelectMail then
		self:_setAnimRightSpeed(1)

		self._unlockingMailId = self._curSelectMail:getId()

		printWarn("-----邮件解锁成功--------", self._curSelectMail:getId())
		MailAgent.instance:sendUnlockSecretMailRequest(self._curSelectMail:getId())
	end
end

function M:onEnter()
	MainUIModel.instance:setShowMailTips(false)
	MainScenePerformUtil.setBgHeroShow(false, true, true)

	self._itemCell = {}
	self._rewarditemCell = {}
	self._guiAnimation = self._viewPresentor:getGuiAnimation()
	self._playingGuiAnimName = nil
	self._curSelectMail = false
	self._togCurMail.IsOn = true
	self._togHistoryMail.IsOn = false

	self:setRightPanelActive(rightViewType.None)

	self._txtSecretUnlock.text = lang("tip_mail_secret")

	goutil.setActive(self._leftBottomGo, true)
	MailAgent.instance:sendGetMailInfoRequest()
	self:_showDetailInfo(false)

	self._showFullTips = false
	self._isInEntering = true
end

function M:onEnterFinished()
	self._isInEntering = false
end

function M:onExit()
	self._isInEntering = false

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	self:_playMailEnterAnim(false)
	self:_playMailRewardEnterAnim(false)

	for _, shower in pairs(self._itemCell or {}) do
		shower:StopAni()
	end

	for _, shower in pairs(self._rewarditemCell or {}) do
		shower:StopAni()
	end

	self:playAnimation("close", true)

	self._needPlayItemCellOpenAni = false
	self._needPlayRewardItemCellOpenAni = false
	self._isInUnlockAni = false

	removetimer(self._onUnlockAniFinish, self)
	removetimer(self._delayUnlockSecretyMail, self)
end

function M:onExitFinished()
	self._itemCell = nil
	self._rewarditemCell = nil

	MailMoList.instance:reset()

	self._curSelectMail = false
	self._curRewardList = false
	self._showFullTips = false
end

function M:_onClickDetail()
	local showNormalBg = true

	if self._curSelectMail then
		local isSecret = self._curSelectMail:getIsSecret()

		showNormalBg = not isSecret
	end

	local tips = lang("tip_mail_delecthistory")

	ViewMgr.instance:open(ViewName.TopHintTipsView, tips, showNormalBg)
end

function M:_onClickDeleteAll()
	MailAgent.instance:sendRemoveAllReadMailRequest()
end

function M:_onClickReceiveAll()
	local hasReward, hadUnlockSecret = MailMoList.instance:getCanGetReward()

	if not hasReward then
		if hadUnlockSecret then
			FloatWordMgr.instance:show(lang("tip_no_gain"))
		else
			FloatWordMgr.instance:show(lang("tip_all_no_gain"))
		end

		return
	end

	MailAgent.instance:sendTakeAllMailAttachmentRequest()
end

function M:_onClickReceive()
	if not self._curSelectMail then
		return
	end

	local backpackFull = false
	local list = self._curSelectMail:getRewardList()

	for i, v in pairs(list) do
		if v:getType() == GameEnum.ItemTypeEnum.EquipItemType then
			backpackFull = self:_checkBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType)
		elseif v:getType() == GameEnum.ItemTypeEnum.EchoItemType then
			backpackFull = self:_checkBackpackLimit(GameEnum.ItemTypeEnum.EchoItemType)
		end
	end

	if backpackFull then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))

		return
	elseif not MailMoList.instance:checkBackPackIsFull(self._curSelectMail:getRewardList()) then
		backpackFull = true
	end

	if self._curSelectMail then
		MailAgent.instance:sendTakeMailAttachmentRequest(self._curSelectMail:getId())

		if backpackFull then
			local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_backpack_full"))

			dialog:setConfirmButtonText(lang("tip_common_sure"))
		end
	end
end

function M:_clickMailCallBack(index, needPlayEnterAnim)
	self._curSelectIndex = index
	self._rewarditemCell = {}

	removetimer(self._onUnlockAniFinish, self)
	self:_onUnlockAniFinish()

	self._isInUnlockAni = false

	local mailList = false

	if self._togCurMail.IsOn then
		mailList = MailMoList.instance:getCurMailList()
	else
		mailList = MailMoList.instance:getHistoryMailList()
	end

	if mailList then
		self._curSelectMail = mailList[index]

		if self._curSelectMail then
			if not self._curSelectMail:getIsRead() then
				self._curSelectMail:setIsRead()

				if not self._curSelectMail:getIsSecret() then
					MailAgent.instance:sendMarkMailReadRequest(self._curSelectMail:getId())
				end
			end

			MailMoList.instance:changeSelectState(mailList, self._curSelectMail:getId())

			self._curRewardList = self._curSelectMail:getRewardList()

			self._loopListHelper:RefreshAllShownItem()

			if self._curSelectMail:getIsSecret() and not self._curSelectMail:getUnlockState() then
				self:setRightPanelActive(rightViewType.Unlock)
				self._guiAnimationRight:StopTimelineAni()
				self._guiAnimationRight:PlayAniByName("open02")
				goutil.setActive(self._rewardGo, true)
				self:_showDetailInfo(self._curSelectMail)

				return
			end
		end
	end

	goutil.setActive(self._rewardGo, true)
	self:setRightPanelActive(rightViewType.Detail)
	self._guiAnimationRight:StopTimelineAni()

	if needPlayEnterAnim then
		self:playAnimation("right_cutover", true)
	end

	self:_showDetailInfo(self._curSelectMail)
end

function M:_onToggleViewCurMail(toggle, isOn)
	if isOn then
		goutil.setActive(self._leftBottomGo, true)
		self._loopListHelper:GetLoopListView():ResetListView(true)
		self:_onRefreshCurMail(nil, true)
	end
end

function M:_onToggleViewHistoryMail(toggle, isOn)
	if isOn then
		self._loopListHelper:GetLoopListView():ResetListView(true)
		goutil.setActive(self._leftBottomGo, false)
		MailAgent.instance:sendGetHistoryMailInfoRequest()
	end
end

function M:_onUnlockBtnClick()
	if self._isInUnlockAni then
		return
	end

	self:_setAnimRightSpeed(1)
	self._guiAnimationRight:StopTimelineAni()
	self._guiAnimationRight:PlayAniByName("open")
	goutil.setActive(self._rewardGo, false)

	self._txtSecretUnlock.text = lang("tip_mail_secret_unlocking")
	self._isInUnlockAni = true
	self._curUnlockAniTime = os.clock()

	settimer(kRightUnlockAniTime, self._onUnlockAniFinish, self, false)
	self:_delayUnlockSecretyMail()
end

function M:_onUnlockAniFinish()
	self._txtSecretUnlock.text = lang("tip_mail_secret")
	self._isInUnlockAni = false
end

function M:_delayUnlockSecretyMail()
	goutil.setActive(self._mailDetailPanel, true)
	self:_showDetailInfo(self._curSelectMail)
	self:_onUnlockSecretyMail()

	if self._curSelectMail then
		self:_setAnimRightSpeed(1)

		self._unlockingMailId = self._curSelectMail:getId()

		printWarn("-----邮件解锁成功--------", self._curSelectMail:getId())
		MailAgent.instance:sendUnlockSecretMailRequest(self._curSelectMail:getId())
	end
end

function M:_onRefreshCurMail(evt, needPlayEnterAnim)
	if not self._togCurMail.IsOn then
		return
	end

	self._loopListHelper:ClearCells()

	local mailist = MailMoList.instance:getCurMailList()
	local len = mailist and #mailist or 0

	goutil.setActive(self._leftEmptyGo, len <= 0)
	goutil.setActive(self._mailScroll.gameObject, len > 0)

	if len > 0 then
		self._mailScrollComp.enabled = false
		self._needPlayItemCellOpenAni = true

		self._loopListHelper:SetListItemCount(len, true)
		self:_clickMailCallBack(1, needPlayEnterAnim)
		self:_playMailEnterAnim(true)
	else
		self:setRightPanelActive(rightViewType.None)
	end

	self:_showTopCountInfo()

	if len >= 80 and len <= 100 and not self._showFullTips then
		self._showFullTips = true

		FloatWordMgr.instance:show(lang("t_mail_reach_max"))
	end

	if not self._isInEntering then
		self._animLeftPanel:Play("mailbox_view_panel02")
	end
end

function M:_onRefreshHistoryMail()
	if not self._togHistoryMail.IsOn then
		return
	end

	local len = #MailMoList.instance:getHistoryMailList()

	goutil.setActive(self._leftEmptyGo, len <= 0)
	goutil.setActive(self._mailScroll.gameObject, len > 0)

	if len > 0 then
		self._mailScrollComp.enabled = false
		self._needPlayItemCellOpenAni = true

		self._loopListHelper:SetListItemCount(len, true)
		self:_clickMailCallBack(1, true)
		self:setRightPanelActive(rightViewType.Detail)
		self:_playMailEnterAnim(true)
	else
		self:setRightPanelActive(rightViewType.None)
	end

	self:_showTopCountInfo()

	if not self._isInEntering then
		self._animLeftPanel:Play("mailbox_view_panel01")
	end
end

function M:_onTakeMailAttachmentMail()
	if not self._curSelectMail then
		return
	end

	self._curSelectMail:setGetReward()

	local len = #MailMoList.instance:getCurMailList()

	self._loopListHelper:SetListItemCount(len, false)
	self._loopListHelper:RefreshAllShownItem()
	self:_showDetailInfo(self._curSelectMail)
end

function M:_onRemoveAllReadMail()
	local len = #MailMoList.instance:getCurMailList()

	self._loopListHelper:SetListItemCount(len, false)
	self._loopListHelper:RefreshAllShownItem()
	self._loopListHelper:MoveToItemIndex(0)
	self:_showTopCountInfo()

	local needPlayEnterAnim = true

	if self._curSelectMail and self._curSelectIndex == 1 and self._curSelectMail:hasAttachment() and not self._curSelectMail:hasGetReward() then
		needPlayEnterAnim = false
	end

	self:_clickMailCallBack(1, needPlayEnterAnim)
end

function M:_onUpdateReadMail()
	local len = #MailMoList.instance:getCurMailList()

	self._loopListHelper:SetListItemCount(len, false)
	self._loopListHelper:RefreshAllShownItem()
	self:_showTopCountInfo()
end

function M:_onTakeAllMailAttachmentMail()
	local len = #MailMoList.instance:getCurMailList()

	self._loopListHelper:SetListItemCount(len, false)
	self._loopListHelper:RefreshAllShownItem()
	self:_showDetailInfo(self._curSelectMail)
	self:_showTopCountInfo()
end

function M:_onUnlockSecretyMail()
	self._unlockingMailId = nil

	self._curSelectMail:setUnlock(true)
	self._curSelectMail:setIsRead()
	self:setRightPanelActive(rightViewType.Detail)
	self:_showTopCountInfo()

	local len = #MailMoList.instance:getCurMailList()

	self._loopListHelper:SetListItemCount(len, false)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_setAnimRightSpeed(speed)
	if self._animRightSpeed == speed then
		return
	end

	self._animRightSpeed = speed
end

function M:_updateMailData(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopListHelper:NewListViewItem("mail_item")
	local mailList = false

	if self._togCurMail.IsOn then
		mailList = MailMoList.instance:getCurMailList()
	else
		mailList = MailMoList.instance:getHistoryMailList()
	end

	local mailData = mailList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, MailItem)

	shower.view = self

	shower:setCellData(mailData, curIndex)
	shower:setClickCallBack(self._clickMailCallBack, self)

	self._itemCell[item.gameObject:GetInstanceID()] = shower

	if self._needPlayItemCellOpenAni then
		shower:setDefaultState(0)
	else
		shower:setTargetState(1)
	end

	return item
end

function M:_updateRewardData(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._rewardLoopList:NewListViewItem("backpack_item")

	if self._curRewardList then
		local itemData = self._curRewardList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, MailRewardItem)

			shower:setCellData(itemData, curIndex)

			local isGetReward = self._curSelectMail:hasAttachment() and self._curSelectMail:hasGetReward()

			shower:setIsGetReward(isGetReward)

			self._rewarditemCell[item.gameObject:GetInstanceID()] = shower

			shower:StopAni()

			if self._needPlayRewardItemCellOpenAni then
				shower:setDefaultState(0)
			else
				shower:setTargetState(1)
			end
		end
	end

	return item
end

function M:_playMailEnterAnim(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		local index = 1
		local startIndex, endIndex = self._loopListHelper:GetCurShowItemIndexRange()

		for i = startIndex, endIndex do
			local isLast = i == endIndex or i >= TableUtil.getLen(self._itemCell)
			local loopItem = self._loopListHelper:GetLoopListView():GetShownItemByItemIndex(i)

			if loopItem then
				local shower = self._itemCell[loopItem.gameObject:GetInstanceID()]

				shower:StopAni()
				shower:setDefaultState(0)

				local delay = (index + 1) * 0.07
				local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
					shower:playEnterAnim()

					if isLast then
						self._needPlayItemCellOpenAni = false
						self._mailScrollComp.enabled = true
					end
				end)

				table.insert(self._cacheTweenLst, tweenDelay)

				index = index + 1
			end
		end

		for _, shower in pairs(self._itemCell or {}) do
			local showerIndex = shower:getIndex() - 1

			if showerIndex < startIndex or endIndex < showerIndex then
				shower:StopAni()
				shower:setTargetState(1)
			end
		end
	else
		for _, shower in pairs(self._itemCell or {}) do
			shower:StopAni()
			shower:setTargetState(1)
		end

		self._cacheTweenLst = nil
		self._needPlayItemCellOpenAni = false
	end
end

function M:_playMailRewardEnterAnim(play)
	if self._isInUnlockAni then
		for _, shower in pairs(self._rewarditemCell or {}) do
			shower:StopAni()
			shower:setTargetState(1)
		end

		return
	end

	for _, tweener in ipairs(self._cacheRewardTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheRewardTweenLst = {}

	if play then
		local index = 1
		local startIndex, endIndex = self._rewardLoopList:GetCurShowItemIndexRange()

		for i = startIndex, endIndex do
			local isLast = i == endIndex
			local loopItem = self._rewardLoopList:GetLoopListView():GetShownItemByItemIndex(i)

			if loopItem then
				local shower = self._rewarditemCell[loopItem.gameObject:GetInstanceID()]

				shower:StopAni()
				shower:setDefaultState(0)

				local delay = (index + 1) * 0.07
				local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
					shower:playEnterAnim()

					if isLast then
						self._needPlayRewardItemCellOpenAni = false
						self._rewardScrollComp.enabled = true
					end
				end)

				table.insert(self._cacheRewardTweenLst, tweenDelay)

				index = index + 1
			end
		end

		for _, shower in pairs(self._rewarditemCell or {}) do
			local showerIndex = shower:getIndex() - 1

			if showerIndex < startIndex or endIndex < showerIndex then
				shower:StopAni()
				shower:setTargetState(1)
			end
		end
	else
		for _, shower in pairs(self._rewarditemCell or {}) do
			shower:StopAni()
			shower:setTargetState(1)
		end

		self._cacheRewardTweenLst = nil
		self._needPlayRewardItemCellOpenAni = false
	end
end

function M:setRightPanelActive(type)
	if type == rightViewType.None then
		goutil.setActive(self._noNewEmailGo, self._togCurMail.IsOn)
		goutil.setActive(self._noHistoryMailGo, not self._togCurMail.IsOn)
	end

	if rightViewType.Detail then
		self._canvasGroupDetailPanel.alpha = 1
	end

	goutil.setActive(self._rightEmptyGo, type == rightViewType.None)
	goutil.setActive(self._mailDetailPanel, type == rightViewType.Detail)
	goutil.setActive(self._rewardGo, type == rightViewType.Detail)
	goutil.setActive(self._mailUnlockPanel, type == rightViewType.Unlock)
end

function M:playAnimation(name, stopBefor, timelineMode)
	if stopBefor then
		self._guiAnimation:StopTimelineAni()
	end

	timelineMode = timelineMode or Astral.GUITimeLineMode.TimeToStart
	self._playingGuiAnimName = name

	self._guiAnimation:PlayAniByName(name, timelineMode)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_page_change)
end

function M:refreshDetailInfo(id)
	if self._curSelectMail and id == self._curSelectMail:getId() then
		self:_showDetailInfo(self._curSelectMail)
	end
end

function M:getIsHistoryType()
	return self._togHistoryMail.IsOn
end

function M:_showDetailInfo(mailData)
	self:_playMailRewardEnterAnim(false)

	if not mailData then
		self:setRightPanelActive(rightViewType.None)

		return
	end

	self._labSender.text = langF("tip_mail_sender", StringUtil.replaceTMPBlackBlock(mailData:getName()))
	self._labPlace.text = langF("tip_mail_place", StringUtil.replaceTMPBlackBlock(mailData:getLocation()))
	self._labSendTime.text = mailData:getReceivedTimeStr()

	if self._togHistoryMail.IsOn then
		self._labValidTime.text = lang("tip_perpetual")
	else
		self._labValidTime.text = mailData:getExpiredTimeStr()
	end

	self._labTitle.text = StringUtil.replaceTMPBlackBlock(mailData:getTitle())

	if not self._isInUnlockAni then
		goutil.setActive(self._rewardGo, mailData:hasAttachment())
	end

	goutil.setActive(self._goSecretBg, mailData:hasAttachment() and mailData:getIsSecret())

	if mailData:hasAttachment() then
		goutil.setActive(self._commonDescGo1, true)
		goutil.setActive(self._commonDescGo2, false)
	else
		goutil.setActive(self._commonDescGo1, false)
		goutil.setActive(self._commonDescGo2, true)
	end

	self._labComDesc1.text = mailData:getContent()
	self._labComDesc2.text = mailData:getContent()
	self._scrollRect1.verticalNormalizedPosition = 1
	self._scrollRect2.verticalNormalizedPosition = 1

	if mailData:hasAttachment() then
		self._needPlayRewardItemCellOpenAni = true
		self._rewardScrollComp.enabled = false

		local len = #mailData:getRewardList()

		self._rewardLoopList:SetListItemCount(len, true)
		self._rewardLoopList:RefreshAllShownItem()
		self:_playMailRewardEnterAnim(true)
	else
		self._rewardLoopList:ClearCells()
	end

	goutil.setActive(self._imgSecretLight, mailData:getIsSecret())
	goutil.setActive(self._imgSecretNormal, not mailData:getIsSecret())
	goutil.setActive(self._surveyGo1, mailData:isSurveyMail())

	if mailData:hasAttachment() then
		if mailData:hasGetReward() then
			goutil.setActive(self._overdueGo, false)
			goutil.setActive(self._doneGo, true)
			goutil.setActive(self._btnReceiveGo, false)
		else
			goutil.setActive(self._doneGo, false)

			if mailData:isExpired() then
				goutil.setActive(self._overdueGo, true)
				goutil.setActive(self._btnReceiveGo, false)
			else
				goutil.setActive(self._overdueGo, false)
				goutil.setActive(self._btnReceiveGo, true)
			end
		end
	else
		goutil.setActive(self._overdueGo, mailData:isExpired())
		goutil.setActive(self._doneGo, false)
		goutil.setActive(self._btnReceiveGo, false)
	end
end

function M:_showTopCountInfo()
	local len = 0
	local max = 1

	if self._togCurMail.IsOn then
		len = #MailMoList.instance:getCurMailList()
		max = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.MailMaxCount)
	else
		len = #MailMoList.instance:getHistoryMailList()
		max = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.HistoricalMailMaxCount)
	end

	self._labCurMailNum.text = string.format("%d/%d", len, max)
end

function M:_checkBackpackLimit(type)
	local equipMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	local curEquipCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EquipItemType, 0)
	local echoMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity")
	local curEchoCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EchoItemType, 0)

	if type == GameEnum.ItemTypeEnum.EquipItemType then
		return equipMaxCount <= curEquipCount
	else
		return echoMaxCount <= curEchoCount
	end
end

function M:_onClickGoToSurvey()
	local linker = self._curSelectMail:getSurveyLinker()

	if linker then
		SurveyHtmlUtil.setSurveyData(linker)
		ViewMgr.instance:open(ViewName.SurveyView)
	else
		printWarn("=====_onClickGoToSurvey=====", self._curSelectMail:isSurveyMail(), linker)
		printError("======mail no survey url=======")
	end
end

return M
