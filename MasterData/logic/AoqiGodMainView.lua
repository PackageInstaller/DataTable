-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodMainView.lua

module("logic.extensions.aoqigod.view.AoqiGodMainView", package.seeall)

local AoqiGodMainView = class("AoqiGodMainView", ViewComponent)
local _CurRankIdx = 1
local MaxShowRank = 3
local _CurConIdx = 1
local ResetCd = 5
local _LastResetTime = 0

function AoqiGodMainView:ctor()
	AoqiGodMainView.super.ctor(self)

	self._sifterCondsMap = {}
end

function AoqiGodMainView:buildUI()
	AoqiGodMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._btnHelperRecord = goutil.findChild(self.mainGO, "btnCol/btnHelperRecord")
	self._btnCallerRecord = goutil.findChild(self.mainGO, "btnCol/btnCallerRecord")
	self._btnRank = goutil.findChild(self.mainGO, "btnCol/btnRank")
	self._btnShop = goutil.findChild(self.mainGO, "btnCol/btnShop")
	self._btnTeamBuff = goutil.findChild(self.mainGO, "btnCol/btnTeamBuff")
	self._btnHelp = goutil.findChild(self.mainGO, "btnHelp")
	self._redBtnHelp = goutil.findChild(self.mainGO, "btnHelp/redPoint")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "showCol/myRank/txt")
	self._txtMyHelpCount = goutil.findChildTextComponent(self.mainGO, "showCol/myHelpCount/txt")
	self._btnLeft = goutil.findChild(self.mainGO, "showCol/btnLeft")
	self._btnRight = goutil.findChild(self.mainGO, "showCol/btnRight")
	self._txtNameInPlayer = goutil.findChildTextComponent(self.mainGO, "showCol/txtName")
	self._rankInPlayer = goutil.findChild(self.mainGO, "showCol/rank")
	self._txtRankInPlayer = goutil.findChildTextComponent(self.mainGO, "showCol/rank/txt")
	self._txtZdlInPlayer = goutil.findChildTextComponent(self.mainGO, "showCol/txtZdl")
	self._emptyName = goutil.findChild(self.mainGO, "showCol/emptyName")
	self._btnShowInfo = goutil.findChild(self.mainGO, "showCol/btnShowInfo")

	local playerCon1 = goutil.findChild(self.mainGO, "showCol/playerView/playerCon1")
	local playerCon2 = goutil.findChild(self.mainGO, "showCol/playerView/playerCon2")

	self._posList = self:getGo("modelCam/posList")

	local pos_2 = self:getGo("modelCam/posList/pos_2")
	local pos_1 = self:getGo("modelCam/posList/pos_1")

	self._playerConCellList = {}

	for i, mainGo in ipairs({
		pos_1,
		pos_2
	}) do
		local cell = {}

		cell._mainGo = mainGo
		cell._empty = goutil.findChild(mainGo, "empty")
		cell._con = goutil.findChild(mainGo, "con")
		cell._canvasGroup = cell._mainGo:GetComponent(ComponentType.CanvasGroup)
		cell._photoEff = nil
		cell._avatar = nil
		self._playerConCellList[i] = cell
	end

	self._rootPosList = {}
	self._rootScaleList = {}

	for i = 1, 3 do
		local mainGo = goutil.findChild(self.mainGO, "showCol/playerView/root" .. i)

		table.insert(self._rootPosList, GameUtil.getPos(mainGo))
		table.insert(self._rootScaleList, GameUtil.getLocalScale(mainGo))
	end

	self._txtHelpTips = goutil.findChildTextComponent(self.mainGO, "tips/txtHelpTips")
	self._helpTipsStr = self._txtHelpTips.text
	self._txtGetTips = goutil.findChildTextComponent(self.mainGO, "tips/txtGetTips")
	self._getTipsStr = self._txtGetTips.text
	self._txtRewardTips = goutil.findChildTextComponent(self.mainGO, "myHelper/txtRewardTips")
	self._emptyMyCaller = goutil.findChild(self.mainGO, "myHelper/empty")
	self._mhHelpCell = goutil.findChild(self.mainGO, "myHelper/helpCell")
	self._mhHelpCell_clgIcon = goutil.findChild(self.mainGO, "myHelper/helpCell/clgIcon")
	self._mhHelpCell_btnDetail = goutil.findChild(self.mainGO, "myHelper/helpCell/txtName/btnDetail")
	self._mhHelpCell_btnCancel = goutil.findChild(self.mainGO, "myHelper/helpCell/btnCancel")
	self._mhHelpCell_btnSure = goutil.findChild(self.mainGO, "myHelper/helpCell/btnSure")
	self._mhHelpCell_txtName = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/txtName")
	self._mhHelpCell_txtCharm = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/charm/txt")
	self._tableviewGo = self:getGo("myHelper/helpCell/prize/tableview")
	self._tablecellGo = self:getGo("myHelper/helpCell/prize/tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateHelpRewardCell, self), GameUtil.handler(self._clearHelpRewardCell, self))
	self._mhHelpCell_txtLeftTime = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/leftTime/txt")
	self._mhHelpCell_txtTips = goutil.findChildTextComponent(self.mainGO, "myHelper/helpCell/txtTips")
	self._mhHelpCell_txtScore = self:getTxt("myHelper/helpCell/score/txt")
	self._inputSearch = self:getInput("helperWall/InputC_Search")
	self._btnSearch = goutil.findChild(self.mainGO, "helperWall/InputC_Search/btnSearch")
	self._btnCancel = goutil.findChild(self.mainGO, "helperWall/InputC_Search/btnCancel")
	self._txtTipsInHelperWall = goutil.findChildTextComponent(self.mainGO, "helperWall/txtTips")
	self._tipsInHelperWallStr = self._txtTipsInHelperWall.text
	self._btnFilter = goutil.findChild(self.mainGO, "helperWall/btnFilter")
	self._btnSort = goutil.findChild(self.mainGO, "helperWall/btnSort")
	self._emptyHelperWall = goutil.findChild(self.mainGO, "helperWall/empty")
	self._emptySearch = goutil.findChild(self.mainGO, "helperWall/emptySearch")

	local wallScrView = goutil.findChild(self.mainGO, "helperWall/scrView")
	local wallScrCell = goutil.findChild(self.mainGO, "helperWall/scrCell")

	self._wallScrollerList = ScrollerList.create(wallScrView, wallScrCell, GameUtil.handler(self._updateWallCell, self), GameUtil.handler(self._clearWallCell, self))
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._blackMaskInReset = goutil.findChild(self.mainGO, "btnReset/blackMask")
	self._txtBtnReset = goutil.findChildTextComponent(self.mainGO, "btnReset/txt")
	self._txtBlackMaskInReset = goutil.findChildTextComponent(self.mainGO, "btnReset/blackMask/txt")
	self._sifterCol = goutil.findChild(self.mainGO, "helperWall/sifterCol")
	self._tabView = goutil.findChild(self.mainGO, "helperWall/sifterCol/sifterView/scrView/viewport/content")
	self._tabCell = goutil.findChild(self.mainGO, "helperWall/sifterCol/tabCell")
	self._sortCol = goutil.findChild(self.mainGO, "helperWall/sortCol")
	self._sortView = goutil.findChild(self.mainGO, "helperWall/sortCol/sortView")
	self._sortCell = goutil.findChild(self.mainGO, "helperWall/sortCol/sortCell")
	self._customInputFilter = UICustomInput.Get(self._sifterCol)
	self._customInputSort = UICustomInput.Get(self._sortCol)

	GameUtil.SetActive(self._sifterCol, false)
	GameUtil.SetActive(self._sortCol, false)

	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._scrollList = {}
end

function AoqiGodMainView:bindEvents()
	AoqiGodMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnHelperRecord, self._onClickBtnHelperRecord, self)
	GameUtil.addClickHandler(self._btnCallerRecord, self._onClickBtnCallerRecord, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnTeamBuff, self._onClickBtnTeamBuff, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickBtnHelp, self)
	GameUtil.addClickHandler(self._btnShowInfo, self._onClickBtnShowInfo, self)
	self._customInputFilter:AddListener(self._onCustomInputCallbackFilter, self)
	self._customInputSort:AddListener(self._onCustomInputCallbackSort, self)
	GameUtil.addClickHandler(self._btnFilter, self._onCustomInputCallbackFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onCustomInputCallbackSort, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickBtnSearch, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickBtnSwitchRankShow, self, -1))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickBtnSwitchRankShow, self, 1))
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function AoqiGodMainView:unbindEvents()
	AoqiGodMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnHelperRecord)
	GameUtil.rmClickHandler(self._btnCallerRecord)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTeamBuff)
	GameUtil.rmClickHandler(self._btnHelp)
	self._customInputFilter:RemoveListener()
	self._customInputSort:RemoveListener()
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	self._inputSearch:RemoveOnValueChanged()
end

function AoqiGodMainView:onEnter()
	AoqiGodMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._modalCount = 0

	goutil.setActive(self._modelCam.gameObject, true)
	self:_setAvatarCameraEnv(true)
	AoqiGodController.instance:enterInMgr(self._activityId)

	if not AoqiGodController.instance:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")
		self:close()

		return
	end

	self._mgr = AoqiGodController.instance:getMgr()
	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)
	self._lockTxtDic = self._lockTxtDic or {}

	table.clear(self._lockTxtDic)

	self._nowMs = ServerTime.nowMs()
	self._wallItemListInShow = self._wallItemListInShow or {}
	self._isSearching = false

	if self._sortIdxs == nil then
		self._sortIdxs = {}

		for i, sortType in ipairs(AoqiGodEnum.SortTypeList) do
			self:_triggerSortIdx(sortType, 3)
		end

		self:_triggerSortIdx(AoqiGodEnum.SortTypes_LeftTime, 2)
	end

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodSeekHelpWallRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodRankRes, self._handlePM_AoqiGodRankRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodGiveUpHelpItemRes, self._handlePM_AoqiGodGiveUpHelpItemRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodAcceptHelpItemRes, self._handlePM_AoqiGodAcceptHelpItemRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodSearchSeekHelpItemRes, self._handlePM_AoqiGodSearchSeekHelpItemRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodRefreshHelpWallRes, self._handlePM_AoqiGodRefreshHelpWallRes, self)
	self.addGEvent(self, GlobalNotify.AoqiGodItemHelpChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnViewOpen, self._onOnViewOpen, self)
	self.addGEvent(self, GlobalNotify.OnViewClose, self._onOnViewClose, self)

	local matStr = self._actData.goldMat

	if not string.nilorempty(matStr) then
		local list = {}

		list[1] = {
			showAdd = true,
			id = matStr
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	self._filterSortClgCfgList = AoqiGodController.instance:getSortClgCfgList(self._activityId)

	local activityType = AoqiGodController.instance:getActivityType()

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)

	self:_setInitRole()
	self:_onInitSearch()
	self:_onUpdateTabColUI()
	self:_onUpdateSortColUI()
	self:_onUpdateShowCol()
	self:_onUpdate()
	settimer(1, self._onTicking, self, true)
	self:_onTicking()

	self._tickingSwitch = 0

	settimer(1, self._onSwitchRole, self, true)
	AoqiGodController.instance:sendPM_AoqiGodInfoReq(self._activityId)
	AoqiGodController.instance:sendPM_AoqiGodSeekHelpWallReq(self._activityId)
	AoqiGodController.instance:sendPM_AoqiGodRankReq(self._activityId)
	AoqiGodController.instance:checkChallengeFinishAndPopResult(self._activityId)
end

function AoqiGodMainView:onExit()
	AoqiGodMainView.super.onExit(self)
	self:_setAvatarCameraEnv(false)
	removetimer(self._onTicking, self)
	removetimer(self._onSwitchRole, self)

	self._mgr = nil

	AoqiGodController.instance:exitInMgr(self._activityId)
	table.clear(self._lockTxtDic)
	self:_onClearSortColUI()
	self:_onClearTabColUI()
	self:_onClearPlaneUI()
	self:_onClearHelperWallUI()
	self:_onClearShowCol()
	self:_endStartBtnResetCdAnim()
	self._scrollerList:dispose()
end

function AoqiGodMainView:_handlePM_AoqiGodGiveUpHelpItemRes()
	self:_onUpdatePlaneUI()
end

function AoqiGodMainView:_handlePM_AoqiGodAcceptHelpItemRes()
	self:_onUpdate()
end

function AoqiGodMainView:_handlePM_AoqiGodSearchSeekHelpItemRes()
	self:_onUpdateHelperWallUI()
end

function AoqiGodMainView:_handlePM_AoqiGodRefreshHelpWallRes()
	self:_onUpdate()
end

function AoqiGodMainView:_handlePM_AoqiGodRankRes()
	self:_onUpdateShowCol()
end

function AoqiGodMainView:_onTicking()
	self._nowMs = ServerTime.nowMs()

	for txt, helpItem in pairs(self._lockTxtDic) do
		self:_updateTxtByItem(txt, helpItem)
	end
end

function AoqiGodMainView:_addTxtToItemUpdate(txt, helpItem)
	if helpItem then
		self._lockTxtDic[txt] = helpItem

		self:_updateTxtByItem(txt, helpItem)
	else
		self._lockTxtDic[txt] = nil
	end
end

function AoqiGodMainView:_updateTxtByItem(txt, helpItem)
	if txt then
		local leftSec = helpItem:getLeftTimeSec(self._nowMs)

		if leftSec > 0 then
			txt.text = AoqiGodController.instance:FormatLeftTime(leftSec)
		else
			txt.text = "已过期"
			self._lockTxtDic[txt] = nil
		end
	end
end

function AoqiGodMainView:_onUpdate()
	table.clear(self._lockTxtDic)
	self:_onUpdateData()
	self:_onUpdateUI()
end

function AoqiGodMainView:_onUpdateData()
	self:_onUpdateHelperWallData()
	self:_onUpdateShowColData()
end

function AoqiGodMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateHelperWallUI()
	self:_tryStartBtnResetCdAnim()
end

function AoqiGodMainView:_onUpdatePlaneUI()
	local helpItem = self._aoqiGodMo:getHelper()
	local isEmptyMyCaller = helpItem:isEmpty()

	GameUtil.SetActive(self._emptyMyCaller, isEmptyMyCaller)
	GameUtil.SetActive(self._mhHelpCell, not isEmptyMyCaller)

	if not isEmptyMyCaller then
		self:_onUpdateMyHelperCell(helpItem)
	else
		self:_onClearMyHelperCell()
	end

	if self._txtRewardTips then
		local cur = self._aoqiGodMo:getDailyHelperTimes()
		local max = self._aoqiGodMo:getGodDailyTimes()
		local left = Mathf.Max(0, max - cur)

		self._txtRewardTips.text = string.format("今日协助奖励次数：%s/%s", left, max)
	end

	local leftCountOfCallerPublicInWeek = self._aoqiGodMo:getLeftCountOfCallerPublicInWeek()

	self._txtHelpTips.text = string.format(self._helpTipsStr, leftCountOfCallerPublicInWeek)
	self._txtGetTips.text = string.format(self._getTipsStr, self._aoqiGodMo:getLeftCountOfCaller())

	GameUtil.SetActive(self._redBtnHelp, leftCountOfCallerPublicInWeek > 0)

	local zdl = self._aoqiGodMo:getZdlLimit()
	local base = Mathf.Floor(zdl / 10000)
	local dot = Mathf.Ceil(zdl / 100 - base * 100) / 100

	self._txtTipsInHelperWall.text = string.format(self._tipsInHelperWallStr, dot > 0 and string.format("%.2f", base + dot) or base, self._actData.helperLimit)
end

function AoqiGodMainView:_onClearPlaneUI()
	self:_onClearMyHelperCell()
end

function AoqiGodMainView:_onUpdateMyHelperCell(helpItem)
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, helpItem:getChallengeId())
	local proxy = MaterialMgr.setCell(MatType.Pet, clgData.skinId, self._mhHelpCell_clgIcon)

	self._mhHelpCell_txtName.text = helpItem:getPlayerName()
	self._mhHelpCell_txtCharm.text = helpItem:getCharmValue()

	local rewards = string.split(clgData.godPrize, "#")

	self._scrollerList:reloadData(rewards)
	self:_addTxtToItemUpdate(self._mhHelpCell_txtLeftTime, helpItem)

	self._mhHelpCell_txtScore.text = clgData.helpAddScore
	self._mhHelpCell_txtTips.text = string.format("当前%s/%s人帮打", helpItem:getHelperNum(), helpItem:getHelperLimit())

	GameUtil.addClickHandler(self._mhHelpCell_btnDetail, function()
		FriendController.instance:showInfoView(helpItem:getUserId(), self._mhHelpCell_btnDetail)
	end)
	GameUtil.addClickHandler(self._mhHelpCell_btnCancel, function()
		local result = AoqiGodController.instance:getTryGiveUpHelpResultAndTips(true, self._activityId, helpItem)

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
	GameUtil.addClickHandler(self._mhHelpCell_btnSure, function()
		local result = AoqiGodController.instance:getTryStartHelpResultAndTips(true, self._activityId, helpItem)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		AoqiGodController.instance:enterChallenge(self._activityId, helpItem:getChallengeId())
	end)
end

function AoqiGodMainView:_onClearMyHelperCell()
	self._lockTxtDic[self._mhHelpCell_txtLeftTime] = nil

	MaterialMgr.resetAll(self._mhHelpCell_clgIcon)
	GameUtil.rmClickHandler(self._mhHelpCell_btnDetail)
	GameUtil.rmClickHandler(self._mhHelpCell_btnCancel)
	GameUtil.rmClickHandler(self._mhHelpCell_btnSure)
end

function AoqiGodMainView:_onUpdateShowCol()
	self:_onUpdateShowColData()
	self:_onUpdateShowColUI()

	local cell = self._playerConCellList[_CurConIdx]
	local rankInfo = self._showRankInfoList[_CurRankIdx]

	self:_updatePlayerCon(cell, rankInfo)
end

function AoqiGodMainView:_onUpdateShowColData()
	local msg = self._aoqiGodMo:getRankResMsg() or {}

	self._myRankInGod = msg.myRank or 0
	self._showRankInfoList = msg.tops or {}
	_CurRankIdx = #self._showRankInfoList == 0 and 1 or Mathf.Clamp(_CurRankIdx, 1, #self._showRankInfoList)
end

function AoqiGodMainView:_onUpdateShowColUI()
	local rankInfo = self._showRankInfoList[_CurRankIdx]
	local isHavePlayer = rankInfo ~= nil

	GameUtil.SetActive(self._txtZdlInPlayer.gameObject, isHavePlayer)
	GameUtil.SetActive(self._txtNameInPlayer.gameObject, isHavePlayer)
	GameUtil.SetActive(self._btnShowInfo, isHavePlayer)
	GameUtil.SetActive(self._emptyName, not isHavePlayer)

	if isHavePlayer then
		self._txtNameInPlayer.text = string.format("S%s-%s", rankInfo.headInfo.areaId, rankInfo.headInfo.userName)
		self._txtZdlInPlayer.text = rankInfo.zdl
	end

	self._txtMyRank.text = self._myRankInGod <= 0 and "未上榜" or self._myRankInGod
	self._txtMyHelpCount.text = self._aoqiGodMo:getTotalScore()

	GameUtil.setUIImageSpriteIdx(self._rankInPlayer, _CurRankIdx - 1)

	self._txtRankInPlayer.text = _CurRankIdx
end

function AoqiGodMainView:_onClearShowCol()
	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end

	for _, cell in ipairs(self._playerConCellList) do
		self:_clearPlayerCon(cell)
	end
end

function AoqiGodMainView:_onClickBtnSwitchRankShow(delta)
	local nextRankIdx = (_CurRankIdx + delta - 1) % MaxShowRank + 1

	if _CurRankIdx ~= nextRankIdx then
		if self._sequence then
			self._sequence:Kill(true)

			self._sequence = nil
		end

		local curRankInfo = self._showRankInfoList[_CurRankIdx]
		local nextRankInfo = self._showRankInfoList[nextRankIdx]
		local nextConIdx = (_CurConIdx + delta - 1) % #self._playerConCellList + 1
		local cellA = self._playerConCellList[_CurConIdx]
		local cellB = self._playerConCellList[nextConIdx]
		local avatarRootA = goutil.findChild(self._modelCam, "posList/pos_" .. _CurConIdx)
		local avatarRootB = goutil.findChild(self._modelCam, "posList/pos_" .. nextConIdx)

		self:_updatePlayerCon(cellA, curRankInfo)
		self:_updatePlayerCon(cellB, nextRankInfo)

		local formRootIdxA, toRootIdxA = 2, Mathf.Clamp(2 - delta, 1, 3)
		local formPosA = self._rootPosList[formRootIdxA]
		local toPosA = self._rootPosList[toRootIdxA]
		local formScaleA = self._rootScaleList[formRootIdxA] * 90
		local toScaleA = self._rootScaleList[toRootIdxA] * 90
		local distanceA = Vector2.Distance(formPosA, toPosA)
		local formRootIdxB, toRootIdxB = Mathf.Clamp(2 + delta, 1, 3), 2
		local formPosB = self._rootPosList[formRootIdxB]
		local toPosB = self._rootPosList[toRootIdxB]
		local formScaleB = self._rootScaleList[formRootIdxB] * 90
		local toScaleB = self._rootScaleList[toRootIdxB] * 90
		local distanceB = Vector2.Distance(formPosB, toPosB)
		local speedRatio = 1.3

		GameUtil.setPos(avatarRootA, formPosA.x, formPosA.y, formPosA.z)
		GameUtil.setLocalScale(avatarRootA, formScaleA.x, formScaleA.y, formScaleA.z)
		GameUtil.SetActive(avatarRootA, true)
		GameUtil.setPos(avatarRootB, formPosB.x, formPosB.y, formPosB.z)
		GameUtil.setLocalScale(avatarRootB, formScaleB.x, formScaleB.y, formScaleB.z)
		GameUtil.SetActive(avatarRootB, true)

		local tweenerMoveA = avatarRootA.transform:DOMove(toPosA, distanceA / speedRatio)

		tweenerMoveA:SetEase(DG.Tweening.Ease.Linear)

		local tweenerOfScaleA = avatarRootA.transform:DOScale(toScaleA, distanceA / speedRatio)

		tweenerOfScaleA:SetEase(DG.Tweening.Ease.Linear)
		tweenerMoveA:OnComplete(function()
			GameUtil.SetActive(avatarRootA, false)
		end)

		local tweenerMoveB = avatarRootB.transform:DOMove(toPosB, distanceB / speedRatio)

		tweenerMoveB:SetEase(DG.Tweening.Ease.Linear)

		local tweenerOfScaleB = avatarRootB.transform:DOScale(toScaleB, distanceB / speedRatio)

		tweenerOfScaleB:SetEase(DG.Tweening.Ease.Linear)
		tweenerMoveB:OnComplete(function()
			GameUtil.SetActive(avatarRootB, true)
		end)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Join(tweenerMoveA)
		sequence:Join(tweenerOfScaleA)
		sequence:Join(tweenerMoveB)
		sequence:Join(tweenerOfScaleB)
		sequence:OnComplete(function()
			self:_onUpdateShowColUI()
		end)

		self._sequence = sequence
		_CurRankIdx = nextRankIdx
		_CurConIdx = nextConIdx
		self._tickingSwitch = 0
	end
end

function AoqiGodMainView:_onSwitchRole()
	self._tickingSwitch = self._tickingSwitch + 1

	if self._tickingSwitch >= 5 then
		self._tickingSwitch = 0

		self:_onClickBtnSwitchRankShow(1)
	end
end

function AoqiGodMainView:_updatePlayerCon(cell, rankInfo)
	if rankInfo then
		local gender = rankInfo.gender
		local clothes = rankInfo.clothes
		local skId = DressModel.instance:getSkeIdByGender(gender)
		local avatarMo = DressModel.instance:getAvatarPlayerMo(skId, clothes, 0)
		local avatar = cell._avatar

		if avatar == nil then
			avatar = AvatarsMgrNew.instance:getAvatarByMo(avatarMo)
			avatar.useType = AvatarUseType.Scene
			cell._avatar = avatar

			local avatarRoot = cell._mainGo

			cell._avatar:setParent(avatarRoot.transform)
			cell._avatar:setLayer(SceneLayer.UI3D_Value)
		end

		avatar:updateByMo(avatarMo)
		GameUtil.SetActive(cell._empty, false)
		GameUtil.SetActive(cell._con, true)
	else
		GameUtil.SetActive(cell._empty, true)
		GameUtil.SetActive(cell._con, false)
	end
end

function AoqiGodMainView:_clearPlayerCon(cell)
	if cell._avatar then
		AvatarsMgrNew.instance:removeAvatar(cell._avatar)

		cell._avatar = nil
	end

	cell._avatar = nil
end

function AoqiGodMainView:_onUpdateHelperWallData()
	return
end

function AoqiGodMainView:_onUpdateHelperWallUI()
	table.clear(self._wallItemListInShow)

	local dataList

	if self._isSearching then
		dataList = self._aoqiGodMo:getSearchItemList()

		local findStr = string.nilorempty(self._currSearching) and "" or StringUtil.RelpaceEscapeChar(self._currSearching)
		local petNameFindList = AoqiGodController.instance:getHelpItemNameListByPetName(self._activityId, findStr)

		table.insertto(self._wallItemListInShow, petNameFindList)
	else
		dataList = self._aoqiGodMo:getWallItemList()
	end

	local isShowAll = self:_isSifterShowAll()

	for _, helpItem in ipairs(dataList) do
		local allReadyInside = table.indexof(self._wallItemListInShow, helpItem)

		if not allReadyInside then
			if isShowAll then
				table.insert(self._wallItemListInShow, helpItem)
			elseif self:_getSifterCondvalue(helpItem:getChallengeId()) then
				table.insert(self._wallItemListInShow, helpItem)
			end
		end
	end

	local names, opt = self:_getSortNamesAndOpts()

	ArraySort.sortOn(self._wallItemListInShow, names, opt)
	self._wallScrollerList:reloadData(self._wallItemListInShow)
	GameUtil.SetActive(self._emptyHelperWall, not self._isSearching and #self._wallItemListInShow <= 0)
	GameUtil.SetActive(self._emptySearch, self._isSearching and #self._wallItemListInShow <= 0)
end

function AoqiGodMainView:_onClearHelperWallUI()
	table.clear(self._wallItemListInShow)
	self._wallScrollerList:dispose()
end

function AoqiGodMainView:_updateWallCell(view, cell, helpItem, tag)
	local challengeId = helpItem:getChallengeId()
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, challengeId)
	local targetUserId = helpItem:getUserId()
	local id = helpItem:getId()
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local btnDetail = goutil.findChild(mainGo, "txtName/btnDetail")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtLeftTime = goutil.findChildTextComponent(mainGo, "leftTime/txt")
	local txtTips = goutil.findChildTextComponent(mainGo, "txtTips")
	local txtScore = goutil.findChildTextComponent(mainGo, "score/txt")
	local goTablecell = goutil.findChild(cell.gameObject, "prize/tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "prize/tableview")
	local txtCharm = goutil.findChildTextComponent(cell.gameObject, "charm/txt")
	local proxy = MaterialMgr.setCell(MatType.Pet, clgData.skinId, clgIcon)

	txtName.text = helpItem:getPlayerName()

	local rewards = string.split(clgData.godPrize, "#")
	local scroll = self:_getScroll(goTableview, goTablecell)

	scroll:reloadData(rewards)
	self:_addTxtToItemUpdate(txtLeftTime, helpItem)

	txtScore.text = clgData.helpAddScore
	txtCharm.text = helpItem:getCharmValue()
	txtTips.text = string.format("当前%s/%s人帮打", helpItem:getHelperNum(), helpItem:getHelperLimit())

	GameUtil.addClickHandler(btnDetail, function()
		FriendController.instance:showInfoView(targetUserId, btnDetail)
	end)
	GameUtil.addClickHandler(btnSure, function()
		local result, tips = AoqiGodController.instance:getTryAcceptHelpResultAndTips(true, self._activityId, helpItem)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		UIStateManager.instance:push(ViewName.AoqiGodHelpSurePopView, self._activityId, helpItem)
	end)
end

function AoqiGodMainView:_clearWallCell(cell)
	local mainGo = cell.gameObject
	local clgIcon = goutil.findChild(mainGo, "clgIcon")
	local btnDetail = goutil.findChild(mainGo, "txtName/btnDetail")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local txtLeftTime = goutil.findChildTextComponent(mainGo, "leftTime/txt")
	local goTableview = goutil.findChild(cell.gameObject, "prize/tableview")

	MaterialMgr.resetAll(clgIcon)
	self:_addTxtToItemUpdate(txtLeftTime, nil)
	GameUtil.rmClickHandler(btnDetail)
	GameUtil.rmClickHandler(btnSure)

	if self._scrollList[goTableview] then
		self._scrollList[goTableview]:dispose()
	end
end

function AoqiGodMainView:_onUpdateTabColUI()
	for challengeId, v in pairs(self._sifterCondsMap) do
		if AoqiGodConfig.instance:getClgData(self._activityId, challengeId) == nil then
			self._sifterCondsMap[challengeId] = nil
		end
	end

	GameUtil.updateCellsList(self._tabView, self._tabCell, self._filterSortClgCfgList, self._updateTabCell, self)
end

function AoqiGodMainView:_onClearTabColUI()
	GameUtil.clearCells(self._tabView, self._clearTabCell, self)
end

function AoqiGodMainView:_updateTabCell(mainGo, data, tabIdx)
	local challengeId = data.challengeId
	local isSelected = self:_getSifterCondvalue(challengeId)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)

	txtName.text = CharacterConfig.instance:getPetName(data.skinId)

	GameUtil.addClickHandler(mainGo, function()
		local value = not self:_getSifterCondvalue(challengeId)

		self:_setSifterCondValue(challengeId, value)
		GameUtil.setUIGroupIdx(mainGo, value and 1 or 0)
		self:_onUpdateHelperWallUI()
	end)
end

function AoqiGodMainView:_clearTabCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function AoqiGodMainView:_setSifterCondValue(key, value)
	self._sifterCondsMap[key] = value
end

function AoqiGodMainView:_getSifterCondvalue(key)
	return self._sifterCondsMap[key]
end

function AoqiGodMainView:_isSifterShowAll()
	for k, v in pairs(self._sifterCondsMap) do
		if v then
			return false
		end
	end

	return true
end

function AoqiGodMainView:_onUpdateSortColUI()
	GameUtil.updateCellsList(self._sortView, self._sortCell, AoqiGodEnum.SortTypeList, self._updateSortCell, self)
end

function AoqiGodMainView:_onClearSortColUI()
	GameUtil.clearCells(self._sortView, self._clearSortCell, self)
end

function AoqiGodMainView:_updateSortCell(mainGo, sortType, tabIdx)
	local sortIdx = self:_getSortIdx(sortType)
	local imgSort = goutil.findChild(mainGo, "imgSort")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = AoqiGodEnum.SortNames[sortType]

	GameUtil.setUIImageSpriteIdx(imgSort, sortIdx - 1)
	GameUtil.addClickHandler(mainGo, function()
		self:_triggerSortIdx(sortType)
		self:_onUpdateSortColUI()
		self:_onUpdateHelperWallUI()
	end)
end

function AoqiGodMainView:_clearSortCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function AoqiGodMainView:_triggerSortIdx(sortType, forceIdx)
	if forceIdx then
		self._sortIdxs[sortType] = forceIdx
	elseif not self._sortIdxs[sortType] then
		local sortIdx = 3

		self._sortIdxs[sortType] = sortIdx % 3 + 1
	end

	for k, v in pairs(self._sortIdxs) do
		if k ~= sortType then
			self._sortIdxs[k] = 3
		end
	end
end

function AoqiGodMainView:_getSortIdx(sortType)
	return self._sortIdxs[sortType] or 1
end

function AoqiGodMainView:_getSortNamesAndOpts()
	local names, opts = {}, {}

	for _, sortType in ipairs(AoqiGodEnum.SortTypeList) do
		local opt = self:_getSortValue(sortType)

		if opt ~= -1 then
			table.insert(names, self:_getSortFunc(sortType))
			table.insert(opts, opt)
		end
	end

	return names, opts
end

function AoqiGodMainView:_getSortFunc(sortType)
	if sortType == AoqiGodEnum.SortTypes_LeftTime then
		return function(helpItem)
			return checknumber(helpItem:getEndTimeMillis())
		end
	elseif sortType == AoqiGodEnum.SortTypes_HelperNum then
		return function(helpItem)
			return helpItem:getHelperNum()
		end
	elseif sortType == AoqiGodEnum.SortTypes_ScoreNum then
		return function(helpItem)
			local challengeId = helpItem:getChallengeId()
			local clgData = AoqiGodConfig.instance:getClgData(self._activityId, challengeId)

			return clgData.helpAddScore
		end
	elseif sortType == AoqiGodEnum.SortTypes_CharmNum then
		return function(helpItem)
			return helpItem:getCharmValue()
		end
	end
end

function AoqiGodMainView:_getSortValue(sortType)
	local sortIdx = self:_getSortIdx(sortType)

	return AoqiGodEnum.SortValues[sortType][sortIdx]
end

function AoqiGodMainView:_onInitSearch()
	local searchInfo = self._inputSearch:GetText()

	GameUtil.SetActive(self._btnCancel, not string.nilorempty(searchInfo))
end

function AoqiGodMainView:_OnSearchTextChanged(value)
	GameUtil.SetActive(self._btnCancel, not string.nilorempty(value))

	if value ~= self._currSearching then
		self._currSearching = value

		if string.nilorempty(value) then
			self._isSearching = false

			self:_onUpdateHelperWallUI()
		end
	end
end

function AoqiGodMainView:_onClickBtnSearch()
	local searchInfo = self._inputSearch:GetText()
	local searchUserId

	if not string.nilorempty(searchInfo) then
		self._isSearching = true

		AoqiGodController.instance:sendPM_AoqiGodSearchSeekHelpItemReq(self._activityId, searchInfo, searchUserId)
	end
end

function AoqiGodMainView:_onClickBtnCancel()
	self._inputSearch:SetText("")

	self._isSearching = false
end

function AoqiGodMainView:_onClickBtnReset()
	local last = _LastResetTime
	local now = UnityEngine.Time.realtimeSinceStartup
	local cd = Mathf.Floor(now - last)

	if cd < ResetCd then
		FloatWordMgr.instance:show("操作太频繁了，请稍后再试")

		return
	end

	_LastResetTime = now

	AoqiGodController.instance:sendPM_AoqiGodRefreshHelpWallReq(self._activityId, nil)
	self:_startBtnResetCdAnim()
end

function AoqiGodMainView:_tryStartBtnResetCdAnim()
	local cd = Mathf.Floor(UnityEngine.Time.realtimeSinceStartup - _LastResetTime)

	if cd >= ResetCd then
		self:_endStartBtnResetCdAnim()
	else
		self:_startBtnResetCdAnim()
	end
end

function AoqiGodMainView:_startBtnResetCdAnim()
	GameUtil.SetActive(self._blackMaskInReset, true)
	GameUtil.SetGray(self._txtBtnReset.gameObject, true)
	settimer(1, self._onTickingInResetCd, self, true)
	self:_onTickingInResetCd()
end

function AoqiGodMainView:_endStartBtnResetCdAnim()
	GameUtil.SetActive(self._blackMaskInReset, false)
	GameUtil.SetGray(self._txtBtnReset.gameObject, false)

	self._lastRefreshtime = 0

	removetimer(self._onTickingInResetCd, self)
end

function AoqiGodMainView:_onTickingInResetCd()
	local cd = Mathf.Floor(UnityEngine.Time.realtimeSinceStartup - _LastResetTime)
	local leftCd = Mathf.Max(ResetCd - cd, 0)

	if leftCd <= 0 then
		self:_endStartBtnResetCdAnim()

		return
	end

	self._txtBlackMaskInReset.text = leftCd
end

function AoqiGodMainView:_onClickBtnTip()
	local key = self._actData.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function AoqiGodMainView:_onClickBtnHelperRecord()
	UIStateManager.instance:push(ViewName.AoqiGodHelperRecordView, self._activityId)
end

function AoqiGodMainView:_onClickBtnCallerRecord()
	UIStateManager.instance:push(ViewName.AoqiGodCallerRecordView, self._activityId)
end

function AoqiGodMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.AoqiGodRankTabFrameView, self._activityId)
end

function AoqiGodMainView:_onClickBtnShop()
	local jumpStr = self._actData.jumpTo

	GotoMgr.gotoByString(jumpStr)
end

function AoqiGodMainView:_onClickBtnTeamBuff()
	UIStateManager.instance:push(ViewName.AoqiGodMmTeamBuffView, self._activityId)
end

function AoqiGodMainView:_onClickBtnHelp()
	UIStateManager.instance:push(ViewName.AoqiGodPetSelectView, self._activityId)
end

function AoqiGodMainView:_onCustomInputCallbackFilter(hover)
	if not hover then
		GameUtil.SetActive(self._sifterCol, not GameUtil.GetActive(self._sifterCol))
	end
end

function AoqiGodMainView:_onCustomInputCallbackSort(hover)
	if not hover then
		GameUtil.SetActive(self._sortCol, not GameUtil.GetActive(self._sortCol))
	end
end

function AoqiGodMainView:_onClickBtnShowInfo()
	local rankInfo = self._showRankInfoList[_CurRankIdx]

	if rankInfo then
		FriendController.instance:showInfoView(rankInfo.headInfo.userId, self._btnShowInfo)
	end
end

function AoqiGodMainView:_setInitRole()
	local avatarRoot = goutil.findChild(self._modelCam, "posList/pos_" .. _CurConIdx)
	local formRootIdxA, toRootIdxA = 2, Mathf.Clamp(1, 1, 3)
	local formPosA = self._rootPosList[formRootIdxA]
	local formScaleA = self._rootScaleList[formRootIdxA] * 90

	GameUtil.setPos(avatarRoot, formPosA.x, formPosA.y, formPosA.z)
	GameUtil.setLocalScale(avatarRoot, formScaleA.x, formScaleA.y, formScaleA.z)
	GameUtil.SetActive(avatarRoot, true)
end

function AoqiGodMainView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	LightMgr.instance:setUseModelLight(isOnEnter)
	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

local SpVieews = {
	[ViewName.ItemGet] = true
}

function AoqiGodMainView:_onOnViewOpen(view)
	if ViewSetting.instance:isModal(view.viewName) or SpVieews[view.viewName] then
		self._modalCount = self._modalCount + 1

		goutil.setActive(self._modelCam.gameObject, false)
	end
end

function AoqiGodMainView:_onOnViewClose(view)
	if ViewSetting.instance:isModal(view.viewName) or SpVieews[view.viewName] then
		self._modalCount = self._modalCount - 1

		if self._modalCount <= 0 then
			goutil.setActive(self._modelCam.gameObject, true)
		end
	end
end

function AoqiGodMainView:_getScroll(goView, goCell)
	local scroll = self._scrollList[goView]

	if not scroll then
		scroll = ScrollerList.create(goView, goCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollList[goView] = scroll
	end

	return scroll
end

function AoqiGodMainView:_updateRewardCell(view, cell, data, tag)
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local matType, matId, matNum = MaterialMgr.getMatParams(data)

	MaterialMgr.setIcon(iconGo, matType, matId)

	txt.text = matNum
end

function AoqiGodMainView:_clearRewardCell(cell)
	local iconGo = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(iconGo)
end

function AoqiGodMainView:_updateHelpRewardCell(view, cell, data, tag)
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local matType, matId, matNum = MaterialMgr.getMatParams(data)

	MaterialMgr.setIcon(iconGo, matType, matId)

	txt.text = matNum
end

function AoqiGodMainView:_clearHelpRewardCell(cell)
	local iconGo = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(iconGo)
end

return AoqiGodMainView
