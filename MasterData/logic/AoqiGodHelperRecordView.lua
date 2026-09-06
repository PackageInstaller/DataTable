-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodHelperRecordView.lua

module("logic.extensions.aoqigod.view.AoqiGodHelperRecordView", package.seeall)

local AoqiGodHelperRecordView = class("AoqiGodHelperRecordView", ViewComponent)

function AoqiGodHelperRecordView:ctor()
	AoqiGodHelperRecordView.super.ctor(self)
end

function AoqiGodHelperRecordView:buildUI()
	AoqiGodHelperRecordView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._emptymyHelper = goutil.findChild(self.mainGO, "myHelper/empty")
	self._myHelpCell = goutil.findChild(self.mainGO, "myHelper/helpCell")
	self._myHelpCell_clgIcon = goutil.findChild(self.mainGO, "myHelper/helpCell/clgIcon")
	self._myHelpCell_btnDetail = goutil.findChild(self.mainGO, "myHelper/helpCell/txtName/btnDetail")
	self._myHelpCell_btnCancel = goutil.findChild(self.mainGO, "myHelper/helpCell/btnCancel")
	self._myHelpCell_btnSure = goutil.findChild(self.mainGO, "myHelper/helpCell/btnSure")
	self._myHelpCell_txtName = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/txtName")
	self._myHelpCell_txtLeftTime = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/leftTime/txt")
	self._myHelpCell_txtTips = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/txtTips")
	self._myHelpCell_txtScore = self:getTxt("myHelper/helpCell/score/txt")
	self._myHelpCell_txtCharm = self:getTxt("myHelper/helpCell/charm/txt")

	local tableviewGo = self:getGo("myHelper/helpCell/prize/tableview")
	local tablecellGo = self:getGo("myHelper/helpCell/prize/tablecell")

	self._scrollerListHelp = ScrollerList.create(tableviewGo, tablecellGo, GameUtil.handler(self._updateHelpRewardCell, self), GameUtil.handler(self._clearHelpRewardCell, self))
	self._emptyPrize = goutil.findChild(self.mainGO, "record/prize/empty")
	self._txtHelpTimes = goutil.findChildTextComponent(self.mainGO, "record/helpTimes/txt")
	self._txtScore = self:getTxt("record/score/txt")
	self._txtCharm = self:getTxt("record/charm/txt")
	self._emptyRecord = goutil.findChild(self.mainGO, "record/empty")

	local recordScrView = goutil.findChild(self.mainGO, "record/scrView")
	local recordScrCell = goutil.findChild(self.mainGO, "record/scrCell")

	self._recordScrollerList = ScrollerList.create(recordScrView, recordScrCell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))

	local tableviewGo = self:getGo("record/prize/tableview")
	local tablecellGo = self:getGo("record/prize/tablecell")

	self._scrollerListRecordReward = ScrollerList.create(tableviewGo, tablecellGo, GameUtil.handler(self._updateHelpRewardCell, self), GameUtil.handler(self._clearHelpRewardCell, self))
	self._scrollList = {}
end

function AoqiGodHelperRecordView:bindEvents()
	AoqiGodHelperRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiGodHelperRecordView:unbindEvents()
	AoqiGodHelperRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiGodHelperRecordView:onEnter()
	AoqiGodHelperRecordView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)
	self._helpItem = self._aoqiGodMo:getHelper()

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodHelpRecordRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodAcceptHelpItemRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.AoqiGodItemHelpChange, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodGiveUpHelpItemRes, self._onUpdate, self)
	self:_onUpdate()
	settimer(1, self._onTicking, self, true)
	self:_onTicking()
	self:_sendInfoReq()
end

function AoqiGodHelperRecordView:onExit()
	AoqiGodHelperRecordView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearMyHelper()
	self:_onClearRecord()
	self._scrollerListHelp:dispose()
	self._scrollerListRecordReward:dispose()
end

function AoqiGodHelperRecordView:_sendInfoReq()
	AoqiGodController.instance:sendPM_AoqiGodHelpRecordReq(self._activityId)
end

function AoqiGodHelperRecordView:_onTicking()
	local nowMs = ServerTime.nowMs()
	local leftSec = self._helpItem:getLeftTimeSec(nowMs)

	self._myHelpCell_txtLeftTime.text = leftSec > 0 and AoqiGodController.instance:FormatLeftTime(leftSec) or "已过期"
end

function AoqiGodHelperRecordView:_onUpdate()
	self._recordResMsg = self._aoqiGodMo:getRecordResMsg() or {}
	self._helpTimes = self._recordResMsg.helpTimes or 0
	self._gainedHelpPrize = self._recordResMsg.gainedHelpPrize
	self._recordList = self._recordResMsg.records or {}
	self._totalScore = self._recordResMsg.totalScore or 0
	self._totalCharm = self._recordResMsg.totalCharmValue or 0

	local isHavePrize = not string.nilorempty(self._gainedHelpPrize)

	GameUtil.SetActive(self._emptyPrize, not isHavePrize)

	local rewards

	self._scrollerListRecordReward:reloadData((isHavePrize or nil) and string.split(self._gainedHelpPrize, "#"))

	self._txtHelpTimes.text = string.format("%s次", self._helpTimes)
	self._txtScore.text = self._totalScore
	self._txtCharm.text = self._totalCharm

	self:_onUpdateMyHelper()
	self:_onUpdateRecord()
end

function AoqiGodHelperRecordView:_onUpdateMyHelper()
	local helpItem = self._helpItem
	local isEmpty = helpItem:isEmpty()

	GameUtil.SetActive(self._emptymyHelper, isEmpty)
	GameUtil.SetActive(self._myHelpCell, not isEmpty)

	if not isEmpty then
		self:_onUpdateMyHelperCell(helpItem)
	else
		self:_onClearMyHelperCell()
	end
end

function AoqiGodHelperRecordView:_onClearMyHelper()
	self:_onClearMyHelperCell()
end

function AoqiGodHelperRecordView:_onUpdateMyHelperCell(helpItem)
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, helpItem:getChallengeId())
	local proxy = MaterialMgr.setCell(MatType.Pet, clgData.skinId, self._myHelpCell_clgIcon)

	self._myHelpCell_txtName.text = helpItem:getPlayerName()

	local rewards = string.split(clgData.godPrize, "#")

	self._scrollerListHelp:reloadData(rewards)

	self._myHelpCell_txtTips.text = string.format("当前%s/%s人帮打", helpItem:getHelperNum(), helpItem:getHelperLimit())
	self._myHelpCell_txtScore.text = clgData.helpAddScore
	self._myHelpCell_txtCharm.text = helpItem:getCharmValue()

	GameUtil.addClickHandler(self._myHelpCell_btnDetail, function()
		FriendController.instance:showInfoView(helpItem:getUserId(), self._myHelpCell_btnDetail)
	end)
	GameUtil.addClickHandler(self._myHelpCell_btnCancel, function()
		local result, tips = AoqiGodController.instance:getTryGiveUpHelpResultAndTips(true, self._activityId, helpItem)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		local tipsContent = "放弃挑战后进度将重置，再次接单将重新开始挑战，是否确认放弃？"

		local function okFunc()
			local targetUserId = helpItem:getUserId()
			local id = helpItem:getId()

			AoqiGodController.instance:sendPM_AoqiGodGiveUpHelpItemReq(self._activityId, targetUserId, id)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	end)
	GameUtil.addClickHandler(self._myHelpCell_btnSure, function()
		local result = AoqiGodController.instance:getTryStartHelpResultAndTips(true, self._activityId, helpItem)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		self:close()
		AoqiGodController.instance:enterChallenge(self._activityId, helpItem:getChallengeId())
	end)
end

function AoqiGodHelperRecordView:_onClearMyHelperCell()
	MaterialMgr.resetAll(self._myHelpCell_clgIcon)
	GameUtil.rmClickHandler(self._myHelpCell_btnDetail)
	GameUtil.rmClickHandler(self._myHelpCell_btnCancel)
	GameUtil.rmClickHandler(self._myHelpCell_btnSure)
end

function AoqiGodHelperRecordView:_onUpdateRecord()
	local list = {}

	table.insertto(list, self._recordList)
	table.sort(list, function(a, b)
		return a.finishTimeMilis > b.finishTimeMilis
	end)
	self._recordScrollerList:reloadData(list)
	GameUtil.SetActive(self._emptyRecord, #list <= 0)
end

function AoqiGodHelperRecordView:_onClearRecord()
	self._recordScrollerList:dispose()
end

function AoqiGodHelperRecordView:_updateRecordCell(view, cell, info, tag)
	local challengeId = info.challengeId
	local targetUserId = info.userId
	local finishTimeSec = Mathf.Floor(checknumber(info.finishTimeMilis) / 1000)
	local headInfo = info.headInfo
	local userName = string.format("S%s-%s", headInfo.areaId, headInfo.userName)
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, challengeId)
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local btnDetail = goutil.findChild(mainGo, "txtName/btnDetail")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "score/txt")
	local txtCharm = goutil.findChildTextComponent(mainGo, "charm/txt")
	local txtFinishTime = goutil.findChildTextComponent(mainGo, "txtFinishTime")
	local goTablecell = goutil.findChild(cell.gameObject, "prize/tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "prize/tableview")
	local proxy = MaterialMgr.setCell(MatType.Pet, clgData.skinId, clgIcon)

	txtName.text = userName

	local rewards = string.split(clgData.godPrize, "#")
	local scroll = self:_getScroll(goTableview, goTablecell)

	scroll:reloadData(rewards)

	local date = GameUtil.time2date(finishTimeSec)

	txtFinishTime.text = string.format("%02d.%02d.%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
	txtScore.text = clgData.helpAddScore
	txtCharm.text = checknumber(info.charmValue)

	GameUtil.addClickHandler(btnDetail, function()
		FriendController.instance:showInfoView(targetUserId, btnDetail)
	end)
end

function AoqiGodHelperRecordView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local goTableview = goutil.findChild(mainGo, "prize/tableview")

	MaterialMgr.resetAll(clgIcon)
	GameUtil.rmClickHandler(btnDetail)
	GameUtil.rmClickHandler(btnSure)

	if self._scrollList[goTableview] then
		self._scrollList[goTableview]:dispose()
	end
end

function AoqiGodHelperRecordView:_updateHelpRewardCell(view, cell, data, tag)
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local matType, matId, matNum = MaterialMgr.getMatParams(data)

	MaterialMgr.setIcon(iconGo, matType, matId)

	txt.text = matNum
end

function AoqiGodHelperRecordView:_clearHelpRewardCell(cell)
	local iconGo = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(iconGo)
end

function AoqiGodHelperRecordView:_getScroll(goView, goCell)
	local scroll = self._scrollList[goView]

	if not scroll then
		scroll = ScrollerList.create(goView, goCell, GameUtil.handler(self._updateHelpRewardCell, self), GameUtil.handler(self._clearHelpRewardCell, self))
		self._scrollList[goView] = scroll
	end

	return scroll
end

return AoqiGodHelperRecordView
