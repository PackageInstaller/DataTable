-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversaryKoimainView.lua

module("logic.extensions.anniversarykoi.view.AnniversaryKoimainView", package.seeall)

local AnniversaryKoimainView = class("AnniversaryKoimainView", ViewComponent)
local PrizeType = {
	SPECIAL_PRIZE = 2,
	PARTICIPATION = 3,
	BIG_PRIZE = 1
}

function AnniversaryKoimainView:ctor()
	AnniversaryKoimainView.super.ctor(self)
end

function AnniversaryKoimainView:unbindEvents()
	AnniversaryKoimainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnGetNumber)
end

function AnniversaryKoimainView:bindEvents()
	AnniversaryKoimainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnGetNumber, self._onClickNumber, self)

	local index = 1

	for i = 1, #self._playerCells do
		GameUtil.addClickHandler(self._playerCells[i].go, GameUtil.handler(self._onClickRank, self, index))

		index = index + 2
	end
end

function AnniversaryKoimainView:buildUI()
	AnniversaryKoimainView.super.buildUI(self)

	self._effect = self:getGo("effect")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._petCell = self:getGo("lottery/petCell")
	self._myPet = self:getGo("lottery/myPet")
	self._txtNormal = self:getTxt("lottery/txtNormal")
	self._txtKoi = self:getTxt("lottery/txtKoi")
	self._txtFail = self:getTxt("lottery/txtFail")
	self._lotteryAnim = self:getGo("lottery/lotteryAnim/anim")
	self._hasGet = self:getGo("lottery/lotteryAnim/hasGet")
	self._myNumberInfo = self:getGo("lottery/myNumberInfo/number")
	self._txtEmpty = self:getGo("lottery/myNumberInfo/empty")
	self._btnGetNumber = self:getBtn("lottery/btnGetNumber")
	self._rdNumber = self:getGo("lottery/btnGetNumber/redpoint")
	self._playerCells = {}

	for i = 1, 3 do
		local playerData = {}

		playerData.go = self:getGo("winners/player_" .. i)
		playerData.head = goutil.findChild(playerData.go, "head")
		playerData.area = goutil.findChild(playerData.go, "area")
		playerData.name = goutil.findChild(playerData.go, "name")
		playerData.txtArea = goutil.findChildTextComponent(playerData.go, "area/txtArea")
		playerData.txtName = goutil.findChildTextComponent(playerData.go, "name/txtName")
		playerData.empty = goutil.findChild(playerData.go, "empty")
		self._playerCells[i] = playerData
	end

	self._rdRecord = self:getGo("winners/btnRecord/redpoint")
	self._btnRecord = self:getBtn("winners/btnRecord")
	self._btnGoto = self:getBtn("winners/btnGoto")
end

function AnniversaryKoimainView:onExit()
	AnniversaryKoimainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryKoiGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryKoiLotteryRes, self._refreshMyNumber, self)
	RedPointController.instance:unregRedPoint(self._rdNumber)
	RedPointController.instance:unregRedPoint(self._rdRecord)
	removetimer(self._checkPetMoveState, self)
	removetimer(self._lotteryMask, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	if self._petMoves then
		for _, move in ipairs(self._petMoves) do
			move:stop()
			move:destroy()
		end
	end

	if self._myPets then
		for _, cell in ipairs(self._myPets) do
			MaterialMgr.resetAll(goutil.findChild(cell, "con"))
			goutil.destroy(cell, true)
		end
	end

	if self._effectList then
		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end

	if self._playerCells then
		for i = 1, #self._playerCells do
			HeadItemController:resetHeadCell(self._playerCells[i].head)
		end
	end
end

function AnniversaryKoimainView:onEnter()
	AnniversaryKoimainView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.AnniversaryKoi)

	GlobalDispatcher:addListener(GlobalNotify.AnniversaryKoiGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.AnniversaryKoiLotteryRes, self._refreshMyNumber, self)
	AnniversaryKoiController.instance:sendPM_AnniversaryKoiGetInfoReq(self._activityId)

	self._activityCfg = AnniversaryKoiConfig.instance:getKoiActivityCfgById(self._activityId)
	self._poolCfg = AnniversaryKoiConfig.instance:getKoiPoolCfg(self._activityId)
	self._petNumberCfg = AnniversaryKoiConfig.instance:getKoiPetNumberCfg(self._activityId)
	self._numberCount = self._poolCfg[1].numberCount
	self._koiNumber = AnniversaryKoiModel.instance:getKoiNumber() or {}
	self._myNumber = AnniversaryKoiModel.instance:getMyNumberInfo() or {}
	self._isInLotteryTime = AnniversaryKoiController.instance:timeState() ~= GameUtil.beforeTimePeriod
	self._petId = 5
	self._curProgress = 0
	self._curRoundNum = 1
	self._isLottery = false

	RedPointController.instance:regRedPoint(self._rdNumber, RedPointModel.ID_ANNIVERSARYKOI_NUMBER)
	RedPointController.instance:regRedPoint(self._rdRecord, RedPointModel.ID_ANNIVERSARYKOI_RECORD)
	AnniversaryKoiController.instance:setRdInfo()
	GameUtil.SetActive(self._petCell, false)
	GameUtil.SetActive(self._myPet, false)

	local effectPath = "20230331/zhounianjingli/fx_ui_zhounianjingli_fw.prefab"

	self:_playEffect(effectPath, self._effect, true)
	self:_setTimeUI()
	self:_lotteryDescTip()
	self:_setMyNumber()
	self:_winnerSetInfo()

	local state = AnniversaryKoiController.instance:timeState()

	self._popKey = "AnniversaryKoiresultView"
	self._animKey = "AnniversaryKoiAnimView"
end

function AnniversaryKoimainView:_refreshUI()
	self._myNumber = AnniversaryKoiModel.instance:getMyNumberInfo() or {}
	self._koiNumber = AnniversaryKoiModel.instance:getKoiNumber() or {}

	self:_setLotteryUIState()
	self:_lotteryDescTip()
	self:_setMyNumber()
	self:_winnerSetInfo()
end

function AnniversaryKoimainView:_setTimeUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AnniversaryKoi, self._activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function AnniversaryKoimainView:_playEffect(path, parent, loop)
	self._effectList = {}

	local effectPath = path
	local effect = UIEffectManager.instance:playEffect(self, effectPath, parent, 0, 0, loop, nil, nil, nil, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
	table.insert(self._effectList, effect)
end

function AnniversaryKoimainView:_refreshMyNumber()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ANNIVERSARYKOI_NUMBER, false)

	self._myNumber = AnniversaryKoiModel.instance:getMyNumber()

	self:_startLotteryAnim(false)
end

function AnniversaryKoimainView:_refreshLotteryResult()
	AnniversaryKoiModel.instance:setRecordLightRed(true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ANNIVERSARYKOI_RECORD, true)

	self._isLottery = true
	self._txtFail.text = "今日天选锦鲤开奖中！"

	GameUtil.SetActive(self._hasGet, false)
	self:_startLotteryAnim(true)
	GameUtil.saveUserDayData(self._animKey, true)
end

function AnniversaryKoimainView:_lotteryDescTip()
	local koiPlayers = AnniversaryKoiModel.instance:getPlayerList() or {}
	local isWinner = #koiPlayers > 0 and koiPlayers[1].headInfo.userId == RoleModel.instance:getUserId()

	if self._isInLotteryTime then
		if #self._koiNumber <= 0 then
			GameUtil.SetActive(self._txtNormal, true)
			GameUtil.SetActive(self._txtFail, false)
		else
			self._txtFail.text = "很遗憾，您未中奖，明日再来"

			GameUtil.SetActive(self._txtNormal, false)
			GameUtil.SetActive(self._txtFail, true)
		end
	end

	GameUtil.SetActive(self._txtNormal, not self._isInLotteryTime)
	GameUtil.SetActive(self._txtKoi, self._isInLotteryTime and isWinner)
	GameUtil.SetActive(self._txtFail, self._isInLotteryTime and not isWinner)
end

function AnniversaryKoimainView:_setLotteryUIState()
	GameUtil.SetActive(self._myNumberInfo, #self._myNumber > 0)

	if self._isInLotteryTime then
		GameUtil.SetActive(self._txtEmpty, #self._myNumber <= 0)
		GameUtil.SetActive(self._hasGet, #self._koiNumber <= 0)
		GameUtil.SetActive(self._btnGetNumber, false)

		if #self._koiNumber > 0 then
			self:_setPetCell()

			return
		end
	else
		GameUtil.SetActive(self._txtEmpty, false)
		GameUtil.SetActive(self._hasGet, #self._myNumber > 0)
		GameUtil.SetActive(self._btnGetNumber, #self._myNumber <= 0)

		if #self._myNumber <= 0 then
			self:_setPetCell()
		end
	end
end

function AnniversaryKoimainView:_setPetCell()
	self._animParms = {
		{
			posY = 200,
			posX = 60
		},
		{
			posY = 100,
			posX = 30
		},
		{
			posY = 0,
			posX = 0
		},
		{
			posY = -114,
			posX = -32
		},
		{
			posY = -228,
			posX = -64
		}
	}
	self._petMoves = {}

	for col = 1, self._numberCount do
		local parent = goutil.findChild(self._lotteryAnim, "pos_" .. col)
		local numMove = AnniversaryKoiNumMove.New(parent, self._animParms, self._petNumberCfg)

		numMove:init(self._petCell)
		table.insert(self._petMoves, numMove)
	end

	if not self._isInLotteryTime then
		return
	end

	if GameUtil.getUserDayData(self._animKey) then
		self:_setLotteryNumber()
	else
		self:_refreshLotteryResult()
	end
end

function AnniversaryKoimainView:_setLotteryNumber()
	if #self._koiNumber > 0 then
		for i = 1, #self._koiNumber do
			self._petMoves[i]:refrshNum(checknumber(self._koiNumber[i]))
		end
	end
end

function AnniversaryKoimainView:_startLotteryAnim(isBigPrize)
	local speed = self._activityCfg.speed
	local round = self._activityCfg.round

	if isBigPrize then
		if not self._koiNumber then
			local moveNumber = self._myNumber

			GameUtil.SetActive(self._myNumberInfo, true)
			GameUtil.SetActive(self._txtEmpty, #self._myNumber <= 0 and #self._koiNumber > 0)

			if #moveNumber > 0 then
				for i = 1, #moveNumber do
					self._petMoves[i]:setMoveParams(speed, round, checknumber(moveNumber[i]))

					if i == 1 then
						self._petMoves[i]:setSlown()
					end

					self._petMoves[i]:move()
				end

				settimer(speed, self._checkPetMoveState, self, true)
			end
		end
	end
end

function AnniversaryKoimainView:_checkPetMoveState()
	for i = 1, #self._petMoves do
		local isCurCellNumber = self._petMoves[i]:getStopState() and not self._petMoves[i]:getSetNumber()

		if isCurCellNumber and i <= #self._petMoves then
			if self._petMoves[i + 1] then
				self._petMoves[i + 1]:setSlown()
			end

			if not self._isLottery then
				self:_setMyNumberCell(i)
			else
				self:_endLotteryAnim(i)
			end

			self._petMoves[i]:setNumberOn()

			local parent = goutil.findChild(self._lotteryAnim, "pos_" .. i)
			local effectPath = "20230331/zhounianjingli/fx_ui_zhounianjingli_baokai.prefab"

			self:_playEffect(effectPath, parent, false)
		end
	end
end

function AnniversaryKoimainView:_endLotteryAnim(id)
	if id == self._numberCount then
		removetimer(self._checkPetMoveState, self)

		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end
end

function AnniversaryKoimainView:_setMyNumberCell(id)
	if id == self._numberCount then
		removetimer(self._checkPetMoveState, self)
		settimer(0.4, self._lotteryMask, self, false)
	end

	local pos = goutil.findChild(self._myNumberInfo, "pos_" .. id)
	local cell = goutil.cloneAndSetParent(self._myPet, pos.transform)

	GameUtil.setLocalPos(cell, 0, 0, 0)
	MaterialMgr.setIcon(goutil.findChild(cell, "con"), MatType.Pet, self._petNumberCfg[checknumber(self._myNumber[id])].raceId)
	GameUtil.SetActive(cell, true)
	table.insert(self._myPets, cell)
end

function AnniversaryKoimainView:_setMyNumber()
	self._myPets = {}

	if #self._myNumber > 0 then
		for id = 1, #self._myNumber do
			local pos = goutil.findChild(self._myNumberInfo, "pos_" .. id)
			local cell = goutil.cloneAndSetParent(self._myPet, pos.transform)

			GameUtil.setLocalPos(cell, 0, 0, 0)
			MaterialMgr.setIcon(goutil.findChild(cell, "con"), MatType.Pet, self._petNumberCfg[checknumber(self._myNumber[id])].raceId)
			GameUtil.SetActive(cell, true)
			table.insert(self._myPets, cell)
		end
	end
end

function AnniversaryKoimainView:_lotteryMask()
	GameUtil.SetActive(self._hasGet, true)
	GameUtil.SetActive(self._lotteryAnim, false)
	self:_lotteryDescTip()
	removetimer(self._lotteryMask, self)
end

function AnniversaryKoimainView:_LotteryPetNumber()
	AnniversaryKoiController.instance:sendPM_AnniversaryKoiLotteryReq(self._activityId, PrizeType.BIG_PRIZE)
end

function AnniversaryKoimainView:_onClickNumber()
	self:_LotteryPetNumber()
	GameUtil.SetActive(self._btnGetNumber, false)
end

function AnniversaryKoimainView:_winnerSetInfo()
	local playerList = AnniversaryKoiModel.instance:getPlayerList() or {}

	for i = 1, #self._playerCells do
		GameUtil.SetActive(self._playerCells[i].empty, not playerList[i] or not self._isInLotteryTime or #self._koiNumber <= 0)
		GameUtil.SetActive(self._playerCells[i].name, playerList[i] and self._isInLotteryTime and #self._koiNumber > 0)
		GameUtil.SetActive(self._playerCells[i].area, playerList[i] and self._isInLotteryTime and #self._koiNumber > 0)

		if playerList[i] and self._isInLotteryTime and #self._koiNumber > 0 and playerList[i].poolId == i then
			HeadItemController.instance:setHeadCellByInfo(self._playerCells[i].head, playerList[i].headInfo)

			self._playerCells[i].txtArea.text = playerList[i].headInfo.areaName
			self._playerCells[i].txtName.text = playerList[i].headInfo.userName
		end
	end
end

function AnniversaryKoimainView:_onClickTip()
	TipsFacade.instance:openRulesView("anniversarykoimainview")
end

function AnniversaryKoimainView:_onClickRank(index)
	UIStateManager.instance:push(ViewName.AnniversaryKoirankView, index)
end

function AnniversaryKoimainView:_onClickGoto()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function AnniversaryKoimainView:_onClickRecord()
	UIStateManager.instance:push(ViewName.AnniversaryKoirecordView)

	local isHasNewRecord = AnniversaryKoiModel.instance:getRecordLightRed()

	if isHasNewRecord then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_ANNIVERSARYKOI_RECORD, false)
		AnniversaryKoiModel.instance:setRecordLightRed(false)
	end
end

return AnniversaryKoimainView
