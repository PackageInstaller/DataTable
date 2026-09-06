-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagHelpCardUseView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagHelpCardUseView", package.seeall)

local BuddyLuckyBagHelpCardUseView = class("BuddyLuckyBagHelpCardUseView", ViewComponent)

function BuddyLuckyBagHelpCardUseView:buildUI()
	BuddyLuckyBagHelpCardUseView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnRefresh = self:getGo("btnRefresh")
	self._txtTitle = self:getTxt("txtTitle/txt")
	self._txtCardCount = self:getTxt("txtCardCount")
	self._inputComp = self:getInput("InputField")
	self._emptyBag = self:getGo("bagCol/empty")

	local bagScrView = self:getGo("bagCol/scrView")
	local bagScrCell = self:getGo("bagCol/scrCell")

	self._bagScrollerList = ScrollerList.create(bagScrView, bagScrCell, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))
end

function BuddyLuckyBagHelpCardUseView:bindEvents()
	BuddyLuckyBagHelpCardUseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
end

function BuddyLuckyBagHelpCardUseView:unbindEvents()
	BuddyLuckyBagHelpCardUseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnRefresh)
	self._inputComp:RemoveOnValueChanged()
end

function BuddyLuckyBagHelpCardUseView:onEnter()
	BuddyLuckyBagHelpCardUseView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._oldBagInfo = {}
	self._oldBagInfo.buddyId = "0"
	self._oldBagInfo.bagId = checknumber(params[2])
	self._oldBagInfo.prizeId = checknumber(params[3])
	self._newBagInfo = {}
	self._newBagInfo.buddyId = "0"
	self._newBagInfo.bagId = 0
	self._newBagInfo.prizeId = 0
	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)
	self._isTimerRefresh = false
	self._friendNameDic = {}

	local buddiesMos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	for k, v in ipairs(buddiesMos) do
		local headInfo = v.headInfo

		self._friendNameDic[headInfo.userName] = headInfo.userId
	end

	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagBuddyBagsRes, self._handlePM_BuddyLuckyBagBuddyBagsRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGainLuckRes, self._handlePM_BuddyLuckyBagGainLuckRes, self)

	local buddyBags = self._subMo:getBuddyBags()

	if #buddyBags <= 0 then
		BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagBuddyBagsReq(self._activityId, {})
	end

	self:_onUpdate()
end

function BuddyLuckyBagHelpCardUseView:onExit()
	BuddyLuckyBagHelpCardUseView.super.onExit(self)
	removetimer(self._onTimerToRefresh, self)
	self:_stopTimerToGetFriendBags()
	self:_onClearBagColUI()
end

function BuddyLuckyBagHelpCardUseView:_handlePM_BuddyLuckyBagBuddyBagsRes()
	self._newBagInfo.buddyId = "0"
	self._newBagInfo.bagId = 0
	self._newBagInfo.prizeId = 0

	self:_onUpdate()
end

function BuddyLuckyBagHelpCardUseView:_handlePM_BuddyLuckyBagGainLuckRes()
	self:close()
end

function BuddyLuckyBagHelpCardUseView:_inputValueChanged(text)
	local subStr = string.sub(text, 1, 550)

	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = subStr

	self._inputComp:SetText(subStr)

	self._tickingTime = 0

	if not self._isTimer then
		self._isTimer = true

		settimer(0.1, self._onTimerToGetFriendBags, self, true)
	end
end

function BuddyLuckyBagHelpCardUseView:_stopTimerToGetFriendBags()
	self._tickingTime = 0
	self._isTimer = false

	removetimer(self._onTimerToGetFriendBags, self)
end

function BuddyLuckyBagHelpCardUseView:_onTimerToGetFriendBags()
	self._tickingTime = self._tickingTime + 0.1

	if self._tickingTime >= 0.5 then
		if string.nilorempty(self._lastInputTxt) then
			BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagBuddyBagsReq(self._activityId)
		else
			local userId = self._friendNameDic[self._lastInputTxt]

			if userId then
				BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagBuddyBagsReq(self._activityId, {
					userId
				})
			else
				BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagBuddyBagsReq(self._activityId, {
					self._lastInputTxt
				})
			end
		end

		self:_stopTimerToGetFriendBags()
	end
end

function BuddyLuckyBagHelpCardUseView:_onUpdate()
	self:_onUpdateTipsUI()
	self:_onUpdateBagColUI()
	self:_onUpdateBtnSureUI()
	self:_onUpdateBtnRefreshUI()
end

function BuddyLuckyBagHelpCardUseView:_onUpdateBtnSureUI()
	local buddyId = checknumber(self._newBagInfo.buddyId)
	local bagId = checknumber(self._newBagInfo.bagId)
	local prizeId = checknumber(self._newBagInfo.prizeId)
	local isHasSelect = buddyId > 0 and bagId > 0 and prizeId > 0

	GameUtil.SetGray(self._btnSure, not isHasSelect)
end

function BuddyLuckyBagHelpCardUseView:_onUpdateTipsUI()
	local curCardCount = self._subMo:getCardCount()
	local maxCardCount = self._subMo:getMaxCardCount()

	self._txtCardCount.text = curCardCount
end

function BuddyLuckyBagHelpCardUseView:_onUpdateBagColUI()
	self._buddyBags = self._subMo:getBuddyBags()
	self._bagInfoList = {}

	for _, v in ipairs(self._buddyBags) do
		for _, vv in ipairs(v.bagList) do
			if self._oldBagInfo.bagId == vv.bagId and self._oldBagInfo.prizeId ~= vv.prizeId then
				local info = {}

				info.headInfo = v.headInfo
				info.buddyId = v.headInfo.userId
				info.bagId = vv.bagId
				info.prizeId = vv.prizeId

				table.insert(self._bagInfoList, info)

				break
			end
		end
	end

	self._bagScrollerList:reloadData(self._bagInfoList)
	GameUtil.SetActive(self._emptyBag, #self._bagInfoList <= 0)
end

function BuddyLuckyBagHelpCardUseView:_onClearBagColUI()
	self._bagScrollerList:dispose()
end

function BuddyLuckyBagHelpCardUseView:_updateBagCell(view, cell, info, tag)
	local headInfo = info.headInfo
	local buddyId = info.buddyId
	local bagId = info.bagId
	local prizeId = info.prizeId
	local bagData = BuddyLuckyBagConfig.instance:getBagData(self._activityId, bagId)
	local poolId = bagData.poolId
	local data = BuddyLuckyBagConfig.instance:getPoolPrizeData(poolId, prizeId)
	local isSelected = self._newBagInfo.buddyId == buddyId and self._newBagInfo.bagId == bagId and self._newBagInfo.prizeId == prizeId
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local btnGo = goutil.findChild(mainGo, "btn")
	local icon = goutil.findChild(mainGo, "btn/mask/icon")
	local tagSelected = goutil.findChild(mainGo, "btn/tagSelected")

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	txtName.text = headInfo.userName

	MaterialMgr.setIcon(icon, matType, matId, nil, nil)
	GameUtil.SetActive(tagSelected, isSelected)
	GameUtil.addClickHandler(icon, function()
		CommonTipsMgr.instance:openMaterialTips(icon, matType, matId, matNum)
	end, self)
	GameUtil.addClickHandler(btnGo, function()
		if isSelected then
			self._newBagInfo.buddyId = "0"
			self._newBagInfo.bagId = 0
			self._newBagInfo.prizeId = 0
		else
			local oldBuddyId = checknumber(self._newBagInfo.buddyId)

			self._newBagInfo.buddyId = info.buddyId
			self._newBagInfo.bagId = info.bagId
			self._newBagInfo.prizeId = info.prizeId
		end

		self._bagScrollerList:refresh()
		self:_onUpdateBtnSureUI()
	end, self)
end

function BuddyLuckyBagHelpCardUseView:_clearBagCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local icon = goutil.findChild(mainGo, "btn/mask/icon")
	local btnGo = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btnGo)
	GameUtil.rmClickHandler(icon)
	MaterialMgr.clearIcon(icon)
	HeadItemController.instance:resetHeadCell(headRoot)
end

function BuddyLuckyBagHelpCardUseView:_onUpdateBtnRefreshUI()
	GameUtil.SetGray(self._btnRefresh, self._isTimerRefresh)
end

function BuddyLuckyBagHelpCardUseView:_onTickingTimerRefresh()
	self._tickingTimeRefresh = self._tickingTimeRefresh + 1

	if self._tickingTimeRefresh >= 3 then
		self._isTimerRefresh = false

		removetimer(self._onTickingTimerRefresh, self)
		self:_onUpdateBtnRefreshUI()
	end
end

function BuddyLuckyBagHelpCardUseView:_onClickBtnRefresh()
	if self._isTimerRefresh then
		FloatWordMgr.instance:show("刷新中，请稍后再试")

		return
	end

	BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagBuddyBagsReq(self._activityId, {})

	if not self._isTimerRefresh then
		self._isTimerRefresh = true
		self._tickingTimeRefresh = 0

		settimer(1, self._onTickingTimerRefresh, self, true)
	end
end

function BuddyLuckyBagHelpCardUseView:_onClickBtnSure()
	local buddyId = checknumber(self._newBagInfo.buddyId)
	local bagId = checknumber(self._newBagInfo.bagId)
	local prizeId = checknumber(self._newBagInfo.prizeId)
	local isHasSelect = buddyId > 0 and bagId > 0 and prizeId > 0

	if not isHasSelect then
		FloatWordMgr.instance:show("未选择福袋")

		return
	end

	local cardCount = self._subMo:getCardCount()

	if cardCount <= 0 then
		FloatWordMgr.instance:show("剩余沾福卡不足")

		return
	end

	local oldBagInfo = {}

	oldBagInfo.buddyId = self._oldBagInfo.buddyId
	oldBagInfo.bagId = self._oldBagInfo.bagId
	oldBagInfo.prizeId = self._oldBagInfo.prizeId

	local newBagInfo = {}

	newBagInfo.buddyId = buddyId
	newBagInfo.bagId = bagId
	newBagInfo.prizeId = prizeId

	UIStateManager.instance:push(ViewName.BuddyLuckyBagHelpCardSureView, self._activityId, oldBagInfo, newBagInfo)
end

return BuddyLuckyBagHelpCardUseView
