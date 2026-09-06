-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodCallerRecordView.lua

module("logic.extensions.aoqigod.view.AoqiGodCallerRecordView", package.seeall)

local AoqiGodCallerRecordView = class("AoqiGodCallerRecordView", ViewComponent)
local ItemTag_Doing = 1
local ItemTag_Finish = 2
local _publicCdTimes = {}
local PulicCd = 10

function AoqiGodCallerRecordView:ctor()
	AoqiGodCallerRecordView.super.ctor(self)
end

function AoqiGodCallerRecordView:buildUI()
	AoqiGodCallerRecordView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local scrView = goutil.findChild(self.mainGO, "scrView")
	local scrCell1 = goutil.findChild(self.mainGO, "scrCell1")
	local scrCell2 = goutil.findChild(self.mainGO, "scrCell2")
	local scrCellList = {
		scrCell1,
		scrCell2
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._itemScrollerList = ScrollerList.create(scrView, scrCellList, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._itemScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._itemScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._empty = goutil.findChild(self.mainGO, "empty")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._tipsStr = self._txtTips.text
end

function AoqiGodCallerRecordView:bindEvents()
	AoqiGodCallerRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiGodCallerRecordView:unbindEvents()
	AoqiGodCallerRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiGodCallerRecordView:onEnter()
	AoqiGodCallerRecordView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)
	self._lockTxtDic = self._lockTxtDic or {}

	table.clear(self._lockTxtDic)

	self._nowMs = ServerTime.nowMs()
	self._cellDic = {}

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodAcceptHelpItemRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.AoqiGodItemHelpChange, self._onUpdate, self)
	self:_onUpdate()
	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function AoqiGodCallerRecordView:onExit()
	AoqiGodCallerRecordView.super.onExit(self)
	removetimer(self._onTicking, self)
	self._itemScrollerList:dispose()
	table.clear(self._lockTxtDic)
end

function AoqiGodCallerRecordView:_onTicking()
	self._nowMs = ServerTime.nowMs()

	for txt, helpItem in pairs(self._lockTxtDic) do
		local leftTime = helpItem:getLeftTimeSec(self._nowMs)

		self:_updateTxtByItem(txt, leftTime)

		if leftTime <= 0 then
			self._lockTxtDic[txt] = nil
		end
	end

	local nowRealtime = UnityEngine.Time.realtimeSinceStartup

	for mainGo, cell in pairs(self._cellDic) do
		local challengeId = cell.challengeId
		local oldRealtime = checknumber(_publicCdTimes[challengeId])

		if oldRealtime > 0 then
			local leftTime = Mathf.Floor(PulicCd - (nowRealtime - oldRealtime))

			self:_updateTxtBtn(cell.txtBtnPublic, leftTime)

			if leftTime <= 0 then
				GameUtil.SetGray(cell.btnPublic, false)

				_publicCdTimes[challengeId] = nil
				self._cellDic[mainGo] = nil
			end
		end
	end

	for challengeId, oldRealtime in pairs(_publicCdTimes) do
		if oldRealtime > 0 and nowRealtime - oldRealtime > PulicCd then
			_publicCdTimes[challengeId] = nil
		end
	end
end

function AoqiGodCallerRecordView:_addTxtToItemUpdate(txt, helpItem)
	if helpItem then
		self._lockTxtDic[txt] = helpItem

		local leftTime = helpItem:getLeftTimeSec(self._nowMs)

		self:_updateTxtByItem(txt, leftTime)
	else
		self._lockTxtDic[txt] = nil
	end
end

function AoqiGodCallerRecordView:_updateTxtByItem(txt, leftSec)
	if not goutil.isNil(txt) then
		txt.text = leftSec > 0 and AoqiGodController.instance:FormatLeftTime(leftSec) or "已过期"
	end
end

function AoqiGodCallerRecordView:_updateTxtBtn(txt, leftTime)
	if not goutil.isNil(txt) then
		txt.text = leftTime > 0 and string.format(string.format("发送到求助(%s)", leftTime)) or "发送到求助"
	end
end

function AoqiGodCallerRecordView:_onUpdate()
	self._infoList = {}

	local caller = self._aoqiGodMo:getCaller()

	if not caller:isEmpty() then
		local info = {}

		info.tag = ItemTag_Doing
		info.data = caller

		table.insert(self._infoList, info)
	end

	local finishItems = self._aoqiGodMo:getFinishItems()

	for _, v in pairs(finishItems) do
		local info = {}

		info.tag = ItemTag_Finish
		info.data = v

		table.insert(self._infoList, info)
	end

	self._itemScrollerList:reloadData(self._infoList)
	GameUtil.SetActive(self._empty, #self._infoList <= 0)

	local maxWeek = self._aoqiGodMo:getMaxFinishCountInWeek()
	local leftWeek = self._aoqiGodMo:getLeftCountOfCallerPublicInWeek()
	local maxAct = self._aoqiGodMo:getMaxFinishCount()
	local leftAct = self._aoqiGodMo:getLeftCountOfCaller()

	self._txtTips.text = string.format(self._tipsStr, leftWeek, maxAct)
end

function AoqiGodCallerRecordView:_getTagByIdx(data, idx)
	return data.tag
end

function AoqiGodCallerRecordView:_getCellSize(view, idx)
	local info = self._infoList[idx + 1]
	local tag = info.tag

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function AoqiGodCallerRecordView:_updateItemCell(view, cell, info, tag)
	if tag == ItemTag_Doing then
		self:_updateItemDoingCell(view, cell, info, tag)
	elseif tag == ItemTag_Finish then
		self:_updateItemFinishCell(view, cell, info, tag)
	end
end

function AoqiGodCallerRecordView:_updateItemDoingCell(view, cell, info, tag)
	local helpItem = info.data
	local challengeId = helpItem:getChallengeId()
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, helpItem:getChallengeId())
	local skinId = clgData.skinId
	local petName = CharacterConfig.instance:getPetName(skinId)
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local btnPublic = goutil.findChild(mainGo, "btnPublic")
	local txtBtnPublic = goutil.findChildTextComponent(mainGo, "btnPublic/txt")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtLeftTime = goutil.findChildTextComponent(mainGo, "leftTime/txt")
	local txtPalyerCount = goutil.findChildTextComponent(mainGo, "txtPalyerCount")
	local txtCharmNum = goutil.findChildTextComponent(mainGo, "charmNum/txt")
	local proxy = MaterialMgr.setCell(MatType.Pet, clgData.skinId, clgIcon)

	txtName.text = petName
	txtPalyerCount.text = string.format("当前%s/%s人帮打", helpItem:getHelperNum(), helpItem:getHelperLimit())
	txtCharmNum.text = checknumber(helpItem:getCharmValue())

	self:_addTxtToItemUpdate(txtLeftTime, helpItem)

	local oldRealTime = checknumber(_publicCdTimes[challengeId])
	local leftTime = Mathf.Floor(PulicCd - (UnityEngine.Time.realtimeSinceStartup - oldRealTime))
	local isNeedGrayCd = leftTime > 0

	self._cellDic[mainGo] = isNeedGrayCd and {
		challengeId = challengeId,
		btnPublic = btnPublic,
		txtBtnPublic = txtBtnPublic
	} or nil

	GameUtil.SetGray(btnPublic, isNeedGrayCd)
	self:_updateTxtBtn(txtBtnPublic, leftTime)
	GameUtil.addClickHandler(btnPublic, function()
		if self:_isCding(challengeId) then
			FloatWordMgr.instance:show("发送太频繁了，请稍后再试")

			return
		end

		_publicCdTimes[challengeId] = UnityEngine.Time.realtimeSinceStartup
		self._cellDic[mainGo] = {
			challengeId = challengeId,
			btnPublic = btnPublic,
			txtBtnPublic = txtBtnPublic
		}

		GameUtil.SetGray(btnPublic, true)
		self:_onTicking()

		local dataT = {
			tpId = 77,
			params = {
				activityId = self._activityId,
				targetUserId = helpItem:getUserId(),
				id = helpItem:getId(),
				challengeName = petName
			}
		}
		local content = GameUtil.jsonToString(dataT)

		ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Help, GameEnum.ChatType.System, content)
	end)
end

function AoqiGodCallerRecordView:_updateItemFinishCell(view, cell, info, tag)
	local finishItem = info.data
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, finishItem.challengeId)
	local skinId = clgData.skinId
	local headInfo = finishItem.helper
	local areaId = headInfo and headInfo.areaId
	local userName = headInfo and headInfo.userName
	local userId = headInfo and headInfo.userId
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtFinfishTime = goutil.findChildTextComponent(mainGo, "finfishTime/txt")
	local txtPlayerName = goutil.findChildTextComponent(mainGo, "playerName/txt")
	local btnDetail = goutil.findChild(mainGo, "playerName/txt/btnDetail")
	local txtCharmNum = goutil.findChildTextComponent(mainGo, "charmNum/txt")
	local finishTime = Mathf.Floor(checknumber(finishItem.finishTimeMillis) / 1000)
	local date = GameUtil.time2date(finishTime)

	txtFinfishTime.text = string.format("%02d.%02d.%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
	txtPlayerName.text = string.format("S%s-%s", areaId, userName)
	txtCharmNum.text = checknumber(finishItem.charmValue)

	local proxy = MaterialMgr.setCell(MatType.Pet, clgData.skinId, clgIcon)

	txtName.text = CharacterConfig.instance:getPetName(skinId)

	GameUtil.addClickHandler(btnDetail, function()
		FriendController.instance:showInfoView(userId, btnDetail)
	end)
end

function AoqiGodCallerRecordView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local txtLeftTime = goutil.findChildTextComponent(mainGo, "leftTime/txt")
	local btnPublic = goutil.findChild(mainGo, "btnPublic")
	local btnDetail = goutil.findChild(mainGo, "playerName/txt/btnDetail")

	MaterialMgr.resetAll(clgIcon)

	if txtLeftTime then
		self:_addTxtToItemUpdate(txtLeftTime, nil)
	end

	self._cellDic[mainGo] = nil

	GameUtil.rmClickHandler(btnPublic)
	GameUtil.rmClickHandler(btnDetail)
end

function AoqiGodCallerRecordView:_isCding(challengeId)
	local oldRealTime = checknumber(_publicCdTimes[challengeId])
	local leftTime = Mathf.Floor(PulicCd - (UnityEngine.Time.realtimeSinceStartup - oldRealTime))

	return leftTime > 0
end

return AoqiGodCallerRecordView
